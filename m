Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54C421A641C
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Apr 2020 10:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729330AbgDMIQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Apr 2020 04:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.18]:42070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727971AbgDMIQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 04:16:06 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB97C00860B
        for <linux-kernel@vger.kernel.org>; Mon, 13 Apr 2020 01:16:06 -0700 (PDT)
IronPort-SDR: 5x/rSgGPJGvOiv9Fcn7nGN3Y1PazUWR1RISwSnpOO7Xj0c+Kpk1rAmWMnFNAe12U3sjtjexQk3
 RdCQEQ+Jc6Mw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 01:16:06 -0700
IronPort-SDR: LMtMC2kw108QPa4vZkYR1RcM22cb0TDcUaSzwuq3e3b9zFGeYHIfbCaV+ODipKT4ZoPeMi8wlc
 XpDLiqh5W78w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,378,1580803200"; 
   d="scan'208";a="245088427"
Received: from brentlu-desk0.itwn.intel.com ([10.5.253.11])
  by fmsmga008.fm.intel.com with ESMTP; 13 Apr 2020 01:16:04 -0700
From:   Brent Lu <brent.lu@intel.com>
To:     alsa-devel@alsa-project.org
Cc:     Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Jie Yang <yang.jie@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Ben Zhang <benzh@chromium.org>,
        Mac Chiang <mac.chiang@intel.com>,
        Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Brent Lu <brent.lu@intel.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: bdw-rt5650: incorrect rate of PCM data
Date:   Mon, 13 Apr 2020 16:09:18 +0800
Message-Id: <1586765358-18474-1-git-send-email-brent.lu@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement a constrain to exclude 3-channel capture since only 2 and 4
channel capture are supported on the platform.

Signed-off-by: Brent Lu <brent.lu@intel.com>
---
 sound/soc/intel/boards/bdw-rt5650.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/sound/soc/intel/boards/bdw-rt5650.c b/sound/soc/intel/boards/bdw-rt5650.c
index af2f502..eedbdad 100644
--- a/sound/soc/intel/boards/bdw-rt5650.c
+++ b/sound/soc/intel/boards/bdw-rt5650.c
@@ -83,6 +83,36 @@ static struct snd_soc_jack_pin mic_jack_pin = {
 	.mask	= SND_JACK_MICROPHONE,
 };
 
+static const unsigned int channels[] = {
+	2, 4,
+};
+
+static const struct snd_pcm_hw_constraint_list constraints_channels = {
+	.count = ARRAY_SIZE(channels),
+	.list = channels,
+	.mask = 0,
+};
+
+static int bdw_fe_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+
+	/*
+	 * On this platform for PCM device we support,
+	 * 2 or 4 channel capture
+	 */
+	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
+		snd_pcm_hw_constraint_list(runtime, 0,
+					   SNDRV_PCM_HW_PARAM_CHANNELS,
+					   &constraints_channels);
+
+	return 0;
+}
+
+static const struct snd_soc_ops bdw_rt5650_fe_ops = {
+	.startup = bdw_fe_startup,
+};
+
 static int broadwell_ssp0_fixup(struct snd_soc_pcm_runtime *rtd,
 			struct snd_pcm_hw_params *params)
 {
@@ -234,6 +264,7 @@ static struct snd_soc_dai_link bdw_rt5650_dais[] = {
 		.name = "System PCM",
 		.stream_name = "System Playback",
 		.dynamic = 1,
+		.ops = &bdw_rt5650_fe_ops,
 #if !IS_ENABLED(CONFIG_SND_SOC_SOF_BROADWELL)
 		.init = bdw_rt5650_rtd_init,
 #endif
-- 
2.7.4

