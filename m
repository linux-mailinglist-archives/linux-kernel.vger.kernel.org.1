Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02DAC28762B
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 16:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730666AbgJHOff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 10:35:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730653AbgJHOf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 10:35:28 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46963C0613D2;
        Thu,  8 Oct 2020 07:35:26 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id qp15so8461195ejb.3;
        Thu, 08 Oct 2020 07:35:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DGhCGthpGnpGVEJv/+ZRguWk8wCmOwJoA9fKbUTSkJM=;
        b=pKntwWZllvBo/BFJ9l0Ms31NGnOtX16fvsUs9jnvLyzn3Y+LjSmbP6flECZzg8LAOl
         yd2SHcRav1PP0PMajom/snhANRxMuPrTo6S0TuKhsmm/+i9ySTVJ3EL72g8dnlhlsb5a
         ZwFxzQL+/n8jaD+lj4rZycxjMGqrNVuTtN1TJzqDffQEAnTqbUJSlUHhi1wGTszQXxvC
         17I4pp7yZqfbfCmK/FqBES72Ez8DCaewJEKJFSdyDNze3iuXUw20UOeTzKWwxSecJZ5S
         GMD8FERkDsJ8UUvPDSwGPsVkUrUbcEH67E7pT7Pjq2IpDz9cHQ7fE2T64Y5P9aX0o0Yw
         HdVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DGhCGthpGnpGVEJv/+ZRguWk8wCmOwJoA9fKbUTSkJM=;
        b=LKMpge5bqzf7EnOauX+JtEMGJg3stlMlwoUy2PAcZrhEUCauy3EW1jy0ka1kiH0x/y
         H4bJDKxOmsK5npH10HvuCmVG5OVbW6O8tPKW3zoEUndhUz2FKob2BKXmJhMFHTO+0BkN
         vnRPhJjYbyU429gPuljmSQipxRynZVEDHxMFv+Kdu+68WbrVfiROtVWQyNgaSVxgzyp8
         jsDzUy5gEJBhDMgpPzK7MgZjMpMM0s776DaK3TRY1IvyAH8Pwpvensg9232L7BxfKVAg
         GGFFc+xsMHd+d7j3gittAJHNe0/YjNud5X2QOXMg0H8ZMRCd8nsa3h3m9ZTtMvSMpx0r
         ERRw==
X-Gm-Message-State: AOAM530AmLeq/zKTmCvJ5XSN98erm4eTYUagJjn8BsYOynRckLNeA4wP
        WcwMlOgfvc2SC4iO2r5LcVzTAFKqEMk=
X-Google-Smtp-Source: ABdhPJzf670x6tk8zNWPTBOomUOMjf5G7rBSbiGOzZgzOV53rqczhLTaHS3m1+0iCnXeXqUxtfJxug==
X-Received: by 2002:a17:906:dbf7:: with SMTP id yd23mr8749790ejb.281.1602167724400;
        Thu, 08 Oct 2020 07:35:24 -0700 (PDT)
Received: from xws.fritz.box (pd9e5a9e4.dip0.t-ipconnect.de. [217.229.169.228])
        by smtp.gmail.com with ESMTPSA id b8sm4123763edv.20.2020.10.08.07.35.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 07:35:23 -0700 (PDT)
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
Subject: [PATCH v3 4/5] platform/surface: Move Surface 3 Power OpRegion driver to platform/surface
Date:   Thu,  8 Oct 2020 16:34:54 +0200
Message-Id: <20201008143455.340599-5-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201008143455.340599-1-luzmaximilian@gmail.com>
References: <20201008143455.340599-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the Surface 3 Power operation region driver from platform/x86 to
the newly created platform/surface directory.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 drivers/platform/surface/Kconfig                   | 7 +++++++
 drivers/platform/surface/Makefile                  | 1 +
 drivers/platform/{x86 => surface}/surface3_power.c | 0
 drivers/platform/x86/Kconfig                       | 7 -------
 drivers/platform/x86/Makefile                      | 1 -
 5 files changed, 8 insertions(+), 8 deletions(-)
 rename drivers/platform/{x86 => surface}/surface3_power.c (100%)

diff --git a/drivers/platform/surface/Kconfig b/drivers/platform/surface/Kconfig
index 22075ca451b0..2af26379804c 100644
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
 endif # SURFACE_PLATFORM
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

