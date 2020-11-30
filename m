Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 558A62C922D
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Dec 2020 00:12:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731159AbgK3XKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 18:10:10 -0500
Received: from mga06.intel.com ([134.134.136.31]:42876 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731151AbgK3XKI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 18:10:08 -0500
IronPort-SDR: dksY1cAJ90L+nyY3CD1qe8oVpuoH+cHN8ecF5+O5fkzluaQ5X8bcPxIn03ykLupTKAg0bUR/Zo
 1zIsBtXuBfMg==
X-IronPort-AV: E=McAfee;i="6000,8403,9821"; a="234331877"
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="234331877"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 15:07:10 -0800
IronPort-SDR: lT2/vF8FOoosTmvQ8DsfBwg4Xl0Keh/gET694kqPgPSJhjOFgvuPm89GiaCigqmkN7SJN5+86Z
 Nl8nXyVOHuOQ==
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="334833627"
Received: from smtp.ostc.intel.com ([10.54.29.231])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 15:07:10 -0800
Received: from mtg-dev (mtg-dev.jf.intel.com [10.54.74.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.ostc.intel.com (Postfix) with ESMTPS id 65A2F636B;
        Mon, 30 Nov 2020 15:07:10 -0800 (PST)
Received: from mgross by mtg-dev with local (Exim 4.90_1)
        (envelope-from <mgross@linux.intel.com>)
        id 1kjsGE-000C5B-8n; Mon, 30 Nov 2020 15:07:10 -0800
From:   mgross@linux.intel.com
To:     linux-kernel@vger.kernel.org
Cc:     markgross@kernel.org, mgross@linux.intel.com,
        adam.r.gretzinger@intel.com,
        Srikanth Thokala <srikanth.thokala@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 10/22] misc: xlink-pcie: lh: Prepare changes for adding remote host driver
Date:   Mon, 30 Nov 2020 15:06:55 -0800
Message-Id: <20201130230707.46351-11-mgross@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201130230707.46351-1-mgross@linux.intel.com>
References: <20201130230707.46351-1-mgross@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Srikanth Thokala <srikanth.thokala@intel.com>

Move logic that can be reused between local host and remote host to
common/ folder

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Mark Gross <mgross@linux.intel.com>
Signed-off-by: Srikanth Thokala <srikanth.thokala@intel.com>
---
 drivers/misc/xlink-pcie/{local_host => common}/core.h  | 0
 drivers/misc/xlink-pcie/{local_host => common}/util.c  | 0
 drivers/misc/xlink-pcie/{local_host => common}/util.h  | 0
 drivers/misc/xlink-pcie/{local_host => common}/xpcie.h | 0
 drivers/misc/xlink-pcie/local_host/Makefile            | 2 +-
 drivers/misc/xlink-pcie/local_host/core.c              | 4 ++--
 drivers/misc/xlink-pcie/local_host/epf.h               | 4 ++--
 7 files changed, 5 insertions(+), 5 deletions(-)
 rename drivers/misc/xlink-pcie/{local_host => common}/core.h (100%)
 rename drivers/misc/xlink-pcie/{local_host => common}/util.c (100%)
 rename drivers/misc/xlink-pcie/{local_host => common}/util.h (100%)
 rename drivers/misc/xlink-pcie/{local_host => common}/xpcie.h (100%)

diff --git a/drivers/misc/xlink-pcie/local_host/core.h b/drivers/misc/xlink-pcie/common/core.h
similarity index 100%
rename from drivers/misc/xlink-pcie/local_host/core.h
rename to drivers/misc/xlink-pcie/common/core.h
diff --git a/drivers/misc/xlink-pcie/local_host/util.c b/drivers/misc/xlink-pcie/common/util.c
similarity index 100%
rename from drivers/misc/xlink-pcie/local_host/util.c
rename to drivers/misc/xlink-pcie/common/util.c
diff --git a/drivers/misc/xlink-pcie/local_host/util.h b/drivers/misc/xlink-pcie/common/util.h
similarity index 100%
rename from drivers/misc/xlink-pcie/local_host/util.h
rename to drivers/misc/xlink-pcie/common/util.h
diff --git a/drivers/misc/xlink-pcie/local_host/xpcie.h b/drivers/misc/xlink-pcie/common/xpcie.h
similarity index 100%
rename from drivers/misc/xlink-pcie/local_host/xpcie.h
rename to drivers/misc/xlink-pcie/common/xpcie.h
diff --git a/drivers/misc/xlink-pcie/local_host/Makefile b/drivers/misc/xlink-pcie/local_host/Makefile
index 28761751d43b..65df94c7e860 100644
--- a/drivers/misc/xlink-pcie/local_host/Makefile
+++ b/drivers/misc/xlink-pcie/local_host/Makefile
@@ -2,4 +2,4 @@ obj-$(CONFIG_XLINK_PCIE_LH_DRIVER) += mxlk_ep.o
 mxlk_ep-objs := epf.o
 mxlk_ep-objs += dma.o
 mxlk_ep-objs += core.o
-mxlk_ep-objs += util.o
+mxlk_ep-objs += ../common/util.o
diff --git a/drivers/misc/xlink-pcie/local_host/core.c b/drivers/misc/xlink-pcie/local_host/core.c
index aecaaa783153..0f83b5ffc4f2 100644
--- a/drivers/misc/xlink-pcie/local_host/core.c
+++ b/drivers/misc/xlink-pcie/local_host/core.c
@@ -10,8 +10,8 @@
 #include <linux/of_reserved_mem.h>
 
 #include "epf.h"
-#include "core.h"
-#include "util.h"
+#include "../common/core.h"
+#include "../common/util.h"
 
 static struct xpcie *global_xpcie;
 
diff --git a/drivers/misc/xlink-pcie/local_host/epf.h b/drivers/misc/xlink-pcie/local_host/epf.h
index 675c07455ffa..9cfd96923c6f 100644
--- a/drivers/misc/xlink-pcie/local_host/epf.h
+++ b/drivers/misc/xlink-pcie/local_host/epf.h
@@ -13,8 +13,8 @@
 #include <linux/pci-epc.h>
 #include <linux/pci-epf.h>
 
-#include "xpcie.h"
-#include "util.h"
+#include "../common/xpcie.h"
+#include "../common/util.h"
 
 #define XPCIE_DRIVER_NAME "mxlk_pcie_epf"
 #define XPCIE_DRIVER_DESC "Intel(R) xLink PCIe endpoint function driver"
-- 
2.17.1

