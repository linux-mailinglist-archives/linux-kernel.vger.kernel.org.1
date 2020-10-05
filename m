Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56E2A283BF3
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 18:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbgJEQDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 12:03:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727707AbgJEQDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 12:03:38 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4163C0613CE;
        Mon,  5 Oct 2020 09:03:37 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id c22so11424465ejx.0;
        Mon, 05 Oct 2020 09:03:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DGhCGthpGnpGVEJv/+ZRguWk8wCmOwJoA9fKbUTSkJM=;
        b=H+AG5dHv93Ve+EOaV05DP3+2fQOseMJpl7DrYzVJvwa1bWQmwFdF6TF24/qvfAjhys
         PRE6cKzb+50GHa584QvgYCkeXjZWHbk/nY7IKpach6Jnx3j588cOpohL7jthIo47VQdE
         xNz3er2OZZWvRICLOX6314JI4FXHTO8/wjlxpglzaMj7nRb43KdoTIHwGw8mJVV2VVhm
         L0KTY6mhEPdspfAESXn6kbPL4ZCdlAjU9FfAMMjkefgK6zpZt05XQV6ttucZySnY7CTw
         pBno+HXhsUljK6NCTInB5VRbb4/hXtWRs9qK5A+XcceQebjj1UJoTEYQHjalvN9Tfc6j
         ahDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DGhCGthpGnpGVEJv/+ZRguWk8wCmOwJoA9fKbUTSkJM=;
        b=eQAyW+fYuxyux9oFAMW6W9I3gr+1LVMgfHBFKiAKU4a3f+hDb5KV65lk0xvnm3/rJw
         2ajv5v7dju3v8pFfzkIHKHkd2ScOp/xiikfJEtSKOug/uarkaMm9iMp/v323YCz+OQPJ
         XP13ZiClUueAwXMEWFzCTslugHvcxz8eLSV5FvPELYo1eUKVKGFUxntWBJyOAx13YFNv
         QzGKc0IoOVf9/IBTel3uRZWCHjR2wCRBTdvgLCRJV813VmBbE9l4dd4e+xeK9Ibxwr3+
         WDBdEe2p3UKfgDkpzWUYEfAXvfPxlysSv9gSPkvlh424CmmjVSOYBcjrG4PDPRvnI4d8
         kArA==
X-Gm-Message-State: AOAM5311jEOwLjXTDIsZKplLpT1gxT89pai/qy5U/zZ8jJ+5wNiDbiX6
        sJ2mtuHf3zarRhNd/QbjesARtXs4Up4=
X-Google-Smtp-Source: ABdhPJzPwBJEYEc9s4YUjTTZT8SZU/fBBqj3gJ9pgS+MQ1seJota137+Eu6wSYCA16mWXV2D9+7JJA==
X-Received: by 2002:a17:906:7254:: with SMTP id n20mr406762ejk.382.1601913816191;
        Mon, 05 Oct 2020 09:03:36 -0700 (PDT)
Received: from xws.fritz.box (pd9e5a952.dip0.t-ipconnect.de. [217.229.169.82])
        by smtp.gmail.com with ESMTPSA id y3sm51788ejk.92.2020.10.05.09.03.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 09:03:35 -0700 (PDT)
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
Subject: [PATCH v2 4/5] platform/surface: Move Surface 3 Power OpRegion driver to platform/surface
Date:   Mon,  5 Oct 2020 18:03:06 +0200
Message-Id: <20201005160307.39201-5-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201005160307.39201-1-luzmaximilian@gmail.com>
References: <20201005160307.39201-1-luzmaximilian@gmail.com>
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

