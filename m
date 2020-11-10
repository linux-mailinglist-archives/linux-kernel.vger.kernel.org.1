Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 702382ADD5A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 18:49:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730986AbgKJRtK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 12:49:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbgKJRtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 12:49:08 -0500
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD83C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 09:49:07 -0800 (PST)
Received: from ramsan.of.borg ([84.195.186.194])
        by andre.telenet-ops.be with bizsmtp
        id qhp52300z4C55Sk01hp51Z; Tue, 10 Nov 2020 18:49:06 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kcXlR-001FNO-Iw; Tue, 10 Nov 2020 18:49:05 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kcXlQ-00EK6n-TX; Tue, 10 Nov 2020 18:49:04 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH] ASoC: Fix 7/8 spaces indentation in Kconfig
Date:   Tue, 10 Nov 2020 18:49:04 +0100
Message-Id: <20201110174904.3413846-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some entries used 7 or 8 spaces instead if a single TAB.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 sound/soc/codecs/Kconfig       | 18 +++++++++---------
 sound/soc/generic/Kconfig      |  2 +-
 sound/soc/intel/boards/Kconfig |  2 +-
 sound/soc/meson/Kconfig        |  2 +-
 sound/soc/pxa/Kconfig          | 14 +++++++-------
 5 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 34c6dd04b85a3c9e..384c5de0107e4077 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -517,7 +517,7 @@ config SND_SOC_AK5558
 	select REGMAP_I2C
 
 config SND_SOC_ALC5623
-       tristate "Realtek ALC5623 CODEC"
+	tristate "Realtek ALC5623 CODEC"
 	depends on I2C
 
 config SND_SOC_ALC5632
@@ -728,7 +728,7 @@ config SND_SOC_JZ4770_CODEC
 	  will be called snd-soc-jz4770-codec.
 
 config SND_SOC_L3
-       tristate
+	tristate
 
 config SND_SOC_DA7210
 	tristate
@@ -768,10 +768,10 @@ config SND_SOC_HDMI_CODEC
 	select HDMI
 
 config SND_SOC_ES7134
-       tristate "Everest Semi ES7134 CODEC"
+	tristate "Everest Semi ES7134 CODEC"
 
 config SND_SOC_ES7241
-       tristate "Everest Semi ES7241 CODEC"
+	tristate "Everest Semi ES7241 CODEC"
 
 config SND_SOC_ES8316
 	tristate "Everest Semi ES8316 CODEC"
@@ -970,10 +970,10 @@ config SND_SOC_PCM186X_SPI
 	select REGMAP_SPI
 
 config SND_SOC_PCM3008
-       tristate
+	tristate
 
 config SND_SOC_PCM3060
-       tristate
+	tristate
 
 config SND_SOC_PCM3060_I2C
 	tristate "Texas Instruments PCM3060 CODEC - I2C"
@@ -1436,7 +1436,7 @@ config SND_SOC_UDA1334
 	  rate) and mute.
 
 config SND_SOC_UDA134X
-       tristate
+	tristate
 
 config SND_SOC_UDA1380
 	tristate
@@ -1761,8 +1761,8 @@ config SND_SOC_MT6660
 	  Select M to build this as module.
 
 config SND_SOC_NAU8540
-       tristate "Nuvoton Technology Corporation NAU85L40 CODEC"
-       depends on I2C
+	tristate "Nuvoton Technology Corporation NAU85L40 CODEC"
+	depends on I2C
 
 config SND_SOC_NAU8810
 	tristate "Nuvoton Technology Corporation NAU88C10 CODEC"
diff --git a/sound/soc/generic/Kconfig b/sound/soc/generic/Kconfig
index a90c3b28bce5fcac..4cafcf0e2bbfd38d 100644
--- a/sound/soc/generic/Kconfig
+++ b/sound/soc/generic/Kconfig
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 config SND_SIMPLE_CARD_UTILS
-       tristate
+	tristate
 
 config SND_SIMPLE_CARD
 	tristate "ASoC Simple sound card support"
diff --git a/sound/soc/intel/boards/Kconfig b/sound/soc/intel/boards/Kconfig
index c10c37803c670b6b..dddb672a6d553357 100644
--- a/sound/soc/intel/boards/Kconfig
+++ b/sound/soc/intel/boards/Kconfig
@@ -552,7 +552,7 @@ config SND_SOC_INTEL_SOUNDWIRE_SOF_MACH
 	select SND_SOC_RT715_SDCA_SDW
 	select SND_SOC_RT5682_SDW
 	select SND_SOC_DMIC
-        help
+	help
 	  Add support for Intel SoundWire-based platforms connected to
 	  MAX98373, RT700, RT711, RT1308 and RT715
 	  If unsure select "N".
diff --git a/sound/soc/meson/Kconfig b/sound/soc/meson/Kconfig
index 363dc3b1bbe47032..917fce7fa3cb7bde 100644
--- a/sound/soc/meson/Kconfig
+++ b/sound/soc/meson/Kconfig
@@ -98,7 +98,7 @@ config SND_MESON_AXG_PDM
 	  in the Amlogic AXG SoC family
 
 config SND_MESON_CARD_UTILS
-       tristate
+	tristate
 
 config SND_MESON_CODEC_GLUE
 	tristate
diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
index 0ac85eada75cb1b7..9d40e8a206d104aa 100644
--- a/sound/soc/pxa/Kconfig
+++ b/sound/soc/pxa/Kconfig
@@ -221,13 +221,13 @@ config SND_PXA2XX_SOC_MIOA701
 	  MIO A701.
 
 config SND_PXA2XX_SOC_IMOTE2
-       tristate "SoC Audio support for IMote 2"
-       depends on SND_PXA2XX_SOC && MACH_INTELMOTE2 && I2C
-       select SND_PXA2XX_SOC_I2S
-       select SND_SOC_WM8940
-       help
-	 Say Y if you want to add support for SoC audio on the
-	 IMote 2.
+	tristate "SoC Audio support for IMote 2"
+	depends on SND_PXA2XX_SOC && MACH_INTELMOTE2 && I2C
+	select SND_PXA2XX_SOC_I2S
+	select SND_SOC_WM8940
+	help
+	  Say Y if you want to add support for SoC audio on the
+	  IMote 2.
 
 config SND_MMP_SOC_BROWNSTONE
 	tristate "SoC Audio support for Marvell Brownstone"
-- 
2.25.1

