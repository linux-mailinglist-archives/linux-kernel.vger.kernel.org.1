Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 635522E96D9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jan 2021 15:10:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbhADOKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jan 2021 09:10:02 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:48448 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbhADOKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jan 2021 09:10:01 -0500
Received: from 36-229-96-78.dynamic-ip.hinet.net ([36.229.96.78] helo=localhost)
        by youngberry.canonical.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1kwQXd-0006oi-46; Mon, 04 Jan 2021 14:09:02 +0000
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
To:     pierre-louis.bossart@linux.intel.com, lgirdwood@gmail.com,
        ranjani.sridharan@linux.intel.com, kai.vehmanen@linux.intel.com,
        daniel.baluta@nxp.com
Cc:     Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Rander Wang <rander.wang@intel.com>,
        Payal Kshirsagar <payalskshirsagar1234@gmail.com>,
        sound-open-firmware@alsa-project.org (moderated list:SOUND - SOUND OPEN
        FIRMWARE (SOF) DRIVERS),
        alsa-devel@alsa-project.org (moderated list:SOUND - SOC LAYER / DYNAMIC
        AUDIO POWER MANAGEM...), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/3] ASoC: SOF: Intel: hda: Resume codec to do jack detection
Date:   Mon,  4 Jan 2021 22:08:50 +0800
Message-Id: <20210104140853.228448-1-kai.heng.feng@canonical.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of queueing jackpoll_work, runtime resume the codec to let it
use different jack detection methods based on jackpoll_interval.

This matches SOF driver's behavior with commit a6e7d0a4bdb0 ("ALSA: hda:
fix jack detection with Realtek codecs when in D3"). Since SOF only uses
Realtek codec, we don't need any additional check for the resume.

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
v2:
 No change.

 sound/soc/sof/intel/hda-codec.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/sof/intel/hda-codec.c b/sound/soc/sof/intel/hda-codec.c
index 6875fa570c2c..df59c79cfdfc 100644
--- a/sound/soc/sof/intel/hda-codec.c
+++ b/sound/soc/sof/intel/hda-codec.c
@@ -93,8 +93,7 @@ void hda_codec_jack_check(struct snd_sof_dev *sdev)
 		 * has been recorded in STATESTS
 		 */
 		if (codec->jacktbl.used)
-			schedule_delayed_work(&codec->jackpoll_work,
-					      codec->jackpoll_interval);
+			pm_request_resume(&codec->core.dev);
 }
 #else
 void hda_codec_jack_wake_enable(struct snd_sof_dev *sdev) {}
-- 
2.29.2

