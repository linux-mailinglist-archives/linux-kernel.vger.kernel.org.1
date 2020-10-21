Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED5EA294B53
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 12:35:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441797AbgJUKfE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 06:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441780AbgJUKfD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 06:35:03 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33CFC0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 21 Oct 2020 03:35:02 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1kVBSK-0006kK-Vy; Wed, 21 Oct 2020 12:34:56 +0200
Received: from afa by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1kVBSK-00024m-Lr; Wed, 21 Oct 2020 12:34:56 +0200
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Cc:     kernel@pengutronix.de, Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] ARM: dts: stm32: support child mfd cells for the stm32mp1 TAMP syscon
Date:   Wed, 21 Oct 2020 12:28:56 +0200
Message-Id: <20201021102855.18026-2-a.fatoum@pengutronix.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201021102855.18026-1-a.fatoum@pengutronix.de>
References: <20201021102855.18026-1-a.fatoum@pengutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: afa@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The stm32mp1 TAMP peripheral has 32 backup registers that survive
a warm reset. This makes them suitable for storing a reboot
mode, which the vendor's kernel tree is already doing[0].

The actual syscon-reboot-mode child node can be added by a board.dts or
fixed up by the bootloader. For the child node to be probed, the
compatible needs to include simple-mfd. The binding now specifies this,
so have the SoC dtsi adhere to it.

[0]: https://github.com/STMicroelectronics/linux/commit/2e9bfc29dd

Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
v1 -> v2:
  - Dropped simple-bus. simple-mfd is all that's needed
  - reworded commit message
---
 arch/arm/boot/dts/stm32mp151.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stm32mp151.dtsi b/arch/arm/boot/dts/stm32mp151.dtsi
index 842ecffae73a..662c2408d41b 100644
--- a/arch/arm/boot/dts/stm32mp151.dtsi
+++ b/arch/arm/boot/dts/stm32mp151.dtsi
@@ -1542,7 +1542,7 @@ i2c6: i2c@5c009000 {
 		};
 
 		tamp: tamp@5c00a000 {
-			compatible = "st,stm32-tamp", "syscon";
+			compatible = "st,stm32-tamp", "syscon", "simple-mfd";
 			reg = <0x5c00a000 0x400>;
 		};
 
-- 
2.28.0

