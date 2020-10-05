Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8A82283BEA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 18:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727718AbgJEQDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 12:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727569AbgJEQDh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 12:03:37 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975CEC0613A8;
        Mon,  5 Oct 2020 09:03:36 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id lw21so8769383ejb.6;
        Mon, 05 Oct 2020 09:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P1alwE6/TrOFlXLMswuzb/9hNUWfzhQ0/xjCElKc5HI=;
        b=HnqTvrDd0Q8fFQWJdXx8pr1sJlWco3wT6ADaz9xEni3iRXOLuwomRW+rCITg5m/WLM
         HS1dZZz/pY7EYSdKKze0mR28ZLjx6sFaD9qzawGJYORSNMQNrb6Ne/cLh5r053Tmcu0K
         4PH4IpIrU0RwrXAkSOdSbnNoeeVKG5gh5DIERPllObCc4Rdf+0mNeWiyzYMkaljd6CbE
         o7evQdPzDtU3DqUMbudS7yPD8wYre6YzdakUsufw+Tg5CZDCHq6WYFZbEh5YqEUH3gsI
         nJnToa5OOjhlE7LxDyiVR07SNUyym6Vp3FBGczJLam2Woooti7Bho0iugqCatWGMHP//
         Hpag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P1alwE6/TrOFlXLMswuzb/9hNUWfzhQ0/xjCElKc5HI=;
        b=V3mLUnI1PAfo9hd/Z9MdcpC1CXSqkb0M2uF0Rbg2yGxwP1G6bsykJ/feF/VYMO9mxt
         MeDqqaqq3GuKnZhNhmK7SI8clexmyXBu+A0jCwfHZ56tl1SQGiTmXtYUoxj/UVtPi028
         orvX4i3cbM+rPnM2j0wb84D9xpscfXqTugcvERP2qCRB9DOrurBKnM/cUqcMVvlEFmLz
         WCjlJTEVj4EwIFh5K4iNJ4IPqos0pIfq2htondWQ0J4rTfZSAGpOsYKh8Jd916Bvs6CZ
         2SZxgHF+A8wxHxjLHWBIpVU0sJRgCzv0ZkfIZs1MMbpY27pZxOIXFQrgYEwwrn7bHg6D
         8Pog==
X-Gm-Message-State: AOAM533eR9p1J/zEL7Q770YyB/H6eqfPcb4r1c3+6QffDz/cpPreN/1a
        ZPb5JsGZX5BQzcWr9X+gnB68toJBv8s=
X-Google-Smtp-Source: ABdhPJwJAxUgOtDt5dMVBYthTbfXqGRoZqexCtKs/YYgEszVdQFp8vo+HT8iSjZa9waocsLu+3KJaw==
X-Received: by 2002:a17:906:1e10:: with SMTP id g16mr430678ejj.438.1601913814500;
        Mon, 05 Oct 2020 09:03:34 -0700 (PDT)
Received: from xws.fritz.box (pd9e5a952.dip0.t-ipconnect.de. [217.229.169.82])
        by smtp.gmail.com with ESMTPSA id y3sm51788ejk.92.2020.10.05.09.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 09:03:33 -0700 (PDT)
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
Subject: [PATCH v2 3/5] platform/surface: Move Surface 3 Button driver to platform/surface
Date:   Mon,  5 Oct 2020 18:03:05 +0200
Message-Id: <20201005160307.39201-4-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201005160307.39201-1-luzmaximilian@gmail.com>
References: <20201005160307.39201-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the Surface 3 Button driver from platform/x86 to the newly created
platform/surface directory.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
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
index 0759913c9846..5fba590a1a67 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -870,12 +870,6 @@ config INTEL_VBTN
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

