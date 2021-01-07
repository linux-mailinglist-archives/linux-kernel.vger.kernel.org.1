Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 789172EC8FA
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jan 2021 04:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727332AbhAGDMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 22:12:48 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:56438 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727273AbhAGDMr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 22:12:47 -0500
X-UUID: 247e50b8d8f44adeb7fa56da9f7ac998-20210107
X-UUID: 247e50b8d8f44adeb7fa56da9f7ac998-20210107
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 787687370; Thu, 07 Jan 2021 11:11:34 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 7 Jan 2021 11:11:32 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 7 Jan 2021 11:11:32 +0800
From:   Yongqiang Niu <yongqiang.niu@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Mark Rutland <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [PATCH v9, 09/11] drm/mediatek: enable dither function
Date:   Thu, 7 Jan 2021 11:11:19 +0800
Message-ID: <1609989081-29353-10-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1609989081-29353-1-git-send-email-yongqiang.niu@mediatek.com>
References: <1609989081-29353-1-git-send-email-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

for 5 or 6 bpc panel, we need enable dither function
to improve the display quality

Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 38 ++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
index 03589c9..81ed076 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
@@ -53,7 +53,9 @@
 #define DITHER_EN				BIT(0)
 #define DISP_DITHER_CFG				0x0020
 #define DITHER_RELAY_MODE			BIT(0)
+#define DITHER_ENGINE_EN			BIT(1)
 #define DISP_DITHER_SIZE			0x0030
+#define DITHER_REG(idx)				(0x100 + (idx) * 4)
 
 #define LUT_10BIT_MASK				0x03ff
 
@@ -258,8 +260,42 @@ static void mtk_dither_config(struct mtk_ddp_comp *comp, unsigned int w,
 			      unsigned int h, unsigned int vrefresh,
 			      unsigned int bpc, struct cmdq_pkt *cmdq_pkt)
 {
+	bool enable = true;
+
+	const u32 dither_setting[] = {
+		0x00000000, /* 5 */
+		0x00003002, /* 6 */
+		0x00000000, /* 7 */
+		0x00000000, /* 8 */
+		0x00000000, /* 9 */
+		0x00000000, /* 10 */
+		0x00000000, /* 11 */
+		0x00000011, /* 12 */
+		0x00000000, /* 13 */
+		0x00000000, /* 14 */
+	};
+
+	if (bpc == 6) {
+		mtk_ddp_write(cmdq_pkt, 0x40400001, comp, DITHER_REG(15));
+		mtk_ddp_write(cmdq_pkt, 0x40404040, comp, DITHER_REG(16));
+	} else if (bpc == 5) {
+		mtk_ddp_write(cmdq_pkt, 0x50500001, comp, DITHER_REG(15));
+		mtk_ddp_write(cmdq_pkt, 0x50504040, comp, DITHER_REG(16));
+	} else {
+		enable = false;
+	}
+
+	if (enable) {
+		u32 idx;
+
+		for (idx = 0; idx < ARRAY_SIZE(dither_setting); idx++)
+			mtk_ddp_write(cmdq_pkt, dither_setting[idx], comp,
+				      DITHER_REG(idx + 5));
+	}
+
 	mtk_ddp_write(cmdq_pkt, h << 16 | w, comp, DISP_DITHER_SIZE);
-	mtk_ddp_write(cmdq_pkt, DITHER_RELAY_MODE, comp, DISP_DITHER_CFG);
+	mtk_ddp_write(cmdq_pkt, enable ? DITHER_ENGINE_EN : DITHER_RELAY_MODE,
+		      comp, DISP_DITHER_CFG);
 }
 
 static void mtk_dither_start(struct mtk_ddp_comp *comp)
-- 
1.8.1.1.dirty

