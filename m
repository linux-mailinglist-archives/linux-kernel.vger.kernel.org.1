Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2044725E5C7
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Sep 2020 08:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgIEGWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Sep 2020 02:22:55 -0400
Received: from mga18.intel.com ([134.134.136.126]:49017 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725818AbgIEGWw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Sep 2020 02:22:52 -0400
IronPort-SDR: 2OFQ4m1nvSiut1YDwvID1eEQr00bkDz6RzMla967eGVnwCrgQYShfOj1y1DVXvQjd1x4M4otFt
 yWgj2vOUx+KA==
X-IronPort-AV: E=McAfee;i="6000,8403,9734"; a="145547461"
X-IronPort-AV: E=Sophos;i="5.76,392,1592895600"; 
   d="scan'208";a="145547461"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2020 23:22:51 -0700
IronPort-SDR: XHKZPE1pnjJxVEqYHA9SQHCGYf1cI1IGLzueIWa1oY4RSdmcaJrtWtCdTpA97zCD3b+7FS0S/v
 ddaKZCMdNjgg==
X-IronPort-AV: E=Sophos;i="5.76,392,1592895600"; 
   d="scan'208";a="478804292"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2020 23:22:47 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: [PATCH v3 3/3]  ASoC: Intel: sof_sdw: add dailink .prepare and .hw_free callback
Date:   Sat,  5 Sep 2020 02:28:54 +0800
Message-Id: <20200904182854.3944-4-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200904182854.3944-1-yung-chuan.liao@linux.intel.com>
References: <20200904182854.3944-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Add .prepare and .hw_free callback to dailink.

The companion patch for this patch is the removal of stream operations
in the .prepare and .hw_free callbacks at the DAI level in
drivers/soundwire/intel.c

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Reviewed-by: Rander Wang <rander.wang@linux.intel.com>
Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
---
 sound/soc/intel/boards/sof_sdw.c | 40 ++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/sound/soc/intel/boards/sof_sdw.c b/sound/soc/intel/boards/sof_sdw.c
index f251e046d74d..16503772965c 100644
--- a/sound/soc/intel/boards/sof_sdw.c
+++ b/sound/soc/intel/boards/sof_sdw.c
@@ -195,6 +195,25 @@ int sdw_startup(struct snd_pcm_substream *substream)
 	return sdw_startup_stream(substream);
 }
 
+static int sdw_prepare(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
+	struct sdw_stream_runtime *sdw_stream;
+	struct snd_soc_dai *dai;
+
+	/* Find stream from first CPU DAI */
+	dai = asoc_rtd_to_cpu(rtd, 0);
+
+	sdw_stream = snd_soc_dai_get_sdw_stream(dai, substream->stream);
+
+	if (IS_ERR(sdw_stream)) {
+		dev_err(rtd->dev, "no stream found for DAI %s", dai->name);
+		return PTR_ERR(sdw_stream);
+	}
+
+	return sdw_prepare_stream(sdw_stream);
+}
+
 static int sdw_trigger(struct snd_pcm_substream *substream, int cmd)
 {
 	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
@@ -235,6 +254,25 @@ static int sdw_trigger(struct snd_pcm_substream *substream, int cmd)
 	return ret;
 }
 
+static int sdw_hw_free(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = asoc_substream_to_rtd(substream);
+	struct sdw_stream_runtime *sdw_stream;
+	struct snd_soc_dai *dai;
+
+	/* Find stream from first CPU DAI */
+	dai = asoc_rtd_to_cpu(rtd, 0);
+
+	sdw_stream = snd_soc_dai_get_sdw_stream(dai, substream->stream);
+
+	if (IS_ERR(sdw_stream)) {
+		dev_err(rtd->dev, "no stream found for DAI %s", dai->name);
+		return PTR_ERR(sdw_stream);
+	}
+
+	return sdw_deprepare_stream(sdw_stream);
+}
+
 void sdw_shutdown(struct snd_pcm_substream *substream)
 {
 	sdw_shutdown_stream(substream);
@@ -242,7 +280,9 @@ void sdw_shutdown(struct snd_pcm_substream *substream)
 
 static const struct snd_soc_ops sdw_ops = {
 	.startup = sdw_startup,
+	.prepare = sdw_prepare,
 	.trigger = sdw_trigger,
+	.hw_free = sdw_hw_free,
 	.shutdown = sdw_shutdown,
 };
 
-- 
2.17.1

