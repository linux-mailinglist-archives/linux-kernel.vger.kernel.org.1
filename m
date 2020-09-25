Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DF69278F07
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 18:49:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729454AbgIYQtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 12:49:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726368AbgIYQtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 12:49:08 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C81AC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 09:49:08 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z1so4351660wrt.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 09:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Ssju2WyDh5j0zn3FxJ2qEeLRsDGQouz5zG8/DyJr+lg=;
        b=Dzn6BomXQuuqwu3kVz3HW4HYjLiPHh1aPVbOzCQ5eMeP17ZUB7G+mzMUI5Q9/d8H5h
         uBKJ6Q+5/bBdz+OoxUXwamCFnPFrwgu4ad9ZSx1CFgy1kCNCfj3JY3LXk2R0RrHzuMeM
         lWHk+++DMbaDyqNL4vUFDw3KsCxvWyZ+kU81EnEsZXaYKYWMl8xhhz00oJm5KlfM2qtO
         eY5NQXnlfPXmTCa70WJEzQbEbwOG37iF8tvkXOqITxcGKdr7+4df9D7ic8UUvbSbtCB4
         1uWCnXgyAjn3x0rqBPdQ7BQZQsq8xDT5RNpC6/ggkU8bxnOpCTKSbtHe4X3esZfbjWpH
         DfxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ssju2WyDh5j0zn3FxJ2qEeLRsDGQouz5zG8/DyJr+lg=;
        b=R9ufI0hoNkVW961sWkv9RKlM+KLEF9dJMKFe/Xccna84bVznAJZuyFyOLvzx47YKZf
         nnSV8uqOk4RkG9HP10eHiikUQx97BHvgr3Wvqe6EcEzmb5rpSyjPKSUkQZkuGWjazgzb
         jgx8ABLybH0F+eOjpLF67FFcjEnlQhSkrbLz+x4mtfz01Cyti8nUSICmQwl81OMjVQId
         Z064Zv8ePNEqdWztTsrLwC01+4WbY6A8qp4enijampeAwGDi5i0fvCjTtJrOm2mlb6wD
         F5CSdFvitNm3AocCEKazf4Sw+J4V2/N2OoeBEfM2uDMHRkXBHrvYBqFp81NFY1EsxGrB
         L+SQ==
X-Gm-Message-State: AOAM5318QZRr2O8YrcNHQJp2lbMfu0QBbe9q2XUj35bmA51rbHwYpUm1
        vQb1YMb+njfkbUhCfvPnQSMuHQ==
X-Google-Smtp-Source: ABdhPJzF6a15K9ycGmVQMoYUKXDCxa73oBO2AW6MOErQWnTaGG1fXrd/DW0LDyQxA24LHKih8B4Vkg==
X-Received: by 2002:adf:ec4d:: with SMTP id w13mr5667896wrn.334.1601052547018;
        Fri, 25 Sep 2020 09:49:07 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id a5sm3604247wrp.37.2020.09.25.09.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2020 09:49:06 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     gregkh@linuxfoundation.org, rafael@kernel.org, lgirdwood@gmail.com,
        perex@perex.cz, tiwai@suse.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, srivasam@codeaurora.org,
        rohitkr@codeaurora.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 1/2] regmap: add support to regmap_field_bulk_alloc/free apis
Date:   Fri, 25 Sep 2020 17:48:55 +0100
Message-Id: <20200925164856.10315-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200925164856.10315-1-srinivas.kandagatla@linaro.org>
References: <20200925164856.10315-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Usage of regmap_field_alloc becomes much overhead when number of fields
exceed more than 3.
QCOM LPASS driver has extensively converted to use regmap_fields.

Using new bulk api to allocate fields makes it much more cleaner code to read!

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Tested-by: Srinivasa Rao Mandadapu <srivasam@codeaurora.org>
---
 drivers/base/regmap/regmap.c | 100 +++++++++++++++++++++++++++++++++++
 include/linux/regmap.h       |  11 ++++
 2 files changed, 111 insertions(+)

diff --git a/drivers/base/regmap/regmap.c b/drivers/base/regmap/regmap.c
index aec3f26bf711..8d6aedce666d 100644
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
+ * @rm_field: regmap register fields within the bank.
+ * @reg_field: Register fields within the bank.
+ * @num_fields: Number of register fields.
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
+ * @rm_field: regmap register fields within the bank.
+ * @reg_field: Register fields within the bank.
+ * @num_fields: Number of register fields.
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
+ * will be freed as per device-driver life-cycle.
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

