Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2E4C2636EC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Sep 2020 21:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbgIIT5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Sep 2020 15:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727782AbgIIT4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 15:56:55 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4998C061757
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 12:56:54 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id o8so5310853ejb.10
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 12:56:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sartura-hr.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QB9wVyxK3s2UE2GnjM0Q5M2uDYbxba5hPikMpTPdfXg=;
        b=lfcpDCfDZLFxIAuHTN3XX8/Qe5vYvmjC30526Mdj+sEcJkfqCvxokRMuOLu8MLrUjI
         RIEkKF35kFN84+XrYikuBmeFBOHIJsVdutcVVGEOJGw+an7aDaY7D3XCuZw7p01CalIt
         U/U5EoVVd8W4zEXELgGBK8tGOt98+4qGZs3Vz5q4EYXWrtHohH3aPtZaaDG51zu1u2Ce
         4VecX1v/NGT5zRV3MYrExLNUySek5C/0/VuGaRl786w/RVCSDq3Aa7lKpywdpy5QOsF1
         ur/KQb4WcCBT36jt20Xj+Q2Iv864WZJ1su7sshESJidZ2xFaSgDQOdx/YYAw6DzpYMUo
         ngww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QB9wVyxK3s2UE2GnjM0Q5M2uDYbxba5hPikMpTPdfXg=;
        b=V8jwZMpxWT1CiBHCBIoSnzgG3eb3PqDTjD2qzcWGk2xg26FWoZW72/a7A2TqXrR/3u
         +MQbAHQUspZ0T3sh/ggqBCIHyK+Wb1Y2O8UTZjnsPygl5su3w2q+B0PtC/ekMYuKq9cs
         g/3w5AajwwVsVyokI3Qr39WAa94MIOd2dN2wIzD0d+Hddcx4j/Q86Aog89rMx9qZjyLd
         HpNzkDnSwYBmnaq4Pv04+giCWXPwE/zE+nkw+KT1BP/jh5lYwGFciEYAHxSt4yVzWGJO
         ZfECZP/inKp/u6LWpk/Vcbzm6G5UJ21yVa1kq74dlSyA3xyyQ8CyedOWY+EAGcJ7RbiQ
         7tJw==
X-Gm-Message-State: AOAM53240cr4Mo+aKrb6Fw03G41WpcydQYRVdLo/GZ0NSViPFd96ZKdV
        elJentYzYYwSQd/4mgHVBFL4wA==
X-Google-Smtp-Source: ABdhPJzYXNfLuoOpt1VUoQHPJ9WWWQuRB+IQVME30IpZLeGziq0TA5FhFMEXVL9MaevZ6t/AO5fXNQ==
X-Received: by 2002:a17:906:874f:: with SMTP id hj15mr5570675ejb.539.1599681411641;
        Wed, 09 Sep 2020 12:56:51 -0700 (PDT)
Received: from localhost.localdomain (dh207-97-133.xnet.hr. [88.207.97.133])
        by smtp.googlemail.com with ESMTPSA id n26sm3510870ejz.89.2020.09.09.12.56.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 12:56:51 -0700 (PDT)
From:   Robert Marko <robert.marko@sartura.hr>
To:     agross@kernel.org, bjorn.andersson@linaro.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>
Subject: [PATCH v2 3/4] arm: dts: add Alfa Network AP120C-AC
Date:   Wed,  9 Sep 2020 21:56:39 +0200
Message-Id: <20200909195640.3127341-4-robert.marko@sartura.hr>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200909195640.3127341-1-robert.marko@sartura.hr>
References: <20200909195640.3127341-1-robert.marko@sartura.hr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ALFA Network AP120C-AC is a dual-band ceiling AP, based on Qualcomm
IPQ4018 + QCA8075 platform.

Specification:

- Qualcomm IPQ4018 (717 MHz)
- 256 MB of RAM (DDR3)
- 16 MB (SPI NOR) + 128 or 512 MB (SPI NAND) of flash
- 2x Gbps Ethernet, with 802.3af PoE support in one port
- 2T2R 2.4/5 GHz (IPQ4018), with ext. FEMs (QFE1952, QFE1922)
- 3x U.FL connectors
- 1x 1.8 dBi (Bluetooth) and 2x 3/5 dBi dual-band (Wi-Fi) antennas
- Atmel/Microchip AT97SC3205T TPM module (I2C bus)
- TI CC2540 Bluetooth LE module (USB 2.0 bus)
- 1x button (reset)
- 1x USB 2.0
- DC jack for main power input (12 V)
- UART header available on PCB (2.0 mm pitch)

This adds DTS for both the generic and custom Bit edition for Sartura.

