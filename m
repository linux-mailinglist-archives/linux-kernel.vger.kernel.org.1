Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFC37283BEE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 18:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbgJEQDm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 12:03:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727654AbgJEQDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 12:03:37 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C320CC0613CE;
        Mon,  5 Oct 2020 09:03:35 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id dt13so3372859ejb.12;
        Mon, 05 Oct 2020 09:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QqZlieJiKz7vG6xUay2HjJB344jisx0YbRObfbt2BOc=;
        b=lF41dGFJJXq/Aap8sKLNLIi8pUKjM/PyBzeE1tA3tu8aOUq+oQNBS0Ya/K/0cNqWMl
         WtqKK5d6ZlCdTOS/uvJQ9x941qIBFGdoPSdmXLVOIP8X2LJjfXhvdRl18FIR7ONhO9vX
         gB7UbInCxce8JHstXpdnBrnYm5j1WcNRYQtdi+CnRiPcAZEwp5KoXT9ItVvweLRcpd7R
         7SiYyUA0jLtQ1kRndZjos3go5SoyWsz1uYqLnnoRpvyZS7jkg1XkxBF/Ygwhh/J13N/x
         r05WbMHHnqFO+4pKpGhoOk7tTaV3+2kTJOIKL0+GSqsmnL0MGe5M65jw/3eNgNpUIJt3
         WzJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QqZlieJiKz7vG6xUay2HjJB344jisx0YbRObfbt2BOc=;
        b=bTTOCBrtIei/nOhh1zAk6t4o0k3oSs6TzSnSSMuAgZtuRIsWqI9g2wmuhIGibqwdHj
         9ybW5YKJRCuklgwUjRbo9HedsUMvrO/6AvYYbgUCA1CByyTiqmJsmJ8ZkwKcyGEZpiZQ
         VPOkbkYomZg7AcPVKjvyJJ2fT0Ft0yfmklU76nsyvrb+OT479aLiOe/uq00aV+vDXy6A
         uR570IX9HN067fWfWgJgzXeJdD2VsusJSL0JNlzCIKijDsCwJUZzjhc8QHogQxQhUTpx
         WEtUCSEDzbgqeA7HRHXM2lb2B87UxRc05Vlk+H47+l4GiwvY2d/XK0jiTnUBbVg+bIip
         WX5Q==
X-Gm-Message-State: AOAM533RZHwNuo167vrU/jp7Hz1aLZL2+Kn4vGCILiuqdVl7/QMOv1Y1
        oQE9JtkmOsfD7VPEKdbFSStehGgEakI=
X-Google-Smtp-Source: ABdhPJxswPy963Yar5eeXrZKAqfmYj/jmld7zx4OEkpUeWAh44VHbIVpB66rLNufAPPHu5RNGmUpZA==
X-Received: by 2002:a17:906:af75:: with SMTP id os21mr445132ejb.28.1601913812811;
        Mon, 05 Oct 2020 09:03:32 -0700 (PDT)
Received: from xws.fritz.box (pd9e5a952.dip0.t-ipconnect.de. [217.229.169.82])
        by smtp.gmail.com with ESMTPSA id y3sm51788ejk.92.2020.10.05.09.03.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 09:03:32 -0700 (PDT)
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
Subject: [PATCH v2 2/5] platform/surface: Move Surface 3 WMI driver to platform/surface
Date:   Mon,  5 Oct 2020 18:03:04 +0200
Message-Id: <20201005160307.39201-3-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201005160307.39201-1-luzmaximilian@gmail.com>
References: <20201005160307.39201-1-luzmaximilian@gmail.com>
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

