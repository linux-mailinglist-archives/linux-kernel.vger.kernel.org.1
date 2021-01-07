Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B96362ECF90
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 13:26:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbhAGMZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jan 2021 07:25:19 -0500
Received: from mail-lf1-f47.google.com ([209.85.167.47]:47084 "EHLO
        mail-lf1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725894AbhAGMZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jan 2021 07:25:18 -0500
Received: by mail-lf1-f47.google.com with SMTP id o10so3202570lfl.13
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jan 2021 04:25:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=qiRbThtKbsgldb/rZJ+rP33eB16ilOX+2AMb4nWd/mU=;
        b=qg63uihTKBtPjrSUfooO+/dMQPNOrbgWA2x/eEQeTbweTf7eImgAgJA+92F/Lt/KgH
         Anp+L7TfV/KNC4Z47hfSbTTiMJDPNGeVv6ClXZi+ldJZ2d/BnsBnfISEvI+iybxxIbHf
         R1LQWbBmOiuHapPEAX8SLl72JhrWDSymtOtuO7R2+qTSZ46kEKP9MPzBKKOnJoZ/xIjl
         UtTFcE/XqPXgZIdzI1SXL5NSl2T2TTDsQvhI8YWfg7MTeHh8J48DACOBC6fWJbH3+Br+
         pt6akHf+8zSlOJMJCFzhZXwz5fvr1PM9CcV2prJJhHCgQSGCQBATEyFKtuBY7E75T+OE
         Jd4w==
X-Gm-Message-State: AOAM532m2BxC4dz/HArO9kmlZoi6eIWcwCa+7lOyIh+x4oSNYBObyO8N
        LF9/XUoEbb0LE7XS5iH9Y8g=
X-Google-Smtp-Source: ABdhPJyvooCeCwNSuctUAL+no2XXEWyQHRERapbNR6GfnW4oMMNmrY8x2sTPnqum4w/ICvEaD1gbSg==
X-Received: by 2002:a05:651c:489:: with SMTP id s9mr3907950ljc.188.1610022276610;
        Thu, 07 Jan 2021 04:24:36 -0800 (PST)
Received: from localhost.localdomain (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id a9sm1111170lfl.143.2021.01.07.04.24.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jan 2021 04:24:35 -0800 (PST)
Date:   Thu, 7 Jan 2021 14:23:55 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-power@fi.rohmeurope.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: bd718x7: Stop using parent data
Message-ID: <20210107122355.GA35080@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ROHM PMIC regulator drivers only need the regmap pointer from
the parent device. Regmap can be obtained via dev_get_regmap()
so do not require parent to populate driver data for that.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
Sorry for not including this in previous cleanup patch I sent yesterday.

This is last user for MFD struct struct bd718xx - so I thought of sending
this together with the MFD change - and the MFD change was still partially
unfinished. Well, I just noticed the MFD can't be applied before the clk
portion (which I already sent) is applied - so I must anyways wait for the
clk before sending the MFD. Well, I guess I can send out the regulator
bits as well as I now anyways need to manally poll the clk to be applied
before sending the MFD.

 drivers/regulator/bd718x7-regulator.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/regulator/bd718x7-regulator.c b/drivers/regulator/bd718x7-regulator.c
index 0774467994fb..454ffec62f4f 100644
--- a/drivers/regulator/bd718x7-regulator.c
+++ b/drivers/regulator/bd718x7-regulator.c
@@ -1349,7 +1349,7 @@ static int get_hw_controlled_regulators(struct device *dev,
 
 static int bd718xx_probe(struct platform_device *pdev)
 {
-	struct bd718xx *mfd;
+	struct regmap *regmap;
 	struct regulator_config config = { 0 };
 	int i, j, err, omit_enable;
 	bool use_snvs;
@@ -1358,11 +1358,10 @@ static int bd718xx_probe(struct platform_device *pdev)
 	enum rohm_chip_type chip = platform_get_device_id(pdev)->driver_data;
 	const struct regulator_ops **swops, **hwops;
 
-	mfd = dev_get_drvdata(pdev->dev.parent);
-	if (!mfd) {
+	regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	if (!regmap) {
 		dev_err(&pdev->dev, "No MFD driver data\n");
-		err = -EINVAL;
-		goto err;
+		return -EINVAL;
 	}
 
 	switch (chip) {
@@ -1385,7 +1384,7 @@ static int bd718xx_probe(struct platform_device *pdev)
 	}
 
 	/* Register LOCK release */
-	err = regmap_update_bits(mfd->chip.regmap, BD718XX_REG_REGLOCK,
+	err = regmap_update_bits(regmap, BD718XX_REG_REGLOCK,
 				 (REGLOCK_PWRSEQ | REGLOCK_VREG), 0);
 	if (err) {
 		dev_err(&pdev->dev, "Failed to unlock PMIC (%d)\n", err);
@@ -1404,8 +1403,7 @@ static int bd718xx_probe(struct platform_device *pdev)
 	 * bit allowing HW defaults for power rails to be used
 	 */
 	if (!use_snvs) {
-		err = regmap_update_bits(mfd->chip.regmap,
-					 BD718XX_REG_TRANS_COND1,
+		err = regmap_update_bits(regmap, BD718XX_REG_TRANS_COND1,
 					 BD718XX_ON_REQ_POWEROFF_MASK |
 					 BD718XX_SWRESET_POWEROFF_MASK |
 					 BD718XX_WDOG_POWEROFF_MASK |
@@ -1421,7 +1419,7 @@ static int bd718xx_probe(struct platform_device *pdev)
 	}
 
 	config.dev = pdev->dev.parent;
-	config.regmap = mfd->chip.regmap;
+	config.regmap = regmap;
 	/*
 	 * There are cases when we want to leave the enable-control for
 	 * the HW state machine and use this driver only for voltage control.
@@ -1478,7 +1476,7 @@ static int bd718xx_probe(struct platform_device *pdev)
 		if (!no_enable_control && (!use_snvs ||
 		    !rdev->constraints->always_on ||
 		    !rdev->constraints->boot_on)) {
-			err = regmap_update_bits(mfd->chip.regmap, r->init.reg,
+			err = regmap_update_bits(regmap, r->init.reg,
 						 r->init.mask, r->init.val);
 			if (err) {
 				dev_err(&pdev->dev,
@@ -1488,7 +1486,7 @@ static int bd718xx_probe(struct platform_device *pdev)
 			}
 		}
 		for (j = 0; j < r->additional_init_amnt; j++) {
-			err = regmap_update_bits(mfd->chip.regmap,
+			err = regmap_update_bits(regmap,
 						 r->additional_inits[j].reg,
 						 r->additional_inits[j].mask,
 						 r->additional_inits[j].val);

base-commit: 2c85ebc57b3e1817b6ce1a6b703928e113a90442
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
