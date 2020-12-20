Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CACB2DF2CB
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Dec 2020 03:39:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727190AbgLTCiE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 21:38:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:48926 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726732AbgLTCiB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 21:38:01 -0500
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, CK Hu <ck.hu@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Subject: [PATCH 4/5] drm/mediatek: Automatically search unclaimed mtk mutex in mtk_mutex_get()
Date:   Sun, 20 Dec 2020 10:36:54 +0800
Message-Id: <20201220023655.30795-5-chunkuang.hu@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201220023655.30795-1-chunkuang.hu@kernel.org>
References: <20201220023655.30795-1-chunkuang.hu@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: CK Hu <ck.hu@mediatek.com>

Moving mutex resource management from client driver to  mutex driver
could prevent client drivers negotiating for resource management.

Signed-off-by: CK Hu <ck.hu@mediatek.com>
Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
---
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c |  2 +-
 drivers/gpu/drm/mediatek/mtk_mutex.c    | 16 ++++++++--------
 drivers/gpu/drm/mediatek/mtk_mutex.h    |  2 +-
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
index 5c4e8e2f4448..23d9abc4f46c 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
@@ -772,7 +772,7 @@ int mtk_drm_crtc_create(struct drm_device *drm_dev,
 	if (!mtk_crtc->ddp_comp)
 		return -ENOMEM;
 
-	mtk_crtc->mutex = mtk_mutex_get(priv->mutex_dev, pipe);
+	mtk_crtc->mutex = mtk_mutex_get(priv->mutex_dev);
 	if (IS_ERR(mtk_crtc->mutex)) {
 		ret = PTR_ERR(mtk_crtc->mutex);
 		dev_err(dev, "Failed to get mutex: %d\n", ret);
diff --git a/drivers/gpu/drm/mediatek/mtk_mutex.c b/drivers/gpu/drm/mediatek/mtk_mutex.c
index ece26359a292..e16b1772317c 100644
--- a/drivers/gpu/drm/mediatek/mtk_mutex.c
+++ b/drivers/gpu/drm/mediatek/mtk_mutex.c
@@ -226,18 +226,18 @@ static const struct mtk_mutex_data mt8173_mutex_driver_data = {
 	.mutex_sof_reg = MT2701_MUTEX0_SOF0,
 };
 
-struct mtk_mutex *mtk_mutex_get(struct device *dev, unsigned int id)
+struct mtk_mutex *mtk_mutex_get(struct device *dev)
 {
 	struct mtk_mutex_ctx *mtx = dev_get_drvdata(dev);
+	int i;
 
-	if (id >= 10)
-		return ERR_PTR(-EINVAL);
-	if (mtx->mutex[id].claimed)
-		return ERR_PTR(-EBUSY);
-
-	mtx->mutex[id].claimed = true;
+	for (i = 0; i < 10; i++)
+		if (!mtx->mutex[i].claimed) {
+			mtx->mutex[i].claimed = true;
+			return &mtx->mutex[i];
+		}
 
-	return &mtx->mutex[id];
+	return ERR_PTR(-EBUSY);
 }
 
 void mtk_mutex_put(struct mtk_mutex *mutex)
diff --git a/drivers/gpu/drm/mediatek/mtk_mutex.h b/drivers/gpu/drm/mediatek/mtk_mutex.h
index b678e0988a37..6fe4ffbde290 100644
--- a/drivers/gpu/drm/mediatek/mtk_mutex.h
+++ b/drivers/gpu/drm/mediatek/mtk_mutex.h
@@ -10,7 +10,7 @@ struct regmap;
 struct device;
 struct mtk_mutex;
 
-struct mtk_mutex *mtk_mutex_get(struct device *dev, unsigned int id);
+struct mtk_mutex *mtk_mutex_get(struct device *dev);
 int mtk_mutex_prepare(struct mtk_mutex *mutex);
 void mtk_mutex_add_comp(struct mtk_mutex *mutex,
 			enum mtk_ddp_comp_id id);
-- 
2.17.1

