Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE61B2D614F
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 17:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391811AbgLJQJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 11:09:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403884AbgLJQIO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 11:08:14 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8F5C0611CA
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 08:07:34 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id w79so5245710qkb.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 08:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8qkH/T0u1gIF+PhxKKFzFehDKE3HDIIdIpQZFLT4Bhs=;
        b=TTCCXDSLrBA2NXLYRXoh5BMEly9WIUnOfhgx7j16Bglfc5BJz1rjDT2guFKeq43Sof
         nVG1qWc598tBvGLf1WeHNilHbrG7olVsOOfnNvn5GsHCIimYEgCrgx9N0nH4TZFNYPYj
         mgPcYASjrHDrb6X7mB1PXUDfVC3xEsJCnGmDrXa+WbH/E7cK63jYEuupVdv36Q/vZWxZ
         O3GMHCLNAOURheN+L73YIlI+ycmILecTaUYc4Z4Ssp9gec4rldklTehOeEtWeqKscgcJ
         q8rhKRimXqXWbUwJh0BExMUTEqdUmatmknMb67i+i21ctEM3gs6b1Zf05sVSsKzMsehi
         Qv1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8qkH/T0u1gIF+PhxKKFzFehDKE3HDIIdIpQZFLT4Bhs=;
        b=b2rnIBHC5/54n2VNVgR4GK8PUAjIEdhRBycojXR1mcC+XLYJ9+trGPHCGPlDP5ZwWI
         5xR/sI8Iksfnf8OzDCiX6gOHB7Om0LcR5zmoKsiKf7WuTvqm/XC5HvLsOXpNzFKflCPF
         X9J9cTa7m+kNUWdtQgNJxDbcQZWfuK01bU8JvEuGciYFA9ITpkXVQ3xsdDQ/OqTPCIES
         czzxe/KzikFX6yOtfYSZHlr2iPMESshDoFY7XPH10v7WfYN+SVb6HTgP0dkE+wWtQ7ds
         skd4t3d0VbPTQRqMqPb+JbxS6ma22pTAe5t9fBJ13U1WJEm27Xi7Z6gcHkg7txxQ6lG1
         jibA==
X-Gm-Message-State: AOAM530sGLdYZ2RTMLW15UIC7W6VExpAAZyeFFzkdBr8Y6p5P/KR3r6q
        hSAK6bAIVo/j7uDWl++uFUtIwemqcPk=
X-Google-Smtp-Source: ABdhPJxHRY4OBGREbkOnuB7bjpNabJlG4/6RoDaVFn5Y5BgqCwSKYQQBaZu4ESCJPPRaVWshLqRXDg==
X-Received: by 2002:a37:aec2:: with SMTP id x185mr10249359qke.64.1607616451795;
        Thu, 10 Dec 2020 08:07:31 -0800 (PST)
Received: from localhost.localdomain (cpe-71-65-111-223.cinci.res.rr.com. [71.65.111.223])
        by smtp.googlemail.com with ESMTPSA id d190sm3852290qkf.112.2020.12.10.08.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 08:07:31 -0800 (PST)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] ALSA: hda/ca0132 - Ensure DSP is properly setup post-firmware download.
Date:   Thu, 10 Dec 2020 11:06:56 -0500
Message-Id: <20201210160658.461739-5-conmanx360@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201210160658.461739-1-conmanx360@gmail.com>
References: <20201210160658.461739-1-conmanx360@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make sure that the DSP has no DMA channels allocated once the firmware
is downloaded, and that the default audio streams in use by the DSP are
setup in the correct order.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 119 +++++++++++++++++++++++++++++++++++
 1 file changed, 119 insertions(+)

v2 changes:
-Remove conditional mutex.

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index f84815cc8d2f..8884ad0910cd 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -1863,6 +1863,18 @@ static void chipio_set_stream_control(struct hda_codec *codec,
 			CONTROL_PARAM_STREAM_CONTROL, enable);
 }
 
