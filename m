Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CD472FBC3D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 17:19:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392130AbhASQOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 11:14:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:36322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391390AbhASQMT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 11:12:19 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5EFC223137;
        Tue, 19 Jan 2021 16:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611072651;
        bh=U4kdN16C/IeL/ZSKFf0juQ1NKvCmwim4VbjgDzr2xqo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DMeFVp2Pp6giY8zWEglxIortdceQaS9vjmSrKs5tDfvAhtEvDuvddRt+6oEKJpX/k
         uGvJfCG4yEvA68LCEohMB2MmOq9VKV27gFX4h8oZFHinXMXdlM3YovBbf5E+iDZOd3
         wV5GvdhXflWmu+JWHs83nq3+bcza0pwN3/D+f5jxqP5wk/9CugsCx537Ot1PXkdp+r
         6j85IMJNfBzwVgMmiOaZPDE7yasysS/GwS/e+dWu9ivLmP8B7wrRTcxv98rBdkCJwx
         LfCfepePIYbsy/YzrtGFLxyrLUgRuMd6LuPHFTepzsSg2wKYVLEHyKtZGkSMt+lMNs
         nXhgVasVSVehA==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1l1taj-0012bl-1x; Tue, 19 Jan 2021 17:10:49 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mayulong <mayulong1@huawei.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 08/21] staging: hikey9xx: hi6421v600-regulator: do some cleanups
Date:   Tue, 19 Jan 2021 17:10:34 +0100
Message-Id: <1011b25c5e4e20d93ad1ce118dfdc9747467f852.1611072387.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1611072387.git.mchehab+huawei@kernel.org>
References: <cover.1611072387.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for de-staging, do some cleanups:

- Return error codes from hi6421_spmi_pmic_rmw();
- Remove a debug message;
- Change the module description;
- a few minor coding style adjustments.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../staging/hikey9xx/hi6421v600-regulator.c   | 37 ++++++++-----------
 1 file changed, 15 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/hikey9xx/hi6421v600-regulator.c b/drivers/staging/hikey9xx/hi6421v600-regulator.c
index e25e596f58cf..564d86f0e4dc 100644
--- a/drivers/staging/hikey9xx/hi6421v600-regulator.c
+++ b/drivers/staging/hikey9xx/hi6421v600-regulator.c
@@ -117,6 +117,7 @@ static int hi6421_spmi_regulator_enable(struct regulator_dev *rdev)
 {
 	struct hi6421_spmi_reg_info *sreg = rdev_get_drvdata(rdev);
 	struct hi6421_spmi_pmic *pmic = sreg->pmic;
+	int ret;
 
 	/* cannot enable more than one regulator at one time */
 	mutex_lock(&sreg->enable_mutex);
@@ -124,13 +125,13 @@ static int hi6421_spmi_regulator_enable(struct regulator_dev *rdev)
 		     HISI_REGS_ENA_PROTECT_TIME + 1000);
 
 	/* set enable register */
-	hi6421_spmi_pmic_rmw(pmic, rdev->desc->enable_reg,
-			     rdev->desc->enable_mask,
-			     rdev->desc->enable_mask);
+	ret = hi6421_spmi_pmic_rmw(pmic, rdev->desc->enable_reg,
+				   rdev->desc->enable_mask,
+				   rdev->desc->enable_mask);
 
 	mutex_unlock(&sreg->enable_mutex);
 
-	return 0;
+	return ret;
 }
 
 static int hi6421_spmi_regulator_disable(struct regulator_dev *rdev)
@@ -139,10 +140,8 @@ static int hi6421_spmi_regulator_disable(struct regulator_dev *rdev)
 	struct hi6421_spmi_pmic *pmic = sreg->pmic;
 
 	/* set enable register to 0 */
-	hi6421_spmi_pmic_rmw(pmic, rdev->desc->enable_reg,
-			     rdev->desc->enable_mask, 0);
-
-	return 0;
+	return hi6421_spmi_pmic_rmw(pmic, rdev->desc->enable_reg,
+				    rdev->desc->enable_mask, 0);
 }
 
 static int hi6421_spmi_regulator_get_voltage_sel(struct regulator_dev *rdev)
@@ -154,7 +153,7 @@ static int hi6421_spmi_regulator_get_voltage_sel(struct regulator_dev *rdev)
 	/* get voltage selector */
 	reg_val = hi6421_spmi_pmic_read(pmic, rdev->desc->vsel_reg);
 
-	return (reg_val & rdev->desc->vsel_mask) >>	(ffs(rdev->desc->vsel_mask) - 1);
+	return (reg_val & rdev->desc->vsel_mask) >> (ffs(rdev->desc->vsel_mask) - 1);
 }
 
 static int hi6421_spmi_regulator_set_voltage_sel(struct regulator_dev *rdev,
@@ -164,16 +163,14 @@ static int hi6421_spmi_regulator_set_voltage_sel(struct regulator_dev *rdev,
 	struct hi6421_spmi_pmic *pmic = sreg->pmic;
 	u32 reg_val;
 
-	if (unlikely(selector >= rdev->desc->n_voltages))
+	if (selector >= rdev->desc->n_voltages)
 		return -EINVAL;
 
 	reg_val = selector << (ffs(rdev->desc->vsel_mask) - 1);
 
 	/* set voltage selector */
-	hi6421_spmi_pmic_rmw(pmic, rdev->desc->vsel_reg,
-			     rdev->desc->vsel_mask, reg_val);
-
-	return 0;
+	return hi6421_spmi_pmic_rmw(pmic, rdev->desc->vsel_reg,
+				    rdev->desc->vsel_mask, reg_val);
 }
 
 static unsigned int hi6421_spmi_regulator_get_mode(struct regulator_dev *rdev)
@@ -209,10 +206,8 @@ static int hi6421_spmi_regulator_set_mode(struct regulator_dev *rdev,
 	}
 
 	/* set mode */
-	hi6421_spmi_pmic_rmw(pmic, rdev->desc->enable_reg,
-			     sreg->eco_mode_mask, val);
-
-	return 0;
+	return hi6421_spmi_pmic_rmw(pmic, rdev->desc->enable_reg,
+				    sreg->eco_mode_mask, val);
 }
 
 static unsigned int
@@ -319,8 +314,6 @@ static int hi6421_spmi_regulator_probe(struct platform_device *pdev)
 		/* assign per-regulator data */
 		info = &regulator_info[i];
 
-		dev_dbg(dev, "adding regulator %s\n", info->desc.name);
-
 		config.dev = pdev->dev.parent;
 		config.driver_data = sreg;
 
@@ -344,12 +337,12 @@ MODULE_DEVICE_TABLE(platform, hi6421_spmi_regulator_table);
 static struct platform_driver hi6421_spmi_regulator_driver = {
 	.id_table = hi6421_spmi_regulator_table,
 	.driver = {
-		.name	= "hi6421v600-regulator",
+		.name = "hi6421v600-regulator",
 	},
 	.probe	= hi6421_spmi_regulator_probe,
 };
 module_platform_driver(hi6421_spmi_regulator_driver);
 
-MODULE_DESCRIPTION("Hi6421v600 regulator driver");
+MODULE_DESCRIPTION("Hi6421v600 SPMI regulator driver");
 MODULE_LICENSE("GPL v2");
 
-- 
2.29.2

