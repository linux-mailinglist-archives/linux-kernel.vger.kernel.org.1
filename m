Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 198B328FC1F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 02:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388430AbgJPAhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Oct 2020 20:37:54 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:55982 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2388291AbgJPAhx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Oct 2020 20:37:53 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 48F5BBFBFA966E71B15B;
        Fri, 16 Oct 2020 08:37:50 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 DGGEMS411-HUB.china.huawei.com (10.3.19.211) with Microsoft SMTP Server id
 14.3.487.0; Fri, 16 Oct 2020 08:37:45 +0800
From:   Tian Tao <tiantao6@hisilicon.com>
To:     <airlied@linux.ie>, <daniel@ffwll.ch>, <tzimmermann@suse.de>,
        <kraxel@redhat.com>, <alexander.deucher@amd.com>,
        <tglx@linutronix.de>, <dri-devel@lists.freedesktop.org>,
        <xinliang.liu@linaro.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH drm/hisilicon v3 2/2] drm/hisilicon: Use the same style of variable type in hibmc_drm_drv
Date:   Fri, 16 Oct 2020 08:38:31 +0800
Message-ID: <1602808711-65193-3-git-send-email-tiantao6@hisilicon.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1602808711-65193-1-git-send-email-tiantao6@hisilicon.com>
References: <1602808711-65193-1-git-send-email-tiantao6@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Consistently Use the same style of variable type in hibmc_drm_drv.c and
hibmc_drm_drv.h.

Signed-off-by: Tian Tao <tiantao6@hisilicon.com>
Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
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
index 6a63502..f310a83 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
@@ -33,8 +33,8 @@ struct hibmc_drm_private {
 	/* hw */
 	void __iomem   *mmio;
 	void __iomem   *fb_map;
-	unsigned long  fb_base;
-	unsigned long  fb_size;
+	resource_size_t  fb_base;
+	resource_size_t  fb_size;
 
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

