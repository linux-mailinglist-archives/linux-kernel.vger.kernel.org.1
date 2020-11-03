Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC7F92A52C1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 21:53:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731503AbgKCUw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Nov 2020 15:52:56 -0500
Received: from leonov.paulk.fr ([185.233.101.22]:57368 "EHLO leonov.paulk.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732171AbgKCUwy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Nov 2020 15:52:54 -0500
Received: from gagarine.paulk.fr (gagarine [192.168.1.127])
        by leonov.paulk.fr (Postfix) with ESMTPS id D328FBFBC2;
        Tue,  3 Nov 2020 21:52:51 +0100 (CET)
Received: by gagarine.paulk.fr (Postfix, from userid 114)
        id 2F2A0C1D59; Tue,  3 Nov 2020 21:52:51 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on gagarine.paulk.fr
X-Spam-Level: 
X-Spam-Status: No, score=0.0 required=5.0 tests=none autolearn=unavailable
        autolearn_force=no version=3.4.2
Received: from localhost.localdomain (collins [192.168.1.129])
        by gagarine.paulk.fr (Postfix) with ESMTP id 6F0DCC1D4A;
        Tue,  3 Nov 2020 21:51:01 +0100 (CET)
From:   Paul Kocialkowski <contact@paulk.fr>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, Icenowy Zheng <icenowy@aosc.io>,
        Paul Kocialkowski <contact@paulk.fr>,
        Matteo Scordino <matteo.scordino@gmail.com>
Subject: [PATCH v2 3/6] ARM: dts: sun8i-v3s: Add the V3s NMI IRQ controller
Date:   Tue,  3 Nov 2020 21:50:55 +0100
Message-Id: <20201103205058.435207-4-contact@paulk.fr>
X-Mailer: git-send-email 2.29.1
In-Reply-To: <20201103205058.435207-1-contact@paulk.fr>
References: <20201103205058.435207-1-contact@paulk.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The V3s/V3 has a NMI interrupt controller, mainly used for the AXP209.
Its address follows the system controller block, which was previously
incorrectly described as spanning over 0x1000 address bytes.
Even though this is what the Allwinner documentation indicates,
precedence from other SoCs such as the R40 suggests that this is not
actually the case.

This reduces the system controller address span up to the NMI
controller and adds a node for the controller, with its dedicated
compatible.

While the interrupt number was found in Allwinner's documentation,
the address for the controller is specified in any Allwinner SDK
supporting sun8iw8 (V3/V3s) at:
drivers/power/axp_power/axp20/axp20-board.c

It was tested to work on a V3 board with an AXP209 connected to the
NMI interrupt line.

Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
---
 arch/arm/boot/dts/sun8i-v3s.dtsi | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun8i-v3s.dtsi b/arch/arm/boot/dts/sun8i-v3s.dtsi
index 7b2d684aeb97..d2e2abd3869a 100644
--- a/arch/arm/boot/dts/sun8i-v3s.dtsi
+++ b/arch/arm/boot/dts/sun8i-v3s.dtsi
@@ -157,12 +157,20 @@ mixer0_out_tcon0: endpoint {
 		syscon: system-control@1c00000 {
 			compatible = "allwinner,sun8i-v3s-system-control",
 				     "allwinner,sun8i-h3-system-control";
-			reg = <0x01c00000 0x1000>;
+			reg = <0x01c00000 0xd0>;
 			#address-cells = <1>;
 			#size-cells = <1>;
 			ranges;
 		};
 
+		nmi_intc: interrupt-controller@1c000d0 {
+			compatible = "allwinner,sun8i-v3s-sc-nmi";
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			reg = <0x01c000d0 0x0c>;
+			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
+		};
+
 		tcon0: lcd-controller@1c0c000 {
 			compatible = "allwinner,sun8i-v3s-tcon";
 			reg = <0x01c0c000 0x1000>;
-- 
2.29.1

