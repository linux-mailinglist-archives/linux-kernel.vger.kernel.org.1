Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 252F72C8D1A
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 19:45:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388070AbgK3Smk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 13:42:40 -0500
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.167]:29266 "EHLO
        mo4-p01-ob.smtp.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727626AbgK3Smj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 13:42:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1606761585;
        s=strato-dkim-0002; d=fossekall.de;
        h=Message-Id:Date:Subject:Cc:To:From:X-RZG-CLASS-ID:X-RZG-AUTH:From:
        Subject:Sender;
        bh=m33IIaYJF3O/xPuoQve3F1xb1VC6UKc+YqedJ1FE7UI=;
        b=eEmP7bHPhRN2hSAsi10WnfJmXOeaUa02ni2ysCb5kT/51uw2ShlR5h6EFl6jJhScdx
        VWGoGcQG2lLy/EJVtTtUkeOBNevJUEa+rme84QciLILtFIxPCM66+sHl1HOKIavFyDrv
        5UckFRGERvSQXCoGHMNcDkB4CazD4Btj0BPF2rZQ371X2xvMnV74gVxwL4CtaPoBBh8A
        jUexf0CoW4b5ZdENEIJlVnzw7d5u9l/nyDqhFRfDKtOB/ZCB5K/S6k+QyaHx6o4uqAoe
        SAEqbyoNsLwIu5r2uZ5vBVvBdKJvlD8dJ5TM+T8vzQDZ6pPrtIEhvxI/yTYw8qyiR6ha
        X+oQ==
X-RZG-AUTH: ":O2kGeEG7b/pS1EzgE2y7nF0STYsSLflpbjNKxx7cGrBOdI6BL9pkS3QW19mO7I+/JwRspuzJFZuRzQ=="
X-RZG-CLASS-ID: mo00
Received: from aerfugl
        by smtp.strato.de (RZmta 47.3.4 AUTH)
        with ESMTPSA id g02087wAUIdhofS
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve X9_62_prime256v1 with 256 ECDH bits, eq. 3072 bits RSA))
        (Client did not present a certificate);
        Mon, 30 Nov 2020 19:39:43 +0100 (CET)
Received: from koltrast.a98shuttle.de ([192.168.1.27] helo=a98shuttle.de)
        by aerfugl with smtp (Exim 4.89)
        (envelope-from <michael@a98shuttle.de>)
        id 1kjo5M-0005JM-Sg; Mon, 30 Nov 2020 19:39:40 +0100
Received: (nullmailer pid 136773 invoked by uid 502);
        Mon, 30 Nov 2020 18:39:40 -0000
From:   Michael Klein <michael@fossekall.de>
To:     Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Michael Klein <michael@fossekall.de>
Subject: [PATCH] ARM: dts: sun8i-h2-plus-bananapi-m2-zero: add regulator nodes vcc-dram and vcc1v2
Date:   Mon, 30 Nov 2020 19:38:43 +0100
Message-Id: <20201130183841.136708-1-michael@fossekall.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add regulator nodes vcc-dram and vcc1v2 to the devicetree. These
regulators correspond to U4 and U5 in the schematics:

http://forum.banana-pi.org/t/bpi-m2-zero-schematic-diagram-public/4111

Signed-off-by: Michael Klein <michael@fossekall.de>
---
 .../dts/sun8i-h2-plus-bananapi-m2-zero.dts    | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts b/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
index 4c6704e4c57e..74d5732c412b 100644
--- a/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
+++ b/arch/arm/boot/dts/sun8i-h2-plus-bananapi-m2-zero.dts
@@ -62,6 +62,30 @@ reg_vdd_cpux: vdd-cpux-regulator {
 		states = <1100000 0>, <1300000 1>;
 	};
 
+	reg_vcc_dram: vcc-dram {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc-dram";
+		regulator-min-microvolt = <1500000>;
+		regulator-max-microvolt = <1500000>;
+		regulator-always-on;
+		regulator-boot-on;
+		enable-active-high;
+		gpio = <&r_pio 0 9 GPIO_ACTIVE_HIGH>; /* PL9 */
+		vin-supply = <&reg_vcc5v0>;
+	};
+
+	reg_vcc1v2: vcc1v2 {
+		compatible = "regulator-fixed";
+		regulator-name = "vcc1v2";
+		regulator-min-microvolt = <1200000>;
+		regulator-max-microvolt = <1200000>;
+		regulator-always-on;
+		regulator-boot-on;
+		enable-active-high;
+		gpio = <&r_pio 0 8 GPIO_ACTIVE_HIGH>; /* PL8 */
+		vin-supply = <&reg_vcc5v0>;
+	};
+
 	wifi_pwrseq: wifi_pwrseq {
 		compatible = "mmc-pwrseq-simple";
 		reset-gpios = <&r_pio 0 7 GPIO_ACTIVE_LOW>; /* PL7 */
-- 
2.29.2

