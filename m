Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 927BD2508C5
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Aug 2020 21:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727041AbgHXTHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Aug 2020 15:07:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:57392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725904AbgHXTHc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 15:07:32 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 085AB20866;
        Mon, 24 Aug 2020 19:07:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598296051;
        bh=rxCetTspe8KMioT4q53ipWCXmDgk8Gu8XRI1Kwelkcc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LbVFW+a8poD4t9MvV0gub2MluDm4nWKHmtapomgmSZjwQoNsFpOGQV75XWot3KX7l
         aOJQ0wQIPUNG2V6DPCC8oE49KHXkI24mP8tAQchX3+aK4xfoL9Vs5d/f5enMN09B2x
         FktGM4TeOSc0/EVpY28yEZwBfZJmOZIFCIiFIH2k=
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
        Adam Ford <aford173@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Robin Gong <yibin.gong@nxp.com>, Li Jun <jun.li@nxp.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Han Xu <han.xu@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 04/16] arm64: dts: imx8mm-beacon-baseboard: Correct SPI CS polarity
Date:   Mon, 24 Aug 2020 21:06:49 +0200
Message-Id: <20200824190701.8447-4-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200824190701.8447-1-krzk@kernel.org>
References: <20200824190701.8447-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the "spi-cs-high" property is not present, the SPI chip select pin
polarity is active low.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi
index bf0859f1e1fa..5b5af8b381df 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-beacon-baseboard.dtsi
@@ -70,7 +70,7 @@
 &ecspi2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_espi2>;
-	cs-gpios = <&gpio5 9 0>;
+	cs-gpios = <&gpio5 9 GPIO_ACTIVE_LOW>;
 	status = "okay";
 
 	eeprom@0 {
-- 
2.17.1

