Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13B5B27DE4E
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Sep 2020 04:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729904AbgI3CJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 22:09:11 -0400
Received: from lucky1.263xmail.com ([211.157.147.131]:35100 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729499AbgI3CJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 22:09:11 -0400
Received: from localhost (unknown [192.168.167.235])
        by lucky1.263xmail.com (Postfix) with ESMTP id 3BE9EB5541;
        Wed, 30 Sep 2020 10:09:09 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P2981T139638771541760S1601431744269822_;
        Wed, 30 Sep 2020 10:09:08 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <49e9b27a3f90f8f43367c442f5aba43e>
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
Subject: [PATCH v10 5/8] arm64: dts: rockchip: Add NFC node for PX30 SoC
Date:   Wed, 30 Sep 2020 10:08:59 +0800
Message-Id: <20200930020902.7522-1-yifeng.zhao@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200930020710.7394-1-yifeng.zhao@rock-chips.com>
References: <20200930020710.7394-1-yifeng.zhao@rock-chips.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add NAND FLASH Controller(NFC) node for PX30 SoC.

Signed-off-by: Yifeng Zhao <yifeng.zhao@rock-chips.com>
---

Changes in v10: None
Changes in v9: None
Changes in v8: None
Changes in v7: None
Changes in v6: None
Changes in v5: None
Changes in v4: None
Changes in v3: None
Changes in v2: None

 arch/arm64/boot/dts/rockchip/px30.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/px30.dtsi b/arch/arm64/boot/dts/rockchip/px30.dtsi
index 2695ea8cda14..6cd67e80d623 100644
--- a/arch/arm64/boot/dts/rockchip/px30.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30.dtsi
@@ -973,6 +973,21 @@
 		status = "disabled";
 	};
 
+	nfc: nand-controller@ff3b0000 {
+		compatible = "rockchip,px30-nfc";
+		reg = <0x0 0xff3b0000 0x0 0x4000>;
+		interrupts = <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&cru HCLK_NANDC>, <&cru SCLK_NANDC>;
+		clock-names = "ahb", "nfc";
+		assigned-clocks = <&cru SCLK_NANDC>;
+		assigned-clock-rates = <150000000>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&flash_ale &flash_bus8 &flash_cle &flash_cs0
+			     &flash_rdn &flash_rdy &flash_wrn &flash_dqs>;
+		power-domains = <&power PX30_PD_MMC_NAND>;
+		status = "disabled";
+	};
+
 	gpu: gpu@ff400000 {
 		compatible = "rockchip,px30-mali", "arm,mali-bifrost";
 		reg = <0x0 0xff400000 0x0 0x4000>;
-- 
2.17.1



