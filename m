Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D107C279B3F
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 19:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729950AbgIZRSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 13:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729047AbgIZRR7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 13:17:59 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4230C0613D3;
        Sat, 26 Sep 2020 10:17:58 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id ay8so5701714edb.8;
        Sat, 26 Sep 2020 10:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4eBSpXh2Tq6EEqJL5obhqKxWiOfol2HlMFEkEUAyq5w=;
        b=cs9uqhDFDEjL3Wu1Dtv1I/ROwETzfz11PFHQPuum4B8WdOAkyJCB2TFJ0b2z94ccW7
         1KppRSw7U5vs+vja5XYPbFj/WNqMLLiKpNs9mYF8eoPsranTGtsEA8Xv/oZ5RoQ3ec24
         T0N0sUL531RFCgQ8Rd91su/1LjkynA2VfC1Q9/vpFMsdNtWWZ/o7jnaHvHurAyj7WcOs
         lBRDOpXRt0ObOv4chJTEUSIm3364Fc1xCn2E3mDAF/ZAnfrdoQxTsHLWsNX+n3Gpj0xm
         tTRj9KE+yp19n0zA4vLo21qXjlEVz0x2POiHsJcDxlhl3A/J1/Fy9F76SyXc6dl3cWZG
         ECQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4eBSpXh2Tq6EEqJL5obhqKxWiOfol2HlMFEkEUAyq5w=;
        b=GRTJXrDUPTh7HBFYsZ8bchSE4NtFOw4ll7d0V0FXcrqbmeE/kLtSgjpfTLILK6+RgW
         XRsk6+Hqnn8QKTWFruZZ1Ao8Tq7aHDpFsiuMi6DOdmtWi4tNkN8kBo7/1JIfqL/RIt+6
         lmFGFjDh41r3xz3qziIAPjHWmgRCA6EABUXnwqMfEpVd43bqXvOBckZrHU58Hj7q+0RX
         f+VxIb/PlBSoIFbsI6z2jfvWWJluIxaOt6QFfTe7a9jKDr7a1eWPARWZiTR/ztU9amVG
         cCUa1Tf/X4ISri2EAHKRfm+iT1LWMJrAaTVsAgE9LRnRfvWRNKdjLlH8/o7Q/aCSThmx
         Z1Bw==
X-Gm-Message-State: AOAM532EVCC/bPQfdZcaofNlR65myszDXwhNCy3ld5CI6/cszlug4kgP
        uZdeHaQsQiRMdxln4NKai3xMp8InnP8=
X-Google-Smtp-Source: ABdhPJyDLGO72BC33dOUV7bpWoNQE0CiHuwXTwdlIAoPGAZWewQs2nMxxHq9j1XDrsKUtuiek5AXMQ==
X-Received: by 2002:a05:6402:718:: with SMTP id w24mr7583092edx.294.1601140676961;
        Sat, 26 Sep 2020 10:17:56 -0700 (PDT)
Received: from xws.fritz.box (pd9e5ae20.dip0.t-ipconnect.de. [217.229.174.32])
        by smtp.gmail.com with ESMTPSA id u13sm4625589ejn.82.2020.09.26.10.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2020 10:17:56 -0700 (PDT)
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
Subject: [PATCH 5/5] platform/surface: Move Surface Pro 3 Button driver to platform/surface
Date:   Sat, 26 Sep 2020 19:17:14 +0200
Message-Id: <20200926171714.721406-6-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200926171714.721406-1-luzmaximilian@gmail.com>
References: <20200926171714.721406-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the Surface Pro 3 Button driver from platform/x86 to the newly
created platform/surface directory.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 MAINTAINERS                                            | 2 +-
 drivers/platform/surface/Kconfig                       | 6 ++++++
 drivers/platform/surface/Makefile                      | 1 +
 drivers/platform/{x86 => surface}/surfacepro3_button.c | 0
 drivers/platform/x86/Kconfig                           | 6 ------
 drivers/platform/x86/Makefile                          | 3 ---
 6 files changed, 8 insertions(+), 10 deletions(-)
 rename drivers/platform/{x86 => surface}/surfacepro3_button.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index a4f955f2ce25..5bf40ead9a1f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11569,7 +11569,7 @@ MICROSOFT SURFACE PRO 3 BUTTON DRIVER
 M:	Chen Yu <yu.c.chen@intel.com>
 L:	platform-driver-x86@vger.kernel.org
 S:	Supported
-F:	drivers/platform/x86/surfacepro3_button.c
+F:	drivers/platform/surface/surfacepro3_button.c
 
 MICROTEK X6 SCANNER
 M:	Oliver Neukum <oliver@neukum.org>
diff --git a/drivers/platform/surface/Kconfig b/drivers/platform/surface/Kconfig
index 2af26379804c..fcd80e860132 100644
--- a/drivers/platform/surface/Kconfig
+++ b/drivers/platform/surface/Kconfig
@@ -40,4 +40,10 @@ config SURFACE_3_POWER_OPREGION
 	  This driver provides support for ACPI operation
 	  region of the Surface 3 battery platform driver.
 
+config SURFACE_PRO3_BUTTON
+	tristate "Power/home/volume buttons driver for Microsoft Surface Pro 3/4 tablet"
+	depends on ACPI && INPUT
+	help
+	  This driver handles the power/home/volume buttons on the Microsoft Surface Pro 3/4 tablet.
+
 endif # SURFACE_PLATFORM
diff --git a/drivers/platform/surface/Makefile b/drivers/platform/surface/Makefile
index 4940d4db58b2..dcb1df06d57a 100644
--- a/drivers/platform/surface/Makefile
+++ b/drivers/platform/surface/Makefile
@@ -7,3 +7,4 @@
 obj-$(CONFIG_SURFACE3_WMI)		+= surface3-wmi.o
 obj-$(CONFIG_SURFACE_3_BUTTON)		+= surface3_button.o
 obj-$(CONFIG_SURFACE_3_POWER_OPREGION)	+= surface3_power.o
+obj-$(CONFIG_SURFACE_PRO3_BUTTON)	+= surfacepro3_button.o
diff --git a/drivers/platform/x86/surfacepro3_button.c b/drivers/platform/surface/surfacepro3_button.c
similarity index 100%
rename from drivers/platform/x86/surfacepro3_button.c
rename to drivers/platform/surface/surfacepro3_button.c
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index fbb9556fa688..09fcfb20f4ac 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -869,12 +869,6 @@ config INTEL_VBTN
 	  To compile this driver as a module, choose M here: the module will
 	  be called intel_vbtn.
 
-config SURFACE_PRO3_BUTTON
-	tristate "Power/home/volume buttons driver for Microsoft Surface Pro 3/4 tablet"
-	depends on ACPI && INPUT
-	help
-	  This driver handles the power/home/volume buttons on the Microsoft Surface Pro 3/4 tablet.
-
 config MSI_LAPTOP
 	tristate "MSI Laptop Extras"
 	depends on ACPI
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index ffa31f57d9a2..aeff497e23a5 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -81,9 +81,6 @@ obj-$(CONFIG_INTEL_MENLOW)		+= intel_menlow.o
 obj-$(CONFIG_INTEL_OAKTRAIL)		+= intel_oaktrail.o
 obj-$(CONFIG_INTEL_VBTN)		+= intel-vbtn.o
 
-# Microsoft
-obj-$(CONFIG_SURFACE_PRO3_BUTTON)	+= surfacepro3_button.o
-
 # MSI
 obj-$(CONFIG_MSI_LAPTOP)	+= msi-laptop.o
 obj-$(CONFIG_MSI_WMI)		+= msi-wmi.o
-- 
2.28.0

