Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 351192F309F
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 14:15:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730305AbhALNIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 08:08:11 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:53975 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728258AbhALNII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 08:08:08 -0500
Received: from 36-229-236-11.dynamic-ip.hinet.net ([36.229.236.11] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kzJO9-0008Qs-MG; Tue, 12 Jan 2021 13:07:10 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     tiwai@suse.com, pierre-louis.bossart@linux.intel.com,
        lgirdwood@gmail.com, ranjani.sridharan@linux.intel.com,
        kai.vehmanen@linux.intel.com, daniel.baluta@nxp.com
Cc:     broonie@kernel.org, Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Kailang Yang <kailang@realtek.com>,
        Jian-Hong Pan <jhp@endlessos.org>,
        Hui Wang <hui.wang@canonical.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Thomas Hebb <tommyhebb@gmail.com>,
        alsa-devel@alsa-project.org (moderated list:SOUND),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 1/4] ALSA: hda/realtek: Power up codec when setting LED via COEF and GPIO
Date:   Tue, 12 Jan 2021 21:06:59 +0800
Message-Id: <20210112130704.1201406-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

System takes a very long time to suspend after commit 215a22ed31a1
("ALSA: hda: Refactor codec PM to use direct-complete optimization"):
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

That commit keeps the codec suspended during the system suspend. However,
led_suspend() for mute and micmute led writes codec register, triggers
a pending wake up. The wakeup is then handled in __device_suspend() by
the following:
- pm_runtime_disable() to handle the wakeup event.
- device is no longer is suspended state, direct-complete isn't taken.
- pm_runtime_enable() to balance disable_depth.

if (dev->power.direct_complete) {
	if (pm_runtime_status_suspended(dev)) {
		pm_runtime_disable(dev);
		if (pm_runtime_status_suspended(dev)) {
			pm_dev_dbg(dev, state, "direct-complete ");
			goto Complete;
		}

		pm_runtime_enable(dev);
	}
	dev->power.direct_complete = false;
}

Since direct-complete doens't apply anymore, the codec's system suspend
routine is used.

This doesn't play well with SOF driver. When its runtime resume is
called for system suspend, hda_codec_jack_check() schedules
jackpoll_work which uses snd_hdac_is_power_on() to check whether codec
is suspended. Because of the previous pm_runtime_enable(),
snd_hdac_is_power_on() returns false and jackpoll continues to run, and
snd_hda_power_up_pm() cannot power up an already suspended codec in
multiple attempts, causes the long delay on system suspend.

When direct-complete path is taken, snd_hdac_is_power_on() returns true
and hda_jackpoll_work() is skipped by accident. This is still not
correct, and it will be addressed by later patch.

Explicitly runtime resume codec on setting LED to solve the issue.

Fixes: 215a22ed31a1 ("ALSA: hda: Refactor codec PM to use direct-complete optimization")
---
v3:
 New patch.

 sound/pci/hda/patch_realtek.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 3c1d2a3fb1a4..304a7bc89fcd 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4164,7 +4164,10 @@ static void alc_update_gpio_led(struct hda_codec *codec, unsigned int mask,
 {
 	if (polarity)
 		enabled = !enabled;
+	/* temporarily power up/down for setting GPIO */
+	snd_hda_power_up_pm(codec);
 	alc_update_gpio_data(codec, mask, !enabled); /* muted -> LED on */
+	snd_hda_power_down_pm(codec);
 }
 
 /* turn on/off mute LED via GPIO per vmaster hook */
@@ -4287,8 +4290,10 @@ static void alc_update_coef_led(struct hda_codec *codec,
 	if (polarity)
 		on = !on;
 	/* temporarily power up/down for setting COEF bit */
+	snd_hda_power_up_pm(codec);
 	alc_update_coef_idx(codec, led->idx, led->mask,
 			    on ? led->on : led->off);
+	snd_hda_power_down_pm(codec);
 }
 
 /* update mute-LED according to the speaker mute state via COEF bit */
-- 
2.29.2

