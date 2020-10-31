Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96D872A1979
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 19:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbgJaSXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 14:23:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728116AbgJaSXU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 14:23:20 -0400
Received: from leonov.paulk.fr (vpn-0-22.aquilenet.fr [IPv6:2a0c:e300:4:22::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B68C0617A7;
        Sat, 31 Oct 2020 11:23:20 -0700 (PDT)
Received: from gagarine.paulk.fr (gagarine [192.168.1.127])
        by leonov.paulk.fr (Postfix) with ESMTPS id 32619C036D;
        Sat, 31 Oct 2020 19:23:19 +0100 (CET)
Received: by gagarine.paulk.fr (Postfix, from userid 114)
        id 991C6C1D6B; Sat, 31 Oct 2020 19:23:18 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on gagarine.paulk.fr
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=5.0 tests=RDNS_NONE autolearn=no
        autolearn_force=no version=3.4.2
Received: from localhost.localdomain (unknown [192.168.1.101])
        by gagarine.paulk.fr (Postfix) with ESMTP id 6EF8EC1D6C;
        Sat, 31 Oct 2020 19:21:56 +0100 (CET)
From:   Paul Kocialkowski <contact@paulk.fr>
To:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Matteo Scordino <matteo.scordino@gmail.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Paul Kocialkowski <contact@paulk.fr>
Subject: [PATCH 6/9] ARM: dts: sun8i-v3s: Add the V3s NMI IRQ controller
Date:   Sat, 31 Oct 2020 19:21:34 +0100
Message-Id: <20201031182137.1879521-7-contact@paulk.fr>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201031182137.1879521-1-contact@paulk.fr>
References: <20201031182137.1879521-1-contact@paulk.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The V3s/V3 has a NMI interrupt controller, mainly used for the AXP209.
Its address follows the sytsem controller block, which was previously
incorrectly described as spanning over 0x1000 address bytes.

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
2.28.0

