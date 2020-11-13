Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 954A82B255D
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 21:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgKMU0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 15:26:22 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:43164 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbgKMU0O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 15:26:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1605299174; x=1636835174;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FMk3GJh6GLOKhmCzjEnTNiYeWbZUVSoitIVCLoGIgAU=;
  b=DmUIIo3x5ZkDdcsdCgRcDRcJ8Ecv7TQkFOFoIMB9x1E80sm20sKvLjSF
   VCUGedvGKtjtuBL9A5/2QcogsbFcAQ2U7kkmpYtVvk92NrxVoEbK3FhUg
   adtGNxVaiA4VBPK4KBrkq84CJSYJ646mSA59/ELk9MVyJwePr6I8/3jnH
   lByjLbfOjd4+9KFSFDcaX9H7x370PI0z9o6sjxUfOwA0Yj3HA9MQNGXft
   Oj/0MOrJhSkA7k/pPVMZNV/kTPTgM9mDWeColCvogO2qnknlh4uKzBYtz
   X2a3THGAr37bwhFY0UEK7GRO9HEEAahvTxLSPxJaFaBD9yWI33+QJ+UIg
   g==;
IronPort-SDR: Tt2A4bgzl/bk7DFdcm0Fgny4VTY7K8L7r3/UEpCbwB5PP96DIY1Fm/A4nkVLM7sKzZsK0Uq6Nc
 ICbieOEfcPUWQW96m9gqIyIj8WTs1PKQmfwZAJ4JJ3D2E/sCQHrXlc+AlG9bscVklZYpUS428X
 oDvUq2GP2OOechxAqfIQhEYZC4uNoz1XNi/nUayXJUYryGD7Xwo/r/iYJlmZlAsg8mXXJlqH+d
 GxhC7sVJnnFxTiDgS9DHY07UkFZK7EFdnIr+dcvTGlu8YZIzW8gkQwsZ6C7+en53hce6a7VSG3
 zso=
X-IronPort-AV: E=Sophos;i="5.77,476,1596470400"; 
   d="scan'208";a="157074940"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com) ([199.255.45.14])
  by ob1.hgst.iphmx.com with ESMTP; 14 Nov 2020 04:26:13 +0800
IronPort-SDR: poqSc2+LnpqIAe/uQgUZs/2jzu3/p5ROdnhz36xHdogZAH5oAKZAjJQAXu35DDdCLA19spq5PT
 35GtqFyoBArGKRKy3nggKWL9TdyPQKjfJJHLCZTrImpec/6vu4uyLcOKF24LkTxBbF7LGhrJwm
 Td5zNc7eZnnL6vjQ9+6Sk7sL4Iz6wUPo63sGa6kZs6q+EHinGyGvGuY3PL3EanXit6Dkpwi8ra
 z6c+YLRgwlEbGF7FNXlNLQDA8kgDeVGkyH8WuzxsGoQOedXCvEA6BKMm2qfsGlQ7f6JxCuhvsb
 LqWFMTEkrT4npgpqUQQACMjM
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Nov 2020 12:12:10 -0800
IronPort-SDR: 5YFuQySbepNhbsikDIBUGove5qdcrLukJ+z0GESpvvcKYmEukgGHfZQQLmUjLDBl6yRNrupQSS
 YtEOoVzPkViw/lrmK8WdMDpiFVaT5pyxoOvlVCbTF3hW6Zk1RNbVFXDcVezkMcD50DbQzekjEy
 ISRLYQHgAgbkFl9mXjBDP566jjc2DcKeK+gcWcL1AmBJHG3XFxd6j4rGjfS8D3W0vbCXhx2hcg
 BQGXJioDu4t5Bt8Dts8TDheRis75NbF1xqrt+u27KxnjppzmAnQmRSNLqYWILl+WVGWoKE1PLF
 0bM=
WDCIronportException: Internal
Received: from usa003372.ad.shared (HELO jedi-01.hgst.com) ([10.86.61.22])
  by uls-op-cesaip01.wdc.com with ESMTP; 13 Nov 2020 12:26:13 -0800
From:   Atish Patra <atish.patra@wdc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Atish Patra <atish.patra@wdc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Alistair Francis <alistair.francis@wdc.com>,
        Anup Patel <anup.patel@wdc.com>, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Cyril.Jean@microchip.com, Ivan.Griffin@microchip.com,
        Conor.Dooley@microchip.com
Subject: [RFC PATCH v2 3/4] RISC-V: Initial DTS for Microchip ICICLE board
Date:   Fri, 13 Nov 2020 12:25:49 -0800
Message-Id: <20201113202550.3693323-4-atish.patra@wdc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201113202550.3693323-1-atish.patra@wdc.com>
References: <20201113202550.3693323-1-atish.patra@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add initial DTS for Microchip ICICLE board having only
essential devcies (clocks, sdhci, ethernet, serial, etc).
The device tree is based on the U-Boot patch.

https://patchwork.ozlabs.org/project/uboot/patch/20201110103414.10142-6-padmarao.begari@microchip.com/

Signed-off-by: Atish Patra <atish.patra@wdc.com>
---
 arch/riscv/boot/dts/Makefile                  |   1 +
 arch/riscv/boot/dts/microchip/Makefile        |   2 +
 .../microchip/microchip-mpfs-icicle-kit.dts   |  54 +++
 .../boot/dts/microchip/microchip-mpfs.dtsi    | 342 ++++++++++++++++++
 4 files changed, 399 insertions(+)
 create mode 100644 arch/riscv/boot/dts/microchip/Makefile
 create mode 100644 arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
 create mode 100644 arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi

diff --git a/arch/riscv/boot/dts/Makefile b/arch/riscv/boot/dts/Makefile
index ca1f8cbd78c0..3ea94ea0a18a 100644
--- a/arch/riscv/boot/dts/Makefile
+++ b/arch/riscv/boot/dts/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 subdir-y += sifive
 subdir-y += kendryte
+subdir-y += microchip
 
 obj-$(CONFIG_BUILTIN_DTB) := $(addsuffix /, $(subdir-y))
