Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2C62783F9
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 11:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727915AbgIYJ2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 05:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727428AbgIYJ2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 05:28:36 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA07CC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 02:28:35 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id b79so2492148wmb.4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 02:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ILQ/IiRKb55ppcaOHIyXL34tMQjZIAgy+EvIz2zBiIc=;
        b=OKYztN3emZinZ60HG3Zaxg3pQkZM8kA1HxlbgRE5GQfuunViHAro6Z7Qm7QWUpGb6y
         8FF9VP4qNwZX4xi5uZzhr9ICXax2MvYohnmW6VlX0fDh45tB3Es2HX90yyDhbot9OFqn
         THbBv0tAzRvY/Swx6ic81ssAWbq1RPN9CVlU+M0W34WFFeUarHZMP0rXSurdxalCafWM
         KB2aG2JXbflkzuZyHocZjXNdvL0m5IyAZgynvGms0+w18tMFN2sKtXOjm6PmgN/TmnzW
         qOYe48Jp2GKuPReXYIQcpeJw9f2tMh8uj5CnNf02nDlAgkkOwTfthpPnu7p9YUerFbP2
         BMsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ILQ/IiRKb55ppcaOHIyXL34tMQjZIAgy+EvIz2zBiIc=;
        b=b/Jv/T8IV1haiA72ThL6avDXdv8oRZV+e8yWDnYT9SFqxq/Z5WcwrcK0zEl5gb5oDX
         k53U5izEhqH4tOM5tvn7wapUUbLFO16QzZu4hwb9iUwVzmJJoGcos1IbvNeV7QRPcPHG
         qMpaEzOt3Cf4KJvs8fHTEo3fgVG6Fgsh/kszkLGCWdNNDBqJDE5JiXkRamijBDQdqUwB
         6cuLNR5ARdVUkrAXxWiqvSgAJOIwbC6U17DqNNiwoYhl02/DwyQU4hCfSkoEnRUHJgB+
         AKp6fqqgHJkvs82RmQAcJMKX5gPC4n0gMWEXG4BZK82DZaTdHAnKD7zWbnn2vM1zTHoP
         E72g==
X-Gm-Message-State: AOAM533qd9TF0iEUDbBWmkYe8eh3SixASfBBKPcuAmTmCA+RTsnIDLNj
        pKkPPQc8wI3mz+hylLjvoNQhnA==
X-Google-Smtp-Source: ABdhPJx34N2upgwLQ/YFcj2NxUHH/0r1UvLTJ42+7TN6qcD2mAk2/oh9pZZvU4i1CGwxzOHzGSF/mw==
X-Received: by 2002:a1c:5988:: with SMTP id n130mr2174411wmb.95.1601026114341;
        Fri, 25 Sep 2020 02:28:34 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id n2sm2366859wma.29.2020.09.25.02.28.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 02:28:33 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, srivasam@codeaurora.org,
        rohitkr@codeaurora.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/2] regmap: add support to regmap_field_bulk_alloc/free apis
Date:   Fri, 25 Sep 2020 10:28:03 +0100
Message-Id: <20200925092804.23536-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200925092804.23536-1-srinivas.kandagatla@linaro.org>
References: <20200925092804.23536-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Usage of regmap_field_alloc becomes much overhead when number of fields
exceed more than 3.
QCOM LPASS driver has extensively converted to use regmap_fileds.

Using new bluk api to allocate fields makes it much more cleaner code to read!

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Tested-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
---
 drivers/base/regmap/regmap.c | 100 +++++++++++++++++++++++++++++++++++
 include/linux/regmap.h       |  11 ++++
 2 files changed, 111 insertions(+)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index aec3f26bf711..271740a163ad 100644
--- a/drivers/base/regmap/regmap.c
+++ b/drivers/base/regmap/regmap.c
@@ -1270,6 +1270,106 @@ struct regmap_field *devm_regmap_field_alloc(struct device *dev,
 }
 EXPORT_SYMBOL_GPL(devm_regmap_field_alloc);
 
