Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83A122D4C0B
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 21:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387865AbgLIUij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 15:38:39 -0500
Received: from mga12.intel.com ([192.55.52.136]:6795 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725816AbgLIUii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 15:38:38 -0500
IronPort-SDR: a+Jme+p862qPOl7JVqSs0pzwHZ7sW/IHasyBUnKcVfsVFuXNSluBUgAhplUBPeVvq8SU1mAvJX
 oneV2Qyz8JgA==
X-IronPort-AV: E=McAfee;i="6000,8403,9830"; a="153384185"
X-IronPort-AV: E=Sophos;i="5.78,405,1599548400"; 
   d="scan'208";a="153384185"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2020 12:36:45 -0800
IronPort-SDR: V22kb8zRx4wB7Y4newVE1FGMV1uxDJAqp7RQW/L2IH4CzDzryLaXpHdEPE3B+vMoLt8N8EbSLI
 MffEP0iSOWDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,405,1599548400"; 
   d="scan'208";a="348497562"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga002.jf.intel.com with ESMTP; 09 Dec 2020 12:36:44 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 927DF1F1; Wed,  9 Dec 2020 22:36:43 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-usb@vger.kernel.org
Subject: [PATCH v2 3/5] usb: host: sl811: Switch to use platform_get_mem_or_io()
Date:   Wed,  9 Dec 2020 22:36:40 +0200
Message-Id: <20201209203642.27648-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201209203642.27648-1-andriy.shevchenko@linux.intel.com>
References: <20201209203642.27648-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to use new platform_get_mem_or_io() instead of home grown analogue.
Note, the code has been moved upper in the function to allow farther cleanups,
such as resource sanity check.

Cc: linux-usb@vger.kernel.org
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
v2: no changes
 drivers/usb/host/sl811-hcd.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/host/sl811-hcd.c b/drivers/usb/host/sl811-hcd.c
index adaf4063690a..115ced0d93e1 100644
--- a/drivers/usb/host/sl811-hcd.c
+++ b/drivers/usb/host/sl811-hcd.c
@@ -1614,12 +1614,18 @@ sl811h_probe(struct platform_device *dev)
 	void __iomem		*addr_reg;
 	void __iomem		*data_reg;
 	int			retval;
-	u8			tmp, ioaddr = 0;
+	u8			tmp, ioaddr;
 	unsigned long		irqflags;
 
 	if (usb_disabled())
 		return -ENODEV;
 
+	/* the chip may be wired for either kind of addressing */
+	addr = platform_get_mem_or_io(dev, 0);
+	data = platform_get_mem_or_io(dev, 1);
+	if (!addr || !data || resource_type(addr) != resource_type(data))
+		return -ENODEV;
+
 	/* basic sanity checks first.  board-specific init logic should
 	 * have initialized these three resources and probably board
 	 * specific platform_data.  we don't probe for IRQs, and do only
@@ -1632,16 +1638,8 @@ sl811h_probe(struct platform_device *dev)
 	irq = ires->start;
 	irqflags = ires->flags & IRQF_TRIGGER_MASK;
 
-	/* the chip may be wired for either kind of addressing */
-	addr = platform_get_resource(dev, IORESOURCE_MEM, 0);
-	data = platform_get_resource(dev, IORESOURCE_MEM, 1);
-	retval = -EBUSY;
-	if (!addr || !data) {
-		addr = platform_get_resource(dev, IORESOURCE_IO, 0);
-		data = platform_get_resource(dev, IORESOURCE_IO, 1);
-		if (!addr || !data)
-			return -ENODEV;
-		ioaddr = 1;
+	ioaddr = resource_type(addr) == IORESOURCE_IO;
+	if (ioaddr) {
 		/*
 		 * NOTE: 64-bit resource->start is getting truncated
 		 * to avoid compiler warning, assuming that ->start
-- 
2.29.2

