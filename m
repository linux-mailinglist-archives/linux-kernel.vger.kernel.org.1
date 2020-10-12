Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58DBA28AEE5
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 09:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgJLHSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 03:18:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726694AbgJLHSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 03:18:25 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56FF5C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 12 Oct 2020 00:18:25 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1kRs66-0003Eq-SE; Mon, 12 Oct 2020 09:18:18 +0200
Received: from ore by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1kRs65-0005qm-VF; Mon, 12 Oct 2020 09:18:17 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>,
        devicetree@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        David Jander <david@protonic.nl>
Subject: [PATCH v1] ARM: dts: protonic prti6q: fix PHY address
Date:   Mon, 12 Oct 2020 09:18:16 +0200
Message-Id: <20201012071816.22434-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to bug in the bootloader, the PHY has floating address and may
randomly change on each PHY reset. To avoid it, the updated bootloader
with the following patch[0] should be used:

| ARM: protonic: disable on-die termination to fix PHY bootstrapping
|
| If on-die termination is enabled, the RXC pin of iMX6 will be pulled
| high. Since we already have an 10K pull-down on board, the RXC level on
| PHY reset will be ~800mV, which is mostly interpreted as 1. On some
| reboots we get 0 instead and kernel can't detect the PHY properly.
|
| Since the default 0x020e07ac value is 0, it is sufficient to remove this
| entry from the affected imxcfg files.
|
| Since we get stable 0 on pin PHYADDR[2], the PHY address is changed from
| 4 to 0.

With latest bootloader update, the PHY address will be fixed to "0".

[0] https://git.pengutronix.de/cgit/barebox/commit/?id=93f7dcf631edfcda19e7757b28d66017ea274b81

Fixes: 0d446a50559 ("ARM: dts: add Protonic PRTI6Q board")
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 arch/arm/boot/dts/imx6q-prti6q.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6q-prti6q.dts b/arch/arm/boot/dts/imx6q-prti6q.dts
index de6cbaab8b49..671bb3a6665d 100644
--- a/arch/arm/boot/dts/imx6q-prti6q.dts
+++ b/arch/arm/boot/dts/imx6q-prti6q.dts
@@ -213,8 +213,8 @@ mdio {
 		#size-cells = <0>;
 
 		/* Microchip KSZ9031RNX PHY */
-		rgmii_phy: ethernet-phy@4 {
-			reg = <4>;
+		rgmii_phy: ethernet-phy@0 {
+			reg = <0>;
 			interrupts-extended = <&gpio1 28 IRQ_TYPE_LEVEL_LOW>;
 			reset-gpios = <&gpio1 25 GPIO_ACTIVE_LOW>;
 			reset-assert-us = <10000>;
-- 
2.28.0

