Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 198BE297430
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 18:35:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S465975AbgJWQfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 12:35:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:33218 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751872AbgJWQdv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 12:33:51 -0400
Received: from mail.kernel.org (ip5f5ad5a3.dynamic.kabel-deutschland.de [95.90.213.163])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C713C246F3;
        Fri, 23 Oct 2020 16:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603470829;
        bh=TiErx0DHSwGmn93sXtyWEg2A3/4Yc9Z0tHKlR3Hbbcg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qEA8fW3jRdIXNz5GR1Vplzy6O+tNo+prcjXYE2X4keqqK9FL+w+wvRWfRoViMKyuF
         N4RjCYJwhqvq9iiKlHl8uIsG3nL9r8RWDMTd9i8+DPP95wwxHDZIyVi0sLysWjIPtG
         fRvBm0d5R4CGhOOunrItUP825AJoiI1z+dkIXYrU=
Received: from mchehab by mail.kernel.org with local (Exim 4.94)
        (envelope-from <mchehab@kernel.org>)
        id 1kW00g-002Axa-IV; Fri, 23 Oct 2020 18:33:46 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Arnd Bergmann <arnd@arndb.de>,
        Baolin Wang <baolin.wang@linaro.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Vinod Koul <vkoul@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, paulhsia <paulhsia@chromium.org>
Subject: [PATCH v3 48/56] sound: fix kernel-doc markups
Date:   Fri, 23 Oct 2020 18:33:35 +0200
Message-Id: <535182d6f55d7a7de293dda9676df68f5f60afc6.1603469755.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <cover.1603469755.git.mchehab+huawei@kernel.org>
References: <cover.1603469755.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel-doc markups should use this format:
        identifier - description

There is a common comment marked, instead, with kernel-doc
notation.

Some identifiers have different names between their prototypes
and the kernel-doc markup.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 include/sound/core.h                  | 3 ++-
 include/sound/pcm.h                   | 4 ++--
 include/uapi/sound/compress_offload.h | 2 +-
 sound/core/control.c                  | 4 ++--
 sound/core/pcm_dmaengine.c            | 3 ++-
 sound/core/pcm_lib.c                  | 2 +-
 sound/core/pcm_native.c               | 4 ++--
 sound/soc/soc-core.c                  | 2 +-
 sound/soc/soc-dapm.c                  | 2 +-
 9 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/include/sound/core.h b/include/sound/core.h
index 381a010a1bd4..0462c577d7a3 100644
--- a/include/sound/core.h
+++ b/include/sound/core.h
@@ -332,7 +332,8 @@ void __snd_printk(unsigned int level, const char *file, int line,
 #define snd_BUG()		WARN(1, "BUG?\n")
 
 /**
- * Suppress high rates of output when CONFIG_SND_DEBUG is enabled.
+ * snd_printd_ratelimit - Suppress high rates of output when
+ * 			  CONFIG_SND_DEBUG is enabled.
  */
 #define snd_printd_ratelimit() printk_ratelimit()
 
diff --git a/include/sound/pcm.h b/include/sound/pcm.h
index 2ba5df2c9e23..2336bf9243e1 100644
--- a/include/sound/pcm.h
+++ b/include/sound/pcm.h
@@ -1284,8 +1284,8 @@ snd_pcm_sgbuf_get_ptr(struct snd_pcm_substream *substream, unsigned int ofs)
 }
 
 /**
- * snd_pcm_sgbuf_chunk_size - Compute the max size that fits within the contig.
- * page from the given size
+ * snd_pcm_sgbuf_get_chunk_size - Compute the max size that fits within the
+ * contig. page from the given size
  * @substream: PCM substream
  * @ofs: byte offset
  * @size: byte size to examine
diff --git a/include/uapi/sound/compress_offload.h b/include/uapi/sound/compress_offload.h
index 7184265c0b0d..9555f31c8425 100644
--- a/include/uapi/sound/compress_offload.h
+++ b/include/uapi/sound/compress_offload.h
@@ -144,7 +144,7 @@ struct snd_compr_metadata {
 	 __u32 value[8];
 } __attribute__((packed, aligned(4)));
 
-/**
+/*
  * compress path ioctl definitions
  * SNDRV_COMPRESS_GET_CAPS: Query capability of DSP
  * SNDRV_COMPRESS_GET_CODEC_CAPS: Query capability of a codec
diff --git a/sound/core/control.c b/sound/core/control.c
index 421ddc76f264..4373de42a5a0 100644
--- a/sound/core/control.c
+++ b/sound/core/control.c
@@ -1925,8 +1925,8 @@ EXPORT_SYMBOL(snd_ctl_unregister_ioctl);
 
 #ifdef CONFIG_COMPAT
 /**
- * snd_ctl_unregister_ioctl - de-register the device-specific compat 32bit
- * control-ioctls
+ * snd_ctl_unregister_ioctl_compat - de-register the device-specific compat
+ * 32bit control-ioctls
  * @fcn: ioctl callback function to unregister
  */
 int snd_ctl_unregister_ioctl_compat(snd_kctl_ioctl_func_t fcn)
