Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6A327BFC9
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 10:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727849AbgI2Ikh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 04:40:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:47056 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725710AbgI2Ikg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 04:40:36 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.194])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 778A6206BE;
        Tue, 29 Sep 2020 08:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1601368835;
        bh=ytsu4gTridp6EXkDEsUYWto5d+cRM96B23swmWy0BpQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X9dSDmZ9/i+KHFjm4LB2RzU7xXRmsO5VoRH6DXum7ZwVAWtnY9wjmndYULtNkClle
         5Fsdz/0uGQwijiMk+hMwzmBkCUmjCBLC7mWto8YvgVHDDjDDR6cHwORekk4gvGzjcA
         hHVKz7/PsNERe3N9WSlUcE+Rk4zZ73VrVYxxHwks=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Anson Huang <Anson.Huang@nxp.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Jacky Bai <ping.bai@nxp.com>, Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 3/3] arm64: dts: imx8mp: adjust GIC CPU mask to match number of CPUs
Date:   Tue, 29 Sep 2020 10:40:15 +0200
Message-Id: <20200929084015.7178-3-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929084015.7178-1-krzk@kernel.org>
References: <20200929084015.7178-1-krzk@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

i.MX 8M Plus has four Cortex-A CPUs, not six.  Using higher value is
harmless but adjust it to match real HW.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/freescale/imx8mp.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/imx8mp.dtsi b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
index 6038f66aefc1..c69c206068a4 100644
--- a/arch/arm64/boot/dts/freescale/imx8mp.dtsi
+++ b/arch/arm64/boot/dts/freescale/imx8mp.dtsi
@@ -202,10 +202,10 @@
 
 	timer {
 		compatible = "arm,armv8-timer";
-		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>,
-			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>,
-			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>,
-			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(6) | IRQ_TYPE_LEVEL_LOW)>;
+		interrupts = <GIC_PPI 13 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 14 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 11 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>,
+			     <GIC_PPI 10 (GIC_CPU_MASK_SIMPLE(4) | IRQ_TYPE_LEVEL_LOW)>;
 		clock-frequency = <8000000>;
 		arm,no-tick-in-suspend;
 	};
-- 
2.17.1

