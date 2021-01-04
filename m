Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D141C2E96DA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 15:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbhADOKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 09:10:05 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:48454 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbhADOKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 09:10:04 -0500
Received: from 36-229-96-78.dynamic-ip.hinet.net ([36.229.96.78] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kwQXq-0006q1-7Q; Mon, 04 Jan 2021 14:09:15 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        daniel.baluta@nxp.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Keyon Jie <yang.jie@linux.intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Marcin Rajwa <marcin.rajwa@linux.intel.com>,
        Payal Kshirsagar <payalskshirsagar1234@gmail.com>,
        sound-open-firmware@alsa-project.org (moderated list:SOUND - SOUND OPEN
        FIRMWARE (SOF) DRIVERS),
        alsa-devel@alsa-project.org (moderated list:SOUND - SOC LAYER / DYNAMIC
        AUDIO POWER MANAGEM...), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 3/3] ASoC: SOF: Intel: hda: Avoid checking jack on system suspend
Date:   Mon,  4 Jan 2021 22:08:52 +0800
Message-Id: <20210104140853.228448-3-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210104140853.228448-1-kai.heng.feng@canonical.com>
References: <20210104140853.228448-1-kai.heng.feng@canonical.com>
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

That commit keeps codec suspended during the system suspend. However,
SOF driver's runtime resume, which is for system suspend, calls
hda_codec_jack_check() and schedules jackpoll_work. The jackpoll
work uses snd_hda_power_up_pm() which tries to resume the codec in
system suspend path, hence blocking the suspend process.

So only check jack status if it's not in system PM process.

Fixes: 215a22ed31a1 ("ALSA: hda: Refactor codec PM to use direct-complete optimization")
Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
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

