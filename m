Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 644662F0D47
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 08:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbhAKHj5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 02:39:57 -0500
Received: from inva021.nxp.com ([92.121.34.21]:54896 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727185AbhAKHjz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 02:39:55 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C0B68200BF4;
        Mon, 11 Jan 2021 08:39:08 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 6D320200C35;
        Mon, 11 Jan 2021 08:39:06 +0100 (CET)
Received: from lsv03124.swis.in-blr01.nxp.com (lsv03124.swis.in-blr01.nxp.com [92.120.146.121])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 60734402A8;
        Mon, 11 Jan 2021 08:39:03 +0100 (CET)
From:   Kuldeep Singh <kuldeep.singh@nxp.com>
To:     Shawn Guo <shawnguo@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Joakim Zhang <qiangqing.zhang@nxp.com>,
        Kuldeep Singh <kuldeep.singh@nxp.com>
Subject: [PATCH 2/3] arm64: dtsi: ls1028a: Update flexcan properties
Date:   Mon, 11 Jan 2021 13:08:48 +0530
Message-Id: <1610350729-21287-3-git-send-email-kuldeep.singh@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1610350729-21287-1-git-send-email-kuldeep.singh@nxp.com>
References: <1610350729-21287-1-git-send-email-kuldeep.singh@nxp.com>
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
 arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index 60ff19f..447d3b6 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -395,19 +395,19 @@
 		};
 
 		can0: can@2180000 {
-			compatible = "fsl,ls1028ar1-flexcan", "fsl,lx2160ar1-flexcan";
+			compatible = "fsl,lx2160ar1-flexcan";
 			reg = <0x0 0x2180000 0x0 0x10000>;
 			interrupts = <GIC_SPI 21 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&sysclk>, <&clockgen 4 1>;
+			clocks = <&clockgen 4 1>, <&clockgen 4 1>;
 			clock-names = "ipg", "per";
 			status = "disabled";
 		};
 
 		can1: can@2190000 {
-			compatible = "fsl,ls1028ar1-flexcan", "fsl,lx2160ar1-flexcan";
+			compatible = "fsl,lx2160ar1-flexcan";
 			reg = <0x0 0x2190000 0x0 0x10000>;
 			interrupts = <GIC_SPI 22 IRQ_TYPE_LEVEL_HIGH>;
-			clocks = <&sysclk>, <&clockgen 4 1>;
+			clocks = <&clockgen 4 1>, <&clockgen 4 1>;
 			clock-names = "ipg", "per";
 			status = "disabled";
 		};
-- 
2.7.4

