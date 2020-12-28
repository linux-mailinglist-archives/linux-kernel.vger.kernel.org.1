Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B5252E3525
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 09:38:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgL1IiV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 03:38:21 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:57864 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726602AbgL1IiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 03:38:20 -0500
X-UUID: 53f74bec2cee4880a46433ae295a2791-20201228
X-UUID: 53f74bec2cee4880a46433ae295a2791-20201228
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 959070899; Mon, 28 Dec 2020 16:37:20 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 28 Dec 2020 16:38:28 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 28 Dec 2020 16:38:26 +0800
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
        Yongqiang Niu <yongqiang.niu@mediatek.com>
Subject: [PATCH v3, 7/8] soc: mediatek: mmsys: Use function call for setting mmsys ovl mout register
Date:   Mon, 28 Dec 2020 16:37:09 +0800
Message-ID: <1609144630-14721-8-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1609144630-14721-1-git-send-email-yongqiang.niu@mediatek.com>
References: <1609144630-14721-1-git-send-email-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use function call for setting mmsys ovl mout register

Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
---
 drivers/soc/mediatek/mmsys/mtk-mmsys.c | 20 ++++++++++++++++++++
 include/linux/soc/mediatek/mtk-mmsys.h |  3 +++
 2 files changed, 23 insertions(+)

diff --git a/drivers/soc/mediatek/mmsys/mtk-mmsys.c b/drivers/soc/mediatek/mmsys/mtk-mmsys.c
index dae665b..ea36a11 100644
--- a/drivers/soc/mediatek/mmsys/mtk-mmsys.c
+++ b/drivers/soc/mediatek/mmsys/mtk-mmsys.c
@@ -74,6 +74,17 @@ void mtk_mmsys_ddp_connect(struct device *dev,
 		reg = readl_relaxed(mmsys->regs + addr) | value;
 		writel_relaxed(reg, mmsys->regs + addr);
 	}
+
+	if (!funcs->ovl_mout_en)
+		return;
+
+	if (funcs->ovl_mout_en) {
+		value = funcs->ovl_mout_en(cur, next, &addr);
+		if (value) {
+			reg = readl_relaxed(mmsys->regs + addr) | value;
+			writel_relaxed(reg, mmsys->regs + addr);
+		}
+	}
 }
 EXPORT_SYMBOL_GPL(mtk_mmsys_ddp_connect);
 
@@ -99,6 +110,15 @@ void mtk_mmsys_ddp_disconnect(struct device *dev,
 		reg = readl_relaxed(mmsys->regs + addr) & ~value;
 		writel_relaxed(reg, mmsys->regs + addr);
 	}
+
+	if (!funcs->ovl_mout_en)
+		return;
+
+	value = funcs->ovl_mout_en(cur, next, &addr);
+	if (value) {
+		reg = readl_relaxed(mmsys->regs + addr) & ~value;
+		writel_relaxed(reg, mmsys->regs + addr);
+	}
 }
 EXPORT_SYMBOL_GPL(mtk_mmsys_ddp_disconnect);
 
diff --git a/include/linux/soc/mediatek/mtk-mmsys.h b/include/linux/soc/mediatek/mtk-mmsys.h
index aa4f60e..220203d 100644
--- a/include/linux/soc/mediatek/mtk-mmsys.h
+++ b/include/linux/soc/mediatek/mtk-mmsys.h
@@ -49,6 +49,9 @@ struct mtk_mmsys_conn_funcs {
 	u32 (*mout_en)(enum mtk_ddp_comp_id cur,
 		       enum mtk_ddp_comp_id next,
 		       unsigned int *addr);
+	u32 (*ovl_mout_en)(enum mtk_ddp_comp_id cur,
+			   enum mtk_ddp_comp_id next,
+			   unsigned int *addr);
 	u32 (*sel_in)(enum mtk_ddp_comp_id cur,
 		      enum mtk_ddp_comp_id next,
 		      unsigned int *addr);
-- 
1.8.1.1.dirty

