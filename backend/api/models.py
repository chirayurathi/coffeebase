from django.db import models
from django.contrib.auth.models import User

class Bean(models.Model):
    ROAST_LEVELS = [
        ('LIGHT', 'Light'),
        ('MEDIUM', 'Medium'),
        ('DARK', 'Dark'),
    ]
    name = models.CharField(max_length=255)
    roastery = models.CharField(max_length=255)
    origin = models.CharField(max_length=255)
    roast_level = models.CharField(max_length=10, choices=ROAST_LEVELS)
    process = models.CharField(max_length=100) # e.g. Washed, Natural
    notes = models.TextField(blank=True)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.name} - {self.roastery}"

class Equipment(models.Model):
    TYPES = [
        ('GRINDER', 'Grinder'),
        ('KETTLE', 'Kettle'),
        ('SCALE', 'Scale'),
        ('BREWER', 'Brewer'),
    ]
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    name = models.CharField(max_length=255)
    type = models.CharField(max_length=20, choices=TYPES)

    def __str__(self):
        return self.name

class Recipe(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    bean = models.ForeignKey(Bean, on_delete=models.CASCADE)
    method = models.CharField(max_length=100) # e.g. V60, Aeropress
    grind_size = models.CharField(max_length=100)
    water_temp = models.DecimalField(max_digits=5, decimal_places=2)
    coffee_weight = models.DecimalField(max_digits=5, decimal_places=2)
    water_weight = models.DecimalField(max_digits=5, decimal_places=2)
    description = models.TextField(blank=True)
    is_public = models.BooleanField(default=True)
    # Pro mode fields
    tds = models.DecimalField(max_digits=4, decimal_places=2, null=True, blank=True)
    extraction_yield = models.DecimalField(max_digits=4, decimal_places=2, null=True, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)

    def __str__(self):
        return f"{self.method} by {self.user.username}"

class RecipeStep(models.Model):
    recipe = models.ForeignKey(Recipe, related_name='steps', on_delete=models.CASCADE)
    order = models.PositiveIntegerField()
    title = models.CharField(max_length=255)
    description = models.TextField()
    duration_seconds = models.PositiveIntegerField()

    class Meta:
        ordering = ['order']

class Post(models.Model):
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    image = models.ImageField(upload_to='posts/images/', null=True, blank=True)
    video = models.FileField(upload_to='posts/videos/', null=True, blank=True)
    caption = models.TextField()
    recipe = models.ForeignKey(Recipe, on_delete=models.SET_NULL, null=True, blank=True)
    created_at = models.DateTimeField(auto_now_add=True)

class Comment(models.Model):
    post = models.ForeignKey(Post, related_name='comments', on_delete=models.CASCADE)
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    content = models.TextField()
    created_at = models.DateTimeField(auto_now_add=True)

class Like(models.Model):
    post = models.ForeignKey(Post, related_name='likes', on_delete=models.CASCADE)
    user = models.ForeignKey(User, on_delete=models.CASCADE)
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        unique_together = ('post', 'user')

class Follow(models.Model):
    user = models.ForeignKey(User, related_name='followers', on_delete=models.CASCADE)
    follower = models.ForeignKey(User, related_name='following', on_delete=models.CASCADE)
    created_at = models.DateTimeField(auto_now_add=True)

    class Meta:
        unique_together = ('user', 'follower')

class TastingNote(models.Model):
    recipe = models.ForeignKey(Recipe, related_name='tasting_notes', on_delete=models.CASCADE)
    flavor = models.CharField(max_length=100)
    intensity = models.PositiveIntegerField() # 1-5
