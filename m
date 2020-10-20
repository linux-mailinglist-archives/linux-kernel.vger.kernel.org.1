Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1636293E1D
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 16:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407842AbgJTOGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 10:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407779AbgJTOGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 10:06:04 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17825C061755
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 07:06:04 -0700 (PDT)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1kUsGy-0003id-GA; Tue, 20 Oct 2020 16:05:56 +0200
Received: from afa by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <afa@pengutronix.de>)
        id 1kUsGw-0000KI-My; Tue, 20 Oct 2020 16:05:54 +0200
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>
Cc:     kernel@pengutronix.de, Yann Gautier <yann.gautier@st.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Ludovic Barre <ludovic.barre@st.com>,
        devicetree@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: stm32: update sdmmc IP version for STM32MP157 SOC
Date:   Tue, 20 Oct 2020 16:04:51 +0200
Message-Id: <20201020140450.29158-1-a.fatoum@pengutronix.de>
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

From: Yann Gautier <yann.gautier@st.com>

Update the IP version to v2.0, which supports linked lists in internal DMA,
and is present in STM32MP1 SoCs.

The mmci driver supports the v2.0 periph id since 7a2a98be672b ("mmc: mmci:
Add support for sdmmc variant revision 2.0"), so it's now Ok to add it into
the SoC device tree to benefit from the improved DMA support.

Signed-off-by: Ludovic Barre <ludovic.barre@st.com>
Signed-off-by: Yann Gautier <yann.gautier@st.com>
[afa: cherry-picked from https://github.com/STMicroelectronics/linux/commit/31e2a6bc8]
[afa: extended commit message with reference to driver patch]
Signed-off-by: Ahmad Fatoum <a.fatoum@pengutronix.de>
---
Cc: Ludovic Barre <ludovic.barre@st.com>
---
 arch/arm/boot/dts/stm32mp151.dtsi | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/stm32mp151.dtsi b/arch/arm/boot/dts/stm32mp151.dtsi
index bfe29023fbd5..b8d996d32dc0 100644
--- a/arch/arm/boot/dts/stm32mp151.dtsi
+++ b/arch/arm/boot/dts/stm32mp151.dtsi
@@ -1040,7 +1040,7 @@ adc2: adc@100 {
 
 		sdmmc3: sdmmc@48004000 {
 			compatible = "arm,pl18x", "arm,primecell";
-			arm,primecell-periphid = <0x10153180>;
+			arm,primecell-periphid = <0x00253180>;
 			reg = <0x48004000 0x400>;
 			interrupts = <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "cmd_irq";
@@ -1338,7 +1338,7 @@ qspi: spi@58003000 {
 
 		sdmmc1: sdmmc@58005000 {
 			compatible = "arm,pl18x", "arm,primecell";
-			arm,primecell-periphid = <0x10153180>;
+			arm,primecell-periphid = <0x00253180>;
 			reg = <0x58005000 0x1000>;
 			interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "cmd_irq";
@@ -1353,7 +1353,7 @@ sdmmc1: sdmmc@58005000 {
 
 		sdmmc2: sdmmc@58007000 {
 			compatible = "arm,pl18x", "arm,primecell";
-			arm,primecell-periphid = <0x10153180>;
+			arm,primecell-periphid = <0x00253180>;
 			reg = <0x58007000 0x1000>;
 			interrupts = <GIC_SPI 124 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "cmd_irq";
-- 
2.28.0

