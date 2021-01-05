Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BACF12EA3B8
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 04:09:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbhAEDHy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 22:07:54 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:60829 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727458AbhAEDHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 22:07:52 -0500
X-UUID: 1faa70c1461a42378ff861de30b47ff4-20210105
X-UUID: 1faa70c1461a42378ff861de30b47ff4-20210105
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <yongqiang.niu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1192603702; Tue, 05 Jan 2021 11:06:51 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs05n2.mediatek.inc (172.21.101.140) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 5 Jan 2021 11:06:49 +0800
Received: from localhost.localdomain (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 5 Jan 2021 11:06:48 +0800
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
Subject: [PATCH v4, 09/10] soc: mediatek: mmsys: Use function call for setting mmsys ovl mout register
Date:   Tue, 5 Jan 2021 11:06:32 +0800
Message-ID: <1609815993-22744-10-git-send-email-yongqiang.niu@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1609815993-22744-1-git-send-email-yongqiang.niu@mediatek.com>
References: <1609815993-22744-1-git-send-email-yongqiang.niu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use function call for setting mmsys ovl mout register

Signed-off-by: Yongqiang Niu <yongqiang.niu@mediatek.com>
---
 drivers/soc/mediatek/mmsys/mtk-mmsys.c | 6 ++++++
 include/linux/soc/mediatek/mtk-mmsys.h | 4 ++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/soc/mediatek/mmsys/mtk-mmsys.c b/drivers/soc/mediatek/mmsys/mtk-mmsys.c
index 075d356..34728ed 100644
--- a/drivers/soc/mediatek/mmsys/mtk-mmsys.c
+++ b/drivers/soc/mediatek/mmsys/mtk-mmsys.c
@@ -68,6 +68,9 @@ void mtk_mmsys_ddp_connect(struct device *dev,
 
 	if (funcs->sel_in)
 		funcs->sel_in(mmsys->regs, cur, next, true);
+
+	if (funcs->ovl_mout_en)
+		funcs->ovl_mout_en(mmsys->regs, cur, next, true);
 }
 EXPORT_SYMBOL_GPL(mtk_mmsys_ddp_connect);
 
@@ -86,6 +89,9 @@ void mtk_mmsys_ddp_disconnect(struct device *dev,
 
 	if (funcs->sel_in)
 		funcs->sel_in(mmsys->regs, cur, next, false);
+
+	if (funcs->ovl_mout_en)
+		funcs->ovl_mout_en(mmsys->regs, cur, next, false);
 }
 EXPORT_SYMBOL_GPL(mtk_mmsys_ddp_disconnect);
 
diff --git a/include/linux/soc/mediatek/mtk-mmsys.h b/include/linux/soc/mediatek/mtk-mmsys.h
index 2c11617..19318d2 100644
--- a/include/linux/soc/mediatek/mtk-mmsys.h
+++ b/include/linux/soc/mediatek/mtk-mmsys.h
@@ -50,6 +50,10 @@ struct mtk_mmsys_conn_funcs {
 			enum mtk_ddp_comp_id cur,
 			enum mtk_ddp_comp_id next,
 			bool enable);
+	void (*ovl_mout_en)(void __iomem *config_regs,
+			    enum mtk_ddp_comp_id cur,
+			    enum mtk_ddp_comp_id next,
+			    bool enable);
 	void (*sel_in)(void __iomem *config_regs,
 		       enum mtk_ddp_comp_id cur,
 		       enum mtk_ddp_comp_id next,
-- 
1.8.1.1.dirty

