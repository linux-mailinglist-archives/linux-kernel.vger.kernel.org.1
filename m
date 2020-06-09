Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2141F357A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jun 2020 09:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbgFIHtf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Jun 2020 03:49:35 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:33664 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727774AbgFIHtf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 03:49:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1591688974; x=1623224974;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=riLN+R9+iea9la5DRgv4JxkKdYjJMTBI001pP1e5cEU=;
  b=kx/DUhCbKY2SCD0d3YmSpvkpy0FCRZfXTBkryrpAmCrk7V8Ck8oThVMR
   mex2wCV1/FHushzsR30x6mILra+/bSScE+P5jWb/kgBk94UpTvVtLF61D
   Z1mKoeyne22FPW9spkn00HbXpj/HTvzMFFWOLg1P3QmpmGxSqCcMFQYxY
   1N/yDxyGj8BAJULZrPa/JWajSMpoCGBFRnSvPejd8X1KnDVvy1eW25t4g
   GS/YXmsA+S8RKXq2cMNXYBpQxufJOthu+OVpOoMI40sWF4GBmX8JU1r/5
   j2Dn/EeVH18+R1ZLI6kyg37gPCvEp8piJx++SB4mYK3zseABda2NF2mah
   Q==;
IronPort-SDR: u/jmM1FPykEZ1aKwXTZLWoWTz4ttUjy+gONedKqZpbf7ePKo0mEHe5gM2FCBb0ige6IbnJA9Fo
 wT13tW373AwExbPjqRO/Fui/+wO+xfNT6SiwZo4cL8vnWdAMtJBDbAz21+rNkZHwKusytjfR2w
 Qr7T2fznQ8z6/gViSMb6jyyZFb1A3Ii0FfdkW7NF6DlLs3Br60EZa/tUO5gihGfDe4AnUGvFni
 ygs9hWkLdGHmQx5ir4bunlz2UeCyUUvk04cveyQmN4jo8Nigupb2XY3k8VlCigBUbLGH2FMeEI
 YW8=
X-IronPort-AV: E=Sophos;i="5.73,490,1583218800"; 
   d="scan'208";a="79410256"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Jun 2020 00:49:31 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Tue, 9 Jun 2020 00:49:30 -0700
Received: from soft-dev15.microsemi.net (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1847.3 via Frontend Transport; Tue, 9 Jun 2020 00:49:28 -0700
From:   Lars Povlsen <lars.povlsen@microchip.com>
To:     Guenter Roeck <linux@roeck-us.net>
CC:     Lars Povlsen <lars.povlsen@microchip.com>,
        Jean Delvare <jdelvare@suse.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: [PATCH v2 2/3] arm64: dts: sparx5: Add hwmon temperature sensor
Date:   Tue, 9 Jun 2020 09:49:25 +0200
Message-ID: <20200609074925.9481-1-lars.povlsen@microchip.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200609072828.9088-1-lars.povlsen@microchip.com>
References: <20200609072828.9088-1-lars.povlsen@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a hwmon temperature node sensor to the Sparx5 SoC.

Reviewed-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Lars Povlsen <lars.povlsen@microchip.com>
---
 arch/arm64/boot/dts/microchip/sparx5.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/microchip/sparx5.dtsi b/arch/arm64/boot/dts/microchip/sparx5.dtsi
index c9dbd1a8b22b6..49d4f289b9026 100644
--- a/arch/arm64/boot/dts/microchip/sparx5.dtsi
+++ b/arch/arm64/boot/dts/microchip/sparx5.dtsi
@@ -244,5 +244,11 @@ i2c1: i2c@600103000 {
 			clock-frequency = <100000>;
 			clocks = <&ahb_clk>;
 		};
+
+		tmon0: tmon@610508110 {
+			compatible = "microchip,sparx5-temp";
+			reg = <0x6 0x10508110 0xc>;
+			#thermal-sensor-cells = <0>;
+		};
 	};
 };
--
2.27.0
