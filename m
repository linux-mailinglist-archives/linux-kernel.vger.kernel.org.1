Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45D552992A4
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 17:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1786267AbgJZQlD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 12:41:03 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:55806 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502504AbgJZQlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 12:41:02 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 653A380307CB;
        Mon, 26 Oct 2020 16:40:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Xcyr2yLLC3PA; Mon, 26 Oct 2020 19:40:53 +0300 (MSK)
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        David Cohen <david.a.cohen@linux.intel.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Felipe Balbi <balbi@ti.com>
Subject: [PATCH v2 2/3] usb: dwc3: ulpi: Replace CPU-based busyloop with Protocol-based one
Date:   Mon, 26 Oct 2020 19:40:49 +0300
Message-ID: <20201026164050.30380-3-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20201026164050.30380-1-Sergey.Semin@baikalelectronics.ru>
References: <20201026164050.30380-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Originally the procedure of the ULPI transaction finish detection has been
developed as a simple busy-loop with just decrementing counter and no
delays. It's wrong since on different systems the loop will take a
different time to complete. So if the system bus and CPU are fast enough
to overtake the ULPI bus and the companion PHY reaction, then we'll get to
take a false timeout error. Fix this by converting the busy-loop procedure
to take the standard bus speed, address value and the registers access
mode into account for the busy-loop delay calculation.

Here is the way the fix works. It's known that the ULPI bus is clocked
with 60MHz signal. In accordance with [1] the ULPI bus protocol is created
so to spend 5 and 6 clock periods for immediate register write and read
operations respectively, and 6 and 7 clock periods - for the extended
register writes and reads. Based on that we can easily pre-calculate the
time which will be needed for the controller to perform a requested IO
operation. Note we'll still preserve the attempts counter in case if the
DWC USB3 controller has got some internals delays.

[1] UTMI+ Low Pin Interface (ULPI) Specification, Revision 1.1,
    October 20, 2004, pp. 30 - 36.

Fixes: 88bc9d194ff6 ("usb: dwc3: add ULPI interface support")
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/dwc3/ulpi.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc3/ulpi.c b/drivers/usb/dwc3/ulpi.c
index 20f5d9aba317..0dbc826355a5 100644
--- a/drivers/usb/dwc3/ulpi.c
+++ b/drivers/usb/dwc3/ulpi.c
@@ -7,6 +7,8 @@
  * Author: Heikki Krogerus <heikki.krogerus@linux.intel.com>
  */
 
+#include <linux/delay.h>
+#include <linux/time64.h>
 #include <linux/ulpi/regs.h>
 
 #include "core.h"
@@ -17,12 +19,22 @@
 		DWC3_GUSB2PHYACC_ADDR(ULPI_ACCESS_EXTENDED) | \
 		DWC3_GUSB2PHYACC_EXTEND_ADDR(a) : DWC3_GUSB2PHYACC_ADDR(a))
 
-static int dwc3_ulpi_busyloop(struct dwc3 *dwc)
+#define DWC3_ULPI_BASE_DELAY	DIV_ROUND_UP(NSEC_PER_SEC, 60000000L)
+
+static int dwc3_ulpi_busyloop(struct dwc3 *dwc, u8 addr, bool read)
 {
+	unsigned long ns = 5L * DWC3_ULPI_BASE_DELAY;
 	unsigned count = 1000;
 	u32 reg;
 
+	if (addr >= ULPI_EXT_VENDOR_SPECIFIC)
+		ns += DWC3_ULPI_BASE_DELAY;
+
+	if (read)
+		ns += DWC3_ULPI_BASE_DELAY;
+
 	while (count--) {
+		ndelay(ns);
 		reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYACC(0));
 		if (reg & DWC3_GUSB2PHYACC_DONE)
 			return 0;
@@ -47,7 +59,7 @@ static int dwc3_ulpi_read(struct device *dev, u8 addr)
 	reg = DWC3_GUSB2PHYACC_NEWREGREQ | DWC3_ULPI_ADDR(addr);
 	dwc3_writel(dwc->regs, DWC3_GUSB2PHYACC(0), reg);
 
-	ret = dwc3_ulpi_busyloop(dwc);
+	ret = dwc3_ulpi_busyloop(dwc, addr, true);
 	if (ret)
 		return ret;
 
@@ -71,7 +83,7 @@ static int dwc3_ulpi_write(struct device *dev, u8 addr, u8 val)
 	reg |= DWC3_GUSB2PHYACC_WRITE | val;
 	dwc3_writel(dwc->regs, DWC3_GUSB2PHYACC(0), reg);
 
-	return dwc3_ulpi_busyloop(dwc);
+	return dwc3_ulpi_busyloop(dwc, addr, false);
 }
 
 static const struct ulpi_ops dwc3_ulpi_ops = {
-- 
2.28.0

