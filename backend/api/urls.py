from django.urls import path, include
from rest_framework.routers import DefaultRouter
from .views import BeanViewSet, EquipmentViewSet, RecipeViewSet, PostViewSet, FollowViewSet, GoogleLogin

router = DefaultRouter()
router.register(r'beans', BeanViewSet)
router.register(r'equipment', EquipmentViewSet, basename='equipment')
router.register(r'recipes', RecipeViewSet)
router.register(r'posts', PostViewSet)
router.register(r'follows', FollowViewSet, basename='follows')

urlpatterns = [
    path('', include(router.urls)),
    path('auth/google/', GoogleLogin.as_view(), name='google_login'),
]
