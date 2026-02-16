from rest_framework import serializers
from django.contrib.auth.models import User
from .models import Bean, Equipment, Recipe, RecipeStep, Post, Comment, Like, Follow, TastingNote

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['id', 'username', 'email']

class BeanSerializer(serializers.ModelSerializer):
    class Meta:
        model = Bean
        fields = '__all__'

class EquipmentSerializer(serializers.ModelSerializer):
    class Meta:
        model = Equipment
        fields = '__all__'

class RecipeStepSerializer(serializers.ModelSerializer):
    class Meta:
        model = RecipeStep
        fields = '__all__'

class TastingNoteSerializer(serializers.ModelSerializer):
    class Meta:
        model = TastingNote
        fields = '__all__'

class RecipeSerializer(serializers.ModelSerializer):
    steps = RecipeStepSerializer(many=True, read_only=True)
    tasting_notes = TastingNoteSerializer(many=True, read_only=True)
    user = UserSerializer(read_only=True)

    class Meta:
        model = Recipe
        fields = '__all__'

class CommentSerializer(serializers.ModelSerializer):
    user = UserSerializer(read_only=True)
    class Meta:
        model = Comment
        fields = '__all__'

class PostSerializer(serializers.ModelSerializer):
    user = UserSerializer(read_only=True)
    comments = CommentSerializer(many=True, read_only=True)
    likes_count = serializers.SerializerMethodField()
    is_liked = serializers.SerializerMethodField()

    class Meta:
        model = Post
        fields = '__all__'

    def get_likes_count(self, obj):
        return obj.likes.count()

    def get_is_liked(self, obj):
        user = self.context.get('request').user
        if user.is_authenticated:
            return obj.likes.filter(user=user).exists()
        return False

class FollowSerializer(serializers.ModelSerializer):
    class Meta:
        model = Follow
        fields = '__all__'