Signed-off-by: Robert Marko <robert.marko@sartura.hr>
Cc: Luka Perkov <luka.perkov@sartura.hr>
---
Changes since v1:
* Drop include that does not exist

 arch/arm/boot/dts/Makefile                    |   2 +
 .../boot/dts/qcom-ipq4018-ap120c-ac-bit.dts   |  28 ++
 arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dts  |  27 ++
 arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dtsi | 254 ++++++++++++++++++
 4 files changed, 311 insertions(+)
 create mode 100644 arch/arm/boot/dts/qcom-ipq4018-ap120c-ac-bit.dts
 create mode 100644 arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dts
 create mode 100644 arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dtsi

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 9b474208057d..246d82fc5fcd 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -890,6 +890,8 @@ dtb-$(CONFIG_ARCH_QCOM) += \
 	qcom-apq8074-dragonboard.dtb \
 	qcom-apq8084-ifc6540.dtb \
 	qcom-apq8084-mtp.dtb \
+	qcom-ipq4018-ap120c-ac.dtb \
+	qcom-ipq4018-ap120c-ac-bit.dtb \
 	qcom-ipq4018-jalapeno.dtb \
 	qcom-ipq4019-ap.dk01.1-c1.dtb \
 	qcom-ipq4019-ap.dk04.1-c1.dtb \
