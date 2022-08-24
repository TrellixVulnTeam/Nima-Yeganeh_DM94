# Generated by Django 3.2.6 on 2022-03-05 07:29

from django.conf import settings
from django.db import migrations, models
import django.db.models.deletion


class Migration(migrations.Migration):

    initial = True

    dependencies = [
        migrations.swappable_dependency(settings.AUTH_USER_MODEL),
    ]

    operations = [
        migrations.CreateModel(
            name='Log',
            fields=[
                ('id', models.BigAutoField(auto_created=True, primary_key=True, serialize=False, verbose_name='ID')),
                ('namespace', models.CharField(max_length=30)),
                ('log_type', models.CharField(blank=True, max_length=30)),
                ('mode', models.CharField(max_length=15)),
                ('var1', models.CharField(blank=True, max_length=100)),
                ('var2', models.TextField(blank=True, null=True)),
                ('created_at', models.DateTimeField(auto_now_add=True)),
                ('user_ip', models.CharField(blank=True, max_length=15)),
                ('user_id', models.ForeignKey(null=True, on_delete=django.db.models.deletion.PROTECT, to=settings.AUTH_USER_MODEL)),
            ],
        ),
    ]
