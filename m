Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37CCC2D180C
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 19:02:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgLGR7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 12:59:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbgLGR6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 12:58:55 -0500
Received: from mail.kmu-office.ch (mail.kmu-office.ch [IPv6:2a02:418:6a02::a2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EFD2C061793;
        Mon,  7 Dec 2020 09:58:15 -0800 (PST)
Received: from allenwind.lan (unknown [IPv6:2a02:169:3df5:0:6d9:f5ff:fe22:28bf])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 1375E5C2B77;
        Mon,  7 Dec 2020 18:58:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1607363894;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=opKv7lCH9GWv1bsYT1BdsMnTfGZsqh4aRoGA9fH2Gpk=;
        b=WyD+aMF90r9pxVl4m7MOn4I24gdvyhfpCiU61i4V5fCQGVYBmI/pg8DGYYHtPTIVNuciJ2
        q0pplxBugtXjzqhs/AgUkxDgutx8Wv/pNB8jWWPU1TdSiVaCGUrLYDnX8zV5Oiw1l/xE2i
        29FDy9+X6/zJiTHz4QQDLNY8ny/OqzE=
From:   Stefan Agner <stefan@agner.ch>
To:     khilman@baylibre.com
Cc:     robh+dt@kernel.org, narmstrong@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, christianshewitt@gmail.com,
        jian.hu@amlogic.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stefan Agner <stefan@agner.ch>
Subject: [PATCH v3 2/5] arm64: dts: meson: fix PHY deassert timing requirements
Date:   Mon,  7 Dec 2020 18:58:00 +0100
Message-Id: <4a322c198b86e4c8b3dda015560a683babea4d63.1607363522.git.stefan@agner.ch>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <df3f5c4fc6e43c55429fd3662a636036a21eed49.1607363522.git.stefan@agner.ch>
References: <df3f5c4fc6e43c55429fd3662a636036a21eed49.1607363522.git.stefan@agner.ch>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

According to the datasheet (Rev. 1.9) the RTL8211F requires at least
72ms "for internal circuits settling time" before accessing the PHY
registers. This fixes an issue seen on ODROID-C2 where the Ethernet
link doesn't come up when using ip link set down/up:
  [ 6630.714855] meson8b-dwmac c9410000.ethernet eth0: Link is Down
  [ 6630.785775] meson8b-dwmac c9410000.ethernet eth0: PHY [stmmac-0:00] driver [RTL8211F Gigabit Ethernet] (irq=36)
  [ 6630.893071] meson8b-dwmac c9410000.ethernet: Failed to reset the dma
  [ 6630.893800] meson8b-dwmac c9410000.ethernet eth0: stmmac_hw_setup: DMA engine initialization failed
  [ 6630.902835] meson8b-dwmac c9410000.ethernet eth0: stmmac_open: Hw setup failed

Fixes: f29cabf240ed ("arm64: dts: meson: use the generic Ethernet PHY reset GPIO bindings")
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Signed-off-by: Stefan Agner <stefan@agner.ch>
---
 arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts  | 2 +-
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts   | 2 +-
 arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi  | 2 +-
 arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi     | 2 +-
 arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dts  | 2 +-
 arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts | 2 +-
 arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts   | 2 +-
 arch/arm64/boot/dts/amlogic/meson-gxm-q200.dts        | 2 +-
 arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts    | 2 +-
 9 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
index 7be3e354093b..de27beafe9db 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
@@ -165,7 +165,7 @@ eth_phy0: ethernet-phy@0 {
 			reg = <0>;
 
 			reset-assert-us = <10000>;
-			reset-deassert-us = <30000>;
+			reset-deassert-us = <80000>;
 			reset-gpios = <&gpio GPIOZ_14 GPIO_ACTIVE_LOW>;
 
 			interrupt-parent = <&gpio_intc>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index 70fcfb7b0683..50de1d01e565 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -200,7 +200,7 @@ eth_phy0: ethernet-phy@0 {
 			reg = <0>;
 
 			reset-assert-us = <10000>;
-			reset-deassert-us = <30000>;
+			reset-deassert-us = <80000>;
 			reset-gpios = <&gpio GPIOZ_14 GPIO_ACTIVE_LOW>;
 
 			interrupt-parent = <&gpio_intc>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
index 222ee8069cfa..9b0b81f191f1 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-vega-s95.dtsi
@@ -126,7 +126,7 @@ eth_phy0: ethernet-phy@0 {
 			reg = <0>;
 
 			reset-assert-us = <10000>;
-			reset-deassert-us = <30000>;
+			reset-deassert-us = <80000>;
 			reset-gpios = <&gpio GPIOZ_14 GPIO_ACTIVE_LOW>;
 
 			interrupt-parent = <&gpio_intc>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
index ad812854a107..a350fee1264d 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek.dtsi
@@ -147,7 +147,7 @@ eth_phy0: ethernet-phy@0 {
 			reg = <0>;
 
 			reset-assert-us = <10000>;
-			reset-deassert-us = <30000>;
+			reset-deassert-us = <80000>;
 			reset-gpios = <&gpio GPIOZ_14 GPIO_ACTIVE_LOW>;
 
 			interrupt-parent = <&gpio_intc>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dts
index b08c4537f260..b2ab05c22090 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905d-p230.dts
@@ -82,7 +82,7 @@ external_phy: ethernet-phy@0 {
 
 		/* External PHY reset is shared with internal PHY Led signal */
 		reset-assert-us = <10000>;
-		reset-deassert-us = <30000>;
+		reset-deassert-us = <80000>;
 		reset-gpios = <&gpio GPIOZ_14 GPIO_ACTIVE_LOW>;
 
 		interrupt-parent = <&gpio_intc>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
index bff8ec2c1c70..e38d9e50caa7 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
@@ -194,7 +194,7 @@ external_phy: ethernet-phy@0 {
 		reg = <0>;
 
 		reset-assert-us = <10000>;
-		reset-deassert-us = <30000>;
+		reset-deassert-us = <80000>;
 		reset-gpios = <&gpio GPIOZ_14 GPIO_ACTIVE_LOW>;
 
 		interrupt-parent = <&gpio_intc>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
index 83eca3af44ce..dfa7a37a1281 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-nexbox-a1.dts
@@ -112,7 +112,7 @@ external_phy: ethernet-phy@0 {
 		max-speed = <1000>;
 
 		reset-assert-us = <10000>;
-		reset-deassert-us = <30000>;
+		reset-deassert-us = <80000>;
 		reset-gpios = <&gpio GPIOZ_14 GPIO_ACTIVE_LOW>;
 	};
 };
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-q200.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-q200.dts
index ea45ae0c71b7..8edbfe040805 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-q200.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-q200.dts
@@ -64,7 +64,7 @@ external_phy: ethernet-phy@0 {
 
 		/* External PHY reset is shared with internal PHY Led signal */
 		reset-assert-us = <10000>;
-		reset-deassert-us = <30000>;
+		reset-deassert-us = <80000>;
 		reset-gpios = <&gpio GPIOZ_14 GPIO_ACTIVE_LOW>;
 
 		interrupt-parent = <&gpio_intc>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts
index c89c9f846fb1..dde7cfe12cff 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-rbox-pro.dts
@@ -114,7 +114,7 @@ external_phy: ethernet-phy@0 {
 		max-speed = <1000>;
 
 		reset-assert-us = <10000>;
-		reset-deassert-us = <30000>;
+		reset-deassert-us = <80000>;
 		reset-gpios = <&gpio GPIOZ_14 GPIO_ACTIVE_LOW>;
 	};
 };
-- 
2.29.2

