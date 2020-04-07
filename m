Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14DD31A1744
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Apr 2020 23:13:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726602AbgDGVNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Apr 2020 17:13:10 -0400
Received: from relay9-d.mail.gandi.net ([217.70.183.199]:49633 "EHLO
        relay9-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726370AbgDGVNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 17:13:09 -0400
X-Originating-IP: 72.234.141.215
Received: from tb.lan (udp224251uds.hawaiiantel.net [72.234.141.215])
        (Authenticated sender: mail@aparcar.org)
        by relay9-d.mail.gandi.net (Postfix) with ESMTPSA id 35BF5FF808;
        Tue,  7 Apr 2020 21:13:01 +0000 (UTC)
From:   Paul Spooren <mail@aparcar.org>
To:     devicetree@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, jason@lakedaemon.net, andrew@lunn.ch,
        gregory.clement@bootlin.com, sebastian.hesselbarth@gmail.com,
        daniel@makrotopia.org, freifunk@adrianschmutzler.de,
        Paul Spooren <mail@aparcar.org>
Subject: [PATCH 3/5] arm: dts: linksys: rename cobra to wrt1900ac-v2
Date:   Tue,  7 Apr 2020 11:08:13 -1000
Message-Id: <20200407210816.866084-4-mail@aparcar.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200407210816.866084-1-mail@aparcar.org>
References: <20200407210816.866084-1-mail@aparcar.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linksys uses internally the codename "cobra" for a device sold under the
name of "Linksys WRT1900ACv2", which is already reflected in the device
tree `model`. However the `compatible` list only contains the codename
`linksys,cobra` which does not relate to the common name.

This patch renames the `dts` file to the sanitized model name and
prepends `linksys,wrt1900ac-v2` to the `compatible` list to simplify the
device relation.

For consistency with other models containing a version number a space
was added in the DT `model` to sepparate the *v2* and also reflected in
the `dts` filename containing `-v2`.

Signed-off-by: Paul Spooren <mail@aparcar.org>
CC: Rob Herring <robh+dt@kernel.org>
CC: Jason Cooper <jason@lakedaemon.net>
CC: Andrew Lunn <andrew@lunn.ch>
CC: Gregory Clement <gregory.clement@bootlin.com>
CC: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
CC: Daniel Golle <daniel@makrotopia.org>
CC: Adrian Schmutzler <freifunk@adrianschmutzler.de>
---
 arch/arm/boot/dts/Makefile                    |  2 +-
 ...ts => armada-385-linksys-wrt1900ac-v2.dts} | 27 ++++++++++---------
 2 files changed, 15 insertions(+), 14 deletions(-)
 rename arch/arm/boot/dts/{armada-385-linksys-cobra.dts => armada-385-linksys-wrt1900ac-v2.dts} (78%)

diff --git a/arch/arm/boot/dts/Makefile b/arch/arm/boot/dts/Makefile
index cf288adb8fe0..be45b5fb4f95 100644
--- a/arch/arm/boot/dts/Makefile
+++ b/arch/arm/boot/dts/Makefile
@@ -1281,8 +1281,8 @@ dtb-$(CONFIG_MACH_ARMADA_38X) += \
 	armada-385-db-88f6820-amc.dtb \
 	armada-385-db-ap.dtb \
 	armada-385-linksys-caiman.dtb \
-	armada-385-linksys-cobra.dtb \
 	armada-385-linksys-shelby.dtb \
+	armada-385-linksys-wrt1900ac-v2.dtb \
 	armada-385-linksys-wrt3200acm.dtb \
 	armada-385-synology-ds116.dtb \
 	armada-385-turris-omnia.dtb \
diff --git a/arch/arm/boot/dts/armada-385-linksys-cobra.dts b/arch/arm/boot/dts/armada-385-linksys-wrt1900ac-v2.dts
similarity index 78%
rename from arch/arm/boot/dts/armada-385-linksys-cobra.dts
rename to arch/arm/boot/dts/armada-385-linksys-wrt1900ac-v2.dts
index e3e4877a6f49..8f78350fa988 100644
--- a/arch/arm/boot/dts/armada-385-linksys-cobra.dts
+++ b/arch/arm/boot/dts/armada-385-linksys-wrt1900ac-v2.dts
@@ -9,65 +9,66 @@
 #include "armada-385-linksys.dtsi"
 
 / {
-	model = "Linksys WRT1900ACv2";
-	compatible = "linksys,cobra", "linksys,armada385", "marvell,armada385",
+	model = "Linksys WRT1900AC v2";
+	compatible = "linksys,wrt1900ac-v2", "linksys,cobra",
+		     "linksys,armada385", "marvell,armada385",
 		     "marvell,armada380";
 };
 
 &expander0 {
 	wan_amber@0 {
-		label = "cobra:amber:wan";
+		label = "wrt1900ac-v2:amber:wan";
 		reg = <0x0>;
 	};
 
 	wan_white@1 {
-		label = "cobra:white:wan";
+		label = "wrt1900ac-v2:white:wan";
 		reg = <0x1>;
 	};
 
 	wlan_2g@2 {
-		label = "cobra:white:wlan_2g";
+		label = "wrt1900ac-v2:white:wlan_2g";
 		reg = <0x2>;
 	};
 
 	wlan_5g@3 {
-		label = "cobra:white:wlan_5g";
+		label = "wrt1900ac-v2:white:wlan_5g";
 		reg = <0x3>;
 	};
 
 	usb2@5 {
-		label = "cobra:white:usb2";
+		label = "wrt1900ac-v2:white:usb2";
 		reg = <0x5>;
 	};
 
 	usb3_1@6 {
-		label = "cobra:white:usb3_1";
+		label = "wrt1900ac-v2:white:usb3_1";
 		reg = <0x6>;
 	};
 
 	usb3_2@7 {
-		label = "cobra:white:usb3_2";
+		label = "wrt1900ac-v2:white:usb3_2";
 		reg = <0x7>;
 	};
 
 	wps_white@8 {
-		label = "cobra:white:wps";
+		label = "wrt1900ac-v2:white:wps";
 		reg = <0x8>;
 	};
 
 	wps_amber@9 {
-		label = "cobra:amber:wps";
+		label = "wrt1900ac-v2:amber:wps";
 		reg = <0x9>;
 	};
 };
 
 &gpio_leds {
 	power {
-		label = "cobra:white:power";
+		label = "wrt1900ac-v2:white:power";
 	};
 
 	sata {
-		label = "cobra:white:sata";
+		label = "wrt1900ac-v2:white:sata";
 	};
 };
 
-- 
2.25.1

