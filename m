Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 036D51F7800
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jun 2020 14:40:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbgFLMkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Jun 2020 08:40:17 -0400
Received: from m17617.mail.qiye.163.com ([59.111.176.17]:49190 "EHLO
        m17617.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726085AbgFLMkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 08:40:17 -0400
Received: from njvxl5505.vivo.xyz (unknown [157.0.31.125])
        by m17617.mail.qiye.163.com (Hmail) with ESMTPA id B7F9426177A;
        Fri, 12 Jun 2020 20:40:13 +0800 (CST)
From:   Bernard Zhao <bernard@vivo.com>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com, Bernard Zhao <bernard@vivo.com>
Subject: [PATCH] drm/mediatek: remove unnecessary conversion to bool
Date:   Fri, 12 Jun 2020 20:40:06 +0800
Message-Id: <20200612124007.4990-1-bernard@vivo.com>
X-Mailer: git-send-email 2.17.1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZQx5LTBoeH0JCHhodVkpOQkpCTU5NSkhCTEJVEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKTFVKS0tZBg++
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PAg6PSo*GDg5Mws9Dw8LMxYz
        SS5PFApVSlVKTkJKQk1OTUpPSExLVTMWGhIXVRkeCRUaCR87DRINFFUYFBZFWVdZEgtZQVlKTkxV
        S1VISlVKSU5ZV1kIAVlBSUtPSzcG
X-HM-Tid: 0a72a88b7f4c9375kuwsb7f9426177a
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In function mtk_dsi_clk_hs_state, remove unnecessary conversion
to bool return, this change is to make the code a bit readable.

Signed-off-by: Bernard Zhao <bernard@vivo.com>
---
 drivers/gpu/drm/mediatek/mtk_dsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_dsi.c b/drivers/gpu/drm/mediatek/mtk_dsi.c
index 270bf22c98fe..4491e64b3f06 100644
--- a/drivers/gpu/drm/mediatek/mtk_dsi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dsi.c
@@ -319,7 +319,7 @@ static bool mtk_dsi_clk_hs_state(struct mtk_dsi *dsi)
 	u32 tmp_reg1;
 
 	tmp_reg1 = readl(dsi->regs + DSI_PHY_LCCON);
-	return ((tmp_reg1 & LC_HS_TX_EN) == 1) ? true : false;
+	return ((tmp_reg1 & LC_HS_TX_EN) == 1);
 }
 
 static void mtk_dsi_clk_hs_mode(struct mtk_dsi *dsi, bool enter)
-- 
2.17.1

