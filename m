Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A00E293A83
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 14:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394138AbgJTMBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 08:01:07 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:52112 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394084AbgJTMAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 08:00:34 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 16661803017C;
        Tue, 20 Oct 2020 12:00:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id VpRjlTEyKyUy; Tue, 20 Oct 2020 15:00:31 +0300 (MSK)
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Felipe Balbi <balbi@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 27/29] arm64: dts: layerscape: Harmonize DWC USB3 DT nodes name
Date:   Tue, 20 Oct 2020 14:59:57 +0300
Message-ID: <20201020115959.2658-28-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20201020115959.2658-1-Sergey.Semin@baikalelectronics.ru>
References: <20201020115959.2658-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In accordance with the DWC USB3 bindings the corresponding node
name is suppose to comply with the Generic USB HCD DT schema, which
requires the USB nodes to have the name acceptable by the regexp:
"^usb(@.*)?" . Make sure the "snps,dwc3"-compatible nodes are correctly
named.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi | 4 ++--
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi | 6 +++---
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 4 ++--
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 4 ++--
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
index ff19ec415b60..06dac6be67e9 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
@@ -453,7 +453,7 @@ edma0: edma@2c00000 {
 				 <&clockgen 4 3>;
 		};
 
-		usb0: usb3@2f00000 {
+		usb0: usb@2f00000 {
 			compatible = "snps,dwc3";
 			reg = <0x0 0x2f00000 0x0 0x10000>;
 			interrupts = <0 60 0x4>;
@@ -474,7 +474,7 @@ sata: sata@3200000 {
 			status = "disabled";
 		};
 
-		usb1: usb2@8600000 {
+		usb1: usb@8600000 {
 			compatible = "fsl-usb2-dr-v2.5", "fsl-usb2-dr";
 			reg = <0x0 0x8600000 0x0 0x1000>;
 			interrupts = <0 139 0x4>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index 5c2e370f6316..1f45fa32e57b 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -750,7 +750,7 @@ edma0: edma@2c00000 {
 				 <&clockgen 4 0>;
 		};
 
-		usb0: usb3@2f00000 {
+		usb0: usb@2f00000 {
 			compatible = "snps,dwc3";
 			reg = <0x0 0x2f00000 0x0 0x10000>;
 			interrupts = <0 60 0x4>;
@@ -761,7 +761,7 @@ usb0: usb3@2f00000 {
 			status = "disabled";
 		};
 
-		usb1: usb3@3000000 {
+		usb1: usb@3000000 {
 			compatible = "snps,dwc3";
 			reg = <0x0 0x3000000 0x0 0x10000>;
 			interrupts = <0 61 0x4>;
@@ -772,7 +772,7 @@ usb1: usb3@3000000 {
 			status = "disabled";
 		};
 
-		usb2: usb3@3100000 {
+		usb2: usb@3100000 {
 			compatible = "snps,dwc3";
 			reg = <0x0 0x3100000 0x0 0x10000>;
 			interrupts = <0 63 0x4>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index 169f4742ae3b..96723b53a4e9 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -402,7 +402,7 @@ esdhc: esdhc@2140000 {
 			status = "disabled";
 		};
 
-		usb0: usb3@3100000 {
+		usb0: usb@3100000 {
 			compatible = "snps,dwc3";
 			reg = <0x0 0x3100000 0x0 0x10000>;
 			interrupts = <0 80 IRQ_TYPE_LEVEL_HIGH>;
@@ -413,7 +413,7 @@ usb0: usb3@3100000 {
 			status = "disabled";
 		};
 
-		usb1: usb3@3110000 {
+		usb1: usb@3110000 {
 			compatible = "snps,dwc3";
 			reg = <0x0 0x3110000 0x0 0x10000>;
 			interrupts = <0 81 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
index 41102dacc2e1..d356ec2beee3 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -737,7 +737,7 @@ sata1: sata@3210000 {
 			dma-coherent;
 		};
 
-		usb0: usb3@3100000 {
+		usb0: usb@3100000 {
 			status = "disabled";
 			compatible = "snps,dwc3";
 			reg = <0x0 0x3100000 0x0 0x10000>;
@@ -748,7 +748,7 @@ usb0: usb3@3100000 {
 			snps,incr-burst-type-adjustment = <1>, <4>, <8>, <16>;
 		};
 
-		usb1: usb3@3110000 {
+		usb1: usb@3110000 {
 			status = "disabled";
 			compatible = "snps,dwc3";
 			reg = <0x0 0x3110000 0x0 0x10000>;
-- 
2.27.0

