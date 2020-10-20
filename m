Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F2B7293395
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 05:18:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391141AbgJTDSp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 23:18:45 -0400
Received: from lucky1.263xmail.com ([211.157.147.135]:59662 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391113AbgJTDSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 23:18:34 -0400
Received: from localhost (unknown [192.168.167.235])
        by lucky1.263xmail.com (Postfix) with ESMTP id 04A39A5EE2;
        Tue, 20 Oct 2020 11:18:29 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P2981T139638909118208S1603163896309471_;
        Tue, 20 Oct 2020 11:18:28 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <c50aff8c58acf4b89b6b5baf6d6892de>
X-RL-SENDER: yifeng.zhao@rock-chips.com
X-SENDER: zyf@rock-chips.com
X-LOGIN-NAME: yifeng.zhao@rock-chips.com
X-FST-TO: miquel.raynal@bootlin.com
X-SENDER-IP: 58.22.7.114
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
X-System-Flag: 0
From:   Yifeng Zhao <yifeng.zhao@rock-chips.com>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        robh+dt@kernel.org
Cc:     devicetree@vger.kernel.org, linux-mtd@lists.infradead.org,
        heiko@sntech.de, linux-rockchip@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Yifeng Zhao <yifeng.zhao@rock-chips.com>
Subject: [PATCH v12 8/8] arm: dts: rockchip: Add NFC node for RK3036 SoC
Date:   Tue, 20 Oct 2020 11:18:14 +0800
Message-Id: <20201020031814.17939-4-yifeng.zhao@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201020031814.17939-1-yifeng.zhao@rock-chips.com>
References: <20201020031733.17883-1-yifeng.zhao@rock-chips.com>
 <20201020031814.17939-1-yifeng.zhao@rock-chips.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add NAND FLASH Controller(NFC) node for RK3036 SoC.

Signed-off-by: Yifeng Zhao <yifeng.zhao@rock-chips.com>
---

(no changes since v1)

 arch/arm/boot/dts/rk3036.dtsi | 52 +++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm/boot/dts/rk3036.dtsi b/arch/arm/boot/dts/rk3036.dtsi
index 093567022386..dda5a1f79aca 100644
--- a/arch/arm/boot/dts/rk3036.dtsi
+++ b/arch/arm/boot/dts/rk3036.dtsi
@@ -292,6 +292,21 @@
 		status = "disabled";
 	};
 
+	nfc: nand-controller@10500000 {
+		compatible = "rockchip,rk3036-nfc",
+			     "rockchip,rk2928-nfc";
+		reg = <0x10500000 0x4000>;
+		interrupts = <GIC_SPI 18 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru HCLK_NANDC>, <&cru SCLK_NANDC>;
+		clock-names = "ahb", "nfc";
+		assigned-clocks = <&cru SCLK_NANDC>;
+		assigned-clock-rates = <150000000>;
+		pinctrl-0 = <&flash_ale &flash_bus8 &flash_cle &flash_csn0
+			     &flash_rdn &flash_rdy &flash_wrn>;
+		pinctrl-names = "default";
+		status = "disabled";
+	};
+
 	cru: clock-controller@20000000 {
 		compatible = "rockchip,rk3036-cru";
 		reg = <0x20000000 0x1000>;
@@ -643,6 +658,43 @@
 			};
 		};
 
+		nfc {
+			flash_ale: flash-ale {
+				rockchip,pins = <2 RK_PA0 1 &pcfg_pull_default>;
+			};
+
+			flash_bus8: flash-bus8 {
+				rockchip,pins = <1 RK_PD0 1 &pcfg_pull_default>,
+						<1 RK_PD1 1 &pcfg_pull_default>,
+						<1 RK_PD2 1 &pcfg_pull_default>,
+						<1 RK_PD3 1 &pcfg_pull_default>,
+						<1 RK_PD4 1 &pcfg_pull_default>,
+						<1 RK_PD5 1 &pcfg_pull_default>,
+						<1 RK_PD6 1 &pcfg_pull_default>,
+						<1 RK_PD7 1 &pcfg_pull_default>;
+			};
+
+			flash_cle: flash-cle {
+				rockchip,pins = <2 RK_PA1 1 &pcfg_pull_default>;
+			};
+
+			flash_csn0: flash-csn0 {
+				rockchip,pins = <2 RK_PA6 1 &pcfg_pull_default>;
+			};
+
+			flash_rdn: flash-rdn {
+				rockchip,pins = <2 RK_PA3 1 &pcfg_pull_default>;
+			};
+
+			flash_rdy: flash-rdy {
+				rockchip,pins = <2 RK_PA4 1 &pcfg_pull_default>;
+			};
+
+			flash_wrn: flash-wrn {
+				rockchip,pins = <2 RK_PA2 1 &pcfg_pull_default>;
+			};
+		};
+
 		emac {
 			emac_xfer: emac-xfer {
 				rockchip,pins = <2 RK_PB2 1 &pcfg_pull_default>, /* crs_dvalid */
-- 
2.17.1



