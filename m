Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A07B62FE3D5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 08:24:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727449AbhAUHXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 02:23:24 -0500
Received: from mail.kernel.org ([198.145.29.99]:40550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727195AbhAUHUA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 02:20:00 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4CF91239E7;
        Thu, 21 Jan 2021 07:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611213508;
        bh=pNzT4ZXdfbyQJ787t9mEl9rU6uPQH/3r0bnIT/3lt4U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nkPi4gPBWQfXAYQvAC08IA8EJv2L9M5QpSUabfH0P8/HfUJK5RX7OAXiNGwuzOSy9
         IVt9SymCk+IXEVu6fzoS2Ucv3txg6mA1BJ/J8EXrrXgTIoBn0z0KKDZWahyit6+OVH
         yon+Ir5TqFmQ4ec5OefKBQgEJzl3ah+cjIARJVwyjyDRCRjl8wYozUdUZaykn0Qgu7
         cAAHln8Kj4fB00YawJ5221GIWxLHpfiW2MY9TLMbxjg2eR6K6nQNZ7mK3ufXYT47ZJ
         2ZTyTSlZPyG+/EE5x5L3ZIyCcSwGmM0EjoC2mU4n2OOGziPHBRyb16gQ8pPm0Lp8TV
         vYlcMIWBmnfyA==
Received: by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1l2UEb-004BsZ-QE; Thu, 21 Jan 2021 08:18:25 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mayulong <mayulong1@huawei.com>,
        Rob Herring <robh+dt@kernel.org>, devel@driverdev.osuosl.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 19/21] mfd: hi6421-spmi-pmic: move driver from staging
Date:   Thu, 21 Jan 2021 08:18:21 +0100
Message-Id: <97696bbe44202ae4af15c4f799de65dca7de6d37.1611212783.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1611212783.git.mchehab+huawei@kernel.org>
References: <cover.1611212783.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver is ready for mainstream. So, move it out of staging.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../mfd}/hisilicon,hi6421-spmi-pmic.yaml         |  0
 MAINTAINERS                                      |  7 +++++++
 drivers/mfd/Kconfig                              | 15 +++++++++++++++
 drivers/mfd/Makefile                             |  1 +
 .../{staging/hikey9xx => mfd}/hi6421-spmi-pmic.c |  0
 drivers/staging/hikey9xx/Kconfig                 | 16 ----------------
 drivers/staging/hikey9xx/Makefile                |  1 -
 7 files changed, 23 insertions(+), 17 deletions(-)
 rename {drivers/staging/hikey9xx => Documentation/devicetree/bindings/mfd}/hisilicon,hi6421-spmi-pmic.yaml (100%)
 rename drivers/{staging/hikey9xx => mfd}/hi6421-spmi-pmic.c (100%)

diff --git a/drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml b/Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml
similarity index 100%
rename from drivers/staging/hikey9xx/hisilicon,hi6421-spmi-pmic.yaml
rename to Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml
diff --git a/MAINTAINERS b/MAINTAINERS
index 056777397c68..120f14620f56 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8006,6 +8006,13 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/spmi/hisilicon,hisi-spmi-controller.yaml
 F:	drivers/spmi/hisi-spmi-controller.c
 
+HISILICON SPMI PMIC DRIVER FOR HIKEY 6421v600
+M:	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/mfd/hisilicon,hi6421-spmi-pmic.yaml
+F:	drivers/mfd/hi6421-spmi-pmic.c
+
 HISILICON STAGING DRIVERS FOR HIKEY 960/970
 M:	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
 L:	devel@driverdev.osuosl.org
diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 8b99a13669bf..c04c2f6be1d9 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -509,6 +509,21 @@ config MFD_HI6421_PMIC
 	  menus in order to enable them.
 	  We communicate with the Hi6421 via memory-mapped I/O.
 
