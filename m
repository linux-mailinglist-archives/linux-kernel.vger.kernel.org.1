Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 874672EF346
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 14:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbhAHNmG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 08:42:06 -0500
Received: from mail-lf1-f48.google.com ([209.85.167.48]:39977 "EHLO
        mail-lf1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726059AbhAHNmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 08:42:05 -0500
Received: by mail-lf1-f48.google.com with SMTP id m12so22983654lfo.7
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jan 2021 05:41:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Un/0ChZMqY7muxT6N5Oef3TvdSB8hIrl/YAfmawt2s0=;
        b=mmd42/oZIwA2bQazzU23zuZQZIHJc83RSv5sYf+qpnS31cjHWg7W76QMgO6SBVJR3D
         Xpn68O5uEL7rBmrx6dntzFes2jl19IdIg81X8TVCq9Hb3P8V4Es9ZN78MH5WtLXxgHFf
         Q/CqXMTXSszYwtlrqhGXdTW6bJ1ycfObX2OjqNxiUekf61O/f4nyWGiWjds6mx5yn44q
         iH2Hiak5unMz9kvK3AQ4koYAOcpRR4sjvulz246N45Z7Amb7VVbNXjvXL+rEixR1FMtQ
         Lz1Lhrz/VLU/9bP4vE6p0INJjmNtst2MNCBonBKJlYBUgwNvZXL5gCELnZ97ApCKpbvJ
         k6EQ==
X-Gm-Message-State: AOAM5313pCfJ9DQ1aTHZVxADaadFJqTuuhuwLh/xMArKVSc6HIUJLMTK
        mhWh8YRyGI2km791ObY+cpw=
X-Google-Smtp-Source: ABdhPJxvs4bXpbp2lQVkuzigD6p8ci1GywoD+dXhFPS4OdgYCnezm6G5MrpXDLTi6sp0PIM6Y3Zq7A==
X-Received: by 2002:a2e:bc26:: with SMTP id b38mr1621399ljf.161.1610113283875;
        Fri, 08 Jan 2021 05:41:23 -0800 (PST)
Received: from localhost.localdomain (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id z6sm2165782ljz.71.2021.01.08.05.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jan 2021 05:41:23 -0800 (PST)
Date:   Fri, 8 Jan 2021 15:41:14 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        linux-kernel@vger.kernel.org, linux-power@fi.rohmeurope.com
Subject: [PATCH 10/15] regulator: helpers: Export helper voltage listing
Message-ID: <723882b066b4572075553b19c410ec3feb6a98a0.1610110144.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1610110144.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1610110144.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some drivers need to translate voltage values to selectors prior regulator
registration. Currently a regulator_desc based list_voltages helper is only
exported for regulators using the linear_ranges. Export similar helper also
for regulators using simple linear mapping.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 drivers/regulator/helpers.c      | 36 +++++++++++++++++++++++++-------
 include/linux/regulator/driver.h |  2 ++
 2 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/drivers/regulator/helpers.c b/drivers/regulator/helpers.c
index e4bb09bbd3fa..3cd0babac8a3 100644
--- a/drivers/regulator/helpers.c
+++ b/drivers/regulator/helpers.c
@@ -508,6 +508,33 @@ int regulator_map_voltage_pickable_linear_range(struct regulator_dev *rdev,
 }
 EXPORT_SYMBOL_GPL(regulator_map_voltage_pickable_linear_range);
 
+/**
+ * regulator_desc_list_voltage_linear - List voltages with simple calculation
+ *
+ * @desc: Regulator desc for regulator which volatges are to be listed
+ * @selector: Selector to convert into a voltage
+ *
+ * Regulators with a simple linear mapping between voltages and
+ * selectors can set min_uV and uV_step in the regulator descriptor
+ * and then use this function prior regulator registration to list
+ * the voltages. This is useful when voltages need to be listed during
+ * device-tree parsing.
+ */
+int regulator_desc_list_voltage_linear(const struct regulator_desc *desc,
+				       unsigned int selector)
+{
+	if (selector >= desc->n_voltages)
+		return -EINVAL;
+
+	if (selector < desc->linear_min_sel)
+		return 0;
+
+	selector -= desc->linear_min_sel;
+
+	return desc->min_uV + (desc->uV_step * selector);
+}
+EXPORT_SYMBOL_GPL(regulator_desc_list_voltage_linear);
+
 /**
  * regulator_list_voltage_linear - List voltages with simple calculation
  *
@@ -521,14 +548,7 @@ EXPORT_SYMBOL_GPL(regulator_map_voltage_pickable_linear_range);
 int regulator_list_voltage_linear(struct regulator_dev *rdev,
 				  unsigned int selector)
 {
-	if (selector >= rdev->desc->n_voltages)
-		return -EINVAL;
-	if (selector < rdev->desc->linear_min_sel)
-		return 0;
-
-	selector -= rdev->desc->linear_min_sel;
-
-	return rdev->desc->min_uV + (rdev->desc->uV_step * selector);
+	return regulator_desc_list_voltage_linear(rdev->desc, selector);
 }
 EXPORT_SYMBOL_GPL(regulator_list_voltage_linear);
 
diff --git a/include/linux/regulator/driver.h b/include/linux/regulator/driver.h
index 11cade73726c..05a8e0bb924a 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -540,4 +540,6 @@ void *regulator_get_init_drvdata(struct regulator_init_data *reg_init_data);
 int regulator_desc_list_voltage_linear_range(const struct regulator_desc *desc,
 					     unsigned int selector);
 
+int regulator_desc_list_voltage_linear(const struct regulator_desc *desc,
+				       unsigned int selector);
 #endif
-- 
2.25.4


-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =] 
