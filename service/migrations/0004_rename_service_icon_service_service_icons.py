# Generated by Django 5.0.7 on 2024-07-31 13:11

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('service', '0003_billinfo_paymentrecords'),
    ]

    operations = [
        migrations.RenameField(
            model_name='service',
            old_name='service_icon',
            new_name='service_icons',
        ),
    ]
