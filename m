Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AECB327A1EB
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 19:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgI0RAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 13:00:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:39552 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726392AbgI0RAD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 13:00:03 -0400
Received: from kozik-lap.proceq-device.com (unknown [194.230.155.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 91CC1239D4;
        Sun, 27 Sep 2020 16:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601226002;
        bh=t+YwkthSo2eBlAb2K2GtNGP6In6SEhjgsb+sAZSMahI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dl8xwSoV6X7661/JJM524KpJ51h/jbmdt7JCnz6sDs7HY+yOgy7LF22RnNY5WkUG6
         Rrdo6UeCH9OApXF4dP5Nnzw1Qmfya8uhP0IZIzUJF80rGlX74Y1DrMG/rasPMCB8qd
         W1llMpyh77aiMRxzD2Aai6jmIPv/4cKT2xx2vPDY=
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
Subject: [PATCH 2/6] arm64: dts: imx8mm-beacon-som: fix missing PMIC's interrupt line pull-up
Date:   Sun, 27 Sep 2020 18:59:43 +0200
Message-Id: <20200927165947.7317-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200927165947.7317-1-krzk@kernel.org>
References: <20200927165947.7317-1-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PMIC's interrupt is level low and should be pulled up.  The PMIC's
device node had pinctrl-0 property but it lacked pinctrl-names which
is required to apply the pin configuration.

Fixes: 5f67317bd967 ("arm64: dts: imx8mm: correct interrupt flags")
Fixes: 593816fa2f35 ("arm64: dts: imx: Add Beacon i.MX8m-Mini development kit")
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi b/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi
index 6de86a4f0ec4..55b36bddd513 100644
--- a/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mm-beacon-som.dtsi
@@ -72,6 +72,7 @@
 	pmic@4b {
 		compatible = "rohm,bd71847";
 		reg = <0x4b>;
+		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_pmic>;
 		interrupt-parent = <&gpio1>;
 		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
-- 
2.17.1

