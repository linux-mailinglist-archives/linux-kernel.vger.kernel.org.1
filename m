Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72D33293A6F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 14:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394074AbgJTMAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 08:00:30 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:51966 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393987AbgJTMAX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 08:00:23 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 1DEA5803071B;
        Tue, 20 Oct 2020 12:00:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id GCKvxQpGmnuM; Tue, 20 Oct 2020 15:00:20 +0300 (MSK)
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Felipe Balbi <balbi@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Wei Xu <xuwei5@hisilicon.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 11/29] arm64: dts: hisi: Harmonize EHCI/OHCI DT nodes name
Date:   Tue, 20 Oct 2020 14:59:41 +0300
Message-ID: <20201020115959.2658-12-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20201020115959.2658-1-Sergey.Semin@baikalelectronics.ru>
References: <20201020115959.2658-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In accordance with the Generic EHCI/OHCI bindings the corresponding node
name is suppose to comply with the Generic USB HCD DT schema, which
requires the USB nodes to have the name acceptable by the regexp:
"^usb(@.*)?" . Make sure the "generic-ehci" and "generic-ohci"-compatible
nodes are correctly named.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi | 4 ++--
 arch/arm64/boot/dts/hisilicon/hip06.dtsi       | 4 ++--
 arch/arm64/boot/dts/hisilicon/hip07.dtsi       | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi b/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
index 12bc1d3ed424..a4acecb75c89 100644
--- a/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi3798cv200.dtsi
@@ -585,7 +585,7 @@ pcie: pcie@9860000 {
 			status = "disabled";
 		};
 
-		ohci: ohci@9880000 {
+		ohci: usb@9880000 {
 			compatible = "generic-ohci";
 			reg = <0x9880000 0x10000>;
 			interrupts = <GIC_SPI 67 IRQ_TYPE_LEVEL_HIGH>;
@@ -600,7 +600,7 @@ ohci: ohci@9880000 {
 			status = "disabled";
 		};
 
-		ehci: ehci@9890000 {
+		ehci: usb@9890000 {
 			compatible = "generic-ehci";
 			reg = <0x9890000 0x10000>;
 			interrupts = <GIC_SPI 66 IRQ_TYPE_LEVEL_HIGH>;
diff --git a/arch/arm64/boot/dts/hisilicon/hip06.dtsi b/arch/arm64/boot/dts/hisilicon/hip06.dtsi
index 50ceaa959bdc..1226440d54ad 100644
--- a/arch/arm64/boot/dts/hisilicon/hip06.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hip06.dtsi
@@ -373,7 +373,7 @@ refclk: refclk {
 			#clock-cells = <0>;
 		};
 
-		usb_ohci: ohci@a7030000 {
+		usb_ohci: usb@a7030000 {
 			compatible = "generic-ohci";
 			reg = <0x0 0xa7030000 0x0 0x10000>;
 			interrupt-parent = <&mbigen_usb>;
@@ -382,7 +382,7 @@ usb_ohci: ohci@a7030000 {
 			status = "disabled";
 		};
 
-		usb_ehci: ehci@a7020000 {
+		usb_ehci: usb@a7020000 {
 			compatible = "generic-ehci";
 			reg = <0x0 0xa7020000 0x0 0x10000>;
 			interrupt-parent = <&mbigen_usb>;
diff --git a/arch/arm64/boot/dts/hisilicon/hip07.dtsi b/arch/arm64/boot/dts/hisilicon/hip07.dtsi
index 4773a533fce5..93f99a5255ac 100644
--- a/arch/arm64/boot/dts/hisilicon/hip07.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hip07.dtsi
@@ -1253,7 +1253,7 @@ uart0: uart@602b0000 {
 			status = "disabled";
 		};
 
-		usb_ohci: ohci@a7030000 {
+		usb_ohci: usb@a7030000 {
 			compatible = "generic-ohci";
 			reg = <0x0 0xa7030000 0x0 0x10000>;
 			interrupt-parent = <&mbigen_usb>;
@@ -1262,7 +1262,7 @@ usb_ohci: ohci@a7030000 {
 			status = "disabled";
 		};
 
-		usb_ehci: ehci@a7020000 {
+		usb_ehci: usb@a7020000 {
 			compatible = "generic-ehci";
 			reg = <0x0 0xa7020000 0x0 0x10000>;
 			interrupt-parent = <&mbigen_usb>;
-- 
2.27.0

