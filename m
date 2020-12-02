Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18FED2CC75D
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 21:04:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389882AbgLBUBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 15:01:38 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([85.215.255.54]:19098 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389621AbgLBUBh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 15:01:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1606939124;
        s=strato-dkim-0002; d=fossekall.de;
        h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=MiOFrh5z1GYfS5zmDo4vnLbWqldZvc9i8hAPAYbemNM=;
        b=SfAQsNsKFcIWY1gTPLupt2pMWQlKHVtHdgBk2k1wDyzqrImdlmkF8fcLsbOSebefle
        s+Mho5v8aQqtymo3TYsytexf8yQ0P8WopNdyEE9yUISwhjIEqQrbfjLLQ2/NcxNJt3u8
        23DH/xwJVil2UI+ZDdlGNtGCQDJYaEXMJ0vvSfhP7zRENxN3A8TLerI4CBbLwbK1FWLv
        gErmGOlxNkN+0qvj50pFcCG+DBHvHh7vF1lnXKk/xYu0rZ6DUW6wEP209jaOWOU6X/J7
        IXhXEBDm1zI0DHO6ogY4HX8dGrgvuup8d0wJIMPCEin5ts0nP1OoegjjeVI7cM+yMWUo
        ISRQ==
X-RZG-AUTH: ":O2kGeEG7b/pS1EzgE2y7nF0STYsSLflpbjNKxx7cGrBOdI6BL9pkS3QW19mO7I+/JwRspuzJFZuRzQ=="
X-RZG-CLASS-ID: mo00
Received: from aerfugl
        by smtp.strato.de (RZmta 47.3.4 AUTH)
        with ESMTPSA id g02087wB2Jwh2CU
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Wed, 2 Dec 2020 20:58:43 +0100 (CET)
Received: from koltrast.a98shuttle.de ([192.168.1.27] helo=a98shuttle.de)
        by aerfugl with smtp (Exim 4.89)
        (envelope-from <michael@a98shuttle.de>)
        id 1kkYGt-0007iD-QL; Wed, 02 Dec 2020 20:58:39 +0100
Received: (nullmailer pid 2105638 invoked by uid 502);
        Wed, 02 Dec 2020 19:58:39 -0000
From:   Michael Klein <michael@fossekall.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Michael Klein <michael@fossekall.de>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: sun6i-a31s-sinovoip-bpi-m2: add gpio-line-names
Date:   Wed,  2 Dec 2020 20:51:47 +0100
Message-Id: <20201202195144.2105036-1-michael@fossekall.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add gpio-line-names as documented on gitbooks [1] and in the
schematics [2].

[1]: https://bananapi.gitbook.io/bpi-m2/en/bpi-m2_gpio_pin_define
[2]: https://drive.google.com/file/d/0B4PAo2nW2KfnRERWNnJGSGxJbmM/view

Signed-off-by: Michael Klein <michael@fossekall.de>
---
 .../boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts   | 71 +++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts b/arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts
index 708caee52425..367006fb280d 100644
--- a/arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts
+++ b/arch/arm/boot/dts/sun6i-a31s-sinovoip-bpi-m2.dts
@@ -261,3 +261,74 @@ &uart0 {
 &usbphy {
 	status = "okay";
 };
+
+&pio {
+	gpio-line-names =
+		/* PA */
+		"ETXD0", "ETXD1", "ETXD2", "ETXD3", "SDC0-DET", "", "",
+		"", "ETXCLK", "ETXEN", "EGTXCLK", "ERXD0", "ERXD1",
+		"ERXD2", "ERXD3", "", "", "", "", "ERXDV", "ERXCK",
+		"ETXERR", "ERXERR", "ECOL", "ECRS", "ECLKIN", "EMDC",
+		"EMDIO", "", "", "", "",
+
+		/* PB */
+		"CN7-P29", "CN7-P31", "CN7-P33", "CN7-P35", "CN7-P37",
+		"CN7-P28", "CN7-P27", "CN7-P32", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "", "", "", "", "", "", "",
+		"", "", "", "",
+
+		/* PC */
+		"", "", "", "", "", "", "WL-SDIO-CMD", "WL-SDIO-CLK",
+		"WL-SDIO-D0", "WL-SDIO-D2", "WL-SDIO-D2", "WL-SDIO-D3",
+		"", "", "", "", "", "", "", "", "", "", "", "", "", "",
+		"", "USB-DRV", "", "", "", "",
+
+		/* PD */
+		"CN9-P09", "CN9-P11", "CN9-P13", "CN9-P15", "CN9-P17",
+		"CN9-P19", "CN9-P21", "CN9-P23", "CN9-P25", "CN9-P27",
+		"CN9-P29", "CN9-P31", "CN9-P33", "CN9-P35", "CN9-P37",
+		"CN9-P39", "CN9-P40", "CN9-P38", "CN9-P36", "CN9-P34",
+		"CN9-P32", "CN9-P30", "CN9-P28", "CN9-P26", "CN9-P22",
+		"CN9-P14", "CN9-P18", "CN9-P16", "", "", "", "",
+
+		/* PE */
+		"CN6-P20", "CN6-P24", "CN6-P30", "CN6-P28", "CN7-P08",
+		"CN7-P10", "CN7-P36", "CN7-P38", "CN6-P17", "CN6-P19",
+		"CN6-P21", "CN6-P23", "CN6-P25", "CN6-P27", "CN6-P29",
+		"CN6-P31", "", "", "", "", "", "", "", "", "", "", "",
+		"", "", "", "", "",
+
+		/* PF */
+		"SDC0-D1", "SDC0-D0", "SDC0-CLK", "SDC0-CMD", "SDC0-D3",
+		"SDC0-D2", "", "", "", "", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "", "", "", "", "", "", "",
+		"",
+
+		/* PG */
+		"CN9-P06", "CN9-P08", "CN9-P20", "CN9-P12", "CN9-P07",
+		"LED-PWR", "CN7-P13", "CN7-P11", "CN7-P22", "CN7-P15",
+		"LED-G", "LED-B", "CN7-P26", "CN7-P24", "CN7-P23",
+		"CN7-P19", "CN7-P21", "HCEC", "CN6-P22", "", "", "", "",
+		"", "", "", "", "", "", "", "", "",
+
+		/* PH */
+		"", "", "", "", "", "", "", "", "", "CN7-P07",
+		"CN7-P12", "CN7-P16", "CN7-P18", "CN9-P10", "CN6-P16",
+		"CN6-P14", "CN9-P04", "CN9-P02", "CN7-P05", "CN7-P03",
+		"CN8-P03", "CN8-P02", "", "", "CN6-P34", "CN6-P32",
+		"CN6-P26", "CN6-P18", "", "", "", "";
+};
+
+&r_pio {
+	gpio-line-names =
+		/* PL */
+		"PMU-SCK", "PMU-SDA", "VBAT-EN", "", "IR-RX",
+		"WL-WAKE-HOST", "BT-WAKE_HOST", "BT-ENABLE",
+		"WL-PMU-EN", "", "", "", "", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "", "", "", "", "",
+
+		/* PM */
+		"CN6-P12", "CN6-P35", "CN7-P40", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "", "", "", "", "", "", "",
+		"", "", "", "", "", "", "", "", "";
+};
-- 
2.29.2

