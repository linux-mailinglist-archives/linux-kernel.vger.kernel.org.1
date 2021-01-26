Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45DB2304DEE
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 01:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388658AbhAZXZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 18:25:13 -0500
Received: from inva020.nxp.com ([92.121.34.13]:56928 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732442AbhAZFte (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 00:49:34 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 3BC741A0168;
        Tue, 26 Jan 2021 06:48:46 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E33541A0C31;
        Tue, 26 Jan 2021 06:48:43 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id AF022402F0;
        Tue, 26 Jan 2021 06:48:40 +0100 (CET)
From:   Shengjiu Wang <shengjiu.wang@nxp.com>
To:     lars@metafoo.de, perex@perex.cz, tiwai@suse.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ASoC: dmaengine_pcm: add peripheral configuration
Date:   Tue, 26 Jan 2021 13:38:16 +0800
Message-Id: <1611639496-4616-1-git-send-email-shengjiu.wang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit e7bbb7acabf4 ("dmaengine: add peripheral configuration")
adds peripheral configuration for dma_slave_config.

This configuration is useful for some audio peripherals, for
example, the peripheral supports multi fifos, we can
let the DMA know which fifos are selected. So also add
this configuration for snd_dmaengine_dai_dma_data.

Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
---
 include/sound/dmaengine_pcm.h | 5 +++++
 sound/core/pcm_dmaengine.c    | 2 ++
 2 files changed, 7 insertions(+)

diff --git a/include/sound/dmaengine_pcm.h b/include/sound/dmaengine_pcm.h
index 8c5e38180fb0..96666efddb39 100644
--- a/include/sound/dmaengine_pcm.h
+++ b/include/sound/dmaengine_pcm.h
@@ -66,6 +66,9 @@ struct dma_chan *snd_dmaengine_pcm_get_chan(struct snd_pcm_substream *substream)
  * @chan_name: Custom channel name to use when requesting DMA channel.
  * @fifo_size: FIFO size of the DAI controller in bytes
  * @flags: PCM_DAI flags, only SND_DMAENGINE_PCM_DAI_FLAG_PACK for now
+ * @peripheral_config: peripheral configuration for programming peripheral
+ * for dmaengine transfer
+ * @peripheral_size: peripheral configuration buffer size
  */
 struct snd_dmaengine_dai_dma_data {
 	dma_addr_t addr;
@@ -76,6 +79,8 @@ struct snd_dmaengine_dai_dma_data {
 	const char *chan_name;
 	unsigned int fifo_size;
 	unsigned int flags;
+	void *peripheral_config;
+	size_t peripheral_size;
 };
 
 void snd_dmaengine_pcm_set_config_from_dai_data(
diff --git a/sound/core/pcm_dmaengine.c b/sound/core/pcm_dmaengine.c
index 4d0e8fe535a1..1fc2fa077574 100644
--- a/sound/core/pcm_dmaengine.c
+++ b/sound/core/pcm_dmaengine.c
@@ -125,6 +125,8 @@ void snd_dmaengine_pcm_set_config_from_dai_data(
 	}
 
 	slave_config->slave_id = dma_data->slave_id;
+	slave_config->peripheral_config = dma_data->peripheral_config;
+	slave_config->peripheral_size = dma_data->peripheral_size;
 }
 EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_set_config_from_dai_data);
 
-- 
2.27.0

