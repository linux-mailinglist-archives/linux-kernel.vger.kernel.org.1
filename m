Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B98D1283BF2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 18:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbgJEQDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 12:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727224AbgJEQDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 12:03:40 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC8D1C0613A7;
        Mon,  5 Oct 2020 09:03:39 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id p13so4015018edi.7;
        Mon, 05 Oct 2020 09:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YSnkx38z+wZbKzjG3g1MnOT9jVsKnRmjaQJ/DDTPAzU=;
        b=Ei9Ko36o8OcwevDxebkdZKZOMjQbtBZNZ5DEox2X6gaie+3scRgS4djqjNZU73YW0y
         I8wowtarZ4dDUeSTB77J8IjIFN5G8VsUO3zbPxaoG1auzcP2oVGNCr+uRYohuLy1RimF
         4BCR52O8ABUv9Oh1k5lBCa+UEC4CupC5zHKbZEhQFU6dBaBdet+IiDnezVNGVC8PwqAC
         O1x7PnFM9Do75Ch84aiNtinqIB9N6vikF3827DHBb74lzctrGsmzWJnD/8i6wrLqUpEv
         Bho59L6JiZnTl7i9owtJvHZBtl6Q77pjZQ6bKe5L9+VpTUXIcXjl03KPiV+PpJYc9axG
         lpXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YSnkx38z+wZbKzjG3g1MnOT9jVsKnRmjaQJ/DDTPAzU=;
        b=un9or2FPT5vPA//GEbU2C3C8YGUTcuiNxXp/LOJznQF1iO/u0ptyb8gWJOtT/WEJkI
         Zug0+F/exB2FZ1uNnbOwKVJP0xKEybbaDyPUbWBM8iMOF6riZljGTNumunPEWQdSg6il
         uRPxbeLsnSMk57edvbC7voGUiYtUSTMnYmMO8kKzRk+HKYMrkm26+vk13OdeN6m63C+2
         fCqYWJwVvx82HjgLzGMtcuuaDbXfJUvfnRKufZZrorDb4MMT3KTgkRlbMqai5mzsLu3o
         7RYNB0VzV4xdZR/S900b5dZRm+BInzAEgsL7eJG2SsTijmTEcNVO63mGMDtYww2liGdl
         ucqA==
X-Gm-Message-State: AOAM530oSsUcWT9Tvrg8LLwnZa9sZ7cei+f11djdDmC/DlUDCDWHTbAv
        0WOwpA7W3NNGitExCkfV+cmx5c6IpC0=
X-Google-Smtp-Source: ABdhPJx3guHWaqOHXaKXFuEbSYwiSnume7yH5KhMz10m/1yXqwJS8PpQU3s7GuYS71FCgr/4eSeZ9A==
X-Received: by 2002:a50:dac1:: with SMTP id s1mr387884edj.74.1601913817935;
        Mon, 05 Oct 2020 09:03:37 -0700 (PDT)
Received: from xws.fritz.box (pd9e5a952.dip0.t-ipconnect.de. [217.229.169.82])
        by smtp.gmail.com with ESMTPSA id y3sm51788ejk.92.2020.10.05.09.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 09:03:37 -0700 (PDT)
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
Subject: [PATCH v2 5/5] platform/surface: Move Surface Pro 3 Button driver to platform/surface
Date:   Mon,  5 Oct 2020 18:03:07 +0200
Message-Id: <20201005160307.39201-6-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201005160307.39201-1-luzmaximilian@gmail.com>
References: <20201005160307.39201-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the Surface Pro 3 Button driver from platform/x86 to the newly
created platform/surface directory.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
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
index 21b4b4c975b3..57ea792c0ab1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11536,7 +11536,7 @@ MICROSOFT SURFACE PRO 3 BUTTON DRIVER
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
index 8417ee0178d0..6083f8241b7d 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -870,12 +870,6 @@ config INTEL_VBTN
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

