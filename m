Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32BCE2E2BE8
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Dec 2020 17:53:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgLYQsm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Dec 2020 11:48:42 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:59481 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbgLYQsl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Dec 2020 11:48:41 -0500
Received: from 1-171-89-5.dynamic-ip.hinet.net ([1.171.89.5] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1ksqFd-0000Km-W6; Fri, 25 Dec 2020 16:47:39 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     tiwai@suse.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        alsa-devel@alsa-project.org (moderated list:SOUND),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] ALSA: hda: Resume codec for system suspend if LED is controlled by codec
Date:   Sat, 26 Dec 2020 00:47:23 +0800
Message-Id: <20201225164727.103280-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Laptop with codec controlled LEDs takes a very long time to suspend
after commit 215a22ed31a1 ("ALSA: hda: Refactor codec PM to use
direct-complete optimization"):
[   90.065964] PM: suspend entry (s2idle)
[   90.067337] Filesystems sync: 0.001 seconds
[   90.185758] Freezing user space processes ... (elapsed 0.002 seconds) done.
[   90.188713] OOM killer disabled.
[   90.188714] Freezing remaining freezable tasks ... (elapsed 0.001 seconds) done.
[   90.190024] printk: Suspending console(s) (use no_console_suspend to debug)
[   90.904912] intel_pch_thermal 0000:00:12.0: CPU-PCH is cool [49C], continue to suspend
[  321.262505] snd_hda_codec_realtek ehdaudio0D0: Unable to sync register 0x2b8000. -5
[  328.426919] snd_hda_codec_realtek ehdaudio0D0: Unable to sync register 0x2b8000. -5
[  329.490933] ACPI: EC: interrupt blocked

That commit keeps codec suspended during the system suspend. This
doesn't play well with codec controlled mute and micmute LEDs, because
LED core will use codec registers to turn off those LEDs.

Currently, all users of create_mute_led_cdev() use codec to control
LED, so unconditionally runtime resume those codecs before system
suspend to solve the problem.

Fixes: 215a22ed31a1 ("ALSA: hda: Refactor codec PM to use direct-complete optimization")
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 include/sound/hda_codec.h   | 1 +
 sound/pci/hda/hda_codec.c   | 7 +++++++
 sound/pci/hda/hda_generic.c | 1 +
 3 files changed, 9 insertions(+)

diff --git a/include/sound/hda_codec.h b/include/sound/hda_codec.h
index 2e8d51937acd..b01d76abe008 100644
--- a/include/sound/hda_codec.h
+++ b/include/sound/hda_codec.h
@@ -255,6 +255,7 @@ struct hda_codec {
 	unsigned int relaxed_resume:1;	/* don't resume forcibly for jack */
 	unsigned int forced_resume:1; /* forced resume for jack */
 	unsigned int mst_no_extra_pcms:1; /* no backup PCMs for DP-MST */
+	unsigned int resume_for_sleep:1;  /* runtime resume for system sleep */
 
 #ifdef CONFIG_PM
 	unsigned long power_on_acct;
diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 687216e74526..b890d9b4339e 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -2983,6 +2983,13 @@ static int hda_codec_runtime_resume(struct device *dev)
 #ifdef CONFIG_PM_SLEEP
 static int hda_codec_pm_prepare(struct device *dev)
 {
+	struct hda_codec *codec = dev_to_hda_codec(dev);
+
+	if (codec->resume_for_sleep) {
+		pm_runtime_resume(dev);
+		return 0;
+	}
+
 	return pm_runtime_suspended(dev);
 }
 
diff --git a/sound/pci/hda/hda_generic.c b/sound/pci/hda/hda_generic.c
index 8060cc86dfea..6d259d5bb5bb 100644
--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -3913,6 +3913,7 @@ static int create_mute_led_cdev(struct hda_codec *codec,
 	cdev->brightness_set_blocking = callback;
 	cdev->brightness = ledtrig_audio_get(micmute ? LED_AUDIO_MICMUTE : LED_AUDIO_MUTE);
 	cdev->flags = LED_CORE_SUSPENDRESUME;
+	codec->resume_for_sleep = 1;
 
 	return devm_led_classdev_register(&codec->core.dev, cdev);
 }
-- 
2.29.2

