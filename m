Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E3732DCDB2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 09:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727482AbgLQIfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 03:35:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726488AbgLQIfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 03:35:10 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF0CC0617A7
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 00:34:30 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id g185so4906637wmf.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Dec 2020 00:34:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S/cF24D4J6cwZf31EM96gFXc7xDWWLJL3b20a73K+Mk=;
        b=jbRLwFboY615xgwu29uVtZxijSNHCHMkFkl+dfhrnrQR4hK+xrrHbXI35Zn59D/Qw8
         Z8PIvv0Knb85w8ZSUDBElGmBRJfWfmLYgslaTPzlFM4vhVT21NG2od4lvM9XTKqoplIq
         HOZ5/fVkqOfZRBEJloaAQlcEZKXOBbY9STZwe0m6AbNQFTNSpSR07VAGo4zhyJIDUz3Y
         diqKeVaiYekK1x4C9isGLeFycUpFILhKX7SqISQ7pV1lHfWEVY150WqKTzEDnsexr0wA
         AgF4dPz4hGQ0s//weQKqWihjqqIYTPEl2SngQ3zZtXzM7Bp4WWn0MLyRG1KRulThW14F
         20fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S/cF24D4J6cwZf31EM96gFXc7xDWWLJL3b20a73K+Mk=;
        b=M680KRYaqXvD/Rf9QVlkoqthPd/EOZbHwD6/4NqdwT3R/u09y4GEsVmSTDOLc5HQ0P
         TToJ9COs8eTcf99kOAwG3dLQGpVUbscRQrQ5M1raGjPtcRCRMntPlGRYrCbb4WjNvvYf
         Xfnl5L3ukpd3U+GZrJJNQP8DSq6wlrBoqzqN2E87gGHelX+0Nnj4xskry2LgNluv6za5
         AcSjQ8EFRJLVV887tOlhxM7d7DU34qAXnX9VNYzu0nB+XAhLZa9BxxtXZJZKYKiMAV21
         gmrw9Kr+XUEuFrJZNHY2Hc1NqraMSx+Nh8k9andDeEDfd8LIqMC6QkTKnR8YjpxU2S5h
         pDdw==
X-Gm-Message-State: AOAM532JMlAF1EZnPZub0+JNePtVJqYU7iuTD+6LRwHtdPfOnE9lTmtR
        x2PRM5oSByanzeqquPfl9kajsw==
X-Google-Smtp-Source: ABdhPJxvUdE/0aYj/DoCgrKUtfPlErQ8D2icT9fnVxgwxcjpTUEm2L25byl0nlyrDC3iKQgrL9ueEg==
X-Received: by 2002:a05:600c:2042:: with SMTP id p2mr7504535wmg.152.1608194069003;
        Thu, 17 Dec 2020 00:34:29 -0800 (PST)
Received: from dell.default ([91.110.221.200])
        by smtp.gmail.com with ESMTPSA id b19sm6573309wmj.37.2020.12.17.00.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Dec 2020 00:34:28 -0800 (PST)
From:   Lee Jones <lee.jones@linaro.org>
To:     lee.jones@linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Gene Chen <gene_chen@richtek.com>,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 1/1] mfd: Standardise MFD_CELL_* helper names
Date:   Thu, 17 Dec 2020 08:34:20 +0000
Message-Id: <20201217083420.411569-1-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Start all helpers with "MFD_CELL_".

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: Gene Chen <gene_chen@richtek.com>
Cc: linux-mediatek@lists.infradead.org
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mfd/ab8500-core.c  | 42 +++++++++++++++++++-------------------
 drivers/mfd/db8500-prcmu.c |  6 +++---
 drivers/mfd/mt6360-core.c  | 12 +++++------
 include/linux/mfd/core.h   |  6 +++---
 4 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/drivers/mfd/ab8500-core.c b/drivers/mfd/ab8500-core.c
