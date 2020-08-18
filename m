Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2517F247CAC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 05:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgHRDXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 23:23:42 -0400
Received: from mga03.intel.com ([134.134.136.65]:63987 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726647AbgHRDXd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 23:23:33 -0400
IronPort-SDR: 6HKLDSZ0gcDvrF/PLone3txpiUACH4Zr4xKIQNH15L8Um2QxMtSiE0hsTSEuxf7RCzXJON+Bo3
 gD4RiSuE6D9g==
X-IronPort-AV: E=McAfee;i="6000,8403,9716"; a="154806485"
X-IronPort-AV: E=Sophos;i="5.76,325,1592895600"; 
   d="scan'208";a="154806485"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 20:23:32 -0700
IronPort-SDR: 6J4Ao/94+u2JJ7c5mjZuan033/qQQ7tk915WIWz6hDEB6ZWPpK9iaXrNMqLHS3SLLCQ+6SA5ey
 Uq5YKqo1xQMg==
X-IronPort-AV: E=Sophos;i="5.76,325,1592895600"; 
   d="scan'208";a="441084596"
Received: from bard-ubuntu.sh.intel.com ([10.239.13.33])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 20:23:28 -0700
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org, tiwai@suse.de,
        broonie@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        srinivas.kandagatla@linaro.org, rander.wang@linux.intel.com,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        pierre-louis.bossart@linux.intel.com, sanyog.r.kale@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
Subject: [PATCH v2 05/12] soundwire: intel: reinitialize IP+DSP in .prepare(), but only when resuming
Date:   Mon, 17 Aug 2020 23:29:16 +0800
Message-Id: <20200817152923.3259-6-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817152923.3259-1-yung-chuan.liao@linux.intel.com>
References: <20200817152923.3259-1-yung-chuan.liao@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The .prepare() callback is invoked for normal streaming, underflows or
during the system resume transition. In the latter case, the context
for the ALH PDIs is lost, and the DSP is not initialized properly
either, but the bus parameters don't need to be recomputed.

Conversely, when doing a regular .prepare() during an underflow, the
ALH/SHIM registers shall not be changed as the hardware cannot be
reprogrammed after the DMA started (hardware spec requirement).

This patch adds storage of PDI and hw_params in the DAI dma context,
and the difference between the types of .prepare() usages is handled
via a simple boolean, updated when suspending, and tested for in the
.prepare() case.

Signed-off-by: Bard Liao <yung-chuan.liao@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/soundwire/cadence_master.h |  4 ++
 drivers/soundwire/intel.c          | 71 +++++++++++++++++++++++++++++-
 2 files changed, 74 insertions(+), 1 deletion(-)

diff --git a/drivers/soundwire/cadence_master.h b/drivers/soundwire/cadence_master.h
index 7638858397df..fdec62b912d3 100644
--- a/drivers/soundwire/cadence_master.h
+++ b/drivers/soundwire/cadence_master.h
@@ -84,6 +84,8 @@ struct sdw_cdns_stream_config {
  * @bus: Bus handle
  * @stream_type: Stream type
  * @link_id: Master link id
+ * @hw_params: hw_params to be applied in .prepare step
+ * @suspended: status set when suspended, to be used in .prepare
  */
 struct sdw_cdns_dma_data {
 	char *name;
@@ -92,6 +94,8 @@ struct sdw_cdns_dma_data {
 	struct sdw_bus *bus;
 	enum sdw_stream_type stream_type;
 	int link_id;
+	struct snd_pcm_hw_params *hw_params;
+	bool suspended;
 };
 
 /**
diff --git a/drivers/soundwire/intel.c b/drivers/soundwire/intel.c
index 10dd0e208ce7..95a1d88a5bfb 100644
--- a/drivers/soundwire/intel.c
+++ b/drivers/soundwire/intel.c
@@ -879,6 +879,10 @@ static int intel_hw_params(struct snd_pcm_substream *substream,
 	intel_pdi_alh_configure(sdw, pdi);
 	sdw_cdns_config_stream(cdns, ch, dir, pdi);
 
+	/* store pdi and hw_params, may be needed in prepare step */
+	dma->suspended = false;
+	dma->pdi = pdi;
+	dma->hw_params = params;
 
 	/* Inform DSP about PDI stream number */
 	ret = intel_params_stream(sdw, substream, dai, params,
@@ -922,7 +926,11 @@ static int intel_hw_params(struct snd_pcm_substream *substream,
 static int intel_prepare(struct snd_pcm_substream *substream,
 			 struct snd_soc_dai *dai)
 {
+	struct sdw_cdns *cdns = snd_soc_dai_get_drvdata(dai);
+	struct sdw_intel *sdw = cdns_to_intel(cdns);
 	struct sdw_cdns_dma_data *dma;
+	int ch, dir;
+	int ret;
 
 	dma = snd_soc_dai_get_dma_data(dai, substream);
 	if (!dma) {
@@ -931,7 +939,41 @@ static int intel_prepare(struct snd_pcm_substream *substream,
 		return -EIO;
 	}
 
-	return sdw_prepare_stream(dma->stream);
+	if (dma->suspended) {
+		dma->suspended = false;
+
+		/*
+		 * .prepare() is called after system resume, where we
+		 * need to reinitialize the SHIM/ALH/Cadence IP.
+		 * .prepare() is also called to deal with underflows,
+		 * but in those cases we cannot touch ALH/SHIM
+		 * registers
+		 */
+
+		/* configure stream */
+		ch = params_channels(dma->hw_params);
+		if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
+			dir = SDW_DATA_DIR_RX;
+		else
+			dir = SDW_DATA_DIR_TX;
+
+		intel_pdi_shim_configure(sdw, dma->pdi);
+		intel_pdi_alh_configure(sdw, dma->pdi);
+		sdw_cdns_config_stream(cdns, ch, dir, dma->pdi);
+
+		/* Inform DSP about PDI stream number */
+		ret = intel_params_stream(sdw, substream, dai,
+					  dma->hw_params,
+					  sdw->instance,
+					  dma->pdi->intel_alh_id);
+		if (ret)
+			goto err;
+	}
+
+	ret = sdw_prepare_stream(dma->stream);
+
+err:
+	return ret;
 }
 
 static int intel_trigger(struct snd_pcm_substream *substream, int cmd,
@@ -1002,6 +1044,9 @@ intel_hw_free(struct snd_pcm_substream *substream, struct snd_soc_dai *dai)
 		return ret;
 	}
 
+	dma->hw_params = NULL;
+	dma->pdi = NULL;
+
 	return 0;
 }
 
@@ -1014,6 +1059,29 @@ static void intel_shutdown(struct snd_pcm_substream *substream,
 	pm_runtime_put_autosuspend(cdns->dev);
 }
 
+static int intel_component_dais_suspend(struct snd_soc_component *component)
+{
+	struct sdw_cdns_dma_data *dma;
+	struct snd_soc_dai *dai;
+
+	for_each_component_dais(component, dai) {
+		/*
+		 * we don't have a .suspend dai_ops, and we don't have access
+		 * to the substream, so let's mark both capture and playback
+		 * DMA contexts as suspended
+		 */
+		dma = dai->playback_dma_data;
+		if (dma)
+			dma->suspended = true;
+
+		dma = dai->capture_dma_data;
+		if (dma)
+			dma->suspended = true;
+	}
+
+	return 0;
+}
+
 static int intel_pcm_set_sdw_stream(struct snd_soc_dai *dai,
 				    void *stream, int direction)
 {
@@ -1066,6 +1134,7 @@ static const struct snd_soc_dai_ops intel_pdm_dai_ops = {
 
 static const struct snd_soc_component_driver dai_component = {
 	.name           = "soundwire",
+	.suspend	= intel_component_dais_suspend
 };
 
 static int intel_create_dai(struct sdw_cdns *cdns,
-- 
2.17.1

