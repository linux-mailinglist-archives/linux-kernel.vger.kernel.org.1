Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6D1A2E8BB9
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jan 2021 11:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbhACKc7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jan 2021 05:32:59 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:50023 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726920AbhACKc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jan 2021 05:32:57 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id DC2F55803C9;
        Sun,  3 Jan 2021 05:31:07 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Sun, 03 Jan 2021 05:31:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=BNxTPzPacOvVR
        Yyb20NJ1AqlSA0VOO/nEtlLH6aS6Vw=; b=WhKHsgtaRarlMXwpoTse0/sMK7bTZ
        uiz1AfUN108XCAL/cgz0+tf3vESntdbjY08yx58zC03cda4EN2sCyL5LQxpCOK9U
        MGbEZfXG/r2aNdBV6DC06PhtEE1OvsgkGEExydnbMYGY0Aym3Ru0aXt6BhOX7xZ4
        FjQdu6CWMvoxLiA2k9iTGEPYpDmEeHmhOUUUwbE1ZNWGKi/+SW+XLj1ka+gJxPgA
        cVLoyLh2VP4KVGudm54bkhV6sP0DI+faWO1jB7B92BWUz5qLY6oLIOrSphOace4/
        d4dtgNdDeX8U6a/5Aou7PL2M/zMWLbGiXs6+p16woetmhxhRsVGgxKHjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=BNxTPzPacOvVRYyb20NJ1AqlSA0VOO/nEtlLH6aS6Vw=; b=WEAC+44D
        OJwmjOb9WyKBSkcucSlVzutTixYtBpYtDZGEhfDUVg5PzavzVTIJqzWrHgyMMWSC
        88RcVWCOqZ5A2p1vQr9s17IdNgEdAvrd4HLzdVVCVSc2x0OF0X0LDSquK83o/gxD
        DOJSegY1uOAWleEYOZ+uGfGks6MzeWqFBBYcz5L33AlqoatbIksg1jyHDket9pvv
        HzuiBp0rXxKpVqeoVvbh5Yu01KK9uJK348eyloqQScmwTkAmM+FLdT33i8q5rQG1
        PtxpajJLKQ6VZkKOwy8DwskFd+foFVWJG+DXvoqUZmK2I6cJux5hNT63c3n4p8Iy
        v2Axu+5BsHZoJw==
X-ME-Sender: <xms:65zxX7Qw7Me_PXLFwNoMd_KdBZKUb3kqAcv3z-Qffxe1whgK25cDdw>
    <xme:65zxX8yQOJkXYNKt73VIbxWV6xyTI6qXYFu70kg7grXtbiD6fOrHz6sO70eejPSCE
    IKwcpj2PgYTSyYGAg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdefuddgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:65zxXw1HnWqWIFtwzHdUqDr8l-C87n9HWjIgFWOkn7jDlp0qSzUOiQ>
    <xmx:65zxX7BarL0c1SBbyRpaioTPg7u79UZ96ghP6YysG30QrCWlS7WaCw>
    <xmx:65zxX0iBYBKiwLUS7Ff35RpGidcB4rY0AtI7WdeVBxvjmU3_jiLnnQ>
    <xmx:65zxX1ZRNDcXSJ0ansVzMiC8NdhHQWOOV_oO73a1E2GmA7yfNDJ-Qg>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 17FFE108005C;
        Sun,  3 Jan 2021 05:31:07 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@siol.net>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Ondrej Jirman <megous@megous.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Samuel Holland <samuel@sholland.org>
Subject: [PATCH v3 09/10] arm64: dts: allwinner: Use the new r_intc binding
Date:   Sun,  3 Jan 2021 04:31:00 -0600
Message-Id: <20210103103101.33603-10-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210103103101.33603-1-samuel@sholland.org>
References: <20210103103101.33603-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The binding of R_INTC was updated to allow specifying interrupts other
than the external NMI, since routing those interrupts through the R_INTC
driver allows using them for wakeup.

Update the device trees to use the new binding.

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
 arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi               | 2 +-
 17 files changed, 18 insertions(+), 18 deletions(-)

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
index 896f34fd9fc3..d1f85018257c 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinebook.dts
@@ -248,7 +248,7 @@ axp803: pmic@3a3 {
 		compatible = "x-powers,axp803";
 		reg = <0x3a3>;
 		interrupt-parent = <&r_intc>;
-		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_LOW>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
index 2dfe9bae8c67..b7124ec2cea2 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
@@ -288,7 +288,7 @@ axp803: pmic@3a3 {
 		compatible = "x-powers,axp803";
 		reg = <0x3a3>;
 		interrupt-parent = <&r_intc>;
-		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_LOW>;
 	};
 };
 
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinetab.dts
index 0494bfaf2ffa..5514075a2ae1 100644
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
index c48692b06e1f..a820f30c3e8a 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine.dtsi
@@ -46,7 +46,7 @@ axp803: pmic@3a3 {
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
index 51cc30e84e26..fd4bf90163d5 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64.dtsi
@@ -1215,7 +1215,7 @@ r_intc: interrupt-controller@1f00c00 {
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
index 961732c52aa0..0b9117e986b7 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6-pine-h64.dts
@@ -167,7 +167,7 @@ axp805: pmic@36 {
 		compatible = "x-powers,axp805", "x-powers,axp806";
 		reg = <0x36>;
 		interrupt-parent = <&r_intc>;
-		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_LOW>;
 		interrupt-controller;
 		#interrupt-cells = <1>;
 		x-powers,self-working-mode;
@@ -280,7 +280,7 @@ pcf8563: rtc@51 {
 		compatible = "nxp,pcf8563";
 		reg = <0x51>;
 		interrupt-parent = <&r_intc>;
-		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_LOW>;
 		#clock-cells = <0>;
 	};
 };
diff --git a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
index 8a62a9fbe347..d838bcc7aa60 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -923,7 +923,7 @@ r_intc: interrupt-controller@7021000 {
 			compatible = "allwinner,sun50i-h6-r-intc",
 				     "allwinner,sun6i-a31-r-intc";
 			interrupt-controller;
-			#interrupt-cells = <2>;
+			#interrupt-cells = <3>;
 			reg = <0x07021000 0x400>;
 			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
 		};
-- 
2.26.2

