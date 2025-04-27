# Используем официальный образ Maven с Java 21
FROM maven:3.9.8-eclipse-temurin-21 AS build

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем pom.xml и исходный код
COPY pom.xml .
COPY src ./src

# Собираем проект
RUN mvn clean package -DskipTests

# Используем официальный образ OpenJDK 21 для запуска приложения
FROM eclipse-temurin:21

# Устанавливаем рабочую директорию
WORKDIR /app

# Копируем собранный JAR-файл
COPY --from=build /app/target/*.jar app.jar

# Открываем порт 
EXPOSE 5001

# Запускаем приложение
CMD ["java", "-jar", "app.jar"]