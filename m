Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2BA4228A5A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jul 2020 23:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731095AbgGUVHi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jul 2020 17:07:38 -0400
Received: from mga18.intel.com ([134.134.136.126]:59841 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726658AbgGUVHh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 17:07:37 -0400
IronPort-SDR: r1EEjtt0RXCTi+5Svux5JzHIq8W7ZWdiwHfeCyap9deKgg4pXX75XOuCwqLr8esaJlpFKdydaN
 pr02jqCDLjnA==
X-IronPort-AV: E=McAfee;i="6000,8403,9689"; a="137734230"
X-IronPort-AV: E=Sophos;i="5.75,380,1589266800"; 
   d="scan'208";a="137734230"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2020 14:07:36 -0700
IronPort-SDR: xfiJ9NNJ4KGguu1iWyDcO576Ka4bjPrUvFlOQGqJSMEBEWg/5exeu91oTouiAq4N3bNDx/yM0L
 NUjgCdoyY2Nw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,380,1589266800"; 
   d="scan'208";a="310380758"
Received: from joycetoh-desk.sc.intel.com ([172.25.206.187])
  by fmsmga004.fm.intel.com with ESMTP; 21 Jul 2020 14:07:36 -0700
From:   Harsha Priya <harshapriya.n@intel.com>
To:     alsa-devel@alsa-project.org, broonie@kernel.org,
        pierre-louis.bossart@linux.intel.com
Cc:     lma@semihalf.com, yang.jie@linux.intel.com,
        liam.r.girdwood@linux.intel.com, rad@semihalf.com,
        zwisler@google.com, linux-kernel@vger.kernel.org,
        sathya.prakash.m.r@intel.com, brndt@google.com, mw@semihalf.com,
        levinale@chromium.org, Harsha Priya <harshapriya.n@intel.com>,
        Vamshi Krishna Gopal <vamshi.krishna.gopal@intel.com>
Subject: [PATCH v7] ASoC: Intel: kbl_rt5663_rt5514_max98927: Fix kabylake_ssp_fixup function
Date:   Tue, 21 Jul 2020 14:07:29 -0700
Message-Id: <1595365649-8019-1-git-send-email-harshapriya.n@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kabylake_ssp_fixup function uses snd_soc_dpcm to identify the codecs DAIs.
The hw parameters are changed based on the codec DAI,
the stream is intended for. The earlier approach to get
snd_soc_dpcm was using container_of() macro on snd_pcm_hw_params.
The structures have been modified over time and snd_soc_dpcm does
not have snd_pcm_hw_params as a reference but as a copy.
This causes the current driver to crash when used.
This patch changes the way snd_soc_dpcm is extracted.
The snd_soc_pcm_runtime holds 2 dpcm
instances (one for playback and one for capture).
The 2 codecs on this SSP are dmic and speakers.
One is for capture and one is for playback respectively.
Based on the direction of the stream,
the snd_soc_dpcm is extracted from the snd_soc_pcm_runtime structure.
Tested for all use cases of the driver.

Signed-off-by: Harsha Priya <harshapriya.n@intel.com>
Signed-off-by: Vamshi Krishna Gopal <vamshi.krishna.gopal@intel.com>
Tested-by: Lukasz Majczak <lma@semihalf.com>
---
v1 -> v2:
- Extract dmic from SSP0 as every BE should have own fixup function.
v2 -> v3:
- Restore naming in the dapm route table to not confuse with other
drivers
- Fixed indentations
v3 -> v4:
- Updated code and commit description according to
solution proposed by Harsha
v4 -> v5:
- Cosmetic Changes
v5 -> v6:
- Dmic regression seen with v4 fixed 
- Using available routines for obtaining dpcm information
v6 -> v7:
- Updated comments
- initilize rtd_dpcm variable
- added break statement in the loop

---
---
 .../intel/boards/kbl_rt5663_rt5514_max98927.c | 38 ++++++++++++++-----
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
index 584e4f9cedc2..9f4b949cc39c 100644
--- a/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
+++ b/sound/soc/intel/boards/kbl_rt5663_rt5514_max98927.c
@@ -379,22 +379,42 @@ static int kabylake_ssp_fixup(struct snd_soc_pcm_runtime *rtd,
 	struct snd_interval *chan = hw_param_interval(params,
 			SNDRV_PCM_HW_PARAM_CHANNELS);
 	struct snd_mask *fmt = hw_param_mask(params, SNDRV_PCM_HW_PARAM_FORMAT);
-	struct snd_soc_dpcm *dpcm = container_of(
-			params, struct snd_soc_dpcm, hw_params);
-	struct snd_soc_dai_link *fe_dai_link = dpcm->fe->dai_link;
-	struct snd_soc_dai_link *be_dai_link = dpcm->be->dai_link;
+	struct snd_soc_dpcm *dpcm, *rtd_dpcm = NULL;
+
+	/*
+	 * The following loop will be called only for playback stream
+	 * In this platform, there is only one playback device on every SSP
+	 */
+	for_each_dpcm_fe(rtd, SNDRV_PCM_STREAM_PLAYBACK, dpcm) {
+		rtd_dpcm = dpcm;
+		break;
+	}
+
+	/*
+	 * This following loop will be called only for capture stream
+	 * In this platform, there is only one capture device on every SSP
+	 */
+	for_each_dpcm_fe(rtd, SNDRV_PCM_STREAM_CAPTURE, dpcm) {
+		rtd_dpcm = dpcm;
+		break;
+	}
+
+	/*
+	 * The above 2 loops are mutually exclusive based on the strem direction,
+	 * thus rtd_dpcm variable will never be overwritten
+	 */
 
 	/*
 	 * The ADSP will convert the FE rate to 48k, stereo, 24 bit
 	 */
-	if (!strcmp(fe_dai_link->name, "Kbl Audio Port") ||
-	    !strcmp(fe_dai_link->name, "Kbl Audio Headset Playback") ||
-	    !strcmp(fe_dai_link->name, "Kbl Audio Capture Port")) {
+	if (!strcmp(rtd_dpcm->fe->dai_link->name, "Kbl Audio Port") ||
+	    !strcmp(rtd_dpcm->fe->dai_link->name, "Kbl Audio Headset Playback") ||
+	    !strcmp(rtd_dpcm->fe->dai_link->name, "Kbl Audio Capture Port")) {
 		rate->min = rate->max = 48000;
 		chan->min = chan->max = 2;
 		snd_mask_none(fmt);
 		snd_mask_set_format(fmt, SNDRV_PCM_FORMAT_S24_LE);
-	} else if (!strcmp(fe_dai_link->name, "Kbl Audio DMIC cap")) {
+	} else if (!strcmp(rtd_dpcm->fe->dai_link->name, "Kbl Audio DMIC cap")) {
 		if (params_channels(params) == 2 ||
 				DMIC_CH(dmic_constraints) == 2)
 			chan->min = chan->max = 2;
@@ -405,7 +425,7 @@ static int kabylake_ssp_fixup(struct snd_soc_pcm_runtime *rtd,
 	 * The speaker on the SSP0 supports S16_LE and not S24_LE.
 	 * thus changing the mask here
 	 */
-	if (!strcmp(be_dai_link->name, "SSP0-Codec"))
+	if (!strcmp(rtd_dpcm->be->dai_link->name, "SSP0-Codec"))
 		snd_mask_set_format(fmt, SNDRV_PCM_FORMAT_S16_LE);
 
 	return 0;
-- 
2.17.1

