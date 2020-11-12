Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45F742B00B7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 09:00:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727356AbgKLIAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 03:00:34 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:14477 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725941AbgKLH7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 02:59:53 -0500
X-UUID: 571e430957e34063b705853a36f0df28-20201112
X-UUID: 571e430957e34063b705853a36f0df28-20201112
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 741548777; Thu, 12 Nov 2020 15:59:41 +0800
Received: from mtkcas08.mediatek.inc (172.21.101.126) by
 MTKMBS31DR.mediatek.inc (172.27.6.102) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 12 Nov 2020 15:59:39 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas08.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 12 Nov 2020 15:59:38 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Al Cooper <alcooperx@gmail.com>, <linux-usb@vger.kernel.org>,
        <bcm-kernel-feedback-list@broadcom.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v4 04/11] usb: gadget: bdc: fix warning of embedded function name
Date:   Thu, 12 Nov 2020 15:59:27 +0800
Message-ID: <1605167974-28502-4-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1605167974-28502-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1605167974-28502-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 022E7E6078BD26F695A7301EE66C7BA6C0C23EC1CEE97316EC37F3FCF984DF5B2000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use '"%s...", __func__' to replace embedded function name

Cc: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---
v4: no changes, but rebase on kernel 5.10-rc1
v3: add acked-by Florian
v2: add Cc Florian
---
 drivers/usb/gadget/udc/bdc/bdc_dbg.c | 2 +-
 drivers/usb/gadget/udc/bdc/bdc_ep.c  | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/gadget/udc/bdc/bdc_dbg.c b/drivers/usb/gadget/udc/bdc/bdc_dbg.c
index 7ba7448ad743..9c03e13308ca 100644
--- a/drivers/usb/gadget/udc/bdc/bdc_dbg.c
+++ b/drivers/usb/gadget/udc/bdc/bdc_dbg.c
@@ -68,7 +68,7 @@ void bdc_dbg_srr(struct bdc *bdc, u32 srr_num)
 
 	sr = bdc->srr.sr_bds;
 	addr = bdc->srr.dma_addr;
-	dev_vdbg(bdc->dev, "bdc_dbg_srr sr:%p dqp_index:%d\n",
+	dev_vdbg(bdc->dev, "%s sr:%p dqp_index:%d\n", __func__,
 						sr, bdc->srr.dqp_index);
 	for (i = 0; i < NUM_SR_ENTRIES; i++) {
 		sr = &bdc->srr.sr_bds[i];
diff --git a/drivers/usb/gadget/udc/bdc/bdc_ep.c b/drivers/usb/gadget/udc/bdc/bdc_ep.c
index 76463de75595..44f3a122546d 100644
--- a/drivers/usb/gadget/udc/bdc/bdc_ep.c
+++ b/drivers/usb/gadget/udc/bdc/bdc_ep.c
@@ -756,7 +756,7 @@ static int ep_dequeue(struct bdc_ep *ep, struct bdc_req *req)
 
 	dev_dbg(bdc->dev, "%s ep:%s start:%d end:%d\n",
 					__func__, ep->name, start_bdi, end_bdi);
-	dev_dbg(bdc->dev, "ep_dequeue ep=%p ep->desc=%p\n",
+	dev_dbg(bdc->dev, "%s ep=%p ep->desc=%p\n", __func__,
 						ep, (void *)ep->usb_ep.desc);
 	/* if still connected, stop the ep to see where the HW is ? */
 	if (!(bdc_readl(bdc->regs, BDC_USPC) & BDC_PST_MASK)) {
@@ -1858,12 +1858,12 @@ static int bdc_gadget_ep_enable(struct usb_ep *_ep,
 	int ret;
 
 	if (!_ep || !desc || desc->bDescriptorType != USB_DT_ENDPOINT) {
-		pr_debug("bdc_gadget_ep_enable invalid parameters\n");
+		pr_debug("%s invalid parameters\n", __func__);
 		return -EINVAL;
 	}
 
 	if (!desc->wMaxPacketSize) {
-		pr_debug("bdc_gadget_ep_enable missing wMaxPacketSize\n");
+		pr_debug("%s missing wMaxPacketSize\n", __func__);
 		return -EINVAL;
 	}
 
-- 
2.18.0

