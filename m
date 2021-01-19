Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 109FD2FB2FA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 08:30:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbhASH2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 02:28:47 -0500
Received: from mail-lj1-f169.google.com ([209.85.208.169]:36545 "EHLO
        mail-lj1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731072AbhASH0A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 02:26:00 -0500
Received: by mail-lj1-f169.google.com with SMTP id n8so11972449ljg.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jan 2021 23:25:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YGrne4f+5i807vnd/1HrFrqpIe7X+fjHJqMwI9w2IWM=;
        b=rJ5udQ5WZLTeN6JZ/gO0IL7pd0uaQtVZVlTQ3SnykcpMvynw1LvkyMxurcLaf/Wi84
         lpWeG63OLEZps9i8wF4B0He6zMVd0ZqjhuNME8V9i+A41/5kdtkVprcZCHJN1UB6MG5c
         JRhFRvYmT8RWy9GXm5LB+nO1bR6r79YTL/t5Z8CszmRxXFtYGIc6D1CdeIkbuwcTwzO9
         Mw+gUVi5rPhXCMpMjQk4urMBjcPRn1XBmiZ0YuFYxZ5FMt4Z57KBecs0l/j8agS3Kvja
         exkr2XsrKoDwO50A39HzmT/2x2hgalTrN6naC/Q1cmXaOBwCl1An0ugOV5tTyYI8NIZj
         i9MA==
X-Gm-Message-State: AOAM533voW2+3G0BoFP4kmPMIqQaXYP9GP36kKHfXN+2wTivJs1/P7EK
        xn8A/Fia5Ssf7D4aNtNQ9NE=
X-Google-Smtp-Source: ABdhPJyasNYriSaFPXcNXfhz+1fNibtkbH21CHiCsxXCSLP+ArwjN6v18pZZTgajfxSOAaiEdiAYjQ==
X-Received: by 2002:a2e:98cc:: with SMTP id s12mr1424839ljj.325.1611041116537;
        Mon, 18 Jan 2021 23:25:16 -0800 (PST)
Received: from localhost.localdomain (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id g4sm2192888lfc.85.2021.01.18.23.25.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Jan 2021 23:25:15 -0800 (PST)
Date:   Tue, 19 Jan 2021 09:25:09 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        linux-kernel@vger.kernel.org, linux-power@fi.rohmeurope.com
Subject: [PATCH v2 11/17] regulator: helpers: Export helper voltage listing
Message-ID: <4bca1f81e1791e27ee461ee41b39fc7502d6eb7d.1611037866.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1611037866.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1611037866.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some drivers need to translate voltage values to selectors prior regulator
registration. Currently a regulator_desc based list_voltages helper is only
exported for regulators using the linear_ranges. Export similar helper also
for regulators using simple linear mapping.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
No changes since v1

 drivers/regulator/helpers.c      | 36 +++++++++++++++++++++++++-------
 include/linux/regulator/driver.h |  2 ++
 2 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/drivers/regulator/helpers.c b/drivers/regulator/helpers.c
index f42b394a0c46..3e19ecbf7267 100644
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
index d7c77ee370f3..39a540111645 100644
--- a/include/linux/regulator/driver.h
+++ b/include/linux/regulator/driver.h
@@ -543,4 +543,6 @@ void *regulator_get_init_drvdata(struct regulator_init_data *reg_init_data);
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
