Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A12312C04F8
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 12:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729248AbgKWLv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 06:51:58 -0500
Received: from mo4-p00-ob.smtp.rzone.de ([85.215.255.25]:20587 "EHLO
        mo4-p00-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729238AbgKWLv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 06:51:58 -0500
X-Greylist: delayed 358 seconds by postgrey-1.27 at vger.kernel.org; Mon, 23 Nov 2020 06:51:57 EST
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1606132316;
        s=strato-dkim-0002; d=fossekall.de;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        X-RZG-CLASS-ID:X-RZG-AUTH:From:Subject:Sender;
        bh=0ViczQDt2DtBTnmEzAehJOI81vq5YA+iX7QI/80gcQI=;
        b=fGAw5W1GMLMHN1MnWIPqg4fpenQ+AEmaTX1S9WObA7741ni9a2x71ppuFzcuR8ee5F
        jNMfPHR4vXYGadeiP4nrfi51uyTsBhZcCP/wGm8LmhH92fzAsIu1f8W6BcrvS8+5mxjN
        1W84E1UsA0eIHpgFOAHf7ZX7g+K2BWxg0MsDukxzLHcLJz4JvpBtwj8cjCJRXiEx0ZHZ
        PYSmjK81lTOHhe08ejfyNZJUCvou6f7V4dOcAAOWxBA4E/t/nXnE4OCRI4mpOHuZ9JFU
        8o01IVa5xkbgyP+9n3bJ9CNdItBFbVLfiQeCuajCBmXIMsA7PrJ3EKVFFq2w89mpaFHR
        hMRQ==
X-RZG-AUTH: ":O2kGeEG7b/pS1EzgE2y7nF0STYsSLflpbjNKxx7cGrBOdI6BL9pkS3QW19mO7I+/JwRspuzJFZuRzQ=="
X-RZG-CLASS-ID: mo00
Received: from aerfugl
        by smtp.strato.de (RZmta 47.3.4 AUTH)
        with ESMTPSA id g02087wANBjs58i
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Mon, 23 Nov 2020 12:45:54 +0100 (CET)
Received: from koltrast.a98shuttle.de ([192.168.1.27] helo=a98shuttle.de)
        by aerfugl with smtp (Exim 4.89)
        (envelope-from <michael@a98shuttle.de>)
        id 1khAI2-0002qP-9T; Mon, 23 Nov 2020 12:45:50 +0100
Received: (nullmailer pid 1605989 invoked by uid 502);
        Mon, 23 Nov 2020 11:45:50 -0000
From:   Michael Klein <michael@fossekall.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Michael Klein <michael@fossekall.de>
Subject: [PATCH v2] ARM: dts: sun8i-h2-plus-bananapi-m2-zero: add gpio-line-names
Date:   Mon, 23 Nov 2020 12:45:35 +0100
Message-Id: <20201123114535.1605939-1-michael@fossekall.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201123094300.GA3699@a98shuttle.de>
References: <20201123094300.GA3699@a98shuttle.de>
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
index 4c6704e4c57e..e76d56a3df9c 100644
--- a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
+++ b/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
@@ -136,6 +136,70 @@ bluetooth {
 
 };
 
+&pio {
+	gpio-line-names =
+		/* PA */
+		"CON2-P13", "CON2-P11", "CON2-P22", "CON2-P15",
+			"CON3-P03", "CON3-P02", "CON2-P07", "CON2-P29",
+		"CON2-P31", "CON2-P33", "CON2-P35", "CON2-P05",
+			"CON2-P03", "CON2-P08", "CON2-P10", "CON2-P16",
+		"CON2-P12", "CON2-P37", "CON2-P28", "CON2-P27",
+			"CON2-P40", "CON2-P38", "", "",
+		"", "", "", "", "", "", "", "",
+
+		/* PB */
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "",
+
+		/* PC */
+		"CON2-P19", "CON2-P21", "CON2-P23", "CON2-P24",
+			"CON2-P18", "", "", "CON2-P26",
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
+		"CN3-P17", "CN3-P13", "CN3-P09", "CN3-P07",
+			"CN3-P19", "CN3-P21", "CN3-P22", "CN3-P20",
+		"CN3-P18", "CN3-P16", "CN3-P14", "CN3-P12",
+			"CN3-P05", "CN3-P03", "CN3-P06", "CN3-P08",
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
+			"WL-SDIO-D2", "WL-SDIO-D3", "BT-UART-TX", "BT-UART-RX",
+		"BT-UART-RTS", "BT-UART-CTS", "WL-WAKE-AP", "BT-WAKE-AP",
+			"BT-RST-N", "AP-WAKE-BT", "", "",
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "";
+};
+
+&r_pio {
+	gpio-line-names =
+		/* PL */
+		"", "CPUX-SET", "CON2-P32", "POWER-KEY", "CON2-P36",
+			"VCC-IO-EN", "USB0-ID", "WL-PWR-EN",
+		"PWR-STB", "PWR-DRAM", "PWR-LED", "IR-RX", "", "", "", "",
+		"", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "";
+};
+
 &usb_otg {
 	dr_mode = "otg";
 	status = "okay";
-- 
2.29.2

