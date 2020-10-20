Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFA80293A8F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 14:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404450AbgJTMBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 08:01:21 -0400
Received: from mail.baikalelectronics.com ([87.245.175.226]:52288 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394060AbgJTMAa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 08:00:30 -0400
Received: from localhost (unknown [127.0.0.1])
        by mail.baikalelectronics.ru (Postfix) with ESMTP id 14A9F803073E;
        Tue, 20 Oct 2020 12:00:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at baikalelectronics.ru
Received: from mail.baikalelectronics.ru ([127.0.0.1])
        by localhost (mail.baikalelectronics.ru [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id NHlMs8l0hDJz; Tue, 20 Oct 2020 15:00:27 +0300 (MSK)
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Felipe Balbi <balbi@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Patrice Chotard <patrice.chotard@st.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-usb@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 23/29] arm: dts: stih407-family: Harmonize DWC USB3 DT nodes name
Date:   Tue, 20 Oct 2020 14:59:53 +0300
Message-ID: <20201020115959.2658-24-Sergey.Semin@baikalelectronics.ru>
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
 arch/arm/boot/dts/stih407-family.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/stih407-family.dtsi b/arch/arm/boot/dts/stih407-family.dtsi
index 23a1746f3baa..2352f76b5a69 100644
--- a/arch/arm/boot/dts/stih407-family.dtsi
+++ b/arch/arm/boot/dts/stih407-family.dtsi
@@ -681,7 +681,7 @@ st_dwc3: dwc3@8f94000 {
 
 			status = "disabled";
 
-			dwc3: dwc3@9900000 {
+			dwc3: usb@9900000 {
 				compatible	= "snps,dwc3";
 				reg		= <0x09900000 0x100000>;
 				interrupts	= <GIC_SPI 155 IRQ_TYPE_LEVEL_HIGH>;
-- 
2.27.0

