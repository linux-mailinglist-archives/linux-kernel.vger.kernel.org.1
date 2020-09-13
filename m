Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 246012681F0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 01:57:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726001AbgIMX5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Sep 2020 19:57:17 -0400
Received: from mga18.intel.com ([134.134.136.126]:50540 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725975AbgIMX5P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Sep 2020 19:57:15 -0400
IronPort-SDR: tldXAmCVWOE+MI9q/5f01ScrnkRl11Be7oIXEsZkbnluAplcP/A3xb0WzKWxqt3nyOwDg2IAgV
 dhddeISfIFiw==
X-IronPort-AV: E=McAfee;i="6000,8403,9743"; a="146746554"
X-IronPort-AV: E=Sophos;i="5.76,424,1592895600"; 
   d="scan'208";a="146746554"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2020 16:57:13 -0700
IronPort-SDR: DYxWBjumKk/K0imlpU3Cr1MbCTVUOGhw/jxHwypmy8bw1w9EChjcx6QGUJWs+W2/mwhymUlHvY
 36+1RL9FP7vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,424,1592895600"; 
   d="scan'208";a="305973466"
Received: from wwanmoha-ilbpg2.png.intel.com ([10.88.227.42])
  by orsmga006.jf.intel.com with ESMTP; 13 Sep 2020 16:57:11 -0700
From:   Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
To:     kishon@ti.com, vkoul@kernel.org, robh+dt@kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        andriy.shevchenko@linux.intel.com,
        vadivel.muruganx.ramuthevar@linux.intel.com,
        eswara.kota@linux.intel.com,
        lakshmi.bai.raja.subramanian@intel.com,
        wan.ahmad.zainie.wan.mohamad@intel.com
Subject: [PATCH v9 1/3] phy: intel: Rename phy-intel to phy-intel-lgm
Date:   Mon, 14 Sep 2020 07:55:20 +0800
Message-Id: <20200913235522.4316-2-wan.ahmad.zainie.wan.mohamad@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200913235522.4316-1-wan.ahmad.zainie.wan.mohamad@intel.com>
References: <20200913235522.4316-1-wan.ahmad.zainie.wan.mohamad@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rename phy-intel-{combo,emmc}.c to phy-intel-lgm-{combo,emmc}.c
to make drivers/phy/intel directory more generic for future use.

Signed-off-by: Wan Ahmad Zainie <wan.ahmad.zainie.wan.mohamad@intel.com>
Reviewed-by: Ramuthevar Vadivel Murugan <vadivel.muruganx.ramuthevar@linux.intel.com>
---
 drivers/phy/intel/Kconfig                              | 10 +++++-----
 drivers/phy/intel/Makefile                             |  4 ++--
 .../intel/{phy-intel-combo.c => phy-intel-lgm-combo.c} |  0
 .../intel/{phy-intel-emmc.c => phy-intel-lgm-emmc.c}   |  0
 4 files changed, 7 insertions(+), 7 deletions(-)
 rename drivers/phy/intel/{phy-intel-combo.c => phy-intel-lgm-combo.c} (100%)
 rename drivers/phy/intel/{phy-intel-emmc.c => phy-intel-lgm-emmc.c} (100%)

diff --git a/drivers/phy/intel/Kconfig b/drivers/phy/intel/Kconfig
index 7b47682a4e0e..db8586c3eed8 100644
--- a/drivers/phy/intel/Kconfig
+++ b/drivers/phy/intel/Kconfig
@@ -1,9 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0
 #
-# Phy drivers for Intel Lightning Mountain(LGM) platform
+# Phy drivers for Intel platforms
 #
-config PHY_INTEL_COMBO
-	bool "Intel ComboPHY driver"
+config PHY_INTEL_LGM_COMBO
+	bool "Intel Lightning Mountain ComboPHY driver"
 	depends on X86 || COMPILE_TEST
 	depends on OF && HAS_IOMEM
 	select MFD_SYSCON
@@ -16,8 +16,8 @@ config PHY_INTEL_COMBO
 	  chipsets which provides PHYs for various controllers, EMAC,
 	  SATA and PCIe.
 
-config PHY_INTEL_EMMC
-	tristate "Intel EMMC PHY driver"
+config PHY_INTEL_LGM_EMMC
+	tristate "Intel Lightning Mountain EMMC PHY driver"
 	depends on X86 || COMPILE_TEST
 	select GENERIC_PHY
 	help
diff --git a/drivers/phy/intel/Makefile b/drivers/phy/intel/Makefile
index 233d530dadde..662385d0a366 100644
--- a/drivers/phy/intel/Makefile
+++ b/drivers/phy/intel/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_PHY_INTEL_COMBO)		+= phy-intel-combo.o
-obj-$(CONFIG_PHY_INTEL_EMMC)            += phy-intel-emmc.o
+obj-$(CONFIG_PHY_INTEL_LGM_COMBO)	+= phy-intel-lgm-combo.o
+obj-$(CONFIG_PHY_INTEL_LGM_EMMC)	+= phy-intel-lgm-emmc.o
diff --git a/drivers/phy/intel/phy-intel-combo.c b/drivers/phy/intel/phy-intel-lgm-combo.c
similarity index 100%
rename from drivers/phy/intel/phy-intel-combo.c
rename to drivers/phy/intel/phy-intel-lgm-combo.c
diff --git a/drivers/phy/intel/phy-intel-emmc.c b/drivers/phy/intel/phy-intel-lgm-emmc.c
similarity index 100%
rename from drivers/phy/intel/phy-intel-emmc.c
rename to drivers/phy/intel/phy-intel-lgm-emmc.c
-- 
2.17.1

