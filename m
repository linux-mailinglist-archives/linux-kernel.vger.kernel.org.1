Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB5EF25905A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 16:27:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728407AbgIAO0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 10:26:55 -0400
Received: from lelv0143.ext.ti.com ([198.47.23.248]:41658 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728402AbgIAOZJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 10:25:09 -0400
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 081E6kST006073;
        Tue, 1 Sep 2020 09:06:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1598969206;
        bh=I+bDqaa6CJJpsxu988YGODOrvSnoHvdknuQLCh1PA+Q=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=GxI+k/Pl1ApNg/EexLA3UMd+kCiPbNRTP+Eh8/3Hp0X6X+g/4sniPupDAxrLQjw6u
         hXkdrRUc4xH0QGGIwra5V0WCCBfoM+fWx272+Dizo7WH6HArnOty+uy6r7ToQaIkXW
         q2z1IgeZJ/T7ShXKL2Cj21KvonLycCIzjtt2Hqnc=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 081E6kqV017737
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 1 Sep 2020 09:06:46 -0500
Received: from DFLE115.ent.ti.com (10.64.6.36) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 1 Sep
 2020 09:06:46 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 1 Sep 2020 09:06:46 -0500
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 081E6Zlg034944;
        Tue, 1 Sep 2020 09:06:43 -0500
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
Subject: [RESEND PATCH 1/2] arm64: dts: ti: k3-j721e-main: Add PCIe device tree nodes
Date:   Tue, 1 Sep 2020 19:36:27 +0530
Message-ID: <20200901140628.8800-2-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200901140628.8800-1-kishon@ti.com>
References: <20200901140628.8800-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add PCIe device tree node (both RC and EP) for the four
PCIe instances here.

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
---
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 218 ++++++++++++++++++++++
 arch/arm64/boot/dts/ti/k3-j721e.dtsi      |   5 +-
 2 files changed, 222 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index 00a36a14efe7..a36909d8b8c3 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -28,6 +28,26 @@
 		#size-cells = <1>;
 		ranges = <0x0 0x0 0x00100000 0x1c000>;
 
+		pcie0_ctrl: pcie-ctrl@4070 {
+			compatible = "syscon";
+			reg = <0x00004070 0x4>;
+		};
+
+		pcie1_ctrl: pcie-ctrl@4074 {
+			compatible = "syscon";
+			reg = <0x00004074 0x4>;
+		};
+
+		pcie2_ctrl: pcie-ctrl@4078 {
+			compatible = "syscon";
+			reg = <0x00004078 0x4>;
+		};
+
+		pcie3_ctrl: pcie-ctrl@407c {
+			compatible = "syscon";
+			reg = <0x0000407c 0x4>;
+		};
+
 		serdes_ln_ctrl: serdes-ln-ctrl@4080 {
 			compatible = "mmio-mux";
 			reg = <0x00004080 0x50>;
@@ -576,6 +596,204 @@
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

