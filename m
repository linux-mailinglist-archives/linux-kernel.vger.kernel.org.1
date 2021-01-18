Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85BBD2FA19F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 14:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392256AbhARNaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 08:30:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:34766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390890AbhARN3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 08:29:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DF17B21D93;
        Mon, 18 Jan 2021 13:28:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610976499;
        bh=kgnPnbYajDLZ7OMrS6Oz7aU+0+apRb/5+GgwuoOZGW4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LWdhETu969WoazpjNy5rmzowuadILkFhLqSnJNverOOTAI6CJbDNu642bJQsvsw+C
         V+ew2niDXSd4NXelynWh1GcudBT4yubxXjX6ZQ+BlqPwBQdmZ5DB55zg17h0+y9I3i
         QXlZ/wLW22K+3XmiForUGiprSGgGxA+3SO0DkE0ueMVkbrdsrSBVxRldXfqJNVkXka
         ZNxNrcUe8ZbVFhpR5qae9r+WrkJEUx/sxq1FaE4uYNk2QveSDHgSd3NQ6sFIr1DCCV
         laUgQpM6mV+HUb4njF4v5GyEhvaJ7bA1C0YBsmHZf5qJVolJN/X0E1Z7+LfGdDqeMG
         GpBEMaZ+2uBkQ==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1l1UZs-000Vkm-Fy; Mon, 18 Jan 2021 14:28:16 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mayulong <mayulong1@huawei.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 05/13] staging: hikey9xx: hi6421v600-regulator: cleanup debug msgs
Date:   Mon, 18 Jan 2021 14:28:06 +0100
Message-Id: <5a9fa2db2f996b5b8739f2960105e25e5c096abe.1610975633.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1610975633.git.mchehab+huawei@kernel.org>
References: <cover.1610975633.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While those were useful during port time from downstream
version, let's get rid of them for good, as it is possible to
get about the same things by enabling regulator debugging code.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../staging/hikey9xx/hi6421v600-regulator.c   | 47 ++-----------------
 1 file changed, 4 insertions(+), 43 deletions(-)

diff --git a/drivers/staging/hikey9xx/hi6421v600-regulator.c b/drivers/staging/hikey9xx/hi6421v600-regulator.c
index a9d83c99d2d4..1aed5b37fa23 100644
--- a/drivers/staging/hikey9xx/hi6421v600-regulator.c
+++ b/drivers/staging/hikey9xx/hi6421v600-regulator.c
@@ -23,9 +23,6 @@
 #include <linux/regulator/driver.h>
 #include <linux/spmi.h>
 
-#define rdev_dbg(rdev, fmt, arg...)	\
-		 pr_debug("%s: %s: " fmt, (rdev)->desc->name, __func__, ##arg)
-
 struct hi6421_spmi_reg_info {
 	struct regulator_desc	desc;
 	struct hi6421_spmi_pmic *pmic;
@@ -112,11 +109,6 @@ static int hi6421_spmi_regulator_is_enabled(struct regulator_dev *rdev)
 
 	reg_val = hi6421_spmi_pmic_read(pmic, rdev->desc->enable_reg);
 
-	rdev_dbg(rdev,
-		 "enable_reg=0x%x, val= 0x%x, enable_state=%d\n",
-		 rdev->desc->enable_reg,
-		 reg_val, (reg_val & rdev->desc->enable_mask));
-
 	return ((reg_val & rdev->desc->enable_mask) != 0);
 }
 
@@ -131,11 +123,6 @@ static int hi6421_spmi_regulator_enable(struct regulator_dev *rdev)
 		     HISI_REGS_ENA_PROTECT_TIME + 1000);
 
 	/* set enable register */
-	rdev_dbg(rdev,
-		 "off_on_delay=%d us, enable_reg=0x%x, enable_mask=0x%x\n",
-		 rdev->desc->off_on_delay, rdev->desc->enable_reg,
-		 rdev->desc->enable_mask);
-
 	hi6421_spmi_pmic_rmw(pmic, rdev->desc->enable_reg,
 			     rdev->desc->enable_mask,
 			     rdev->desc->enable_mask);
