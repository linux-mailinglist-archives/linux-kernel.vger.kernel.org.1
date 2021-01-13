Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9B9E2F420A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 03:49:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728665AbhAMCtB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 21:49:01 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:31952 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728602AbhAMCs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 21:48:59 -0500
X-UUID: 2755d58cb4134bf7b49d47969534faa9-20210113
X-UUID: 2755d58cb4134bf7b49d47969534faa9-20210113
Received: from mtkcas35.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chunfeng.yun@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1659275320; Wed, 13 Jan 2021 10:42:50 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 MTKMBS31N2.mediatek.inc (172.27.4.87) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 13 Jan 2021 10:42:48 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 13 Jan 2021 10:42:47 +0800
From:   Chunfeng Yun <chunfeng.yun@mediatek.com>
To:     Felipe Balbi <balbi@kernel.org>
CC:     Florian Fainelli <f.fainelli@gmail.com>,
        Al Cooper <alcooperx@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-usb@vger.kernel.org>,
        <bcm-kernel-feedback-list@broadcom.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>
Subject: [PATCH RESEND v4 05/11] usb: gadget: bdc: fix check warning of block comments alignment
Date:   Wed, 13 Jan 2021 10:42:22 +0800
Message-ID: <1610505748-30616-5-git-send-email-chunfeng.yun@mediatek.com>
X-Mailer: git-send-email 1.8.1.1.dirty
In-Reply-To: <1610505748-30616-1-git-send-email-chunfeng.yun@mediatek.com>
References: <1610505748-30616-1-git-send-email-chunfeng.yun@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: BCD91CF0E5005D3CE8CAECC4BDB3E6CE2EE9B78D141FBD94DA72A261EC228A0D2000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix the warning:
  WARNING:BLOCK_COMMENT_STYLE:
  Block comments should align the * on each line

Cc: Florian Fainelli <f.fainelli@gmail.com>
Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---
v4 resend: base on kernel 5.11-rc1
v4: no changes, but rebase on kernel 5.10-rc1
v3: add acked-by Florian
v2: add Cc Florian
---
 drivers/usb/gadget/udc/bdc/bdc.h     | 2 +-
 drivers/usb/gadget/udc/bdc/bdc_ep.c  | 2 +-
 drivers/usb/gadget/udc/bdc/bdc_udc.c | 6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/gadget/udc/bdc/bdc.h b/drivers/usb/gadget/udc/bdc/bdc.h
index fcba77e42fd1..c0ee735bd887 100644
--- a/drivers/usb/gadget/udc/bdc/bdc.h
+++ b/drivers/usb/gadget/udc/bdc/bdc.h
@@ -35,7 +35,7 @@
 /*
  * Maximum size of ep0 response buffer for ch9 requests,
  * the set_sel request uses 6 so far, the max.
-*/
+ */
 #define EP0_RESPONSE_BUFF  6
 /* Start with SS as default */
 #define EP0_MAX_PKT_SIZE 512
diff --git a/drivers/usb/gadget/udc/bdc/bdc_ep.c b/drivers/usb/gadget/udc/bdc/bdc_ep.c
index 44f3a122546d..3fb36c8454fc 100644
--- a/drivers/usb/gadget/udc/bdc/bdc_ep.c
+++ b/drivers/usb/gadget/udc/bdc/bdc_ep.c
@@ -68,7 +68,7 @@ static void ep_bd_list_free(struct bdc_ep *ep, u32 num_tabs)
 		 * check if the bd_table struct is allocated ?
 		 * if yes, then check if bd memory has been allocated, then
 		 * free the dma_pool and also the bd_table struct memory
-		*/
+		 */
 		bd_table = bd_list->bd_table_array[index];
 		dev_dbg(bdc->dev, "bd_table:%p index:%d\n", bd_table, index);
 		if (!bd_table) {
diff --git a/drivers/usb/gadget/udc/bdc/bdc_udc.c b/drivers/usb/gadget/udc/bdc/bdc_udc.c
index 248426a3e88a..0c1ab9548786 100644
--- a/drivers/usb/gadget/udc/bdc/bdc_udc.c
+++ b/drivers/usb/gadget/udc/bdc/bdc_udc.c
@@ -164,7 +164,7 @@ static void bdc_func_wake_timer(struct work_struct *work)
 	/*
 	 * Check if host has started transferring on endpoints
 	 * FUNC_WAKE_ISSUED is cleared when transfer has started after resume
-	*/
+	 */
 	if (bdc->devstatus & FUNC_WAKE_ISSUED) {
 		dev_dbg(bdc->dev, "FUNC_WAKE_ISSUED FLAG IS STILL SET\n");
 		/* flag is still set, so again send func wake */
@@ -205,7 +205,7 @@ static void handle_link_state_change(struct bdc *bdc, u32 uspc)
 				 * if not then send function wake again every
 				 * TNotification secs until host initiates
 				 * transfer to BDC, USB3 spec Table 8.13
-				*/
+				 */
 				schedule_delayed_work(
 						&bdc->func_wake_notify,
 						msecs_to_jiffies(BDC_TNOTIFY));
@@ -379,7 +379,7 @@ static int bdc_udc_start(struct usb_gadget *gadget,
 	 * Run the controller from here and when BDC is connected to
 	 * Host then driver will receive a USPC SR with VBUS present
 	 * and then driver will do a softconnect.
-	*/
+	 */
 	ret = bdc_run(bdc);
 	if (ret) {
 		dev_err(bdc->dev, "%s bdc run fail\n", __func__);
-- 
2.18.0

