import pandas as pd
import numpy as np
import os

# 1. قراءة ملف البيانات الحقيقي الخاص بالمشروع
# تأكدي أن اسم الملف مطابق لملف الـ CSV الموجود في البروجكت
data_file = "CarPrice_Assignment.csv" 

if not os.path.exists(data_file):
    print(f"⚠️ تنبيه: يرجى وضع ملف البيانات '{data_file}' في نفس الفولدر مع هذا السكريبت.")
    # إنشاء داتا تجريبية بنفس الأعمدة الحقيقية للمشروع فقط لحمايتك من التوقف إذا لم يتوفر الملف فوراً
    demo_cols = ['car_ID', 'symboling', 'CarName', 'fueltype', 'aspiration', 'doornumber', 
                 'carbody', 'drivewheel', 'enginelocation', 'wheelbase', 'carlength', 
                 'carwidth', 'carheight', 'curbweight', 'enginetype', 'cylindernumber', 
                 'enginesize', 'fuelsystem', 'boreratio', 'stroke', 'compressionratio', 
                 'horsepower', 'peakrpm', 'citympg', 'highwaympg', 'price']
    df = pd.DataFrame(columns=demo_cols)
    # تعبئة سطر واحد وهمي لتجنب أخطاء التشغيل الأولي
    df.loc[0] = [1, 3, 'alfa-romero giulia', 'gas', 'std', 'two', 'convertible', 'rwd', 'front', 
                 88.6, 168.8, 64.1, 48.8, 2548, 'dohc', 'four', 130, 'mpfi', 3.47, 2.68, 9.0, 111, 5000, 21, 27, 13495.0]
else:
    df = pd.read_csv(data_file)
    print("✅ تم تحميل ملف بيانات السيارات الحقيقي بنجاح.")

# إنشاء فولدر لحفظ الجداول المستخرجة للـ Power BI
os.makedirs('powerbi_tables', exist_ok=True)

# -------------------------------------------------------------
# 2. تنظيف البيانات وفصل اسم الماركة (Car Brand) عن اسم الموديل
# -------------------------------------------------------------
if 'CarName' in df.columns:
    # استخراج الكلمة الأولى وهي الماركة (مثل: toyota, audi)
    df['Car_Brand'] = df['CarName'].apply(lambda x: str(x).split(' ')[0].lower())
    
    # تصحيح الأخطاء الإملائية الشائعة في هذا السيت الحقيقي للبيانات
    brand_corrections = {
        'maxda': 'mazda',
        'porcshz': 'porsche',
        'vokswagen': 'volkswagen',
        'vw': 'volkswagen',
        'toyouta': 'toyota'
    }
    df['Car_Brand'] = df['Car_Brand'].replace(brand_corrections)
else:
    df['Car_Brand'] = 'unknown'

print("✅ تم تنظيف أسماء ماركات السيارات وتصحيح الأخطاء الإملائية.")

# -------------------------------------------------------------
# 3. بناء جداum الأبعاد (Dimension Tables) - المتغيرات النوعية
# -------------------------------------------------------------

# أ) جدول مواصفات هيكل وماركة السيارة (DIM_CAR_CATALOG)
dim_car_catalog = df[['Car_Brand', 'carbody', 'drivewheel', 'enginelocation']].drop_duplicates().reset_index(drop=True)
dim_car_catalog['Catalog_ID'] = dim_car_catalog.index + 1

# ب) جدول نظام المحرك والوقود (DIM_ENGINE_SPECS)
dim_engine_specs = df[['fueltype', 'aspiration', 'enginetype', 'cylindernumber', 'fuelsystem']].drop_duplicates().reset_index(drop=True)
dim_engine_specs['Engine_SpecID'] = dim_engine_specs.index + 1

# ربط المعرفات (IDs) بالجدول الرئيسي قبل الفصل
df = df.merge(dim_car_catalog, on=['Car_Brand', 'carbody', 'drivewheel', 'enginelocation'])
df = df.merge(dim_engine_specs, on=['fueltype', 'aspiration', 'enginetype', 'cylindernumber', 'fuelsystem'])

print("✅ تم تجهيز جداول الأبعاد النوعية (Dimensions).")

# -------------------------------------------------------------
# 4. بناء جداول الحقائق (Fact Tables) - المتغيرات الكمية والأرقام
# -------------------------------------------------------------

# أ) جدول حقائق الأسعار والأبعاد الفنية (FACT_CAR_PRICING)
fact_car_pricing = df[[
    'car_ID', 'Catalog_ID', 'Engine_SpecID', 'symboling', 'doornumber',
    'wheelbase', 'carlength', 'carwidth', 'carheight', 'curbweight', 'price'
]]

# ب) جدول حقائق الأداء الميكانيكي واستهلاك الوقود (FACT_ENGINE_PERFORMANCE)
fact_engine_performance = df[[
    'car_ID', 'enginesize', 'boreratio', 'stroke', 'compressionratio',
    'horsepower', 'peakrpm', 'citympg', 'highwaympg'
]]

print("✅ تم تجهيز جداول الحقائق الكمية (Facts).")

# -------------------------------------------------------------
# 5. تصدير الجداول النهائية إلى ملفات CSV نظيفة تماماً للـ Power BI
# -------------------------------------------------------------
dim_car_catalog.to_csv('powerbi_tables/dim_car_catalog.csv', index=False)
dim_engine_specs.to_csv('powerbi_tables/dim_engine_specs.csv', index=False)
fact_car_pricing.to_csv('powerbi_tables/fact_car_pricing.csv', index=False)
fact_engine_performance.to_csv('powerbi_tables/fact_engine_performance.csv', index=False)

print("\n🚀 كودك جاهز بالملي ومطابق للبروجكت!")
print("تجدين الجداول الـ 4 داخل فولدر 'powerbi_tables' جاهزة للربط الفوري في Power BI وتحليل تأثير المتغيرات على السعر.")
