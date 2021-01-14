Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C73A2F5966
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 04:42:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbhANDdz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 22:33:55 -0500
Received: from lgeamrelo13.lge.com ([156.147.23.53]:51138 "EHLO
        lgeamrelo11.lge.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726429AbhANDdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 22:33:55 -0500
X-Greylist: delayed 1799 seconds by postgrey-1.27 at vger.kernel.org; Wed, 13 Jan 2021 22:33:54 EST
Received: from unknown (HELO lgeamrelo02.lge.com) (156.147.1.126)
        by 156.147.23.53 with ESMTP; 14 Jan 2021 12:03:12 +0900
X-Original-SENDERIP: 156.147.1.126
X-Original-MAILFROM: daewoong00.kim@lge.com
Received: from unknown (HELO marvel.156.147.1.1) (10.178.35.47)
        by 156.147.1.126 with ESMTP; 14 Jan 2021 12:03:12 +0900
X-Original-SENDERIP: 10.178.35.47
X-Original-MAILFROM: daewoong00.kim@lge.com
From:   Daewoong Kim <daewoong00.kim@lge.com>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     allen.lkml@gmail.com, gustavoars@kernel.org,
        a.darwish@linutronix.de, romain.perier@gmail.com,
        dvyukov@google.com, andreyknvl@google.com, mathias.nyman@intel.com,
        gregkh@linuxfoundation.org, Daewoong Kim <daewoong00.kim@lge.com>
Subject: [PATCH 1/1] usb: xhci: setup packets don't need DMA mapping
Date:   Thu, 14 Jan 2021 11:59:07 +0900
Message-Id: <1610593147-12511-1-git-send-email-daewoong00.kim@lge.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DMA mapping of urb->setup_packet is not necessary for xHCI host
controllers. The xHCI specification says that Setup Stage TRB includes
whole Setup Data; therefore, urb->setup_dma will not be used in the xhci
HCD code.

Signed-off-by: Daewoong Kim <daewoong00.kim@lge.com>
---
 drivers/usb/core/hcd.c  | 4 +++-
 drivers/usb/host/xhci.c | 1 +
 include/linux/usb.h     | 4 ++++
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/core/hcd.c b/drivers/usb/core/hcd.c
index ad5a0f405a75..b1f9eac93f0d 100644
--- a/drivers/usb/core/hcd.c
+++ b/drivers/usb/core/hcd.c
@@ -1411,7 +1411,9 @@ int usb_hcd_map_urb_for_dma(struct usb_hcd *hcd, struct urb *urb,
 	if (usb_endpoint_xfer_control(&urb->ep->desc)) {
 		if (hcd->self.uses_pio_for_control)
 			return ret;
-		if (hcd->localmem_pool) {
+		if (hcd->self.uses_pio_for_setup_pkt) {
+			;	/* do nothing */
+		} else if (hcd->localmem_pool) {
 			ret = hcd_alloc_coherent(
 					urb->dev->bus, mem_flags,
 					&urb->setup_dma,
diff --git a/drivers/usb/host/xhci.c b/drivers/usb/host/xhci.c
index e86940571b4c..c263aee82dc0 100644
--- a/drivers/usb/host/xhci.c
+++ b/drivers/usb/host/xhci.c
@@ -643,6 +643,7 @@ int xhci_run(struct usb_hcd *hcd)
 	 */
 
 	hcd->uses_new_polling = 1;
+	hcd->self.uses_pio_for_setup_pkt = 1;
 	if (!usb_hcd_is_primary_hcd(hcd))
 		return xhci_run_finished(xhci);
 
diff --git a/include/linux/usb.h b/include/linux/usb.h
index 7d72c4e0713c..76600e8de414 100644
--- a/include/linux/usb.h
+++ b/include/linux/usb.h
@@ -430,6 +430,10 @@ struct usb_bus {
 					 * Does the host controller use PIO
 					 * for control transfers?
 					 */
+	u8 uses_pio_for_setup_pkt;	/*
+					 * Does the host controller use PIO
+					 * for setup packets?
+					 */
 	u8 otg_port;			/* 0, or number of OTG/HNP port */
 	unsigned is_b_host:1;		/* true during some HNP roleswitches */
 	unsigned b_hnp_enable:1;	/* OTG: did A-Host enable HNP? */
-- 
2.17.1

