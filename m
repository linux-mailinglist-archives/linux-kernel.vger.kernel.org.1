Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1154F2D5B51
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 14:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389072AbgLJNKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 08:10:08 -0500
Received: from fllv0015.ext.ti.com ([198.47.19.141]:39678 "EHLO
        fllv0015.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388945AbgLJNJq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 08:09:46 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0BAD87m4060397;
        Thu, 10 Dec 2020 07:08:07 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1607605687;
        bh=lH1IwpnnOjZmwF8k9RePKE8rDB2DJOszN7HCS1PLkvQ=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=QQZa/4Zo9sEJiCQp55UJz/DTplKyAZv9sW4WPMwxBTrqSQ2Ve2PuFTnmljXB1s7oj
         yTE8frhiv6vVoXQPr/ijmo5ARb5yHj6oq4FB4RGO/au/wpJ0TK2qViTqoFeKNXQvG8
         vEOt559965n5a+Qo1JVMbTCuyRvqDDfzNFVSgbnU=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0BAD87iS118247
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 10 Dec 2020 07:08:07 -0600
Received: from DFLE113.ent.ti.com (10.64.6.34) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 10
 Dec 2020 07:08:07 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 10 Dec 2020 07:08:07 -0600
Received: from a0393678-ssd.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0BAD7rah098988;
        Thu, 10 Dec 2020 07:08:04 -0600
From:   Kishon Vijay Abraham I <kishon@ti.com>
To:     Tero Kristo <t-kristo@ti.com>, Nishanth Menon <nm@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 2/6] arm64: dts: ti: k3-j721e-main: Remove "syscon" nodes added for pcieX_ctrl
Date:   Thu, 10 Dec 2020 18:37:43 +0530
Message-ID: <20201210130747.25436-3-kishon@ti.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201210130747.25436-1-kishon@ti.com>
References: <20201210130747.25436-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove "syscon" nodes added for pcieX_ctrl and have the PCIe node
point to the parent with an offset argument. This change is as discussed in [1]

[1] -> http://lore.kernel.org/r/CAL_JsqKiUcO76bo1GoepWM1TusJWoty_BRy2hFSgtEVMqtrvvQ@mail.gmail.com

Fixes: 4e5833884f66 ("arm64: dts: ti: k3-j721e-main: Add PCIe device tree nodes")
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

