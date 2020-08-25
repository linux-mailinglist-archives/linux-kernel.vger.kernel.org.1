Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2C002521A9
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Aug 2020 22:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727011AbgHYUMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Aug 2020 16:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726873AbgHYULd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 16:11:33 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAAE3C061574
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 13:11:31 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id n129so12306169qkd.6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 13:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OzNi8qBZax1qiFUhCDxFsPNYTIc/CE+8CT0h/LOkdas=;
        b=YQDsVI8NJFehiOOi7PMuhfEgaSR4+Bd7OllFs7oR1DJ5MRSalfRia9Wfq0JXCGS4wN
         K10R8k113BgKZdK49g3FPQKXBF0o04k5TOyrC6Xk577y8DJNQGQdmu1LjwltBIsocI60
         Pb1/1OUMfXHIMc4yhGvd7Oc5o4AiN5+m5V90RV5BgIHL4yXFYaqtS9NIJyrebtSt9DHO
         rLRqmLEocspW6Y3mDIYVYKv62MhS/Pbuy8eNKs2y/PBPw0T2hV29BRV6qWFIw+RNSGnj
         4kmWikr0qiyPvPgHqwtkaa1+JUv3mxlFbRJ2CQ3o3HPZTsVlKwVsYdcP/4qWuz8OjBsh
         5EFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OzNi8qBZax1qiFUhCDxFsPNYTIc/CE+8CT0h/LOkdas=;
        b=iBejD0SxefLCjjqwpDRrb78McbLOGbKbZ0GaPWMwe+EiwxXs2Ar8CxE9FLlX+Ou/hw
         kOy1rgUU1BKT7w8wQV3BvVIZWS+vbEYttHj3pcuRA1m6fJmfNc5cVLdQPnUjwkauzivY
         H6D07r9b3yHzNfjFquS44ILhtawJ0phkTG93V+IlgGnEAtttcz8xOhWRb0AQw4E9S4KM
         DmzqaT2atGppwJqXAhGS9mxMltZRfSsksATfx8eOXUb48IoPUucv2FVa+kiz11EwBU+c
         hytjQZ9Yd1oxMWH0RC1Jy3l7ama/nXk/+uPYvXbmnQS3VZaqWS+fy6XaFyvO+sOC4aDP
         NdTA==
X-Gm-Message-State: AOAM531i8DFvyWyocD8xy5snOKUBNuI1VYZnpFJj5hhYbOR2J2CynRlT
        FeBTQD05rtVLIkHjJt79vonVV8a+Jq0=
X-Google-Smtp-Source: ABdhPJwGqzKNPy1gqwPTELwgOydTXjShpl6fmYqe5ZXCeVpKXjTHQ6uwcY3kzk7aSD4wUy4zyjjSnw==
X-Received: by 2002:a05:620a:48:: with SMTP id t8mr11121508qkt.474.1598386290937;
        Tue, 25 Aug 2020 13:11:30 -0700 (PDT)
Received: from localhost.localdomain (cpe-71-65-111-223.cinci.res.rr.com. [71.65.111.223])
        by smtp.googlemail.com with ESMTPSA id n23sm12453459qkk.105.2020.08.25.13.11.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 13:11:30 -0700 (PDT)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 16/20] ALSA: hda/ca0132 - Add DSP setup functions for AE-7.
Date:   Tue, 25 Aug 2020 16:10:35 -0400
Message-Id: <20200825201040.30339-17-conmanx360@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200825201040.30339-1-conmanx360@gmail.com>
References: <20200825201040.30339-1-conmanx360@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DSP setup functions for the Sound Blaster AE-7 post DSP download.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 290 +++++++++++++++++++++++++++++++++++
 1 file changed, 290 insertions(+)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index dc1eb9bfcc5e..8519119ef7a6 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -7378,6 +7378,7 @@ static void ca0132_alt_init_speaker_tuning(struct hda_codec *codec)
 		values = zxr_default_delay_values;
 		break;
 	case QUIRK_AE5:
+	case QUIRK_AE7:
 		values = ae5_default_delay_values;
 		break;
 	default:
@@ -7551,6 +7552,7 @@ static void ca0132_alt_dsp_scp_startup(struct hda_codec *codec)
 		switch (ca0132_quirk(spec)) {
 		case QUIRK_SBZ:
 		case QUIRK_AE5:
+		case QUIRK_AE7:
 			tmp = 0x00000003;
 			dspio_set_uint_param_no_source(codec, 0x80, 0x0C, tmp);
 			tmp = 0x00000000;
@@ -7760,6 +7762,206 @@ static void ae5_post_dsp_startup_data(struct hda_codec *codec)
 	mutex_unlock(&spec->chipio_mutex);
 }
 
