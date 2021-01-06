Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9ECD2EC6B4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 00:19:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbhAFXSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 18:18:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:48268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726119AbhAFXSV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 18:18:21 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DF82923339;
        Wed,  6 Jan 2021 23:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609975060;
        bh=RuKbU26yuLZJAE82ECbyxWKAfxQoGE+1gpGy1pi6ErU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=i+oQrZOhV8uWRogTMJD4O/ez9I/Wy0nAK4BwCY8iCpKgMinLRhX3BWKsNpJbBRDfV
         LRaF/jWeIs4tCLU2E5cSej0rqMsI4gvUZjkmVsgnH8D0/LrQK40LEBiWJT159nAJad
         08nwmtoYqX3DUkZWV9/NkzjG4UJd6Qzh3WajQf/lTWxhNdURiKpCapMBQPmzpxPtdY
         Qz1FBI0m95m/q7lcb3oHdnE6STL8DsOYiAv66xD5VYH/iRNtZAc6dErwxJ4LFSroYL
         1VswneUBbwbZBmIKgypo9sIzUnX/N7wczp/LfA0lJYriybigoQPs5+6VV6Cdh/M3Xt
         VHauJxrZ4J3lw==
From:   Chun-Kuang Hu <chunkuang.hu@kernel.org>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, CK Hu <ck.hu@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>
Subject: [PATCH v2 1/5] drm/mediatek: Remove redundant file including
Date:   Thu,  7 Jan 2021 07:17:25 +0800
Message-Id: <20210106231729.17173-2-chunkuang.hu@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210106231729.17173-1-chunkuang.hu@kernel.org>
References: <20210106231729.17173-1-chunkuang.hu@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: CK Hu <ck.hu@mediatek.com>

Those file includings are useless, so remove them.

Signed-off-by: CK Hu <ck.hu@mediatek.com>
Signed-off-by: Chun-Kuang Hu <chunkuang.hu@kernel.org>
---
 drivers/gpu/drm/mediatek/mtk_drm_ddp.h | 2 --
 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 2 --
 2 files changed, 4 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp.h b/drivers/gpu/drm/mediatek/mtk_drm_ddp.h
index 6b691a57be4a..a1ee21d15334 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp.h
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp.h
@@ -6,8 +6,6 @@
 #ifndef MTK_DRM_DDP_H
 #define MTK_DRM_DDP_H
 
-#include "mtk_drm_ddp_comp.h"
-
 struct regmap;
 struct device;
 struct mtk_disp_mutex;
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 8514d68bde32..25a24f69b986 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -10,7 +10,6 @@
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/pm_runtime.h>
-#include <linux/soc/mediatek/mtk-mmsys.h>
 #include <linux/dma-mapping.h>
 
 #include <drm/drm_atomic.h>
@@ -26,7 +25,6 @@
 #include <drm/drm_vblank.h>
 
 #include "mtk_drm_crtc.h"
-#include "mtk_drm_ddp.h"
 #include "mtk_drm_ddp_comp.h"
 #include "mtk_drm_drv.h"
 #include "mtk_drm_gem.h"
-- 
2.17.1

