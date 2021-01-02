Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4AF2E8340
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jan 2021 07:41:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbhAAGi0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jan 2021 01:38:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbhAAGiZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jan 2021 01:38:25 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482D9C061573;
        Thu, 31 Dec 2020 22:37:45 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id w5so21467991wrm.11;
        Thu, 31 Dec 2020 22:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=nlfReydtN+5AdDJpsPVzbHeq6QMz16fB+zOwSmkYQx4=;
        b=jo9iC4Rj1imQU0Ul0BOSMru0/mCht5SgYq0x+EFDqgUGx01+ObxQDiie3tEgq957AR
         I3PH8yiQNrLiP8Epiyk2rpVSjJTzQkqpMnLTRNuUJB0b2xWk3xiLYaoQPBgJzsMzkGyE
         MpGrypzFCc/4KJNRBUewbQIQLp9B80WUIjKmSagMx3waNbJQphFvk3PFolNjeW/3b4iw
         yW2SoXAC0ZDPdME8Ye00d4Lw652mwUYVYIxe0FvWGiq27txDW7OifFsjMD6YggXkXhJJ
         DuXM5DFttYyym6xB4xCGDqgeIG3aubZjccsKo87IzkSnhe88TtR2hYTRqBVnYa8VbiwL
         wX2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=nlfReydtN+5AdDJpsPVzbHeq6QMz16fB+zOwSmkYQx4=;
        b=YTJ4mD6pxdjKp9+N+nY7reGlul4t3nduLBr192DRCeOHu0WV8PyCt/wzxqcdas3Tn5
         2aciTs9aW6awJw6BPsshk0vuB0inZYZd+ivmkAYKq+5xDoqsiPef2Mk8cs2nTAVI/ERb
         d75DXzX0wo0ca06txGWuVi03R5M5258UHphijzDxvxmIxNkyQmQX8UdQLBrtSWVqbClu
         LgY+M620Pp+rgUf77LnczbfRfAd3MTDVo2ATK5whX290Yg4pyZU8g+NhKgvS0cKcoHEh
         AaVvNpcdkKpw4Xvye5iaE/CTZIeRDrC9mKJcsNFyhT15cqAqNKw4syVZ331wZoii/pwU
         EEXw==
X-Gm-Message-State: AOAM531mfsy9q9PnuuXFiBY1IQRHqmFfJSwZWkU9qEfX1dXt4jsXWBou
        TuoKKeL8Fi4qp3FdECgxpHo=
X-Google-Smtp-Source: ABdhPJyzClMWFp0FlsRKbgV+9HsEqZe/LZ/xrAS14GSs1EO2+JyoSWVGWgukrpGbGTHn7ixQftwzMg==
X-Received: by 2002:adf:f101:: with SMTP id r1mr67428618wro.112.1609483062662;
        Thu, 31 Dec 2020 22:37:42 -0800 (PST)
Received: from localhost.localdomain ([87.200.95.144])
        by smtp.gmail.com with ESMTPSA id k18sm79407106wrd.45.2020.12.31.22.37.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Dec 2020 22:37:42 -0800 (PST)
From:   Christian Hewitt <christianshewitt@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Kevin Hilman <khilman@baylibre.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Christian Hewitt <christianshewitt@gmail.com>
Subject: [PATCH] arm64: dts: meson: shorten audio card names for alsa compatibility
Date:   Fri,  1 Jan 2021 06:37:37 +0000
Message-Id: <20210101063737.26635-1-christianshewitt@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch shortens all audio card model names by dropping the SoC prefix
(for conformity) and rewording those that are still longer than alsa's 15
character name limit [0] to avoid userspace config issues.

[0] https://github.com/torvalds/linux/blob/master/Documentation/sound/alsa-configuration.rst#common-parameters-for-top-sound-card-modules

Signed-off-by: Christian Hewitt <christianshewitt@gmail.com>
---
I've been experimenting with alsa conf files to ensure alsa handles
multi-channel audio properly (else channels are messed up) and it's
been bugging me why an Odroid N2 showed surroundXX devices (defined in
a common alsa conf) while a VIM3 only showed sysdefault devices. The
eureka moment is discovering alsa enforces a 15-character limit on
model names, so G12B-ODROID-N2 (14) works while longer names like
G12B-KHADAS-VIM3 (16) truncate to e.g. G12B-KHADAS-VIM causing mismatch
with the strings alsa-lib matches conf(s) against.

