Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C2242B5CBA
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 11:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727448AbgKQKRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 05:17:11 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:54942 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726266AbgKQKRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 05:17:11 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 0AHAH1Rb104903;
        Tue, 17 Nov 2020 04:17:01 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1605608221;
        bh=5PzqAjOn9hqrl9Xboz9UFRMFNQDjVdOmm7f31tzlDxw=;
        h=From:To:CC:Subject:Date;
        b=r9ayo/7x2gfjwhubJ+ZzTelcV1NmgWqBV0wJBGD+MFvLXaPF9TEJDBFdC07YcO1eb
         7EKDmay2N/SGeShMTEgcvjgRv+MtKPpai9meYoYw2slKi5NlFq3iEuMfZk0r039dBr
         dBnxc85ANMpy40Jnxe82em5NbOoux2ceeuEhVpc4=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 0AHAH14o080415
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 17 Nov 2020 04:17:01 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Tue, 17
 Nov 2020 04:17:00 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Tue, 17 Nov 2020 04:17:01 -0600
Received: from feketebors.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 0AHAGwie017469;
        Tue, 17 Nov 2020 04:16:59 -0600
From:   Peter Ujfalusi <peter.ujfalusi@ti.com>
To:     <ssantosh@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nsekhar@ti.com>, <tomi.valkeinen@ti.com>, <jsarha@ti.com>
Subject: [PATCH] ARM: dts: keystone-k2g-evm: add HDMI and analog audio data
Date:   Tue, 17 Nov 2020 12:17:49 +0200
Message-ID: <20201117101749.26187-1-peter.ujfalusi@ti.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The board is using McASP2 for both analog (tlv320aic3106) and
HDMI (SiI9022) audio.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 arch/arm/boot/dts/keystone-k2g-evm.dts | 112 +++++++++++++++++++++++++
 1 file changed, 112 insertions(+)

diff --git a/arch/arm/boot/dts/keystone-k2g-evm.dts b/arch/arm/boot/dts/keystone-k2g-evm.dts
index 8b3d64c913d8..4d7e3514a3a7 100644
--- a/arch/arm/boot/dts/keystone-k2g-evm.dts
+++ b/arch/arm/boot/dts/keystone-k2g-evm.dts
@@ -46,6 +46,14 @@ vcc1v8_ldo1_reg: fixedregulator-vcc1v8-ldo1 {
 		regulator-always-on;
 	};
 
+	vcc1v8_ldo2_reg: fixedregulator-vcc1v8-ldo2 {
+		compatible = "regulator-fixed";
+		regulator-name = "ldo2";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		regulator-always-on;
+	};
+
 	hdmi: connector {
 		compatible = "hdmi-connector";
 		label = "hdmi";
@@ -58,6 +66,57 @@ hdmi_connector_in: endpoint {
 			};
 		};
 	};
+
+	sound0: sound@0 {
+		compatible = "simple-audio-card";
+		simple-audio-card,name = "K2G-EVM";
+		simple-audio-card,widgets =
+			"Headphone", "Headphone Jack",
+			"Line", "Line In";
+		simple-audio-card,routing =
+			"Headphone Jack",	"HPLOUT",
+			"Headphone Jack",	"HPROUT",
+			"LINE1L",		"Line In",
+			"LINE1R",		"Line In";
+
+		simple-audio-card,dai-link@0 {
+			format = "i2s";
+			bitclock-master = <&sound0_0_master>;
+			frame-master = <&sound0_0_master>;
+			sound0_0_master: cpu {
+				sound-dai = <&mcasp2>;
+				clocks = <&k2g_clks 0x6 1>;
+				system-clock-direction-out;
+			};
+
+			codec {
+				sound-dai = <&tlv320aic3106>;
+				system-clock-frequency = <12288000>;
+			};
+		};
+
+		simple-audio-card,dai-link@1 {
+			format = "i2s";
+			bitclock-master = <&sound0_1_master>;
+			frame-master = <&sound0_1_master>;
+			sound0_1_master: cpu {
+				sound-dai = <&mcasp2>;
+				clocks = <&k2g_clks 0x6 1>;
+				system-clock-direction-out;
+			};
+
+			codec {
+				sound-dai = <&sii9022>;
+				system-clock-frequency = <12288000>;
+			};
+		};
+	};
+
+	sii9022_mclk: sii9022_mclk {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <12288000>;
+	};
 };
 
 &k2g_pinctrl {
@@ -214,6 +273,15 @@ K2G_CORE_IOPAD(0x10e4) (BUFFER_CLASS_B | PULL_DISABLE | MUX_MODE0) /* dssde.dssd
 			K2G_CORE_IOPAD(0x10e8) (BUFFER_CLASS_B | PULL_DISABLE | MUX_MODE0) /* dssfid.dssfid */
 		>;
 	};
