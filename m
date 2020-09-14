Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBF5C268FA0
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 17:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbgINPWB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 11:22:01 -0400
Received: from fllv0015.ext.ti.com ([198.47.19.141]:57194 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726469AbgINPVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 11:21:41 -0400
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08EFLUfS069529;
        Mon, 14 Sep 2020 10:21:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600096890;
        bh=fEmERqR9tWX7ve/ozt2J5sLSsbkd8LtgOgvUi2uSm3w=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=U/6qJ/eiKSFR3hRPugSjxO4jvujVRAp7jwXr2uJPN3I/8OToIWbNzE4986Dzi6trW
         64O/Iw3ehYoOjQj8NyxUOAN2zzlVf8AZjMFLORjLHnxHaPxQGBPL5Mgm6/B2O3f6Jk
         jF1yaxxsVIR21kkkxqV0/4HJeXxGbM6bN4pUwPoo=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08EFLULx055136;
        Mon, 14 Sep 2020 10:21:30 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Mon, 14
 Sep 2020 10:21:29 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Mon, 14 Sep 2020 10:21:29 -0500
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08EFLNOQ103257;
        Mon, 14 Sep 2020 10:21:27 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [PATCH v2 1/2] arm64: dts: ti: k3-j721e-main: Add PCIe device tree nodes
Date:   Mon, 14 Sep 2020 20:51:14 +0530
Message-ID: <20200914152115.1788-2-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200914152115.1788-1-kishon@ti.com>
References: <20200914152115.1788-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PCIe device tree nodes (both RC and EP) for the four
PCIe instances here.

Also add the missing translations required in the "ranges"
DT property of cbass_main to access all the four PCIe
instances.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 232 +++++++++++++++++++++-
 arch/arm64/boot/dts/ti/k3-j721e.dtsi      |   5 +-
 2 files changed, 235 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index 00a36a14efe7..c9045f005a62 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -28,7 +28,39 @@
 		#size-cells = <1>;
 		ranges = <0x0 0x0 0x00100000 0x1c000>;
 
-		serdes_ln_ctrl: serdes-ln-ctrl@4080 {
+		pcie0_ctrl: syscon@4070 {
+			compatible = "ti,j721e-system-controller", "syscon", "simple-mfd";
+			reg = <0x00004070 0x4>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x4070 0x4070 0x4>;
+		};
+
+		pcie1_ctrl: syscon@4074 {
+			compatible = "ti,j721e-system-controller", "syscon", "simple-mfd";
+			reg = <0x00004074 0x4>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x4074 0x4074 0x4>;
+		};
+
+		pcie2_ctrl: syscon@4078 {
+			compatible = "ti,j721e-system-controller", "syscon", "simple-mfd";
+			reg = <0x00004078 0x4>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x4078 0x4078 0x4>;
+		};
+
+		pcie3_ctrl: syscon@407c {
+			compatible = "ti,j721e-system-controller", "syscon", "simple-mfd";
+			reg = <0x0000407c 0x4>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x407c 0x407c 0x4>;
+		};
+
+		serdes_ln_ctrl: mux@4080 {
 			compatible = "mmio-mux";
 			reg = <0x00004080 0x50>;
 			#mux-control-cells = <1>;
@@ -576,6 +608,204 @@
 		};
 	};
 
+	pcie0_rc: pcie@2900000 {
+		compatible = "ti,j721e-pcie-host";
+		reg = <0x00 0x02900000 0x00 0x1000>,
+		      <0x00 0x02907000 0x00 0x400>,
+		      <0x00 0x0d000000 0x00 0x00800000>,
+		      <0x00 0x10000000 0x00 0x00001000>;
+		reg-names = "intd_cfg", "user_cfg", "reg", "cfg";
+		interrupt-names = "link_state";
+		interrupts = <GIC_SPI 318 IRQ_TYPE_EDGE_RISING>;
+		device_type = "pci";
+		ti,syscon-pcie-ctrl = <&pcie0_ctrl>;
+		max-link-speed = <3>;
+		num-lanes = <2>;
+		power-domains = <&k3_pds 239 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 239 1>;
+		clock-names = "fck";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		bus-range = <0x0 0xf>;
+		vendor-id = <0x104c>;
+		device-id = <0xb00d>;
+		msi-map = <0x0 &gic_its 0x0 0x10000>;
+		dma-coherent;
+		ranges = <0x01000000 0x0 0x10001000 0x0 0x10001000 0x0 0x0010000>,
+			 <0x02000000 0x0 0x10011000 0x0 0x10011000 0x0 0x7fef000>;
+		dma-ranges = <0x02000000 0x0 0x0 0x0 0x0 0x10000 0x0>;
+	};
+
+	pcie0_ep: pcie-ep@2900000 {
+		compatible = "ti,j721e-pcie-ep";
+		reg = <0x00 0x02900000 0x00 0x1000>,
+		      <0x00 0x02907000 0x00 0x400>,
+		      <0x00 0x0d000000 0x00 0x00800000>,
+		      <0x00 0x10000000 0x00 0x08000000>;
+		reg-names = "intd_cfg", "user_cfg", "reg", "mem";
+		interrupt-names = "link_state";
+		interrupts = <GIC_SPI 318 IRQ_TYPE_EDGE_RISING>;
+		ti,syscon-pcie-ctrl = <&pcie0_ctrl>;
+		max-link-speed = <3>;
+		num-lanes = <2>;
+		power-domains = <&k3_pds 239 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 239 1>;
+		clock-names = "fck";
+		cdns,max-outbound-regions = <16>;
+		max-functions = /bits/ 8 <6>;
+		max-virtual-functions = /bits/ 16 <4 4 4 4 0 0>;
+		dma-coherent;
+	};
+
+	pcie1_rc: pcie@2910000 {
+		compatible = "ti,j721e-pcie-host";
+		reg = <0x00 0x02910000 0x00 0x1000>,
+		      <0x00 0x02917000 0x00 0x400>,
+		      <0x00 0x0d800000 0x00 0x00800000>,
+		      <0x00 0x18000000 0x00 0x00001000>;
+		reg-names = "intd_cfg", "user_cfg", "reg", "cfg";
+		interrupt-names = "link_state";
+		interrupts = <GIC_SPI 330 IRQ_TYPE_EDGE_RISING>;
+		device_type = "pci";
+		ti,syscon-pcie-ctrl = <&pcie1_ctrl>;
+		max-link-speed = <3>;
+		num-lanes = <2>;
+		power-domains = <&k3_pds 240 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 240 1>;
+		clock-names = "fck";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		bus-range = <0x0 0xf>;
+		vendor-id = <0x104c>;
+		device-id = <0xb00d>;
+		msi-map = <0x0 &gic_its 0x10000 0x10000>;
+		dma-coherent;
+		ranges = <0x01000000 0x0 0x18001000 0x0 0x18001000 0x0 0x0010000>,
+			 <0x02000000 0x0 0x18011000 0x0 0x18011000 0x0 0x7fef000>;
+		dma-ranges = <0x02000000 0x0 0x0 0x0 0x0 0x10000 0x0>;
+	};
+
+	pcie1_ep: pcie-ep@2910000 {
+		compatible = "ti,j721e-pcie-ep";
+		reg = <0x00 0x02910000 0x00 0x1000>,
+		      <0x00 0x02917000 0x00 0x400>,
+		      <0x00 0x0d800000 0x00 0x00800000>,
+		      <0x00 0x18000000 0x00 0x08000000>;
+		reg-names = "intd_cfg", "user_cfg", "reg", "mem";
+		interrupt-names = "link_state";
+		interrupts = <GIC_SPI 330 IRQ_TYPE_EDGE_RISING>;
+		ti,syscon-pcie-ctrl = <&pcie1_ctrl>;
+		max-link-speed = <3>;
+		num-lanes = <2>;
+		power-domains = <&k3_pds 240 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 240 1>;
+		clock-names = "fck";
+		cdns,max-outbound-regions = <16>;
+		max-functions = /bits/ 8 <6>;
+		max-virtual-functions = /bits/ 16 <4 4 4 4 0 0>;
+		dma-coherent;
+	};
+
+	pcie2_rc: pcie@2920000 {
+		compatible = "ti,j721e-pcie-host";
+		reg = <0x00 0x02920000 0x00 0x1000>,
+		      <0x00 0x02927000 0x00 0x400>,
+		      <0x00 0x0e000000 0x00 0x00800000>,
+		      <0x44 0x00000000 0x00 0x00001000>;
+		reg-names = "intd_cfg", "user_cfg", "reg", "cfg";
+		interrupt-names = "link_state";
+		interrupts = <GIC_SPI 342 IRQ_TYPE_EDGE_RISING>;
+		device_type = "pci";
+		ti,syscon-pcie-ctrl = <&pcie2_ctrl>;
+		max-link-speed = <3>;
+		num-lanes = <2>;
+		power-domains = <&k3_pds 241 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 241 1>;
+		clock-names = "fck";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		bus-range = <0x0 0xf>;
+		vendor-id = <0x104c>;
+		device-id = <0xb00d>;
+		msi-map = <0x0 &gic_its 0x20000 0x10000>;
+		dma-coherent;
+		ranges = <0x01000000 0x0 0x00001000 0x44 0x00001000 0x0 0x0010000>,
+			 <0x02000000 0x0 0x00011000 0x44 0x00011000 0x0 0x7fef000>;
+		dma-ranges = <0x02000000 0x0 0x0 0x0 0x0 0x10000 0x0>;
+	};
+
+	pcie2_ep: pcie-ep@2920000 {
+		compatible = "ti,j721e-pcie-ep";
+		reg = <0x00 0x02920000 0x00 0x1000>,
+		      <0x00 0x02927000 0x00 0x400>,
+		      <0x00 0x0e000000 0x00 0x00800000>,
+		      <0x44 0x00000000 0x00 0x08000000>;
+		reg-names = "intd_cfg", "user_cfg", "reg", "mem";
+		interrupt-names = "link_state";
+		interrupts = <GIC_SPI 342 IRQ_TYPE_EDGE_RISING>;
+		ti,syscon-pcie-ctrl = <&pcie2_ctrl>;
+		max-link-speed = <3>;
+		num-lanes = <2>;
+		power-domains = <&k3_pds 241 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 241 1>;
+		clock-names = "fck";
+		cdns,max-outbound-regions = <16>;
+		max-functions = /bits/ 8 <6>;
+		max-virtual-functions = /bits/ 16 <4 4 4 4 0 0>;
+		dma-coherent;
+	};
+
+	pcie3_rc: pcie@2930000 {
+		compatible = "ti,j721e-pcie-host";
+		reg = <0x00 0x02930000 0x00 0x1000>,
+		      <0x00 0x02937000 0x00 0x400>,
+		      <0x00 0x0e800000 0x00 0x00800000>,
+		      <0x44 0x10000000 0x00 0x00001000>;
+		reg-names = "intd_cfg", "user_cfg", "reg", "cfg";
+		interrupt-names = "link_state";
+		interrupts = <GIC_SPI 354 IRQ_TYPE_EDGE_RISING>;
+		device_type = "pci";
+		ti,syscon-pcie-ctrl = <&pcie3_ctrl>;
+		max-link-speed = <3>;
+		num-lanes = <2>;
+		power-domains = <&k3_pds 242 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 242 1>;
+		clock-names = "fck";
+		#address-cells = <3>;
+		#size-cells = <2>;
+		bus-range = <0x0 0xf>;
+		vendor-id = <0x104c>;
+		device-id = <0xb00d>;
+		msi-map = <0x0 &gic_its 0x30000 0x10000>;
+		dma-coherent;
+		ranges = <0x01000000 0x0 0x00001000 0x44 0x10001000 0x0 0x0010000>,
+			 <0x02000000 0x0 0x00011000 0x44 0x10011000 0x0 0x7fef000>;
+		dma-ranges = <0x02000000 0x0 0x0 0x0 0x0 0x10000 0x0>;
+	};
+
+	pcie3_ep: pcie-ep@2930000 {
+		compatible = "ti,j721e-pcie-ep";
+		reg = <0x00 0x02930000 0x00 0x1000>,
+		      <0x00 0x02937000 0x00 0x400>,
+		      <0x00 0x0e800000 0x00 0x00800000>,
+		      <0x44 0x10000000 0x00 0x08000000>;
+		reg-names = "intd_cfg", "user_cfg", "reg", "mem";
+		interrupt-names = "link_state";
+		interrupts = <GIC_SPI 354 IRQ_TYPE_EDGE_RISING>;
+		ti,syscon-pcie-ctrl = <&pcie3_ctrl>;
+		max-link-speed = <3>;
+		num-lanes = <2>;
+		power-domains = <&k3_pds 242 TI_SCI_PD_EXCLUSIVE>;
+		clocks = <&k3_clks 242 1>;
+		clock-names = "fck";
+		cdns,max-outbound-regions = <16>;
+		max-functions = /bits/ 8 <6>;
+		max-virtual-functions = /bits/ 16 <4 4 4 4 0 0>;
+		dma-coherent;
+		#address-cells = <2>;
+		#size-cells = <2>;
+	};
+
 	main_uart0: serial@2800000 {
 		compatible = "ti,j721e-uart", "ti,am654-uart";
 		reg = <0x00 0x02800000 0x00 0x100>;
diff --git a/arch/arm64/boot/dts/ti/k3-j721e.dtsi b/arch/arm64/boot/dts/ti/k3-j721e.dtsi
index f787aa73aaae..eeb02115b966 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e.dtsi
@@ -132,9 +132,12 @@
 			 <0x00 0x06400000 0x00 0x06400000 0x00 0x00400000>, /* USBSS1 */
 			 <0x00 0x01000000 0x00 0x01000000 0x00 0x0af02400>, /* Most peripherals */
 			 <0x00 0x30000000 0x00 0x30000000 0x00 0x0c400000>, /* MAIN NAVSS */
-			 <0x00 0x0d000000 0x00 0x0d000000 0x00 0x01000000>, /* PCIe Core*/
+			 <0x00 0x0d000000 0x00 0x0d000000 0x00 0x01800000>, /* PCIe Core*/
+			 <0x00 0x0e000000 0x00 0x0e000000 0x00 0x01800000>, /* PCIe Core*/
 			 <0x00 0x10000000 0x00 0x10000000 0x00 0x10000000>, /* PCIe DAT */
 			 <0x00 0x64800000 0x00 0x64800000 0x00 0x00800000>, /* C71 */
+			 <0x44 0x00000000 0x44 0x00000000 0x00 0x08000000>, /* PCIe2 DAT */
+			 <0x44 0x10000000 0x44 0x10000000 0x00 0x08000000>, /* PCIe3 DAT */
 			 <0x4d 0x80800000 0x4d 0x80800000 0x00 0x00800000>, /* C66_0 */
 			 <0x4d 0x81800000 0x4d 0x81800000 0x00 0x00800000>, /* C66_1 */
 			 <0x4e 0x20000000 0x4e 0x20000000 0x00 0x00080000>, /* GPU */
-- 
2.17.1

