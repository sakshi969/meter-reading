from rest_framework import serializers
from .models import  Charts

class  ChartsSerializer(serializers.ModelSerializer):
    class Meta:
        model =  Charts
        fields = ['user_id', 'meter_reading', 'entry_date', 'yyyymm', 'units_delta', 'units_cumulative']
