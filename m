Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 810082EAB62
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 14:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730457AbhAENDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 08:03:11 -0500
Received: from mail-lf1-f43.google.com ([209.85.167.43]:38219 "EHLO
        mail-lf1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725776AbhAENDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 08:03:10 -0500
Received: by mail-lf1-f43.google.com with SMTP id h205so72347070lfd.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jan 2021 05:02:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=tgtQajNQtfGYZ522ipxCMSmjS3sbg3o75nQBCkrCxw4=;
        b=l5s3U54LQgi628fF8GpsiZCPImN64kVI4Njmg9UYIDWdmbwT3b+GCVyEm9ZhGEwZMn
         LTT+k/y6rs+tEflLKtYhyy4O0m5Su54Imr1LrKumJoDCqcRSdhYFZzjfOLWepgl/bJfJ
         eMMd64PPyv38nxWVf0xyR9Q8ukLsITxRb6jaLbHkI7n5YZKnv71PvnYc83Id19bz36j2
         UdmCrSuM+XJ4mb4pK7NATJivFyJcqII8zYcvGLDZzoXY1zxA1y9GYxFn6QRIcUbGV02N
         ZKmIWScgtMQqjbbb+f833zm3WQpRTGG633O5GTfmpyGtoy3N4woMg3V3zK1DDTqqmHyo
         +2EQ==
X-Gm-Message-State: AOAM531OatPuKvngybesOGr/FwL0aLNhtl2dQglNt2C7sNhHc0TqGSdr
        hB5s4S5IwRYLeJg3UDfckjM=
X-Google-Smtp-Source: ABdhPJwe+5igMUcL8ocUrqrmBqm+c66kGs/6TnkYR28GbWR8hggd0RGnu23wggvD2YTT4u3FN4l/pQ==
X-Received: by 2002:a05:6512:3328:: with SMTP id l8mr37212970lfe.185.1609851748355;
        Tue, 05 Jan 2021 05:02:28 -0800 (PST)
Received: from localhost.localdomain (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id c24sm6951959lfc.277.2021.01.05.05.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 05:02:27 -0800 (PST)
Date:   Tue, 5 Jan 2021 15:02:21 +0200
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-power@fi.rohmeurope.com,
        linux-kernel@vger.kernel.org
Subject: [PATCH] regulator: ROHM bd7xxxx: Do not depend on parent driver data
Message-ID: <20210105130221.GA3438042@localhost.localdomain>
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
 drivers/regulator/bd70528-regulator.c | 11 +++--------
 drivers/regulator/bd71828-regulator.c | 13 ++++---------
 2 files changed, 7 insertions(+), 17 deletions(-)

diff --git a/drivers/regulator/bd70528-regulator.c b/drivers/regulator/bd70528-regulator.c
index d44adf7e875a..1f5f9482b209 100644
--- a/drivers/regulator/bd70528-regulator.c
+++ b/drivers/regulator/bd70528-regulator.c
@@ -244,19 +244,14 @@ static const struct regulator_desc bd70528_desc[] = {
 
 static int bd70528_probe(struct platform_device *pdev)
 {
-	struct rohm_regmap_dev *bd70528;
 	int i;
 	struct regulator_config config = {
 		.dev = pdev->dev.parent,
 	};
 
-	bd70528 = dev_get_drvdata(pdev->dev.parent);
-	if (!bd70528) {
-		dev_err(&pdev->dev, "No MFD driver data\n");
-		return -EINVAL;
-	}
-
-	config.regmap = bd70528->regmap;
+	config.regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	if (!config.regmap)
+		return -ENODEV;
 
 	for (i = 0; i < ARRAY_SIZE(bd70528_desc); i++) {
 		struct regulator_dev *rdev;
diff --git a/drivers/regulator/bd71828-regulator.c b/drivers/regulator/bd71828-regulator.c
index 85c0b9000963..6b12e963ed8f 100644
--- a/drivers/regulator/bd71828-regulator.c
+++ b/drivers/regulator/bd71828-regulator.c
@@ -749,19 +749,14 @@ static const struct bd71828_regulator_data bd71828_rdata[] = {
 
 static int bd71828_probe(struct platform_device *pdev)
 {
-	struct rohm_regmap_dev *bd71828;
 	int i, j, ret;
 	struct regulator_config config = {
 		.dev = pdev->dev.parent,
 	};
 
-	bd71828 = dev_get_drvdata(pdev->dev.parent);
-	if (!bd71828) {
-		dev_err(&pdev->dev, "No MFD driver data\n");
-		return -EINVAL;
-	}
-
-	config.regmap = bd71828->regmap;
+	config.regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	if (!config.regmap)
+		return -ENODEV;
 
 	for (i = 0; i < ARRAY_SIZE(bd71828_rdata); i++) {
 		struct regulator_dev *rdev;
@@ -777,7 +772,7 @@ static int bd71828_probe(struct platform_device *pdev)
 			return PTR_ERR(rdev);
 		}
 		for (j = 0; j < rd->reg_init_amnt; j++) {
-			ret = regmap_update_bits(bd71828->regmap,
+			ret = regmap_update_bits(config.regmap,
 						 rd->reg_inits[j].reg,
 						 rd->reg_inits[j].mask,
 						 rd->reg_inits[j].val);

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
