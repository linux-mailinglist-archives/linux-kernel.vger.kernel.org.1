Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25EBE2F382C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 19:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406457AbhALSNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 13:13:19 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:37019 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406317AbhALSNQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 13:13:16 -0500
Received: from 1.general.khfeng.us.vpn ([10.172.68.174] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kzO90-0005fK-6P; Tue, 12 Jan 2021 18:11:51 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     tiwai@suse.com, pierre-louis.bossart@linux.intel.com,
        lgirdwood@gmail.com, ranjani.sridharan@linux.intel.com,
        kai.vehmanen@linux.intel.com, daniel.baluta@nxp.com
Cc:     broonie@kernel.org, Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Keyon Jie <yang.jie@linux.intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Marcin Rajwa <marcin.rajwa@linux.intel.com>,
        Payal Kshirsagar <payalskshirsagar1234@gmail.com>,
        sound-open-firmware@alsa-project.org (moderated list:SOUND - SOUND OPEN
        FIRMWARE (SOF) DRIVERS),
        alsa-devel@alsa-project.org (moderated list:SOUND - SOC LAYER / DYNAMIC
        AUDIO POWER MANAGEM...), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v4 3/3] ASoC: SOF: Intel: hda: Avoid checking jack on system suspend
Date:   Wed, 13 Jan 2021 02:11:25 +0800
Message-Id: <20210112181128.1229827-3-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210112181128.1229827-1-kai.heng.feng@canonical.com>
References: <20210112181128.1229827-1-kai.heng.feng@canonical.com>
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
mute/micmute LED will clear codec's direct-complete flag by
dpm_clear_superiors_direct_complete().

This doesn't play well with SOF driver. When its runtime resume is
called for system suspend, hda_codec_jack_check() schedules
jackpoll_work which uses snd_hdac_is_power_on() to check whether codec
is suspended. Because the direct-complete path isn't taken,
pm_runtime_disable() isn't called so snd_hdac_is_power_on() returns
false and jackpoll continues to run, and snd_hda_power_up_pm() cannot
power up an already suspended codec in multiple attempts, causes the
long delay on system suspend:

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

When direct-complete path is taken, snd_hdac_is_power_on() returns true
and hda_jackpoll_work() is skipped by accident. So this is still not
correct.

If we were to use snd_hdac_is_power_on() in system PM path,
pm_runtime_status_suspended() should be used instead of
pm_runtime_suspended(), otherwise pm_runtime_{enable,disable}() may
change the outcome of snd_hdac_is_power_on().

Because devices suspend in reverse order (i.e. child first), it doesn't
make much sense to resume an already suspended codec from audio
controller. So avoid the issue by making sure jackpoll isn't used in
system PM process.

Fixes: 215a22ed31a1 ("ALSA: hda: Refactor codec PM to use direct-complete optimization")
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v4:
 Clarify why direct-complete path isn't take.
v3:
 Clarify the root cause and why it's needed.
v2:
 No change.

 sound/soc/sof/intel/hda-dsp.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/intel/hda-dsp.c b/sound/soc/sof/intel/hda-dsp.c
index 7d00107cf3b2..1c5e05b88a90 100644
--- a/sound/soc/sof/intel/hda-dsp.c
+++ b/sound/soc/sof/intel/hda-dsp.c
@@ -685,7 +685,8 @@ static int hda_resume(struct snd_sof_dev *sdev, bool runtime_resume)
 	/* check jack status */
 	if (runtime_resume) {
 		hda_codec_jack_wake_enable(sdev, false);
-		hda_codec_jack_check(sdev);
+		if (sdev->system_suspend_target == SOF_SUSPEND_NONE)
+			hda_codec_jack_check(sdev);
 	}
 
 	/* turn off the links that were off before suspend */
-- 
2.29.2

