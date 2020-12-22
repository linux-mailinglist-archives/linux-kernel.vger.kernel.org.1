Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BD702E082A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 10:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbgLVJfu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 04:35:50 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:6954 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725895AbgLVJfq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 04:35:46 -0500
X-UUID: ffee714fcebf433f9e96065ed3bd8e9f-20201222
X-UUID: ffee714fcebf433f9e96065ed3bd8e9f-20201222
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 266398425; Tue, 22 Dec 2020 17:34:54 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 MTKMBS31N1.mediatek.inc (172.27.4.69) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 22 Dec 2020 17:34:53 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 22 Dec 2020 17:34:51 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Ikjoon Jang <ikjn@chromium.org>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Tianping Fang <tianping.fang@mediatek.com>,
        Zhanyong Wang <zhangyong.wang@mediatek.com>,
        <linux-mediatek@lists.infradead.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Zhanyong Wang <zhanyong.wang@mediatek.com>
Subject: [RFC PATCH v3 2/5] usb: xhci-mtk: add mt8192 wakeup
Date:   Tue, 22 Dec 2020 17:34:39 +0800
Message-ID: <1608629682-8535-2-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1608629682-8535-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1608629682-8535-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 4E19E506E984517EAF04F3A002C9AD4C689C86BC3D595BD82BBCC7BDB91C627F2000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhanyong Wang <zhanyong.wang@mediatek.com>

need to add wakeup solution as V3
since not support presently.

Signed-off-by: Zhanyong Wang <zhanyong.wang@mediatek.com>
Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v2~v3: no changes
---
 drivers/usb/host/xhci-mtk.c | 9 +++++++++
 1 file changed, 9 insertions(+)
 mode change 100644 => 100755 drivers/usb/host/xhci-mtk.c

diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
old mode 100644
new mode 100755
index 8f321f39ab96..565ce4c16206
--- a/drivers/usb/host/xhci-mtk.c
+++ b/drivers/usb/host/xhci-mtk.c
@@ -68,9 +68,13 @@
 #define SSC_IP_SLEEP_EN	BIT(4)
 #define SSC_SPM_INT_EN		BIT(1)
 
+/* mt8192 etc */
+#define SSC_IP_SLEEP_EN_V3	BIT(6)
+
 enum ssusb_uwk_vers {
 	SSUSB_UWK_V1 = 1,
 	SSUSB_UWK_V2,
+	SSUSB_UWK_V3,
 };
 
 static int xhci_mtk_host_enable(struct xhci_hcd_mtk *mtk)
@@ -305,6 +309,11 @@ static void usb_wakeup_ip_sleep_set(struct xhci_hcd_mtk *mtk, bool enable)
 		msk = SSC_IP_SLEEP_EN | SSC_SPM_INT_EN;
 		val = enable ? msk : 0;
 		break;
+	case SSUSB_UWK_V3:
+		reg = mtk->uwk_reg_base + PERI_SSUSB_SPM_CTRL;
+		msk = SSC_IP_SLEEP_EN_V3 | SSC_SPM_INT_EN;
+		val = enable ? msk : 0;
+		break;
 	default:
 		return;
 	}
-- 
2.18.0

