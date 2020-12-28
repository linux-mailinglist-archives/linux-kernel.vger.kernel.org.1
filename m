Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22D472E6A0E
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Dec 2020 19:45:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbgL1SpD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Dec 2020 13:45:03 -0500
Received: from mga07.intel.com ([134.134.136.100]:48151 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727030AbgL1SpC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Dec 2020 13:45:02 -0500
IronPort-SDR: EMQxQ3BjuBTxEfFAsUGY+tYeKXz+XRadFVGRXIH8gZgMNkjOGaTXRmPXfFRRrdOe9aPP1sRewu
 VG0S2DmBzyzA==
X-IronPort-AV: E=McAfee;i="6000,8403,9848"; a="240496080"
X-IronPort-AV: E=Sophos;i="5.78,455,1599548400"; 
   d="scan'208";a="240496080"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Dec 2020 10:43:16 -0800
IronPort-SDR: ldkX5EWyDsv5XXFcFNtA3Hsu5CWQ5Q409YtBqoqcMgjgiQiVlxbEWZ/meBG35F8FUwB4wdVKMS
 Zr2nIcUUfH5A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,455,1599548400"; 
   d="scan'208";a="347664531"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga006.jf.intel.com with ESMTP; 28 Dec 2020 10:43:15 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 8090ADE; Mon, 28 Dec 2020 20:43:14 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1] misc: pvpanic: Check devm_ioport_map() for NULL
Date:   Mon, 28 Dec 2020 20:43:13 +0200
Message-Id: <20201228184313.57610-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inconveniently devm_ioport_map() and devm_ioremap_resource()
return errors differently, i.e. former uses simply NULL pointer,
while the latter an error pointer.

Due to this, we have to check each of them separately.

Fixes: f104060813fe ("misc: pvpanic: Combine ACPI and platform drivers")
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/misc/pvpanic.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/misc/pvpanic.c b/drivers/misc/pvpanic.c
index 951b37da5e3c..41cab297d66e 100644
--- a/drivers/misc/pvpanic.c
+++ b/drivers/misc/pvpanic.c
@@ -55,12 +55,23 @@ static int pvpanic_mmio_probe(struct platform_device *pdev)
 	struct resource *res;
 
 	res = platform_get_mem_or_io(pdev, 0);
-	if (res && resource_type(res) == IORESOURCE_IO)
+	if (!res)
+		return -EINVAL;
+
+	switch (resource_type(res)) {
+	case IORESOURCE_IO:
 		base = devm_ioport_map(dev, res->start, resource_size(res));
-	else
+		if (!base)
+			return -ENOMEM;
+		break;
+	case IORESOURCE_MEM:
 		base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(base))
-		return PTR_ERR(base);
+		if (IS_ERR(base))
+			return PTR_ERR(base);
+		break;
+	default:
+		return -EINVAL;
+	}
 
 	atomic_notifier_chain_register(&panic_notifier_list,
 				       &pvpanic_panic_nb);
-- 
2.29.2

