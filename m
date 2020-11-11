Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A164F2AEC8D
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 10:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgKKJDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 04:03:17 -0500
Received: from mail.baikalelectronics.com ([87.245.175.226]:38646 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726133AbgKKJDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 04:03:16 -0500
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id AFD5F803016F;
        Wed, 11 Nov 2020 09:03:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5gyhnUBrHcCI; Wed, 11 Nov 2020 12:03:13 +0300 (MSK)
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Felipe Balbi <balbi@kernel.org>,
        John Youn <John.Youn@synopsys.com>,
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
Subject: [PATCH v3 1/3] usb: dwc3: ulpi: Use VStsDone to detect PHY regs access completion
Date:   Wed, 11 Nov 2020 12:02:51 +0300
Message-ID: <20201111090254.12842-2-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20201111090254.12842-1-Sergey.Semin@baikalelectronics.ru>
References: <20201111090254.12842-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In accordance with [1] the DWC_usb3 core sets the GUSB2PHYACCn.VStsDone
bit when the PHY vendor control access is done and clears it when the
application initiates a new transaction. The doc doesn't say anything
about the GUSB2PHYACCn.VStsBsy flag serving for the same purpose. Moreover
we've discovered that the VStsBsy flag can be cleared before the VStsDone
bit. So using the former as a signal of the PHY control registers
completion might be dangerous. Let's have the VStsDone flag utilized
instead then.

[1] Synopsys DesignWare Cores SuperSpeed USB 3.0 xHCI Host Controller
    Databook, 2.70a, December 2013, p.388

Fixes: 88bc9d194ff6 ("usb: dwc3: add ULPI interface support")
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

---

Changelog v3:
- Add Fixes tag to the commit log.
---
 drivers/usb/dwc3/core.h | 1 +
 drivers/usb/dwc3/ulpi.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 2f04b3e42bf1..8d5e5bba1bc2 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -284,6 +284,7 @@
 
 /* Global USB2 PHY Vendor Control Register */
 #define DWC3_GUSB2PHYACC_NEWREGREQ	BIT(25)
+#define DWC3_GUSB2PHYACC_DONE		BIT(24)
 #define DWC3_GUSB2PHYACC_BUSY		BIT(23)
 #define DWC3_GUSB2PHYACC_WRITE		BIT(22)
 #define DWC3_GUSB2PHYACC_ADDR(n)	(n << 16)
diff --git a/drivers/usb/dwc3/ulpi.c b/drivers/usb/dwc3/ulpi.c
index e6e6176386a4..20f5d9aba317 100644
--- a/drivers/usb/dwc3/ulpi.c
+++ b/drivers/usb/dwc3/ulpi.c
@@ -24,7 +24,7 @@ static int dwc3_ulpi_busyloop(struct dwc3 *dwc)
 
 	while (count--) {
 		reg = dwc3_readl(dwc->regs, DWC3_GUSB2PHYACC(0));
-		if (!(reg & DWC3_GUSB2PHYACC_BUSY))
+		if (reg & DWC3_GUSB2PHYACC_DONE)
 			return 0;
 		cpu_relax();
 	}
-- 
2.28.0

