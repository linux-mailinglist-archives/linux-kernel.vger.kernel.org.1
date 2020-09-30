Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2371C27E269
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 09:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728442AbgI3HPy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 03:15:54 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:38690 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725440AbgI3HPx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 03:15:53 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3C97477D1EFD6731895D;
        Wed, 30 Sep 2020 15:15:49 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS402-HUB.china.huawei.com (10.3.19.202) with Microsoft SMTP Server id
 14.3.487.0; Wed, 30 Sep 2020 15:15:39 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <airlied@linux.ie>, <daniel@ffwll.ch>, <tzimmermann@suse.de>,
        <kraxel@redhat.com>, <alexander.deucher@amd.com>,
        <tglx@linutronix.de>, <dri-devel@lists.freedesktop.org>,
        <xinliang.liu@linaro.org>, <linux-kernel@vger.kernel.org>
CC:     <linuxarm@huawei.com>
Subject: [PATCH drm/hisilicon 2/2] drm/hisilicon: Use the same style of variable type in hibmc_drm_drv
Date:   Wed, 30 Sep 2020 15:13:08 +0800
Message-ID: <1601449988-41463-3-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1601449988-41463-1-git-send-email-tiantao6@hisilicon.com>
References: <1601449988-41463-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Consistently Use the same style of variable type in hibmc_drm_de.c and
hibmc_drm_de.h.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
---
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c | 13 ++++++-------
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h |  8 ++++----
 2 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
index 5632bce..0c1b40d 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
@@ -121,12 +121,11 @@ static void hibmc_kms_fini(struct hibmc_drm_private *priv)
 /*
  * It can operate in one of three modes: 0, 1 or Sleep.
  */
-void hibmc_set_power_mode(struct hibmc_drm_private *priv,
-			  unsigned int power_mode)
+void hibmc_set_power_mode(struct hibmc_drm_private *priv, u32 power_mode)
 {
-	unsigned int control_value = 0;
+	u32 control_value = 0;
 	void __iomem   *mmio = priv->mmio;
-	unsigned int input = 1;
+	u32 input = 1;
 
 	if (power_mode > HIBMC_PW_MODE_CTL_MODE_SLEEP)
 		return;
@@ -144,8 +143,8 @@ void hibmc_set_power_mode(struct hibmc_drm_private *priv,
 
 void hibmc_set_current_gate(struct hibmc_drm_private *priv, unsigned int gate)
 {
-	unsigned int gate_reg;
-	unsigned int mode;
+	u32 gate_reg;
+	u32 mode;
 	void __iomem   *mmio = priv->mmio;
 
 	/* Get current power mode. */
@@ -170,7 +169,7 @@ void hibmc_set_current_gate(struct hibmc_drm_private *priv, unsigned int gate)
 
 static void hibmc_hw_config(struct hibmc_drm_private *priv)
 {
-	unsigned int reg;
+	u32 reg;
 
 	/* On hardware reset, power mode 0 is default. */
 	hibmc_set_power_mode(priv, HIBMC_PW_MODE_CTL_MODE_MODE0);
diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
index 6a63502..5c4030d 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
@@ -33,8 +33,8 @@ struct hibmc_drm_private {
 	/* hw */
 	void __iomem   *mmio;
 	void __iomem   *fb_map;
-	unsigned long  fb_base;
-	unsigned long  fb_size;
+	u64  fb_base;
+	u64  fb_size;
 
 	/* drm */
 	struct drm_device  *dev;
@@ -56,9 +56,9 @@ static inline struct hibmc_drm_private *to_hibmc_drm_private(struct drm_device *
 }
 
 void hibmc_set_power_mode(struct hibmc_drm_private *priv,
-			  unsigned int power_mode);
+			  u32 power_mode);
 void hibmc_set_current_gate(struct hibmc_drm_private *priv,
-			    unsigned int gate);
+			    u32 gate);
 
 int hibmc_de_init(struct hibmc_drm_private *priv);
 int hibmc_vdac_init(struct hibmc_drm_private *priv);
-- 
2.7.4