diff --git a/arch/arm/boot/dts/qcom-ipq4018-ap120c-ac-bit.dts b/arch/arm/boot/dts/qcom-ipq4018-ap120c-ac-bit.dts
new file mode 100644
index 000000000000..028ac8e24797
--- /dev/null
+++ b/arch/arm/boot/dts/qcom-ipq4018-ap120c-ac-bit.dts
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+
+#include "qcom-ipq4018-ap120c-ac.dtsi"
+
+/ {
+	model = "ALFA Network AP120C-AC Bit";
+
+	leds {
+		compatible = "gpio-leds";
+
+		power {
+			label = "ap120c-ac:green:power";
+			gpios = <&tlmm 5 GPIO_ACTIVE_LOW>;
+			default-state = "on";
+		};
+
+		wlan {
+			label = "ap120c-ac:green:wlan";
+			gpios = <&tlmm 3 GPIO_ACTIVE_HIGH>;
+		};
+
+		support {
+			label = "ap120c-ac:green:support";
+			gpios = <&tlmm 2 GPIO_ACTIVE_HIGH>;
+			panic-indicator;
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dts b/arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dts
new file mode 100644
index 000000000000..b7916fc26d68
--- /dev/null
+++ b/arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dts
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+
+#include "qcom-ipq4018-ap120c-ac.dtsi"
+
+/ {
+	leds {
+		compatible = "gpio-leds";
+
+		status: status {
+			label = "ap120c-ac:blue:status";
+			gpios = <&tlmm 5 GPIO_ACTIVE_LOW>;
+			default-state = "keep";
+		};
+
+		wlan2g {
+			label = "ap120c-ac:green:wlan2g";
+			gpios = <&tlmm 3 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "phy0tpt";
+		};
+
+		wlan5g {
+			label = "ap120c-ac:red:wlan5g";
+			gpios = <&tlmm 2 GPIO_ACTIVE_HIGH>;
+			linux,default-trigger = "phy1tpt";
+		};
+	};
+};
diff --git a/arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dtsi b/arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dtsi
new file mode 100644
index 000000000000..1f3b1ce82108
--- /dev/null
+++ b/arch/arm/boot/dts/qcom-ipq4018-ap120c-ac.dtsi
@@ -0,0 +1,254 @@
+// SPDX-License-Identifier: GPL-2.0-or-later OR MIT
+
+#include "qcom-ipq4019.dtsi"
+#include <dt-bindings/gpio/gpio.h>
+#include <dt-bindings/input/input.h>
+
+/ {
+	model = "ALFA Network AP120C-AC";
+	compatible = "alfa-network,ap120c-ac";
+
+	keys {
+		compatible = "gpio-keys";
+
+		reset {
+			label = "reset";
+			gpios = <&tlmm 63 GPIO_ACTIVE_LOW>;
+			linux,code = <KEY_RESTART>;
+		};
+	};
+};
+
+&tlmm {
+	i2c0_pins: i2c0_pinmux {
+		mux_i2c {
+			function = "blsp_i2c0";
+			pins = "gpio58", "gpio59";
+			drive-strength = <16>;
+			bias-disable;
+		};
+	};
+
+	mdio_pins: mdio_pinmux {
+		mux_mdio {
+			pins = "gpio53";
+			function = "mdio";
+			bias-pull-up;
+		};
+
+		mux_mdc {
+			pins = "gpio52";
+			function = "mdc";
+			bias-pull-up;
+		};
+	};
+
+	serial0_pins: serial0_pinmux {
+		mux_uart {
+			pins = "gpio60", "gpio61";
+			function = "blsp_uart0";
+			bias-disable;
+		};
+	};
+
+	spi0_pins: spi0_pinmux {
+		mux_spi {
+			function = "blsp_spi0";
+			pins = "gpio55", "gpio56", "gpio57";
+			drive-strength = <12>;
+			bias-disable;
+		};
+
+		mux_cs {
+			function = "gpio";
+			pins = "gpio54", "gpio4";
+			drive-strength = <2>;
+			bias-disable;
+			output-high;
+		};
+	};
+
+	usb-power {
+		line-name = "USB-power";
+		gpios = <1 GPIO_ACTIVE_HIGH>;
+		gpio-hog;
+		output-high;
+	};
+};
+
+&watchdog {
+	status = "okay";
+};
+
+&prng {
+	status = "okay";
+};
+
+&blsp_dma {
+	status = "okay";
+};
+
+&blsp1_i2c3 {
+	status = "okay";
+
+	pinctrl-0 = <&i2c0_pins>;
+	pinctrl-names = "default";
+
+	tpm@29 {
+		compatible = "atmel,at97sc3204t";
+		reg = <0x29>;
+	};
+};
+
+&blsp1_spi1 {
+	status = "okay";
+
+	pinctrl-0 = <&spi0_pins>;
+	pinctrl-names = "default";
+	cs-gpios = <&tlmm 54 GPIO_ACTIVE_HIGH>, <&tlmm 4 GPIO_ACTIVE_HIGH>;
+
+	flash@0 {
+		compatible = "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <24000000>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 {
+				label = "SBL1";
+				reg = <0x00000000 0x00040000>;
+				read-only;
+			};
+
+			partition@40000 {
+				label = "MIBIB";
+				reg = <0x00040000 0x00020000>;
+				read-only;
+			};
+
+			partition@60000 {
+				label = "QSEE";
+				reg = <0x00060000 0x00060000>;
+				read-only;
+			};
+
+			partition@c0000 {
+				label = "CDT";
+				reg = <0x000c0000 0x00010000>;
+				read-only;
+			};
+
+			partition@d0000 {
+				label = "DDRPARAMS";
+				reg = <0x000d0000 0x00010000>;
+				read-only;
+			};
+
+			partition@e0000 {
+				label = "u-boot-env";
+				reg = <0x000e0000 0x00010000>;
+			};
+
+			partition@f0000 {
+				label = "u-boot";
+				reg = <0x000f0000 0x00080000>;
+				read-only;
+			};
+
+			partition@170000 {
+				label = "ART";
+				reg = <0x00170000 0x00010000>;
+				read-only;
+			};
+
+			partition@180000 {
+				label = "priv_data1";
+				reg = <0x00180000 0x00010000>;
+				read-only;
+			};
+
+			partition@190000 {
+				label = "priv_data2";
+				reg = <0x00190000 0x00010000>;
+				read-only;
+			};
+		};
+	};
+
+	nand@1 {
+		compatible = "spi-nand";
+		reg = <1>;
+		spi-max-frequency = <40000000>;
+
+		partitions {
+			compatible = "fixed-partitions";
+			#address-cells = <1>;
+			#size-cells = <1>;
+
+			partition@0 {
+				label = "ubi1";
+				reg = <0x00000000 0x04000000>;
+			};
+
+			partition@4000000 {
+				label = "ubi2";
+				reg = <0x04000000 0x04000000>;
+			};
+		};
+	};
+};
+
+&blsp1_uart1 {
+	status = "okay";
+
+	pinctrl-0 = <&serial0_pins>;
+	pinctrl-names = "default";
+};
+
+&cryptobam {
+	status = "okay";
+};
+
+&crypto {
+	status = "okay";
+};
+
+&mdio {
+	status = "okay";
+
+	pinctrl-0 = <&mdio_pins>;
+	pinctrl-names = "default";
+};
+
+&wifi0 {
+	status = "okay";
+};
+
+&wifi1 {
+	status = "okay";
+	qcom,ath10k-calibration-variant = "ALFA-Network-AP120C-AC";
+};
+
+&usb3_hs_phy {
+	status = "okay";
+};
+
+&usb3 {
+	status = "okay";
+
+	dwc3@8a00000 {
+		phys = <&usb3_hs_phy>;
+		phy-names = "usb2-phy";
+	};
+};
+
+&usb2_hs_phy {
+	status = "okay";
+};
+
+&usb2 {
+	status = "okay";
+};
-- 
2.26.2

