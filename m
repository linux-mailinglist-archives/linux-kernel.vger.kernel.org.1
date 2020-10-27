Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C16C329A6E5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 09:48:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2509330AbgJ0IsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 04:48:18 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:37661 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2509321AbgJ0IsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 04:48:17 -0400
Received: by mail-pj1-f67.google.com with SMTP id lt2so400663pjb.2;
        Tue, 27 Oct 2020 01:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0Q0JEJhglCVtWUnNAN4lkbbkMeDcQNxkk529TN6uDLs=;
        b=PetRbD8cz25PvrGChqG3EUc/bivxihJ8ceuFOJaVH4EH+vmwH7aPyr+gGX4H4kNj7p
         /3x5mFecGKsMx7YyfOG16wOVD2noi93NwXy78w+YdItkaV59xARTn6+CdB/0qUXb+Jjp
         6O06IH26Plf3jp3k+nwDTGhT1cT2t+cNXGp3bOx7rx4QzLItVnvcjmsmGx4E/LSF102p
         CAcO4c3nkJkU2AgnMdwVOzLW7shdmi46Lh+aEHyLOaNIuW7z6+9J0lPr2EHd5Y1wUUZt
         pQfjO8bTXnlsE+c9esDAHytukbakBeDmSPBgEZwjhTThSScLryC0wk8oH2+cnX/L5sG1
         nBMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0Q0JEJhglCVtWUnNAN4lkbbkMeDcQNxkk529TN6uDLs=;
        b=kvcf6yUP0HJxfSUf/2PadfT+Ctmdu7Q7cFiqkH4Qy9fNMr67/XmYZhzabQ0SdJga1C
         YdRP45GAVMSq4ZD9ZiZ38VQ7RxIHxOdzFwrO03tYKQxoFdA/WMpdgqLkbfb7UJGlEMTc
         e4fP/NEMYg1FfjBXobWphRL6dpffxJvq4xw+5giSSXNTbM44XEswFmOmvOJ1pgZV2+c2
         xBAKeKFLcT8tIxz2VHM+LhyL1UdCc3U3y1JW7Qr6EbGrcpwzxPSSgzOQ92u8bL8l8dSV
         gkN3TAgLzBHaE7SLLKCgJBhqzX41T0/t2ljECF5/TL0k+zuayQ363dk/+Zbn8c2vtv3T
         EV9A==
X-Gm-Message-State: AOAM531gQ7yc/W2ZVG429DEFM++ODeKhf5Go6sOBWNtEk4TlbyWeCM7R
        NnM/iysXytgIw7YlcT4Rw6w=
X-Google-Smtp-Source: ABdhPJyuh8PFTGYQO5h/4A+7PRKkftZFYY8KBRehDheCyt8FJG933zCJdw/ZoGQY0AKI2cDUiWlp1A==
X-Received: by 2002:a17:902:b7c9:b029:d5:f570:d573 with SMTP id v9-20020a170902b7c9b02900d5f570d573mr1264452plz.15.1603788496267;
        Tue, 27 Oct 2020 01:48:16 -0700 (PDT)
Received: from ruantu-3.localdomain ([103.230.142.242])
        by smtp.gmail.com with ESMTPSA id n7sm1291988pgk.70.2020.10.27.01.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 01:48:15 -0700 (PDT)
From:   Yu-Tung Chang <mtwget@gmail.com>
To:     robh+dt@kernel.org
Cc:     mripard@kernel.org, wens@csie.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yu-Tung Chang <mtwget@gmail.com>
Subject: [PATCH 1/1] ARM: dts: sun8i: h3: Add initial NanoPi R1 support
Date:   Tue, 27 Oct 2020 16:48:03 +0800
Message-Id: <20201027084803.17368-2-mtwget@gmail.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201027084803.17368-1-mtwget@gmail.com>
References: <20201027084803.17368-1-mtwget@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The NanoPi R1 is a complete open source board developed
by FriendlyElec for makers, hobbyists, fans and etc.

NanoPi R1 key features
- Allwinner H3, Quad-core Cortex-A7@1.2GHz
- 512MB/1GB DDR3 RAM
- 8GB eMMC
- microSD slot
- 10/100/1000M Ethernet x 1
- 10/100 Ethernet x 1
- Wifi 802.11b/g/n
- Bluetooth 4.0
- Serial Debug Port
- 5V 2A DC power-supply

