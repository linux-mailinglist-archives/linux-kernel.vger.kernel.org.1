Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F342220841
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jul 2020 11:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730409AbgGOJKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jul 2020 05:10:07 -0400
Received: from lucky1.263xmail.com ([211.157.147.131]:57356 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728682AbgGOJKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 05:10:05 -0400
Received: from localhost (unknown [192.168.167.235])
        by lucky1.263xmail.com (Postfix) with ESMTP id 3ABBDB0379;
        Wed, 15 Jul 2020 17:06:25 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P5937T140503939016448S1594803977824177_;
        Wed, 15 Jul 2020 17:06:25 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <e5e97746f481f1f5bd491f9dd2d3f77c>
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
Subject: [PATCH v7 8/8] arm: dts: rockchip: Add NFC node for RK3036 SoC
Date:   Wed, 15 Jul 2020 17:06:16 +0800
Message-Id: <20200715090616.28452-4-yifeng.zhao@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200715090616.28452-1-yifeng.zhao@rock-chips.com>
References: <20200715090342.28339-1-yifeng.zhao@rock-chips.com>
 <20200715090616.28452-1-yifeng.zhao@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add NAND FLASH Controller(NFC) node for RK3036 SoC.

Signed-off-by: Yifeng Zhao <yifeng.zhao@rock-chips.com>
---

Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 arch/arm/boot/dts/rk3036.dtsi | 52 +++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/arm/boot/dts/rk3036.dtsi b/arch/arm/boot/dts/rk3036.dtsi
index d9a0c9a29b68..be8d46c0bbb0 100644
--- a/arch/arm/boot/dts/rk3036.dtsi
+++ b/arch/arm/boot/dts/rk3036.dtsi
@@ -291,6 +291,21 @@
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
@@ -642,6 +657,43 @@
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



