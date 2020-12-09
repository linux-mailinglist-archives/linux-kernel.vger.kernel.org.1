Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82F692D4C09
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 21:39:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732246AbgLIUii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 15:38:38 -0500
Received: from mga05.intel.com ([192.55.52.43]:52318 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727901AbgLIUib (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 15:38:31 -0500
IronPort-SDR: xfZHLk6CQrRvGKD2OQv/oIJX3xESpIAQbK6aVLkfDZXDho1ounlMEPSzNnSJI2zM0dxU9Tvdcv
 UWxxTJfH9zMA==
X-IronPort-AV: E=McAfee;i="6000,8403,9830"; a="258860592"
X-IronPort-AV: E=Sophos;i="5.78,405,1599548400"; 
   d="scan'208";a="258860592"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2020 12:36:45 -0800
IronPort-SDR: O9L+UaeVmT/RS3FYhXlxjwnqGzs0y8UCxtMuZVavZ4CDVDebP42aUZzfIhhhMLMSgQIiGWLTBw
 U0o5uahU2JnQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,405,1599548400"; 
   d="scan'208";a="540743330"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 09 Dec 2020 12:36:44 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id A3226453; Wed,  9 Dec 2020 22:36:43 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Peng Hao <peng.hao2@zte.com.cn>, Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH v2 5/5] misc: pvpanic: Replace OF headers by mod_devicetable.h
Date:   Wed,  9 Dec 2020 22:36:42 +0200
Message-Id: <20201209203642.27648-5-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201209203642.27648-1-andriy.shevchenko@linux.intel.com>
References: <20201209203642.27648-1-andriy.shevchenko@linux.intel.com>
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
v2: no changes
 drivers/misc/pvpanic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/pvpanic.c b/drivers/misc/pvpanic.c
index fcab2efd0c45..951b37da5e3c 100644
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
2.29.2

