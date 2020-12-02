Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 781F62CB7F0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 10:01:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387982AbgLBI75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 03:59:57 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:2995 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387961AbgLBI75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 03:59:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1606899596; x=1638435596;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4wWcur5DlsfV0lXw+0GFCRuwJmV24Pfs1EWJ0dKu/e0=;
  b=SwULJ6tNySlslBi+zL5D0Vql+sKgrhbBFU4sFSrOwo64oWlGQUK5iyfy
   vLVEuPIxkOc1QnbioazZrMfI4q/Ab6pJ4lxLLEkNbfANmejXt9K+KwWBQ
   AqfrmaKDuBgeFuSB9h/mjiHYXfjSwydYJhQLkIkQRB3Bm8ArcDVR03oJ1
   gp0x0BSK+FkhNbYqsN3R9jiHnkrJ5WU9WD3MaiWYL6B3x5um26aAbcF34
   8718umFJeuB4LR9BpQso6hPiv9sthLvbHJIrm0QNHn7Tev7hfWUnNeY4o
   x9KtWyiYf/rU1BlHReaqtuXiFRSH/b3cJhZTXAEqmq2D2K8+rkNMfmlun
   g==;
IronPort-SDR: q5U6gLx4CEBN2KAufOk1EWi97dBu/2+kfYG6StG7i7Z8vucCkMNhZhibAzzXV/ez1xZAxFNoup
 DauJHg09cB9dTe6D6GurXYVyntLnbd2XWOczd1UNTZw2K0VlsKjCfYpdfe7atD6LDM8khumRcy
 f3Zp3ipp2XKm3oYiI7tk8kuejALLeY6Su413PEtIceoF43XkO8cjldn7ogcrs7ZEAse8upKZrr
 M8h2wACC0kcZuC1woo1DmZAnPRpJZl7KAOX9GEgM1kVlb8B6qj+g39aFTAfMUtvOpe1MtrV8+x
 C3c=
X-IronPort-AV: E=Sophos;i="5.78,386,1599548400"; 
   d="scan'208";a="105815768"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Dec 2020 01:58:50 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 2 Dec 2020 01:58:50 -0700
Received: from rob-ult-m19940.amer.actel.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.1979.3 via Frontend Transport; Wed, 2 Dec 2020 01:58:47 -0700
From:   Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
To:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>
CC:     <broonie@kernel.org>, <lgirdwood@gmail.com>, <tiwai@suse.com>,
        <perex@perex.cz>, <lars@metafoo.de>,
        Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
Subject: [RFC PATCH] ASoC: pcm_dmaengine: Add support for BE DAIs
Date:   Wed, 2 Dec 2020 10:58:38 +0200
Message-ID: <20201202085838.1779525-1-codrin.ciubotariu@microchip.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Considering the bellow scenarios:
                                                /- Gen DMA engine -\
       48KHz    ********     *******   44.1KHz  ********     *******     *********
PCM0 <-FE DAI-> * FE   * <-> * DSP * <-BE DAI-> *      *     *     *     *       *
                * Ring *     *     *            * Ring * <-> * CPU * <-> * Codec *
                * buff *     *******            * buff *     * DAI *     * DAI   *
       44.1KHz  ********                        *      *     *     *     *       *
PCM1 <--------------------DAI-----------------> *      *     *     *     *       *
                                                ********     *******     *********

For PCM0, we have two DAI links. The first DAI link is a FE, with a DSP as
a CPU DAI and a platform driver .The second DAI link is a BE DAI link,
with separate CPU, codec and platform drivers. We can also notice that
there are two Ring buffers: the first one used by the DSP to communicate
with the user-space and the second one used to move data between FE
(DSP) and BE (CPU).
PCM1 is a normal DAI link, with a CPU, codec and platform driver. It is
exactly the previous BE DAI link from PCM0, so the samples from user-space
are copied directly into the second Ring buffer.

In this scenario, the BE DAI link driver should be the same, since it is
decided at runtime whether the DAI is a used as a BE or not. The generic
platform driver needs to be aware of this thing. For the BE case (PCM0),
some callbacks of the platform driver are not called, hence the
preallocated buffer is not available. Also, the PCM runtime strcture
must not be touched, since it should be only used by the FE platform
driver.

With these changes, the generic dmaengine can also be used as a BE
platform driver.

Signed-off-by: Codrin Ciubotariu <codrin.ciubotariu@microchip.com>
---

Hello,
 
This patch is more or less incomplete for the described scenario. This
is because DMAengine's pcm->config is ignored for the BE DAI link, so
runtime->hw is not updated. Also, since pcm_construct/destruct are not
called, the DMA channels are allocated only if DT is used.
Underrun/overrun support would also be a nice to have for the transfers
involving the buffer allocated for the BE.
One way to hold trach of these would be to use a substream_be->runtime
different than the one used for the FE.

Please share your thoughts.

 sound/core/pcm_dmaengine.c            | 18 ++++++++++--
 sound/soc/soc-generic-dmaengine-pcm.c | 40 +++++++++++++++++++++++----
 2 files changed, 50 insertions(+), 8 deletions(-)

diff --git a/sound/core/pcm_dmaengine.c b/sound/core/pcm_dmaengine.c
index 4d059ff2b2e4..5e96bc27628d 100644
--- a/sound/core/pcm_dmaengine.c
+++ b/sound/core/pcm_dmaengine.c
@@ -137,7 +137,9 @@ static void dmaengine_pcm_dma_complete(void *arg)
 	if (prtd->pos >= snd_pcm_lib_buffer_bytes(substream))
 		prtd->pos = 0;
 
