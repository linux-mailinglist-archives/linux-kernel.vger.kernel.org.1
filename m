Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B95C6283BEC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 18:03:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbgJEQDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 12:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbgJEQDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 12:03:33 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082E4C0613CE;
        Mon,  5 Oct 2020 09:03:33 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id ce10so12758953ejc.5;
        Mon, 05 Oct 2020 09:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z9aCwmkE9rVihKPnzER4l7iBu2YQtTm4952+qUhOwyM=;
        b=dkZZyMllAT9EUL1lcGMdjkhjaJFQJKe3NEE9f/cK6Sk6a/wtXIOgc4F7loeKJtUW5R
         IkZ3d/9+jod3GJUbj2g+FkRWu6XucR2FxdkHs/atpPG154FB2n2bJAsNRnNn/Kefz625
         LLwLEuGFM9mzLasX4iTyI3mTXnlFnYfmJw9AthSosBNw1MwzJ6ZN8BMPZj06m7189Y+p
         rEpHw8W0kPJ7Wplfg9Wy77ABBm3LwxsmzkjvqozPeEWrFrEgJxubmZQ3L15dn9NQne4s
         E2v5uAhaMsR5O5NG8UnJetKvnMpj3IGRqILyw44bpOTnhYN/rU2MZwZIGSiHJZBVzMsT
         OAOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z9aCwmkE9rVihKPnzER4l7iBu2YQtTm4952+qUhOwyM=;
        b=f0Nm0qrvz/F9VG6xrlFsLQF3bUVs4iG5DGuZM4ngj16Z86Dfp1boulzG4ldJYo5p49
         2z/gwDbPprgPH+H+lcF7qdayrkWklgt0gxnRQJO7YSz8Pzd+z/XLgackcWmK4xtPLdea
         efHDJswpaF/d6QqQx56xyI/Kv7RlYnTJwUK+hDhQifPupyf6lUw3/xtiPNwROG5+dL2T
         VlvPGyIvGdym1H9hkGymdOJjrJqrEYOsZky/TD0SJzHu5s8qV1Ww+mOecHb/bESDi/u1
         exdlmeEO2/oyehQIrsMaf1RqaPu8mD89YGPGd+6BqO8nL54mCOLUeKktiz3LX5Epn9fd
         uK6g==
X-Gm-Message-State: AOAM531u2rj+v5Rvb4PMZoIpXzh44a1U9SiFx1GzyinRLNxCx5AS1hCR
        CY4u7ZSlB2KoJh3bzBzoAg3A5UJkHdU=
X-Google-Smtp-Source: ABdhPJxm+eOq+ue3YqcxJdp+gpnByPmg3v/9k9O11iHZY3T2+FE78F3AbAKglk3Q7PK92ipRTrLMMA==
X-Received: by 2002:a17:906:6855:: with SMTP id a21mr379085ejs.289.1601913811154;
        Mon, 05 Oct 2020 09:03:31 -0700 (PDT)
Received: from xws.fritz.box (pd9e5a952.dip0.t-ipconnect.de. [217.229.169.82])
        by smtp.gmail.com with ESMTPSA id y3sm51788ejk.92.2020.10.05.09.03.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 09:03:30 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        =?UTF-8?q?Bla=C5=BE=20Hrastnik?= <blaz@mxxn.io>,
        Stephen Just <stephenjust@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Chen Yu <yu.c.chen@intel.com>, linux-kernel@vger.kernel.org,
        Maximilian Luz <luzmaximilian@gmail.com>
Subject: [PATCH v2 1/5] platform: Add Surface platform directory
Date:   Mon,  5 Oct 2020 18:03:03 +0200
Message-Id: <20201005160307.39201-2-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201005160307.39201-1-luzmaximilian@gmail.com>
References: <20201005160307.39201-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It may make sense to split the Microsoft Surface hardware platform
drivers out to a separate subdirectory, since some of it may be shared
between ARM and x86 in the future (regarding devices like the Surface
Pro X).

