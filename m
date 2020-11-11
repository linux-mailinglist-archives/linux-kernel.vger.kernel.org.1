Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42A362AED16
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 10:16:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbgKKJQD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 04:16:03 -0500
Received: from mail.baikalelectronics.com ([87.245.175.226]:39510 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725830AbgKKJQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 04:16:03 -0500
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 57ACA803017E;
        Wed, 11 Nov 2020 09:16:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 5qq1Tpty6Z8M; Wed, 11 Nov 2020 12:16:00 +0300 (MSK)
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Felipe Balbi <balbi@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Santosh Shilimkar <ssantosh@kernel.org>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 01/18] arm: dts: keystone: Correct DWC USB3 compatible string
Date:   Wed, 11 Nov 2020 12:15:35 +0300
Message-ID: <20201111091552.15593-2-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20201111091552.15593-1-Sergey.Semin@baikalelectronics.ru>
References: <20201111091552.15593-1-Sergey.Semin@baikalelectronics.ru>
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
2.28.0

