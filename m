Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E93AA2D613B
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 17:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392222AbgLJQJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 11:09:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403826AbgLJQII (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 11:08:08 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB32C061257
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 08:07:28 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id y18so5217426qki.11
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 08:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2oxYtLvh9Yue0U2KPaThGLnKUpw3c+yg4zRy4/rBMX8=;
        b=Zyb/5DHbjrR7Ch7/7OaBwqNiElg3vUwd2JpgIltykl27Md56C6oF/JPPPYo8H9t0qg
         2g2Rdc2s8GiKVctNIu/2ZvU9q0+ridF8XSKrCu+XYYiXkeOthJWp0fmra+WLhqgKiLq/
         ePMql1cEe4pyu46irDV9reiEcwZ3f4Aj+Yd64JyvVTMQ1J+Ff8BMC2i/mPzrC4Fugopm
         yKoaXMBBVaUqda58oOgkM+3xxUqkm7n8ckfgj8jbt4O4DY8Bq52fQ7FkZ2MIPeNKWQmc
         yRmrMkIoNxnVFyj5HioVRe2cAjpPZbbWnDHkTLiHdpQpcTC1Sai53saohsj5i1DSZCmM
         VyAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2oxYtLvh9Yue0U2KPaThGLnKUpw3c+yg4zRy4/rBMX8=;
        b=DUc6nYbJdIxD/MnP8un0tahoGYpzO1lKr9W9drHtxRQqyWnzL50gqSUgK2nSZg7HK5
         6hy3xMVRPDR5apDD+4oq2Eg3KFUc6Pbnc9/hyjwSm2twRi1iSxhO42Lx0vUmjCEnsFHa
         GbxfSvICxL/onmGh02iNvQYO1TMuMl4w2QjFpKOAAPbDOrNJ3/wW0sbG6RLMONuJ5s8o
         jql5EJOky7tg8+o3RJ4paOgypTZ0fuhpFaOpAEfoYI93xaIi0frX6Uvd/XCnAwZT0/mf
         6TlDk4HY8m+N1X4KLdxVAh0aAzfF5F4r9ojIlYCsAYP6teqRr9YYJinbVT6r9pbHgKMJ
         Jmyg==
X-Gm-Message-State: AOAM531Kwf/wAgl9AjWpzP6s+3jH06MHzNAYz8up4vvTOjki+KB9D7v1
        ntzGhE5ormOqp3eHeUxJUIk=
X-Google-Smtp-Source: ABdhPJxddCr4bSAa3u5FbtvZhI2Vx5MUW0HXnCcEFp3E9sbGUNPCC6lBTig95GvK+hyHfnlWZhWNGw==
X-Received: by 2002:a37:a917:: with SMTP id s23mr9850874qke.214.1607616447306;
        Thu, 10 Dec 2020 08:07:27 -0800 (PST)
Received: from localhost.localdomain (cpe-71-65-111-223.cinci.res.rr.com. [71.65.111.223])
        by smtp.googlemail.com with ESMTPSA id d190sm3852290qkf.112.2020.12.10.08.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 08:07:26 -0800 (PST)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] ALSA: hda/ca0132 - Add stream port remapping function.
Date:   Thu, 10 Dec 2020 11:06:54 -0500
Message-Id: <20201210160658.461739-3-conmanx360@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201210160658.461739-1-conmanx360@gmail.com>
References: <20201210160658.461739-1-conmanx360@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add function for remapping a ChipIO stream's ports. Also include some
documentation as to how this works.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 208 ++++++++++++++++++++++++++---------
 1 file changed, 156 insertions(+), 52 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 7ce4a966b733..8d2f12f2ce3f 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -788,6 +788,40 @@ static const struct ae5_filter_set ae5_filter_presets[] = {
 	}
 };
 
