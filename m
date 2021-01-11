Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFF72F0D72
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 08:48:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbhAKHpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 02:45:17 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:36036 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727669AbhAKHpP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 02:45:15 -0500
X-UUID: 096091ece4744d42bc83a839f72ac26d-20210111
X-UUID: 096091ece4744d42bc83a839f72ac26d-20210111
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 403095666; Mon, 11 Jan 2021 15:44:03 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 11 Jan 2021 15:44:01 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 11 Jan 2021 15:44:01 +0800
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
Subject: [PATCH v3, 07/15] drm/mediatek: enable OVL_LAYER_SMI_ID_EN for multi-layer usecase
Date:   Mon, 11 Jan 2021 15:43:43 +0800
Message-ID: <1610351031-21133-8-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1610351031-21133-1-git-send-email-yongqiang.niu@mediatek.com>
References: <1610351031-21133-1-git-send-email-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

enable OVL_LAYER_SMI_ID_EN for multi-layer usecase

Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
---
 drivers/gpu/drm/mediatek/mtk_disp_ovl.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
index b47c238..4934bee 100644
--- a/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
+++ b/drivers/gpu/drm/mediatek/mtk_disp_ovl.c
@@ -23,6 +23,7 @@
 #define DISP_REG_OVL_RST			0x0014
 #define DISP_REG_OVL_ROI_SIZE			0x0020
 #define DISP_REG_OVL_DATAPATH_CON		0x0024
+#define OVL_LAYER_SMI_ID_EN				BIT(0)
 #define OVL_BGCLR_SEL_IN				BIT(2)
 #define DISP_REG_OVL_ROI_BGCLR			0x0028
 #define DISP_REG_OVL_SRC_CON			0x002c
@@ -61,6 +62,7 @@ struct mtk_disp_ovl_data {
 	unsigned int gmc_bits;
 	unsigned int layer_nr;
 	bool fmt_rgb565_is_0;
+	bool smi_id_en;
 };
 
 /**
@@ -116,7 +118,17 @@ static void mtk_ovl_disable_vblank(struct mtk_ddp_comp *comp)
 
 static void mtk_ovl_start(struct mtk_ddp_comp *comp)
 {
+	struct mtk_disp_ovl *ovl = comp_to_ovl(comp);
+
 	writel_relaxed(0x1, comp->regs + DISP_REG_OVL_EN);
+
+	if(ovl->data->smi_id_en) {
+		unsigned int reg;
+
+		reg = readl(comp->regs + DISP_REG_OVL_DATAPATH_CON);
+		reg = reg | OVL_LAYER_SMI_ID_EN;
+		writel_relaxed(reg, comp->regs + DISP_REG_OVL_DATAPATH_CON);
+	}
 }
 
 static void mtk_ovl_stop(struct mtk_ddp_comp *comp)
-- 
1.8.1.1.dirty

