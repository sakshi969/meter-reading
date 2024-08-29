from django.shortcuts import render
from .models import Charts
import json
from decimal import Decimal
from collections import defaultdict
from datetime import datetime

def charts(request):
    charts_entries = Charts.objects.all()

    registrations_per_month = defaultdict(int)
    total_consumption_per_month = defaultdict(Decimal)

    total_users = charts_entries.count()
    registered_users = 0 

    for entry in charts_entries:
        if entry.yyyymm == "YYYYMM":
            month_name = entry.yyyymm
        else:
            yyyymm_date = datetime.strptime(str(entry.yyyymm), '%Y%m')
            month_name = yyyymm_date.strftime('%b %Y')

        registrations_per_month[month_name] += 1
        total_consumption_per_month[month_name] += entry.units_cumulative
        registered_users += 1

    unregistered_users = total_users - registered_users

    applied_labels = ['Registered', 'Unregistered']
    applied_data = [registered_users, unregistered_users]

    registration_labels = list(registrations_per_month.keys())
    registration_data = list(registrations_per_month.values())

    avg_consumption_labels = list(total_consumption_per_month.keys())
    avg_consumption_data = [
        float(total_consumption_per_month[month] / registrations_per_month[month])
        for month in avg_consumption_labels
    ]

    context = {
        'registration_labels': json.dumps(registration_labels),
        'registration_data': json.dumps(registration_data),
        'avg_consumption_labels': json.dumps(avg_consumption_labels),
        'avg_consumption_data': json.dumps(avg_consumption_data),
        'applied_labels': json.dumps(applied_labels),
        'applied_data': json.dumps(applied_data),
    }

    return render(request, "charts.html", context)

def user_detail_view(request):
    user_id = request.GET.get('user_id', '')

    if not user_id:
        return render(request, "user_analysis.html", {'error': 'User ID is required.'})

    user_entries = Charts.objects.filter(user_id=user_id).order_by('yyyymm')
    if not user_entries.exists():
        return render(request, "user_analysis.html", {'error': 'No data found for this user.'})

    consumption_data = defaultdict(Decimal)
    cumulative_data = defaultdict(Decimal)
    months = []

    for entry in user_entries:
        yyyymm_date = datetime.strptime(str(entry.yyyymm), '%Y%m')
        month_name = yyyymm_date.strftime('%b %Y')
        months.append(month_name)
        consumption_data[month_name] += entry.units_delta
        cumulative_data[month_name] += entry.units_cumulative

    min_max_diff = []
    max_deviation = 0 
    max_deviation_label = ""  


    if len(months) > 1:
        for i in range(len(months) - 1):
            month1 = months[i]
            month2 = months[i + 1]
            diff = consumption_data[month2] - consumption_data[month1]
            min_max_diff.append(diff)
            
            

            if abs(diff) > abs(max_deviation):
                max_deviation = diff
                max_deviation_label = f"{month1} to {month2}"

        min_diff = float(min(min_max_diff))
        max_diff = float(max(min_max_diff))
        diff_labels = [f"{months[i]} to {months[i+1]}" for i in range(len(months) - 1)]
        diff_data = [float(diff) for diff in min_max_diff]
    else:
        min_diff = max_diff = 0
        diff_labels = []
        diff_data = []
    print(max(min_max_diff))
    labels = list(consumption_data.keys())
    data = [float(value) for value in consumption_data.values()]

    cumulative_labels = list(cumulative_data.keys())
    cumulative_data_list = [float(value) for value in cumulative_data.values()]

    avg_consumption = sum(data) / len(data) if data else 0

    context = {
        'user_id': user_id,
        'labels': json.dumps(labels),
        'data': json.dumps(data),
        'cumulative_labels': json.dumps(cumulative_labels),
        'cumulative_data': json.dumps(cumulative_data_list),
        'min_diff': json.dumps(float(min_diff)),
        'max_diff': json.dumps(float(max_diff)),
        'avg_consumption': avg_consumption,
        'diff_labels': json.dumps(diff_labels),
        'diff_data': json.dumps(diff_data),
        'max_deviation': json.dumps(float(max_deviation)),  
        'max_deviation_label': max_deviation_label,  
    }

    return render(request, "user_analysis.html", context)
