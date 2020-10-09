Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18685288A6B
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 16:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388662AbgJIOMB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 10:12:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388327AbgJIOL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 10:11:57 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0C81C0613D2;
        Fri,  9 Oct 2020 07:11:55 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id g4so9532035edk.0;
        Fri, 09 Oct 2020 07:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y9btYdEkTrtUXwhTgLKS41ZV5GpEa2RccM+q/Je+c94=;
        b=AU3a9laTbFRVWSuXjnut4Wd8cjBnca17x/7wWhjoUmQtmxQcWMaT3BeNl1IWSJRgG2
         VwBtRVToz5ziBXP/ih1zTFzSbc4MU1TTO5Z8cPmjtjj2JdoX8tadC7duBRSDR8LLKdFQ
         IuMfC8LfLxY7kAGJ+cJPKyO6DsZjVKBAEj9OucXiX5RDyWYQKRq6f5PTSUb1glfxoxGJ
         AdqQurerSU2W9Y6NRK6p+MfaKO0LQrJ5LDicWmLdWhV+lJH+YqXwQLKWb3t6FzEoZHBU
         Ya5PQFnncnbG3S19PMyBQODNi3zyfzqIeHNfxGjRLcpSLY270IBmttcsp0arihffCosL
         8x7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y9btYdEkTrtUXwhTgLKS41ZV5GpEa2RccM+q/Je+c94=;
        b=JNkMFcb1qHtdE4O9lYfzZ/N/52h0W7ja+gXzTBWTCQfCTZR4MUdfHFyRUVFDEa8s7S
         9SiN3jFiFdipQRSRSdlArUfpAlTK+jPLizkuaij3kYhdJWMEgFFY1d/c1EF0rfcLGzF0
         5c4L6DLBBHGx5PpjNaw80JjwQVV4bkKHGb+8ESyJlMZCSqaAzcEXRKAv3kNP0+mqY078
         Qr4pvsMWnojvTxs7skM6DOjqppvYxUJUX6KxWl8OEwZIFKaS/DhJTFqg261ZlTFmC+WX
         Y8Rx23MSFGyeyk49HSi+U7Xr2W3H1QcQJ7tgC+lRBBIN24EapDeiQdMchoF9OgU93b3x
         eanQ==
X-Gm-Message-State: AOAM53087xP6EXzldQCV1O8kmVVFN5wy/Hhqv+Xt5S8zmzcgjjDwPaAA
        T05HJnLmvml0Ds8gOwHHmshwvaz8S+w=
X-Google-Smtp-Source: ABdhPJxAEPgUjZ2bRIMt1yXG0t2zgL/OVNm8fbbLm3YPG6Qv38wO+hKFGqLf5E2InCIYjsudON+G2A==
X-Received: by 2002:aa7:d504:: with SMTP id y4mr14934865edq.336.1602252713918;
        Fri, 09 Oct 2020 07:11:53 -0700 (PDT)
Received: from xws.fritz.box (pd9e5a236.dip0.t-ipconnect.de. [217.229.162.54])
        by smtp.gmail.com with ESMTPSA id a5sm6184108edl.6.2020.10.09.07.11.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 07:11:53 -0700 (PDT)
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
Subject: [PATCH v4 2/5] platform/surface: Move Surface 3 WMI driver to platform/surface
Date:   Fri,  9 Oct 2020 16:11:25 +0200
Message-Id: <20201009141128.683254-3-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201009141128.683254-1-luzmaximilian@gmail.com>
References: <20201009141128.683254-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the Surface 3 WMI driver from platform/x86 to the newly created
platform/surface directory.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 drivers/platform/surface/Kconfig                 | 16 ++++++++++++++++
 drivers/platform/surface/Makefile                |  2 ++
 drivers/platform/{x86 => surface}/surface3-wmi.c |  0
 drivers/platform/x86/Kconfig                     | 12 ------------
 drivers/platform/x86/Makefile                    |  1 -
 5 files changed, 18 insertions(+), 13 deletions(-)
 rename drivers/platform/{x86 => surface}/surface3-wmi.c (100%)

diff --git a/drivers/platform/surface/Kconfig b/drivers/platform/surface/Kconfig
index b67926ece95f..326f7bbf83d7 100644
--- a/drivers/platform/surface/Kconfig
+++ b/drivers/platform/surface/Kconfig
@@ -12,3 +12,19 @@ menuconfig SURFACE_PLATFORMS
 	  kernel code.
 
 	  If you say N, all options in this submenu will be skipped and disabled.
+
+if SURFACE_PLATFORMS
+
+config SURFACE3_WMI
+	tristate "Surface 3 WMI Driver"
+	depends on ACPI_WMI
+	depends on DMI
+	depends on INPUT
+	depends on SPI
+	help
+	  Say Y here if you have a Surface 3.
+
+	  To compile this driver as a module, choose M here: the module will
+	  be called surface3-wmi.
+
+endif # SURFACE_PLATFORMS
diff --git a/drivers/platform/surface/Makefile b/drivers/platform/surface/Makefile
index 3700f9e84299..f889d521420f 100644
--- a/drivers/platform/surface/Makefile
+++ b/drivers/platform/surface/Makefile
@@ -3,3 +3,5 @@
 # Makefile for linux/drivers/platform/surface
 # Microsoft Surface Platform-Specific Drivers
 #
+
+obj-$(CONFIG_SURFACE3_WMI)		+= surface3-wmi.o
diff --git a/drivers/platform/x86/surface3-wmi.c b/drivers/platform/surface/surface3-wmi.c
similarity index 100%
rename from drivers/platform/x86/surface3-wmi.c
rename to drivers/platform/surface/surface3-wmi.c
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 0d91d136bc3b..0759913c9846 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -870,18 +870,6 @@ config INTEL_VBTN
 	  To compile this driver as a module, choose M here: the module will
 	  be called intel_vbtn.
 
-config SURFACE3_WMI
-	tristate "Surface 3 WMI Driver"
-	depends on ACPI_WMI
-	depends on DMI
-	depends on INPUT
-	depends on SPI
-	help
-	  Say Y here if you have a Surface 3.
-
-	  To compile this driver as a module, choose M here: the module will
-	  be called surface3-wmi.
-
 config SURFACE_3_BUTTON
 	tristate "Power/home/volume buttons driver for Microsoft Surface 3 tablet"
 	depends on ACPI && KEYBOARD_GPIO && I2C
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 5f823f7eff45..29563a32b3e3 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -82,7 +82,6 @@ obj-$(CONFIG_INTEL_OAKTRAIL)		+= intel_oaktrail.o
 obj-$(CONFIG_INTEL_VBTN)		+= intel-vbtn.o
 
 # Microsoft
-obj-$(CONFIG_SURFACE3_WMI)		+= surface3-wmi.o
 obj-$(CONFIG_SURFACE_3_BUTTON)		+= surface3_button.o
 obj-$(CONFIG_SURFACE_3_POWER_OPREGION)	+= surface3_power.o
 obj-$(CONFIG_SURFACE_PRO3_BUTTON)	+= surfacepro3_button.o
-- 
2.28.0

