Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98E6E2B1EA8
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 16:29:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbgKMP3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 10:29:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726278AbgKMP3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 10:29:08 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E5F1C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Nov 2020 07:29:08 -0800 (PST)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1kdb0V-0005ZU-Sx; Fri, 13 Nov 2020 16:28:59 +0100
Received: from afa by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1kdb0V-0000zk-2g; Fri, 13 Nov 2020 16:28:59 +0100
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH] ARM: dts: imx6qdl: specify vcc-supply for NOP USB PHYs
Date:   Fri, 13 Nov 2020 16:28:55 +0100
Message-Id: <20201113152856.3758-1-a.fatoum@pengutronix.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: afa@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SoC dtsi lists a NOP USB PHY for each of the two HSIC-only USB
controllers. Their device tree node doesn't indicate a vcc-supply
resulting in:

  usb_phy_generic usbphynop1: supply vcc not found, using dummy regulator
  usb_phy_generic usbphynop2: supply vcc not found, using dummy regulator

warnings on boot up. The USB IP vcc-supply - separate from the vusb - is
hardwired to LDO_2P5[1], which we already have a device tree node for.
Reference it for the dummy "phy" as well.

This will lead to breakage (probe deferment) for kernels that:
  - Use a HSIC USB controller
  - Use this new device tree
  - but have CONFIG_REGULATOR_ANATOP disabled

Because while the regulator is always-on, it can't be resolved when
there is no driver for it.

As there are

  - no affected upstream device trees
  - existing device trees are unaffected without recompilation
  - disabling CONFIG_REGULATOR_ANATOP is explicitly a non-recommended
    configuration per symbol help text

this potential breakage is deemed acceptable.

[1]: i.MX 6Dual/6Quad Reference Manual, Rev. C,
     Figure 53-1. Power System Overview

Cc: Frieder Schrempf <frieder.schrempf@kontron.de>
Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
 arch/arm/boot/dts/imx6qdl.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/imx6qdl.dtsi b/arch/arm/boot/dts/imx6qdl.dtsi
index 43edbf1156c7..22e4c142de13 100644
--- a/arch/arm/boot/dts/imx6qdl.dtsi
+++ b/arch/arm/boot/dts/imx6qdl.dtsi
@@ -131,11 +131,13 @@ pmu: pmu {
 
 	usbphynop1: usbphynop1 {
 		compatible = "usb-nop-xceiv";
+		vcc-supply = <&reg_vdd2p5>;
 		#phy-cells = <0>;
 	};
 
 	usbphynop2: usbphynop2 {
 		compatible = "usb-nop-xceiv";
+		vcc-supply = <&reg_vdd2p5>;
 		#phy-cells = <0>;
 	};
 
-- 
2.28.0

