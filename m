Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC4272F999C
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jan 2021 06:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731910AbhARF7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jan 2021 00:59:03 -0500
Received: from wnew4-smtp.messagingengine.com ([64.147.123.18]:54157 "EHLO
        wnew4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731504AbhARFwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jan 2021 00:52:43 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.west.internal (Postfix) with ESMTP id 3A3D51654;
        Mon, 18 Jan 2021 00:50:46 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 18 Jan 2021 00:50:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=oMntSZT4ZK82N
        PlnCg2Nq5HCodnyPKRAQT4SkM8GEtU=; b=GGKyHGuC/teOi5sJexnFNwSm2p/3/
        uAvVu807jktLVG5Uwco7na4yFHn+daL9lSVwvU8V3LMeG2BvZNnjbR7whT5Aifq9
        ZrYBn0/XEOtJyjEuECRyjXf0huynrktDEQVs8DThf7c83z/CPkQRbL9hC5Ibd7PL
        98B1GpvNU9DRXkNl5qSfsuS1I7Y58KhO/rRMyNscHLFBLlxVcz/JamQyHM1wG9S9
        Hzw2kyR8rSwUcmmxIs0dH6yOotxEkNMmk/UcFWzXAwV3A7Z4CHrm9yBklw/Ssfn/
        Dskb2zfMid0KdUmSreWWLwDinzKlSm4jlduWWuI0k1KDIVT0q8DChNZTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=oMntSZT4ZK82NPlnCg2Nq5HCodnyPKRAQT4SkM8GEtU=; b=Oypxt61s
        p34ZwwmosZTCQfNEK/wPkb10eUgni/vn+dyZsuie829hiBpbVk0aLKNh4ONVN5Qd
        OxoW/vrvPKbKrh2ZZ5le7xip7c12yhGxF3HNloaFpXKt2piDxxv2Py/8ONLdz9aR
        rxnRLyFxd8kgual2saimv0+MNCGQYzWHFwPXOuDxdufVWckPkLZ13hQayD5AKg8S
        lqYqnK5OcBm6EnWchrOXc1/9ifDH8vWEqUsJeP7dryBu3v0Ug+pbYp72Xo7+kO5f
        krtiNIfhLAXqOnZzRYVn12G/6zYe+sjCq9SWudoZRjENq1Iscp8V51Q+rGmVkVkV
        K1TNONcyePQ4ow==
X-ME-Sender: <xms:tSEFYIkhjrEpjA2sU8IzlDt6zPcQwVVshfeY6EsGitFx-64II_SAtQ>
    <xme:tSEFYPRUw7UByjBD7Yxo8xbOG7d3uQBpkui0dhXQoSOOUr5TDdEymhskNt7y6rXd3
    QDNDa4n08FWBVDoOg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrtdejgdekjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepudfhjeefvdfhgfefheetgffhieeigfefhefgvddvveefgeejheejvdfg
    jeehueeinecukfhppeejtddrudefhedrudegkedrudehudenucevlhhushhtvghrufhiii
    gvpeegnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgu
    rdhorhhg
X-ME-Proxy: <xmx:tSEFYEBs7P9tU7cJm3wYF5H06f77vGt3XBwg_Zp7shp0RT1lITRUCg>
    <xmx:tSEFYOQatpTXK2F4PJo4xSx6ZcgioZ8SdewsgfWNBINlsY5hUxMg6Q>
    <xmx:tSEFYKrGQ9oqvijNqLg_gSKClWGbU3_OsLeybSdH5SfBRzGVZmKOCw>
    <xmx:tSEFYEbmYSRMXtSu3tGWTXEdiWfNdxiW-wvdZDNdede0G1wFx-DzzVDDBr8>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4E32624005C;
        Mon, 18 Jan 2021 00:50:45 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Ondrej Jirman <megous@megous.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH v5 09/10] arm64: dts: allwinner: Use the new r_intc binding
Date:   Sun, 17 Jan 2021 23:50:39 -0600
Message-Id: <20210118055040.21910-10-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210118055040.21910-1-samuel@sholland.org>
References: <20210118055040.21910-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The binding of R_INTC was updated to allow specifying interrupts other
than the external NMI, since routing those interrupts through the R_INTC
driver allows using them for wakeup.

Update the device trees to use the new binding.

Acked-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts  | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts    | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts     | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts  | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts        | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts      | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi    | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts       | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi       | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts       | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi              | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts    | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts     | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi      | 2 +-
 arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts       | 4 ++--
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi               | 5 ++---
 17 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
