Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14FBB279B3B
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 19:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729505AbgIZRR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 13:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgIZRRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 13:17:53 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF5DC0613CE;
        Sat, 26 Sep 2020 10:17:52 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id p15so2804718ejm.7;
        Sat, 26 Sep 2020 10:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/bT+9g3lVO7fkI7HzcoGrFZjHUXdg68R1W6hVnfLe6Y=;
        b=SbWdamF/VMRTWR5JQJbVd33ODDSEE1Sx8Lvx2sQPwuV+XtGYAjTQf2vSiac2lTIFFe
         MQH2RUe87Yw+BwuONKLJO4SFg2EMd5Y64sbLhYNeIL9YE/dnRxI1k+HbqPGIyI3dcCHQ
         ArdK0k1f1T2fv/mQvSl0nfoKhu05vTlczR54QxYvEZeojplVbjdcFzzwRWxV6zgtyFtI
         kf2Bn8RXMG1pc7eSDikjGehbVuoEcpZN3/57abZ4AsjFcjxeWsjSsBEUXiyQHu/tihGE
         /HvE5hMGOqmw/CTawjQBE27GSmsO1Xo4pc1KhHINKoIr1BepvceN8Fb1LM2mkhz4cVFh
         J5Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/bT+9g3lVO7fkI7HzcoGrFZjHUXdg68R1W6hVnfLe6Y=;
        b=VEULgi7zuISZurVnUlZywmwR+p8FbsZ4599olaeP2nETVI1CaDtDvnSFpaIibtgIf8
         +bZ2ipT9HdaiPplQ3yxkABC0T4qmtDsG1RqAijiAYYyQg/OdLMEK8tq0pTmMqCiBB1Dz
         fsTHaFzxzqVco2+dAMqUGCy6EUJgH0bUp/Sa9Oq0zKkRuBaVRN/bO5B3PAxkpk7IVCVJ
         AW0IEOxjmhSOr2ai0WGQ4OgxXrB4mYb02AxMATJIIKROIOX0tGyJuBtUpgCnOQAEcUqV
         5fk8dwKFmFPY0XK9UaSyDTngnuLifqdxC1j8pGI1EcdXffRZOD65t9K6YJ76+DaALMMl
         8Vow==
X-Gm-Message-State: AOAM531wgn9uriho4CPBdBFSHo9vhANHdh+h8BeocA7/nMFi4lvvw2cc
        5epPOzb47pLYpX+HBJfQ7uPFvVX2UPE=
X-Google-Smtp-Source: ABdhPJw1I+m0V7mTd1yD31H3VrOUvHyJ75pAgITpX9eKNu0qkegdOHMDn4i4jLXUZVP5JBMi5XVD4Q==
X-Received: by 2002:a17:906:3b03:: with SMTP id g3mr7933683ejf.506.1601140670662;
        Sat, 26 Sep 2020 10:17:50 -0700 (PDT)
Received: from xws.fritz.box (pd9e5ae20.dip0.t-ipconnect.de. [217.229.174.32])
        by smtp.gmail.com with ESMTPSA id u13sm4625589ejn.82.2020.09.26.10.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2020 10:17:50 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     platform-driver-x86@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Darren Hart <dvhart@infradead.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Gayatri Kammela <gayatri.kammela@intel.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        =?UTF-8?q?Bla=C5=BE=20Hrastnik?= <blaz@mxxn.io>,
        Stephen Just <stephenjust@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Chen Yu <yu.c.chen@intel.com>, linux-kernel@vger.kernel.org,
        Maximilian Luz <luzmaximilian@gmail.com>
Subject: [PATCH 1/5] platform: Add Surface platform directory
Date:   Sat, 26 Sep 2020 19:17:10 +0200
Message-Id: <20200926171714.721406-2-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200926171714.721406-1-luzmaximilian@gmail.com>
References: <20200926171714.721406-1-luzmaximilian@gmail.com>
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
drivers over from platfomr/x86.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 MAINTAINERS                       |  8 ++++++++
 drivers/platform/Kconfig          |  2 ++
 drivers/platform/Makefile         |  1 +
 drivers/platform/surface/Kconfig  | 20 ++++++++++++++++++++
 drivers/platform/surface/Makefile |  7 +++++++
 5 files changed, 38 insertions(+)
 create mode 100644 drivers/platform/surface/Kconfig
 create mode 100644 drivers/platform/surface/Makefile

diff --git a/MAINTAINERS b/MAINTAINERS
index d746519253c3..a4f955f2ce25 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11557,6 +11557,14 @@ F:	drivers/scsi/smartpqi/smartpqi*.[ch]
 F:	include/linux/cciss*.h
 F:	include/uapi/linux/cciss*.h
 
+MICROSOFT SURFACE PLATFORM DRIVERS
+M:	Darren Hart <dvhart@infradead.org>
+M:	Andy Shevchenko <andy@infradead.org>
+L:	platform-driver-x86@vger.kernel.org
+S:	Odd Fixes
+T:	git git://git.infradead.org/linux-platform-drivers-x86.git
+F:	drivers/platform/surface/
+
 MICROSOFT SURFACE PRO 3 BUTTON DRIVER
 M:	Chen Yu <yu.c.chen@intel.com>
 L:	platform-driver-x86@vger.kernel.org
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

