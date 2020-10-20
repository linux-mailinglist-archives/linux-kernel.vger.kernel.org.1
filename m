Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1135293A70
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 14:00:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394095AbgJTMAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 08:00:33 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:51966 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394024AbgJTMA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 08:00:26 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 536D6803016F;
        Tue, 20 Oct 2020 12:00:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WDZAmvbWJfJB; Tue, 20 Oct 2020 15:00:23 +0300 (MSK)
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Felipe Balbi <balbi@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 17/29] arm64: dts: marvell: cp11x: Harmonize xHCI DT nodes name
Date:   Tue, 20 Oct 2020 14:59:47 +0300
Message-ID: <20201020115959.2658-18-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20201020115959.2658-1-Sergey.Semin@baikalelectronics.ru>
References: <20201020115959.2658-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In accordance with the Generic xHCI bindings the corresponding node
name is suppose to comply with the Generic USB HCD DT schema, which
requires the USB nodes to have the name acceptable by the regexp:
"^usb(@.*)?" . Make sure the "generic-xhci"-compatible nodes are
correctly named.

Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
---
 arch/arm64/boot/dts/marvell/armada-cp11x.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
index 9dcf16beabf5..1e37ae181acf 100644
--- a/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-cp11x.dtsi
@@ -275,7 +275,7 @@ CP11X_LABEL(thermal): thermal-sensor@70 {
 			};
 		};
 
-		CP11X_LABEL(usb3_0): usb3@500000 {
+		CP11X_LABEL(usb3_0): usb@500000 {
 			compatible = "marvell,armada-8k-xhci",
 			"generic-xhci";
 			reg = <0x500000 0x4000>;
@@ -287,7 +287,7 @@ CP11X_LABEL(usb3_0): usb3@500000 {
 			status = "disabled";
 		};
 
-		CP11X_LABEL(usb3_1): usb3@510000 {
+		CP11X_LABEL(usb3_1): usb@510000 {
 			compatible = "marvell,armada-8k-xhci",
 			"generic-xhci";
 			reg = <0x510000 0x4000>;
-- 
2.27.0