VIM3:~ # cat /proc/asound/cards
 0 [G12BKHADASVIM3 ]: G12B-KHADAS-VIM - G12B-KHADAS-VIM3
                      G12B-KHADAS-VIM3

I'm using aliases.conf with alsa-lib to map 20+ card names back to
two confs so I _could_ just map the truncated names, but this is not
obvious for users and other maintainers so the better solution is
shortening the names.

 arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts               | 2 +-
 arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts              | 2 +-
 arch/arm64/boot/dts/amlogic/meson-g12b-gtking-pro.dts           | 2 +-
 arch/arm64/boot/dts/amlogic/meson-g12b-gtking.dts               | 2 +-
 arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi           | 2 +-
 arch/arm64/boot/dts/amlogic/meson-g12b-ugoos-am6.dts            | 2 +-
 arch/arm64/boot/dts/amlogic/meson-gx-libretech-pc.dtsi          | 2 +-
 arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi             | 2 +-
 arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts            | 2 +-
 arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts          | 2 +-
 arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts             | 2 +-
 arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-hub.dts            | 2 +-
 arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-play2.dts          | 2 +-
 arch/arm64/boot/dts/amlogic/meson-gxl-s805x-libretech-ac.dts    | 2 +-
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts      | 2 +-
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc-v2.dts | 2 +-
 arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts    | 2 +-
 arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts           | 2 +-
 arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi              | 2 +-
 arch/arm64/boot/dts/amlogic/meson-sm1-odroid-c4.dts             | 2 +-
 arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts                | 2 +-
 21 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
