Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B865D29A55E
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 08:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410993AbgJ0HRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 03:17:30 -0400
Received: from mail-pl1-f195.google.com ([209.85.214.195]:45322 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391259AbgJ0HR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 03:17:29 -0400
Received: by mail-pl1-f195.google.com with SMTP id v22so274470ply.12;
        Tue, 27 Oct 2020 00:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=vljv2zTcnusdnoE2Ebtr4B8YFnOFsaAH4GsaHCQRfeg=;
        b=LlSOfcFsayjSdsPRwX3bwJmgY95xyHeIWWOtlnkmhbuDgKr29Cget1JJ1BYHivEaaJ
         9yVkE0TVoNFP79zajEbBU3CNbx3oNqzXiv9LKQ/CVw0VZAIdxd7ElS14qxXE4Y2VB1Z1
         RfqBTXY0zcdgTsLhiE8as8M0CG9wUyhVHb5KTm3nIGmBzpEwyi8k2UoCTFpbYltVUZ4O
         VtUzmia5kg50jSi50FR0H+MKz1l9AixwoYeXwUbYfubNToK+eT6qTPYo/qP3fX5pKVvu
         UatsWBCm9bcPJqiByaZ9VdguT/MXlemCNmVGIYIyQgIa+PZ/z9DcML9cV0mGbf4spBQ4
         zBtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=vljv2zTcnusdnoE2Ebtr4B8YFnOFsaAH4GsaHCQRfeg=;
        b=KYItFKwbJ+ycoMhqGR8Q63SgW26OtizhPw19Wsplu7t1KHT5Xa8Qby9b8yPP/Pxj+0
         S++u4SuVZVkK4ROJZJQWY4ofSrtDVLb9DgCxlBmfo2+hdMTqPXhDeLeyX2bccqzYmgZW
         nOssCLYT1U6XigyKiw0lCRhsBIQ5eA569ttmyLCI5+Tk2CTnn94kR1vtRVbALV071ztX
         W7HeFlCOQoW461kZgSUHz9G73RcURucCDIhntG9JWEg7lweXYKct0fj64PV+M6I23xnt
         5T73MY8Z1qqIA4yv2cHo3IfjJhB34Kr2nWNaxrkP/prinHdWgVOJKSa64y/rxCtrmTWW
         y1FA==
X-Gm-Message-State: AOAM533NX5jl5s1JsOoPJuvPaN0CV9WE0OItVCg4uOpbor16ZIHlk08m
        /OAFBEpjYre1AIeqQanUjWjs15LTVWqwUwAg
X-Google-Smtp-Source: ABdhPJyd83PuMNnaBAvQ+OhFngbOvXPax9LrFj1ABpiAfcpRjlmNHN7JGT7UjoTV9cOqzCuiJpRtHg==
X-Received: by 2002:a17:902:9a84:b029:d2:9390:5e6 with SMTP id w4-20020a1709029a84b02900d2939005e6mr1220968plp.37.1603783048413;
        Tue, 27 Oct 2020 00:17:28 -0700 (PDT)
Received: from ruantu-3.localdomain ([103.230.142.242])
        by smtp.gmail.com with ESMTPSA id u7sm1036634pfn.37.2020.10.27.00.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2020 00:17:27 -0700 (PDT)
From:   Yu-Tung Chang <mtwget@gmail.com>
To:     robh+dt@kernel.org
Cc:     mripard@kernel.org, wens@csie.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yu-Tung Chang <mtwget@gmail.com>,
        Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH v4 1/1] ARM: dts: sun8i: add FriendlyArm ZeroPi support
Date:   Tue, 27 Oct 2020 15:16:48 +0800
Message-Id: <20201027071648.15988-2-mtwget@gmail.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201027071648.15988-1-mtwget@gmail.com>
References: <20201027071648.15988-1-mtwget@gmail.com>
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
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
Link: https://lore.kernel.org/r/20201026073536.13617-2-mtwget@gmail.com
---
 .../devicetree/bindings/arm/sunxi.yaml        |  5 ++
 arch/arm/boot/dts/Makefile                    |  1 +
 arch/arm/boot/dts/sun8i-h3-zeropi.dts         | 85 +++++++++++++++++++
 3 files changed, 91 insertions(+)
 create mode 100644 arch/arm/boot/dts/sun8i-h3-zeropi.dts

diff --git a/Documentation/devicetree/bindings/arm/sunxi.yaml b/Documentation/devicetree/bindings/arm/sunxi.yaml
index afa00268c7db..0f23133672a3 100644
--- a/Documentation/devicetree/bindings/arm/sunxi.yaml
+++ b/Documentation/devicetree/bindings/arm/sunxi.yaml
@@ -251,6 +251,11 @@ properties:
           - const: friendlyarm,nanopi-neo-plus2
           - const: allwinner,sun50i-h5
 
+      - description: FriendlyARM ZeroPi
+        items:
+          - const: friendlyarm,zeropi
+          - const: allwinner,sun8i-h3
+
       - description: Gemei G9 Tablet
         items:
           - const: gemei,g9
diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index ce66ffd5a1bb..4f0adfead547 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1201,6 +1201,7 @@ dtb-$(CONFIG_MACH_SUN8I) += \
 	sun8i-h3-orangepi-plus2e.dtb \
 	sun8i-h3-orangepi-zero-plus2.dtb \
 	sun8i-h3-rervision-dvk.dtb \
+	sun8i-h3-zeropi.dtb \
 	sun8i-h3-emlid-neutis-n5h3-devboard.dtb \
 	sun8i-r16-bananapi-m2m.dtb \
 	sun8i-r16-nintendo-nes-classic.dtb \
diff --git a/arch/arm/boot/dts/sun8i-h3-zeropi.dts b/arch/arm/boot/dts/sun8i-h3-zeropi.dts
new file mode 100644
index 000000000000..7d3e7323b661
--- /dev/null
+++ b/arch/arm/boot/dts/sun8i-h3-zeropi.dts
@@ -0,0 +1,85 @@
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
+	phy-mode = "rgmii-id";
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

