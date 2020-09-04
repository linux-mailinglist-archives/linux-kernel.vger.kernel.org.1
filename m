Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F7F625D13E
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 08:28:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728108AbgIDG16 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 02:27:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:45984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbgIDG14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 02:27:56 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 777B82086A;
        Fri,  4 Sep 2020 06:27:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599200875;
        bh=kvDTII5zSFyNmj5eIlA/5tyXW3tDsDhHVGiOPUxpzO4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=j9GZP5FvaOnUsrabCTac58pL+F7rwwltHiKM9oPWrAAtxeol/2cy+EXUaCCqgDjnd
         /CrApqJO3mUxC+4I+axNkB0KbG7a6tMx80o8HxNpbozA5l+vu5ipsmrob1WPIQX8K4
         1JaHzAIclJ8oj11b2zBTYZoROPSaMqkOuOViX+H4=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH v2 02/14] arm64: dts: imx8mm-evk: Add 32.768 kHz clock to PMIC
Date:   Fri,  4 Sep 2020 08:27:31 +0200
Message-Id: <20200904062743.6273-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200904062743.6273-1-krzk@kernel.org>
References: <20200904062743.6273-1-krzk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ROHM BD71847 PMIC has a 32.768 kHz clock.  Adding necessary parent
allows to probe the bd718x7 clock driver fixing boot errors:

    bd718xx-clk bd71847-clk.1.auto: No parent clk found
    bd718xx-clk: probe of bd71847-clk.1.auto failed with error -22

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-By: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 arch/arm64/boot/dts/freescale/imx8mm-evk.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-evk.dts b/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
index 38134d201eef..1c39a2b90ee1 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mm-evk.dts
@@ -169,6 +169,10 @@
 		interrupts = <3 GPIO_ACTIVE_LOW>;
 		rohm,reset-snvs-powered;
 
+		#clock-cells = <0>;
+		clocks = <&osc_32k 0>;
+		clock-output-names = "clk-32k-out";
+
 		regulators {
 			buck1_reg: BUCK1 {
 				regulator-name = "buck1";
-- 
2.17.1