-	snd_pcm_period_elapsed(substream);
+	/* do no update period for an internal PCM */
+	if (!substream->pcm->internal)
+		snd_pcm_period_elapsed(substream);
 }
 
 static int dmaengine_pcm_prepare_and_submit(struct snd_pcm_substream *substream)
@@ -147,6 +149,7 @@ static int dmaengine_pcm_prepare_and_submit(struct snd_pcm_substream *substream)
 	struct dma_async_tx_descriptor *desc;
 	enum dma_transfer_direction direction;
 	unsigned long flags = DMA_CTRL_ACK;
+	dma_addr_t addr;
 
 	direction = snd_pcm_substream_to_dma_direction(substream);
 
@@ -154,11 +157,15 @@ static int dmaengine_pcm_prepare_and_submit(struct snd_pcm_substream *substream)
 		flags |= DMA_PREP_INTERRUPT;
 
 	prtd->pos = 0;
+	if (substream->pcm->internal)
+		addr = substream->dma_buffer.addr;
+	else
+		addr = substream->runtime->dma_addr;
+
 	desc = dmaengine_prep_dma_cyclic(chan,
-		substream->runtime->dma_addr,
+		addr,
 		snd_pcm_lib_buffer_bytes(substream),
 		snd_pcm_lib_period_bytes(substream), direction, flags);
-
 	if (!desc)
 		return -ENOMEM;
 
@@ -315,6 +322,11 @@ int snd_dmaengine_pcm_open(struct snd_pcm_substream *substream,
 
 	substream->runtime->private_data = prtd;
 
+	if (substream->pcm->internal) {
+		substream->dma_buffer.dev.type = SNDRV_DMA_TYPE_DEV_IRAM;
+		substream->dma_buffer.dev.dev = chan->device->dev;
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_open);
diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index 9ef80a48707e..f403849cd1aa 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -97,6 +97,31 @@ static int dmaengine_pcm_hw_params(struct snd_soc_component *component,
 		if (ret)
 			return ret;
 	}
+	if (!substream->pcm->internal) {
+		return snd_pcm_lib_malloc_pages(substream,
+						params_buffer_bytes(params));
+	}
+
+	/* allocate a buffer for BE DAI; for now, the buffer will have the same
+	 * size as the buffer used by the FE
+	 */
+	if (snd_dma_alloc_pages(substream->dma_buffer.dev.type,
+				substream->dma_buffer.dev.dev,
+				params_buffer_bytes(params),
+				&substream->dma_buffer) < 0)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static int dmaengine_pcm_hw_free(struct snd_soc_component *component,
+				 struct snd_pcm_substream *substream)
+{
+	if (!substream->pcm->internal)
+		return 0;
+
+	snd_dma_free_pages(&substream->dma_buffer);
+	substream->dma_buffer.area = NULL;
 
 	return 0;
 }
@@ -157,9 +182,12 @@ static int dmaengine_pcm_open(struct snd_soc_component *component,
 	struct dma_chan *chan = pcm->chan[substream->stream];
 	int ret;
 
-	ret = dmaengine_pcm_set_runtime_hwparams(component, substream);
-	if (ret)
-		return ret;
+	/* do not touch runtime if this is an internal PCM */
+	if (!substream->pcm->internal) {
+		ret = dmaengine_pcm_set_runtime_hwparams(component, substream);
+		if (ret)
+			return ret;
+	}
 
 	return snd_dmaengine_pcm_open(substream, chan);
 }
@@ -309,7 +337,7 @@ static int dmaengine_copy_user(struct snd_soc_component *component,
 			channel * (runtime->dma_bytes / runtime->channels);
 	int ret;
 
-	if (is_playback)
+	if (!substream->pcm->internal && is_playback)
 		if (copy_from_user(dma_ptr, buf, bytes))
 			return -EFAULT;
 
@@ -319,7 +347,7 @@ static int dmaengine_copy_user(struct snd_soc_component *component,
 			return ret;
 	}
 
-	if (!is_playback)
+	if (!substream->pcm->internal && !is_playback)
 		if (copy_to_user(buf, dma_ptr, bytes))
 			return -EFAULT;
 
@@ -332,6 +360,7 @@ static const struct snd_soc_component_driver dmaengine_pcm_component = {
 	.open		= dmaengine_pcm_open,
 	.close		= dmaengine_pcm_close,
 	.hw_params	= dmaengine_pcm_hw_params,
+	.hw_free	= dmaengine_pcm_hw_free,
 	.trigger	= dmaengine_pcm_trigger,
 	.pointer	= dmaengine_pcm_pointer,
 	.pcm_construct	= dmaengine_pcm_new,
@@ -344,6 +373,7 @@ static const struct snd_soc_component_driver dmaengine_pcm_component_process = {
 	.close		= dmaengine_pcm_close,
 	.hw_params	= dmaengine_pcm_hw_params,
 	.trigger	= dmaengine_pcm_trigger,
+	.hw_free	= dmaengine_pcm_hw_free,
 	.pointer	= dmaengine_pcm_pointer,
 	.copy_user	= dmaengine_copy_user,
 	.pcm_construct	= dmaengine_pcm_new,
-- 
2.27.0