index c7bd73f35ed8..f17cc89f472d 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-amarula-relic.dts
@@ -173,7 +173,7 @@ axp803: pmic@3a3 {
 		compatible = "x-powers,axp803";
 		reg = <0x3a3>;
 		interrupt-parent = <&r_intc>;
-		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_LOW>;
 		x-powers,drive-vbus-en; /* set N_VBUSEN as output pin */
 	};
 };
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
index e5e840b9fbb4..e45bef292aa3 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-bananapi-m64.dts
@@ -191,7 +191,7 @@ axp803: pmic@3a3 {
 		compatible = "x-powers,axp803";
 		reg = <0x3a3>;
 		interrupt-parent = <&r_intc>;
-		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_LOW>;
 		x-powers,drive-vbus-en; /* set N_VBUSEN as output pin */
 	};
 };
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
index e58db8a6cab6..57b64c57781b 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-nanopi-a64.dts
@@ -152,7 +152,7 @@ axp803: pmic@3a3 {
 		compatible = "x-powers,axp803";
 		reg = <0x3a3>;
 		interrupt-parent = <&r_intc>;
-		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_LOW>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
index f3f8e177ab61..ec7e2c0e82c1 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-olinuxino.dts
@@ -185,7 +185,7 @@ axp803: pmic@3a3 {
 		compatible = "x-powers,axp803";
 		reg = <0x3a3>;
 		interrupt-parent = <&r_intc>;
-		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_LOW>;
 		x-powers,drive-vbus-en;	/* set N_VBUSEN as output pin */
 	};
 };
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
index 70e31743f0ba..097a5511523a 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-orangepi-win.dts
@@ -192,7 +192,7 @@ axp803: pmic@3a3 {
 		compatible = "x-powers,axp803";
 		reg = <0x3a3>;
 		interrupt-parent = <&r_intc>;
-		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_LOW>;
 		x-powers,drive-vbus-en; /* set N_VBUSEN as output pin */
 	};
 };
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
index 329cf276561e..2accb5ddf783 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
@@ -139,7 +139,7 @@ axp803: pmic@3a3 {
 		compatible = "x-powers,axp803";
 		reg = <0x3a3>;
 		interrupt-parent = <&r_intc>;
-		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_LOW>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
index 7ae16541d14f..34e67f5f8297 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
@@ -245,7 +245,7 @@ axp803: pmic@3a3 {
 		compatible = "x-powers,axp803";
 		reg = <0x3a3>;
 		interrupt-parent = <&r_intc>;
-		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_LOW>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
index 7f37f9fea0ab..7a38adb7aef9 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
@@ -289,7 +289,7 @@ axp803: pmic@3a3 {
 		compatible = "x-powers,axp803";
 		reg = <0x3a3>;
 		interrupt-parent = <&r_intc>;
-		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_LOW>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts
index 422a8507f674..7ef96f9ff7ae 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts
@@ -266,7 +266,7 @@ axp803: pmic@3a3 {
 		compatible = "x-powers,axp803";
 		reg = <0x3a3>;
 		interrupt-parent = <&r_intc>;
-		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_LOW>;
 		x-powers,drive-vbus-en;
 	};
 };
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi
index 3402cec87035..50308077ea8c 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi
@@ -45,7 +45,7 @@ axp803: pmic@3a3 {
 		compatible = "x-powers,axp803";
 		reg = <0x3a3>;
 		interrupt-parent = <&r_intc>;
-		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_LOW>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
index a1864a89fb89..03f733ee44d9 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-teres-i.dts
@@ -205,7 +205,7 @@ axp803: pmic@3a3 {
 		compatible = "x-powers,axp803";
 		reg = <0x3a3>;
 		interrupt-parent = <&r_intc>;
-		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_LOW>;
 		wakeup-source;
 	};
 };
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
index 57786fc120c3..5bf9d61fab12 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -1219,7 +1219,7 @@ r_intc: interrupt-controller@1f00c00 {
 			compatible = "allwinner,sun50i-a64-r-intc",
 				     "allwinner,sun6i-a31-r-intc";
 			interrupt-controller;
-			#interrupt-cells = <2>;
+			#interrupt-cells = <3>;
 			reg = <0x01f00c00 0x400>;
 			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
 		};
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
index 7c9dbde645b5..5c39f5f3f22c 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-beelink-gs1.dts
@@ -157,7 +157,7 @@ axp805: pmic@36 {
 		compatible = "x-powers,axp805", "x-powers,axp806";
 		reg = <0x36>;
 		interrupt-parent = <&r_intc>;
-		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-controller;
 		#interrupt-cells = <1>;
 		x-powers,self-working-mode;
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
index 15c9dd8c4479..41aaad43b5d5 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi-3.dts
@@ -182,7 +182,7 @@ axp805: pmic@36 {
 		compatible = "x-powers,axp805", "x-powers,axp806";
 		reg = <0x36>;
 		interrupt-parent = <&r_intc>;
-		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-controller;
 		#interrupt-cells = <1>;
 		x-powers,self-working-mode;
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
index ebc120a9232f..1ee19f5fc6ab 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-orangepi.dtsi
@@ -119,7 +119,7 @@ axp805: pmic@36 {
 		compatible = "x-powers,axp805", "x-powers,axp806";
 		reg = <0x36>;
 		interrupt-parent = <&r_intc>;
-		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-controller;
 		#interrupt-cells = <1>;
 		x-powers,self-working-mode;
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
index 15ceba027a73..36aee6a3f6f9 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
@@ -168,7 +168,7 @@ axp805: pmic@36 {
 		compatible = "x-powers,axp805", "x-powers,axp806";
 		reg = <0x36>;
 		interrupt-parent = <&r_intc>;
-		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-controller;
 		#interrupt-cells = <1>;
 		x-powers,self-working-mode;
@@ -281,7 +281,7 @@ pcf8563: rtc@51 {
 		compatible = "nxp,pcf8563";
 		reg = <0x51>;
 		interrupt-parent = <&r_intc>;
-		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_LOW>;
 		#clock-cells = <0>;
 	};
 };
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index 77765d4a05ec..15babb635cf7 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -927,10 +927,9 @@ r_watchdog: watchdog@7020400 {
 		};
 
 		r_intc: interrupt-controller@7021000 {
-			compatible = "allwinner,sun50i-h6-r-intc",
-				     "allwinner,sun6i-a31-r-intc";
+			compatible = "allwinner,sun50i-h6-r-intc";
 			interrupt-controller;
-			#interrupt-cells = <2>;
+			#interrupt-cells = <3>;
 			reg = <0x07021000 0x400>;
 			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
 		};
-- 
2.26.2

