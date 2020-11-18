Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11F8E2B7D34
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 13:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727975AbgKRMA7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 07:00:59 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:4568 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727919AbgKRMA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 07:00:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1605700857; x=1637236857;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=iCt4DsDSKqejPIkvYDT2cO5FTh1J6dFJ5teH1s3neoU=;
  b=B2Svji3OsaCQ8ywmUawhM4aTjO/H8lt/BZSqLbvKjFKYcUrmdu3WRzQZ
   j4IIrjqqPhwJg6Hyzk9/PCQgpVmyvLhlzvwqhwps2vUqwIZkdsQfX2qRF
   e2UGaIcY+cjjp96IC9d1t0wEWN61QCJhxBWsKf6xh9cFoXrBk2lLmlBmA
   H3/wSiVHH3E4adygYQkBYIQNsNfIVdUcrxYBfyFbSfFWNxtEpoE8SUlPE
   VznKSewwyhbEms75bJu+/RQqT5PJiFZh8wjr79b42nTKDimU84TG6sMiq
   Te8nFt9ehrob2XsJy4QMEXeAUKBN0Z2UWdACjQMoybaZJd4Ue6QhGtAe7
   w==;
IronPort-SDR: +N+HajUoK2D27L+syJaKzaEDRwqSy2DcPBkAAswyK3zW/IV8tG3AgeHb5bpHcq4miD0pQwrF/z
 60QTmY/+uD8xvm+TWhDczPEofGro2Wg2GghCQ/jbnIsiMRAzG1pyA63FPDkxKBAQXgv2nQrbcc
 CvYdjOGFIcjbTz5XuvkaDeyhFaL3UkU/3NaEGzf4OsRc43+7xsauDkzok0vPA2FDSTvgsyepSR
 eUZipyvf57l2fPuMf8EtoZnoRDRHr+UaP8QzZjUMti3Ly0lvE/nCcy4B7XN9DXGZaeAAYbWLFC
 2dE=
X-IronPort-AV: E=Sophos;i="5.77,486,1596524400"; 
   d="scan'208";a="94089032"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 18 Nov 2020 05:00:56 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 18 Nov 2020 05:00:56 -0700
Received: from cristi-P53.amer.actel.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 18 Nov 2020 05:00:54 -0700
From:   <cristian.birsan@microchip.com>
To:     <alexandre.belloni@bootlin.com>, <nicolas.ferre@microchip.com>,
        <ludovic.desroches@microchip.com>, <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Cristian Birsan <cristian.birsan@microchip.com>
Subject: [PATCH 3/3] ARM: dts: at91: sama5d3_xplained: add pincontrol for USB Host
Date:   Wed, 18 Nov 2020 14:00:19 +0200
Message-ID: <20201118120019.1257580-4-cristian.birsan@microchip.com>
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

Fixes: b7c2b61570798 ("ARM: at91: add Atmel's SAMA5D3 Xplained board")
Signed-off-by: Cristian Birsan <cristian.birsan@microchip.com>
---
 arch/arm/boot/dts/at91-sama5d3_xplained.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/at91-sama5d3_xplained.dts b/arch/arm/boot/dts/at91-sama5d3_xplained.dts
index cf13632edd44..5179258f9247 100644
--- a/arch/arm/boot/dts/at91-sama5d3_xplained.dts
+++ b/arch/arm/boot/dts/at91-sama5d3_xplained.dts
@@ -242,6 +242,11 @@ pinctrl_usba_vbus: usba_vbus {
 						atmel,pins =
 							<AT91_PIOE 9 AT91_PERIPH_GPIO AT91_PINCTRL_DEGLITCH>;	/* PE9, conflicts with A9 */
 					};
+					pinctrl_usb_default: usb_default {
+						atmel,pins =
+							<AT91_PIOE 3 AT91_PERIPH_GPIO AT91_PINCTRL_NONE
+							 AT91_PIOE 4 AT91_PERIPH_GPIO AT91_PINCTRL_NONE>;
+					};
 				};
 			};
 		};
@@ -259,6 +264,8 @@ usb1: ohci@600000 {
 					   &pioE 3 GPIO_ACTIVE_LOW
 					   &pioE 4 GPIO_ACTIVE_LOW
 					  >;
+			pinctrl-names = "default";
+			pinctrl-0 = <&pinctrl_usb_default>;
 			status = "okay";
 		};
 
-- 
2.25.1

