Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08DE92FE9E2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 13:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbhAUMWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 07:22:11 -0500
Received: from inva021.nxp.com ([92.121.34.21]:54690 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729784AbhAUK64 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 05:58:56 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id AA55D200C68;
        Thu, 21 Jan 2021 11:58:09 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 05D4B200C74;
        Thu, 21 Jan 2021 11:58:07 +0100 (CET)
Received: from lsv03124.swis.in-blr01.nxp.com (lsv03124.swis.in-blr01.nxp.com [92.120.146.121])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 8F92740297;
        Thu, 21 Jan 2021 11:58:03 +0100 (CET)
From:   Kuldeep Singh <kuldeep.singh@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, Li Yang <leoyang.li@nxp.com>,
        Kuldeep Singh <kuldeep.singh@nxp.com>
Subject: [Patch v2 2/3] arm64: dtsi: ls1028a: Update flexcan properties
Date:   Thu, 21 Jan 2021 16:27:38 +0530
Message-Id: <1611226659-30129-3-git-send-email-kuldeep.singh@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1611226659-30129-1-git-send-email-kuldeep.singh@nxp.com>
References: <1611226659-30129-1-git-send-email-kuldeep.singh@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LS1028A supports two flexcan controllers similar to LX2160A.

There's already a compatible entry defined i.e "fsl,lx2160ar1-flexcan"
which can be further reused for LS1028A.
Please note, "fsl,ls1028ar1-flexcan" compatible entry doesn't exists and
can be safely removed.

LS1028A has a single peripheral clock (i.e platform clock) source
connected to both "ipg" and "per" and therefore, remove "sysclk" as
clock source from device-tree.

Signed-off-by: Kuldeep Singh <kuldeep.singh@nxp.com>
---
Hi Shawn,
I would like to mention the motivation behind compatible string change.
There's no ls1028a compatible entry i.e " fsl,ls1028ar1-flexcan" in flexcan
driver. See below.
https://elixir.bootlin.com/linux/latest/source/drivers/net/can/flexcan.c#L1913

And the documentation says that ls1028a entry should be followed by lx2160a.
https://elixir.bootlin.com/linux/latest/source/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml#L42

Since ls1028a entry is not present, anyway lx2160a entry will be eventually used.
Please let me know your views.

 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index e00acad..d28bd52 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -408,21 +408,25 @@
 		};
 
 		can0: can@2180000 {
-			compatible = "fsl,ls1028ar1-flexcan", "fsl,lx2160ar1-flexcan";
+			compatible = "fsl,lx2160ar1-flexcan";
 			reg = <0x0 0x2180000 0x0 0x10000>;
 			interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&sysclk>, <&clockgen QORIQ_CLK_PLATFORM_PLL
-						       QORIQ_CLK_PLL_DIV(2)>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(2)>,
+				 <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(2)>;
 			clock-names = "ipg", "per";
 			status = "disabled";
 		};
 
 		can1: can@2190000 {
-			compatible = "fsl,ls1028ar1-flexcan", "fsl,lx2160ar1-flexcan";
+			compatible = "fsl,lx2160ar1-flexcan";
 			reg = <0x0 0x2190000 0x0 0x10000>;
 			interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&sysclk>, <&clockgen QORIQ_CLK_PLATFORM_PLL
-						       QORIQ_CLK_PLL_DIV(2)>;
+			clocks = <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(2)>,
+				 <&clockgen QORIQ_CLK_PLATFORM_PLL
+					    QORIQ_CLK_PLL_DIV(2)>;
 			clock-names = "ipg", "per";
 			status = "disabled";
 		};
-- 
2.7.4

