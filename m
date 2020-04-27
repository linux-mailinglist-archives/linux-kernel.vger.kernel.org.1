Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FAD31BAB0A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Apr 2020 19:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgD0RTt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Apr 2020 13:19:49 -0400
Received: from mga04.intel.com ([192.55.52.120]:16042 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726315AbgD0RTs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 13:19:48 -0400
IronPort-SDR: rJQgkN/LdUERr20+0hnTk8iBbVovLBVUypL0ArdAAF5nVgEmnuqoG5h+yz1R6/LrNrxPLZ6f2m
 APs7Akr2QUnA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2020 10:19:48 -0700
IronPort-SDR: DADqqs2VzvU4RMSSL6T60L9KHe4i0BJ0rYCBdBIHkENHyPdaStM4QkMLCKL6kggUXRPd4ZJut5
 q69mUwJ6AJ1w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,324,1583222400"; 
   d="scan'208";a="458932342"
Received: from brentlu-desk0.itwn.intel.com ([10.5.253.11])
  by fmsmga006.fm.intel.com with ESMTP; 27 Apr 2020 10:19:45 -0700
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
Subject: [PATCH v2 2/3] ASoC: bdw-rt5650: add channel constraint
Date:   Tue, 28 Apr 2020 01:13:33 +0800
Message-Id: <1588007614-25061-3-git-send-email-brent.lu@intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1588007614-25061-1-git-send-email-brent.lu@intel.com>
References: <1588007614-25061-1-git-send-email-brent.lu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BDW boards using this machine driver supports only 2 or 4-channel capture.
Implement a constraint to enforce it.

Signed-off-by: Brent Lu <brent.lu@intel.com>
---
 sound/soc/intel/boards/bdw-rt5650.c | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/sound/soc/intel/boards/bdw-rt5650.c b/sound/soc/intel/boards/bdw-rt5650.c
index af2f502..a97e912 100644
--- a/sound/soc/intel/boards/bdw-rt5650.c
+++ b/sound/soc/intel/boards/bdw-rt5650.c
@@ -162,6 +162,34 @@ static int bdw_rt5650_rtd_init(struct snd_soc_pcm_runtime *rtd)
 }
 #endif
 
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
+static int bdw_rt5650_fe_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+
+	/* Board supports stereo and quad configurations for capture */
+	if (substream->stream != SNDRV_PCM_STREAM_CAPTURE)
+		return 0;
+
+	runtime->hw.channels_max = 4;
+	return snd_pcm_hw_constraint_list(runtime, 0,
+					  SNDRV_PCM_HW_PARAM_CHANNELS,
+					  &constraints_channels);
+}
+
+static const struct snd_soc_ops bdw_rt5650_fe_ops = {
+	.startup = bdw_rt5650_fe_startup,
+};
+
 static int bdw_rt5650_init(struct snd_soc_pcm_runtime *rtd)
 {
 	struct bdw_rt5650_priv *bdw_rt5650 =
@@ -234,6 +262,7 @@ static struct snd_soc_dai_link bdw_rt5650_dais[] = {
 		.name = "System PCM",
 		.stream_name = "System Playback",
 		.dynamic = 1,
+		.ops = &bdw_rt5650_fe_ops,
 #if !IS_ENABLED(CONFIG_SND_SOC_SOF_BROADWELL)
 		.init = bdw_rt5650_rtd_init,
 #endif
-- 
2.7.4

