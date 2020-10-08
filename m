Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCCF228762D
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 16:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730673AbgJHOfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 10:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730655AbgJHOf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 10:35:28 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B7DDC0613D3;
        Thu,  8 Oct 2020 07:35:28 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id 33so6029374edq.13;
        Thu, 08 Oct 2020 07:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NqaJ51EXPvZCqqLQUo3ryVOLCQr5ZMYt3vugfzRfrK0=;
        b=RoYUTHJfVJqABI/0nzomh6A+KmpMGrKUoO0nMt3iiQeC0rRPEiB1cOvPyuyEE9MUqM
         YDq6995HWtuHOGXze62/L3zYMl50xZQX3TDyYbAK0PuijVyqukZ4ajYVVBBAtTxKtC97
         6pJadbidhgk0keG7EY7488eRR/QeDasVAJinPzgDNjyR6lDb0hFU8ICwK4VrOr8gmBbI
         kJriXRhgp/PO7TqpQdMmYli9bP1WBZVgFKljgtK6XwSkjulPzhn/8eeSOzi1Mpg1x66X
         IeCV9hmfcXvSmYap7CplPjR3bnkLYbpi92YQwb0JdBSql36YRF+SRqoFCVekz6hl6bn3
         n55g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NqaJ51EXPvZCqqLQUo3ryVOLCQr5ZMYt3vugfzRfrK0=;
        b=bgc678OoIQuqtOT5Wgg+54JVcvAqILi3Mo7pFZTyhE5H2CLY8yPa44It+XTA2DbS1n
         JqqteLFcMJQxtddQtTk6TeWxXHoC/liJg2eQ3aSp9TvIp/9Lo9kVclY3DVGS/gXx9FEd
         ZtUN7yPd9P3wGsZ48DFq+hi7baTtv3LdnfZhkSqRqxQXTGQsy2d/bk0Q9fBdWRukNcBo
         E8IT8pdODARSsK43ojuA/C3sRB08hUfvp5Ck9KleWEE6VcYqPD9eYdqECH9T5NDekjg9
         DZ7V9WUYCKKzJvb6hrwSO/bgGiXyrXlMVb17onPse7l+GeiTg89mU7OH0gkcr4yEfW48
         3L1w==
X-Gm-Message-State: AOAM530zWgr09GvAh/GXXRrr4udQ8qMb+g/Iyl1lW7ZbvNuIb312gYjR
        WvVxjvkCAYeNq8Dcq1JEaKnVMrFUABA=
X-Google-Smtp-Source: ABdhPJxnqQ55XoJeBEFRENK/zxB/VEZaFTWYUpOYubnrMlf+lSed7w+1E6E6W6pkwOGNovFtsbUPCg==
X-Received: by 2002:aa7:c586:: with SMTP id g6mr5851078edq.343.1602167726091;
        Thu, 08 Oct 2020 07:35:26 -0700 (PDT)
Received: from xws.fritz.box (pd9e5a9e4.dip0.t-ipconnect.de. [217.229.169.228])
        by smtp.gmail.com with ESMTPSA id b8sm4123763edv.20.2020.10.08.07.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 07:35:25 -0700 (PDT)
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
Subject: [PATCH v3 5/5] platform/surface: Move Surface Pro 3 Button driver to platform/surface
Date:   Thu,  8 Oct 2020 16:34:55 +0200
Message-Id: <20201008143455.340599-6-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201008143455.340599-1-luzmaximilian@gmail.com>
References: <20201008143455.340599-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the Surface Pro 3 Button driver from platform/x86 to the newly
created platform/surface directory.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 MAINTAINERS                                            | 2 +-
 drivers/platform/surface/Kconfig                       | 6 ++++++
 drivers/platform/surface/Makefile                      | 1 +
 drivers/platform/{x86 => surface}/surfacepro3_button.c | 0
 drivers/platform/x86/Kconfig                           | 6 ------
 drivers/platform/x86/Makefile                          | 3 ---
 6 files changed, 8 insertions(+), 10 deletions(-)
 rename drivers/platform/{x86 => surface}/surfacepro3_button.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1c5be5875769..2ea51dee885f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11545,7 +11545,7 @@ MICROSOFT SURFACE PRO 3 BUTTON DRIVER
 M:	Chen Yu <yu.c.chen@intel.com>
 L:	platform-driver-x86@vger.kernel.org
 S:	Supported
