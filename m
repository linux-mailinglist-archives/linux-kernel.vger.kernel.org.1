Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0ACB1279B20
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 19:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729656AbgIZRFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 13:05:31 -0400
Received: from crapouillou.net ([89.234.176.41]:38776 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726210AbgIZRFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 13:05:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1601139911; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CR6w83gwHN18JZ2Q3DyR8varXN6+RB0Yd4kBoEdPsAk=;
        b=aFgh+8StM6Un93C1B5T2HM5e1xbkd4j1ahKywOu6c2Crmr93M3J+Fe+eN/DY7aMh9+HqBn
        YxsW4I/AKxqNbfKkAmCXogVyQy5B+Sihxns8aoEW6RJD1r12DdvSfUQ7FskXhvWB07ziu6
        k77tQ67YbNhcOd5r7f0mRkf8fKnKORw=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc:     Sam Ravnborg <sam@ravnborg.org>, od@zcrc.me,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 3/7] drm/ingenic: Alloc F0 and F1 DMA descriptors at once
Date:   Sat, 26 Sep 2020 19:04:57 +0200
Message-Id: <20200926170501.1109197-4-paul@crapouillou.net>
In-Reply-To: <20200926170501.1109197-1-paul@crapouillou.net>
References: <20200926170501.1109197-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of calling dmam_alloc_coherent() once for each 4-bit DMA
hardware descriptor, we can have them both in a physical memory page, as
long as they are aligned to 16 bytes. This reduces memory consumption,
and will make it easier to add more DMA descriptors in the future.

Note that the old code would not create the F0 descriptor on SoCs that
don't support multiple planes. We don't care, because:
- we don't use more memory by allocating two descriptors instead of a
  single one;
- the only SoC that does not support multiple planes (JZ4740) still has
  two independent DMA channels, for an unknown reason.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 51 +++++++++++++----------
 1 file changed, 28 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
index d34e76f5f57d..e8d47549ff2e 100644
--- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
+++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
@@ -45,7 +45,12 @@ struct ingenic_dma_hwdesc {
 	u32 addr;
 	u32 id;
 	u32 cmd;
-} __packed;
+} __aligned(16);
+
+struct ingenic_dma_hwdescs {
+	struct ingenic_dma_hwdesc hwdesc_f0;
+	struct ingenic_dma_hwdesc hwdesc_f1;
+};
 
 struct jz_soc_info {
 	bool needs_dev_clk;
@@ -68,8 +73,8 @@ struct ingenic_drm {
 	struct clk *lcd_clk, *pix_clk;
 	const struct jz_soc_info *soc_info;
 
-	struct ingenic_dma_hwdesc *dma_hwdesc_f0, *dma_hwdesc_f1;
-	dma_addr_t dma_hwdesc_phys_f0, dma_hwdesc_phys_f1;
+	struct ingenic_dma_hwdescs *dma_hwdescs;
+	dma_addr_t dma_hwdescs_phys;
 
 	bool panel_is_sharp;
 	bool no_vblank;
@@ -546,9 +551,9 @@ static void ingenic_drm_plane_atomic_update(struct drm_plane *plane,
 		cpp = state->fb->format->cpp[0];
 
 		if (priv->soc_info->has_osd && plane->type == DRM_PLANE_TYPE_OVERLAY)
-			hwdesc = priv->dma_hwdesc_f0;
+			hwdesc = &priv->dma_hwdescs->hwdesc_f0;
 		else
-			hwdesc = priv->dma_hwdesc_f1;
+			hwdesc = &priv->dma_hwdescs->hwdesc_f1;
 
 		hwdesc->addr = addr;
 		hwdesc->cmd = JZ_LCD_CMD_EOF_IRQ | (width * height * cpp / 4);
@@ -856,6 +861,7 @@ static int ingenic_drm_bind(struct device *dev, bool has_components)
 	void __iomem *base;
 	long parent_rate;
 	unsigned int i, clone_mask = 0;
+	dma_addr_t dma_hwdesc_phys_f0, dma_hwdesc_phys_f1;
 	int ret, irq;
 
 	soc_info = of_device_get_match_data(dev);
@@ -930,26 +936,25 @@ static int ingenic_drm_bind(struct device *dev, bool has_components)
 		return PTR_ERR(priv->pix_clk);
 	}
 
-	priv->dma_hwdesc_f1 = dmam_alloc_coherent(dev, sizeof(*priv->dma_hwdesc_f1),
-						  &priv->dma_hwdesc_phys_f1,
-						  GFP_KERNEL);
-	if (!priv->dma_hwdesc_f1)
+	priv->dma_hwdescs = dmam_alloc_coherent(dev,
+						sizeof(*priv->dma_hwdescs),
+						&priv->dma_hwdescs_phys,
+						GFP_KERNEL);
+	if (!priv->dma_hwdescs)
 		return -ENOMEM;
 
-	priv->dma_hwdesc_f1->next = priv->dma_hwdesc_phys_f1;
-	priv->dma_hwdesc_f1->id = 0xf1;
 
-	if (priv->soc_info->has_osd) {
-		priv->dma_hwdesc_f0 = dmam_alloc_coherent(dev,
-							  sizeof(*priv->dma_hwdesc_f0),
-							  &priv->dma_hwdesc_phys_f0,
-							  GFP_KERNEL);
-		if (!priv->dma_hwdesc_f0)
-			return -ENOMEM;
+	/* Configure DMA hwdesc for foreground0 plane */
+	dma_hwdesc_phys_f0 = priv->dma_hwdescs_phys
+		+ offsetof(struct ingenic_dma_hwdescs, hwdesc_f0);
+	priv->dma_hwdescs->hwdesc_f0.next = dma_hwdesc_phys_f0;
+	priv->dma_hwdescs->hwdesc_f0.id = 0xf0;
 
-		priv->dma_hwdesc_f0->next = priv->dma_hwdesc_phys_f0;
-		priv->dma_hwdesc_f0->id = 0xf0;
-	}
+	/* Configure DMA hwdesc for foreground1 plane */
+	dma_hwdesc_phys_f1 = priv->dma_hwdescs_phys
+		+ offsetof(struct ingenic_dma_hwdescs, hwdesc_f1);
+	priv->dma_hwdescs->hwdesc_f1.next = dma_hwdesc_phys_f1;
+	priv->dma_hwdescs->hwdesc_f1.id = 0xf1;
 
 	if (soc_info->has_osd)
 		priv->ipu_plane = drm_plane_from_index(drm, 0);
@@ -1101,8 +1106,8 @@ static int ingenic_drm_bind(struct device *dev, bool has_components)
 	}
 
 	/* Set address of our DMA descriptor chain */
-	regmap_write(priv->map, JZ_REG_LCD_DA0, priv->dma_hwdesc_phys_f0);
-	regmap_write(priv->map, JZ_REG_LCD_DA1, priv->dma_hwdesc_phys_f1);
+	regmap_write(priv->map, JZ_REG_LCD_DA0, dma_hwdesc_phys_f0);
+	regmap_write(priv->map, JZ_REG_LCD_DA1, dma_hwdesc_phys_f1);
 
 	/* Enable OSD if available */
 	if (soc_info->has_osd)
-- 
2.28.0

