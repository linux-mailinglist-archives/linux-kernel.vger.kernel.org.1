Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82A5F279B3C
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 19:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729595AbgIZRR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 13:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729391AbgIZRRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 13:17:55 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 059C7C0613D3;
        Sat, 26 Sep 2020 10:17:55 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id ay8so5701594edb.8;
        Sat, 26 Sep 2020 10:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lcBsjnajO4fTPTvs7qAbh2JZawKgsdZDVsW0VBI+daE=;
        b=CKdJWQlFlegkx9NVPNoh2ptMtli7494EMgY1tlR9JkkcZlEw5zUogEibMzHuTi1gqO
         ziH+/oikcYZgPR+209skV1G+dpfPX8I+SOFo1XOlf21/g509QqT6NzOPQKblrClKBKVO
         vLdsw9za4liVxRhKPKvr6Zusw4CyHT9Nr1V5TdRJfxvnjcmLOnRzGRKg6Pz4zkIiIVTh
         eReF6VkazRhtq9zVG59+szhYh4aXYXXvR4sfV6WWeyNjvSCK8X/m9Ido++X/k6AqWNo3
         K6GNUsBw49m4VzEq545icPf/gH07ujwqg2xE597TS7vsq/6wV0tHFcA3uUZmz7KOJtdX
         1KHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lcBsjnajO4fTPTvs7qAbh2JZawKgsdZDVsW0VBI+daE=;
        b=B7BoIVrKhSfmJ5qvZrjB8tb5kL6z/WSFUAlIlpQs+4U/PvlV7FO45yL9f0yaUH9SvK
         G8x9G6edUsjxdSIKovipqEidVRoaqTKpaTeeTlE2pl0PaMdjbgsq9I+ABQuAKIT79/t2
         IjM5K6f+QO7SxpvlhgJr46iDo2iVOTjVfLDolrXl8xIkzGFWEN5843+dYWbRIlexwaz+
         uHN0QF9mFbNIWC0bNfflRUoCVplmDkCFkvjvm0xmuzDw9OriwfkiblaI5QFPAN/ovQX0
         Nou6Z6pHoL/S6rZleuGt7in7dGR7sLnW15S2Gsogr8Owz0w238vaA0jHgK75btgxBooK
         p6fQ==
X-Gm-Message-State: AOAM530xhjo3j1s1MixcoKzoxD3yY4uvAFMTTP1yxkL/lJnA9YYN2JID
        WpXQgAQK2nMf9pYM8x8/x2QZ7CILSCY=
X-Google-Smtp-Source: ABdhPJzsdQnpUNpqzEnmoXkz7fxNOrpPgmyp1nElKfSX93Oz0+vcvETBLXMQI2VkKRTyqILoX8hk7g==
X-Received: by 2002:a50:e80a:: with SMTP id e10mr7554432edn.4.1601140672181;
        Sat, 26 Sep 2020 10:17:52 -0700 (PDT)
Received: from xws.fritz.box (pd9e5ae20.dip0.t-ipconnect.de. [217.229.174.32])
        by smtp.gmail.com with ESMTPSA id u13sm4625589ejn.82.2020.09.26.10.17.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2020 10:17:51 -0700 (PDT)
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
Subject: [PATCH 2/5] platform/surface: Move Surface 3 WMI driver to platform/surface
Date:   Sat, 26 Sep 2020 19:17:11 +0200
Message-Id: <20200926171714.721406-3-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200926171714.721406-1-luzmaximilian@gmail.com>
References: <20200926171714.721406-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the Surface 3 WMI driver from platform/x86 to the newly created
platform/surface directory.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
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
index 40219bba6801..1be0a23bd9f2 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -869,18 +869,6 @@ config INTEL_VBTN
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

