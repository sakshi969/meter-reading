from django.db import models
from django.contrib.auth.models import User

class Charts(models.Model):
    user_id = models.CharField(max_length=15)
    meter_reading = models.DecimalField(max_digits=10, decimal_places=2)
    entry_date = models.DateField()
    yyyymm = models.CharField(max_length=6)
    units_delta = models.DecimalField(max_digits=10, decimal_places=2)
    units_cumulative = models.DecimalField(max_digits=10, decimal_places=2)

    def __str__(self):
        return f"User {self.user.id} - Meter Reading {self.id} - {self.yyyymm}"
