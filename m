Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC3EF242CC5
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Aug 2020 18:00:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgHLP70 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Aug 2020 11:59:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:46036 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726632AbgHLP5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 11:57:02 -0400
Received: from mail.kernel.org (ip5f5ad5c5.dynamic.kabel-deutschland.de [95.90.213.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DECDD22CAE;
        Wed, 12 Aug 2020 15:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597247820;
        bh=ZcDE5i42m9j0hSsmtVzmayvub4jxnh7AZrHRgXzHWhU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NoQjjhvA+UoYAM5PJjgxIAa+XYLobOOfUMt7sKs1Uyu9YWO6/bI17gEcinNw01Dq9
         CScIeHfq1TPS64sbjiUqQDz/rAVHwki3X3zlTanEXsEfoQv1o1KjRtrf38CiCg/FzC
         76u9Tqs2Lp6ULP21anC6p366uPdlX7tKo/2SRa8A=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1k5t7Z-005t67-Vf; Wed, 12 Aug 2020 17:56:57 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     linuxarm@huawei.com, mauro.chehab@huawei.com,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lee Jones <lee.jones@linaro.org>, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org
Subject: [PATCH 12/44] staging: mfd: hi6421-spmi-pmic: get rid of unused code
Date:   Wed, 12 Aug 2020 17:56:22 +0200
Message-Id: <2f9c3b0a157e14ecdf5f632304bc5c87e0ebf2d7.1597247164.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1597247164.git.mchehab+huawei@kernel.org>
References: <cover.1597247164.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are some checks there which could make sense for
downstream builds, but doesn't make much sense for
upstream ones. They came from the official Hikey970 tree
from Linaro, but even there, the commented-out code is not
set via other Kconfig vars.

So, let's just get rid of that. If needed later, this
patch can be (partially?) reversed.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 drivers/staging/hikey9xx/hi6421-spmi-pmic.c | 63 ---------------------
 include/linux/mfd/hi6421-spmi-pmic.h        | 42 --------------
 2 files changed, 105 deletions(-)

diff --git a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
index 6bb0bc4b203b..809381eb6043 100644
--- a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
+++ b/drivers/staging/hikey9xx/hi6421-spmi-pmic.c
@@ -53,10 +53,6 @@
 #define HISI_PMIC_FIRST_GROUP_INT_NUM        2
 
 static struct bit_info g_pmic_vbus = {0};
-#ifndef BIT
-#define BIT(x)		(0x1U << (x))
-#endif
-
 static struct hisi_pmic *g_pmic;
 static unsigned int g_extinterrupt_flag  = 0;
 static struct of_device_id of_hisi_pmic_match_tbl[] = {
@@ -121,65 +117,6 @@ void hisi_pmic_write(struct hisi_pmic *pmic, int reg, u32 val)
 }
 EXPORT_SYMBOL(hisi_pmic_write);
 
-#ifdef CONFIG_HISI_DIEID
-u32 hisi_pmic_read_sub_pmu(u8 sid, int reg)
-{
-	u32 ret;
-	u8 read_value = 0;
-	struct spmi_device *pdev;
-
-	if(strstr(saved_command_line, "androidboot.swtype=factory"))
-	{
-		if (NULL == g_pmic) {
-			pr_err(" g_pmic  is NULL\n");
-			return -1;/*lint !e570 */
-		}
-
-		pdev = to_spmi_device(g_pmic->dev);
-		if (NULL == pdev) {
-			pr_err("%s:pdev get failed!\n", __func__);
-			return -1;/*lint !e570 */
-		}
-
-		ret = spmi_ext_register_readl(pdev->ctrl, sid, reg, (unsigned char*)&read_value, 1);/*lint !e734 !e732 */
-		if (ret) {
-			pr_err("%s:spmi_ext_register_readl failed!\n", __func__);
-			return ret;
-		}
-		return (u32)read_value;
-	}
-	return  0;
-}
-EXPORT_SYMBOL(hisi_pmic_read_sub_pmu);
-
-void hisi_pmic_write_sub_pmu(u8 sid, int reg, u32 val)
-{
-	u32 ret;
-	struct spmi_device *pdev;
-	if(strstr(saved_command_line, "androidboot.swtype=factory"))
-	{
-		if (NULL == g_pmic) {
-			pr_err(" g_pmic  is NULL\n");
-			return;
-		}
-
-		pdev = to_spmi_device(g_pmic->dev);
-		if (NULL == pdev) {
-			pr_err("%s:pdev get failed!\n", __func__);
-			return;
-		}
-
-		ret = spmi_ext_register_writel(pdev->ctrl, sid, reg, (unsigned char*)&val, 1);/*lint !e734 !e732 */
-		if (ret) {
-			pr_err("%s:spmi_ext_register_writel failed!\n", __func__);
-			return ;
-		}
-	}
-
-	return ;
-}
-EXPORT_SYMBOL(hisi_pmic_write_sub_pmu);
-#endif
 
 void hisi_pmic_rmw(struct hisi_pmic *pmic, int reg,
 		     u32 mask, u32 bits)
diff --git a/include/linux/mfd/hi6421-spmi-pmic.h b/include/linux/mfd/hi6421-spmi-pmic.h
index 939b36f617c1..5be9b4d3f207 100644
--- a/include/linux/mfd/hi6421-spmi-pmic.h
+++ b/include/linux/mfd/hi6421-spmi-pmic.h
@@ -78,7 +78,6 @@ unsigned int get_uv_mntn_status(void);
 void clear_uv_mntn_resered_reg_bit(void);
 void set_uv_mntn_resered_reg_bit(void);
 
-#if defined(CONFIG_HISI_PMIC) || defined(CONFIG_HISI_PMIC_PMU_SPMI)
 /* Register Access Helpers */
 u32 hisi_pmic_read(struct hisi_pmic *pmic, int reg);
 void hisi_pmic_write(struct hisi_pmic *pmic, int reg, u32 val);
@@ -90,11 +89,6 @@ int hisi_pmic_array_read(int addr, char *buff, unsigned int len);
 int hisi_pmic_array_write(int addr, char *buff, unsigned int len);
 extern int hisi_get_pmic_irq_byname(unsigned int pmic_irq_list);
 extern int hisi_pmic_get_vbus_status(void);
-#if defined(CONFIG_HISI_DIEID)
-u32 hisi_pmic_read_sub_pmu(u8 sid ,int reg);
-void hisi_pmic_write_sub_pmu(u8 sid ,int reg, u32 val);
-#endif
-#else
 static inline u32 hisi_pmic_read(struct hisi_pmic *pmic, int reg) { return 0; }
 static inline void hisi_pmic_write(struct hisi_pmic *pmic, int reg, u32 val) {}
 static inline void hisi_pmic_rmw(struct hisi_pmic *pmic, int reg, u32 mask, u32 bits) {}
@@ -107,38 +101,7 @@ static inline int hisi_get_pmic_irq_byname(unsigned int pmic_irq_list) { return
 static inline int hisi_pmic_get_vbus_status(void) { return 1; }
 static inline u32 hisi_pmic_read_sub_pmu(u8 sid ,int reg) { return 0; }
 static inline void hisi_pmic_write_sub_pmu(u8 sid ,int reg, u32 val) {}
-#endif
 
-#ifdef CONFIG_HISI_HI6421V500_PMU
-enum pmic_irq_list {
-	POR_D45MR = 0,
-	VBUS_CONNECT,
-	VBUS_DISCONNECT,
-	ALARMON_R,
-	HOLD_6S,
-	HOLD_1S,
-	POWERKEY_UP,
-	POWERKEY_DOWN,
-	OCP_SCP_R,
-	COUL_R,
-	VSYS_OV,
-	VSYS_UV,
-	VSYS_PWROFF_ABS,
-	VSYS_PWROFF_DEB,
-	THSD_OTMP140,
-	THSD_OTMP125,
-	HRESETN,
-	SIM0_HPD_R = 24,
-	SIM0_HPD_F,
-	SIM0_HPD_H,
-	SIM0_HPD_L,
-	SIM1_HPD_R,
-	SIM1_HPD_F,
-	SIM1_HPD_H,
-	SIM1_HPD_L,
-	PMIC_IRQ_LIST_MAX,
-};
-#else
 enum pmic_irq_list {
 	OTMP = 0,
 	VBUS_CONNECT,
@@ -156,10 +119,5 @@ enum pmic_irq_list {
 	SIM1_HPD_F,
 	PMIC_IRQ_LIST_MAX,
 };
-#endif
-
-#ifdef CONFIG_HISI_SR_DEBUG
-extern void get_ip_regulator_state(void);
-#endif
 #endif		/* __HISI_PMIC_H */
 
-- 
2.26.2

