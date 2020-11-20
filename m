Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE0A62BA6C3
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Nov 2020 10:57:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbgKTJ42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Nov 2020 04:56:28 -0500
Received: from lucky1.263xmail.com ([211.157.147.134]:57890 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727696AbgKTJ40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Nov 2020 04:56:26 -0500
Received: from localhost (unknown [192.168.167.223])
        by lucky1.263xmail.com (Postfix) with ESMTP id 1CF66C5555;
        Fri, 20 Nov 2020 17:56:22 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P21631T139747833935616S1605866174624500_;
        Fri, 20 Nov 2020 17:56:22 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <52cbdf21a468047bdc6cbca6b4a167f5>
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
        Yifeng Zhao <zyf@rock-chips.com>,
        Yifeng Zhao <yifeng.zhao@rock-chips.com>
Subject: [PATCH v14 4/8] arm64: dts: rockchip: Add NFC node for RK3308 SoC
Date:   Fri, 20 Nov 2020 17:56:13 +0800
Message-Id: <20201120095613.20172-5-yifeng.zhao@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201120095613.20172-1-yifeng.zhao@rock-chips.com>
References: <20201120095613.20172-1-yifeng.zhao@rock-chips.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yifeng Zhao <zyf@rock-chips.com>

Add NAND FLASH Controller(NFC) node for RK3308 SoC.

Signed-off-by: Yifeng Zhao <zyf@rock-chips.com>
Signed-off-by: Yifeng Zhao <yifeng.zhao@rock-chips.com>
---

Changes in v14: None
Changes in v13: None
Changes in v12: None
Changes in v11: None
Changes in v10: None
Changes in v9: None
Changes in v8: None
Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 arch/arm64/boot/dts/rockchip/rk3308.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/rk3308.dtsi b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
index b3118cabd0f6..f6b4d47089b5 100644
--- a/arch/arm64/boot/dts/rockchip/rk3308.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
@@ -629,6 +629,21 @@
 		status = "disabled";
 	};
 
+	nfc: nand-controller@ff4b0000 {
+		compatible = "rockchip,rk3308-nfc",
+			     "rockchip,rv1108-nfc";
+		reg = <0x0 0xff4b0000 0x0 0x4000>;
+		interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
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
 	cru: clock-controller@ff500000 {
 		compatible = "rockchip,rk3308-cru";
 		reg = <0x0 0xff500000 0x0 0x1000>;
-- 
2.17.1



