Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 435222F2BD9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 10:55:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392810AbhALJxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 04:53:43 -0500
Received: from comms.puri.sm ([159.203.221.185]:34598 "EHLO comms.puri.sm"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392782AbhALJxm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 04:53:42 -0500
Received: from localhost (localhost [127.0.0.1])
        by comms.puri.sm (Postfix) with ESMTP id D5E86DFDF1;
        Tue, 12 Jan 2021 01:53:01 -0800 (PST)
Received: from comms.puri.sm ([127.0.0.1])
        by localhost (comms.puri.sm [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id lZmfe6zHuC42; Tue, 12 Jan 2021 01:53:00 -0800 (PST)
From:   Martin Kepplinger <martin.kepplinger@puri.sm>
To:     robh@kernel.org, shawnguo@kernel.org, festevam@gmail.com
Cc:     kernel@pengutronix.de, linux-imx@nxp.com, catalin.marinas@arm.com,
        will@kernel.org, krzk@kernel.org, kernel@puri.sm,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
        Martin Kepplinger <martin.kepplinger@puri.sm>
Subject: [PATCH 2/9] arm64: dts: imx8mq-librem5: Mark charger IRQ as High-Z
Date:   Tue, 12 Jan 2021 10:51:44 +0100
Message-Id: <20210112095151.4995-3-martin.kepplinger@puri.sm>
In-Reply-To: <20210112095151.4995-1-martin.kepplinger@puri.sm>
References: <20210112095151.4995-1-martin.kepplinger@puri.sm>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guido Günther <agx@sigxcpu.org>

This is consistent with other IRQs and makes keeps currents low.

Signed-off-by: Guido Günther <agx@sigxcpu.org>
Signed-off-by: Martin Kepplinger <martin.kepplinger@puri.sm>
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

