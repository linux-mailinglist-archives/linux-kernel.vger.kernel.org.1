Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9E692E0829
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 10:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726168AbgLVJfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 04:35:51 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:47521 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725897AbgLVJfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 04:35:45 -0500
X-UUID: e0875460767e42219c5c57c658387b34-20201222
X-UUID: e0875460767e42219c5c57c658387b34-20201222
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 163910702; Tue, 22 Dec 2020 17:34:57 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 22 Dec 2020 17:34:53 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 22 Dec 2020 17:34:52 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Ikjoon Jang <ikjn@chromium.org>
CC:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Tianping Fang <tianping.fang@mediatek.com>,
        Zhanyong Wang <zhangyong.wang@mediatek.com>,
        <linux-mediatek@lists.infradead.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH v3 3/5] usb: xhci-mtk: fix random remote wakeup
Date:   Tue, 22 Dec 2020 17:34:40 +0800
Message-ID: <1608629682-8535-3-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1608629682-8535-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1608629682-8535-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: DB305DF1703578D7A07C42CC68D02DC8FE8162C6711BAE8B5815CD4297C816F72000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wakeup_signal will toggle status according to ssusb_ip_sleep
signal after debounc time, add a delay time to avoid spurious
wakeup event.

Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
---
v3: new patch
---
 drivers/usb/host/xhci-mtk.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/host/xhci-mtk.c b/drivers/usb/host/xhci-mtk.c
index 565ce4c16206..34bd3de090b1 100755
--- a/drivers/usb/host/xhci-mtk.c
+++ b/drivers/usb/host/xhci-mtk.c
@@ -172,7 +172,10 @@ static int xhci_mtk_host_disable(struct xhci_hcd_mtk *mtk)
 	if (ret) {
 		dev_err(mtk->dev, "ip sleep failed!!!\n");
 		return ret;
+	} else {
+		usleep_range(200, 250);
 	}
+
 	return 0;
 }
 
-- 
2.18.0

