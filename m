Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C37B329A439
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 06:40:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2506010AbgJ0Fkx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 01:40:53 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:46993 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2506003AbgJ0Fkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 01:40:53 -0400
Received: from 61-220-137-37.hinet-ip.hinet.net ([61.220.137.37] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kXHiX-0002dZ-MG; Tue, 27 Oct 2020 05:40:22 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     tiwai@suse.com
Cc:     perex@perex.cz, hui.wang@canonical.com,
        kai.vehmanen@linux.intel.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH v2 3/4] ALSA: hda: Separate runtime and system suspend
Date:   Tue, 27 Oct 2020 13:40:00 +0800
Message-Id: <20201027054001.1800-4-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201027054001.1800-1-kai.heng.feng@canonical.com>
References: <20201027054001.1800-1-kai.heng.feng@canonical.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Both pm_runtime_force_suspend() and pm_runtime_force_resume() have
some implicit checks, so it can make code flow more straightfoward if we
separate runtime and systemd suspend callbacks.

High Definition Audio Specification, 4.5.9.3 Codec Wake From System S3
states that codec can wake the system up from S3 if WAKEEN is toggled.
Since HDA controller has different wakeup settings for runtime and
system susend, we also need to explicitly disable direct-complete which
can be enabled automatically by PCI core. In addition to that, avoid
waking up codec if runtime resume is for system suspend, to not break
direct-complete for codecs.

