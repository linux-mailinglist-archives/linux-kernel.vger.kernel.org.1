Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBCB2F49F7
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 12:29:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbhAMLWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 06:22:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:40996 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728179AbhAMLVq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 06:21:46 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CA0A7AF16;
        Wed, 13 Jan 2021 11:21:04 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Paul Zimmerman <Paul.Zimmerman@synopsys.com>,
        Felipe Balbi <balbi@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Hudson <skrll@netbsd.org>, linux-usb@vger.kernel.org,
        Minas Harutyunyan <hminas@synopsys.com>
Cc:     linux@roeck-us.net, dianders@chromium.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] usb: dwc2: Do not update data length if it is 0 on inbound transfers
Date:   Wed, 13 Jan 2021 12:20:49 +0100
Message-Id: <20210113112052.17063-2-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210113112052.17063-1-nsaenzjulienne@suse.de>
References: <20210113112052.17063-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

The DWC2 documentation states that transfers with zero data length should
set the number of packets to 1 and the transfer length to 0. This is not
currently the case for inbound transfers: the transfer length is set to
the maximum packet length. This can have adverse effects if the chip
actually does transfer data as it is programmed to do. Follow chip
documentation and keep the transfer length set to 0 in that situation.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Fixes: 56f5b1cff22a1 ("staging: Core files for the DWC2 driver")
Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Tested-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 drivers/usb/dwc2/hcd.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index e9ac215b9663..fc3269f5faf1 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -1313,19 +1313,20 @@ static void dwc2_hc_start_transfer(struct dwc2_hsotg *hsotg,
 			if (num_packets > max_hc_pkt_count) {
 				num_packets = max_hc_pkt_count;
 				chan->xfer_len = num_packets * chan->max_packet;
+			} else if (chan->ep_is_in) {
+				/*
+				 * Always program an integral # of max packets
+				 * for IN transfers.
+				 * Note: This assumes that the input buffer is
+				 * aligned and sized accordingly.
+				 */
+				chan->xfer_len = num_packets * chan->max_packet;
 			}
 		} else {
 			/* Need 1 packet for transfer length of 0 */
 			num_packets = 1;
 		}
 
-		if (chan->ep_is_in)
-			/*
-			 * Always program an integral # of max packets for IN
-			 * transfers
-			 */
-			chan->xfer_len = num_packets * chan->max_packet;
-
 		if (chan->ep_type == USB_ENDPOINT_XFER_INT ||
 		    chan->ep_type == USB_ENDPOINT_XFER_ISOC)
 			/*
-- 
2.29.2

