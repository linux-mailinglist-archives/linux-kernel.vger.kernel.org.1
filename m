Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27F0425D3D4
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 10:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729934AbgIDIlg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 04:41:36 -0400
Received: from mga04.intel.com ([192.55.52.120]:13465 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729924AbgIDIlf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 04:41:35 -0400
IronPort-SDR: qxyw2VEIXwxWE00XlTXRvROgKnSWPief2Rl0qqV8EXl0Zep+ddlThaGW7Fxrzs3ouhILEomZa4
 9hLZIAWxCmCg==
X-IronPort-AV: E=McAfee;i="6000,8403,9733"; a="155108904"
X-IronPort-AV: E=Sophos;i="5.76,389,1592895600"; 
   d="scan'208";a="155108904"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2020 01:41:34 -0700
IronPort-SDR: GGJd22o4rz1ij9zEaQAK78nZoMsaMSyi8PaKMuV8rC5xbJdjIA9BWATs+bJsWhG2TRj61lpSpE
 Fm29k7JjAX9w==
X-IronPort-AV: E=Sophos;i="5.76,389,1592895600"; 
   d="scan'208";a="284358923"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2020 01:41:30 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: [PATCH v2 3/4] soundwire: intel: remove .trigger operation
Date:   Fri,  4 Sep 2020 04:47:38 +0800
Message-Id: <20200903204739.31206-4-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200903204739.31206-1-yung-chuan.liao@linux.intel.com>
References: <20200903204739.31206-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Now that the stream trigger is handled at the dai-link level, there is
no need for a dai-level trigger any longer.

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 drivers/soundwire/intel.c | 39 ---------------------------------------
 1 file changed, 39 deletions(-)

diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 7c20b7daf1c8..d208c49b157a 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -1013,43 +1013,6 @@ static int intel_prepare(struct snd_pcm_substream *substream,
 	return ret;
 }
 
-static int intel_trigger(struct snd_pcm_substream *substream, int cmd,
-			 struct snd_soc_dai *dai)
-{
-	struct sdw_cdns_dma_data *dma;
-	int ret;
-
-	dma = snd_soc_dai_get_dma_data(dai, substream);
-	if (!dma) {
-		dev_err(dai->dev, "failed to get dma data in %s", __func__);
-		return -EIO;
-	}
-
-	switch (cmd) {
-	case SNDRV_PCM_TRIGGER_START:
-	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
-	case SNDRV_PCM_TRIGGER_RESUME:
-		ret = sdw_enable_stream(dma->stream);
-		break;
-
-	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
-	case SNDRV_PCM_TRIGGER_SUSPEND:
-	case SNDRV_PCM_TRIGGER_STOP:
-		ret = sdw_disable_stream(dma->stream);
-		break;
-
-	default:
-		ret = -EINVAL;
-		break;
-	}
-
-	if (ret)
-		dev_err(dai->dev,
-			"%s trigger %d failed: %d",
-			__func__, cmd, ret);
-	return ret;
-}
-
 static int
 intel_hw_free(struct snd_pcm_substream *substream, struct snd_soc_dai *dai)
 {
@@ -1151,7 +1114,6 @@ static const struct snd_soc_dai_ops intel_pcm_dai_ops = {
 	.startup = intel_startup,
 	.hw_params = intel_hw_params,
 	.prepare = intel_prepare,
-	.trigger = intel_trigger,
 	.hw_free = intel_hw_free,
 	.shutdown = intel_shutdown,
 	.set_sdw_stream = intel_pcm_set_sdw_stream,
@@ -1162,7 +1124,6 @@ static const struct snd_soc_dai_ops intel_pdm_dai_ops = {
 	.startup = intel_startup,
 	.hw_params = intel_hw_params,
 	.prepare = intel_prepare,
-	.trigger = intel_trigger,
 	.hw_free = intel_hw_free,
 	.shutdown = intel_shutdown,
 	.set_sdw_stream = intel_pdm_set_sdw_stream,
-- 
2.17.1

