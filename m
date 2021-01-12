Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8E42F30A1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 14:15:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730523AbhALNI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 08:08:28 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:53998 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730350AbhALNIV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 08:08:21 -0500
Received: from 36-229-236-11.dynamic-ip.hinet.net ([36.229.236.11] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kzJOS-0008Sh-UQ; Tue, 12 Jan 2021 13:07:29 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     tiwai@suse.com, pierre-louis.bossart@linux.intel.com,
        lgirdwood@gmail.com, ranjani.sridharan@linux.intel.com,
        kai.vehmanen@linux.intel.com, daniel.baluta@nxp.com
Cc:     broonie@kernel.org, Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Keyon Jie <yang.jie@linux.intel.com>,
        Marcin Rajwa <marcin.rajwa@linux.intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Payal Kshirsagar <payalskshirsagar1234@gmail.com>,
        sound-open-firmware@alsa-project.org (moderated list:SOUND - SOUND OPEN
        FIRMWARE (SOF) DRIVERS),
        alsa-devel@alsa-project.org (moderated list:SOUND - SOC LAYER / DYNAMIC
        AUDIO POWER MANAGEM...), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v3 4/4] ASoC: SOF: Intel: hda: Avoid checking jack on system suspend
Date:   Tue, 12 Jan 2021 21:07:02 +0800
Message-Id: <20210112130704.1201406-4-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210112130704.1201406-1-kai.heng.feng@canonical.com>
References: <20210112130704.1201406-1-kai.heng.feng@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When runtime resume is for system suspend, hda_codec_jack_check()
schedules jackpoll_work which uses snd_hdac_is_power_on() to check
whether codec is suspended.

If we were to use snd_hdac_is_power_on() in system PM path,
pm_runtime_status_suspended() should be used instead of
pm_runtime_suspended(), otherwise pm_runtime_{enable,disable}() changes
the result of snd_hdac_is_power_on().

Because devices suspend in reverse order (i.e. child first), it doesn't
make much sense to resume already suspended codec from audio controller.

So instead of using pm_runtime_status_suspended(), the better approach
here is to make sure jackpoll isn't used in system PM process.

Fixes: 215a22ed31a1 ("ALSA: hda: Refactor codec PM to use direct-complete optimization")
---
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

