Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64ADF2E0C8A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 16:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgLVPOu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 10:14:50 -0500
Received: from comms.puri.sm ([159.203.221.185]:54828 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727840AbgLVPOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 10:14:50 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 03B7DE021B;
        Tue, 22 Dec 2020 07:14:10 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id wiO2Ga4tHL6U; Tue, 22 Dec 2020 07:14:09 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     robh@kernel.org, shawnguo@kernel.org, festevam@gmail.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, krzk@kernel.org,
        kernel@puri.sm, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v2 2/4] arm64: dts: imx8mq-librem5: add pinctrl for the touchscreen description
Date:   Tue, 22 Dec 2020 16:13:45 +0100
Message-Id: <20201222151347.7886-3-martin.kepplinger@puri.sm>
In-Reply-To: <20201222151347.7886-1-martin.kepplinger@puri.sm>
References: <20201222151347.7886-1-martin.kepplinger@puri.sm>
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order for the touchscreen interrupt line to work, describe it properly.
Otherwise it can work if defaults are ok, but we cannot be sure.

Fixes: 8f0216b006e5 ("arm64: dts: Add a device tree for the Librem 5 phone")
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

