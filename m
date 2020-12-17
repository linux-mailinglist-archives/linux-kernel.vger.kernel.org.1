Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA9762DD3EA
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Dec 2020 16:16:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728817AbgLQPOG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Dec 2020 10:14:06 -0500
Received: from honk.sigxcpu.org ([24.134.29.49]:42132 "EHLO honk.sigxcpu.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726291AbgLQPOF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Dec 2020 10:14:05 -0500
Received: from localhost (localhost [127.0.0.1])
        by honk.sigxcpu.org (Postfix) with ESMTP id 22346FB03;
        Thu, 17 Dec 2020 16:13:22 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at honk.sigxcpu.org
Received: from honk.sigxcpu.org ([127.0.0.1])
        by localhost (honk.sigxcpu.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id aQOZOQE_fcvv; Thu, 17 Dec 2020 16:13:20 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
        id 2A5E243FE3; Thu, 17 Dec 2020 16:13:16 +0100 (CET)
From:   =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Martin Kepplinger <martink@posteo.de>,
        Angus Ainslie <angus@akkea.ca>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Li Yang <leoyang.li@nxp.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Vinod Koul <vkoul@kernel.org>,
        Anson Huang <Anson.Huang@nxp.com>,
        Michael Walle <michael@walle.cc>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org
Subject: [PATCH v2 4/4] arm64: dts: imx8mq-librem5-devkit: Drop custom clock settings
Date:   Thu, 17 Dec 2020 16:13:15 +0100
Message-Id: <3343e82ab52e753b385a3e451c07b774920790fc.1608216796.git.agx@sigxcpu.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1608216796.git.agx@sigxcpu.org>
References: <cover.1608216796.git.agx@sigxcpu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Otherwise the boot hangs early on and the resulting clock tree without
this already closely matches the selected rates (722534400 and
786432000).

  audio_pll2                  0        0        0   722534397          0     0  50000
     audio_pll2_bypass        0        0        0   722534397          0     0  50000
        audio_pll2_out        0        0        0   722534397          0     0  50000
  audio_pll1                  1        1        0   786431998          0     0  50000
     audio_pll1_bypass        1        1        0   786431998          0     0  50000
        audio_pll1_out        1        1        0   786431998          0     0  50000
           sai2               1        1        0    24576000          0     0  50000
              sai2_root_clk       1        1        0    24576000          0     0  50000
           sai6               0        0        0    24576000          0     0  50000
              sai6_root_clk       0        0        0    24576000          0     0  50000

Signed-off-by: Guido Günther <agx@sigxcpu.org>
---
 arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
index 05a43ee6d051..dd217a0760e9 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
+++ b/arch/arm64/boot/dts/freescale/imx8mq-librem5-devkit.dts
@@ -244,11 +244,6 @@ &A53_3 {
 	cpu-supply = <&buck2_reg>;
 };
 
-&clk {
-	assigned-clocks = <&clk IMX8MQ_AUDIO_PLL1>, <&clk IMX8MQ_AUDIO_PLL2>;
-	assigned-clock-rates = <786432000>, <722534400>;
-};
-
 &dphy {
 	status = "okay";
 };
-- 
2.29.2

