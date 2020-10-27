Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4702029C4EC
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 19:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1823711AbgJ0R7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 13:59:48 -0400
Received: from mga06.intel.com ([134.134.136.31]:45500 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1823181AbgJ0R6K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 13:58:10 -0400
IronPort-SDR: zY4dlnzYXYVAff1pliYoKV1JMbYFiBENB/6+JUdwfsjsm1QE7t7b7I65OBjOOb1znpUWd6frbB
 LgWchr0lf+mA==
X-IronPort-AV: E=McAfee;i="6000,8403,9787"; a="229771971"
X-IronPort-AV: E=Sophos;i="5.77,424,1596524400"; 
   d="scan'208";a="229771971"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2020 10:58:09 -0700
IronPort-SDR: r0bFDgqqkmmOy2iDMDA4/n9DmIUZGS2o3t+glU6IWlUh0Q55RLSogZy42xSI9pP0HEE+b3Qrp0
 nFdMKStw4+gQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,424,1596524400"; 
   d="scan'208";a="535893727"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga005.jf.intel.com with ESMTP; 27 Oct 2020 10:58:07 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 05EC4249; Tue, 27 Oct 2020 19:58:07 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-usb@vger.kernel.org
Subject: [PATCH v1 3/5] usb: host: sl811: Switch to use platform_get_mem_or_io_resource()
Date:   Tue, 27 Oct 2020 19:58:04 +0200
Message-Id: <20201027175806.20305-3-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201027175806.20305-1-andriy.shevchenko@linux.intel.com>
References: <20201027175806.20305-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to use new platform_get_mem_or_io_resource() instead of
home grown analogue.

Note, the code has been moved upper in the function to allow farther cleanups,
such as resource sanity check.

Cc: linux-usb@vger.kernel.org
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/usb/host/sl811-hcd.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/drivers/usb/host/sl811-hcd.c b/drivers/usb/host/sl811-hcd.c
index adaf4063690a..7e0d6f686231 100644
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
+	addr = platform_get_mem_or_io_resource(dev, 0);
+	data = platform_get_mem_or_io_resource(dev, 1);
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
2.28.0

