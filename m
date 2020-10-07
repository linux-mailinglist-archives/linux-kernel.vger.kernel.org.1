Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 864452867F5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 21:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbgJGTCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 15:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbgJGTCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 15:02:07 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF13EC061755;
        Wed,  7 Oct 2020 12:02:06 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id s47so2921781qth.4;
        Wed, 07 Oct 2020 12:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J3VG7MJ7Wsvu/VADxjYStuh9g6YebZQZ+YS6/5hPptA=;
        b=QQmFGTNmCX1NGBO/hNS8LszE1BVy7iA3ztMK27ybGDywPuMJ5ltGXU/1A0etuBuUVq
         fbszLgDpYNt72L1ItfUCxEyVhftGaMpzL5Im5IkXVgePnBBOhmDX4/+QVEkq60x3C/0Q
         6xBOMo3+M58K9rXGA1Tvt7hFQeOnTgg66rn2lFKMZ8Q+rKLpvMzB99azyVYtgP9BdhZf
         crFFnPend5yAOrElWYhNJYb/BVg2aaQ5eUkRjoiX06qH+njv6x2/2ts5IX1iQgQxlXQU
         tbqPuAH99v+xOOlRHy0PwmqlXIa+FQ2bkKW4D0oHlELY4VHjNA8CMhp/8S+Ge9hXbWls
         Hvmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J3VG7MJ7Wsvu/VADxjYStuh9g6YebZQZ+YS6/5hPptA=;
        b=UJiPb9pIILYsptMpSuL4q1QEgInWM/7Mcv6+tuc8ilt3DcAa9B+tfIWXVWt6rxQC5N
         E4jKlLLzqwdZAnOw+RYYq3zGSKCn41nf9CGxoO9wrNhQvJ3ZkaWfztCSnycniMHu4i6k
         sizt3A0cmA5JbnGQvF/wdZFB7yNAyA0U2xhVKfHEIwtvduG/muDyKiHJr8e4NTmp13v1
         a/iFU0w1ZhgxrT4XwiB9Jkczc/u6FlqO41z+rBeeOQEzRrJbnnx89UCkJc7w3ECjxC0M
         mmIebChv2mdwdTKCNgL514MroOE3a+P1aFFA7d9GINiD6SmXqG3qC+ZUo3FxxXOT/QqQ
         nS0Q==
X-Gm-Message-State: AOAM5338siZeNlIGbOkbGnyDNRvhTNI7Tc8w9XdiyRsr20mK5Z2yr75O
        IeOJC67DLOLHVzeZENsAM6s=
X-Google-Smtp-Source: ABdhPJyWE2fl4bpuo5qgJr8ZJn0I8P3qX0q6Bgh0IXAAbnA/WFqJMxEJKB5DvYoQAXHC8G4huSz5Kg==
X-Received: by 2002:ac8:588d:: with SMTP id t13mr4757344qta.380.1602097324929;
        Wed, 07 Oct 2020 12:02:04 -0700 (PDT)
Received: from ubuntu.localdomain (ool-45785633.dyn.optonline.net. [69.120.86.51])
        by smtp.googlemail.com with ESMTPSA id j16sm2087078qkg.26.2020.10.07.12.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2020 12:02:04 -0700 (PDT)
From:   Vivek Unune <npcomplete13@gmail.com>
Cc:     Vivek Unune <npcomplete13@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] ARM: dts: BCM5301X: Linksys EA9500 make use of pinctrl
Date:   Wed,  7 Oct 2020 15:01:50 -0400
Message-Id: <6687de05226dd055ee362933d4841a12b038792d.1601655904.git.npcomplete13@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1601655904.git.npcomplete13@gmail.com>
References: <cover.1601655904.git.npcomplete13@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Forgo the use of mmioreg mdio mux infavor of the pinctrl

Signed-off-by: Vivek Unune <npcomplete13@gmail.com>
---
 .../boot/dts/bcm47094-linksys-panamera.dts    | 153 +++++++++---------
 arch/arm/boot/dts/bcm5301x.dtsi               |   4 +-
 2 files changed, 74 insertions(+), 83 deletions(-)

diff --git a/arch/arm/boot/dts/bcm47094-linksys-panamera.dts b/arch/arm/boot/dts/bcm47094-linksys-panamera.dts
index 0faae8950375..f8443d9f86b7 100644
--- a/arch/arm/boot/dts/bcm47094-linksys-panamera.dts
+++ b/arch/arm/boot/dts/bcm47094-linksys-panamera.dts
@@ -122,87 +122,6 @@ bluebar8 {
 			gpios = <&chipcommon 8 GPIO_ACTIVE_HIGH>;
 		};
 	};