index a3bac9da8cbbc..ba8da061af0ef 100644
--- a/drivers/mfd/ab8500-core.c
+++ b/drivers/mfd/ab8500-core.c
@@ -610,52 +610,52 @@ int ab8500_suspend(struct ab8500 *ab8500)
 }
 
 static const struct mfd_cell ab8500_bm_devs[] = {
-	OF_MFD_CELL("ab8500-charger", NULL, &ab8500_bm_data,
+	MFD_CELL_OF("ab8500-charger", NULL, &ab8500_bm_data,
 		    sizeof(ab8500_bm_data), 0, "stericsson,ab8500-charger"),
-	OF_MFD_CELL("ab8500-btemp", NULL, &ab8500_bm_data,
+	MFD_CELL_OF("ab8500-btemp", NULL, &ab8500_bm_data,
 		    sizeof(ab8500_bm_data), 0, "stericsson,ab8500-btemp"),
-	OF_MFD_CELL("ab8500-fg", NULL, &ab8500_bm_data,
+	MFD_CELL_OF("ab8500-fg", NULL, &ab8500_bm_data,
 		    sizeof(ab8500_bm_data), 0, "stericsson,ab8500-fg"),
-	OF_MFD_CELL("ab8500-chargalg", NULL, &ab8500_bm_data,
+	MFD_CELL_OF("ab8500-chargalg", NULL, &ab8500_bm_data,
 		    sizeof(ab8500_bm_data), 0, "stericsson,ab8500-chargalg"),
 };
 
 static const struct mfd_cell ab8500_devs[] = {
 #ifdef CONFIG_DEBUG_FS
-	OF_MFD_CELL("ab8500-debug",
+	MFD_CELL_OF("ab8500-debug",
 		    NULL, NULL, 0, 0, "stericsson,ab8500-debug"),
 #endif
-	OF_MFD_CELL("ab8500-sysctrl",
+	MFD_CELL_OF("ab8500-sysctrl",
 		    NULL, NULL, 0, 0, "stericsson,ab8500-sysctrl"),
-	OF_MFD_CELL("ab8500-ext-regulator",
+	MFD_CELL_OF("ab8500-ext-regulator",
 		    NULL, NULL, 0, 0, "stericsson,ab8500-ext-regulator"),
-	OF_MFD_CELL("ab8500-regulator",
+	MFD_CELL_OF("ab8500-regulator",
 		    NULL, NULL, 0, 0, "stericsson,ab8500-regulator"),
-	OF_MFD_CELL("ab8500-clk",
+	MFD_CELL_OF("ab8500-clk",
 		    NULL, NULL, 0, 0, "stericsson,ab8500-clk"),
-	OF_MFD_CELL("ab8500-gpadc",
+	MFD_CELL_OF("ab8500-gpadc",
 		    NULL, NULL, 0, 0, "stericsson,ab8500-gpadc"),
-	OF_MFD_CELL("ab8500-rtc",
+	MFD_CELL_OF("ab8500-rtc",
 		    NULL, NULL, 0, 0, "stericsson,ab8500-rtc"),
-	OF_MFD_CELL("ab8500-acc-det",
+	MFD_CELL_OF("ab8500-acc-det",
 		    NULL, NULL, 0, 0, "stericsson,ab8500-acc-det"),
-	OF_MFD_CELL("ab8500-poweron-key",
+	MFD_CELL_OF("ab8500-poweron-key",
 		    NULL, NULL, 0, 0, "stericsson,ab8500-poweron-key"),
-	OF_MFD_CELL("ab8500-pwm",
+	MFD_CELL_OF("ab8500-pwm",
 		    NULL, NULL, 0, 1, "stericsson,ab8500-pwm"),
-	OF_MFD_CELL("ab8500-pwm",
+	MFD_CELL_OF("ab8500-pwm",
 		    NULL, NULL, 0, 2, "stericsson,ab8500-pwm"),
-	OF_MFD_CELL("ab8500-pwm",
+	MFD_CELL_OF("ab8500-pwm",
 		    NULL, NULL, 0, 3, "stericsson,ab8500-pwm"),
-	OF_MFD_CELL("ab8500-denc",
+	MFD_CELL_OF("ab8500-denc",
 		    NULL, NULL, 0, 0, "stericsson,ab8500-denc"),
-	OF_MFD_CELL("pinctrl-ab8500",
+	MFD_CELL_OF("pinctrl-ab8500",
 		    NULL, NULL, 0, 0, "stericsson,ab8500-gpio"),
-	OF_MFD_CELL("abx500-temp",
+	MFD_CELL_OF("abx500-temp",
 		    NULL, NULL, 0, 0, "stericsson,abx500-temp"),
-	OF_MFD_CELL("ab8500-usb",
+	MFD_CELL_OF("ab8500-usb",
 		    NULL, NULL, 0, 0, "stericsson,ab8500-usb"),
-	OF_MFD_CELL("ab8500-codec",
+	MFD_CELL_OF("ab8500-codec",
 		    NULL, NULL, 0, 0, "stericsson,ab8500-codec"),
 };
 
diff --git a/drivers/mfd/db8500-prcmu.c b/drivers/mfd/db8500-prcmu.c
index a5983d515db03..167faac9b75bf 100644
--- a/drivers/mfd/db8500-prcmu.c
+++ b/drivers/mfd/db8500-prcmu.c
@@ -2954,12 +2954,12 @@ static const struct mfd_cell common_prcmu_devs[] = {
 };
 
 static const struct mfd_cell db8500_prcmu_devs[] = {
-	OF_MFD_CELL("db8500-prcmu-regulators", NULL,
+	MFD_CELL_OF("db8500-prcmu-regulators", NULL,
 		    &db8500_regulators, sizeof(db8500_regulators), 0,
 		    "stericsson,db8500-prcmu-regulator"),
-	OF_MFD_CELL("cpuidle-dbx500",
+	MFD_CELL_OF("cpuidle-dbx500",
 		    NULL, NULL, 0, 0, "stericsson,cpuidle-dbx500"),
-	OF_MFD_CELL("db8500-thermal",
+	MFD_CELL_OF("db8500-thermal",
 		    NULL, NULL, 0, 0, "stericsson,db8500-thermal"),
 };
 
diff --git a/drivers/mfd/mt6360-core.c b/drivers/mfd/mt6360-core.c
index 4661c1b29a726..480722acf706b 100644
--- a/drivers/mfd/mt6360-core.c
+++ b/drivers/mfd/mt6360-core.c
@@ -292,17 +292,17 @@ static const struct resource mt6360_ldo_resources[] = {
 };
 
 static const struct mfd_cell mt6360_devs[] = {
-	OF_MFD_CELL("mt6360_adc", mt6360_adc_resources,
+	MFD_CELL_OF("mt6360_adc", mt6360_adc_resources,
 		    NULL, 0, 0, "mediatek,mt6360_adc"),
-	OF_MFD_CELL("mt6360_chg", mt6360_chg_resources,
+	MFD_CELL_OF("mt6360_chg", mt6360_chg_resources,
 		    NULL, 0, 0, "mediatek,mt6360_chg"),
-	OF_MFD_CELL("mt6360_led", mt6360_led_resources,
+	MFD_CELL_OF("mt6360_led", mt6360_led_resources,
 		    NULL, 0, 0, "mediatek,mt6360_led"),
-	OF_MFD_CELL("mt6360_pmic", mt6360_pmic_resources,
+	MFD_CELL_OF("mt6360_pmic", mt6360_pmic_resources,
 		    NULL, 0, 0, "mediatek,mt6360_pmic"),
-	OF_MFD_CELL("mt6360_ldo", mt6360_ldo_resources,
+	MFD_CELL_OF("mt6360_ldo", mt6360_ldo_resources,
 		    NULL, 0, 0, "mediatek,mt6360_ldo"),
-	OF_MFD_CELL("mt6360_tcpc", NULL,
+	MFD_CELL_OF("mt6360_tcpc", NULL,
 		    NULL, 0, 0, "mediatek,mt6360_tcpc"),
 };
 
diff --git a/include/linux/mfd/core.h b/include/linux/mfd/core.h
index 4b35baa14d308..2009c4b936d9d 100644
--- a/include/linux/mfd/core.h
+++ b/include/linux/mfd/core.h
@@ -28,13 +28,13 @@
 		.id = (_id),						\
 	}
 
-#define OF_MFD_CELL_REG(_name, _res, _pdata, _pdsize, _id, _compat, _of_reg) \
+#define MFD_CELL_OF_REG(_name, _res, _pdata, _pdsize, _id, _compat, _of_reg) \
 	MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, _compat, _of_reg, true, NULL)
 
-#define OF_MFD_CELL(_name, _res, _pdata, _pdsize, _id, _compat) \
+#define MFD_CELL_OF(_name, _res, _pdata, _pdsize, _id, _compat) \
 	MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, _compat, 0, false, NULL)
 
-#define ACPI_MFD_CELL(_name, _res, _pdata, _pdsize, _id, _match) \
+#define MFD_CELL_ACPI(_name, _res, _pdata, _pdsize, _id, _match) \
 	MFD_CELL_ALL(_name, _res, _pdata, _pdsize, _id, NULL, 0, false, _match)
 
 #define MFD_CELL_BASIC(_name, _res, _pdata, _pdsize, _id) \
-- 
2.25.1

