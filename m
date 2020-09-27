Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80BA827A1F3
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 19:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726565AbgI0RBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 13:01:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:40784 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726328AbgI0RBk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 13:01:40 -0400
Received: from kozik-lap.proceq-device.com (unknown [194.230.155.132])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C28D23718;
        Sun, 27 Sep 2020 17:00:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601226100;
        bh=ONX1HWW/lQarZVwKRKAcpEQRWzFtua/m+rlceTQC/aE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gxHUcjBSdWBDygZMT7YVbVZ0AjR3cVB8iXv3Gulbq9sgYc1gBQNXp/LZW7hb/m17p
         9vwcUXRXLrakgk3sfhyWQjUOODfrtFqCaNqYqAETF93DSxKdTSx3LEDnQwBVAQxVab
         3RcA72/zdqH/yCddK7yO2FB0FbTh4mZFo8MonpCA=
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
Subject: [PATCH 6/6] arm64: dts: imx8mn-evk: fix missing PMIC's interrupt line pull-up
Date:   Sun, 27 Sep 2020 18:59:47 +0200
Message-Id: <20200927165947.7317-6-krzk@kernel.org>
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
Fixes: 6386156eb279 ("arm64: dts: imx8mn-evk: add pca9450 for i.mx8mn-evk board")
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8mn-evk.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mn-evk.dts b/arch/arm64/boot/dts/freescale/imx8mn-evk.dts
index 707d8486b4d8..8311b95dee49 100644
--- a/arch/arm64/boot/dts/freescale/imx8mn-evk.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mn-evk.dts
@@ -18,6 +18,7 @@
 	pmic: pmic@25 {
 		compatible = "nxp,pca9450b";
 		reg = <0x25>;
+		pinctrl-names = "default";
 		pinctrl-0 = <&pinctrl_pmic>;
 		interrupt-parent = <&gpio1>;
 		interrupts = <3 IRQ_TYPE_LEVEL_LOW>;
-- 
2.17.1

