churn <- read.csv("~/Desktop/WA_Fn-UseC_-Telco-Customer-Churn.csv")
dim(churn)
str(churn)
factor_cols <- c(
  "gender",
  "Partner",
  "Dependents",
  "PhoneService",
  "MultipleLines",
  "InternetService",
  "OnlineSecurity",
  "OnlineBackup",
  "DeviceProtection",
  "TechSupport",
  "StreamingTV",
  "StreamingMovies",
  "Contract",
  "PaperlessBilling",
  "PaymentMethod",
  "Churn"
)

churn[factor_cols] <- lapply(
  churn[factor_cols],
  as.factor
)
str(churn)
table(churn$Churn)
prop.table(table(churn$Churn))

library(ggplot2)

ggplot(churn, aes(x = Churn)) +
  geom_bar(fill = "steelblue") +
  labs(
    title = "Distribution of Customer Churn",
    x = "Churn Status",
    y = "Number of Customers"
  )

ggplot(churn, aes(x = Contract, fill = Churn)) +
  geom_bar(position = "fill") +
  scale_fill_manual(
    values = c(
      "No" = "#4CAF50",
      "Yes" = "#E74C3C"
    )
  ) +
  labs(
    title = "Churn Rate by Contract Type",
    x = "Contract Type",
    y = "Proportion of Customers",
    fill = "Churn Status"
  )
ggplot(churn, aes(x = PaymentMethod, fill = Churn)) +
  geom_bar(position = "fill") +
  scale_fill_manual(
    values = c(
      "No" = "#4CAF50",
      "Yes" = "#E74C3C"
    )
  ) +
  labs(
    title = "Churn Rate by Payment Method",
    x = "Payment Method",
    y = "Proportion of Customers",
    fill = "Churn Status"
  ) +
  theme(
    axis.text.x = element_text(
      angle = 45,
      hjust = 1
    )
  )
ggplot(churn, aes(x = InternetService, fill = Churn)) +
  geom_bar(position = "fill") +
  scale_fill_manual(
    values = c(
      "No" = "#4CAF50",
      "Yes" = "#E74C3C"
    )
  ) +
  labs(
    title = "Churn Rate by Internet Service",
    x = "Internet Service",
    y = "Proportion of Customers",
    fill = "Churn Status"
  )

ggplot(churn, aes(x = Churn, y = MonthlyCharges, fill = Churn)) +
  geom_boxplot() +
  labs(
    title = "Monthly Charges by Churn Status",
    x = "Churn Status",
    y = "Monthly Charges"
  )
ggplot(churn, aes(x = Churn, y = tenure, fill = Churn)) +
  geom_boxplot() +
  labs(
    title = "Customer Tenure by Churn Status",
    x = "Churn Status",
    y = "Tenure (Months)"
  )
set.seed(123)

index <- sample(
  1:nrow(churn),
  0.7 * nrow(churn)
)

train <- churn[index, ]
test <- churn[-index, ]
dim(train)
dim(test)
churn_model <- glm(
  Churn ~ .
  data = train,
  family = "binomial"
)
summary(churn_model)

churn_model <- glm(
  Churn ~ .,
  data = train,
  family = "binomial"
)

churn_model <- glm(
  Churn ~ .,
  data = train,
  family = "binomial"
)

churn_model <- glm(
  Churn ~ .,
  data = train,
  family = "binomial"
)
summary(churn_model)
rm(churn_model)

churn_model <- glm(
  Churn ~ .,
  data = train,
  family = "binomial"
)

train2 <- train[, !(names(train) %in% "customerID")]
test2 <- test[, !(names(test) %in% "customerID")]
names(train2)
churn_model <- glm(
  Churn ~ .,
  data = train2,
  family = "binomial"
)
summary(churn_model)

pred_prob <- predict(
  churn_model,
  newdata = test2,
  type = "response"
)
head(pred_prob)
pred_prob <- predict(
  churn_model,
  newdata = test2,
  type = "response"
)

head(pred_prob)
pred_class <- ifelse(
  pred_prob > 0.5,
  "Yes",
  "No"
)
head(pred_class)
pred_class <- ifelse(
  pred_prob > 0.5,
  "Yes",
  "No"
)

head(pred_class)
table(
  Actual = test2$Churn,
  Predicted = pred_class
)
accuracy <- sum(pred_class == test2$Churn, na.rm = TRUE) /
  sum(!is.na(test2$Churn))

accuracy
conf_matrix <- table(
  Actual = test2$Churn,
  Predicted = pred_class
)

conf_matrix

accuracy <- sum(diag(conf_matrix)) / sum(conf_matrix)

accuracy

precision <- conf_matrix["Yes", "Yes"] /
  (conf_matrix["No", "Yes"] + conf_matrix["Yes", "Yes"])

precision
recall <- conf_matrix["Yes", "Yes"] /
  (conf_matrix["Yes", "No"] +
     conf_matrix["Yes", "Yes"])

recall
f1_score <- 2 * ((precision * recall) / (precision + recall))

f1_score

