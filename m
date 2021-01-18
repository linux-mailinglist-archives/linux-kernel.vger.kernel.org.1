Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9182F9D47
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 11:56:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389467AbhARK4i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 05:56:38 -0500
Received: from comms.puri.sm ([159.203.221.185]:59514 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389536AbhARKzh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 05:55:37 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id 10172DF65B;
        Mon, 18 Jan 2021 02:54:57 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id JGVpsenaAa51; Mon, 18 Jan 2021 02:54:56 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     robh@kernel.org, shawnguo@kernel.org, festevam@gmail.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, krzk@kernel.org,
        kernel@puri.sm, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, will@kernel.org,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH v2 2/9] arm64: dts: imx8mq-librem5: Mark charger IRQ as High-Z
Date:   Mon, 18 Jan 2021 11:54:18 +0100
Message-Id: <20210118105425.425-3-martin.kepplinger@puri.sm>
In-Reply-To: <20210118105425.425-1-martin.kepplinger@puri.sm>
References: <20210118105425.425-1-martin.kepplinger@puri.sm>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guido Günther <agx@sigxcpu.org>

This is consistent with other IRQs and makes keeps currents low.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
index f85d30a0c2cb..9928e941ee21 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5.dtsi
@@ -276,7 +276,7 @@
 	pinctrl_charger_in: chargeringrp {
 		fsl,pins = <
 			/* CHRG_INT */
-			MX8MQ_IOMUXC_NAND_CE2_B_GPIO3_IO3	0x00
+			MX8MQ_IOMUXC_NAND_CE2_B_GPIO3_IO3	0x80
 			/* CHG_STATUS_B */
 			MX8MQ_IOMUXC_NAND_ALE_GPIO3_IO0		0x80
 		>;
-- 
2.20.1

