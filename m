Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C13F829C4F0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 19:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1823725AbgJ0SBB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 14:01:01 -0400
Received: from mga17.intel.com ([192.55.52.151]:65115 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1823202AbgJ0R6K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 13:58:10 -0400
IronPort-SDR: R1vBY2fKZnzwNEBtP2k7LZdmod7vSKPv1TfXKJxzRDZiw6xNCG6VX8nsZzPDl/RR35Em0zXRdI
 1c1OOAjvtTSg==
X-IronPort-AV: E=McAfee;i="6000,8403,9787"; a="147987989"
X-IronPort-AV: E=Sophos;i="5.77,424,1596524400"; 
   d="scan'208";a="147987989"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2020 10:58:09 -0700
IronPort-SDR: bvwsthhye2XuSPqNGB6XvGVJKkyKB1pk7wdw5kbWdYnykL4ML0QNApKGnu1XSWcvRWRngRFqYv
 vMJNx9DC7lug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,424,1596524400"; 
   d="scan'208";a="468422795"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga004.jf.intel.com with ESMTP; 27 Oct 2020 10:58:07 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 1B26B567; Tue, 27 Oct 2020 19:58:07 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Peng Hao <peng.hao2@zte.com.cn>, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v1 5/5] misc: pvpanic: Replace OF headers by mod_devicetable.h
Date:   Tue, 27 Oct 2020 19:58:06 +0200
Message-Id: <20201027175806.20305-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201027175806.20305-1-andriy.shevchenko@linux.intel.com>
References: <20201027175806.20305-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no use for OF headers in the driver, but mod_devicetable.h
must be included. Update driver accordingly.

Cc: Peng Hao <peng.hao2@zte.com.cn>
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/misc/pvpanic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/pvpanic.c b/drivers/misc/pvpanic.c
index 103a09ed651d..a45e70c5b6b9 100644
--- a/drivers/misc/pvpanic.c
+++ b/drivers/misc/pvpanic.c
@@ -11,11 +11,11 @@
 #include <linux/io.h>
 #include <linux/kernel.h>
 #include <linux/kexec.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/of.h>
-#include <linux/of_address.h>
 #include <linux/platform_device.h>
 #include <linux/types.h>
+
 #include <uapi/misc/pvpanic.h>
 
 static void __iomem *base;
-- 
2.28.0

