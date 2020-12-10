Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE4732D617E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 17:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392303AbgLJQK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 11:10:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392335AbgLJQHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 11:07:50 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00EACC061794
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 08:07:35 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id j26so3885702qtq.8
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 08:07:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sKdNFHIaOGHzemSXJ4fYnvyA7QI5pQyJsgsZg/WlZU8=;
        b=kPhh1k9RGQVw2nO38xkVOkwR/De1KOKnP+eCLe74yxRR6yA8+dGeGdUv/5lHWit/xq
         hc4MYYTiy25Jg9nprHcusjK6o+Ry13V6VxmHRC3LWNSy0nk/4Oa6Z+59spbrzxuCjz0G
         QitlL/rJwBRDdzhwYiOvEKmAyLIfYob+sXa0LqUOpu9h+jkjimy31b+Bx8DCnAbXNDSu
         UHSaA1ZVdDnaOgdhHjT88GakQegAhfpGxHqJjbKLOWu5WzLyQt5g4Nvm2IB9Yd1F4mey
         lGjULS4YXMISpc9p4wWffV3BtmOj9HpGJQ+WY2GgUr3rk596ZonYKW0uo0fLx3xPWMQA
         lnrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sKdNFHIaOGHzemSXJ4fYnvyA7QI5pQyJsgsZg/WlZU8=;
        b=llfQZLY/iTY8jps4BLAEFv2T9GaLSpm33W/b574tXrfbiRxWS/rwazsECZe8Hy2Exh
         5w+kdpzKTcwTVHyKW3O6RwsX7MM1+XNJPpbl0dy5u2LY/Wk7Xvq32DF/00hKArisTBZX
         yMWWGGFeMEK9ZPx/JAkKSdhwa4OCXygYOexVZyNktJJ2Py1ysd3dsRmUZKbPB0mIJ7xk
         mhNefwgKS224NTbA1l/+fRHWRxa0bOo2/lwBAtT3G6GywT0QZ0w5HXR2iZLZWhRcyNTd
         C1IuIml9b1ejGiH8cXp3VhEi7whzCQN1Q0bRA99kJT02/NLcOn8ctD4s4ghak7MpShM5
         ly7A==
X-Gm-Message-State: AOAM5317gM7B81foIIcagi8+sB5tYbA1eHczbWjW2cbuYebqEbSNBRNc
        4ObTZ4Jpc27a+mL5Q1iKGqI=
X-Google-Smtp-Source: ABdhPJyD5Sr0PTnzWNkhnU3yKvolIcUB/EkRkxa//Z39Ut5HYtd2yLd8sNecVMYs8eXqtrZW/j27rA==
X-Received: by 2002:aed:3051:: with SMTP id 75mr9959479qte.64.1607616454186;
        Thu, 10 Dec 2020 08:07:34 -0800 (PST)
Received: from localhost.localdomain (cpe-71-65-111-223.cinci.res.rr.com. [71.65.111.223])
        by smtp.googlemail.com with ESMTPSA id d190sm3852290qkf.112.2020.12.10.08.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 08:07:33 -0800 (PST)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] ALSA: hda/ca0132 - Remove now unnecessary DSP setup functions.
Date:   Thu, 10 Dec 2020 11:06:57 -0500
Message-Id: <20201210160658.461739-6-conmanx360@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201210160658.461739-1-conmanx360@gmail.com>
References: <20201210160658.461739-1-conmanx360@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the DSP's audio configuration is understood, remove previous
hacky methods of trying to properly configure it.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 105 -----------------------------------
 1 file changed, 105 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 8884ad0910cd..df8bee4eef26 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -2426,13 +2426,6 @@ static int dspio_set_uint_param(struct hda_codec *codec, int mod_id,
 			sizeof(unsigned int));
 }
 
-static int dspio_set_uint_param_no_source(struct hda_codec *codec, int mod_id,
-			int req, const unsigned int data)
-{
-	return dspio_set_param(codec, mod_id, 0x00, req, &data,
-			sizeof(unsigned int));
-}
-
 /*
  * Allocate a DSP DMA channel via an SCP message
  */
@@ -7780,24 +7773,6 @@ static void ca0132_alt_init_speaker_tuning(struct hda_codec *codec)
 				SPEAKER_TUNING_FRONT_LEFT_DELAY + i, values[i]);
 }
 
