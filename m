Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FC5E2EB349
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 20:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728440AbhAETEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 14:04:53 -0500
Received: from mail.kernel.org ([198.145.29.99]:35038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727718AbhAETEv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 14:04:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5906D22D57;
        Tue,  5 Jan 2021 19:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609873451;
        bh=m7F7jxxf4ap/Rx2gdRXtLy9isGEOULchCtP0u2gWK0k=;
        h=From:To:Cc:Subject:Date:From;
        b=eFrrIermqvjQT7gdpmnWlTaCTAW7UEa0q5L1WN0EmY3+dW2gbfgscP1wPQNB0q9tM
         dAI8Cv+4LtIXV8T7aTlMG5XVr+C5eM2o6M0HUI3x2xq+Z2a3W6xa8chZVopTejg9HC
         4NunOXY1nNyNw3l0ix4ebnb+mgRRZVmUA/dyZmqczWNLxhX/mDtOUD9y+L2/LY6Xy9
         UPtuCYOXMfKyDAasHxFJ+HIvAQ2brV/kVe4YGXZuIGn1gGU/BjddYdVpj/QF4B29D1
         IvWctyMH4iz5kCcgFdF87rQVl00JSz+OmtwYS8Oc6qL2HTCgUQ452y2EVcDGMPBGTg
         0eXV1hLYR7JCQ==
From:   Dinh Nguyen <dinguyen@kernel.org>
To:     devicetree@vger.kernel.org
Cc:     dinguyen@kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org
Subject: [PATCH] arm64: dts: n5x: Add support for Intel's eASIC N5X platform
Date:   Tue,  5 Jan 2021 13:04:03 -0600
Message-Id: <20210105190403.2054948-1-dinguyen@kernel.org>
X-Mailer: git-send-email 2.30.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Intel eASIC N5X platform shares the same register map as the Agilex
platform, thus, we can re-use the socfpga_agilex.dtsi as the base
DTSI.

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 arch/arm64/Kconfig.platforms                  |  5 ++
 arch/arm64/boot/dts/intel/Makefile            |  1 +
 .../boot/dts/intel/socfpga_n5x_socdk.dts      | 53 +++++++++++++++++++
 3 files changed, 59 insertions(+)
 create mode 100644 arch/arm64/boot/dts/intel/socfpga_n5x_socdk.dts

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 6eecdef538bd..c20eacd9a931 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -13,6 +13,11 @@ config ARCH_AGILEX
 	help
 	  This enables support for Intel's Agilex SoCFPGA Family.
 
+config ARCH_N5X
+	bool "Intel's eASIC N5X SoCFPGA Family"
+	help
+	  This enables support for Intel's eASIC N5X SoCFPGA Family.
+
 config ARCH_SUNXI
 	bool "Allwinner sunxi 64-bit SoC Family"
 	select ARCH_HAS_RESET_CONTROLLER
diff --git a/arch/arm64/boot/dts/intel/Makefile b/arch/arm64/boot/dts/intel/Makefile
index 296eceec4276..3a052540605b 100644
--- a/arch/arm64/boot/dts/intel/Makefile
+++ b/arch/arm64/boot/dts/intel/Makefile
@@ -2,3 +2,4 @@
 dtb-$(CONFIG_ARCH_AGILEX) += socfpga_agilex_socdk.dtb \
 			     socfpga_agilex_socdk_nand.dtb
 dtb-$(CONFIG_ARCH_KEEMBAY) += keembay-evm.dtb
+dtb-$(CONFIG_ARCH_N5X) += socfpga_n5x_socdk.dtb
diff --git a/arch/arm64/boot/dts/intel/socfpga_n5x_socdk.dts b/arch/arm64/boot/dts/intel/socfpga_n5x_socdk.dts
new file mode 100644
index 000000000000..5f56e2697fee
--- /dev/null
+++ b/arch/arm64/boot/dts/intel/socfpga_n5x_socdk.dts
@@ -0,0 +1,53 @@
+// SPDX-License-Identifier:     GPL-2.0
+/*
+ * Copyright (C) 2021, Intel Corporation
+ */
+#include "socfpga_agilex.dtsi"
+
+/ {
+	model = "eASIC N5X SoCDK";
+
+	aliases {
+		serial0 = &uart0;
+		ethernet0 = &gmac0;
+		ethernet1 = &gmac1;
+		ethernet2 = &gmac2;
+	};
+
+	chosen {
+		stdout-path = "serial0:115200n8";
+	};
+
+	memory {
+		device_type = "memory";
+		/* We expect the bootloader to fill in the reg */
+		reg = <0 0 0 0>;
+	};
+
+	soc {
+		clocks {
+			osc1 {
+				clock-frequency = <25000000>;
+			};
+		};
+	};
+};
+
+&clkmgr {
+	compatible = "intel,easic-n5x-clkmgr";
+};
+
+&mmc {
+	status = "okay";
+	cap-sd-highspeed;
+	broken-cd;
+	bus-width = <4>;
+};
+
+&uart0 {
+	status = "okay";
+};
+
+&watchdog0 {
+	status = "okay";
+};
-- 
2.30.0