+static const unsigned int ae7_port_set_data[] = {
+	0x0001e0c0, 0x0001e1c1, 0x0001e4c2, 0x0001e5c3, 0x0001e2c4, 0x0001e3c5,
+	0x0001e8c6, 0x0001e9c7, 0x0001ecc8, 0x0001edc9, 0x0001eaca, 0x0001ebcb
+};
+
+static void ae7_post_dsp_setup_ports(struct hda_codec *codec)
+{
+	struct ca0132_spec *spec = codec->spec;
+	unsigned int i, count, addr;
+
+	mutex_lock(&spec->chipio_mutex);
+
+	chipio_set_stream_channels(codec, 0x0c, 6);
+	chipio_set_stream_control(codec, 0x0c, 1);
+
+	count = ARRAY_SIZE(ae7_port_set_data);
+	addr = 0x190030;
+	for (i = 0; i < count; i++) {
+		chipio_write_no_mutex(codec, addr, ae7_port_set_data[i]);
+
+		/* Addresses are incremented by 4-bytes. */
+		addr += 0x04;
+	}
+
+	/*
+	 * Port setting always ends with a write of 0x1 to address 0x19042c.
+	 */
+	chipio_write_no_mutex(codec, 0x19042c, 0x00000001);
+
+	ca0113_mmio_command_set(codec, 0x30, 0x30, 0x00);
+	ca0113_mmio_command_set(codec, 0x48, 0x0d, 0x40);
+	ca0113_mmio_command_set(codec, 0x48, 0x17, 0x00);
+	ca0113_mmio_command_set(codec, 0x48, 0x19, 0x00);
+	ca0113_mmio_command_set(codec, 0x48, 0x11, 0xff);
+	ca0113_mmio_command_set(codec, 0x48, 0x12, 0xff);
+	ca0113_mmio_command_set(codec, 0x48, 0x13, 0xff);
+	ca0113_mmio_command_set(codec, 0x48, 0x14, 0x7f);
+
+	mutex_unlock(&spec->chipio_mutex);
+}
+
+static void ae7_post_dsp_asi_stream_setup(struct hda_codec *codec)
+{
+	struct ca0132_spec *spec = codec->spec;
+
+	mutex_lock(&spec->chipio_mutex);
+
+	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0, 0x725, 0x81);
+	ca0113_mmio_command_set(codec, 0x30, 0x2b, 0x00);
+
+	chipio_set_conn_rate_no_mutex(codec, 0x70, SR_96_000);
+	chipio_set_stream_channels(codec, 0x0c, 6);
+	chipio_set_stream_control(codec, 0x0c, 1);
+
+	chipio_set_stream_source_dest(codec, 0x05, 0x43, 0x00);
+	chipio_set_stream_source_dest(codec, 0x18, 0x09, 0xd0);
+
+	chipio_set_conn_rate_no_mutex(codec, 0xd0, SR_96_000);
+	chipio_set_stream_channels(codec, 0x18, 6);
+	chipio_set_stream_control(codec, 0x18, 1);
+
+	chipio_set_control_param_no_mutex(codec, CONTROL_PARAM_ASI, 4);
+
+	mutex_unlock(&spec->chipio_mutex);
+}
+
+static void ae7_post_dsp_pll_setup(struct hda_codec *codec)
+{
+	const unsigned int addr[] = { 0x41, 0x45, 0x40, 0x43, 0x51 };
+	const unsigned int data[] = { 0xc8, 0xcc, 0xcb, 0xc7, 0x8d };
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(addr); i++) {
+		snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
+				    VENDOR_CHIPIO_8051_ADDRESS_LOW, addr[i]);
+		snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
+				    VENDOR_CHIPIO_PLL_PMU_WRITE, data[i]);
+	}
+}
+
+static void ae7_post_dsp_asi_setup_ports(struct hda_codec *codec)
+{
+	struct ca0132_spec *spec = codec->spec;
+	const unsigned int target[] = { 0x0b, 0x04, 0x06, 0x0a, 0x0c, 0x11,
+					0x12, 0x13, 0x14 };
+	const unsigned int data[]   = { 0x12, 0x00, 0x48, 0x05, 0x5f, 0xff,
+					0xff, 0xff, 0x7f };
+	unsigned int i;
+
+	mutex_lock(&spec->chipio_mutex);
+
+	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
+			    VENDOR_CHIPIO_8051_ADDRESS_LOW, 0x43);
+	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
+			    VENDOR_CHIPIO_PLL_PMU_WRITE, 0xc7);
+
+	chipio_write_no_mutex(codec, 0x189000, 0x0001f101);
+	chipio_write_no_mutex(codec, 0x189004, 0x0001f101);
+	chipio_write_no_mutex(codec, 0x189024, 0x00014004);
+	chipio_write_no_mutex(codec, 0x189028, 0x0002000f);
+
+	ae7_post_dsp_pll_setup(codec);
+	chipio_set_control_param_no_mutex(codec, CONTROL_PARAM_ASI, 7);
+
+	for (i = 0; i < ARRAY_SIZE(target); i++)
+		ca0113_mmio_command_set(codec, 0x48, target[i], data[i]);
+
+	ca0113_mmio_command_set_type2(codec, 0x48, 0x07, 0x83);
+	ca0113_mmio_command_set(codec, 0x48, 0x0f, 0x00);
+	ca0113_mmio_command_set(codec, 0x48, 0x10, 0x00);
+
+	chipio_set_stream_source_dest(codec, 0x21, 0x64, 0x56);
+	chipio_set_stream_channels(codec, 0x21, 2);
+	chipio_set_conn_rate_no_mutex(codec, 0x56, SR_8_000);
+
+	chipio_set_control_param_no_mutex(codec, CONTROL_PARAM_NODE_ID, 0x09);
+	/*
+	 * In the 8051's memory, this param is referred to as 'n2sid', which I
+	 * believe is 'node to streamID'. It seems to be a way to assign a
+	 * stream to a given HDA node.
+	 */
+	chipio_set_control_param_no_mutex(codec, 0x20, 0x21);
+
+	chipio_write_no_mutex(codec, 0x18b038, 0x00000088);
+
+	/*
+	 * Now, at this point on Windows, an actual stream is setup and
+	 * seemingly sends data to the HDA node 0x09, which is the digital
+	 * audio input node. This is left out here, because obviously I don't
+	 * know what data is being sent. Interestingly, the AE-5 seems to go
+	 * through the motions of getting here and never actually takes this
+	 * step, but the AE-7 does.
+	 */
+
+	ca0113_mmio_gpio_set(codec, 0, 1);
+	ca0113_mmio_gpio_set(codec, 1, 1);
+
+	ca0113_mmio_command_set_type2(codec, 0x48, 0x07, 0x83);
+	chipio_write_no_mutex(codec, 0x18b03c, 0x00000000);
+	ca0113_mmio_command_set(codec, 0x48, 0x0f, 0x00);
+	ca0113_mmio_command_set(codec, 0x48, 0x10, 0x00);
+
+	chipio_set_stream_source_dest(codec, 0x05, 0x43, 0x00);
+	chipio_set_stream_source_dest(codec, 0x18, 0x09, 0xd0);
+
+	chipio_set_conn_rate_no_mutex(codec, 0xd0, SR_96_000);
+	chipio_set_stream_channels(codec, 0x18, 6);
+
+	/*
+	 * Runs again, this has been repeated a few times, but I'm just
+	 * following what the Windows driver does.
+	 */
+	ae7_post_dsp_pll_setup(codec);
+	chipio_set_control_param_no_mutex(codec, CONTROL_PARAM_ASI, 7);
+
+	mutex_unlock(&spec->chipio_mutex);
+}
+
+/*
+ * The Windows driver has commands that seem to setup ASI, which I believe to
+ * be some sort of audio serial interface. My current speculation is that it's
+ * related to communicating with the new DAC.
+ */
+static void ae7_post_dsp_asi_setup(struct hda_codec *codec)
+{
+	chipio_8051_write_direct(codec, 0x93, 0x10);
+
+	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
+			    VENDOR_CHIPIO_8051_ADDRESS_LOW, 0x44);
+	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
+			    VENDOR_CHIPIO_PLL_PMU_WRITE, 0xc2);
+
+	ca0113_mmio_command_set_type2(codec, 0x48, 0x07, 0x83);
+	ca0113_mmio_command_set(codec, 0x30, 0x2e, 0x3f);
+
+	chipio_set_control_param(codec, 3, 3);
+	chipio_set_control_flag(codec, CONTROL_FLAG_ASI_96KHZ, 1);
+
+	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0, 0x724, 0x83);
+	chipio_set_control_param(codec, CONTROL_PARAM_ASI, 0);
+	snd_hda_codec_write(codec, 0x17, 0, 0x794, 0x00);
+
+	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
+			    VENDOR_CHIPIO_8051_ADDRESS_LOW, 0x92);
+	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
+			    VENDOR_CHIPIO_8051_ADDRESS_HIGH, 0xfa);
+	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
+			    VENDOR_CHIPIO_8051_DATA_WRITE, 0x22);
+
+	ae7_post_dsp_pll_setup(codec);
+	ae7_post_dsp_asi_stream_setup(codec);
+
+	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
+			    VENDOR_CHIPIO_8051_ADDRESS_LOW, 0x43);
+	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
+			    VENDOR_CHIPIO_PLL_PMU_WRITE, 0xc7);
+
+	ae7_post_dsp_asi_setup_ports(codec);
+}
+
 /*
  * Setup default parameters for DSP
  */
