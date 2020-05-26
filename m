Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2331C76D2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 May 2020 18:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730183AbgEFQo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 May 2020 12:44:28 -0400
Received: from foss.arm.com ([217.140.110.172]:40992 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730073AbgEFQoU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 12:44:20 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C1461101E;
        Wed,  6 May 2020 09:44:19 -0700 (PDT)
Received: from usa.arm.com (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 72E953F305;
        Wed,  6 May 2020 09:44:18 -0700 (PDT)
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Steven Price <steven.price@arm.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        harb@amperecomputing.com
Subject: [PATCH v3 1/7] firmware: smccc: Add HAVE_ARM_SMCCC_DISCOVERY to identify SMCCC v1.1 and above
Date:   Wed,  6 May 2020 17:44:05 +0100
Message-Id: <20200506164411.3284-2-sudeep.holla@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200506164411.3284-1-sudeep.holla@arm.com>
References: <20200506164411.3284-1-sudeep.holla@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SMCCC v1.0 lacked discoverability of version and features. To accelerate
adoption of few mitigations and protect systems more rapidly from various
vulnerability, PSCI v1.0 was updated to add SMCCC discovery mechanism
though the PSCI firmware implementation of PSCI_FEATURES(SMCCC_VERSION)
which returns success on firmware compliant to SMCCC v1.1 and above.

This inturn makes SMCCC v1.1 and above dependent on ARM_PSCI_FW for
backward compatibility. Let us introduce a new hidden config for the
same to build more features on top of SMCCC v1.1 and above.

While at it, also sort alphabetically the psci entry.

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/firmware/Kconfig       |  6 ++----
 drivers/firmware/smccc/Kconfig | 17 +++++++++++++++++
 2 files changed, 19 insertions(+), 4 deletions(-)
 create mode 100644 drivers/firmware/smccc/Kconfig

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index 8007d4aa76dc..4843e94713a4 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -295,15 +295,13 @@ config TURRIS_MOX_RWTM
 	  other manufacturing data and also utilize the Entropy Bit Generator
 	  for hardware random number generation.
 
-config HAVE_ARM_SMCCC
-	bool
-
-source "drivers/firmware/psci/Kconfig"
 source "drivers/firmware/broadcom/Kconfig"
 source "drivers/firmware/google/Kconfig"
 source "drivers/firmware/efi/Kconfig"
 source "drivers/firmware/imx/Kconfig"
 source "drivers/firmware/meson/Kconfig"
+source "drivers/firmware/psci/Kconfig"
+source "drivers/firmware/smccc/Kconfig"
 source "drivers/firmware/tegra/Kconfig"
 source "drivers/firmware/xilinx/Kconfig"
 
diff --git a/drivers/firmware/smccc/Kconfig b/drivers/firmware/smccc/Kconfig
new file mode 100644
index 000000000000..d93f1ab52cb2
--- /dev/null
+++ b/drivers/firmware/smccc/Kconfig
@@ -0,0 +1,17 @@
+# SPDX-License-Identifier: GPL-2.0-only
+config HAVE_ARM_SMCCC
+	bool
+	help
+	  Include support for the Secure Monitor Call (SMC) and Hypervisor
+	  Call (HVC) instructions on Armv7 and above architectures.
+
+config HAVE_ARM_SMCCC_DISCOVERY
+	bool
+	depends on ARM_PSCI_FW
+	default y
+	help
+	 SMCCC v1.0 lacked discoverability and hence PSCI v1.0 was updated
+	 to add SMCCC discovery mechanism though the PSCI firmware
+	 implementation of PSCI_FEATURES(SMCCC_VERSION) which returns
+	 success on firmware compliant to SMCCC v1.1 and above.
+
-- 
2.17.1