-/*
- * Creates a dummy stream to bind the output to. This seems to have to be done
- * after changing the main outputs source and destination streams.
- */
-static void ca0132_alt_create_dummy_stream(struct hda_codec *codec)
-{
-	struct ca0132_spec *spec = codec->spec;
-	unsigned int stream_format;
-
-	stream_format = snd_hdac_calc_stream_format(48000, 2,
-			SNDRV_PCM_FORMAT_S32_LE, 32, 0);
-
-	snd_hda_codec_setup_stream(codec, spec->dacs[0], spec->dsp_stream_id,
-					0, stream_format);
-
-	snd_hda_codec_cleanup_stream(codec, spec->dacs[0]);
-}
-
 /*
  * Initialize mic for non-chromebook ca0132 implementations.
  */
@@ -7839,9 +7814,6 @@ static void sbz_connect_streams(struct hda_codec *codec)
 
 	codec_dbg(codec, "Connect Streams entered, mutex locked and loaded.\n");
 
-	chipio_set_stream_channels(codec, 0x0C, 6);
-	chipio_set_stream_control(codec, 0x0C, 1);
-
 	/* This value is 0x43 for 96khz, and 0x83 for 192khz. */
 	chipio_write_no_mutex(codec, 0x18a020, 0x00000043);
 
@@ -7889,9 +7861,6 @@ static void sbz_chipio_startup_data(struct hda_codec *codec)
 		break;
 	}
 
-	chipio_set_stream_channels(codec, 0x0c, 6);
-	chipio_set_stream_control(codec, 0x0c, 1);
-
 	if (dsp_out_remap_data)
 		chipio_remap_stream(codec, dsp_out_remap_data);
 
@@ -7899,57 +7868,6 @@ static void sbz_chipio_startup_data(struct hda_codec *codec)
 	mutex_unlock(&spec->chipio_mutex);
 }
 
