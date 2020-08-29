Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52005256709
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Aug 2020 13:13:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728041AbgH2LNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Aug 2020 07:13:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:39114 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726876AbgH2LMy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 07:12:54 -0400
Received: from localhost.localdomain (unknown [194.230.155.216])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BD174207DF;
        Sat, 29 Aug 2020 11:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598699574;
        bh=VnNc7+uZcxG8XMiLRL43M8aRpdv+zundAbqmloq3LDg=;
        h=From:To:Cc:Subject:Date:From;
        b=W+liGVS9wxeji6GF3xckVmzm30iqWbvrah6E/uw8bvbfQVF7G6hv38z5D6h4q4W+u
         sLB8Ap139V+UFTHoKuER2j9D7Kx6IuZABUMyo+41nl5NAeG3WhiLAcb6EHO1ZWVlVV
         UROVmQtnaKc9PA+3Wj0tH2dJnylgBmkH3DGKGGes=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH] arm64: dts: imx8mq: Fix TMU interrupt property
Date:   Sat, 29 Aug 2020 13:12:48 +0200
Message-Id: <20200829111248.321-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"interrupt" is not a valid property.  Using proper name fixes dtbs_check
warning:

  arch/arm64/boot/dts/freescale/imx8mq-zii-ultra-zest.dt.yaml: tmu@30260000: 'interrupts' is a required property

Fixes: e464fd2ba4d4 ("arm64: dts: imx8mq: enable the multi sensor TMU")
Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8mq.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mq.dtsi b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
index f70435cf9ad5..561fa792fe5a 100644
--- a/arch/arm64/boot/dts/freescale/imx8mq.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mq.dtsi
@@ -423,7 +423,7 @@
 			tmu: tmu@30260000 {
 				compatible = "fsl,imx8mq-tmu";
 				reg = <0x30260000 0x10000>;
-				interrupt = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
+				interrupts = <GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>;
 				clocks = <&clk IMX8MQ_CLK_TMU_ROOT>;
 				little-endian;
 				fsl,tmu-range = <0xb0000 0xa0026 0x80048 0x70061>;
-- 
2.17.1