diff --git a/sound/core/pcm_dmaengine.c b/sound/core/pcm_dmaengine.c
index 4d059ff2b2e4..4d0e8fe535a1 100644
--- a/sound/core/pcm_dmaengine.c
+++ b/sound/core/pcm_dmaengine.c
@@ -356,7 +356,8 @@ int snd_dmaengine_pcm_close(struct snd_pcm_substream *substream)
 EXPORT_SYMBOL_GPL(snd_dmaengine_pcm_close);
 
 /**
- * snd_dmaengine_pcm_release_chan_close - Close a dmaengine based PCM substream and release channel
+ * snd_dmaengine_pcm_close_release_chan - Close a dmaengine based PCM
+ *					  substream and release channel
  * @substream: PCM substream
  *
  * Releases the DMA channel associated with the PCM substream.
diff --git a/sound/core/pcm_lib.c b/sound/core/pcm_lib.c
index d531e1bc2b81..bda3514c7b2d 100644
--- a/sound/core/pcm_lib.c
+++ b/sound/core/pcm_lib.c
@@ -490,7 +490,7 @@ void snd_pcm_set_ops(struct snd_pcm *pcm, int direction,
 EXPORT_SYMBOL(snd_pcm_set_ops);
 
 /**
- * snd_pcm_sync - set the PCM sync id
+ * snd_pcm_set_sync - set the PCM sync id
  * @substream: the pcm substream
  *
  * Sets the PCM sync identifier for the card.
diff --git a/sound/core/pcm_native.c b/sound/core/pcm_native.c
index 9e0b2d73faf6..47b155a49226 100644
--- a/sound/core/pcm_native.c
+++ b/sound/core/pcm_native.c
@@ -112,7 +112,7 @@ void snd_pcm_stream_lock(struct snd_pcm_substream *substream)
 EXPORT_SYMBOL_GPL(snd_pcm_stream_lock);
 
 /**
- * snd_pcm_stream_lock - Unlock the PCM stream
+ * snd_pcm_stream_unlock - Unlock the PCM stream
  * @substream: PCM substream
  *
  * This unlocks the PCM stream that has been locked via snd_pcm_stream_lock().
@@ -595,7 +595,7 @@ static void snd_pcm_sync_stop(struct snd_pcm_substream *substream)
 }
 
 /**
- * snd_pcm_hw_param_choose - choose a configuration defined by @params
+ * snd_pcm_hw_params_choose - choose a configuration defined by @params
  * @pcm: PCM instance
  * @params: the hw_params instance
  *
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index ea3986a46c12..05a085f6dc7c 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2341,7 +2341,7 @@ struct snd_soc_dai *snd_soc_register_dai(struct snd_soc_component *component,
 }
 
 /**
- * snd_soc_unregister_dai - Unregister DAIs from the ASoC core
+ * snd_soc_unregister_dais - Unregister DAIs from the ASoC core
  *
  * @component: The component for which the DAIs should be unregistered
  */
diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 980f2c330b87..7f87b449f950 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -1276,7 +1276,7 @@ static int is_connected_input_ep(struct snd_soc_dapm_widget *widget,
 }
 
 /**
- * snd_soc_dapm_get_connected_widgets - query audio path and it's widgets.
+ * snd_soc_dapm_dai_get_connected_widgets - query audio path and it's widgets.
  * @dai: the soc DAI.
  * @stream: stream direction.
  * @list: list of active widgets for this stream.
-- 
2.26.2

