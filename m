Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73E7A279B3E
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 19:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729789AbgIZRSC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 13:18:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729448AbgIZRRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 13:17:55 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890F2C0613CE;
        Sat, 26 Sep 2020 10:17:55 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id n22so5724425edt.4;
        Sat, 26 Sep 2020 10:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AfT9O0H7JUNIb+i7YC/nS1cXrez1aH9KdFCzpHTzaiM=;
        b=WpC0eXS0GxOw/JRQ8EOYODRm/nE7IncGC7eURxmaN9MKacXi/x+7RpenNCwQysiavi
         oR5E2B94ukWWdw9LwLr2FU8jw3n5UWojoxl4rJPmOO6Zjb8hICg+0R+K6Kv7hl6msT20
         myPdQTJyVJA1vBoGu8Ck5lCJQbEvxZz/zi+6pvsoxDWyJLqTv6yDherebB5/qd+rXf0t
         3VvmDpnl8v85urN5Tf0ayvrlGhc3SAm74NBMxfkfvAn/bJ803xk6LPBMdVnZXwg4Y+Ch
         1W6BLFmpIv7qFVD5UHTzXaRkN8rji0Hh7tLBVDLpAK+he3XSOeMQDXxHZSsTSCONHD+v
         y1lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AfT9O0H7JUNIb+i7YC/nS1cXrez1aH9KdFCzpHTzaiM=;
        b=kQODgyNd+lWyrIdbOrhb1mveFLxyFCSLI+xYiQGUGZBqNeb9ReqRD3b6CkPyrDFHZ+
         oMvmNvRdRLeBhLX0pyy/x4xzwF9gJ/h9jOx2MKfVHBWIXYTzvk9fGDzzxt9EwhIJXBu7
         9LHnHOtdn/NXFoT3jqD3Yim4sn6QCrlZFsyexAdC4dO8Rl+dnd5H0KZ0eT97QpzWi3qM
         TrBXQ4lPxj3qKGl2/PTjmIof0YvYhg66E0BCryQ/XNUUyzM0JlOw9AZku0Tn8/jMedg8
         YMV8jbClhSjK7luplIpQ7cFQhZGR3tUneG1WXnlNZpogDQwTNu5RsjZBZLFzWxLtu7JA
         SUJA==
X-Gm-Message-State: AOAM533up9IGPlDvguMdLkdpx+Mof92gjXVZysEShbixB3VQrFOjx6Ya
        Enb2RJKTr/wKbFQjcEcTYnsUXUu+GKg=
X-Google-Smtp-Source: ABdhPJweAwpdsU9xTyvfSiYMkOUhdMDL2MvBPSNgAKvdXKvJhG+GOU4Jl9+lNIaDVWxv4SGEpjNJwA==
X-Received: by 2002:aa7:ca17:: with SMTP id y23mr7763438eds.245.1601140673779;
        Sat, 26 Sep 2020 10:17:53 -0700 (PDT)
Received: from xws.fritz.box (pd9e5ae20.dip0.t-ipconnect.de. [217.229.174.32])
        by smtp.gmail.com with ESMTPSA id u13sm4625589ejn.82.2020.09.26.10.17.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2020 10:17:53 -0700 (PDT)
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
Subject: [PATCH 3/5] platform/surface: Move Surface 3 Button driver to platform/surface
Date:   Sat, 26 Sep 2020 19:17:12 +0200
Message-Id: <20200926171714.721406-4-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200926171714.721406-1-luzmaximilian@gmail.com>
References: <20200926171714.721406-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the Surface 3 Button driver from platform/x86 to the newly created
platform/surface directory.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/platform/surface/Kconfig                    | 6 ++++++
 drivers/platform/surface/Makefile                   | 1 +
 drivers/platform/{x86 => surface}/surface3_button.c | 0
 drivers/platform/x86/Kconfig                        | 6 ------
 drivers/platform/x86/Makefile                       | 1 -
 5 files changed, 7 insertions(+), 7 deletions(-)
 rename drivers/platform/{x86 => surface}/surface3_button.c (100%)

diff --git a/drivers/platform/surface/Kconfig b/drivers/platform/surface/Kconfig
index 1566b32a1884..22075ca451b0 100644
--- a/drivers/platform/surface/Kconfig
+++ b/drivers/platform/surface/Kconfig
@@ -27,4 +27,10 @@ config SURFACE3_WMI
 	  To compile this driver as a module, choose M here: the module will
 	  be called surface3-wmi.
 
+config SURFACE_3_BUTTON
+	tristate "Power/home/volume buttons driver for Microsoft Surface 3 tablet"
+	depends on ACPI && KEYBOARD_GPIO && I2C
+	help
+	  This driver handles the power/home/volume buttons on the Microsoft Surface 3 tablet.
+
 endif # SURFACE_PLATFORM
diff --git a/drivers/platform/surface/Makefile b/drivers/platform/surface/Makefile
index f889d521420f..8588dc178245 100644
--- a/drivers/platform/surface/Makefile
+++ b/drivers/platform/surface/Makefile
@@ -5,3 +5,4 @@
 #
 
 obj-$(CONFIG_SURFACE3_WMI)		+= surface3-wmi.o
+obj-$(CONFIG_SURFACE_3_BUTTON)		+= surface3_button.o
diff --git a/drivers/platform/x86/surface3_button.c b/drivers/platform/surface/surface3_button.c
similarity index 100%
rename from drivers/platform/x86/surface3_button.c
rename to drivers/platform/surface/surface3_button.c
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 1be0a23bd9f2..33c178100efa 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -869,12 +869,6 @@ config INTEL_VBTN
 	  To compile this driver as a module, choose M here: the module will
 	  be called intel_vbtn.
 
-config SURFACE_3_BUTTON
-	tristate "Power/home/volume buttons driver for Microsoft Surface 3 tablet"
-	depends on ACPI && KEYBOARD_GPIO && I2C
-	help
-	  This driver handles the power/home/volume buttons on the Microsoft Surface 3 tablet.
-
 config SURFACE_3_POWER_OPREGION
 	tristate "Surface 3 battery platform operation region support"
 	depends on ACPI && I2C
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index 29563a32b3e3..0fd70d5d2cf3 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -82,7 +82,6 @@ obj-$(CONFIG_INTEL_OAKTRAIL)		+= intel_oaktrail.o
 obj-$(CONFIG_INTEL_VBTN)		+= intel-vbtn.o
 
 # Microsoft
-obj-$(CONFIG_SURFACE_3_BUTTON)		+= surface3_button.o
 obj-$(CONFIG_SURFACE_3_POWER_OPREGION)	+= surface3_power.o
 obj-$(CONFIG_SURFACE_PRO3_BUTTON)	+= surfacepro3_button.o
 
-- 
2.28.0