@@ -7983,6 +8185,91 @@ static void ae5_setup_defaults(struct hda_codec *codec)
 	ca0132_alt_create_dummy_stream(codec);
 }
 
+/*
+ * Setup default parameters for the Sound Blaster AE-7 DSP.
+ */
+static void ae7_setup_defaults(struct hda_codec *codec)
+{
+	struct ca0132_spec *spec = codec->spec;
+	unsigned int tmp;
+	int num_fx;
+	int idx, i;
+
+	if (spec->dsp_state != DSP_DOWNLOADED)
+		return;
+
+	ca0132_alt_dsp_scp_startup(codec);
+	ca0132_alt_init_analog_mics(codec);
+	ae7_post_dsp_setup_ports(codec);
+
+	tmp = FLOAT_ZERO;
+	dspio_set_uint_param(codec, 0x96,
+			SPEAKER_TUNING_FRONT_LEFT_INVERT, tmp);
+	dspio_set_uint_param(codec, 0x96,
+			SPEAKER_TUNING_FRONT_RIGHT_INVERT, tmp);
+
+	ca0113_mmio_command_set(codec, 0x30, 0x2e, 0x3f);
+
+	/* New, unknown SCP req's */
+	dspio_set_uint_param(codec, 0x80, 0x0d, tmp);
+	dspio_set_uint_param(codec, 0x80, 0x0e, tmp);
+
+	ca0113_mmio_gpio_set(codec, 0, false);
+
+	/* Internal loopback off */
+	tmp = FLOAT_ONE;
+	dspio_set_uint_param(codec, 0x37, 0x08, tmp);
+	dspio_set_uint_param(codec, 0x37, 0x10, tmp);
+
+	/*remove DSP headroom*/
+	tmp = FLOAT_ZERO;
+	dspio_set_uint_param(codec, 0x96, 0x3C, tmp);
+
+	/* set WUH source */
+	tmp = FLOAT_TWO;
+	dspio_set_uint_param(codec, 0x31, 0x00, tmp);
+	chipio_set_conn_rate(codec, MEM_CONNID_WUH, SR_48_000);
+
+	/* Set speaker source? */
+	dspio_set_uint_param(codec, 0x32, 0x00, tmp);
+	ca0113_mmio_command_set(codec, 0x30, 0x28, 0x00);
+
+	/*
+	 * This is the second time we've called this, but this is seemingly
+	 * what Windows does.
+	 */
+	ca0132_alt_init_analog_mics(codec);
+
+	ae7_post_dsp_asi_setup(codec);
+
+	/*
+	 * Not sure why, but these are both set to 1. They're only set to 0
+	 * upon shutdown.
+	 */
+	ca0113_mmio_gpio_set(codec, 0, true);
+	ca0113_mmio_gpio_set(codec, 1, true);
+
+	/* Volume control related. */
+	ca0113_mmio_command_set(codec, 0x48, 0x0f, 0x04);
+	ca0113_mmio_command_set(codec, 0x48, 0x10, 0x04);
+	ca0113_mmio_command_set_type2(codec, 0x48, 0x07, 0x80);
+
+	/* out, in effects + voicefx */
+	num_fx = OUT_EFFECTS_COUNT + IN_EFFECTS_COUNT + 1;
+	for (idx = 0; idx < num_fx; idx++) {
+		for (i = 0; i <= ca0132_effects[idx].params; i++) {
+			dspio_set_uint_param(codec,
+					ca0132_effects[idx].mid,
+					ca0132_effects[idx].reqs[i],
+					ca0132_effects[idx].def_vals[i]);
+		}
+	}
+
+	ca0132_alt_init_speaker_tuning(codec);
+
+	ca0132_alt_create_dummy_stream(codec);
+}
+
 /*
  * Initialization of flags in chip
  */
@@ -9000,6 +9287,9 @@ static int ca0132_init(struct hda_codec *codec)
 	case QUIRK_AE5:
 		ae5_setup_defaults(codec);
 		break;
+	case QUIRK_AE7:
+		ae7_setup_defaults(codec);
+		break;
 	default:
 		ca0132_setup_defaults(codec);
 		ca0132_init_analog_mic2(codec);
-- 
2.20.1