Signed-off-by: Yu-Tung Chang <mtwget@gmail.com>
---
 .../devicetree/bindings/arm/sunxi.yaml        |   5 +
 arch/arm/boot/dts/Makefile                    |   1 +
 arch/arm/boot/dts/sun8i-h3-nanopi-r1.dts      | 199 ++++++++++++++++++
 3 files changed, 205 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun8i-h3-nanopi-r1.dts

diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
index 0f23133672a3..54a1aaee7e22 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
@@ -251,6 +251,11 @@ properties:
           - const: friendlyarm,nanopi-neo-plus2
           - const: allwinner,sun50i-h5
 
+      - description: FriendlyARM NanoPi R1
+        items:
+          - const: friendlyarm,nanopi-r1
+          - const: allwinner,sun8i-h3
+
       - description: FriendlyARM ZeroPi
         items:
           - const: friendlyarm,zeropi
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 4f0adfead547..aabaf67f86ed 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1192,6 +1192,7 @@ dtb-$(CONFIG_MACH_SUN8I) += \
 	sun8i-h3-nanopi-m1-plus.dtb \
 	sun8i-h3-nanopi-neo.dtb \
 	sun8i-h3-nanopi-neo-air.dtb \
+	sun8i-h3-nanopi-r1.dtb \
 	sun8i-h3-orangepi-2.dtb \
 	sun8i-h3-orangepi-lite.dtb \
 	sun8i-h3-orangepi-one.dtb \
diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi-r1.dts b/arch/arm/boot/dts/sun8i-h3-nanopi-r1.dts
new file mode 100644
index 000000000000..d4b90892a4d8
--- /dev/null
+++ b/arch/arm/boot/dts/sun8i-h3-nanopi-r1.dts
@@ -0,0 +1,199 @@
+/*
+ * Copyright (C) 2019 Igor Pecovnik <igor@armbian.com>
+ * Copyright (C) 2020 Jayantajit Gogoi <jayanta.gogoi525@gmail.com>
+ * Copyright (C) 2020 Yu-Tung Chang <mtwget@gmail.com>
+ *
+ * This file is dual-licensed: you can use it either under the terms
+ * of the GPL or the X11 license, at your option. Note that this dual
+ * licensing only applies to this file, and not this project as a
+ * whole.
+ *
+ *  a) This file is free software; you can redistribute it and/or
+ *     modify it under the terms of the GNU General Public License as
+ *     published by the Free Software Foundation; either version 2 of the
+ *     License, or (at your option) any later version.
+ *
+ *     This file is distributed in the hope that it will be useful,
+ *     but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *     GNU General Public License for more details.
+ *
+ * Or, alternatively,
+ *
+ *  b) Permission is hereby granted, free of charge, to any person
+ *     obtaining a copy of this software and associated documentation
+ *     files (the "Software"), to deal in the Software without
+ *     restriction, including without limitation the rights to use,
+ *     copy, modify, merge, publish, distribute, sublicense, and/or
+ *     sell copies of the Software, and to permit persons to whom the
+ *     Software is furnished to do so, subject to the following
+ *     conditions:
+ *
+ *     The above copyright notice and this permission notice shall be
+ *     included in all copies or substantial portions of the Software.
+ *
+ *     THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ *     EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
+ *     OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ *     NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
+ *     HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
+ *     WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ *     FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
+ *     OTHER DEALINGS IN THE SOFTWARE.
+ */
+
+#include "sun8i-h3-nanopi.dtsi"
+
+/ {
+	model = "FriendlyARM NanoPi R1";
+	compatible = "friendlyarm,nanopi-r1", "allwinner,sun8i-h3";
+
+	reg_gmac_3v3: gmac-3v3 {
+		compatible = "regulator-fixed";
+		regulator-name = "gmac-3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		startup-delay-us = <100000>;
+		enable-active-high;
+		gpio = <&pio 3 6 GPIO_ACTIVE_HIGH>; /* PD6 */
+	};
+
+	reg_vdd_cpux: gpio-regulator {
+		compatible = "regulator-gpio";
+		regulator-name = "vdd-cpux";
+		regulator-type = "voltage";
+		regulator-boot-on;
+		regulator-always-on;
+		regulator-min-microvolt = <1100000>;
+		regulator-max-microvolt = <1300000>;
+		regulator-ramp-delay = <50>;
+		gpios = <&r_pio 0 6 GPIO_ACTIVE_HIGH>; /* PL6 */
+		gpios-states = <0x1>;
+		states = <1100000 0x0
+			  1300000 0x1>;
+	};
+
+	wifi_pwrseq: wifi_pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&r_pio 0 7 GPIO_ACTIVE_LOW>; /* PL7 */
+		clocks = <&rtc 1>;
+		clock-names = "ext_clock";
+	};
+
+	leds {
+
+		wan {
+			label = "nanopi:green:wan";
+			gpios = <&pio 6 11 GPIO_ACTIVE_HIGH>; /* PG11 */
+		};
+
+		lan {
+			label = "nanopi:green:lan";
+			gpios = <&pio 0 9 GPIO_ACTIVE_HIGH>; /* PA9 */
+		};
+	};
+};
+
+&cpu0 {
+	cpu-supply = <&reg_vdd_cpux>;
+};
+
+&ehci1 {
+	status = "okay";
+};
+
+&ehci2 {
+	status = "okay";
+};
+
+&emac {
+	pinctrl-names = "default";
+	pinctrl-0 = <&emac_rgmii_pins>;
+	phy-supply = <&reg_gmac_3v3>;
+	phy-handle = <&ext_rgmii_phy>;
+	phy-mode = "rgmii-id";
+	status = "okay";
+};
+
+&external_mdio {
+	ext_rgmii_phy: ethernet-phy@7 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <7>;
+	};
+};
+
+&mmc1 {
+	vmmc-supply = <&reg_vcc3v3>;
+	vqmmc-supply = <&reg_vcc3v3>;
+	mmc-pwrseq = <&wifi_pwrseq>;
+	bus-width = <4>;
+	non-removable;
+	status = "okay";
+
+	sdio_wifi: sdio_wifi@1 {
+		reg = <1>;
+		compatible = "brcm,bcm4329-fmac";
+		interrupt-parent = <&pio>;
+		interrupts = <6 10 IRQ_TYPE_LEVEL_LOW>; /* PG10 / EINT10 */
+		interrupt-names = "host-wake";
+	};
+};
+
+&mmc2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc2_8bit_pins>;
+	vmmc-supply = <&reg_vcc3v3>;
+	vqmmc-supply = <&reg_vcc3v3>;
+	bus-width = <8>;
+	non-removable;
+	status = "okay";
+};
+
+&ohci1 {
+	status = "okay";
+};
+
+&ohci2 {
+	status = "okay";
+};
+
+&reg_usb0_vbus {
+	gpio = <&r_pio 0 2 GPIO_ACTIVE_HIGH>; /* PL2 */
+	status = "okay";
+};
+
+&uart1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart1_pins>;
+	status = "okay";
+};
+
+&uart3 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&uart3_pins>, <&uart3_rts_cts_pins>;
+	uart-has-rtscts;
+	status = "okay";
+
+	bluetooth {
+		compatible = "brcm,bcm43438-bt";
+		clocks = <&rtc 1>;
+		clock-names = "lpo";
+		vbat-supply = <&reg_vcc3v3>;
+		vddio-supply = <&reg_vcc3v3>;
+		device-wakeup-gpios = <&pio 0 8 GPIO_ACTIVE_HIGH>; /* PA8 */
+		host-wakeup-gpios = <&pio 0 7 GPIO_ACTIVE_HIGH>; /* PA7 */
+		shutdown-gpios = <&pio 6 13 GPIO_ACTIVE_HIGH>; /* PG13 */
+	};
+};
+
+&usb_otg {
+	status = "okay";
+	dr_mode = "peripheral";
+};
+
+&usbphy {
+	usb0_id_det-gpios = <&pio 6 12 GPIO_ACTIVE_HIGH>; /* PG12 */
+	usb0_vbus-supply = <&reg_usb0_vbus>;
+	status = "okay";
+};
+
-- 
2.29.0

