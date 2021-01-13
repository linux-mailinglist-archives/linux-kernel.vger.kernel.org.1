Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABDB72F49F4
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 12:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728360AbhAMLVw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 06:21:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:41030 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727753AbhAMLVs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 06:21:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A616FAF24;
        Wed, 13 Jan 2021 11:21:05 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Paul Zimmerman <Paul.Zimmerman@synopsys.com>,
        Felipe Balbi <balbi@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Hudson <skrll@netbsd.org>, linux-usb@vger.kernel.org,
        Minas Harutyunyan <hminas@synopsys.com>,
        Paul Zimmerman <paulz@synopsys.com>
Cc:     linux@roeck-us.net, dianders@chromium.org,
        Boris ARZUR <boris@konbu.org>,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] usb: dwc2: Abort transaction after errors with unknown reason
Date:   Wed, 13 Jan 2021 12:20:50 +0100
Message-Id: <20210113112052.17063-3-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210113112052.17063-1-nsaenzjulienne@suse.de>
References: <20210113112052.17063-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

In some situations, the following error messages are reported.

dwc2 ff540000.usb: dwc2_hc_chhltd_intr_dma: Channel 1 - ChHltd set, but reason is unknown
dwc2 ff540000.usb: hcint 0x00000002, intsts 0x04000021

This is sometimes followed by:

dwc2 ff540000.usb: dwc2_update_urb_state_abn(): trimming xfer length

and then:

WARNING: CPU: 0 PID: 0 at kernel/v4.19/drivers/usb/dwc2/hcd.c:2913
			dwc2_assign_and_init_hc+0x98c/0x990

The warning suggests that an odd buffer address is to be used for DMA.

After an error is observed, the receive buffer may be full
(urb->actual_length >= urb->length). However, the urb is still left in
the queue unless three errors were observed in a row. When it is queued
again, the dwc2 hcd code translates this into a 1-block transfer.
If urb->actual_length (ie the total expected receive length) is not
DMA-aligned, the buffer pointer programmed into the chip will be
unaligned. This results in the observed warning.

To solve the problem, abort input transactions after an error with
unknown cause if the entire packet was already received. This may be
a bit drastic, but we don't really know why the transfer was aborted
even though the entire packet was received. Aborting the transfer in
this situation is less risky than accepting a potentially corrupted
packet.

With this patch in place, the 'ChHltd set' and 'trimming xfer length'
messages are still observed, but there are no more transfer attempts
with odd buffer addresses.

Cc: Boris ARZUR <boris@konbu.org>
Cc: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Fixes: 151d0cbdbe860 ("usb: dwc2: make the scheduler handle excessive NAKs better")
Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Tested-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 drivers/usb/dwc2/hcd_intr.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/usb/dwc2/hcd_intr.c b/drivers/usb/dwc2/hcd_intr.c
index a052d39b4375..12819e019e13 100644
--- a/drivers/usb/dwc2/hcd_intr.c
+++ b/drivers/usb/dwc2/hcd_intr.c
@@ -1977,6 +1977,18 @@ static void dwc2_hc_chhltd_intr_dma(struct dwc2_hsotg *hsotg,
 		qtd->error_count++;
 		dwc2_update_urb_state_abn(hsotg, chan, chnum, qtd->urb,
 					  qtd, DWC2_HC_XFER_XACT_ERR);
+		/*
+		 * We can get here after a completed transaction
+		 * (urb->actual_length >= urb->length) which was not reported
+		 * as completed. If that is the case, and we do not abort
+		 * the transfer, a transfer of size 0 will be enqueued
+		 * subsequently. If urb->actual_length is not DMA-aligned,
+		 * the buffer will then point to an unaligned address, and
+		 * the resulting behavior is undefined. Bail out in that
+		 * situation.
+		 */
+		if (qtd->urb->actual_length >= qtd->urb->length)
+			qtd->error_count = 3;
 		dwc2_hcd_save_data_toggle(hsotg, chan, chnum, qtd);
 		dwc2_halt_channel(hsotg, chan, qtd, DWC2_HC_XFER_XACT_ERR);
 	}
-- 
2.29.2

