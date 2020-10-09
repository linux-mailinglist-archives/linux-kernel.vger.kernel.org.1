Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCE66288A71
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 16:12:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388669AbgJIOME (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 10:12:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388643AbgJIOL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 10:11:57 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4C6C0613D5;
        Fri,  9 Oct 2020 07:11:57 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id o18so9508768edq.4;
        Fri, 09 Oct 2020 07:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IniTSkLOwe6i9U30Imyr2gIIQ4FD9dMA9fNMx7FEC9Y=;
        b=fI22hlQfGBSyuQBxzLJUfG/IgWuzjnVMHTzDw68ywUk8jzurtkE803HdDuP2633vwy
         KCqvSZWmUx6lbFe0HgaJHuyw7cv5WkeBj0g4euPwP+wjAIdNO/N4kYXIXXdGAq3P/Y2I
         7Y7E+VSO42fdQgfe4e2Wr7wbvgHGe+oGcIG7l5DGbUxBsS5aUtpGrRu7DLWExNPPBktF
         Y/5ImMvTbmCt+mPxxPj/XeV9AtYlwF2AWwkS4Mz2WaR7/dw3BgSAAb11vf3TbsqZrjCd
         EmeZTzMEvgVnqM7XxKPm/eq1fomoc0J0RiRxu9osogWvaS87Ya69YMmcyXogm9WhhIe3
         zPyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IniTSkLOwe6i9U30Imyr2gIIQ4FD9dMA9fNMx7FEC9Y=;
        b=nZwTLYSORJgF2e9sF8btcUuW2Memq/tj3jSOsol0JbJrlllkXab15nB0UAilkJWsC/
         5LUZ5CNMu4TNDMUb1IPJSdVtNw3InO/wI4p9G3/c6jRTe+ckaWAIM7K6csktTx2DdVkI
         E5lVmvOt4jLQIFb9K81RlA0PTtpuZquFYN+JfpLgCzLiF+ysroH5MZxaxLW4DRHod9v0
         DZsb5fyNrHlgPS0JkJW7QJKiBpuNuztxBH2FENdhONgH6JdoraZiDz5jdWNAOvFjyIr3
         pyPBZRbhFtT+dvtpFtcXLE1ywpDHU7Nj5lPEy11MbQrbWaclOcpOjXqUDrdU5OpqYhjD
         GQZw==
X-Gm-Message-State: AOAM532z0DGyWUi33gy3QDD1+o+szP0NZVSX68yd7ugbdgcSSaY20HVw
        NfDfprJ6qG7lFHLNk1Zq3pFXpf9MqUo=
X-Google-Smtp-Source: ABdhPJxax74x2HPfAbLPVD0RbmhZacD4LKdA+H0602pAFAoT31rgF1mBbCJb6E6GngMKNRzYjQmRLA==
X-Received: by 2002:a50:ff10:: with SMTP id a16mr14899011edu.83.1602252715591;
        Fri, 09 Oct 2020 07:11:55 -0700 (PDT)
Received: from xws.fritz.box (pd9e5a236.dip0.t-ipconnect.de. [217.229.162.54])
        by smtp.gmail.com with ESMTPSA id a5sm6184108edl.6.2020.10.09.07.11.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2020 07:11:54 -0700 (PDT)
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
Subject: [PATCH v4 3/5] platform/surface: Move Surface 3 Button driver to platform/surface
Date:   Fri,  9 Oct 2020 16:11:26 +0200
Message-Id: <20201009141128.683254-4-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201009141128.683254-1-luzmaximilian@gmail.com>
References: <20201009141128.683254-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the Surface 3 Button driver from platform/x86 to the newly created
platform/surface directory.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
---
 drivers/platform/surface/Kconfig                    | 6 ++++++
 drivers/platform/surface/Makefile                   | 1 +
 drivers/platform/{x86 => surface}/surface3_button.c | 0
 drivers/platform/x86/Kconfig                        | 6 ------
 drivers/platform/x86/Makefile                       | 1 -
 5 files changed, 7 insertions(+), 7 deletions(-)
 rename drivers/platform/{x86 => surface}/surface3_button.c (100%)

diff --git a/drivers/platform/surface/Kconfig b/drivers/platform/surface/Kconfig
index 326f7bbf83d7..1a7cf6a73d52 100644
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
 endif # SURFACE_PLATFORMS
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