While at it, also remove AZX_DCAPS_SUSPEND_SPURIOUS_WAKEUP, as the
original bug commit a6630529aecb ("ALSA: hda: Workaround for spurious
wakeups on some Intel platforms") solves doesn't happen with this
patch.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v2:
 - Make sure WAKEEN is disabled for system suspend.
 - Avoid waking up codec if runtime resume is for system suspend

 sound/pci/hda/hda_controller.h |  3 +-
 sound/pci/hda/hda_intel.c      | 61 +++++++++++++++++++---------------
 2 files changed, 37 insertions(+), 27 deletions(-)

diff --git a/sound/pci/hda/hda_controller.h b/sound/pci/hda/hda_controller.h
index be63ead8161f..7176ef8170ba 100644
--- a/sound/pci/hda/hda_controller.h
+++ b/sound/pci/hda/hda_controller.h
@@ -41,7 +41,7 @@
 /* 24 unused */
 #define AZX_DCAPS_COUNT_LPIB_DELAY  (1 << 25)	/* Take LPIB as delay */
 #define AZX_DCAPS_PM_RUNTIME	(1 << 26)	/* runtime PM support */
-#define AZX_DCAPS_SUSPEND_SPURIOUS_WAKEUP (1 << 27) /* Workaround for spurious wakeups after suspend */
+/* 27 unused */
 #define AZX_DCAPS_CORBRP_SELF_CLEAR (1 << 28)	/* CORBRP clears itself after reset */
 #define AZX_DCAPS_NO_MSI64      (1 << 29)	/* Stick to 32-bit MSIs */
 #define AZX_DCAPS_SEPARATE_STREAM_TAG	(1 << 30) /* capture and playback use separate stream tag */
@@ -143,6 +143,7 @@ struct azx {
 	unsigned int align_buffer_size:1;
 	unsigned int region_requested:1;
 	unsigned int disabled:1; /* disabled by vga_switcheroo */
+	unsigned int prepared:1;
 
 	/* GTS present */
 	unsigned int gts_present:1;
diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index b4aa1dcf1aae..4cf90e4602c7 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -297,8 +297,7 @@ enum {
 /* PCH for HSW/BDW; with runtime PM */
 /* no i915 binding for this as HSW/BDW has another controller for HDMI */
 #define AZX_DCAPS_INTEL_PCH \
-	(AZX_DCAPS_INTEL_PCH_BASE | AZX_DCAPS_PM_RUNTIME |\
-	 AZX_DCAPS_SUSPEND_SPURIOUS_WAKEUP)
+	(AZX_DCAPS_INTEL_PCH_BASE | AZX_DCAPS_PM_RUNTIME)
 
 /* HSW HDMI */
 #define AZX_DCAPS_INTEL_HASWELL \
@@ -1002,7 +1001,8 @@ static void __azx_runtime_resume(struct azx *chip, bool from_rt)
 	azx_init_pci(chip);
 	hda_intel_init_chip(chip, true);
 
-	if (from_rt) {
+	/* Avoid codec resume if runtime resume is for system suspend */
+	if (from_rt && !chip->prepared) {
 		list_for_each_codec(codec, &chip->bus) {
 			if (codec->relaxed_resume)
 				continue;
@@ -1018,6 +1018,29 @@ static void __azx_runtime_resume(struct azx *chip, bool from_rt)
 }
 
 #ifdef CONFIG_PM_SLEEP
+static int azx_prepare(struct device *dev)
+{
+	struct snd_card *card = dev_get_drvdata(dev);
+	struct azx *chip;
+
+	chip = card->private_data;
+	chip->prepared = 1;
+
+	/* HDA controller always requires different WAKEEN for runtime suspend
+	 * and system suspend, so don't use direct-complete here.
+	 */
+	return 0;
+}
+
+static void azx_complete(struct device *dev)
+{
+	struct snd_card *card = dev_get_drvdata(dev);
+	struct azx *chip;
+
+	chip = card->private_data;
+	chip->prepared = 0;
+}
+
 static int azx_suspend(struct device *dev)
 {
 	struct snd_card *card = dev_get_drvdata(dev);
@@ -1028,14 +1051,7 @@ static int azx_suspend(struct device *dev)
 
 	chip = card->private_data;
 	snd_power_change_state(card, SNDRV_CTL_POWER_D3hot);
-	/* An ugly workaround: direct call of __azx_runtime_suspend() and
-	 * __azx_runtime_resume() for old Intel platforms that suffer from
-	 * spurious wakeups after S3 suspend
-	 */
-	if (chip->driver_caps & AZX_DCAPS_SUSPEND_SPURIOUS_WAKEUP)
-		__azx_runtime_suspend(chip);
-	else
-		pm_runtime_force_suspend(dev);
+	__azx_runtime_suspend(chip);
 
 	trace_azx_suspend(chip);
 	return 0;
@@ -1050,11 +1066,7 @@ static int azx_resume(struct device *dev)
 		return 0;
 
 	chip = card->private_data;
-
-	if (chip->driver_caps & AZX_DCAPS_SUSPEND_SPURIOUS_WAKEUP)
-		__azx_runtime_resume(chip, false);
-	else
-		pm_runtime_force_resume(dev);
+	__azx_runtime_resume(chip, false);
 	snd_power_change_state(card, SNDRV_CTL_POWER_D0);
 
 	trace_azx_resume(chip);
@@ -1103,10 +1115,8 @@ static int azx_runtime_suspend(struct device *dev)
 	chip = card->private_data;
 
 	/* enable controller wake up event */
-	if (snd_power_get_state(card) == SNDRV_CTL_POWER_D0) {
-		azx_writew(chip, WAKEEN, azx_readw(chip, WAKEEN) |
-			   STATESTS_INT_MASK);
-	}
+	azx_writew(chip, WAKEEN, azx_readw(chip, WAKEEN) |
+		   STATESTS_INT_MASK);
 
 	__azx_runtime_suspend(chip);
 	trace_azx_runtime_suspend(chip);
@@ -1117,18 +1127,15 @@ static int azx_runtime_resume(struct device *dev)
 {
 	struct snd_card *card = dev_get_drvdata(dev);
 	struct azx *chip;
-	bool from_rt = snd_power_get_state(card) == SNDRV_CTL_POWER_D0;
 
 	if (!azx_is_pm_ready(card))
 		return 0;
 	chip = card->private_data;
-	__azx_runtime_resume(chip, from_rt);
+	__azx_runtime_resume(chip, true);
 
 	/* disable controller Wake Up event*/
-	if (from_rt) {
-		azx_writew(chip, WAKEEN, azx_readw(chip, WAKEEN) &
-			   ~STATESTS_INT_MASK);
-	}
+	azx_writew(chip, WAKEEN, azx_readw(chip, WAKEEN) &
+		   ~STATESTS_INT_MASK);
 
 	trace_azx_runtime_resume(chip);
 	return 0;
@@ -1162,6 +1169,8 @@ static int azx_runtime_idle(struct device *dev)
 static const struct dev_pm_ops azx_pm = {
 	SET_SYSTEM_SLEEP_PM_OPS(azx_suspend, azx_resume)
 #ifdef CONFIG_PM_SLEEP
+	.prepare = azx_prepare,
+	.complete = azx_complete,
 	.freeze_noirq = azx_freeze_noirq,
 	.thaw_noirq = azx_thaw_noirq,
 #endif
-- 
2.17.1