+
+/**
+ * regmap_field_bulk_alloc() - Allocate and initialise a bulk register field.
+ *
+ * @regmap: regmap bank in which this register field is located.
+ * @rm_field: regmap register fileds with in the bank.
+ * @reg_field: Register fields with in the bank.
+ * @num_fields: Number of register fileds.
+ *
+ * The return value will be an -ENOMEM on error or zero for success.
+ * Newly allocated regmap_fields should be freed by calling
+ * regmap_field_bulk_free()
+ */
+int regmap_field_bulk_alloc(struct regmap *regmap,
+			    struct regmap_field **rm_field,
+			    struct reg_field *reg_field,
+			    int num_fields)
+{
+	struct regmap_field *rf;
+	int i;
+
+	rf = kcalloc(num_fields, sizeof(*rf), GFP_KERNEL);
+	if (!rf)
+		return -ENOMEM;
+
+	for (i = 0; i < num_fields; i++) {
+		regmap_field_init(&rf[i], regmap, reg_field[i]);
+		rm_field[i] = &rf[i];
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(regmap_field_bulk_alloc);
+
+/**
+ * devm_regmap_field_bulk_alloc() - Allocate and initialise a bulk register
+ * fields.
+ *
+ * @dev: Device that will be interacted with
+ * @regmap: regmap bank in which this register field is located.
+ * @rm_field: regmap register fileds with in the bank.
+ * @reg_field: Register fields with in the bank.
+ * @num_fields: Number of register fileds.
+ *
+ * The return value will be an -ENOMEM on error or zero for success.
+ * Newly allocated regmap_fields will be automatically freed by the
+ * device management code.
+ */
+int devm_regmap_field_bulk_alloc(struct device *dev,
+				 struct regmap *regmap,
+				 struct regmap_field **rm_field,
+				 struct reg_field *reg_field,
+				 int num_fields)
+{
+	struct regmap_field *rf;
+	int i;
+
+	rf = devm_kcalloc(dev, num_fields, sizeof(*rf), GFP_KERNEL);
+	if (!rf)
+		return -ENOMEM;
+
+	for (i = 0; i < num_fields; i++) {
+		regmap_field_init(&rf[i], regmap, reg_field[i]);
+		rm_field[i] = &rf[i];
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(devm_regmap_field_bulk_alloc);
+
+/**
+ * regmap_field_bulk_free() - Free register field allocated using
+ *                       regmap_field_bulk_alloc.
+ *
+ * @field: regmap fields which should be freed.
+ */
+void regmap_field_bulk_free(struct regmap_field *field)
+{
+	kfree(field);
+}
+EXPORT_SYMBOL_GPL(regmap_field_bulk_free);
+
+/**
+ * devm_regmap_field_bulk_free() - Free a bulk register field allocated using
+ *                            devm_regmap_field_bulk_alloc.
+ *
+ * @dev: Device that will be interacted with
+ * @field: regmap field which should be freed.
+ *
+ * Free register field allocated using devm_regmap_field_bulk_alloc(). Usually
+ * drivers need not call this function, as the memory allocated via devm
+ * will be freed as per device-driver life-cyle.
+ */
+void devm_regmap_field_bulk_free(struct device *dev,
+				 struct regmap_field *field)
+{
+	devm_kfree(dev, field);
+}
+EXPORT_SYMBOL_GPL(devm_regmap_field_bulk_free);
+
 /**
  * devm_regmap_field_free() - Free a register field allocated using
  *                            devm_regmap_field_alloc.
diff --git a/include/linux/regmap.h b/include/linux/regmap.h
index 0c49d59168b5..a35ec0a0d6e0 100644
--- a/include/linux/regmap.h
+++ b/include/linux/regmap.h
@@ -1189,6 +1189,17 @@ struct regmap_field *devm_regmap_field_alloc(struct device *dev,
 		struct regmap *regmap, struct reg_field reg_field);
 void devm_regmap_field_free(struct device *dev,	struct regmap_field *field);
 
+int regmap_field_bulk_alloc(struct regmap *regmap,
+			     struct regmap_field **rm_field,
+			     struct reg_field *reg_field,
+			     int num_fields);
+void regmap_field_bulk_free(struct regmap_field *field);
+int devm_regmap_field_bulk_alloc(struct device *dev, struct regmap *regmap,
+				 struct regmap_field **field,
+				 struct reg_field *reg_field, int num_fields);
+void devm_regmap_field_bulk_free(struct device *dev,
+				 struct regmap_field *field);
+
 int regmap_field_read(struct regmap_field *field, unsigned int *val);
 int regmap_field_update_bits_base(struct regmap_field *field,
 				  unsigned int mask, unsigned int val,
-- 
2.21.0

