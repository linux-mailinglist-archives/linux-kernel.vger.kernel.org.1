Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB9C32DE115
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 11:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389118AbgLRKdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 05:33:19 -0500
Received: from comms.puri.sm ([159.203.221.185]:50018 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732959AbgLRKdS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 05:33:18 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 45B2CE019C;
        Fri, 18 Dec 2020 02:32:38 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JT2X49BMuJnj; Fri, 18 Dec 2020 02:32:37 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     robh@kernel.org, shawnguo@kernel.org, festevam@gmail.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, krzk@kernel.org,
        kernel@puri.sm, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH 2/4] arm64: dts: imx8mq-librem5: add pinctrl for the touchscreen description
Date:   Fri, 18 Dec 2020 11:31:29 +0100
Message-Id: <20201218103131.22013-3-martin.kepplinger@puri.sm>
In-Reply-To: <20201218103131.22013-1-martin.kepplinger@puri.sm>
References: <20201218103131.22013-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the pinctrl description for the interrupt.

Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
---
 arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
index 55268fc0622e..a60df09d90f7 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
@@ -459,6 +459,13 @@
 		>;
 	};
 
+	pinctrl_touch: touchgrp {
+		fsl,pins = <
+		/* TP_INT */
+		MX8MQ_IOMUXC_ENET_RD1_GPIO1_IO27	0x80
+		>;
+	};
+
 	pinctrl_typec: typecgrp {
 		fsl,pins = <
 			/* TYPEC_MUX_EN */
@@ -880,6 +887,8 @@
 	touchscreen@38 {
 		compatible = "edt,edt-ft5506";
 		reg = <0x38>;
+		pinctrl-names = "default";
+		pinctrl-0 = <&pinctrl_touch>;
 		interrupt-parent = <&gpio1>;
 		interrupts = <27 IRQ_TYPE_EDGE_FALLING>;
 		touchscreen-size-x = <720>;
-- 
2.20.1

