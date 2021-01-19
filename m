Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 069952FBC29
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 17:14:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391962AbhASQNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 11:13:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:35164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392030AbhASQLc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 11:11:32 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 368D022241;
        Tue, 19 Jan 2021 16:10:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611072651;
        bh=GJGVCgcolu4up0iCAX540U0BQYVfzG27H/pvopxV4tg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dkE29gnGxMsbOymoQrsSmQq0KFTjogDgecgOnVKGSym6ex+zoZmVyKa5+gN39abLJ
         2jK7fp42iPA8Sn2Jp4aWx3n2dvJodn4x0CBzZi9CPkwD05jPhC8Fr6i5f0brPJ087K
         klQTAoekl4fHPFgpjymP/6FTG7TC6Dwvqywf3SdXowcPBCW/ltJSWj7oKXNJZORWRC
         lYknuiL3DVXgkblJzqrf63Xsr5E7Jr2xh7Oph1J/kSWdfpnpFh/rnl46eq+qAxgzS/
         GAWgP1+Px0fcJEI/4JFWR5XKnJ+yVmMsXOofhfQ6bocYQUdYQo+UUi6tUKZT7iYmCN
         EWIsOpL+NKXww==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1l1taj-0012bt-4W; Tue, 19 Jan 2021 17:10:49 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mayulong <mayulong1@huawei.com>, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 11/21] staging: hikey9xx: hi6421v600-regulator: cleanup comments
Date:   Tue, 19 Jan 2021 17:10:37 +0100
Message-Id: <3876bee0f8e35d15a70920c3ea9520af25f3428d.1611072387.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1611072387.git.mchehab+huawei@kernel.org>
References: <cover.1611072387.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove obvious comments and fix the comment for the
HI6421V600_LDO() macro.

While on it, use kernel-doc notation for HI6421V600_LDO(),
as kernel-doc can check if the arguments match its
description.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../staging/hikey9xx/hi6421v600-regulator.c   | 27 ++++++++-----------
 1 file changed, 11 insertions(+), 16 deletions(-)

diff --git a/drivers/staging/hikey9xx/hi6421v600-regulator.c b/drivers/staging/hikey9xx/hi6421v600-regulator.c
index e5a492ee7121..9f096d4e46db 100644
--- a/drivers/staging/hikey9xx/hi6421v600-regulator.c
+++ b/drivers/staging/hikey9xx/hi6421v600-regulator.c
@@ -57,17 +57,17 @@ static const unsigned int ldo34_voltages[] = {
 	3000000, 3100000, 3200000, 3300000
 };
 
-/*
- * _id - LDO id name string
- * _match - of match name string
- * v_table - voltage table
- * vreg - voltage select register
- * vmask - voltage select mask
- * ereg - enable register
- * emask - enable mask
- * odelay - off/on delay time in uS
- * ecomask - eco mode mask
- * ecoamp - eco mode load uppler limit in uA
+/**
+ * HI6421V600_LDO() - specify a LDO power line
+ * @_id: LDO id name string
+ * @vtable: voltage table
+ * @ereg: enable register
+ * @emask: enable mask
+ * @vreg: voltage select register
+ * @odelay: off/on delay time in uS
+ * @etime: enable time in uS
+ * @ecomask: eco mode mask
+ * @ecoamp: eco mode load uppler limit in uA
  */
 #define HI6421V600_LDO(_id, vtable, ereg, emask, vreg,			       \
 		       odelay, etime, ecomask, ecoamp)			       \
@@ -114,7 +114,6 @@ static int hi6421_spmi_regulator_enable(struct regulator_dev *rdev)
 	/* cannot enable more than one regulator at one time */
 	mutex_lock(&sreg->enable_mutex);
 
-	/* set enable register */
 	ret = hi6421_spmi_pmic_rmw(pmic, rdev->desc->enable_reg,
 				   rdev->desc->enable_mask,
 				   rdev->desc->enable_mask);
@@ -132,7 +131,6 @@ static int hi6421_spmi_regulator_disable(struct regulator_dev *rdev)
 	struct hi6421_spmi_reg_info *sreg = rdev_get_drvdata(rdev);
 	struct hi6421_spmi_pmic *pmic = sreg->pmic;
 
-	/* set enable register to 0 */
 	return hi6421_spmi_pmic_rmw(pmic, rdev->desc->enable_reg,
 				    rdev->desc->enable_mask, 0);
 }
@@ -143,7 +141,6 @@ static int hi6421_spmi_regulator_get_voltage_sel(struct regulator_dev *rdev)
 	struct hi6421_spmi_pmic *pmic = sreg->pmic;
 	u32 reg_val;
 
-	/* get voltage selector */
 	reg_val = hi6421_spmi_pmic_read(pmic, rdev->desc->vsel_reg);
 
 	return (reg_val & rdev->desc->vsel_mask) >> (ffs(rdev->desc->vsel_mask) - 1);
@@ -198,7 +195,6 @@ static int hi6421_spmi_regulator_set_mode(struct regulator_dev *rdev,
 		return -EINVAL;
 	}
 
-	/* set mode */
 	return hi6421_spmi_pmic_rmw(pmic, rdev->desc->enable_reg,
 				    sreg->eco_mode_mask, val);
 }
@@ -304,7 +300,6 @@ static int hi6421_spmi_regulator_probe(struct platform_device *pdev)
 	mutex_init(&sreg->enable_mutex);
 
 	for (i = 0; i < ARRAY_SIZE(regulator_info); i++) {
-		/* assign per-regulator data */
 		info = &regulator_info[i];
 
 		config.dev = pdev->dev.parent;
-- 
2.29.2