+/*
+ * Data structures for storing audio router remapping data. These are used to
+ * remap a currently active streams ports.
+ */
+struct chipio_stream_remap_data {
+	unsigned int stream_id;
+	unsigned int count;
+
+	unsigned int offset[16];
+	unsigned int value[16];
+};
+
+static const struct chipio_stream_remap_data stream_remap_data[] = {
+	{ .stream_id = 0x14,
+	  .count     = 0x04,
+	  .offset    = { 0x00, 0x04, 0x08, 0x0c },
+	  .value     = { 0x0001f8c0, 0x0001f9c1, 0x0001fac6, 0x0001fbc7 },
+	},
+	{ .stream_id = 0x0c,
+	  .count     = 0x0c,
+	  .offset    = { 0x00, 0x04, 0x08, 0x0c, 0x10, 0x14, 0x18, 0x1c,
+			 0x20, 0x24, 0x28, 0x2c },
+	  .value     = { 0x0001e0c0, 0x0001e1c1, 0x0001e4c2, 0x0001e5c3,
+			 0x0001e2c4, 0x0001e3c5, 0x0001e8c6, 0x0001e9c7,
+			 0x0001ecc8, 0x0001edc9, 0x0001eaca, 0x0001ebcb },
+	},
+	{ .stream_id = 0x0c,
+	  .count     = 0x08,
+	  .offset    = { 0x08, 0x0c, 0x10, 0x14, 0x20, 0x24, 0x28, 0x2c },
+	  .value     = { 0x000140c2, 0x000141c3, 0x000150c4, 0x000151c5,
+			 0x000142c8, 0x000143c9, 0x000152ca, 0x000153cb },
+	}
+};
+
 enum hda_cmd_vendor_io {
 	/* for DspIO node */
 	VENDOR_DSPIO_SCP_WRITE_DATA_LOW      = 0x000,
@@ -7423,6 +7457,104 @@ static void ca0132_refresh_widget_caps(struct hda_codec *codec)
 	}
 }
 
