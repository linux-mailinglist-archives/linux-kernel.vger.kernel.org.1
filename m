Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A877C256128
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Aug 2020 21:22:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgH1TWj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Aug 2020 15:22:39 -0400
Received: from mail.kernel.org ([198.145.29.99]:46996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbgH1TWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 15:22:38 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0EFF42073A;
        Fri, 28 Aug 2020 19:22:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598642558;
        bh=SsWfjA5eIV9Q084cck3GujGTUi9QVLgIgfP8+HxBqiU=;
        h=From:To:Subject:Date:From;
        b=WkZbgQVmzaU+skuXsf0aAlFCfz9y6XpCS6a0SshPjaTCVfVKAabZ9TRsj0t11DFq0
         wJT+kWYj9xsqrPTIxDjMBIwI4Cdfv0LVxTpkcg820gCJgdlRycBR3Bpvvi3tfLZeOO
         /bEUo2Y/fv6oHTIIQem6+tbCvrhip61ZZo1RTNTQ=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Martin Kepplinger <martink@posteo.de>,
        "Angus Ainslie (Purism)" <angus@akkea.ca>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Anson Huang <Anson.Huang@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: dts: imx8mq-librem5-devkit: Add missing clock-cells to PMIC
Date:   Fri, 28 Aug 2020 21:22:28 +0200
Message-Id: <20200828192228.23060-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PMIC node can be a clock provider (for its 32 kHz clock) and authors
of imx8mq-librem5-devkit.dts apparently wanted this because they added
input clock and clock-output-names.

Add necessary clock-cells to the PMIC node.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
index 377591a0e6e9..40b43625f20f 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
@@ -285,6 +285,7 @@
 		pinctrl-0 = <&pinctrl_pmic>;
 		clocks = <&pmic_osc>;
 		clock-names = "osc";
+		#clock-cells = <0>;
 		clock-output-names = "pmic_clk";
 		interrupt-parent = <&gpio1>;
 		interrupts = <3 GPIO_ACTIVE_LOW>;
-- 
2.17.1

