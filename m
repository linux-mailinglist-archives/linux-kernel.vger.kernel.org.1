Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC81B27A1F1
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 19:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbgI0RAe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 13:00:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:40082 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726392AbgI0RAe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 13:00:34 -0400
Received: from kozik-lap.proceq-device.com (unknown [194.230.155.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1F322389F;
        Sun, 27 Sep 2020 17:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601226033;
        bh=jeFCDuCNPiferb7HFoWMgZAruhGXPPdVaTZYSWdVoM4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V24Uiq5FTi6MyxKwCYiTTa5Ilz71thN93M+CytIyfbl3x7PzoWHP9ZcUq/qHWg5IM
         qwUaGX8d7cGuuuIzzCjH/LxQwsDHhaTnYoF6suIEj2yceck2GFyW8V80a9+vFy6rrk
         syjpbDdoA54ZvfN1lHz0hWvtYRK9pz4o6gRuSAdg=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Adam Ford <aford173@gmail.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>,
        Peter Chen <peter.chen@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 5/6] arm64: dts: imx8mn-ddr4-evk: fix missing PMIC's interrupt line pull-up
Date:   Sun, 27 Sep 2020 18:59:46 +0200
Message-Id: <20200927165947.7317-5-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200927165947.7317-1-krzk@kernel.org>
References: <20200927165947.7317-1-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PMIC's interrupt is level low and should be pulled up.  The PMIC's
device node had pinctrl-0 property but it lacked pinctrl-names which
is required to apply the pin configuration.

Fixes: 4153f7811a9b ("arm64: dts: imx8mn: correct interrupt flags")
Fixes: 3e44dd09736d ("arm64: dts: imx8mn-ddr4-evk: Add rohm,bd71847 PMIC support")
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts b/arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts
index 46e76cf32b2f..7dfee715a2c4 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mn-ddr4-evk.dts
@@ -53,6 +53,7 @@
 	pmic@4b {
 		compatible = "rohm,bd71847";
 		reg = <0x4b>;
+		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_pmic>;
 		interrupt-parent = <&gpio1>;
 		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
-- 
2.17.1

