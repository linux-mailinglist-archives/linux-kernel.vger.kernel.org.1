Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F0472985E1
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 04:19:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1421863AbgJZDTb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 23:19:31 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:41879 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389792AbgJZDTb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 23:19:31 -0400
Received: by mail-pl1-f194.google.com with SMTP id w11so4048466pll.8;
        Sun, 25 Oct 2020 20:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QsMOJAAASmnBLciPsNTk5wBgO9ycp9uLTKdOg45VzbA=;
        b=i6XNf7/psS6DfAyer4ZSjR/IclOovr7CeQfgqjlYHDU+kjvOOOflLxX5lw06L3Q0cp
         NhPyI8ocfUhh446hbQ0FojFItq9MiKypG0/ztZEmK4fDSkqOdFZPA1r5Zd6sIa26A4Ye
         JCcBzuBX7h3eCAnqPMevDG8wEjGghpaIxB3tnIMeXbJNcYy1F+rhwfq013OzFV+nthvD
         XGgAnW9EUNqdB4DokMezq4S5zvQwESKLA0Jp+SBS7sNy4bVgbdL/3M+1kJ6P0BCIvX83
         VrEUksjG0O/P9pJvP2mG6Omb2O1YHYqQfnftWpmEii6F4sYTPcuSh0IWBzYdzKO46Doq
         VYwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QsMOJAAASmnBLciPsNTk5wBgO9ycp9uLTKdOg45VzbA=;
        b=WlDatSOPZ1KzsC/Z4T7E0FHF8wZmlzXj3Z8Dz+/g1BU9H92e/B+1mln7CSLZwTAJoZ
         CGd1RWuoVHZSOoIBiSMLmTrrob2b02JEbVmnde4Rm8YVs5NKd4sB0xBvuS2YiSCyEaej
         iBkvMk+ryUO0xgusnAOY+ggZZm629UeKMVEMAKXJLnxI8/eJhPjQHyKpsz2xgyePY3DK
         9eE5jaVo2fidyAw/LeJSSK9rO2p2d+okZaRzERZR/M9c5fJob9sVQgHR11g++VvFfOVN
         /ff4SL/uuru0+NkeLgSLQwS77tNSyWn1zbCD35dMdi9lGhXdjbfBVF4b3/MzOAGBnCbR
         fF9w==
X-Gm-Message-State: AOAM5316jntvSciBEiMoSwrDxPXfdT5ZnWVkj7YGTqqxQTGuRX2qD1LG
        RHSKA7MLLGxe9gn21xG3wmKDbMOf6DmF9Idz
X-Google-Smtp-Source: ABdhPJybZb2hyA3CDBvO+N8OsbwFu/xFa9rDsbAq51JV5T4j61FmgkCXaFgOFPiyV3WI/xv+id4ssQ==
X-Received: by 2002:a17:902:a3c2:b029:d6:3951:5bdc with SMTP id q2-20020a170902a3c2b02900d639515bdcmr7753644plb.71.1603682370255;
        Sun, 25 Oct 2020 20:19:30 -0700 (PDT)
Received: from ruantu-3.localdomain ([103.230.142.242])
        by smtp.gmail.com with ESMTPSA id e1sm10512103pfd.198.2020.10.25.20.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2020 20:19:29 -0700 (PDT)
From:   Yu-Tung Chang <mtwget@gmail.com>
To:     robh+dt@kernel.org
Cc:     mripard@kernel.org, wens@csie.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yu-Tung Chang <mtwget@gmail.com>
Subject: [PATCH v2] ARM: dts: sun8i: add FriendlyArm ZeroPi support
Date:   Mon, 26 Oct 2020 11:19:22 +0800
Message-Id: <20201026031922.12473-1-mtwget@gmail.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ZeroPi is another fun board developed
by FriendlyELEC for makers,
hobbyists and fans.

ZeroPi key features
- Allwinner H3, Quad-core Cortex-A7@1.2GHz
- 256MB/512MB DDR3 RAM
- microsd slot
- 10/100/1000Mbps Ethernet
- Debug Serial Port
- DC 5V/2A power-supply

Signed-off-by: Yu-Tung Chang <mtwget@gmail.com>
---
 .../devicetree/bindings/arm/sunxi.yaml        |  5 ++
 arch/arm/boot/dts/Makefile                    |  1 +
 arch/arm/boot/dts/sun8i-h3-zeropi.dts         | 87 +++++++++++++++++++
 3 files changed, 93 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun8i-h3-zeropi.dts

diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
index efc9118233b4..9392a9a3f7e7 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
@@ -246,6 +246,11 @@ properties:
           - const: friendlyarm,nanopi-neo-plus2
           - const: allwinner,sun50i-h5
 
+      - description: FriendlyARM ZeroPi
+        items:
+          - const: friendlyarm,zeropi
+          - const: allwinner,sun50i-h3
+
       - description: Gemei G9 Tablet
         items:
           - const: gemei,g9
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index 4572db3fa5ae..f05e54257947 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1187,6 +1187,7 @@ dtb-$(CONFIG_MACH_SUN8I) += \
 	sun8i-h3-orangepi-plus2e.dtb \
 	sun8i-h3-orangepi-zero-plus2.dtb \
 	sun8i-h3-rervision-dvk.dtb \
+	sun8i-h3-zeropi.dtb \
 	sun8i-h3-emlid-neutis-n5h3-devboard.dtb \
 	sun8i-r16-bananapi-m2m.dtb \
 	sun8i-r16-nintendo-nes-classic.dtb \
diff --git a/arch/arm/boot/dts/sun8i-h3-zeropi.dts b/arch/arm/boot/dts/sun8i-h3-zeropi.dts
new file mode 100644
index 000000000000..00cdd35222c5
--- /dev/null
+++ b/arch/arm/boot/dts/sun8i-h3-zeropi.dts
@@ -0,0 +1,87 @@
+/*
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
+	model = "FriendlyARM ZeroPi";
+	compatible = "friendlyarm,zeropi", "allwinner,sun8i-h3";
+
+	aliases {
+		ethernet0 = &emac;
+	};
+
+	reg_gmac_3v3: gmac-3v3 {
+		compatible = "regulator-fixed";
+		pinctrl-names = "default";
+		pinctrl-0 = <&gmac_power_pin_nanopi>;
+		regulator-name = "gmac-3v3";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		startup-delay-us = <100000>;
+		enable-active-high;
+		gpio = <&pio 3 6 GPIO_ACTIVE_HIGH>; /* PD6 */
+	};
+};
+
+&external_mdio {
+	ext_rgmii_phy: ethernet-phy@7 {
+		compatible = "ethernet-phy-ieee802.3-c22";
+		reg = <7>;
+	};
+};
+
+&emac {
+	pinctrl-names = "default";
+	pinctrl-0 = <&emac_rgmii_pins>;
+	phy-supply = <&reg_gmac_3v3>;
+	phy-handle = <&ext_rgmii_phy>;
+	phy-mode = "rgmii";
+
+	allwinner,leds-active-low;
+	status = "okay";
+};
+
+&usb_otg {
+	status = "okay";
+	dr_mode = "host";
+};
-- 
2.29.0