-F:	drivers/platform/x86/surfacepro3_button.c
+F:	drivers/platform/surface/surfacepro3_button.c
 
 MICROTEK X6 SCANNER
 M:	Oliver Neukum <oliver@neukum.org>
diff --git a/drivers/platform/surface/Kconfig b/drivers/platform/surface/Kconfig
index 2af26379804c..fcd80e860132 100644
--- a/drivers/platform/surface/Kconfig
+++ b/drivers/platform/surface/Kconfig
@@ -40,4 +40,10 @@ config SURFACE_3_POWER_OPREGION
 	  This driver provides support for ACPI operation
 	  region of the Surface 3 battery platform driver.
 
+config SURFACE_PRO3_BUTTON
+	tristate "Power/home/volume buttons driver for Microsoft Surface Pro 3/4 tablet"
+	depends on ACPI && INPUT
+	help
+	  This driver handles the power/home/volume buttons on the Microsoft Surface Pro 3/4 tablet.
+
 endif # SURFACE_PLATFORM
diff --git a/drivers/platform/surface/Makefile b/drivers/platform/surface/Makefile
index 4940d4db58b2..dcb1df06d57a 100644
--- a/drivers/platform/surface/Makefile
+++ b/drivers/platform/surface/Makefile
@@ -7,3 +7,4 @@
 obj-$(CONFIG_SURFACE3_WMI)		+= surface3-wmi.o
 obj-$(CONFIG_SURFACE_3_BUTTON)		+= surface3_button.o
 obj-$(CONFIG_SURFACE_3_POWER_OPREGION)	+= surface3_power.o
+obj-$(CONFIG_SURFACE_PRO3_BUTTON)	+= surfacepro3_button.o
diff --git a/drivers/platform/x86/surfacepro3_button.c b/drivers/platform/surface/surfacepro3_button.c
similarity index 100%
rename from drivers/platform/x86/surfacepro3_button.c
rename to drivers/platform/surface/surfacepro3_button.c
diff --git a/drivers/platform/x86/Kconfig b/drivers/platform/x86/Kconfig
index 8417ee0178d0..6083f8241b7d 100644
--- a/drivers/platform/x86/Kconfig
+++ b/drivers/platform/x86/Kconfig
@@ -870,12 +870,6 @@ config INTEL_VBTN
 	  To compile this driver as a module, choose M here: the module will
 	  be called intel_vbtn.
 
-config SURFACE_PRO3_BUTTON
-	tristate "Power/home/volume buttons driver for Microsoft Surface Pro 3/4 tablet"
-	depends on ACPI && INPUT
-	help
-	  This driver handles the power/home/volume buttons on the Microsoft Surface Pro 3/4 tablet.
-
 config MSI_LAPTOP
 	tristate "MSI Laptop Extras"
 	depends on ACPI
diff --git a/drivers/platform/x86/Makefile b/drivers/platform/x86/Makefile
index ffa31f57d9a2..aeff497e23a5 100644
--- a/drivers/platform/x86/Makefile
+++ b/drivers/platform/x86/Makefile
@@ -81,9 +81,6 @@ obj-$(CONFIG_INTEL_MENLOW)		+= intel_menlow.o
 obj-$(CONFIG_INTEL_OAKTRAIL)		+= intel_oaktrail.o
 obj-$(CONFIG_INTEL_VBTN)		+= intel-vbtn.o
 
-# Microsoft
-obj-$(CONFIG_SURFACE_PRO3_BUTTON)	+= surfacepro3_button.o
-
 # MSI
 obj-$(CONFIG_MSI_LAPTOP)	+= msi-laptop.o
 obj-$(CONFIG_MSI_WMI)		+= msi-wmi.o
-- 
2.28.0

