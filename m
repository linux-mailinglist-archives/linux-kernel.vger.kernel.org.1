Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A37B2A772C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Nov 2020 06:42:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731643AbgKEFlz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Nov 2020 00:41:55 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:37013 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731096AbgKEFlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Nov 2020 00:41:39 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id D56FF5C0164;
        Thu,  5 Nov 2020 00:41:38 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 05 Nov 2020 00:41:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=r33Qf5/ecFnA8
        R3uk+Hr4eHdElWkEglB0H9UtHOSJng=; b=Pb0SUyloRdg/+4yBEBaAVpD9dz1Oh
        COMXpTq0z+33dFNi2PQB7oOSWk3e8pP7qS6n5ea5b7p+g8NbugA7VO4nltdXVeNx
        U0lq8417bLegsMeTGw+x+MPXMv6hobVH1/LfXrQOZ6ZONvRsOKYd/SEnVJSHtqKY
        iQ56pLlGITlPy1767c0THHlNQWqs9W80gD7BchnyVHI5cqcdOZyeuxtA47SdIfZX
        dApU2h/vdRXpnLmgDFJZjnyIWqKVQaxpgkQmDfjR6cgv5qbX6hB/+9gGfd8w0ksd
        cA8KByTIk1JpDIlqBe3vj/iu+TWoiR7nRczqc94LZEEyujo536fohDiew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=r33Qf5/ecFnA8R3uk+Hr4eHdElWkEglB0H9UtHOSJng=; b=THfwItVr
        Sv+i8LdjyDAdW3bSbhvDJiS/SZvpw8YunMi3Hhzx66HQu0i7o8iydzp9BdGNyeaS
        Ebg7MSff1l+FD05mqy1nrRLXxOcXHdVf8lfwDhPQVCutaHOSWDkaThx9vyA0jSsP
        MO6TYgF1UwmRG0OXZVfm2pSKMe7IgFUeMmcf/gCLcVhQyZcZhcEdG3y9sBBujZ/8
        /e7lZKwKHq65uzWr6oEpHAw9z/Tb8thfHN5lT8W53YeMJuXajcnUCgHGWc9W6+NU
        TZ3z93PIlbTXITbsvvf/7j1qCmNsbg6GONvI1+oGb4SNte9zytPwLM1ITklGzpE7
        a/+PTpp5gwjb2g==
X-ME-Sender: <xms:kpCjXykZb9_iPAqspgKi467-CbGwyQT78t8E0BSAZyYfiDpAQZIBeQ>
    <xme:kpCjX52oqvrgzCpxqk-UqiRydmCGtfJlacqdgBqQD_lyo-1o1k4uBTXBH5yLEdg0E
    L0_LNcZ8qRCUbXBVQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddtiedgkeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuih
    iivgepudenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:kpCjXwoxQ5xJ3a_YSoK6v-Ib_iUQKffbY1tNL9xNSFpH8ou5uaUuNw>
    <xmx:kpCjX2lJxgzrqnn8OD5DJrTxPZjXN1VdzS8pE4kf2xjlPhA8WEHbyA>
    <xmx:kpCjXw1ccY0eFLbrTI1T385Q0BI0PuioxMKSWbhFfd22vkoolqonHQ>
    <xmx:kpCjXxmUMzS01rVDRizRvaXGKiwGZZ2kWuUw6dOrXgoBVN_1pzU8Og>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1B0C532801D7;
        Thu,  5 Nov 2020 00:41:38 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        linux-arm-kernel@lists.infradead.org
Cc:     Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-sunxi@googlegroups.com,
        Samuel Holland <samuel@sholland.org>,
        Ondrej Jirman <megous@megous.com>
Subject: [PATCH 5/6] arm64: dts: allwinner: pinephone: Add WiFi support
Date:   Wed,  4 Nov 2020 23:41:34 -0600
Message-Id: <20201105054135.24860-6-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201105054135.24860-1-samuel@sholland.org>
References: <20201105054135.24860-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megous@megous.com>

The PinePhone has a Realtek rtl8723cs WiFi module.

On mainboard revisions 1.0 and 1.1, the reset input is always pulled
high, so no power sequence is needed. On mainboard revision 1.2, the
reset input is connected to PL2.

Signed-off-by: Ondrej Jirman <megous@megous.com>
Signed-off-by: Samuel Holland <samuel@sholland.org>
---
 .../allwinner/sun50i-a64-pinephone-1.2.dts    |  9 ++++++++
 .../dts/allwinner/sun50i-a64-pinephone.dtsi   | 22 +++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.2.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.2.dts
index 94e4f11e0215..e7cf9d8577c1 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.2.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone-1.2.dts
@@ -8,6 +8,11 @@
 / {
 	model = "Pine64 PinePhone (1.2)";
 	compatible = "pine64,pinephone-1.2", "allwinner,sun50i-a64";
+
+	wifi_pwrseq: wifi_pwrseq {
+		compatible = "mmc-pwrseq-simple";
+		reset-gpios = <&r_pio 0 2 GPIO_ACTIVE_LOW>; /* PL2 */
+	};
 };
 
 &backlight {
@@ -39,6 +44,10 @@ &lis3mdl {
 	interrupts = <1 1 IRQ_TYPE_EDGE_RISING>; /* PB1 */
 };
 
+&mmc1 {
+	mmc-pwrseq = <&wifi_pwrseq>;
+};
+
 &sgm3140 {
 	enable-gpios = <&pio 3 24 GPIO_ACTIVE_HIGH>; /* PD24 */
 	flash-gpios = <&pio 2 3 GPIO_ACTIVE_HIGH>; /* PC3 */
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
index 9544d7658794..e173096a7e68 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
@@ -13,6 +13,7 @@
 
 / {
 	aliases {
+		ethernet0 = &rtl8723cs;
 		serial0 = &uart0;
 	};
 
@@ -49,6 +50,13 @@ red {
 		};
 	};
 
+	reg_vbat_wifi: vbat-wifi {
+		compatible = "regulator-fixed";
+		regulator-min-microvolt = <3300000>;
+		regulator-max-microvolt = <3300000>;
+		regulator-name = "vbat-wifi";
+	};
+
 	sgm3140: led-controller {
 		compatible = "sgmicro,sgm3140";
 		vin-supply = <&reg_dcdc1>;
@@ -216,6 +224,20 @@ &mmc0 {
 	status = "okay";
 };
 
+&mmc1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&mmc1_pins>;
+	vmmc-supply = <&reg_vbat_wifi>;
+	vqmmc-supply = <&reg_dldo4>;
+	bus-width = <4>;
+	non-removable;
+	status = "okay";
+
+	rtl8723cs: wifi@1 {
+		reg = <1>;
+	};
+};
+
 &mmc2 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc2_pins>;
-- 
2.26.2

