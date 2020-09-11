Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C135265EE9
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Sep 2020 13:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725820AbgIKLlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Sep 2020 07:41:39 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:49616 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725779AbgIKLiy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 07:38:54 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 276D44D483AD00BB640F;
        Fri, 11 Sep 2020 19:22:11 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Fri, 11 Sep 2020
 19:22:01 +0800
From:   Yu Kuai <yukuai3@huawei.com>
To:     <chunkuang.hu@kernel.org>, <p.zabel@pengutronix.de>,
        <airlied@linux.ie>, <daniel@ffwll.ch>, <matthias.bgg@gmail.com>,
        <djkurtz@chromium.org>, <yt.shen@mediatek.com>,
        <ck.hu@mediatek.com>, <littlecvr@chromium.org>
CC:     <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <yukuai3@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH] drm/mediatek: add missing put_device() call in mtk_drm_kms_init()
Date:   Fri, 11 Sep 2020 19:21:19 +0800
Message-ID: <20200911112119.3218073-1-yukuai3@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

if of_find_device_by_node() succeed, mtk_drm_kms_init() doesn't have
a corresponding put_device(). Thus add jump target to fix the exception
handling for this function implementation.

Fixes: 119f5173628a ("drm/mediatek: Add DRM Driver for Mediatek SoC MT8173.")
Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 040a8f393fe2..7aceace94ebf 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -165,7 +165,7 @@ static int mtk_drm_kms_init(struct drm_device *drm)
 
 	ret = drmm_mode_config_init(drm);
 	if (ret)
-		return ret;
+		goto put_mutex_dev;
 
 	drm->mode_config.min_width = 64;
 	drm->mode_config.min_height = 64;
@@ -182,7 +182,7 @@ static int mtk_drm_kms_init(struct drm_device *drm)
 
 	ret = component_bind_all(drm->dev, drm);
 	if (ret)
-		return ret;
+		goto put_mutex_dev;
 
 	/*
 	 * We currently support two fixed data streams, each optional,
@@ -229,7 +229,7 @@ static int mtk_drm_kms_init(struct drm_device *drm)
 	}
 	if (!dma_dev->dma_parms) {
 		ret = -ENOMEM;
-		goto err_component_unbind;
+		goto put_dma_dev;
 	}
 
 	ret = dma_set_max_seg_size(dma_dev, (unsigned int)DMA_BIT_MASK(32));
@@ -256,9 +256,12 @@ static int mtk_drm_kms_init(struct drm_device *drm)
 err_unset_dma_parms:
 	if (private->dma_parms_allocated)
 		dma_dev->dma_parms = NULL;
+put_dma_dev:
+	put_device(private->dma_dev);
 err_component_unbind:
 	component_unbind_all(drm->dev, drm);
-
+put_mutex_dev:
+	put_device(private->mutex_dev);
 	return ret;
 }
 
-- 
2.25.4