+/*
+ * Get ChipIO audio stream's status.
+ */
+static void chipio_get_stream_control(struct hda_codec *codec,
+				int streamid, unsigned int *enable)
+{
+	chipio_set_control_param_no_mutex(codec,
+			CONTROL_PARAM_STREAM_ID, streamid);
+	*enable = snd_hda_codec_read(codec, WIDGET_CHIP_CTRL, 0,
+			   VENDOR_CHIPIO_PARAM_GET,
+			   CONTROL_PARAM_STREAM_CONTROL);
+}
 
 /*
  * Set sampling rate of the connection point. NO MUTEX.
@@ -7513,6 +7525,109 @@ static void ca0132_refresh_widget_caps(struct hda_codec *codec)
 	}
 }
 
+
+/* If there is an active channel for some reason, find it and free it. */
+static void ca0132_alt_free_active_dma_channels(struct hda_codec *codec)
+{
+	unsigned int i, tmp;
+	int status;
+
+	/* Read active DSPDMAC channel register. */
+	status = chipio_read(codec, DSPDMAC_CHNLSTART_MODULE_OFFSET, &tmp);
+	if (status >= 0) {
+		/* AND against 0xfff to get the active channel bits. */
+		tmp = tmp & 0xfff;
+
+		/* If there are no active channels, nothing to free. */
+		if (!tmp)
+			return;
+	} else {
+		codec_dbg(codec, "%s: Failed to read active DSP DMA channel register.\n",
+				__func__);
+		return;
+	}
+
+	/*
+	 * Check each DSP DMA channel for activity, and if the channel is
+	 * active, free it.
+	 */
+	for (i = 0; i < DSPDMAC_DMA_CFG_CHANNEL_COUNT; i++) {
+		if (dsp_is_dma_active(codec, i)) {
+			status = dspio_free_dma_chan(codec, i);
+			if (status < 0)
+				codec_dbg(codec, "%s: Failed to free active DSP DMA channel %d.\n",
+						__func__, i);
+		}
+	}
+}
+
+/*
+ * In the case of CT_EXTENSIONS_ENABLE being set to 1, and the DSP being in
+ * use, audio is no longer routed directly to the DAC/ADC from the HDA stream.
+ * Instead, audio is now routed through the DSP's DMA controllers, which
+ * the DSP is tasked with setting up itself. Through debugging, it seems the
+ * cause of most of the no-audio on startup issues were due to improperly
+ * configured DSP DMA channels.
+ *
+ * Normally, the DSP configures these the first time an HDA audio stream is
+ * started post DSP firmware download. That is why creating a 'dummy' stream
+ * worked in fixing the audio in some cases. This works most of the time, but
+ * sometimes if a stream is started/stopped before the DSP can setup the DMA
+ * configuration registers, it ends up in a broken state. Issues can also
+ * arise if streams are started in an unusual order, i.e the audio output dma
+ * channel being sandwiched between the mic1 and mic2 dma channels.
+ *
+ * The solution to this is to make sure that the DSP has no DMA channels
+ * in use post DSP firmware download, and then to manually start each default
+ * DSP stream that uses the DMA channels. These are 0x0c, the audio output
+ * stream, 0x03, analog mic 1, and 0x04, analog mic 2.
+ */
+static void ca0132_alt_start_dsp_audio_streams(struct hda_codec *codec)
+{
+	const unsigned int dsp_dma_stream_ids[] = { 0x0c, 0x03, 0x04 };
+	struct ca0132_spec *spec = codec->spec;
+	unsigned int i, tmp;
+
+	/*
+	 * Check if any of the default streams are active, and if they are,
+	 * stop them.
+	 */
+	mutex_lock(&spec->chipio_mutex);
+
+	for (i = 0; i < ARRAY_SIZE(dsp_dma_stream_ids); i++) {
+		chipio_get_stream_control(codec, dsp_dma_stream_ids[i], &tmp);
+
+		if (tmp) {
+			chipio_set_stream_control(codec,
+					dsp_dma_stream_ids[i], 0);
+		}
+	}
+
+	mutex_unlock(&spec->chipio_mutex);
+
+	/*
+	 * If all DSP streams are inactive, there should be no active DSP DMA
+	 * channels. Check and make sure this is the case, and if it isn't,
+	 * free any active channels.
+	 */
+	ca0132_alt_free_active_dma_channels(codec);
+
+	mutex_lock(&spec->chipio_mutex);
+
+	/* Make sure stream 0x0c is six channels. */
+	chipio_set_stream_channels(codec, 0x0c, 6);
+
+	for (i = 0; i < ARRAY_SIZE(dsp_dma_stream_ids); i++) {
+		chipio_set_stream_control(codec,
+				dsp_dma_stream_ids[i], 1);
+
+		/* Give the DSP some time to setup the DMA channel. */
+		msleep(75);
+	}
+
+	mutex_unlock(&spec->chipio_mutex);
+}
+
 /*
  * The region of ChipIO memory from 0x190000-0x1903fc is a sort of 'audio
  * router', where each entry represents a 48khz audio channel, with a format
@@ -8250,6 +8365,7 @@ static void r3d_setup_defaults(struct hda_codec *codec)
 
 	ca0132_alt_dsp_scp_startup(codec);
 	ca0132_alt_init_analog_mics(codec);
+	ca0132_alt_start_dsp_audio_streams(codec);
 
 	/*remove DSP headroom*/
 	tmp = FLOAT_ZERO;
@@ -8300,6 +8416,7 @@ static void sbz_setup_defaults(struct hda_codec *codec)
 
 	ca0132_alt_dsp_scp_startup(codec);
 	ca0132_alt_init_analog_mics(codec);
+	ca0132_alt_start_dsp_audio_streams(codec);
 	sbz_connect_streams(codec);
 	sbz_chipio_startup_data(codec);
 
@@ -8359,6 +8476,7 @@ static void ae5_setup_defaults(struct hda_codec *codec)
 
 	ca0132_alt_dsp_scp_startup(codec);
 	ca0132_alt_init_analog_mics(codec);
+	ca0132_alt_start_dsp_audio_streams(codec);
 	chipio_set_stream_control(codec, 0x03, 1);
 	chipio_set_stream_control(codec, 0x04, 1);
 
@@ -8428,6 +8546,7 @@ static void ae7_setup_defaults(struct hda_codec *codec)
 
 	ca0132_alt_dsp_scp_startup(codec);
 	ca0132_alt_init_analog_mics(codec);
+	ca0132_alt_start_dsp_audio_streams(codec);
 	ae7_post_dsp_setup_ports(codec);
 
 	tmp = FLOAT_ZERO;
-- 
2.25.1