Further, newer Surface devices will require additional platform drivers
for fundamental support (mostly regarding their embedded controller),
which may also warrant this split from a size perspective.

This commit introduces a new platform/surface subdirectory for the
Surface device family, with subsequent commits moving existing Surface
drivers over from platform/x86.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---

Changes in v2:
 - Do not create a separate MAINTAINERS entry for platform/surface.
   Instead add drivers/platform/surface to x86 platform drivers entry.
   This incorporates recent changes in the x86 platform driver
   MAINTAINERS entry.
 - Fix typo in commit message.

---
 MAINTAINERS                       |  1 +
 drivers/platform/Kconfig          |  2 ++
 drivers/platform/Makefile         |  1 +
 drivers/platform/surface/Kconfig  | 20 ++++++++++++++++++++
 drivers/platform/surface/Makefile |  7 +++++++
 5 files changed, 31 insertions(+)
 create mode 100644 drivers/platform/surface/Kconfig
 create mode 100644 drivers/platform/surface/Makefile

diff --git a/MAINTAINERS b/MAINTAINERS
index b1c97a16b6ce..21b4b4c975b3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18863,6 +18863,7 @@ L:	platform-driver-x86@vger.kernel.org
 S:	Maintained
 T:	git git://git.infradead.org/linux-platform-drivers-x86.git
 F:	drivers/platform/olpc/
+F:	drivers/platform/surface/
 F:	drivers/platform/x86/
 
 X86 PLATFORM DRIVERS - ARCH
diff --git a/drivers/platform/Kconfig b/drivers/platform/Kconfig
index 971426bb4302..18fc6a08569e 100644
--- a/drivers/platform/Kconfig
+++ b/drivers/platform/Kconfig
@@ -13,3 +13,5 @@ source "drivers/platform/chrome/Kconfig"
 source "drivers/platform/mellanox/Kconfig"
 
 source "drivers/platform/olpc/Kconfig"
+
+source "drivers/platform/surface/Kconfig"
diff --git a/drivers/platform/Makefile b/drivers/platform/Makefile
index 6fda58c021ca..af62d93f0e46 100644
--- a/drivers/platform/Makefile
+++ b/drivers/platform/Makefile
@@ -9,3 +9,4 @@ obj-$(CONFIG_MIPS)		+= mips/
 obj-$(CONFIG_OLPC_EC)		+= olpc/
 obj-$(CONFIG_GOLDFISH)		+= goldfish/
 obj-$(CONFIG_CHROME_PLATFORMS)	+= chrome/
+obj-$(CONFIG_SURFACE_PLATFORM)	+= surface/
diff --git a/drivers/platform/surface/Kconfig b/drivers/platform/surface/Kconfig
new file mode 100644
index 000000000000..806b088ddae2
--- /dev/null
+++ b/drivers/platform/surface/Kconfig
@@ -0,0 +1,20 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Microsoft Surface Platform-Specific Drivers
+#
+
+menuconfig SURFACE_PLATFORM
+	bool "Microsoft Surface Platform-Specific Device Drivers"
+	default y
+	help
+	  Say Y here to get to see options for platform-specific device drivers
+	  for Microsoft Surface devices. This option alone does not add any
+	  kernel code.
+
+	  If you say N, all options in this submenu will be skipped and disabled.
+
+if SURFACE_PLATFORM
+
+# place Microsoft Surface platform drivers here
+
+endif # SURFACE_PLATFORM
diff --git a/drivers/platform/surface/Makefile b/drivers/platform/surface/Makefile
new file mode 100644
index 000000000000..11788a44713f
--- /dev/null
+++ b/drivers/platform/surface/Makefile
@@ -0,0 +1,7 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+# Makefile for linux/drivers/platform/surface
+# Microsoft Surface Platform-Specific Drivers
+#
+
+# place Microsoft Surface platform drivers here
-- 
2.28.0

