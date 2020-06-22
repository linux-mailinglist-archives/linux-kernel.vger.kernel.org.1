Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1907203931
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jun 2020 16:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729570AbgFVO0x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 10:26:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:48530 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729523AbgFVO0u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 10:26:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 937DEC1AB;
        Mon, 22 Jun 2020 14:26:46 +0000 (UTC)
From:   =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
To:     linux-realtek-soc@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        James Tai <james.tai@realtek.com>,
        =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: [PATCH v4 3/3] arm64: dts: realtek: Add RTD1319 SoC and Realtek Pym Particles EVB
Date:   Sun, 21 Jun 2020 01:32:27 +0200
Message-Id: <20200620233227.31585-4-afaerber@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200620233227.31585-1-afaerber@suse.de>
References: <20200620233227.31585-1-afaerber@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Tai <james.tai@realtek.com>

Add Device Trees for Realtek RTD1319 SoC family, RTD1319 SoC and
Realtek Pym Particles EVB.

Signed-off-by: James Tai <james.tai@realtek.com>
Signed-off-by: Andreas Färber <afaerber@suse.de>
---
 v3 -> v4:
 * Updated Realtek copyright for 2 out of 3 files from v3
 * Renamed from rtd1319-pymparticle.dts to rtd1319-pymparticles.dts
 * Updated compatible from pymparticle to pym-particles
 * Updated PMU compatible from armv8-pmuv3 to cortex-a55-pmu (Robin)
 
 v2 -> v3:
 * Add virtual maintenance interrupt for architecture timer
 * Correct the GIC redistributor address range
 
 v1 -> v2:
 * Reserve the boot ROM address
 * Reserve boot loader address
 * Reserve audio/video FW address
 * Reserve RPC and ring buffer address
 * Reserve TEE address
 * Support 1 GiB RAM by default
 * Reduce rbus range to 2 MiB
 * Apply the syscon for ISO,MISC,CRT,SB2,SCPU_WRAPPER
 * Adjust compatible strings order in document
 
 arch/arm64/boot/dts/realtek/Makefile          |   2 +
 .../boot/dts/realtek/rtd1319-pymparticles.dts |  43 ++++
 arch/arm64/boot/dts/realtek/rtd1319.dtsi      |  12 +
 arch/arm64/boot/dts/realtek/rtd13xx.dtsi      | 213 ++++++++++++++++++
 4 files changed, 270 insertions(+)
 create mode 100644 arch/arm64/boot/dts/realtek/rtd1319-pymparticles.dts
 create mode 100644 arch/arm64/boot/dts/realtek/rtd1319.dtsi
 create mode 100644 arch/arm64/boot/dts/realtek/rtd13xx.dtsi

diff --git a/arch/arm64/boot/dts/realtek/Makefile b/arch/arm64/boot/dts/realtek/Makefile
index ef8d8fcbaa05..83708596726d 100644
--- a/arch/arm64/boot/dts/realtek/Makefile
+++ b/arch/arm64/boot/dts/realtek/Makefile
@@ -9,6 +9,8 @@ dtb-$(CONFIG_ARCH_REALTEK) += rtd1295-zidoo-x9s.dtb
 
 dtb-$(CONFIG_ARCH_REALTEK) += rtd1296-ds418.dtb
 
+dtb-$(CONFIG_ARCH_REALTEK) += rtd1319-pymparticles.dtb
+
 dtb-$(CONFIG_ARCH_REALTEK) += rtd1395-bpi-m4.dtb
 dtb-$(CONFIG_ARCH_REALTEK) += rtd1395-lionskin.dtb
 