+/*
+ * The region of ChipIO memory from 0x190000-0x1903fc is a sort of 'audio
+ * router', where each entry represents a 48khz audio channel, with a format
+ * of an 8-bit destination, an 8-bit source, and an unknown 2-bit number
+ * value. The 2-bit number value is seemingly 0 if inactive, 1 if active,
+ * and 3 if it's using Sample Rate Converter ports.
+ * An example is:
+ * 0x0001f8c0
+ * In this case, f8 is the destination, and c0 is the source. The number value
+ * is 1.
+ * This region of memory is normally managed internally by the 8051, where
+ * the region of exram memory from 0x1477-0x1575 has each byte represent an
+ * entry within the 0x190000 range, and when a range of entries is in use, the
+ * ending value is overwritten with 0xff.
+ * 0x1578 in exram is a table of 0x25 entries, corresponding to the ChipIO
+ * streamID's, where each entry is a starting 0x190000 port offset.
+ * 0x159d in exram is the same as 0x1578, except it contains the ending port
+ * offset for the corresponding streamID.
+ *
+ * On certain cards, such as the SBZ/ZxR/AE7, these are originally setup by
+ * the 8051, then manually overwritten to remap the ports to work with the
+ * new DACs.
+ *
+ * Currently known portID's:
+ * 0x00-0x1f: HDA audio stream input/output ports.
+ * 0x80-0xbf: Sample rate converter input/outputs. Only valid ports seem to
+ *            have the lower-nibble set to 0x1, 0x2, and 0x9.
+ * 0xc0-0xdf: DSP DMA input/output ports. Dynamically assigned.
+ * 0xe0-0xff: DAC/ADC audio input/output ports.
+ *
+ * Currently known streamID's:
+ * 0x03: Mic1 ADC to DSP.
+ * 0x04: Mic2 ADC to DSP.
+ * 0x05: HDA node 0x02 audio stream to DSP.
+ * 0x0f: DSP Mic exit to HDA node 0x07.
+ * 0x0c: DSP processed audio to DACs.
+ * 0x14: DAC0, front L/R.
+ *
+ * It is possible to route the HDA audio streams directly to the DAC and
+ * bypass the DSP entirely, with the only downside being that since the DSP
+ * does volume control, the only volume control you'll get is through PCM on
+ * the PC side, in the same way volume is handled for optical out. This may be
+ * useful for debugging.
+ */
+static void chipio_remap_stream(struct hda_codec *codec,
+		const struct chipio_stream_remap_data *remap_data)
+{
+	unsigned int i, stream_offset, tmp;
+
+	/* Get the starting port for the stream to be remapped. */
+	tmp = 0x1578 + remap_data->stream_id;
+	for (i = 0; i < 2; i++) {
+		snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
+				    VENDOR_CHIPIO_8051_ADDRESS_LOW + i,
+				    ((tmp >> (i * 8)) & 0xff));
+	}
+
+	stream_offset = snd_hda_codec_read(codec, WIDGET_CHIP_CTRL, 0,
+				   VENDOR_CHIPIO_8051_DATA_READ, 0);
+
+	/*
+	 * Check if the stream's port value is 0xff, because the 8051 may not
+	 * have gotten around to setting up the stream yet. Wait until it's
+	 * setup to remap it's ports.
+	 */
+	if (stream_offset == 0xff) {
+		for (i = 0; i < 5; i++) {
+			msleep(25);
+
+			stream_offset = snd_hda_codec_read(codec,
+					WIDGET_CHIP_CTRL, 0,
+					VENDOR_CHIPIO_8051_DATA_READ, 0);
+
+			if (stream_offset != 0xff)
+				break;
+		}
+	}
+
+	if (stream_offset == 0xff) {
+		codec_info(codec, "%s: Stream 0x%02x ports aren't allocated, remap failed!\n",
+				__func__, remap_data->stream_id);
+		return;
+	}
+
+	/* Offset isn't in bytes, its in 32-bit words, so multiply it by 4. */
+	stream_offset *= 0x04;
+	stream_offset += 0x190000;
+
+	for (i = 0; i < remap_data->count; i++) {
+		chipio_write_no_mutex(codec,
+				stream_offset + remap_data->offset[i],
+				remap_data->value[i]);
+	}
+
+	/* Update stream map configuration. */
+	chipio_write_no_mutex(codec, 0x19042c, 0x00000001);
+}
+
 /*
  * Default speaker tuning values setup for alternative codecs.
  */