diff --git a/arch/riscv/boot/dts/microchip/Makefile b/arch/riscv/boot/dts/microchip/Makefile
new file mode 100644
index 000000000000..622b12771fd3
--- /dev/null
+++ b/arch/riscv/boot/dts/microchip/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+dtb-$(CONFIG_SOC_MICROCHIP_POLARFIRE) += microchip-mpfs-icicle-kit.dtb
diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts b/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
new file mode 100644
index 000000000000..9a382ab0a799
--- /dev/null
+++ b/arch/riscv/boot/dts/microchip/microchip-mpfs-icicle-kit.dts
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (c) 2020 Microchip Technology Inc */
+
+/dts-v1/;
+
+#include "microchip-mpfs.dtsi"
+
+/* Clock frequency (in Hz) of the rtcclk */
+#define RTCCLK_FREQ		1000000
+
+/ {
+	#address-cells = <2>;
+	#size-cells = <2>;
+	model = "Microchip PolarFire-SoC Icicle Kit";
+	compatible = "microchip,mpfs-icicle-kit", "microchip,polarfire-soc";
+
+	chosen {
+		stdout-path = &serial0;
+	};
+
+	cpus {
+		timebase-frequency = <RTCCLK_FREQ>;
+	};
+
+	memory@80000000 {
+		device_type = "memory";
+		reg = <0x0 0x80000000 0x0 0x40000000>;
+		clocks = <&clkcfg 26>;
+	};
+
+	soc {
+	};
+};
+
+&serial0 {
+	status = "okay";
+};
+
+&serial1 {
+	status = "okay";
+};
+
+&serial2 {
+	status = "okay";
+};
+
+&serial3 {
+	status = "okay";
+};
+
+&sdcard {
+	status = "okay";
+};
+
diff --git a/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
new file mode 100644
index 000000000000..63ac60f345d8
--- /dev/null
+++ b/arch/riscv/boot/dts/microchip/microchip-mpfs.dtsi
@@ -0,0 +1,342 @@
+// SPDX-License-Identifier: GPL-2.0+
+/* Copyright (c) 2020 Microchip Technology Inc */
+
+/dts-v1/;
+
+/ {
+	#address-cells = <2>;
+	#size-cells = <2>;
+	model = "Microchip PolarFire-SoC";
+	compatible = "microchip,polarfire-soc";
+
+	chosen {
+	};
+
+	cpus {
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		cpu@0 {
+			clock-frequency = <0>;
+			compatible = "sifive,rocket0", "riscv";
+			device_type = "cpu";
+			i-cache-block-size = <64>;
+			i-cache-sets = <128>;
+			i-cache-size = <16384>;
+			reg = <0>;
+			riscv,isa = "rv64imac";
+			status = "disabled";
+
+			cpu0_intc: interrupt-controller {
+				#interrupt-cells = <1>;
+				compatible = "riscv,cpu-intc";
+				interrupt-controller;
+			};
+		};
+
+		cpu@1 {
+			clock-frequency = <0>;
+			compatible = "sifive,rocket0", "riscv";
+			d-cache-block-size = <64>;
+			d-cache-sets = <64>;
+			d-cache-size = <32768>;
+			d-tlb-sets = <1>;
+			d-tlb-size = <32>;
+			device_type = "cpu";
+			i-cache-block-size = <64>;
+			i-cache-sets = <64>;
+			i-cache-size = <32768>;
+			i-tlb-sets = <1>;
+			i-tlb-size = <32>;
+			mmu-type = "riscv,sv39";
+			reg = <1>;
+			riscv,isa = "rv64imafdc";
+			tlb-split;
+			status = "okay";
+
+			cpu1_intc: interrupt-controller {
+				#interrupt-cells = <1>;
+				compatible = "riscv,cpu-intc";
+				interrupt-controller;
+			};
+		};
+
+		cpu@2 {
+			clock-frequency = <0>;
+			compatible = "sifive,rocket0", "riscv";
+			d-cache-block-size = <64>;
+			d-cache-sets = <64>;
+			d-cache-size = <32768>;
+			d-tlb-sets = <1>;
+			d-tlb-size = <32>;
+			device_type = "cpu";
+			i-cache-block-size = <64>;
+			i-cache-sets = <64>;
+			i-cache-size = <32768>;
+			i-tlb-sets = <1>;
+			i-tlb-size = <32>;
+			mmu-type = "riscv,sv39";
+			reg = <2>;
+			riscv,isa = "rv64imafdc";
+			tlb-split;
+			status = "okay";
+
+			cpu2_intc: interrupt-controller {
+				#interrupt-cells = <1>;
+				compatible = "riscv,cpu-intc";
+				interrupt-controller;
+			};
+		};
+
+		cpu@3 {
+			clock-frequency = <0>;
+			compatible = "sifive,rocket0", "riscv";
+			d-cache-block-size = <64>;
+			d-cache-sets = <64>;
+			d-cache-size = <32768>;
+			d-tlb-sets = <1>;
+			d-tlb-size = <32>;
+			device_type = "cpu";
+			i-cache-block-size = <64>;
+			i-cache-sets = <64>;
+			i-cache-size = <32768>;
+			i-tlb-sets = <1>;
+			i-tlb-size = <32>;
+			mmu-type = "riscv,sv39";
+			reg = <3>;
+			riscv,isa = "rv64imafdc";
+			tlb-split;
+			status = "okay";
+
+			cpu3_intc: interrupt-controller {
+				#interrupt-cells = <1>;
+				compatible = "riscv,cpu-intc";
+				interrupt-controller;
+			};
+		};
+
+		cpu@4 {
+			clock-frequency = <0>;
+			compatible = "sifive,rocket0", "riscv";
+			d-cache-block-size = <64>;
+			d-cache-sets = <64>;
+			d-cache-size = <32768>;
+			d-tlb-sets = <1>;
+			d-tlb-size = <32>;
+			device_type = "cpu";
+			i-cache-block-size = <64>;
+			i-cache-sets = <64>;
+			i-cache-size = <32768>;
+			i-tlb-sets = <1>;
+			i-tlb-size = <32>;
+			mmu-type = "riscv,sv39";
+			reg = <4>;
+			riscv,isa = "rv64imafdc";
+			tlb-split;
+			status = "okay";
+			cpu4_intc: interrupt-controller {
+				#interrupt-cells = <1>;
+				compatible = "riscv,cpu-intc";
+				interrupt-controller;
+			};
+		};
+	};
+
+	soc {
+		#address-cells = <2>;
+		#size-cells = <2>;
+		compatible = "simple-bus";
+		ranges;
+
+		cache-controller@2010000 {
+			compatible = "sifive,fu540-c000-ccache", "cache";
+			cache-block-size = <64>;
+			cache-level = <2>;
+			cache-sets = <1024>;
+			cache-size = <2097152>;
+			cache-unified;
+			interrupt-parent = <&plic>;
+			interrupts = <1 2 3>;
+			reg = <0x0 0x2010000 0x0 0x1000>;
+		};
+
+		clint@2000000 {
+			compatible = "riscv,clint0";
+			reg = <0x0 0x2000000 0x0 0xC000>;
+			interrupts-extended = <&cpu0_intc 3 &cpu0_intc 7
+						&cpu1_intc 3 &cpu1_intc 7
+						&cpu2_intc 3 &cpu2_intc 7
+						&cpu3_intc 3 &cpu3_intc 7
+						&cpu4_intc 3 &cpu4_intc 7>;
+		};
+
+		plic: interrupt-controller@c000000 {
+			#interrupt-cells = <1>;
+			compatible = "sifive,plic-1.0.0";
+			reg = <0x0 0xc000000 0x0 0x4000000>;
+			riscv,ndev = <53>;
+			interrupt-controller;
+			interrupts-extended = <&cpu0_intc 11
+					&cpu1_intc 11 &cpu1_intc 9
+					&cpu2_intc 11 &cpu2_intc 9
+					&cpu3_intc 11 &cpu3_intc 9
+					&cpu4_intc 11 &cpu4_intc 9>;
+		};
+
+		dma@3000000 {
+			compatible = "sifive,fu540-c000-pdma";
+			reg = <0x0 0x3000000 0x0 0x8000>;
+			interrupt-parent = <&plic>;
+			interrupts = <23 24 25 26 27 28 29 30>;
+			#dma-cells = <1>;
+		};
+
+		refclk: refclk {
+			compatible = "fixed-clock";
+			#clock-cells = <0>;
+			clock-frequency = <600000000>;
+			clock-output-names = "msspllclk";
+		};
+
+		clkcfg: clkcfg@20002000 {
+			compatible = "microchip,pfsoc-clkcfg";
+			reg = <0x0 0x20002000 0x0 0x1000>;
+			reg-names = "mss_sysreg";
+			clocks = <&refclk>;
+			#clock-cells = <1>;
+			clock-output-names = "cpuclk", "axiclk", "ahbclk", "ENVMclk",	/* 0-3   */
+				 "MAC0clk", "MAC1clk", "MMCclk", "TIMERclk",		/* 4-7   */
+				"MMUART0clk", "MMUART1clk", "MMUART2clk", "MMUART3clk",	/* 8-11  */
+				"MMUART4clk", "SPI0clk", "SPI1clk", "I2C0clk",		/* 12-15 */
+				"I2C1clk", "CAN0clk", "CAN1clk", "USBclk",		/* 16-19 */
+				"RESERVED", "RTCclk", "QSPIclk", "GPIO0clk",		/* 20-23 */
+				"GPIO1clk", "GPIO2clk", "DDRCclk", "FIC0clk",		/* 24-27 */
+				"FIC1clk", "FIC2clk", "FIC3clk", "ATHENAclk", "CFMclk";	/* 28-32 */
+		};
+
+		serial0: serial@20000000 {
+			compatible = "ns16550a";
+			reg = <0x0 0x20000000 0x0 0x400>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			interrupt-parent = <&plic>;
+			interrupts = <90>;
+			current-speed = <115200>;
+			clocks = <&clkcfg 8>;
+			status = "disabled";
+		};
+
+		serial1: serial@20100000 {
+			compatible = "ns16550a";
+			reg = <0x0 0x20100000 0x0 0x400>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			interrupt-parent = <&plic>;
+			interrupts = <91>;
+			current-speed = <115200>;
+			clocks = <&clkcfg 9>;
+			status = "disabled";
+		};
+
+		serial2: serial@20102000 {
+			compatible = "ns16550a";
+			reg = <0x0 0x20102000 0x0 0x400>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			interrupt-parent = <&plic>;
+			interrupts = <92>;
+			current-speed = <115200>;
+			clocks = <&clkcfg 10>;
+			status = "disabled";
+		};
+
+		serial3: serial@20104000 {
+			compatible = "ns16550a";
+			reg = <0x0 0x20104000 0x0 0x400>;
+			reg-io-width = <4>;
+			reg-shift = <2>;
+			interrupt-parent = <&plic>;
+			interrupts = <93>;
+			current-speed = <115200>;
+			clocks = <&clkcfg 11>;
+			status = "disabled";
+		};
+
+		emmc: mmc@20008000 {
+			compatible = "cdns,sd4hc";
+			reg = <0x0 0x20008000 0x0 0x1000>;
+			interrupt-parent = <&plic>;
+			interrupts = <88 89>;
+			pinctrl-names = "default";
+			clocks = <&clkcfg 6>;
+			bus-width = <4>;
+			cap-mmc-highspeed;
+			mmc-ddr-3_3v;
+			max-frequency = <200000000>;
+			non-removable;
+			no-sd;
+			no-sdio;
+			voltage-ranges = <3300 3300>;
+			status = "disabled";
+		};
+
+		sdcard: sdhc@20008000 {
+			compatible = "cdns,sd4hc";
+			reg = <0x0 0x20008000 0x0 0x1000>;
+			interrupt-parent = <&plic>;
+			interrupts = <88>;
+			pinctrl-names = "default";
+			clocks = <&clkcfg 6>;
+			bus-width = <4>;
+			disable-wp;
+			no-1-8-v;
+			cap-mmc-highspeed;
+			cap-sd-highspeed;
+			card-detect-delay = <200>;
+			sd-uhs-sdr12;
+			sd-uhs-sdr25;
+			sd-uhs-sdr50;
+			sd-uhs-sdr104;
+			max-frequency = <200000000>;
+			status = "disabled";
+		};
+
+		emac0: ethernet@20110000 {
+			compatible = "cdns,macb";
+			reg = <0x0 0x20110000 0x0 0x2000>;
+			interrupt-parent = <&plic>;
+			interrupts = <64 65 66 67>;
+			local-mac-address = [00 00 00 00 00 00];
+			phy-mode = "sgmii";
+			clocks = <&clkcfg 5>, <&clkcfg 2>;
+			clock-names = "pclk", "hclk";
+			status = "disabled";
+
+			#address-cells = <1>;
+			#size-cells = <0>;
+			phy-handle = <&phy0>;
+			phy0: ethernet-phy@8 {
+				reg = <8>;
+				ti,fifo-depth = <0x01>;
+			};
+		};
+
+		emac1: ethernet@20112000 {
+			compatible = "cdns,macb";
+			reg = <0x0 0x20112000 0x0 0x2000>;
+			interrupt-parent = <&plic>;
+			interrupts = <70 71 72 73>;
+			mac-address = [00 00 00 00 00 00];
+			phy-mode = "sgmii";
+			clocks = <&clkcfg 5>, <&clkcfg 2>;
+			clock-names = "pclk", "hclk";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			phy1: ethernet-phy@9 {
+				reg = <9>;
+				ti,fifo-depth = <0x01>;
+			};
+		};
+
+	};
+};
-- 
2.25.1

