Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99FEC2F49F6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 12:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728367AbhAMLVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 06:21:54 -0500
Received: from mx2.suse.de ([195.135.220.15]:41060 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728292AbhAMLVs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 06:21:48 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 624B1AF2D;
        Wed, 13 Jan 2021 11:21:06 +0000 (UTC)
From:   Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
To:     Paul Zimmerman <Paul.Zimmerman@synopsys.com>,
        Felipe Balbi <balbi@ti.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Nick Hudson <skrll@netbsd.org>, linux-usb@vger.kernel.org,
        Minas Harutyunyan <hminas@synopsys.com>
Cc:     linux@roeck-us.net, dianders@chromium.org,
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] usb: dwc2: Make "trimming xfer length" a debug message
Date:   Wed, 13 Jan 2021 12:20:51 +0100
Message-Id: <20210113112052.17063-4-nsaenzjulienne@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210113112052.17063-1-nsaenzjulienne@suse.de>
References: <20210113112052.17063-1-nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guenter Roeck <linux@roeck-us.net>

With some USB network adapters, such as DM96xx, the following message
is seen for each maximum size receive packet.

dwc2 ff540000.usb: dwc2_update_urb_state(): trimming xfer length

This happens because the packet size requested by the driver is 1522
bytes, wMaxPacketSize is 64, the dwc2 driver configures the chip to
receive 24*64 = 1536 bytes, and the chip does indeed send more than
1522 bytes of data. Since the event does not indicate an error condition,
the message is just noise. Demote it to debug level.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Fixes: 7359d482eb4d3 ("staging: HCD files for the DWC2 driver")
Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
Tested-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 drivers/usb/dwc2/hcd_intr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc2/hcd_intr.c b/drivers/usb/dwc2/hcd_intr.c
index 12819e019e13..d5f4ec1b73b1 100644
--- a/drivers/usb/dwc2/hcd_intr.c
+++ b/drivers/usb/dwc2/hcd_intr.c
@@ -500,7 +500,7 @@ static int dwc2_update_urb_state(struct dwc2_hsotg *hsotg,
 						      &short_read);
 
 	if (urb->actual_length + xfer_length > urb->length) {
-		dev_warn(hsotg->dev, "%s(): trimming xfer length\n", __func__);
+		dev_dbg(hsotg->dev, "%s(): trimming xfer length\n", __func__);
 		xfer_length = urb->length - urb->actual_length;
 	}
 
-- 
2.29.2

