Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 097EF2B39E6
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Nov 2020 23:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728019AbgKOWcT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 17:32:19 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([81.169.146.221]:15548 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728003AbgKOWcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 17:32:19 -0500
X-Greylist: delayed 354 seconds by postgrey-1.27 at vger.kernel.org; Sun, 15 Nov 2020 17:32:18 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1605479533;
        s=strato-dkim-0002; d=fossekall.de;
        h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=UXrol0Nf+O38g5VUogjJgV1Nuqd8cWJwbt/lFiKvDZI=;
        b=OMJng3ditxjlxeFahYTNxlug/kVZxDNdNv7Tv3AG9aRaTSP9Bnsp2ZqNWEIvSobeGm
        5sVmHDlG0150VcVRfTdbIcslMtVk6qR6z5t+m61GWSSSsCL4pJP+AFZ8zaMSwNKQ8Ddh
        m5TSmmyQyJl3zPFlW6DNT7XtF2uWGNZwLddQOrIDaOWcgaFdrUxGSPTTw/FnAByzcBew
        qRxTCxsRZ7OR2Zn58RvbZleClt2p53aSI0AEZ26jDjVzv9yw6jXw89jK2D+TGsnvsGsY
        2UhocJMW4xbQ0JIZogviJOHBh8L6pCG4TsfwxB8WVUZZ9wJwaecr+Q1yT7oeE2FuXchN
        Xiyw==
X-RZG-AUTH: ":O2kGeEG7b/pS1EzgE2y7nF0STYsSLflpbjNKxx7cGrBOdI6BL9pkS3QW19mO7I+/JwRspuzJFZuRzQ=="
X-RZG-CLASS-ID: mo00
Received: from aerfugl
        by smtp.strato.de (RZmta 47.3.4 AUTH)
        with ESMTPSA id g02087wAFMQANyt
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Sun, 15 Nov 2020 23:26:10 +0100 (CET)
Received: from koltrast.a98shuttle.de ([192.168.1.27] helo=a98shuttle.de)
        by aerfugl with smtp (Exim 4.89)
        (envelope-from <michael@a98shuttle.de>)
        id 1keQTH-0003GW-9a; Sun, 15 Nov 2020 23:26:07 +0100
Received: (nullmailer pid 2885986 invoked by uid 502);
        Sun, 15 Nov 2020 22:26:07 -0000
From:   Michael Klein <michael@fossekall.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Michael Klein <michael@fossekall.de>
Subject: [PATCH] ARM: dts: sun8i-h2-plus-bananapi-m2-zero: add gpio-line-names
Date:   Sun, 15 Nov 2020 23:24:25 +0100
Message-Id: <20201115222425.2885427-1-michael@fossekall.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add gpio-line-names as documented in the Banana Pi wiki [1] and in the
schematics [2].

[1]: http://wiki.banana-pi.org/Banana_Pi_BPI-M2_ZERO#GPIO_PIN_define
[2]: https://drive.google.com/file/d/0B4PAo2nW2KfnMW5sVkxWSW9qa28/view

Signed-off-by: Michael Klein <michael@fossekall.de>
---
 .../dts/sun8i-h2-plus-bananapi-m2-zero.dts    | 64 +++++++++++++++++++
 1 file changed, 64 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts b/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
index 4c6704e4c57e..b4ddfaf01b45 100644
--- a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
+++ b/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
@@ -136,6 +136,70 @@ bluetooth {
 
 };
 
+&pio {
+	gpio-line-names =
+		/* PA */
+		"UART2-TX", "UART2-RX", "UART2-RTS", "UART2-CTS",
+			"UART0-TXD", "UART0-RXD", "PWM1", "PA7-EINT7",
+		"PA8-EINT8", "PA9-EINT9", "PA10-EINT10", "TWI0-SCK",
+			"TWI0-SDA", "UART3-TX", "UART3-RX", "UART3-RTS",
+		"UART3-CTS", "PA17-EINT17", "TWI1-SCK", "TWI1-SDA",
+			"PA20-EINT20", "PA21-EINT21", "", "",
+		"", "", "", "", "", "", "", "",
+
+		/* PB */
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "",
+
+		/* PC */
+		"SPI0-MOSI", "SPI0-MISO", "SPI0-CLK", "SPI0-CS", "PC4", "", "",
+			"PC7",
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "",
+
+		/* PD */
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "CSI-PWR-EN", "",
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "",
+
+		/* PE */
+		"CSI0-PCLK", "CSI0-MCLK", "CSI0-HSYNC", "CSI0-VSYNC",
+			"CSI0-D0", "CSI0-D1", "CSI0-D2", "CSI0-D3",
+		"CSI0-D4", "CSI0-D5", "CSI0-D6", "CSI0-D7",
+			"CSI0-SCK", "CSI0-SDA", "CSI0-RST#", "CSI0-PWDN",
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "",
+
+		/* PF */
+		"SDC0-D1", "SDC0-D0", "SDC0-CLK", "SDC0-CMD", "SDC0-D3",
+			"SDC0-D2", "SDC0-DET", "",
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "",
+
+		/* PG */
+		"WL-SDIO-CLK", "WL-SDIO-CMD", "WL-SDIO-D0", "WL-SDIO-D1",
+			"WL-SDIO-D2", "WL-SDIO-D3", "UART1-TX", "UART1-RX",
+		"UART1-RTS", "UART1-CTS", "WL-WAKE-AP", "BT-WAKE-AP",
+			"BT-RST-N", "AP-WAKE-BT", "", "",
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "";
+};
+
+&r_pio {
+	gpio-line-names =
+		/* PL */
+		"", "CPUX-SET", "PL2-S-EINT2", "POWER-KEY", "PL4-S-EINT4",
+			"VCC-IO-EN", "USB0-ID", "WIFI-EN",
+		"PWR-STB", "PWR-DRAM", "PWR-LED", "IR-RX", "", "", "", "",
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "";
+};
+
 &usb_otg {
 	dr_mode = "otg";
 	status = "okay";
-- 
2.28.0

