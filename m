Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE399287627
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 16:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730657AbgJHOf2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 10:35:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730353AbgJHOfX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 10:35:23 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DC4C061755;
        Thu,  8 Oct 2020 07:35:23 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id l24so6074043edj.8;
        Thu, 08 Oct 2020 07:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QqZlieJiKz7vG6xUay2HjJB344jisx0YbRObfbt2BOc=;
        b=dQOsa0BtUCxpBVxZ73IkzPg6b8qULsJAUyZYZ3lwgCjONGWYn3yd6G4UWA9kPdgnwv
         w8OpfvQSqp4EJOiYjPEAAfUg6InbfpFEJbkXUiNsgh6RVskuy/blyFjE11xlDRqRpYiK
         vU87YQknIuwjaN0ngy95hfZZjuhMQO76XLB8C3VxqUTkq5Y1HtxF8H2VDzgXw5zudJF+
         wy/QnDSCZBQUKYAuy3aaVASbPqIulstR5MCOinbvvOpg37bcZtIUXuQW0RuG5di//DOQ
         7hCJx89R1ESmEqymk/sZjS2yWZpZ/TQzon96iKbulAhVzYqoxAzD1BXK3aUg4uJsrK+C
         S4JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QqZlieJiKz7vG6xUay2HjJB344jisx0YbRObfbt2BOc=;
        b=busTNesZ+SDaolgGxz1v0GQ/jEpYixVuYAyEYDn4uCdvJnGFzYc6M4pjgaExo/UBgA
         HK8/DcqT3P6dmPxsyUW/lIzx4Tg0xPJ2UvhQJSqaXFH1qyt2UsTbON9UVo+VqtS6EASh
         2Agf+KPs5oM60R7g3j1In5/tOSYfx11489wecDgJVbLVPTTL3oa0nlHHfzU+JdD/39ZE
         C+U5TLoU8gg5QSllyHCT6Te1dA5nDZKsY0OAy+IHwzo7JCJBqXKcDrkyi5buCZa5822q
         03ht7QAix4a+tibygAybYhi5lCCP0s8v62ATUyshQ1jHGy6keDz1ozvKYVX3S1CTCWRL
         /57w==
X-Gm-Message-State: AOAM530Hv6EbvfNa0ZgV412bwKYSWTJMqIBzD81wGzI+Il1lxdAKtacI
        koCXVjfGBi6vZ+dvoGBv86GOYRQAbhE=
X-Google-Smtp-Source: ABdhPJz3wH8jsYv0jb5DtSVCGmcpw4DUXo5+2vn5ryY0tmbzWy0r3GaUiqC6PH87cDsAUYtCkKBSDw==
X-Received: by 2002:a50:9e49:: with SMTP id z67mr9073877ede.183.1602167721119;
        Thu, 08 Oct 2020 07:35:21 -0700 (PDT)
Received: from xws.fritz.box (pd9e5a9e4.dip0.t-ipconnect.de. [217.229.169.228])
        by smtp.gmail.com with ESMTPSA id b8sm4123763edv.20.2020.10.08.07.35.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 07:35:20 -0700 (PDT)
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
Subject: [PATCH v3 2/5] platform/surface: Move Surface 3 WMI driver to platform/surface
Date:   Thu,  8 Oct 2020 16:34:52 +0200
Message-Id: <20201008143455.340599-3-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201008143455.340599-1-luzmaximilian@gmail.com>
References: <20201008143455.340599-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the Surface 3 WMI driver from platform/x86 to the newly created
platform/surface directory.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 drivers/platform/surface/Kconfig                 | 12 +++++++++++-
 drivers/platform/surface/Makefile                |  2 +-
 drivers/platform/{x86 => surface}/surface3-wmi.c |  0
 drivers/platform/x86/Kconfig                     | 12 ------------
 drivers/platform/x86/Makefile                    |  1 -
 5 files changed, 12 insertions(+), 15 deletions(-)
 rename drivers/platform/{x86 => surface}/surface3-wmi.c (100%)

diff --git a/drivers/platform/surface/Kconfig b/drivers/platform/surface/Kconfig
index 806b088ddae2..1566b32a1884 100644
--- a/drivers/platform/surface/Kconfig
+++ b/drivers/platform/surface/Kconfig
@@ -15,6 +15,16 @@ menuconfig SURFACE_PLATFORM
 
 if SURFACE_PLATFORM
 
-# place Microsoft Surface platform drivers here
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
 
 endif # SURFACE_PLATFORM
diff --git a/drivers/platform/surface/Makefile b/drivers/platform/surface/Makefile
index 11788a44713f..f889d521420f 100644
--- a/drivers/platform/surface/Makefile
+++ b/drivers/platform/surface/Makefile
@@ -4,4 +4,4 @@
 # Microsoft Surface Platform-Specific Drivers
 #
 
-# place Microsoft Surface platform drivers here
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