+config MFD_HI6421_SPMI
+	tristate "HiSilicon Hi6421v600 SPMI PMU/Codec IC"
+	depends on OF
+	depends on SPMI
+	select MFD_CORE
+	help
+	  Add support for HiSilicon Hi6421v600 SPMI PMIC. Hi6421 includes
+	  multi-functions, such as regulators, RTC, codec, Coulomb counter,
+	  etc.
+
+	  This driver includes core APIs _only_. You have to select
+	  individual components like voltage regulators under corresponding
+	  menus in order to enable them.
+	  We communicate with the Hi6421v600 via a SPMI bus.
+
 config MFD_HI655X_PMIC
 	tristate "HiSilicon Hi655X series PMU/Codec IC"
 	depends on ARCH_HISI || COMPILE_TEST
diff --git a/drivers/mfd/Makefile b/drivers/mfd/Makefile
index 1780019d2474..7744993c42bc 100644
--- a/drivers/mfd/Makefile
+++ b/drivers/mfd/Makefile
@@ -233,6 +233,7 @@ obj-$(CONFIG_MFD_IPAQ_MICRO)	+= ipaq-micro.o
 obj-$(CONFIG_MFD_IQS62X)	+= iqs62x.o
 obj-$(CONFIG_MFD_MENF21BMC)	+= menf21bmc.o
 obj-$(CONFIG_MFD_HI6421_PMIC)	+= hi6421-pmic-core.o
+obj-$(CONFIG_MFD_HI6421_SPMI)	+= hi6421-spmi-pmic.o
 obj-$(CONFIG_MFD_HI655X_PMIC)   += hi655x-pmic.o
 obj-$(CONFIG_MFD_DLN2)		+= dln2.o
 obj-$(CONFIG_MFD_RT5033)	+= rt5033.o
diff --git a/drivers/staging/hikey9xx/hi6421-spmi-pmic.c b/drivers/mfd/hi6421-spmi-pmic.c
similarity index 100%
rename from drivers/staging/hikey9xx/hi6421-spmi-pmic.c
rename to drivers/mfd/hi6421-spmi-pmic.c
diff --git a/drivers/staging/hikey9xx/Kconfig b/drivers/staging/hikey9xx/Kconfig
index 6dc9f9307510..76337be330f8 100644
--- a/drivers/staging/hikey9xx/Kconfig
+++ b/drivers/staging/hikey9xx/Kconfig
@@ -11,22 +11,6 @@ config PHY_HI3670_USB
 
 	  To compile this driver as a module, choose M here.
 
-# to be placed at drivers/mfd
-config MFD_HI6421_SPMI
-	tristate "HiSilicon Hi6421v600 SPMI PMU/Codec IC"
-	depends on OF
-	depends on SPMI
-	select MFD_CORE
-	help
-	  Add support for HiSilicon Hi6421v600 SPMI PMIC. Hi6421 includes
-	  multi-functions, such as regulators, RTC, codec, Coulomb counter,
-	  etc.
-
-	  This driver includes core APIs _only_. You have to select
-	  individual components like voltage regulators under corresponding
-	  menus in order to enable them.
-	  We communicate with the Hi6421v600 via a SPMI bus.
-
 # to be placed at drivers/regulator
 config REGULATOR_HI6421V600
 	tristate "HiSilicon Hi6421v600 PMIC voltage regulator support"
diff --git a/drivers/staging/hikey9xx/Makefile b/drivers/staging/hikey9xx/Makefile
index 64b419cf7bca..d26af65baf8b 100644
--- a/drivers/staging/hikey9xx/Makefile
+++ b/drivers/staging/hikey9xx/Makefile
@@ -2,5 +2,4 @@
 
 obj-$(CONFIG_PHY_HI3670_USB)		+= phy-hi3670-usb3.o
 
-obj-$(CONFIG_MFD_HI6421_SPMI)		+= hi6421-spmi-pmic.o
 obj-$(CONFIG_REGULATOR_HI6421V600)	+= hi6421v600-regulator.o
-- 
2.29.2