+
+	mcasp2_pins: pinmux_mcasp2_pins {
+		pinctrl-single,pins = <
+			K2G_CORE_IOPAD(0x1234) (BUFFER_CLASS_B | PIN_PULLDOWN | MUX_MODE4) /* pr0_pru_gpo2.mcasp2_axr2 */
+			K2G_CORE_IOPAD(0x1238) (BUFFER_CLASS_B | PIN_PULLDOWN | MUX_MODE4) /* pr0_pru_gpo3.mcasp2_axr3 */
+			K2G_CORE_IOPAD(0x1254) (BUFFER_CLASS_B | PIN_PULLDOWN | MUX_MODE4) /* pr0_pru_gpo10.mcasp2_afsx */
+			K2G_CORE_IOPAD(0x125c) (BUFFER_CLASS_B | PIN_PULLDOWN | MUX_MODE4) /* pr0_pru_gpo12.mcasp2_aclkx */
+		>;
+	};
 };
 
 &uart0 {
@@ -423,6 +491,10 @@ sii9022: sii9022@3b {
 		compatible = "sil,sii9022";
 		reg = <0x3b>;
 
+		sil,i2s-data-lanes = < 0 >;
+		clocks = <&sii9022_mclk>;
+		clock-names = "mclk";
+
 		ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
@@ -444,6 +516,19 @@ sii9022_out: endpoint {
 			};
 		};
 	};
+
+	tlv320aic3106: tlv320aic3106@1b {
+		#sound-dai-cells = <0>;
+		compatible = "ti,tlv320aic3106";
+		reg = <0x1b>;
+		status = "okay";
+
+		/* Regulators */
+		AVDD-supply = <&vcc3v3_dcin_reg>;
+		IOVDD-supply = <&vcc3v3_dcin_reg>;
+		DRVDD-supply = <&vcc3v3_dcin_reg>;
+		DVDD-supply = <&vcc1v8_ldo2_reg>;
+	};
 };
 
 &dss {
@@ -458,3 +543,30 @@ dpi_out: endpoint {
 		};
 	};
 };
+
+&k2g_clks {
+	/* on the board 22.5792MHz is connected to AUDOSC_IN */
+	assigned-clocks = <&k2g_clks 0x4c 2>;
+	assigned-clock-rates = <22579200>;
+};
+
+&mcasp2 {
+	#sound-dai-cells = <0>;
+
+	pinctrl-names = "default";
+	pinctrl-0 = <&mcasp2_pins>;
+
+	assigned-clocks = <&k2g_clks 0x6 1>;
+	assigned-clock-parents = <&k2g_clks 0x6 2>;
+
+	status = "okay";
+
+	op-mode = <0>;		/* MCASP_IIS_MODE */
+	tdm-slots = <2>;
+	/* 6 serializer */
+	serial-dir = <	/* 0: INACTIVE, 1: TX, 2: RX */
+		0 0 1 2 0 0 // AXR2: TX, AXR3: rx
+	>;
+	tx-num-evt = <32>;
+	rx-num-evt = <32>;
+};
-- 
Peter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki

