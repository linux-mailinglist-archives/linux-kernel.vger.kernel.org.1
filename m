Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8634F293AD9
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 14:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405564AbgJTMCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 08:02:48 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:52058 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393970AbgJTMAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 08:00:21 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 5995A803071C;
        Tue, 20 Oct 2020 12:00:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 9WNRu8GWigpf; Tue, 20 Oct 2020 15:00:18 +0300 (MSK)
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Felipe Balbi <balbi@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        <bcm-kernel-feedback-list@broadcom.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 07/29] arm: dts: bcm53x: Harmonize EHCI/OHCI DT nodes name
Date:   Tue, 20 Oct 2020 14:59:37 +0300
Message-ID: <20201020115959.2658-8-Sergey.Semin@baikalelectronics.ru>
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
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/arm/boot/dts/bcm5301x.dtsi | 4 ++--
 arch/arm/boot/dts/bcm53573.dtsi | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/bcm5301x.dtsi b/arch/arm/boot/dts/bcm5301x.dtsi
index 0016720ce530..bf5656d79a55 100644
--- a/arch/arm/boot/dts/bcm5301x.dtsi
+++ b/arch/arm/boot/dts/bcm5301x.dtsi
@@ -261,7 +261,7 @@ usb2: usb2@21000 {
 
 			interrupt-parent = <&gic>;
 
-			ehci: ehci@21000 {
+			ehci: usb@21000 {
 				#usb-cells = <0>;
 
 				compatible = "generic-ehci";
@@ -283,7 +283,7 @@ ehci_port2: port@2 {
 				};
 			};
 
-			ohci: ohci@22000 {
+			ohci: usb@22000 {
 				#usb-cells = <0>;
 
 				compatible = "generic-ohci";
diff --git a/arch/arm/boot/dts/bcm53573.dtsi b/arch/arm/boot/dts/bcm53573.dtsi
index 4af8e3293cff..51546fccc616 100644
--- a/arch/arm/boot/dts/bcm53573.dtsi
+++ b/arch/arm/boot/dts/bcm53573.dtsi
@@ -135,7 +135,7 @@ usb2: usb2@4000 {
 			#address-cells = <1>;
 			#size-cells = <1>;
 
-			ehci: ehci@4000 {
+			ehci: usb@4000 {
 				compatible = "generic-ehci";
 				reg = <0x4000 0x1000>;
 				interrupt-parent = <&gic>;
@@ -155,7 +155,7 @@ ehci_port2: port@2 {
 				};
 			};
 
-			ohci: ohci@d000 {
+			ohci: usb@d000 {
 				#usb-cells = <0>;
 
 				compatible = "generic-ohci";
-- 
2.27.0