diff --git a/arch/arm64/boot/dts/realtek/rtd1319-pymparticles.dts b/arch/arm64/boot/dts/realtek/rtd1319-pymparticles.dts
new file mode 100644
index 000000000000..e0b3c3707a85
--- /dev/null
+++ b/arch/arm64/boot/dts/realtek/rtd1319-pymparticles.dts
@@ -0,0 +1,43 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
+/*
+ * Copyright (c) 2019-2020 Realtek Semiconductor Corp.
+ */
+
+/dts-v1/;
+
+#include "rtd1319.dtsi"
+
+/ {
+	compatible = "realtek,pym-particles", "realtek,rtd1319";
+	model = "Realtek Pym Particles EVB";
+
+	memory@2e000 {
+		device_type = "memory";
+		reg = <0x2e000 0x3ffd2000>; /* boot ROM to 1 GiB or 2 GiB */
+	};
+
+	chosen {
+		stdout-path = "serial0:460800n8";
+	};
+
+	aliases {
+		serial0 = &uart0;
+		serial1 = &uart1;
+		serial2 = &uart2;
+	};
+};
+
+/* debug console (J1) */
+&uart0 {
+	status = "okay";
+};
+
+/* M.2 slots (CON2, CON8) and J14 */
+&uart1 {
+	status = "disabled";
+};
+
+/* GPIO connector (T1) */
+&uart2 {
+	status = "disabled";
+};
diff --git a/arch/arm64/boot/dts/realtek/rtd1319.dtsi b/arch/arm64/boot/dts/realtek/rtd1319.dtsi
new file mode 100644
index 000000000000..1dcee00009cd
--- /dev/null
+++ b/arch/arm64/boot/dts/realtek/rtd1319.dtsi
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
+/*
+ * Realtek RTD1319 SoC
+ *
+ * Copyright (c) 2019 Realtek Semiconductor Corp.
+ */
+
+#include "rtd13xx.dtsi"
+
+/ {
+	compatible = "realtek,rtd1319";
+};
diff --git a/arch/arm64/boot/dts/realtek/rtd13xx.dtsi b/arch/arm64/boot/dts/realtek/rtd13xx.dtsi
new file mode 100644
index 000000000000..8c5b6fc7b8eb
--- /dev/null
+++ b/arch/arm64/boot/dts/realtek/rtd13xx.dtsi
@@ -0,0 +1,213 @@
+// SPDX-License-Identifier: (GPL-2.0-or-later OR BSD-2-Clause)
+/*
+ * Realtek RTD13xx SoC family
+ *
+ * Copyright (c) 2019-2020 Realtek Semiconductor Corp.
+ */
+
+/memreserve/	0x0000000000000000 0x000000000002e000; /* Boot ROM */
+/memreserve/	0x000000000002e000 0x0000000000100000; /* Boot loader */
+/memreserve/	0x000000000f400000 0x0000000000500000; /* Video FW */
+/memreserve/	0x000000000f900000 0x0000000000500000; /* Audio FW */
+/memreserve/	0x0000000010000000 0x0000000000014000; /* Audio FW RAM */
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+#include <dt-bindings/interrupt-controller/irq.h>
+
+/ {
+	interrupt-parent = <&gic>;
+	#address-cells = <1>;
+	#size-cells = <1>;
+
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		rpc_comm: rpc@3f000 {
+			reg = <0x3f000 0x1000>;
+		};
+
+		rpc_ringbuf: rpc@1ffe000 {
+			reg = <0x1ffe000 0x4000>;
+		};
+
+		tee: tee@10100000 {
+			reg = <0x10100000 0xf00000>;
+			no-map;
+		};
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu0: cpu@0 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x0>;
+			enable-method = "psci";
+			next-level-cache = <&l2>;
+		};
+
+		cpu1: cpu@100 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x100>;
+			enable-method = "psci";
+			next-level-cache = <&l2>;
+		};
+
+		cpu2: cpu@200 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x200>;
+			enable-method = "psci";
+			next-level-cache = <&l2>;
+		};
+
+		cpu3: cpu@300 {
+			device_type = "cpu";
+			compatible = "arm,cortex-a55";
+			reg = <0x300>;
+			enable-method = "psci";
+			next-level-cache = <&l2>;
+		};
+
+		l2: l2-cache {
+			compatible = "cache";
+		};
+	};
+
+	timer {
+		compatible = "arm,armv8-timer";
+		interrupts = <GIC_PPI 13 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 14 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 11 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 10 IRQ_TYPE_LEVEL_LOW>,
+			     <GIC_PPI 9 IRQ_TYPE_LEVEL_LOW>;
+	};
+
+	arm_pmu: pmu {
+		compatible = "arm,cortex-a55-pmu";
+		interrupts = <GIC_PPI 7 IRQ_TYPE_LEVEL_LOW>;
+		interrupt-affinity = <&cpu0>, <&cpu1>, <&cpu2>, <&cpu3>;
+	};
+
+	psci {
+		compatible = "arm,psci-1.0";
+		method = "smc";
+	};
+
+	osc27M: osc {
+		compatible = "fixed-clock";
+		clock-frequency = <27000000>;
+		clock-output-names = "osc27M";
+		#clock-cells = <0>;
+	};
+
+	soc {
+		compatible = "simple-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0x00000000 0x00000000 0x0002e000>, /* boot ROM */
+			 <0xff100000 0xff100000 0x00200000>, /* GIC */
+			 <0x98000000 0x98000000 0x00200000>; /* rbus */
+
+		rbus: bus@98000000 {
+			compatible = "simple-bus";
+			reg = <0x98000000 0x200000>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0x98000000 0x200000>;
+
+			crt: syscon@0 {
+				compatible = "syscon", "simple-mfd";
+				reg = <0x0 0x1000>;
+				reg-io-width = <4>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0x0 0x0 0x1000>;
+			};
+
+			iso: syscon@7000 {
+				compatible = "syscon", "simple-mfd";
+				reg = <0x7000 0x1000>;
+				reg-io-width = <4>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0x0 0x7000 0x1000>;
+			};
+
+			sb2: syscon@1a000 {
+				compatible = "syscon", "simple-mfd";
+				reg = <0x1a000 0x1000>;
+				reg-io-width = <4>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0x0 0x1a000 0x1000>;
+			};
+
+			misc: syscon@1b000 {
+				compatible = "syscon", "simple-mfd";
+				reg = <0x1b000 0x1000>;
+				reg-io-width = <4>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0x0 0x1b000 0x1000>;
+			};
+
+			scpu_wrapper: syscon@1d000 {
+				compatible = "syscon", "simple-mfd";
+				reg = <0x1d000 0x1000>;
+				reg-io-width = <4>;
+				#address-cells = <1>;
+				#size-cells = <1>;
+				ranges = <0x0 0x1d000 0x1000>;
+			};
+		};
+
+		gic: interrupt-controller@ff100000 {
+			compatible = "arm,gic-v3";
+			reg = <0xff100000 0x10000>,
+			      <0xff140000 0x80000>;
+			interrupts = <GIC_PPI 9 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-controller;
+			#interrupt-cells = <3>;
+		};
+	};
+};
+
+&iso {
+	uart0: serial0@800 {
+		compatible = "snps,dw-apb-uart";
+		reg = <0x800 0x400>;
+		reg-shift = <2>;
+		reg-io-width = <4>;
+		interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
+		clock-frequency = <432000000>;
+		status = "disabled";
+	};
+};
+
+&misc {
+	uart1: serial1@200 {
+		compatible = "snps,dw-apb-uart";
+		reg = <0x200 0x400>;
+		reg-shift = <2>;
+		reg-io-width = <4>;
+		interrupts = <GIC_SPI 89 IRQ_TYPE_LEVEL_HIGH>;
+		clock-frequency = <432000000>;
+		status = "disabled";
+	};
+
+	uart2: serial2@400 {
+		compatible = "snps,dw-apb-uart";
+		reg = <0x400 0x400>;
+		reg-shift = <2>;
+		reg-io-width = <4>;
+		interrupts = <GIC_SPI 90 IRQ_TYPE_LEVEL_HIGH>;
+		clock-frequency = <432000000>;
+		status = "disabled";
+	};
+};
-- 
2.26.2

