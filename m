Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 630932EAE02
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 16:16:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbhAEPPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 10:15:23 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:47770 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726328AbhAEPPW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 10:15:22 -0500
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 105FEZ3d060745;
        Tue, 5 Jan 2021 09:14:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1609859675;
        bh=uFq9z3ejFp9l0tjXk+DozG6GW6K1mSjTFFPB1zKf5Zc=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=wyFFiJyIg2oJ54sr1ZSupdwNmDD7moP7lDSbw5m57q7G+Xzdz1ss0pOBop3qT7F07
         nawXgBTh4gy4ZOuViEQm3tHE/SvETaulxDwjKtQc7mA41tP0k8lJqsnuIiD4ehsGPr
         kjODqBqNuMqMhvQyUAqyDOYTCsrcR76fIV/fZVCg=
Received: from DFLE103.ent.ti.com (dfle103.ent.ti.com [10.64.6.24])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 105FEZjh098449
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 5 Jan 2021 09:14:35 -0600
Received: from DFLE103.ent.ti.com (10.64.6.24) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 5 Jan
 2021 09:14:34 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE103.ent.ti.com
 (10.64.6.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 5 Jan 2021 09:14:34 -0600
Received: from a0393678-ssd.ent.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 105FEPOE005961;
        Tue, 5 Jan 2021 09:14:32 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Nishanth Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 2/6] arm64: dts: ti: k3-j721e-main: Remove "syscon" nodes added for pcieX_ctrl
Date:   Tue, 5 Jan 2021 20:44:17 +0530
Message-ID: <20210105151421.23237-3-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210105151421.23237-1-kishon@ti.com>
References: <20210105151421.23237-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove "syscon" nodes added for pcieX_ctrl and have the PCIe node point
to the parent with an offset argument. This change is as discussed in [1].

[1] -> http://lore.kernel.org/r/CAL_JsqKiUcO76bo1GoepWM1TusJWoty_BRy2hFSgtEVMqtrvvQ@mail.gmail.com

Signed-off-by: Kishon Vijay Abraham I <kishon@ti.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 arch/arm64/boot/dts/ti/k3-j721e-main.dtsi | 48 ++++-------------------
 1 file changed, 8 insertions(+), 40 deletions(-)

diff --git a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
index 1c11da612c67..2d526ea44a85 100644
--- a/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-j721e-main.dtsi
@@ -28,38 +28,6 @@
 		#size-cells = <1>;
 		ranges = <0x0 0x0 0x00100000 0x1c000>;
 
