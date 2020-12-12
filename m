Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76B4B2D846A
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Dec 2020 05:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438250AbgLLEPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Dec 2020 23:15:01 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:38974 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S2438215AbgLLEOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Dec 2020 23:14:09 -0500
X-UUID: 4be8dca878254badb6f51b97d3183b8a-20201212
X-UUID: 4be8dca878254badb6f51b97d3183b8a-20201212
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 131028312; Sat, 12 Dec 2020 12:12:29 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 12 Dec 2020 12:12:08 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 12 Dec 2020 12:12:08 +0800
From:   Yongqiang Niu <yongqiang.niu@mediatek.com>
To:     CK Hu <ck.hu@mediatek.com>, Philipp Zabel <p.zabel@pengutronix.de>,
        "Rob Herring" <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        "Mark Rutland" <mark.rutland@arm.com>,
        <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [PATCH v2, 10/17] drm/mediatek: fix aal size config
Date:   Sat, 12 Dec 2020 12:11:50 +0800
Message-ID: <1607746317-4696-11-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1607746317-4696-1-git-send-email-yongqiang.niu@mediatek.com>
References: <1607746317-4696-1-git-send-email-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix aal size config

Fixes: 0664d1392c26 (drm/mediatek: Add AAL engine basic function)
Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
index be61d11..e7d481e0 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_ddp_comp.c
@@ -33,8 +33,13 @@
 #define DISP_REG_UFO_START			0x0000
 
 #define DISP_AAL_EN				0x0000
+#define DISP_AAL_CFG				0x0020
+#define AAL_RELAY_MODE					BIT(0)
+#define AAL_ENGINE_EN					BIT(1)
 #define DISP_AAL_SIZE				0x0030
 
+#define DISP_AAL_OUTPUT_SIZE			0x04d8
+
 #define DISP_CCORR_EN				0x0000
 #define CCORR_EN				BIT(0)
 #define DISP_CCORR_CFG				0x0020
@@ -184,7 +189,11 @@ static void mtk_aal_config(struct mtk_ddp_comp *comp, unsigned int w,
 			   unsigned int h, unsigned int vrefresh,
 			   unsigned int bpc, struct cmdq_pkt *cmdq_pkt)
 {
-	mtk_ddp_write(cmdq_pkt, h << 16 | w, comp, DISP_AAL_SIZE);
+	mtk_ddp_write(cmdq_pkt, w << 16 | h, comp, DISP_AAL_SIZE);
+	mtk_ddp_write(cmdq_pkt, w << 16 | h, comp, DISP_AAL_OUTPUT_SIZE);
+
+	mtk_ddp_write_mask(NULL, AAL_RELAY_MODE, comp, DISP_AAL_CFG,
+			   AAL_RELAY_MODE | AAL_ENGINE_EN);
 }
 
 static void mtk_aal_start(struct mtk_ddp_comp *comp)
-- 
1.8.1.1.dirty