index b00d0468c753..81269ccc2496 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-sei510.dts
@@ -181,7 +181,7 @@
 
 	sound {
 		compatible = "amlogic,axg-sound-card";
-		model = "G12A-SEI510";
+		model = "SEI510";
 		audio-aux-devs = <&tdmout_a>, <&tdmout_b>,
 				 <&tdmin_a>, <&tdmin_b>;
 		audio-routing = "TDMOUT_A IN 0", "FRDDR_A OUT 0",
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
index 463a72d6bb7c..579f3d02d613 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12a-x96-max.dts
@@ -150,7 +150,7 @@
 
 	sound {
 		compatible = "amlogic,axg-sound-card";
-		model = "G12A-X96-MAX";
+		model = "X96-MAX";
 		audio-aux-devs = <&tdmout_b>;
 		audio-routing = "TDMOUT_B IN 0", "FRDDR_A OUT 1",
 				"TDMOUT_B IN 1", "FRDDR_B OUT 1",
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-gtking-pro.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-gtking-pro.dts
index 0e5c500fb78f..0e331aa5a2d7 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-gtking-pro.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-gtking-pro.dts
@@ -44,7 +44,7 @@
 
 	sound {
 		compatible = "amlogic,axg-sound-card";
-		model = "G12B-GTKING-PRO";
+		model = "GTKING-PRO";
 		audio-aux-devs = <&tdmout_b>;
 		audio-routing = "TDMOUT_B IN 0", "FRDDR_A OUT 1",
 				"TDMOUT_B IN 1", "FRDDR_B OUT 1",
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-gtking.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-gtking.dts
index 10b87eb97b14..a7db84a500bb 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-gtking.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-gtking.dts
@@ -28,7 +28,7 @@
 
 	sound {
 		compatible = "amlogic,axg-sound-card";
-		model = "G12B-GTKING";
+		model = "GTKING";
 		audio-aux-devs = <&tdmout_b>;
 		audio-routing = "TDMOUT_B IN 0", "FRDDR_A OUT 1",
 				"TDMOUT_B IN 1", "FRDDR_B OUT 1",
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
index 39a09661c5f6..abc052c72420 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-odroid-n2.dtsi
@@ -211,7 +211,7 @@
 
 	sound {
 		compatible = "amlogic,axg-sound-card";
-		model = "G12B-ODROID-N2";
+		model = "ODROID-N2";
 		audio-widgets = "Line", "Lineout";
 		audio-aux-devs = <&tdmout_b>, <&tdmout_c>, <&tdmin_a>,
 				 <&tdmin_b>, <&tdmin_c>, <&tdmin_lb>,
diff --git a/arch/arm64/boot/dts/amlogic/meson-g12b-ugoos-am6.dts b/arch/arm64/boot/dts/amlogic/meson-g12b-ugoos-am6.dts
index b57bb0befc69..0c7892600d56 100644
--- a/arch/arm64/boot/dts/amlogic/meson-g12b-ugoos-am6.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-g12b-ugoos-am6.dts
@@ -23,7 +23,7 @@
 
 	sound {
 		compatible = "amlogic,axg-sound-card";
-		model = "G12B-UGOOS-AM6";
+		model = "UGOOS-AM6";
 		audio-aux-devs = <&tdmout_b>;
 		audio-routing = "TDMOUT_B IN 0", "FRDDR_A OUT 1",
 				"TDMOUT_B IN 1", "FRDDR_B OUT 1",
diff --git a/arch/arm64/boot/dts/amlogic/meson-gx-libretech-pc.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx-libretech-pc.dtsi
index c2480bab8d33..2d7032f41e4b 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx-libretech-pc.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx-libretech-pc.dtsi
@@ -186,7 +186,7 @@
 
 	sound {
 		compatible = "amlogic,gx-sound-card";
-		model = "GXL-LIBRETECH-S9XX-PC";
+		model = "LIBRETECH-PC";
 		audio-aux-devs = <&dio2133>;
 		audio-widgets = "Speaker", "7J4-14 LEFT",
 				"Speaker", "7J4-11 RIGHT";
diff --git a/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi b/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
index 6b57e15aade3..dafc841f7c16 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-gx-p23x-q20x.dtsi
@@ -121,7 +121,7 @@
 
 	sound {
 		compatible = "amlogic,gx-sound-card";
-		model = "GX-P230-Q200";
+		model = "P230-Q200";
 		audio-aux-devs = <&dio2133>;
 		audio-widgets = "Line", "Lineout";
 		audio-routing = "AU2 INL", "ACODEC LOLP",
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
index 089e0636ba8a..7273eed5292c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-nanopi-k2.dts
@@ -134,7 +134,7 @@
 
 	sound {
 		compatible = "amlogic,gx-sound-card";
-		model = "GXBB-NANOPI-K2";
+		model = "NANOPI-K2";
 		assigned-clocks = <&clkc CLKID_MPLL0>,
 				  <&clkc CLKID_MPLL1>,
 				  <&clkc CLKID_MPLL2>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
index b5b11cb9f393..f887bfb445fd 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-nexbox-a95x.dts
@@ -143,7 +143,7 @@
 
 	sound {
 		compatible = "amlogic,gx-sound-card";
-		model = "GXBB-NEXBOX-A95X";
+		model = "NEXBOX-A95X";
 		assigned-clocks = <&clkc CLKID_MPLL0>,
 				  <&clkc CLKID_MPLL1>,
 				  <&clkc CLKID_MPLL2>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
index c04ef57f7b3b..bfaf7f41a2d6 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-odroidc2.dts
@@ -176,7 +176,7 @@
 
 	sound {
 		compatible = "amlogic,gx-sound-card";
-		model = "GXBB-ODROID-C2";
+		model = "ODROID-C2";
 		assigned-clocks = <&clkc CLKID_MPLL0>,
 				  <&clkc CLKID_MPLL1>,
 				  <&clkc CLKID_MPLL2>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-hub.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-hub.dts
index 0c1570153842..58733017eda8 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-hub.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-hub.dts
@@ -15,7 +15,7 @@
 
 	sound {
 		compatible = "amlogic,gx-sound-card";
-		model = "GXBB-WETEK-HUB";
+		model = "WETEK-HUB";
 		assigned-clocks = <&clkc CLKID_MPLL0>,
 				  <&clkc CLKID_MPLL1>,
 				  <&clkc CLKID_MPLL2>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-play2.dts b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-play2.dts
index f2562c7de67c..6eae692792ec 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-play2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxbb-wetek-play2.dts
@@ -50,7 +50,7 @@
 
 	sound {
 		compatible = "amlogic,gx-sound-card";
-		model = "GXBB-WETEK-PLAY2";
+		model = "WETEK-PLAY2";
 		assigned-clocks = <&clkc CLKID_MPLL0>,
 				  <&clkc CLKID_MPLL1>,
 				  <&clkc CLKID_MPLL2>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s805x-libretech-ac.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s805x-libretech-ac.dts
index 9e43f4dca90d..2d769203f671 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s805x-libretech-ac.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s805x-libretech-ac.dts
@@ -118,7 +118,7 @@
 
 	sound {
 		compatible = "amlogic,gx-sound-card";
-		model = "GXL-LIBRETECH-S805X-AC";
+		model = "LIBRETECH-AC";
 		audio-widgets = "Speaker", "9J5-3 LEFT",
 				"Speaker", "9J5-2 RIGHT";
 		audio-routing = "9J5-3 LEFT", "ACODEC LOLN",
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
index 6fe589cd2ba2..41cc108fae3a 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-khadas-vim.dts
@@ -66,7 +66,7 @@
 
 	sound {
 		compatible = "amlogic,gx-sound-card";
-		model = "GXL-KHADAS-VIM1";
+		model = "KHADAS-VIM";
 		assigned-clocks = <&clkc CLKID_MPLL0>,
 				  <&clkc CLKID_MPLL1>,
 				  <&clkc CLKID_MPLL2>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc-v2.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc-v2.dts
index 9a3c08e6e6cc..93d8f8aff70d 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc-v2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc-v2.dts
@@ -159,7 +159,7 @@
 
 	sound {
 		compatible = "amlogic,gx-sound-card";
-		model = "GXL-LIBRETECH-S905X-CC-V2";
+		model = "LIBRETECH-CC-V2";
 		assigned-clocks = <&clkc CLKID_MPLL0>,
 				  <&clkc CLKID_MPLL1>,
 				  <&clkc CLKID_MPLL2>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
index 5ae7bb6209cb..82bfabfbd39c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxl-s905x-libretech-cc.dts
@@ -135,7 +135,7 @@
 
 	sound {
 		compatible = "amlogic,gx-sound-card";
-		model = "GXL-LIBRETECH-S905X-CC";
+		model = "LIBRETECH-CC";
 		audio-aux-devs = <&dio2133>;
 		audio-widgets = "Line", "Lineout";
 		audio-routing = "AU2 INL", "ACODEC LOLN",
diff --git a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
index bf9877d33427..1e261c2f75d3 100644
--- a/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-gxm-khadas-vim2.dts
@@ -148,7 +148,7 @@
 
 	sound {
 		compatible = "amlogic,gx-sound-card";
-		model = "GXM-KHADAS-VIM2";
+		model = "KHADAS-VIM2";
 		assigned-clocks = <&clkc CLKID_MPLL0>,
 				  <&clkc CLKID_MPLL1>,
 				  <&clkc CLKID_MPLL2>;
diff --git a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
index 8f8656262ae7..56a687994ac8 100644
--- a/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
+++ b/arch/arm64/boot/dts/amlogic/meson-khadas-vim3.dtsi
@@ -170,7 +170,7 @@
 
 	sound {
 		compatible = "amlogic,axg-sound-card";
-		model = "G12B-KHADAS-VIM3";
+		model = "KHADAS-VIM3";
 		audio-aux-devs = <&tdmout_a>;
 		audio-routing = "TDMOUT_A IN 0", "FRDDR_A OUT 0",
 				"TDMOUT_A IN 1", "FRDDR_B OUT 0",
diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-c4.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-c4.dts
index cf5a98f0e47c..0adccb79540c 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-c4.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-odroid-c4.dts
@@ -190,7 +190,7 @@
 
 	sound {
 		compatible = "amlogic,axg-sound-card";
-		model = "SM1-ODROID-C4";
+		model = "ODROID-C4";
 		audio-aux-devs = <&tdmout_b>;
 		audio-routing = "TDMOUT_B IN 0", "FRDDR_A OUT 1",
 				"TDMOUT_B IN 1", "FRDDR_B OUT 1",
diff --git a/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts b/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
index 5ab139a34c01..9d99bba22a93 100644
--- a/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
+++ b/arch/arm64/boot/dts/amlogic/meson-sm1-sei610.dts
@@ -220,7 +220,7 @@
 
 	sound {
 		compatible = "amlogic,axg-sound-card";
-		model = "SM1-SEI610";
+		model = "SEI610";
 		audio-aux-devs = <&tdmout_a>, <&tdmout_b>,
 				 <&tdmin_a>, <&tdmin_b>;
 		audio-routing = "TDMOUT_A IN 0", "FRDDR_A OUT 0",
-- 
2.17.1

