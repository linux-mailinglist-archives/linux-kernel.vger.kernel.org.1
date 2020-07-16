Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B28422286D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jul 2020 18:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729424AbgGPQjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jul 2020 12:39:48 -0400
Received: from crapouillou.net ([89.234.176.41]:50458 "EHLO crapouillou.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728562AbgGPQjs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 12:39:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1594917540; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0+JSwbGIod25QvEeCWSV2Y9jtnfEA3truTTb/dSDItw=;
        b=SV8TRDJC39yBkOq71pqi+n/prrDmF67WSy1QOwDnbe9RJ1RVROU81IxKsSVW/T2CC8rRTi
        qcChQZq2dNMSlr5oaWksdjmTFp0MoMTFP1lgGWD7nXQKijQbWyVA2w5Z3rz47vLsHKBYHc
        DA5sx8ac6+DZ+1FNQbaQ3fO5g5IUxnw=
From:   Paul Cercueil <paul@crapouillou.net>
To:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>
Cc:     Sam Ravnborg <sam@ravnborg.org>, od@zcrc.me,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v3 08/12] drm/ingenic: Use dmam_alloc_coherent()
Date:   Thu, 16 Jul 2020 18:38:42 +0200
Message-Id: <20200716163846.174790-8-paul@crapouillou.net>
In-Reply-To: <20200716163846.174790-1-paul@crapouillou.net>
References: <20200716163846.174790-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use dmam_alloc_coherent() instead of dma_alloc_coherent(). Then we don't
need to register a custom cleanup handler.

v3: New patch

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
---
 drivers/gpu/drm/ingenic/ingenic-drm-drv.c | 18 +++---------------
 1 file changed, 3 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
index d9cd74d70a61..9cc785776594 100644
--- a/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
+++ b/drivers/gpu/drm/ingenic/ingenic-drm-drv.c
@@ -459,14 +459,6 @@ static const struct drm_mode_config_funcs ingenic_drm_mode_config_funcs = {
 	.atomic_commit		= drm_atomic_helper_commit,
 };
 
-static void ingenic_drm_free_dma_hwdesc(void *d)
-{
-	struct ingenic_drm *priv = d;
-
-	dma_free_coherent(priv->dev, sizeof(*priv->dma_hwdesc),
-			  priv->dma_hwdesc, priv->dma_hwdesc_phys);
-}
-
 static int ingenic_drm_probe(struct platform_device *pdev)
 {
 	const struct jz_soc_info *soc_info;
@@ -549,16 +541,12 @@ static int ingenic_drm_probe(struct platform_device *pdev)
 		bridge = devm_drm_panel_bridge_add_typed(dev, panel,
 							 DRM_MODE_CONNECTOR_DPI);
 
-	priv->dma_hwdesc = dma_alloc_coherent(dev, sizeof(*priv->dma_hwdesc),
-					      &priv->dma_hwdesc_phys,
-					      GFP_KERNEL);
+	priv->dma_hwdesc = dmam_alloc_coherent(dev, sizeof(*priv->dma_hwdesc),
+					       &priv->dma_hwdesc_phys,
+					       GFP_KERNEL);
 	if (!priv->dma_hwdesc)
 		return -ENOMEM;
 
-	ret = devm_add_action_or_reset(dev, ingenic_drm_free_dma_hwdesc, priv);
-	if (ret)
-		return ret;
-
 	priv->dma_hwdesc->next = priv->dma_hwdesc_phys;
 	priv->dma_hwdesc->id = 0xdeafbead;
 
-- 
2.27.0

