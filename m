Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BA6C2AED46
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 10:18:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727143AbgKKJRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 04:17:20 -0500
Received: from mail.baikalelectronics.com ([87.245.175.226]:39644 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726375AbgKKJQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 04:16:07 -0500
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 09B65803071C;
        Wed, 11 Nov 2020 09:16:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 58wC3d-YCk5C; Wed, 11 Nov 2020 12:16:03 +0300 (MSK)
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
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 06/18] arm64: dts: hisi: Harmonize EHCI/OHCI DT nodes name
Date:   Wed, 11 Nov 2020 12:15:40 +0300
Message-ID: <20201111091552.15593-7-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20201111091552.15593-1-Sergey.Semin@baikalelectronics.ru>
References: <20201111091552.15593-1-Sergey.Semin@baikalelectronics.ru>
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
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
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
2.28.0

