Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 490B928762A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 16:35:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730681AbgJHOfi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 10:35:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730641AbgJHOfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 10:35:25 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A61AEC061755;
        Thu,  8 Oct 2020 07:35:24 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id md26so8421133ejb.10;
        Thu, 08 Oct 2020 07:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P1alwE6/TrOFlXLMswuzb/9hNUWfzhQ0/xjCElKc5HI=;
        b=fA1x3d3oOuXJgsE5i53Eo+eDwZ037E3ShxQS58j77tHjiW3dJ/pcp3YWiFBKAvFYVX
         e/ULuNJeJWtZv53XVVgyGLdK20gQtX21Nwn5/fyOYDpLbwmny5i7AcRO2Vv9fVdM6cMe
         co8tB5lFY2Heuy+xm29sXMdrRP5SXmpfSBGoqxLErnCYknPc1opG/wUfv3bpUzWzly+B
         cmhbjrnfEyP10spiHGDtD4f3MuwcsOZracsiXkdKsfGlFkiQNLeqjI1KGLlLN31rBUHC
         qjSerlPgYTcLTJelDopS+hEzxEA9bp98LPMypmi/PC/nZAz3WbnHlMayFSdjex0Yw4ib
         Qqcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P1alwE6/TrOFlXLMswuzb/9hNUWfzhQ0/xjCElKc5HI=;
        b=uChwWJGNG9dt1ASbh2uvlek6G4w+7n/NBZ3H9QKykRxZrochSxc3dXFOieb72i1aOu
         f7xbFesb7s22ao6UAca39ixr2dSIsGJR2ZatC/A5dLfu385y6c4qcD0SCLsKwHxUrBQF
         ZrxSpYK5YyL3mAupvJ4btQCsPx3SccqsMwAsgO6ZeTLaDObCJjkC3LuUHXpDMnMgePB5
         fcVdxgkTlr1yCatAUbx7UKaHU53rxQWQF6BFES83O1b5zbctmmAA3/5fFyQ2e0auPoGf
         lf8d6rSkG7XX8clWYoQhFZl8n1TZOxI72b9cElZ3TzEmRP2EkS2rCUuILEP7aAyJshGy
         KoCA==
X-Gm-Message-State: AOAM532t11iWW+tIFgz8YHOdan1prXCyTsy8pT0Rp8+6IRvyuOMgF4fG
        EsqieCmgIOfzzmoZfyctPy4xH4tYkMg=
X-Google-Smtp-Source: ABdhPJyJCjgqjNzC/gGDMIAnHKC1grNhXynNZViwcT/Tw2cjirNwEdsjM0PdiyYC/E4G8UQYpT1ddw==
X-Received: by 2002:a17:906:fb98:: with SMTP id lr24mr8989576ejb.82.1602167722788;
        Thu, 08 Oct 2020 07:35:22 -0700 (PDT)
Received: from xws.fritz.box (pd9e5a9e4.dip0.t-ipconnect.de. [217.229.169.228])
        by smtp.gmail.com with ESMTPSA id b8sm4123763edv.20.2020.10.08.07.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 07:35:22 -0700 (PDT)
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
Subject: [PATCH v3 3/5] platform/surface: Move Surface 3 Button driver to platform/surface
Date:   Thu,  8 Oct 2020 16:34:53 +0200
Message-Id: <20201008143455.340599-4-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201008143455.340599-1-luzmaximilian@gmail.com>
References: <20201008143455.340599-1-luzmaximilian@gmail.com>
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