-
-	mdio-bus-mux {
-		#address-cells = <1>;
-		#size-cells = <0>;
-
-		/* BIT(9) = 1 => external mdio */
-		mdio_ext: mdio@200 {
-			reg = <0x200>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-		};
-	};
-
-	mdio-mii-mux {
-		compatible = "mdio-mux-mmioreg";
-		mdio-parent-bus = <&mdio_ext>;
-		#address-cells = <1>;
-		#size-cells = <0>;
-		reg = <0x1800c1c0 0x4>;
-
-		/* BIT(6) = mdc, BIT(7) = mdio */
-		mux-mask = <0xc0>;
-
-		mdio-mii@0 {
-			/* Enable MII function */
-			reg = <0x0>;
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			switch@0  {
-				compatible = "brcm,bcm53125";
-				#address-cells = <1>;
-				#size-cells = <0>;
-				reset-gpios = <&chipcommon 10 GPIO_ACTIVE_LOW>;
-				reset-names = "robo_reset";
-				reg = <0>;
-				dsa,member = <1 0>;
-
-				ports {
-					#address-cells = <1>;
-					#size-cells = <0>;
-
-					port@0 {
-						reg = <0>;
-						label = "lan1";
-					};
-
-					port@1 {
-						reg = <1>;
-						label = "lan5";
-					};
-
-					port@2 {
-						reg = <2>;
-						label = "lan2";
-					};
-
-					port@3 {
-						reg = <3>;
-						label = "lan6";
-					};
-
-					port@4 {
-						reg = <4>;
-						label = "lan3";
-					};
-
-					sw1_p8: port@8 {
-						reg = <8>;
-						ethernet = <&sw0_p0>;
-						label = "cpu";
-
-						fixed-link {
-							speed = <1000>;
-							full-duplex;
-						};
-					};
-				};
-			};
-		};
-	};
 };
 
 &usb2 {
@@ -265,6 +184,78 @@ fixed-link {
 	};
 };
 
+&pinctrl {
+	compatible = "brcm,bcm4709-pinmux";
+
+	pinmux_mdio: mdio {
+		groups = "mdio_grp";
+		function = "mdio";
+	};
+};
+
+&mdio_bus_mux {
+
+	/* BIT(9) = 1 => external mdio */
+	mdio@200 {
+		reg = <0x200>;
+		#address-cells = <1>;
+		#size-cells = <0>;
+
+		switch@0  {
+			compatible = "brcm,bcm53125";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reset-gpios = <&chipcommon 10 GPIO_ACTIVE_LOW>;
+			reset-names = "robo_reset";
+			reg = <0>;
+			dsa,member = <1 0>;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinmux_mdio>;
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port@0 {
+					reg = <0>;
+					label = "lan1";
+				};
+
+				port@1 {
+					reg = <1>;
+					label = "lan5";
+				};
+
+				port@2 {
+					reg = <2>;
+					label = "lan2";
+				};
+
+				port@3 {
+					reg = <3>;
+					label = "lan6";
+				};
+
+				port@4 {
+					reg = <4>;
+					label = "lan3";
+				};
+
+				sw1_p8: port@8 {
+					reg = <8>;
+					ethernet = <&sw0_p0>;
+					label = "cpu";
+
+					fixed-link {
+						speed = <1000>;
+						full-duplex;
+					};
+				};
+			};
+		};
+	};
+};
+
 &usb3_phy {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/bcm5301x.dtsi b/arch/arm/boot/dts/bcm5301x.dtsi
index 9d9e8fe3f6ae..1476375f88bb 100644
--- a/arch/arm/boot/dts/bcm5301x.dtsi
+++ b/arch/arm/boot/dts/bcm5301x.dtsi
@@ -369,7 +369,7 @@ mdio: mdio@18003000 {
 		#address-cells = <1>;
 	};
 
-	mdio-bus-mux@18003000 {
+	mdio_bus_mux: mdio-bus-mux@18003000 {
 		compatible = "mdio-mux-mmioreg";
 		mdio-parent-bus = <&mdio>;
 		#address-cells = <1>;
@@ -428,7 +428,7 @@ cru@100 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 
-			pin-controller@1c0 {
+			pinctrl: pin-controller@1c0 {
 				compatible = "brcm,bcm4708-pinmux";
 				reg = <0x1c0 0x24>;
 				reg-names = "cru_gpio_control";
-- 
2.25.1

