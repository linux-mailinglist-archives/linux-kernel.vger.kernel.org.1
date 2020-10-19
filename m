Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0632923B2
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 10:34:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729264AbgJSIer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 04:34:47 -0400
Received: from lucky1.263xmail.com ([211.157.147.134]:58966 "EHLO
        lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729073AbgJSIep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 04:34:45 -0400
Received: from localhost (unknown [192.168.167.8])
        by lucky1.263xmail.com (Postfix) with ESMTP id 4B070C4DDD;
        Mon, 19 Oct 2020 16:34:42 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [58.22.7.114])
        by smtp.263.net (postfix) whith ESMTP id P2450T140206693807872S1603096477685464_;
        Mon, 19 Oct 2020 16:34:42 +0800 (CST)
X-IP-DOMAINF: 1
X-UNIQUE-TAG: <5ea0324e20c5a8872fe88b77bf8ab0ce>
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
Subject: [PATCH v11 5/8] arm64: dts: rockchip: Add NFC node for PX30 SoC
Date:   Mon, 19 Oct 2020 16:34:33 +0800
Message-Id: <20201019083436.32677-1-yifeng.zhao@rock-chips.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201019083358.32621-1-yifeng.zhao@rock-chips.com>
References: <20201019083358.32621-1-yifeng.zhao@rock-chips.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add NAND FLASH Controller(NFC) node for PX30 SoC.

Signed-off-by: Yifeng Zhao <yifeng.zhao@rock-chips.com>
---

(no changes since v1)

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



