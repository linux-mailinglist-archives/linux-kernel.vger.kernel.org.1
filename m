Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE4F288A74
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 16:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388616AbgJIOMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 10:12:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388654AbgJIOMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 10:12:01 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DFA5C0613D2;
        Fri,  9 Oct 2020 07:11:59 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id a3so13232965ejy.11;
        Fri, 09 Oct 2020 07:11:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P+AR7+CAaiKDGVCgJHGv1SPkj4wszTmxsmL5WtNZbKc=;
        b=Ak1jmAa6pDNpykyL9RFT+9z5a362Y2FmG+KAHgtl2w7tiDiC2TgUCnbAAXX/8jCrni
         1xfcpRu5KbfJCLzPoOriWw10a+ZDChK34BlJhK7DWgTvVByIOOSuWsSbZrFEEMXAOaSY
         95h3FMPs3QCfc+DxiY46rviEjTr9KP6lmA1M6asv3fevDR8ux4XPCrpLLVVhz9Iu6+oi
         mbtUVwfvhL4MbkcJrjyOqPs2a46QauKXozGJjzRKMgOKTVDtrKNRDb4YNUd5wmq8UebX
         3NQPAC5yQTa/6X1PPISX6XJzn0spBYAXOuQCZZXstSKcILCMJFdnCsf6f8MyvX7iKONl
         CuLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P+AR7+CAaiKDGVCgJHGv1SPkj4wszTmxsmL5WtNZbKc=;
        b=D0p9JFqCEFK0ne58F4qHy4W/KTpGWDx/le/d6vW896zXUcix2UFNxYoT1vmFN19dxH
         LTIBWnbhT96hVu6H03XH2Xm5gtcKkhTPIoKzfdA0Yk1kNbm5LGnhi44kPW+7nO6H5D83
         gBAIjk0ZfSdbqWS8+ca5HtHkHzIlsdCdXFmcSimx8RUp88P0VxoSHAqNhJavayOnPIFm
         Exsqev0NHAooE/z77Xv/N/B6oT9uqSvDdb52FekPxviDLCSzlnuypRbV64jXnbK7eL6v
         ipeFTRbYrP5AwbYdwSafimFLDjcRkO/nIQ0+mbYlTe1cQ7asOFHpAislvzLeuJ5StVlh
         yLOA==
X-Gm-Message-State: AOAM530Sre09H1GSkSajKXupD4XxcBN3ssodpCNLsmzBgxCpMtdZnaqR
        nvbOPyxCKJ6mM+exG5Xwto729sLj+Q8=
X-Google-Smtp-Source: ABdhPJxkr2TlMwNXEiclaJKWakpK+VwwSp74hfOtRFxFmk35c2SyRvVrUI6drya4746lVWstM12t/g==
X-Received: by 2002:a17:906:2e59:: with SMTP id r25mr716209eji.520.1602252717485;
        Fri, 09 Oct 2020 07:11:57 -0700 (PDT)
Received: from xws.fritz.box (pd9e5a236.dip0.t-ipconnect.de. [217.229.162.54])
        by smtp.gmail.com with ESMTPSA id a5sm6184108edl.6.2020.10.09.07.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 07:11:56 -0700 (PDT)
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
Subject: [PATCH v4 4/5] platform/surface: Move Surface 3 Power OpRegion driver to platform/surface
Date:   Fri,  9 Oct 2020 16:11:27 +0200
Message-Id: <20201009141128.683254-5-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201009141128.683254-1-luzmaximilian@gmail.com>
References: <20201009141128.683254-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the Surface 3 Power operation region driver from platform/x86 to
the newly created platform/surface directory.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/platform/surface/Kconfig                   | 7 +++++++
 drivers/platform/surface/Makefile                  | 1 +
 drivers/platform/{x86 => surface}/surface3_power.c | 0
 drivers/platform/x86/Kconfig                       | 7 -------
 drivers/platform/x86/Makefile                      | 1 -
 5 files changed, 8 insertions(+), 8 deletions(-)
 rename drivers/platform/{x86 => surface}/surface3_power.c (100%)

diff --git a/drivers/platform/surface/Kconfig b/drivers/platform/surface/Kconfig
index 1a7cf6a73d52..ac1c749a7a2f 100644
--- a/drivers/platform/surface/Kconfig
+++ b/drivers/platform/surface/Kconfig
@@ -33,4 +33,11 @@ config SURFACE_3_BUTTON
 	help
 	  This driver handles the power/home/volume buttons on the Microsoft Surface 3 tablet.
 
+config SURFACE_3_POWER_OPREGION
+	tristate "Surface 3 battery platform operation region support"
+	depends on ACPI && I2C
+	help
+	  This driver provides support for ACPI operation
+	  region of the Surface 3 battery platform driver.
+
 endif # SURFACE_PLATFORMS
diff --git a/drivers/platform/surface/Makefile b/drivers/platform/surface/Makefile
index 8588dc178245..4940d4db58b2 100644
--- a/drivers/platform/surface/Makefile
+++ b/drivers/platform/surface/Makefile
@@ -6,3 +6,4 @@
 
 obj-$(CONFIG_SURFACE3_WMI)		+= surface3-wmi.o
 obj-$(CONFIG_SURFACE_3_BUTTON)		+= surface3_button.o
+obj-$(CONFIG_SURFACE_3_POWER_OPREGION)	+= surface3_power.o
diff --git a/drivers/platform/x86/surface3_power.c b/drivers/platform/surface/surface3_power.c
similarity index 100%
rename from drivers/platform/x86/surface3_power.c
rename to drivers/platform/surface/surface3_power.c
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 5fba590a1a67..8417ee0178d0 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -870,13 +870,6 @@ config INTEL_VBTN
 	  To compile this driver as a module, choose M here: the module will
 	  be called intel_vbtn.
 
-config SURFACE_3_POWER_OPREGION
-	tristate "Surface 3 battery platform operation region support"
-	depends on ACPI && I2C
-	help
-	  This driver provides support for ACPI operation
-	  region of the Surface 3 battery platform driver.
-
 config SURFACE_PRO3_BUTTON
 	tristate "Power/home/volume buttons driver for Microsoft Surface Pro 3/4 tablet"
 	depends on ACPI && INPUT
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 0fd70d5d2cf3..ffa31f57d9a2 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -82,7 +82,6 @@ obj-$(CONFIG_INTEL_OAKTRAIL)		+= intel_oaktrail.o
 obj-$(CONFIG_INTEL_VBTN)		+= intel-vbtn.o
 
 # Microsoft
-obj-$(CONFIG_SURFACE_3_POWER_OPREGION)	+= surface3_power.o
 obj-$(CONFIG_SURFACE_PRO3_BUTTON)	+= surfacepro3_button.o
 
 # MSI
-- 
2.28.0

