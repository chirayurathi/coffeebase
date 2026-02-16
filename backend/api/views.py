from rest_framework import viewsets, permissions, status
from rest_framework.decorators import action
from allauth.socialaccount.providers.google.views import GoogleOAuth2Adapter
from allauth.socialaccount.providers.oauth2.client import OAuth2Client
from dj_rest_auth.registration.views import SocialLoginView
from rest_framework.response import Response
from django.shortcuts import get_object_or_404
from .models import Bean, Equipment, Recipe, RecipeStep, Post, Comment, Like, Follow, TastingNote
from .serializers import (
    BeanSerializer, EquipmentSerializer, RecipeSerializer,
    RecipeStepSerializer, PostSerializer, CommentSerializer,
    FollowSerializer, TastingNoteSerializer
)

class GoogleLogin(SocialLoginView):
    adapter_class = GoogleOAuth2Adapter
    callback_url = "http://localhost:8000/api/auth/google/callback/"
    client_class = OAuth2Client

class BeanViewSet(viewsets.ModelViewSet):
    queryset = Bean.objects.all()
    serializer_class = BeanSerializer
    permission_classes = [permissions.IsAuthenticatedOrReadOnly]

class EquipmentViewSet(viewsets.ModelViewSet):
    serializer_class = EquipmentSerializer
    permission_classes = [permissions.IsAuthenticated]

    def get_queryset(self):
        return Equipment.objects.filter(user=self.request.user)

    def perform_create(self, serializer):
        serializer.save(user=self.request.user)

class RecipeViewSet(viewsets.ModelViewSet):
    queryset = Recipe.objects.all()
    serializer_class = RecipeSerializer
    permission_classes = [permissions.IsAuthenticatedOrReadOnly]

    def perform_create(self, serializer):
        serializer.save(user=self.request.user)

    @action(detail=True, methods=['post'])
    def add_step(self, request, pk=None):
        recipe = self.get_object_or_404(pk=pk)
        serializer = RecipeStepSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save(recipe=recipe)
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class PostViewSet(viewsets.ModelViewSet):
    queryset = Post.objects.all().order_by('-created_at')
    serializer_class = PostSerializer
    permission_classes = [permissions.IsAuthenticatedOrReadOnly]

    def perform_create(self, serializer):
        serializer.save(user=self.request.user)

    @action(detail=True, methods=['post'])
    def like(self, request, pk=None):
        post = self.get_object_or_404(pk=pk)
        like, created = Like.objects.get_or_create(user=request.user, post=post)
        if not created:
            like.delete()
            return Response({'status': 'unliked'})
        return Response({'status': 'liked'})

    @action(detail=True, methods=['post'])
    def comment(self, request, pk=None):
        post = self.get_object_or_404(pk=pk)
        serializer = CommentSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save(user=request.user, post=post)
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class FollowViewSet(viewsets.ModelViewSet):
    serializer_class = FollowSerializer
    permission_classes = [permissions.IsAuthenticated]

    def get_queryset(self):
        return Follow.objects.filter(follower=self.request.user)

    @action(detail=False, methods=['post'])
    def follow_user(self, request):
        user_id = request.data.get('user_id')
        user_to_follow = get_object_or_404(User, id=user_id)
        follow, created = Follow.objects.get_or_create(user=user_to_follow, follower=request.user)
        if not created:
            follow.delete()
            return Response({'status': 'unfollowed'})
        return Response({'status': 'followed'})