@@ -151,9 +138,6 @@ static int hi6421_spmi_regulator_disable(struct regulator_dev *rdev)
 	struct hi6421_spmi_pmic *pmic = sreg->pmic;
 
 	/* set enable register to 0 */
-	rdev_dbg(rdev, "enable_reg=0x%x, enable_mask=0x%x\n",
-		 rdev->desc->enable_reg, rdev->desc->enable_mask);
-
 	hi6421_spmi_pmic_rmw(pmic, rdev->desc->enable_reg,
 			     rdev->desc->enable_mask, 0);
 
@@ -164,19 +148,12 @@ static int hi6421_spmi_regulator_get_voltage_sel(struct regulator_dev *rdev)
 {
 	struct hi6421_spmi_reg_info *sreg = rdev_get_drvdata(rdev);
 	struct hi6421_spmi_pmic *pmic = sreg->pmic;
-	u32 reg_val, selector;
+	u32 reg_val;
 
 	/* get voltage selector */
 	reg_val = hi6421_spmi_pmic_read(pmic, rdev->desc->vsel_reg);
 
-	selector = (reg_val & rdev->desc->vsel_mask) >>	(ffs(rdev->desc->vsel_mask) - 1);
-
-	rdev_dbg(rdev,
-		 "vsel_reg=0x%x, value=0x%x, entry=0x%x, voltage=%d mV\n",
-		 rdev->desc->vsel_reg, reg_val, selector,
-		rdev->desc->ops->list_voltage(rdev, selector) / 1000);
-
-	return selector;
+	return (reg_val & rdev->desc->vsel_mask) >>	(ffs(rdev->desc->vsel_mask) - 1);
 }
 
 static int hi6421_spmi_regulator_set_voltage_sel(struct regulator_dev *rdev,
@@ -192,11 +169,6 @@ static int hi6421_spmi_regulator_set_voltage_sel(struct regulator_dev *rdev,
 	reg_val = selector << (ffs(rdev->desc->vsel_mask) - 1);
 
 	/* set voltage selector */
-	rdev_dbg(rdev,
-		 "vsel_reg=0x%x, mask=0x%x, value=0x%x, voltage=%d mV\n",
-		 rdev->desc->vsel_reg, rdev->desc->vsel_mask, reg_val,
-		 rdev->desc->ops->list_voltage(rdev, selector) / 1000);
-
 	hi6421_spmi_pmic_rmw(pmic, rdev->desc->vsel_reg,
 			     rdev->desc->vsel_mask, reg_val);
 
@@ -207,22 +179,14 @@ static unsigned int hi6421_spmi_regulator_get_mode(struct regulator_dev *rdev)
 {
 	struct hi6421_spmi_reg_info *sreg = rdev_get_drvdata(rdev);
 	struct hi6421_spmi_pmic *pmic = sreg->pmic;
-	unsigned int mode;
 	u32 reg_val;
 
 	reg_val = hi6421_spmi_pmic_read(pmic, rdev->desc->enable_reg);
 
 	if (reg_val & sreg->eco_mode_mask)
-		mode = REGULATOR_MODE_IDLE;
-	else
-		mode = REGULATOR_MODE_NORMAL;
+		return REGULATOR_MODE_IDLE;
 
-	rdev_dbg(rdev,
-		 "enable_reg=0x%x, eco_mode_mask=0x%x, reg_val=0x%x, %s mode\n",
-		 rdev->desc->enable_reg, sreg->eco_mode_mask, reg_val,
-		 mode == REGULATOR_MODE_IDLE ? "idle" : "normal");
-
-	return mode;
+	return REGULATOR_MODE_NORMAL;
 }
 
 static int hi6421_spmi_regulator_set_mode(struct regulator_dev *rdev,
@@ -244,9 +208,6 @@ static int hi6421_spmi_regulator_set_mode(struct regulator_dev *rdev,
 	}
 
 	/* set mode */
-	rdev_dbg(rdev, "enable_reg=0x%x, eco_mode_mask=0x%x, value=0x%x\n",
-		 rdev->desc->enable_reg, sreg->eco_mode_mask, val);
-
 	hi6421_spmi_pmic_rmw(pmic, rdev->desc->enable_reg,
 			     sreg->eco_mode_mask, val);
 
-- 
2.29.2

