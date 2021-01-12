Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA3F62F2827
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 07:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390501AbhALGB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 01:01:29 -0500
Received: from new3-smtp.messagingengine.com ([66.111.4.229]:59305 "EHLO
        new3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727067AbhALGB1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 01:01:27 -0500
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailnew.nyi.internal (Postfix) with ESMTP id 467A958056B;
        Tue, 12 Jan 2021 00:59:56 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 12 Jan 2021 00:59:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=fm1; bh=lbRQgx2bOeb7Q
        llEEICb8/yfF7c2T0KODx5Mf645lDM=; b=JvHU5FNVS3FTD7Quv0hgarnj5bMxZ
        wrUb5ODscB8PvAK5X9YELLzHnWQjmbB35ekDCRaUKSJd4TRmnAL3Z8K+PACS+9Mj
        0NnZ89AHmZc4/U6qSrXi/kCfhzA0SIe4egN2IcE3iqOA1ViNGN9GWqSezVa7X6NZ
        kMDfTxeer3nzg92lsSwiF9NG8JZipLUyAdfN/OApJZ8XJ4SkxJKKJZ4hFzECb9Am
        wp4ru0AHMo57p2qCYcycVmewlzgsygLud0ZgFVI1iatpQvnKDoisbC3PT07C+Pmo
        DC8UpulZvRhc67RNFvF0jp7Q2DOQzvY0OS/n2meER3uV0Nt5eJejzR4+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=lbRQgx2bOeb7QllEEICb8/yfF7c2T0KODx5Mf645lDM=; b=epaQQj4r
        MGmCerG6NyPSJXC5l2NFbXnG+nG/S3ds+OiJNvjgVv5TiWFKPweH8WIynNHNK8RL
        3dNJfTTCCR0Zc5Ud26Z0FEpTzKt3fNmcbNorcmBnAj7xfb9O9yhsQD71jd5/4fPH
        GV79S91kJXrG71g0/5hXZ4B9pmKvYtPoA1nuXbnG2AzYArDr8vW63CJpK1DqKqHV
        /OzrejRbsXS+8Kksv5Y0JqLf51/BSHPdJOg9f+fzKqNAUu6t5vxV2oSHWgloc8KT
        4BlL5mbA5+T9qfFYodIyUAyDKPi+gQCG8afzGjeO9wzVNw/x8517x45a15ZM0eJo
        MZH5/eBiKxs6nQ==
X-ME-Sender: <xms:3Dr9X8VOUFJbxokdpNo72Y9rkNEE9xSFWAJBc8kh_A6Ei4_LZKarog>
    <xme:3Dr9XwmkiO5UuOTkb5hL_jLiUUkWjwtOq3P3EuMPaulSyS6e0aQfW4zCbOo7-CAN_
    5ut9ed_Rz6mXenu0g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdehvddgleduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgv
    lhcujfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtf
    frrghtthgvrhhnpeduhfejfedvhffgfeehtefghfeiiefgfeehgfdvvdevfeegjeehjedv
    gfejheeuieenucfkphepjedtrddufeehrddugeekrdduhedunecuvehluhhsthgvrhfuih
    iivgepfeenucfrrghrrghmpehmrghilhhfrhhomhepshgrmhhuvghlsehshhholhhlrghn
    ugdrohhrgh
X-ME-Proxy: <xmx:3Dr9XwZGOlFRt61xfCOatk2AgPz-FxeCGfL5EA17uD6VSVzeGmf5FA>
    <xmx:3Dr9X7WgJPfyRNe6ipGj21cSbFMLGi53gWr0UKYWUZdEETDCOSz1Qw>
    <xmx:3Dr9X2nPGny6k3lNRtdK5w6hqxr2MrsvDpeXlvEfQcpXghjBQX402A>
    <xmx:3Dr9Xw68vkZoVG1n6Y4SPyMdE2QE35KLVd9YgPOjW0GCbyG_V2C9Gg>
Received: from titanium.stl.sholland.net (70-135-148-151.lightspeed.stlsmo.sbcglobal.net [70.135.148.151])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9ED4324005A;
        Tue, 12 Jan 2021 00:59:55 -0500 (EST)
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
Subject: [PATCH v4 09/10] arm64: dts: allwinner: Use the new r_intc binding
Date:   Mon, 11 Jan 2021 23:59:49 -0600
Message-Id: <20210112055950.21209-10-samuel@sholland.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210112055950.21209-1-samuel@sholland.org>
References: <20210112055950.21209-1-samuel@sholland.org>
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
index 8a62a9fbe347..93b8456f3b49 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-h6.dtsi
@@ -920,10 +920,9 @@ r_watchdog: watchdog@7020400 {
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

