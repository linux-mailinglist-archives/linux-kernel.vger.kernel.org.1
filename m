Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39D442992AA
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 17:41:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1786258AbgJZQlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 12:41:02 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:55822 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2443361AbgJZQlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 12:41:02 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 03DA38030833;
        Mon, 26 Oct 2020 16:40:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id i9TDtR52sTFo; Mon, 26 Oct 2020 19:40:54 +0300 (MSK)
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
        <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 3/3] usb: dwc3: ulpi: Fix USB2.0 HS/FS/LS PHY suspend regression
Date:   Mon, 26 Oct 2020 19:40:50 +0300
Message-ID: <20201026164050.30380-4-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20201026164050.30380-1-Sergey.Semin@baikalelectronics.ru>
References: <20201026164050.30380-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

First of all the commit e0082698b689 ("usb: dwc3: ulpi: conditionally
resume ULPI PHY") introduced the Suspend USB2.0 HS/FS/LS PHY regression,
as by design of the fix any attempt to read/write from/to the PHY control
registers will completely disable the PHY suspension, which consequently
will increase the USB bus power consumption. Secondly the fix won't work
well for the very first attempt of the ULPI PHY control registers IO,
because after disabling the USB2.0 PHY suspension functionality it will
still take some time for the bus to resume from the sleep state if one has
been reached before it. So the very first PHY register read/write
operation will take more time than the busy-loop provides and the IO
timeout error might be returned anyway.

Here we suggest to fix the denoted problems in the following way. First of
all let's not disable the Suspend USB2.0 HS/FS/LS PHY functionality so to
make the controller and the USB2.0 bus more power efficient. Secondly
instead of that we'll extend the PHY IO op wait procedure with 1 - 1.2 ms
sleep if the PHY suspension is enabled (1ms should be enough as by LPM
specification it is at most how long it takes for the USB2.0 bus to resume
from L1 (Sleep) state). Finally in case if the USB2.0 PHY suspension
functionality has been disabled on the DWC USB3 controller setup procedure
we'll compensate the USB bus resume process latency by extending the
busy-loop attempts counter.

Fixes: e0082698b689 ("usb: dwc3: ulpi: conditionally resume ULPI PHY")
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
---
 drivers/usb/dwc3/ulpi.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/dwc3/ulpi.c b/drivers/usb/dwc3/ulpi.c
index 0dbc826355a5..f23f4c9a557e 100644
--- a/drivers/usb/dwc3/ulpi.c
+++ b/drivers/usb/dwc3/ulpi.c
@@ -24,7 +24,7 @@
 static int dwc3_ulpi_busyloop(struct dwc3 *dwc, u8 addr, bool read)
 {
 	unsigned long ns = 5L * DWC3_ULPI_BASE_DELAY;
-	unsigned count = 1000;
+	unsigned int count = 10000;
 	u32 reg;
 
 	if (addr >= ULPI_EXT_VENDOR_SPECIFIC)
@@ -33,6 +33,10 @@ static int dwc3_ulpi_busyloop(struct dwc3 *dwc, u8 addr, bool read)
 	if (read)
 		ns += DWC3_ULPI_BASE_DELAY;
 
+	reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
+	if (reg & DWC3_GUSB2PHYCFG_SUSPHY)
+		usleep_range(1000, 1200);
+
 	while (count--) {
 		ndelay(ns);
 		reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYACC(0));
@@ -50,12 +54,6 @@ static int dwc3_ulpi_read(struct device *dev, u8 addr)
 	u32 reg;
 	int ret;
 
-	reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
-	if (reg & DWC3_GUSB2PHYCFG_SUSPHY) {
-		reg &= ~DWC3_GUSB2PHYCFG_SUSPHY;
-		dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
-	}
-
 	reg = DWC3_GUSB2PHYACC_NEWREGREQ | DWC3_ULPI_ADDR(addr);
 	dwc3_writel(dwc->regs, DWC3_GUSB2PHYACC(0), reg);
 
@@ -73,12 +71,6 @@ static int dwc3_ulpi_write(struct device *dev, u8 addr, u8 val)
 	struct dwc3 *dwc = dev_get_drvdata(dev);
 	u32 reg;
 
-	reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYCFG(0));
-	if (reg & DWC3_GUSB2PHYCFG_SUSPHY) {
-		reg &= ~DWC3_GUSB2PHYCFG_SUSPHY;
-		dwc3_writel(dwc->regs, DWC3_GUSB2PHYCFG(0), reg);
-	}
-
 	reg = DWC3_GUSB2PHYACC_NEWREGREQ | DWC3_ULPI_ADDR(addr);
 	reg |= DWC3_GUSB2PHYACC_WRITE | val;
 	dwc3_writel(dwc->regs, DWC3_GUSB2PHYACC(0), reg);
-- 
2.28.0

