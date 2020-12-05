Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C00832CFE56
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 20:25:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726873AbgLETYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 14:24:33 -0500
Received: from mx.baikalelectronics.com ([94.125.187.42]:53456 "EHLO
        mail.baikalelectronics.ru" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725730AbgLETYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 14:24:31 -0500
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Felipe Balbi <balbi@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Serge Semin <fancer.lancer@gmail.com>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3 02/10] arm64: dts: amlogic: meson-g12: Set FL-adj property value
Date:   Sat, 5 Dec 2020 18:56:13 +0300
Message-ID: <20201205155621.3045-3-Sergey.Semin@baikalelectronics.ru>
In-Reply-To: <20201205155621.3045-1-Sergey.Semin@baikalelectronics.ru>
References: <20201205155621.3045-1-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In accordance with the DWC USB3 bindings the property is supposed to have
uint32 type. It's erroneous from the DT schema and driver points of view
to declare it as boolean. As Neil suggested set it to 0x20 so not break
the platform and to make the dtbs checker happy.

Link: https://lore.kernel.org/linux-usb/20201010224121.12672-16-Sergey.Semin@baikalelectronics.ru/
Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
Reviewed-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Reviewed-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
index 8514fe6a275a..a6127002573b 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi
@@ -2384,7 +2384,7 @@ dwc3: usb@ff500000 {
 				interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
 				dr_mode = "host";
 				snps,dis_u2_susphy_quirk;
-				snps,quirk-frame-length-adjustment;
+				snps,quirk-frame-length-adjustment = <0x20>;
 				snps,parkmode-disable-ss-quirk;
 			};
 		};
-- 
2.29.2

