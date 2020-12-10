Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0103D2D56C2
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 10:22:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388336AbgLJJSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 04:18:50 -0500
Received: from mx.baikalelectronics.com ([94.125.187.42]:36752 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728631AbgLJJSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 04:18:49 -0500
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Felipe Balbi <balbi@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Santosh Shilimkar <ssantosh@kernel.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: [PATCH v4 01/10] arm: dts: keystone: Correct DWC USB3 compatible string
Date:   Thu, 10 Dec 2020 12:17:46 +0300
Message-ID: <20201210091756.18057-2-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20201210091756.18057-1-Sergey.Semin@baikalelectronics.ru>
References: <20201210091756.18057-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Syonpsys IP cores are supposed to be defined with "snps" vendor-prefix.
Use it instead of the deprecated "synopsys" one.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm/boot/dts/keystone-k2e.dtsi | 2 +-
 arch/arm/boot/dts/keystone.dtsi     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/keystone-k2e.dtsi b/arch/arm/boot/dts/keystone-k2e.dtsi
index 2d94faf31fab..fa1b8499c5a7 100644
--- a/arch/arm/boot/dts/keystone-k2e.dtsi
+++ b/arch/arm/boot/dts/keystone-k2e.dtsi
@@ -79,7 +79,7 @@ keystone_usb1: usb@25000000 {
 			status = "disabled";
 
 			usb1: dwc3@25010000 {
-				compatible = "synopsys,dwc3";
+				compatible = "snps,dwc3";
 				reg = <0x25010000 0x70000>;
 				interrupts = <GIC_SPI 414 IRQ_TYPE_EDGE_RISING>;
 				usb-phy = <&usb1_phy>, <&usb1_phy>;
diff --git a/arch/arm/boot/dts/keystone.dtsi b/arch/arm/boot/dts/keystone.dtsi
index c298675a29a5..8d046a1b690c 100644
--- a/arch/arm/boot/dts/keystone.dtsi
+++ b/arch/arm/boot/dts/keystone.dtsi
@@ -218,7 +218,7 @@ keystone_usb0: usb@2680000 {
 			status = "disabled";
 
 			usb0: dwc3@2690000 {
-				compatible = "synopsys,dwc3";
+				compatible = "snps,dwc3";
 				reg = <0x2690000 0x70000>;
 				interrupts = <GIC_SPI 393 IRQ_TYPE_EDGE_RISING>;
 				usb-phy = <&usb_phy>, <&usb_phy>;
-- 
2.29.2

