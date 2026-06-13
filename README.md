# 1. تحميل المكتبات وقراءة ملف البيانات الحقيقي
library(tidyverse)

data_file <- "CarPrice_Assignment.csv"

if (!file.exists(data_file)) {
  stop("⚠️ تنبيه: يرجى وضع ملف البيانات 'CarPrice_Assignment.csv' في نفس الفولدر!")
}

df <- read_csv(data_file)

# إنشاء الفولدر لحفظ جداول الـ Power BI
dir.create("powerbi_tables", showWarnings = FALSE)

# 2. تنظيف أسماء الماركات وتصحيح الأخطاء الإملائية
df <- df %>%
  mutate(Car_Brand = str_to_lower(str_split_fixed(CarName, " ", 2)[,1])) %>%
  mutate(Car_Brand = recode(Car_Brand, 
                            "maxda" = "mazda",
                            "porcshz" = "porsche",
                            "vokswagen" = "volkswagen",
                            "vw" = "volkswagen",
                            "toyouta" = "toyota"))

# 3. بناء جداول الأبعاد (Dimension Tables)
dim_car_catalog <- df %>%
  select(Car_Brand, carbody, drivewheel, enginelocation) %>%
  distinct() %>%
  mutate(Catalog_ID = row_number())

dim_engine_specs <- df %>%
  select(fueltype, aspiration, enginetype, cylindernumber, fuelsystem) %>%
  distinct() %>%
  mutate(Engine_SpecID = row_number())

# ربط المعرفات بالجدول الرئيسي
df <- df %>%
  inner_join(dim_car_catalog, by = c("Car_Brand", "carbody", "drivewheel", "enginelocation")) %>%
  inner_join(dim_engine_specs, by = c("fueltype", "aspiration", "enginetype", "cylindernumber", "fuelsystem"))

# 4. بناء جداول الحقائق (Fact Tables)
fact_car_pricing <- df %>%
  select(car_ID, Catalog_ID, Engine_SpecID, symboling, doornumber, wheelbase, carlength, carwidth, carheight, curbweight, price)

fact_engine_performance <- df %>%
  select(car_ID, enginesize, boreratio, stroke, compressionratio, horsepower, peakrpm, citympg, highwaympg)

# 5. تصدير الجداول النهائية إلى ملفات CSV للـ Power BI
write_csv(dim_car_catalog, "powerbi_tables/dim_car_catalog.csv")
write_csv(dim_engine_specs, "powerbi_tables/dim_engine_specs.csv")
write_csv(fact_car_pricing, "powerbi_tables/fact_car_pricing.csv")
write_csv(fact_engine_performance, "powerbi_tables/fact_engine_performance.csv")

print("🚀 تم استخراج الجداول الـ 4 بنجاح داخل فولدر 'powerbi_tables' جاهزة للـ Power BI!")
