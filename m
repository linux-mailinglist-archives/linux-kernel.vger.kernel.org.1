Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43542288A76
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 16:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388680AbgJIOMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 10:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388657AbgJIOMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 10:12:01 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEF78C0613D5;
        Fri,  9 Oct 2020 07:12:00 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id i5so9500364edr.5;
        Fri, 09 Oct 2020 07:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8h65wkk5f31FdCdcSzFTr840XJhCUcmzMvFOsSTGBgM=;
        b=FersfZZSiR2ueCA5Ywu37IFc4tofIMCAqBPyaNEX5h+RuexEg2ouHapjKFP8Xu5jzZ
         p7akTPlaJuH1kGb0OC3B/uwTc03OkzH7O1JLQ4x8eUc/bJVOB6bjw7NoWpgAh7tNBsvs
         2SJzXbEo6IzAAPVg7Lj+uRMJK7Vw/na7e0ITbfyCuhUeFa1j18vYWqGF3QNqjdUO9BIy
         lDPndWQvkvgPksTb2Sqgtw/7bfJCF8DyX5xe4Vwsg+pqS+5s37AJ5mtlbIqTV6sYKNDu
         O6VMqQ7hWPSwia9q/sZaqXqKPGKS+cNUEA2WG7Ji0xotuN3tYf43RgVGvx+/77ckn6Nv
         4r7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8h65wkk5f31FdCdcSzFTr840XJhCUcmzMvFOsSTGBgM=;
        b=ehSBQTZeWuZTl8WlwsAa76Ry2btvNprykhpJJiXCb0eINc7PErkoWknNM8E15bhTj7
         E5CKaohsp2EGMdv4edMWVN7+BZi8o8TbEwdToUAp2gUa2AzmSx2mI62hAdFtci7AIupL
         7LCMI0KJPjZasmbIfPOfnyLt+pehI9aHugzaSAiYLk3qjOqPqubpm94MQki7NXiVQHUM
         FWvRTmDW+jHa9eZCaxlYFMUuRxCrhm8k25lSkl3RG2kYo/6c7+FDB92V3Mo5Udp73fpX
         iGdVVsC4rhro0t+n/bL+o4BpmDdCezLDSTsD/HDkgkfEXNDgTdRHDuU9kDuWStC0cYXS
         4DmQ==
X-Gm-Message-State: AOAM5339YqYPBvN9n7kC/NCFdDe9IWEYST9B0Fhfq+Z+emiActBeBoG6
        /vkbRCe9MicyPpedDldoCwIv2vn6xvE=
X-Google-Smtp-Source: ABdhPJwJtbwGK++BC/AImFEqheRzHUgNcT0E1e9WRflA4+tX1bieiQ1XxoqpTXgl89/+12ysymHwiw==
X-Received: by 2002:aa7:cd85:: with SMTP id x5mr15286934edv.0.1602252719172;
        Fri, 09 Oct 2020 07:11:59 -0700 (PDT)
Received: from xws.fritz.box (pd9e5a236.dip0.t-ipconnect.de. [217.229.162.54])
        by smtp.gmail.com with ESMTPSA id a5sm6184108edl.6.2020.10.09.07.11.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 07:11:58 -0700 (PDT)
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
Subject: [PATCH v4 5/5] platform/surface: Move Surface Pro 3 Button driver to platform/surface
Date:   Fri,  9 Oct 2020 16:11:28 +0200
Message-Id: <20201009141128.683254-6-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201009141128.683254-1-luzmaximilian@gmail.com>
References: <20201009141128.683254-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the Surface Pro 3 Button driver from platform/x86 to the newly
created platform/surface directory.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Acked-by: Chen Yu <yu.c.chen@intel.com>
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
index 9fea3ce2db2d..8ff126ced757 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11545,7 +11545,7 @@ MICROSOFT SURFACE PRO 3 BUTTON DRIVER
 M:	Chen Yu <yu.c.chen@intel.com>
 L:	platform-driver-x86@vger.kernel.org
 S:	Supported
-F:	drivers/platform/x86/surfacepro3_button.c
+F:	drivers/platform/surface/surfacepro3_button.c
 
 MICROTEK X6 SCANNER
 M:	Oliver Neukum <oliver@neukum.org>
diff --git a/drivers/platform/surface/Kconfig b/drivers/platform/surface/Kconfig
index ac1c749a7a2f..10902ea43861 100644
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
 endif # SURFACE_PLATFORMS
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