-/*
- * Custom DSP SCP commands where the src value is 0x00 instead of 0x20. This is
- * done after the DSP is loaded.
- */
-static void ca0132_alt_dsp_scp_startup(struct hda_codec *codec)
-{
-	struct ca0132_spec *spec = codec->spec;
-	unsigned int tmp, i;
-
-	/*
-	 * Gotta run these twice, or else mic works inconsistently. Not clear
-	 * why this is, but multiple tests have confirmed it.
-	 */
-	for (i = 0; i < 2; i++) {
-		switch (ca0132_quirk(spec)) {
-		case QUIRK_SBZ:
-		case QUIRK_AE5:
-		case QUIRK_AE7:
-			tmp = 0x00000003;
-			dspio_set_uint_param_no_source(codec, 0x80, 0x0C, tmp);
-			tmp = 0x00000000;
-			dspio_set_uint_param_no_source(codec, 0x80, 0x0A, tmp);
-			tmp = 0x00000001;
-			dspio_set_uint_param_no_source(codec, 0x80, 0x0B, tmp);
-			tmp = 0x00000004;
-			dspio_set_uint_param_no_source(codec, 0x80, 0x0C, tmp);
-			tmp = 0x00000005;
-			dspio_set_uint_param_no_source(codec, 0x80, 0x0C, tmp);
-			tmp = 0x00000000;
-			dspio_set_uint_param_no_source(codec, 0x80, 0x0C, tmp);
-			break;
-		case QUIRK_R3D:
-		case QUIRK_R3DI:
-			tmp = 0x00000000;
-			dspio_set_uint_param_no_source(codec, 0x80, 0x0A, tmp);
-			tmp = 0x00000001;
-			dspio_set_uint_param_no_source(codec, 0x80, 0x0B, tmp);
-			tmp = 0x00000004;
-			dspio_set_uint_param_no_source(codec, 0x80, 0x0C, tmp);
-			tmp = 0x00000005;
-			dspio_set_uint_param_no_source(codec, 0x80, 0x0C, tmp);
-			tmp = 0x00000000;
-			dspio_set_uint_param_no_source(codec, 0x80, 0x0C, tmp);
-			break;
-		default:
-			break;
-		}
-		msleep(100);
-	}
-}
-
 static void ca0132_alt_dsp_initial_mic_setup(struct hda_codec *codec)
 {
 	struct ca0132_spec *spec = codec->spec;
@@ -8067,9 +7985,6 @@ static void ae5_post_dsp_stream_setup(struct hda_codec *codec)
 
 	chipio_set_conn_rate_no_mutex(codec, 0x70, SR_96_000);
 
-	chipio_set_stream_channels(codec, 0x0C, 6);
-	chipio_set_stream_control(codec, 0x0C, 1);
-
 	chipio_set_stream_source_dest(codec, 0x5, 0x43, 0x0);
 
 	chipio_set_stream_source_dest(codec, 0x18, 0x9, 0xd0);
@@ -8127,9 +8042,6 @@ static void ae7_post_dsp_setup_ports(struct hda_codec *codec)
 
 	mutex_lock(&spec->chipio_mutex);
 
-	chipio_set_stream_channels(codec, 0x0c, 6);
-	chipio_set_stream_control(codec, 0x0c, 1);
-
 	/* Seems to share the same port remapping as the SBZ. */
 	chipio_remap_stream(codec, &stream_remap_data[1]);
 
@@ -8155,8 +8067,6 @@ static void ae7_post_dsp_asi_stream_setup(struct hda_codec *codec)
 	ca0113_mmio_command_set(codec, 0x30, 0x2b, 0x00);
 
 	chipio_set_conn_rate_no_mutex(codec, 0x70, SR_96_000);
-	chipio_set_stream_channels(codec, 0x0c, 6);
-	chipio_set_stream_control(codec, 0x0c, 1);
 
 	chipio_set_stream_source_dest(codec, 0x05, 0x43, 0x00);
 	chipio_set_stream_source_dest(codec, 0x18, 0x09, 0xd0);
@@ -8363,7 +8273,6 @@ static void r3d_setup_defaults(struct hda_codec *codec)
 	if (spec->dsp_state != DSP_DOWNLOADED)
 		return;
 
-	ca0132_alt_dsp_scp_startup(codec);
 	ca0132_alt_init_analog_mics(codec);
 	ca0132_alt_start_dsp_audio_streams(codec);
 
@@ -8414,15 +8323,11 @@ static void sbz_setup_defaults(struct hda_codec *codec)
 	if (spec->dsp_state != DSP_DOWNLOADED)
 		return;
 
-	ca0132_alt_dsp_scp_startup(codec);
 	ca0132_alt_init_analog_mics(codec);
 	ca0132_alt_start_dsp_audio_streams(codec);
 	sbz_connect_streams(codec);
 	sbz_chipio_startup_data(codec);
 
-	chipio_set_stream_control(codec, 0x03, 1);
-	chipio_set_stream_control(codec, 0x04, 1);
-
 	/*
 	 * Sets internal input loopback to off, used to have a switch to
 	 * enable input loopback, but turned out to be way too buggy.
@@ -8457,8 +8362,6 @@ static void sbz_setup_defaults(struct hda_codec *codec)
 	}
 
 	ca0132_alt_init_speaker_tuning(codec);
-
-	ca0132_alt_create_dummy_stream(codec);
 }
 
 /*
@@ -8474,11 +8377,8 @@ static void ae5_setup_defaults(struct hda_codec *codec)
 	if (spec->dsp_state != DSP_DOWNLOADED)
 		return;
 
-	ca0132_alt_dsp_scp_startup(codec);
 	ca0132_alt_init_analog_mics(codec);
 	ca0132_alt_start_dsp_audio_streams(codec);
-	chipio_set_stream_control(codec, 0x03, 1);
-	chipio_set_stream_control(codec, 0x04, 1);
 
 	/* New, unknown SCP req's */
 	tmp = FLOAT_ZERO;
@@ -8527,8 +8427,6 @@ static void ae5_setup_defaults(struct hda_codec *codec)
 	}
 
 	ca0132_alt_init_speaker_tuning(codec);
-
-	ca0132_alt_create_dummy_stream(codec);
 }
 
 /*
@@ -8544,7 +8442,6 @@ static void ae7_setup_defaults(struct hda_codec *codec)
 	if (spec->dsp_state != DSP_DOWNLOADED)
 		return;
 
-	ca0132_alt_dsp_scp_startup(codec);
 	ca0132_alt_init_analog_mics(codec);
 	ca0132_alt_start_dsp_audio_streams(codec);
 	ae7_post_dsp_setup_ports(codec);
@@ -8613,8 +8510,6 @@ static void ae7_setup_defaults(struct hda_codec *codec)
 	}
 
 	ca0132_alt_init_speaker_tuning(codec);
-
-	ca0132_alt_create_dummy_stream(codec);
 }
 
 /*
-- 
2.25.1