-		pcie0_ctrl: syscon@4070 {
-			compatible = "ti,j721e-system-controller", "syscon", "simple-mfd";
-			reg = <0x00004070 0x4>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges = <0x4070 0x4070 0x4>;
-		};
-
-		pcie1_ctrl: syscon@4074 {
-			compatible = "ti,j721e-system-controller", "syscon", "simple-mfd";
-			reg = <0x00004074 0x4>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges = <0x4074 0x4074 0x4>;
-		};
-
-		pcie2_ctrl: syscon@4078 {
-			compatible = "ti,j721e-system-controller", "syscon", "simple-mfd";
-			reg = <0x00004078 0x4>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges = <0x4078 0x4078 0x4>;
-		};
-
-		pcie3_ctrl: syscon@407c {
-			compatible = "ti,j721e-system-controller", "syscon", "simple-mfd";
-			reg = <0x0000407c 0x4>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges = <0x407c 0x407c 0x4>;
-		};
-
 		serdes_ln_ctrl: mux@4080 {
 			compatible = "mmio-mux";
 			reg = <0x00004080 0x50>;
@@ -618,7 +586,7 @@
 		interrupt-names = "link_state";
 		interrupts = <GIC_SPI 318 IRQ_TYPE_EDGE_RISING>;
 		device_type = "pci";
-		ti,syscon-pcie-ctrl = <&pcie0_ctrl>;
+		ti,syscon-pcie-ctrl = <&scm_conf 0x4070>;
 		max-link-speed = <3>;
 		num-lanes = <2>;
 		power-domains = <&k3_pds 239 TI_SCI_PD_EXCLUSIVE>;
@@ -645,7 +613,7 @@
 		reg-names = "intd_cfg", "user_cfg", "reg", "mem";
 		interrupt-names = "link_state";
 		interrupts = <GIC_SPI 318 IRQ_TYPE_EDGE_RISING>;
-		ti,syscon-pcie-ctrl = <&pcie0_ctrl>;
+		ti,syscon-pcie-ctrl = <&scm_conf 0x4070>;
 		max-link-speed = <3>;
 		num-lanes = <2>;
 		power-domains = <&k3_pds 239 TI_SCI_PD_EXCLUSIVE>;
@@ -666,7 +634,7 @@
 		interrupt-names = "link_state";
 		interrupts = <GIC_SPI 330 IRQ_TYPE_EDGE_RISING>;
 		device_type = "pci";
-		ti,syscon-pcie-ctrl = <&pcie1_ctrl>;
+		ti,syscon-pcie-ctrl = <&scm_conf 0x4074>;
 		max-link-speed = <3>;
 		num-lanes = <2>;
 		power-domains = <&k3_pds 240 TI_SCI_PD_EXCLUSIVE>;
@@ -693,7 +661,7 @@
 		reg-names = "intd_cfg", "user_cfg", "reg", "mem";
 		interrupt-names = "link_state";
 		interrupts = <GIC_SPI 330 IRQ_TYPE_EDGE_RISING>;
-		ti,syscon-pcie-ctrl = <&pcie1_ctrl>;
+		ti,syscon-pcie-ctrl = <&scm_conf 0x4074>;
 		max-link-speed = <3>;
 		num-lanes = <2>;
 		power-domains = <&k3_pds 240 TI_SCI_PD_EXCLUSIVE>;
@@ -714,7 +682,7 @@
 		interrupt-names = "link_state";
 		interrupts = <GIC_SPI 342 IRQ_TYPE_EDGE_RISING>;
 		device_type = "pci";
-		ti,syscon-pcie-ctrl = <&pcie2_ctrl>;
+		ti,syscon-pcie-ctrl = <&scm_conf 0x4078>;
 		max-link-speed = <3>;
 		num-lanes = <2>;
 		power-domains = <&k3_pds 241 TI_SCI_PD_EXCLUSIVE>;
@@ -741,7 +709,7 @@
 		reg-names = "intd_cfg", "user_cfg", "reg", "mem";
 		interrupt-names = "link_state";
 		interrupts = <GIC_SPI 342 IRQ_TYPE_EDGE_RISING>;
-		ti,syscon-pcie-ctrl = <&pcie2_ctrl>;
+		ti,syscon-pcie-ctrl = <&scm_conf 0x4078>;
 		max-link-speed = <3>;
 		num-lanes = <2>;
 		power-domains = <&k3_pds 241 TI_SCI_PD_EXCLUSIVE>;
@@ -762,7 +730,7 @@
 		interrupt-names = "link_state";
 		interrupts = <GIC_SPI 354 IRQ_TYPE_EDGE_RISING>;
 		device_type = "pci";
-		ti,syscon-pcie-ctrl = <&pcie3_ctrl>;
+		ti,syscon-pcie-ctrl = <&scm_conf 0x407c>;
 		max-link-speed = <3>;
 		num-lanes = <2>;
 		power-domains = <&k3_pds 242 TI_SCI_PD_EXCLUSIVE>;
@@ -789,7 +757,7 @@
 		reg-names = "intd_cfg", "user_cfg", "reg", "mem";
 		interrupt-names = "link_state";
 		interrupts = <GIC_SPI 354 IRQ_TYPE_EDGE_RISING>;
-		ti,syscon-pcie-ctrl = <&pcie3_ctrl>;
+		ti,syscon-pcie-ctrl = <&scm_conf 0x407c>;
 		max-link-speed = <3>;
 		num-lanes = <2>;
 		power-domains = <&k3_pds 242 TI_SCI_PD_EXCLUSIVE>;
-- 
2.17.1

