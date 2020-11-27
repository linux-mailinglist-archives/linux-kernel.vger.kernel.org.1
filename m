Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 889F42C638A
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 12:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729095AbgK0LCV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 06:02:21 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:54082 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726952AbgK0LCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 06:02:21 -0500
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: eballetbo)
        with ESMTPSA id 269BE1F461C9
From:   Enric Balletbo i Serra <enric.balletbo@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     matthias.bgg@gmail.com, drinkcat@chromium.org, hsinyi@chromium.org,
        Collabora Kernel ML <kernel@collabora.com>,
        CK Hu <ck.hu@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH] drm/mediatek: Use correct aliases name for ovl
Date:   Fri, 27 Nov 2020 12:02:04 +0100
Message-Id: <20201127110204.1984789-1-enric.balletbo@collabora.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Aliases property name must include only lowercase and '-', so fix this
in the driver, so we're not tempted to do "ovl_2l0 = &ovl_2l0" in the
device-tree instead of the right one which is "ovl-2l0 = &ovl_2l0".

Fixes: dd8feb2262d9 ("drm/mediatek: add component OVL_2L1")
Fixes: b17bdd0d7a73 ("drm/mediatek: add component OVL_2L0")
Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
index 8eba44be3a8a..3064eac1a750 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
@@ -359,7 +359,7 @@ static const struct mtk_ddp_comp_funcs ddp_ufoe = {
 
 static const char * const mtk_ddp_comp_stem[MTK_DDP_COMP_TYPE_MAX] = {
 	[MTK_DISP_OVL] = "ovl",
-	[MTK_DISP_OVL_2L] = "ovl_2l",
+	[MTK_DISP_OVL_2L] = "ovl-2l",
 	[MTK_DISP_RDMA] = "rdma",
 	[MTK_DISP_WDMA] = "wdma",
 	[MTK_DISP_COLOR] = "color",
-- 
2.29.2

