Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B48202B7D31
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 13:02:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727901AbgKRMAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 07:00:54 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:24526 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727131AbgKRMAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 07:00:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1605700854; x=1637236854;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dx/ojTLTiy6xrFRnydB1VmwJRE9jbvjSezj3P48THWU=;
  b=dH44OncqPEhY/3ZO5rmfUiTa75dnalD77RBBzPABgkoIhFYKD3Z8qjJ4
   s4AGDl09yYQOZG5ZcJ3+TjddQJyI6FzHTYTiha2Gs6fRVl/pAkIzLB8WZ
   PJdBJCAltR3UkkvcMuayJCc/lD2YHgZ+RKzyRDAmhGIAMLJRcAQR6Tb5M
   m8Aac2ZTGYV7R7uycUQp7eIASijTyze/iQDm3wDu9Nj20GdmLSJA9oDvL
   v5nI2/AdQs/n/UDrXMD/jE6fwJWsLSVmpFDgbUsgZY16wzxrEClnQNRiO
   M0sI4/npSmBsE9rM7cPro1hrt07BQb0jOei4p4zBm+uy4BBg6ueFUsTBK
   w==;
IronPort-SDR: X/DnW3dABL+6p84M9qHEpOlVytQ7k2OP+tH9tk1qRDnMq8RthnqOYmMPmR1UFydhRXplWBQDzh
 1Jv+3rKOd6ocYFWTZe2lIObcFgSr/Kl901uGpdrGUA+Rtmnf4ZwjMbSxAF+V5ylWED6Iq+s/Wb
 MmRBI4gX1KeaJwnkoMquA/lrzM7Id1sOv48lZ+tOFEui1Qh0RQRV7oo7m8lTbNZ44u8Q3l0Tvv
 UldZZTkjeluyDZgba/Tpqu/9L49VkyOv7nYU/s1Cn3y+ifGEjryMY/wOoUyt2CDQP0Rj0MpHYV
 okQ=
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="104034941"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Nov 2020 05:00:51 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 18 Nov 2020 05:00:50 -0700
Received: from cristi-P53.amer.actel.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 18 Nov 2020 05:00:48 -0700
From:   <cristian.birsan@microchip.com>
To:     <alexandre.belloni@bootlin.com>, <nicolas.ferre@microchip.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Cristian Birsan <cristian.birsan@microchip.com>
Subject: [PATCH 1/3] ARM: dts: sam9x60: add pincontrol for USB Host
Date:   Wed, 18 Nov 2020 14:00:17 +0200
Message-ID: <20201118120019.1257580-2-cristian.birsan@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201118120019.1257580-1-cristian.birsan@microchip.com>
References: <20201118120019.1257580-1-cristian.birsan@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cristian Birsan <cristian.birsan@microchip.com>

The pincontrol node is needed for USB Host since Linux v5.7-rc1. Without
it the driver probes but VBus is not powered because of wrong pincontrol
configuration.

Fixes: 1e5f532c2737 ("ARM: dts: at91: sam9x60: add device tree for soc and board")
Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
---
 arch/arm/boot/dts/at91-sam9x60ek.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sam9x60ek.dts b/arch/arm/boot/dts/at91-sam9x60ek.dts
index eae28b82c7fd..0e3b6147069f 100644
--- a/arch/arm/boot/dts/at91-sam9x60ek.dts
+++ b/arch/arm/boot/dts/at91-sam9x60ek.dts
@@ -569,6 +569,13 @@ pinctrl_usba_vbus: usba_vbus {
 			atmel,pins = <AT91_PIOB 16 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
 		};
 	};
+
+	usb1 {
+		pinctrl_usb_default: usb_default {
+			atmel,pins = <AT91_PIOD 15 AT91_PERIPH_GPIO AT91_PINCTRL_NONE
+				      AT91_PIOD 16 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
+		};
+	};
 }; /* pinctrl */
 
 &pmc {
@@ -684,6 +691,8 @@ &usb1 {
 	atmel,vbus-gpio = <0
 			   &pioD 15 GPIO_ACTIVE_HIGH
 			   &pioD 16 GPIO_ACTIVE_HIGH>;
+	pinctrl-names = "default";
+	pinctrl-0 = <&pinctrl_usb_default>;
 	status = "okay";
 };
 
-- 
2.25.1

