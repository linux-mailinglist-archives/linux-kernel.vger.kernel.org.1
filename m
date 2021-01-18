Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0992FA1C1
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 14:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392358AbhARNgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 08:36:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:35110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392216AbhARN3c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 08:29:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id E9311222F9;
        Mon, 18 Jan 2021 13:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610976499;
        bh=jRvQEHL8oJlU2BcF/EGMt58FThbxhBFtl5x9gxFjtD8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i6NJn9aH4xlu3l9Oef7UpNOjJGzotmYwCycA0RSZEOj0z/M1d3d0rVLiuj+eZnkLL
         yttJZJvFdd1Qmzbnw2Rr/HcjHvMqFTEOQjrHvH2I8RRBGMGIsfVxreapGVw4X4jPhX
         vVzcRROiGieqhQSZHMSn8rsbr3hjCBTToJoBVfRxXkNURPkFlKtIHoaB5My6OdeOa0
         qJuU+my2BDxW0qlrE9a5QX3EnPxQJiNroCiN0vmN3STGee7qaz5BfTqCKF7MhbDqRz
         8ZB/x7Ecm2yjxcyBr8wxRk7cnIVFS75GzbGTC5oZwLuTJbBgTi/4k17umTJ8an31Gg
         QU2ixC+0QEUzg==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1l1UZs-000Vks-JO; Mon, 18 Jan 2021 14:28:16 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mayulong <mayulong1@huawei.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 08/13] staging: hikey9xx: hi6421v600-regulator: do some cleanups
Date:   Mon, 18 Jan 2021 14:28:09 +0100
Message-Id: <9c39e49df06411389cc37dcbbfbb427d8397d42b.1610975633.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1610975633.git.mchehab+huawei@kernel.org>
References: <cover.1610975633.git.mchehab+huawei@kernel.org>
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
 .../staging/hikey9xx/hi6421v600-regulator.c   | 35 ++++++++-----------
 1 file changed, 14 insertions(+), 21 deletions(-)

diff --git a/drivers/staging/hikey9xx/hi6421v600-regulator.c b/drivers/staging/hikey9xx/hi6421v600-regulator.c
index 8c64c0a86a3d..a8a268f326f5 100644
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
@@ -170,10 +169,8 @@ static int hi6421_spmi_regulator_set_voltage_sel(struct regulator_dev *rdev,
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
 
@@ -343,12 +336,12 @@ MODULE_DEVICE_TABLE(platform, hi6421_spmi_regulator_table);
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