@@ -7570,46 +7702,35 @@ static void sbz_connect_streams(struct hda_codec *codec)
  */
 static void sbz_chipio_startup_data(struct hda_codec *codec)
 {
+	const struct chipio_stream_remap_data *dsp_out_remap_data;
 	struct ca0132_spec *spec = codec->spec;
 
 	mutex_lock(&spec->chipio_mutex);
 	codec_dbg(codec, "Startup Data entered, mutex locked and loaded.\n");
 
-	/* These control audio output */
-	chipio_write_no_mutex(codec, 0x190060, 0x0001f8c0);
-	chipio_write_no_mutex(codec, 0x190064, 0x0001f9c1);
-	chipio_write_no_mutex(codec, 0x190068, 0x0001fac6);
-	chipio_write_no_mutex(codec, 0x19006c, 0x0001fbc7);
-	/* Signal to update I think */
-	chipio_write_no_mutex(codec, 0x19042c, 0x00000001);
+	/* Remap DAC0's output ports. */
+	chipio_remap_stream(codec, &stream_remap_data[0]);
 
-	chipio_set_stream_channels(codec, 0x0C, 6);
-	chipio_set_stream_control(codec, 0x0C, 1);
-	/* No clue what these control */
-	if (ca0132_quirk(spec) == QUIRK_SBZ) {
-		chipio_write_no_mutex(codec, 0x190030, 0x0001e0c0);
-		chipio_write_no_mutex(codec, 0x190034, 0x0001e1c1);
-		chipio_write_no_mutex(codec, 0x190038, 0x0001e4c2);
-		chipio_write_no_mutex(codec, 0x19003c, 0x0001e5c3);
-		chipio_write_no_mutex(codec, 0x190040, 0x0001e2c4);
-		chipio_write_no_mutex(codec, 0x190044, 0x0001e3c5);
-		chipio_write_no_mutex(codec, 0x190048, 0x0001e8c6);
-		chipio_write_no_mutex(codec, 0x19004c, 0x0001e9c7);
-		chipio_write_no_mutex(codec, 0x190050, 0x0001ecc8);
-		chipio_write_no_mutex(codec, 0x190054, 0x0001edc9);
-		chipio_write_no_mutex(codec, 0x190058, 0x0001eaca);
-		chipio_write_no_mutex(codec, 0x19005c, 0x0001ebcb);
-	} else if (ca0132_quirk(spec) == QUIRK_ZXR) {
-		chipio_write_no_mutex(codec, 0x190038, 0x000140c2);
-		chipio_write_no_mutex(codec, 0x19003c, 0x000141c3);
-		chipio_write_no_mutex(codec, 0x190040, 0x000150c4);
-		chipio_write_no_mutex(codec, 0x190044, 0x000151c5);
-		chipio_write_no_mutex(codec, 0x190050, 0x000142c8);
-		chipio_write_no_mutex(codec, 0x190054, 0x000143c9);
-		chipio_write_no_mutex(codec, 0x190058, 0x000152ca);
-		chipio_write_no_mutex(codec, 0x19005c, 0x000153cb);
+	/* Remap DSP audio output stream ports. */
+	switch (ca0132_quirk(spec)) {
+	case QUIRK_SBZ:
+		dsp_out_remap_data = &stream_remap_data[1];
+		break;
+
+	case QUIRK_ZXR:
+		dsp_out_remap_data = &stream_remap_data[2];
+		break;
+
+	default:
+		dsp_out_remap_data = NULL;
+		break;
 	}
-	chipio_write_no_mutex(codec, 0x19042c, 0x00000001);
+
+	chipio_set_stream_channels(codec, 0x0c, 6);
+	chipio_set_stream_control(codec, 0x0c, 1);
+
+	if (dsp_out_remap_data)
+		chipio_remap_stream(codec, dsp_out_remap_data);
 
 	codec_dbg(codec, "Startup Data exited, mutex released.\n");
 	mutex_unlock(&spec->chipio_mutex);
@@ -7842,34 +7963,17 @@ static void ae5_post_dsp_startup_data(struct hda_codec *codec)
 	mutex_unlock(&spec->chipio_mutex);
 }
 
-static const unsigned int ae7_port_set_data[] = {
-	0x0001e0c0, 0x0001e1c1, 0x0001e4c2, 0x0001e5c3, 0x0001e2c4, 0x0001e3c5,
-	0x0001e8c6, 0x0001e9c7, 0x0001ecc8, 0x0001edc9, 0x0001eaca, 0x0001ebcb
-};
-
 static void ae7_post_dsp_setup_ports(struct hda_codec *codec)
 {
 	struct ca0132_spec *spec = codec->spec;
-	unsigned int i, count, addr;
 
 	mutex_lock(&spec->chipio_mutex);
 
 	chipio_set_stream_channels(codec, 0x0c, 6);
 	chipio_set_stream_control(codec, 0x0c, 1);
 
-	count = ARRAY_SIZE(ae7_port_set_data);
-	addr = 0x190030;
-	for (i = 0; i < count; i++) {
-		chipio_write_no_mutex(codec, addr, ae7_port_set_data[i]);
-
-		/* Addresses are incremented by 4-bytes. */
-		addr += 0x04;
-	}
-
-	/*
-	 * Port setting always ends with a write of 0x1 to address 0x19042c.
-	 */
-	chipio_write_no_mutex(codec, 0x19042c, 0x00000001);
+	/* Seems to share the same port remapping as the SBZ. */
+	chipio_remap_stream(codec, &stream_remap_data[1]);
 
 	ca0113_mmio_command_set(codec, 0x30, 0x30, 0x00);
 	ca0113_mmio_command_set(codec, 0x48, 0x0d, 0x40);
-- 
2.25.1

