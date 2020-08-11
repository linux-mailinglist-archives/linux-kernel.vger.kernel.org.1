Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D73A9241D73
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Aug 2020 17:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729192AbgHKPnI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Aug 2020 11:43:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:47588 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729022AbgHKPmH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 11:42:07 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0DFFB22D6F;
        Tue, 11 Aug 2020 15:42:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597160524;
        bh=lmCoQr+eoCdfb0DdVzRDvovZ4BYZOxTqUDEVW6qc/DA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bQHIEUmPn34YDT4Ib/hscnDGDTdyahSTUkXg7xUdyYwdhsopsOkZhmegIaKIz2OL/
         9WqfaMmBeLMy1dSidqSQMyXz+PgFzUSdppFEwWIiTJCRF5YQk5J8I5wGqN+y6hEy/J
         XChyqlh7Z0mhIssyfyxpUceaWPhFNdB6uoTEAkyg=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k5WPa-004bnP-4R; Tue, 11 Aug 2020 17:42:02 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 25/33] regulator: hi6421v600-regulator:  convert to use get/set voltage_sel
Date:   Tue, 11 Aug 2020 17:41:51 +0200
Message-Id: <a3bd0953e0fbac188c60781a882b9e100ff5b5c4.1597160086.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597160086.git.mchehab+huawei@kernel.org>
References: <cover.1597160086.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the supported LDOs on this driver are all using a selector,
change the implementation to use get_voltage_sel and
set_voltage_sel ops.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/regulator/hi6421v600-regulator.c | 58 +++++++++---------------
 1 file changed, 22 insertions(+), 36 deletions(-)

diff --git a/drivers/regulator/hi6421v600-regulator.c b/drivers/regulator/hi6421v600-regulator.c
index f77ecea78597..abd1f43dd5ec 100644
--- a/drivers/regulator/hi6421v600-regulator.c
+++ b/drivers/regulator/hi6421v600-regulator.c
@@ -86,8 +86,8 @@ static int hi6421_spmi_regulator_enable(struct regulator_dev *rdev)
 
 	/* set enable register */
 	hi6421_spmi_pmic_rmw(pmic, rdev->desc->enable_reg,
-		      rdev->desc->enable_mask,
-				rdev->desc->enable_mask);
+			     rdev->desc->enable_mask,
+			     rdev->desc->enable_mask);
 	dev_dbg(&rdev->dev, "%s: enable_reg=0x%x, enable_mask=0x%x\n",
 		 __func__, rdev->desc->enable_reg,
 		 rdev->desc->enable_mask);
@@ -109,64 +109,49 @@ static int hi6421_spmi_regulator_disable(struct regulator_dev *rdev)
 	return 0;
 }
 
-static int hi6421_spmi_regulator_get_voltage(struct regulator_dev *rdev)
+static int hi6421_spmi_regulator_get_voltage_sel(struct regulator_dev *rdev)
 {
 	struct hi6421v600_regulator *sreg = rdev_get_drvdata(rdev);
 	struct hi6421_spmi_pmic *pmic = sreg->pmic;
 	u32 reg_val, selector;
-	int vol;
 
 	/* get voltage selector */
 	reg_val = hi6421_spmi_pmic_read(pmic, rdev->desc->vsel_reg);
-	selector = (reg_val & rdev->desc->vsel_mask) >>
-				(ffs(rdev->desc->vsel_mask) - 1);
 
-	vol = rdev->desc->ops->list_voltage(rdev, selector);
+	selector = (reg_val & rdev->desc->vsel_mask) >>	(ffs(rdev->desc->vsel_mask) - 1);
 
 	dev_dbg(&rdev->dev,
-		"%s: vsel_reg=0x%x, val=0x%x, entry=0x%x, voltage=%d mV\n",
-		 __func__, rdev->desc->vsel_reg, reg_val, selector, vol/ 1000);
+		"%s: vsel_reg=0x%x, value=0x%x, entry=0x%x, voltage=%d mV\n",
+		 __func__, rdev->desc->vsel_reg, reg_val, selector,
+		rdev->desc->ops->list_voltage(rdev, selector) / 1000);
 
-	return vol;
+	return selector;
 }
 
-static int hi6421_spmi_regulator_set_voltage(struct regulator_dev *rdev,
-				      int min_uV, int max_uV, unsigned int *selector)
+static int hi6421_spmi_regulator_set_voltage_sel(struct regulator_dev *rdev,
+						 unsigned int selector)
 {
 	struct hi6421v600_regulator *sreg = rdev_get_drvdata(rdev);
 	struct hi6421_spmi_pmic *pmic = sreg->pmic;
-	u32 vsel;
-	int uV, ret = 0;
-
-	for (vsel = 0; vsel < rdev->desc->n_voltages; vsel++) {
-		uV = rdev->desc->volt_table[vsel];
-		dev_dbg(&rdev->dev,
-			"%s: min %d, max %d, value[%u] = %d\n",
-			__func__, min_uV, max_uV, vsel, uV);
-
-		/* Break at the first in-range value */
-		if (min_uV <= uV && uV <= max_uV)
-			break;
-	}
+	u32 reg_val;
 
 	/* unlikely to happen. sanity test done by regulator core */
-	if (unlikely(vsel == rdev->desc->n_voltages))
+	if (unlikely(selector >= rdev->desc->n_voltages))
 		return -EINVAL;
 
-	*selector = vsel;
+	reg_val = selector << (ffs(rdev->desc->vsel_mask) - 1);
+
 	/* set voltage selector */
 	hi6421_spmi_pmic_rmw(pmic, rdev->desc->vsel_reg,
-		      rdev->desc->vsel_mask,
-		      vsel << (ffs(rdev->desc->vsel_mask) - 1));
+			     rdev->desc->vsel_mask, reg_val);
 
 	dev_dbg(&rdev->dev,
-		"%s: vsel_reg=0x%x, vsel_mask=0x%x, value=0x%x, voltage=%d mV\n",
+		"%s: vsel_reg=0x%x, mask=0x%x, value=0x%x, voltage=%d mV\n",
 		 __func__,
-		 rdev->desc->vsel_reg,
-		 rdev->desc->vsel_mask,
-		 vsel << (ffs(rdev->desc->vsel_mask) - 1), uV / 1000);
+		 rdev->desc->vsel_reg, rdev->desc->vsel_mask, reg_val,
+		 rdev->desc->ops->list_voltage(rdev, selector) / 1000);
 
-	return ret;
+	return 0;
 }
 
 static unsigned int hi6421_spmi_regulator_get_mode(struct regulator_dev *rdev)
@@ -315,8 +300,9 @@ static struct regulator_ops hi6421_spmi_ldo_rops = {
 	.enable = hi6421_spmi_regulator_enable,
 	.disable = hi6421_spmi_regulator_disable,
 	.list_voltage = regulator_list_voltage_table,
-	.get_voltage = hi6421_spmi_regulator_get_voltage,
-	.set_voltage = hi6421_spmi_regulator_set_voltage,
+	.map_voltage = regulator_map_voltage_iterate,
+	.get_voltage_sel = hi6421_spmi_regulator_get_voltage_sel,
+	.set_voltage_sel = hi6421_spmi_regulator_set_voltage_sel,
 	.get_mode = hi6421_spmi_regulator_get_mode,
 	.set_mode = hi6421_spmi_regulator_set_mode,
 	.get_optimum_mode = hi6421_spmi_regulator_get_optimum_mode,
-- 
2.26.2

