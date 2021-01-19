Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4DC2FAE02
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 01:18:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731976AbhASAR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 19:17:59 -0500
Received: from mx2.suse.de ([195.135.220.15]:50440 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725968AbhASARp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 19:17:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 49095AB9F;
        Tue, 19 Jan 2021 00:17:03 +0000 (UTC)
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     gregkh@linuxfoundation.org
Cc:     balbi@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, dave@stgolabs.net,
        Davidlohr Bueso <dbueso@suse.de>
Subject: [PATCH] USB: gadget: udc: Process disconnect synchronously
Date:   Mon, 18 Jan 2021 16:16:53 -0800
Message-Id: <20210119001653.127975-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the comment in usb_disconnect() hints, do not defer the
disconnect processing, and instead just do it directly in
the irq handler. This allows the driver to avoid using a
nowadays deprecated tasklet.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
---
 drivers/usb/gadget/udc/snps_udc_core.c | 30 +++-----------------------
 1 file changed, 3 insertions(+), 27 deletions(-)

diff --git a/drivers/usb/gadget/udc/snps_udc_core.c b/drivers/usb/gadget/udc/snps_udc_core.c
index 6c726d2e1788..d046c09fa566 100644
--- a/drivers/usb/gadget/udc/snps_udc_core.c
+++ b/drivers/usb/gadget/udc/snps_udc_core.c
@@ -36,7 +36,6 @@
 #include <asm/unaligned.h>
 #include "amd5536udc.h"
 
-static void udc_tasklet_disconnect(unsigned long);
 static void udc_setup_endpoints(struct udc *dev);
 static void udc_soft_reset(struct udc *dev);
 static struct udc_request *udc_alloc_bna_dummy(struct udc_ep *ep);
@@ -95,9 +94,6 @@ static struct timer_list udc_pollstall_timer;
 static int stop_pollstall_timer;
 static DECLARE_COMPLETION(on_pollstall_exit);
 
-/* tasklet for usb disconnect */
-static DECLARE_TASKLET_OLD(disconnect_tasklet, udc_tasklet_disconnect);
-
 /* endpoint names used for print */
 static const char ep0_string[] = "ep0in";
 static const struct {
@@ -1637,6 +1633,8 @@ static void usb_connect(struct udc *dev)
  */
 static void usb_disconnect(struct udc *dev)
 {
+	u32 tmp;
+
 	/* Return if already disconnected */
 	if (!dev->connected)
 		return;
@@ -1648,23 +1646,6 @@ static void usb_disconnect(struct udc *dev)
 	/* mask interrupts */
 	udc_mask_unused_interrupts(dev);
 
-	/* REVISIT there doesn't seem to be a point to having this
-	 * talk to a tasklet ... do it directly, we already hold
-	 * the spinlock needed to process the disconnect.
-	 */
-
-	tasklet_schedule(&disconnect_tasklet);
-}
-
-/* Tasklet for disconnect to be outside of interrupt context */
-static void udc_tasklet_disconnect(unsigned long par)
-{
-	struct udc *dev = udc;
-	u32 tmp;
-
-	DBG(dev, "Tasklet disconnect\n");
-	spin_lock_irq(&dev->lock);
-
 	if (dev->driver) {
 		spin_unlock(&dev->lock);
 		dev->driver->disconnect(&dev->gadget);
@@ -1673,13 +1654,10 @@ static void udc_tasklet_disconnect(unsigned long par)
 		/* empty queues */
 		for (tmp = 0; tmp < UDC_EP_NUM; tmp++)
 			empty_req_queue(&dev->ep[tmp]);
-
 	}
 
 	/* disable ep0 */
-	ep_init(dev->regs,
-			&dev->ep[UDC_EP0IN_IX]);
-
+	ep_init(dev->regs, &dev->ep[UDC_EP0IN_IX]);
 
 	if (!soft_reset_occured) {
 		/* init controller by soft reset */
@@ -1695,8 +1673,6 @@ static void udc_tasklet_disconnect(unsigned long par)
 		tmp = AMD_ADDBITS(tmp, UDC_DEVCFG_SPD_FS, UDC_DEVCFG_SPD);
 		writel(tmp, &dev->regs->cfg);
 	}
-
-	spin_unlock_irq(&dev->lock);
 }
 
 /* Reset the UDC core */
-- 
2.26.2

