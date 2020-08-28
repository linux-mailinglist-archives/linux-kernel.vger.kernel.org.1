Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C98B8255F0E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Aug 2020 18:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbgH1Qti (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Aug 2020 12:49:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:43268 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728421AbgH1QtW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 12:49:22 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50AB120DD4;
        Fri, 28 Aug 2020 16:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598633362;
        bh=CqYRHo/0iH7tLsT9o8PS32qjWWTfkPRR9VIUe5p42aw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eSklfYl41kFc+J0Aj8bXANgqLZVGqcVZ0Rdp5/SZ5IrcrS0MOQr1enNadM4FrWnnp
         WduYBjISLtOOAixoNDAZPiXuyo0kY3e9WUoVx7uOwCgPRFUl58m8C+NzHdbQuTUp3h
         rxSv7/jTXhDHNj3luqFogfJtYLFjlqDPdDF14zIM=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>, Rob Herring <robh+dt@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Han Xu <han.xu@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2 05/19] arm64: dts: imx8mm-beacon-som: Fix atmel,24c64 EEPROM compatible
Date:   Fri, 28 Aug 2020 18:47:36 +0200
Message-Id: <20200828164750.10377-6-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200828164750.10377-1-krzk@kernel.org>
References: <20200828164750.10377-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correct the EEPROM node compatible to match device tree schema (invalid
space, unknown ID) to fix dtbs_check warnings:

  arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dt.yaml: eeprom@50:
    compatible: ['microchip, at24c64d', 'atmel,24c64'] is not valid under any of the given schemas
  arch/arm64/boot/dts/freescale/imx8mm-beacon-kit.dt.yaml: eeprom@50:
    compatible:0: 'microchip, at24c64d' does not match '^[a-zA-Z][a-zA-Z0-9,+\\-._]+$'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi
index f627e82ad929..620a124dfb5f 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi
@@ -184,7 +184,7 @@
 	status = "okay";
 
 	eeprom@50 {
-		compatible = "microchip, at24c64d", "atmel,24c64";
+		compatible = "microchip,24c64", "atmel,24c64";
 		pagesize = <32>;
 		read-only;	/* Manufacturing EEPROM programmed at factory */
 		reg = <0x50>;
-- 
2.17.1

