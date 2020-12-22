Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74C532E0C88
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 16:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727833AbgLVPOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 10:14:46 -0500
Received: from comms.puri.sm ([159.203.221.185]:54808 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726868AbgLVPOp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 10:14:45 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 6660BE0212;
        Tue, 22 Dec 2020 07:14:05 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id rh01BL-ncLL3; Tue, 22 Dec 2020 07:14:04 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     robh@kernel.org, shawnguo@kernel.org, festevam@gmail.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, krzk@kernel.org,
        kernel@puri.sm, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v2 1/4] arm64: dts: imx8mq-librem5: add vin-supply to VDD_1V8
Date:   Tue, 22 Dec 2020 16:13:44 +0100
Message-Id: <20201222151347.7886-2-martin.kepplinger@puri.sm>
In-Reply-To: <20201222151347.7886-1-martin.kepplinger@puri.sm>
References: <20201222151347.7886-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

buck7 is the supply here. Also, fix alphabetical ordering.

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
index 64fc546b110f..55268fc0622e 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
@@ -99,6 +99,14 @@
 		regulator-max-microvolt = <3300000>;
 	};
 
+	reg_vdd_1v8: regulator-vdd-1v8 {
+		compatible = "regulator-fixed";
+		regulator-name = "VDD_1V8";
+		regulator-min-microvolt = <1800000>;
+		regulator-max-microvolt = <1800000>;
+		vin-supply = <&buck7_reg>;
+	};
+
 	reg_vdd_3v3: regulator-vdd-3v3 {
 		compatible = "regulator-fixed";
 		regulator-name = "VDD_3V3";
@@ -106,13 +114,6 @@
 		regulator-max-microvolt = <3300000>;
 	};
 
-	reg_vdd_1v8: regulator-vdd-1v8 {
-		compatible = "regulator-fixed";
-		regulator-name = "VCC_1V8";
-		regulator-min-microvolt = <1800000>;
-		regulator-max-microvolt = <1800000>;
-	};
-
 	reg_vsys_3v4: regulator-vsys-3v4 {
 		compatible = "regulator-fixed";
 		regulator-name = "VSYS_3V4";
-- 
2.20.1

