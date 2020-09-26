Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBAE7279B41
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 19:18:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729903AbgIZRSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 13:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729391AbgIZRR5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 13:17:57 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DA1CC0613CE;
        Sat, 26 Sep 2020 10:17:57 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id k14so5737544edo.1;
        Sat, 26 Sep 2020 10:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NrliFGKLE6GsRxqqWvTJbatPN+Tvql6xRPWE2j+Cokk=;
        b=XMfC5d49TiGXPiQ1XDNvwZz9OePbEvavNDucvB/yxUX6BrI+MuwTuytbKiZVkbAe3N
         qlXtAbmPTUWXLbE3W4IwE0t7MAC0NWijv4VVEmOFKmTaTBb77fRqyFh2iClaA+4+CAMA
         4sXFVQTYERHBnx58mODFu3vB+rfEA15mUw5IoQ3FfSeWGzDx9QS73wVX+60bjM3ARcnN
         FdCkt1RtZr9gvxarvWw9UrRN8olAppO4jV7fqwV06wMoi3TBMnRncM5ra6DngiZXkdqO
         NsuYW8+oeLlz35cGvA0kSaSiDWSMksBSIwUoeg5c2nkvGPxUsSrMoXVoIVHajHIOG+ZO
         aCxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NrliFGKLE6GsRxqqWvTJbatPN+Tvql6xRPWE2j+Cokk=;
        b=A2St/b2fwwR848ivy1UeEmlVWebjrwbrypl2YOEYTK33s9gFZf7TbJTal0HhA5zXdq
         h4WuVyQfLcPz1PaNYEytAXTZ7GMoA7fQw3llPB263OIJ1aHcLDPfwTU87VNjzSCZ/51m
         BL05QHM9glVLAaU1i1ttmzK0PTC17Tpcidbsxqc3l64vZcJeb21DDB/oJIiEGjLOSRn1
         T4UT+gnx3jfwggOcwIIPy034rAcuixG4K6EWOjWiMuh41s3i9HqRjNOWCCSKvaG6vdUP
         i27APbuZRG1fJy7oiKWsrCUS0PEuyD+rYEyc8K1mTwoBs2N4IR4ucPOfMva5MnzFt99i
         Pzyw==
X-Gm-Message-State: AOAM5321rQ8tgAtohW69PiDalmArOvSIo/nT869LM98yEqVziIqkGBJT
        W0mUD63WYoydmweczfXa+s9AEggp7mc=
X-Google-Smtp-Source: ABdhPJz5LPxzAHF7cwf2oZHDiDmVl6SS6F51tqmjfK7fhWOQA6szRLrBkT6ipWfhfYUHmg1daZ7k8w==
X-Received: by 2002:a50:9d0a:: with SMTP id v10mr7414594ede.144.1601140675375;
        Sat, 26 Sep 2020 10:17:55 -0700 (PDT)
Received: from xws.fritz.box (pd9e5ae20.dip0.t-ipconnect.de. [217.229.174.32])
        by smtp.gmail.com with ESMTPSA id u13sm4625589ejn.82.2020.09.26.10.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2020 10:17:54 -0700 (PDT)
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
Subject: [PATCH 4/5] platform/surface: Move Surface 3 Power OpRegion driver to platform/surface
Date:   Sat, 26 Sep 2020 19:17:13 +0200
Message-Id: <20200926171714.721406-5-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200926171714.721406-1-luzmaximilian@gmail.com>
References: <20200926171714.721406-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the Surface 3 Power operation region driver from platform/x86 to
the newly created platform/surface directory.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>
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
index 33c178100efa..fbb9556fa688 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -869,13 +869,6 @@ config INTEL_VBTN
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

