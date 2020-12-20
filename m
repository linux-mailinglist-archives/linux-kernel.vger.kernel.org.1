Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8BE32DF2CA
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Dec 2020 03:39:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727005AbgLTCh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Dec 2020 21:37:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:48822 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726923AbgLTCh4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Dec 2020 21:37:56 -0500
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
Subject: [PATCH 2/5] drm/mediatek: Rename file mtk_drm_ddp to mtk_mutex
Date:   Sun, 20 Dec 2020 10:36:52 +0800
Message-Id: <20201220023655.30795-3-chunkuang.hu@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201220023655.30795-1-chunkuang.hu@kernel.org>
References: <20201220023655.30795-1-chunkuang.hu@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: CK Hu <ck.hu@mediatek.com>

After mmsys routing function is moved out of mtk_drm_ddp.c, mtk_drm_ddp.c
has only mtk mutex function, so rename it to match the function in it.

Signed-off-by: CK Hu <ck.hu@mediatek.com>
Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
---
 drivers/gpu/drm/mediatek/Makefile                       | 4 ++--
 drivers/gpu/drm/mediatek/mtk_drm_crtc.c                 | 2 +-
 drivers/gpu/drm/mediatek/{mtk_drm_ddp.c => mtk_mutex.c} | 0
 drivers/gpu/drm/mediatek/{mtk_drm_ddp.h => mtk_mutex.h} | 6 +++---
 4 files changed, 6 insertions(+), 6 deletions(-)
 rename drivers/gpu/drm/mediatek/{mtk_drm_ddp.c => mtk_mutex.c} (100%)
 rename drivers/gpu/drm/mediatek/{mtk_drm_ddp.h => mtk_mutex.h} (92%)

diff --git a/drivers/gpu/drm/mediatek/Makefile b/drivers/gpu/drm/mediatek/Makefile
index a892edec5563..09979c4c340a 100644
--- a/drivers/gpu/drm/mediatek/Makefile
+++ b/drivers/gpu/drm/mediatek/Makefile
@@ -4,13 +4,13 @@ mediatek-drm-y := mtk_disp_color.o \
 		  mtk_disp_ovl.o \
 		  mtk_disp_rdma.o \
 		  mtk_drm_crtc.o \
-		  mtk_drm_ddp.o \
 		  mtk_drm_ddp_comp.o \
 		  mtk_drm_drv.o \
 		  mtk_drm_gem.o \
 		  mtk_drm_plane.o \
 		  mtk_dsi.o \
-		  mtk_dpi.o
+		  mtk_dpi.o \
+		  mtk_mutex.o
 
 obj-$(CONFIG_DRM_MEDIATEK) += mediatek-drm.o
 
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
index bdd37eadecd5..1e827de1427d 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_crtc.c
@@ -19,10 +19,10 @@
 
 #include "mtk_drm_drv.h"
 #include "mtk_drm_crtc.h"
-#include "mtk_drm_ddp.h"
 #include "mtk_drm_ddp_comp.h"
 #include "mtk_drm_gem.h"
 #include "mtk_drm_plane.h"
+#include "mtk_mutex.h"
 
 /*
  * struct mtk_drm_crtc - MediaTek specific crtc structure.
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.c b/drivers/gpu/drm/mediatek/mtk_mutex.c
similarity index 100%
rename from drivers/gpu/drm/mediatek/mtk_drm_ddp.c
rename to drivers/gpu/drm/mediatek/mtk_mutex.c
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.h b/drivers/gpu/drm/mediatek/mtk_mutex.h
similarity index 92%
rename from drivers/gpu/drm/mediatek/mtk_drm_ddp.h
rename to drivers/gpu/drm/mediatek/mtk_mutex.h
index a1ee21d15334..3abcc20e88fb 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.h
+++ b/drivers/gpu/drm/mediatek/mtk_mutex.h
@@ -3,8 +3,8 @@
  * Copyright (c) 2015 MediaTek Inc.
  */
 
-#ifndef MTK_DRM_DDP_H
-#define MTK_DRM_DDP_H
+#ifndef MTK_MUTEX_H
+#define MTK_MUTEX_H
 
 struct regmap;
 struct device;
@@ -23,4 +23,4 @@ void mtk_disp_mutex_put(struct mtk_disp_mutex *mutex);
 void mtk_disp_mutex_acquire(struct mtk_disp_mutex *mutex);
 void mtk_disp_mutex_release(struct mtk_disp_mutex *mutex);
 
-#endif /* MTK_DRM_DDP_H */
+#endif /* MTK_MUTEX_H */
-- 
2.17.1

