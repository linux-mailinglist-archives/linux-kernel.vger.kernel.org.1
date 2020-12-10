Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F23E52D6137
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 17:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403941AbgLJQI2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 11:08:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403833AbgLJQIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 11:08:10 -0500
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52DD0C0611C5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 08:07:30 -0800 (PST)
Received: by mail-qt1-x843.google.com with SMTP id b9so4016691qtr.2
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 08:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LNFp0e1oxBHLLAbT98jciqioJbJK5/HPHacwl39pCE4=;
        b=IxVDdTJOW62Ph/K7eG/YCffUU8ua98VD/E4CYuBqyyVt7m3Voea7EXFrTgosgE/9z4
         /JQLQjl6ZY3G8yXIPrxlg1CgHcptQYV52P84VVy1rdohFoDD3ZSLR9MpHbYrzYQYAikP
         QZYxj0aqMaWGVbQFhXydxf9J5+wzqOgG/MtEvrotEwYvUj4LSoJ7scMf4wjrmpGaogew
         2KMGA1jzgE3Vl4f1MowYPriISWa6iYNB/Ef/UDKvu66dvNgRD2DPa+z6gHpLWQnaTK6K
         FSp+hub37+dJNSNlBKOj+XtS8j0cnq90BypmsLF7F9wbkUNs7cPlxQqBt5hwwSEHnNp2
         cB1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LNFp0e1oxBHLLAbT98jciqioJbJK5/HPHacwl39pCE4=;
        b=L6zXXxsEm5hHq2oiLLB15Id9iPUYURUqqoy69oPw5dve0LIKZ1fsKcoPdOfznHvqkL
         QQ1oRBDp6BHyww/RCGqk8RsJy9N9RAmNz++Q2tk1KalxaXrvMGhf/iClK0VA4ado6oin
         hCOCQaoEXTd2awvxqCcAlpLlfA5ODtb97L4i+D+2kTv48TJ2rH1Djxv4ldQZjP1jAu+K
         llA6iqmh6geSO8N5wMvXw9ac/fNryGe2CRC88oO+iHCz68eK2RXeRFc6cjbsMrL5Sfu1
         njoc+d5VcT7O9yeS/32DamqHn3DF2EO9KgEoc8Ts42r8Ud+8BXhWdfwhvDHmyibanT4b
         GSrg==
X-Gm-Message-State: AOAM531pALJc8jydNQxOM+DtObFc6Af/wFs7oHLV+2jvO8gq1Zy1/NBX
        Cm0fe4NtpI0K10opTMR6CG/OnM2yHcw=
X-Google-Smtp-Source: ABdhPJw+IGq515hstY9rhetdhZePZmALzlL0Q61eB2u/VgWWVO75b1vkxRAlVIEb95nZKaa7z7rD6Q==
X-Received: by 2002:a05:622a:109:: with SMTP id u9mr9773412qtw.213.1607616449508;
        Thu, 10 Dec 2020 08:07:29 -0800 (PST)
Received: from localhost.localdomain (cpe-71-65-111-223.cinci.res.rr.com. [71.65.111.223])
        by smtp.googlemail.com with ESMTPSA id d190sm3852290qkf.112.2020.12.10.08.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 08:07:29 -0800 (PST)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] ALSA: hda/ca0132 - Add 8051 exram helper functions.
Date:   Thu, 10 Dec 2020 11:06:55 -0500
Message-Id: <20201210160658.461739-4-conmanx360@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201210160658.461739-1-conmanx360@gmail.com>
References: <20201210160658.461739-1-conmanx360@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add functions for both reading and writing to the 8051's exram. Also,
add a little bit of documentation on how the addresses are segmented.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 137 ++++++++++++++++++++---------------
 1 file changed, 79 insertions(+), 58 deletions(-)

v2 changes:
-Remove conditional mutex.

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 8d2f12f2ce3f..f84815cc8d2f 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -1901,6 +1901,70 @@ static void chipio_8051_write_direct(struct hda_codec *codec,
 	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0, verb, addr);
 }
 
+/*
+ * Writes to the 8051's exram, which has 16-bits of address space.
+ * Data at addresses 0x2000-0x7fff is mirrored to 0x8000-0xdfff.
+ * Data at 0x8000-0xdfff can also be used as program memory for the 8051 by
+ * setting the pmem bank selection SFR.
+ * 0xe000-0xffff is always mapped as program memory, with only 0xf000-0xffff
+ * being writable.
+ */
+static void chipio_8051_set_address(struct hda_codec *codec, unsigned int addr)
+{
+	unsigned int tmp;
+
+	/* Lower 8-bits. */
+	tmp = addr & 0xff;
+	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
+			    VENDOR_CHIPIO_8051_ADDRESS_LOW, tmp);
+
+	/* Upper 8-bits. */
+	tmp = (addr >> 8) & 0xff;
+	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
+			    VENDOR_CHIPIO_8051_ADDRESS_HIGH, tmp);
+}
+
+static void chipio_8051_set_data(struct hda_codec *codec, unsigned int data)
+{
+	/* 8-bits of data. */
+	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
+			    VENDOR_CHIPIO_8051_DATA_WRITE, data & 0xff);
+}
+
+static unsigned int chipio_8051_get_data(struct hda_codec *codec)
+{
+	return snd_hda_codec_read(codec, WIDGET_CHIP_CTRL, 0,
+				   VENDOR_CHIPIO_8051_DATA_READ, 0);
+}
+
+static void chipio_8051_write_exram(struct hda_codec *codec,
+		unsigned int addr, unsigned int data)
+{
+	struct ca0132_spec *spec = codec->spec;
+
+	mutex_lock(&spec->chipio_mutex);
+
+	chipio_8051_set_address(codec, addr);
+	chipio_8051_set_data(codec, data);
+
+	mutex_unlock(&spec->chipio_mutex);
+}
+
+static void chipio_8051_write_exram_no_mutex(struct hda_codec *codec,
+		unsigned int addr, unsigned int data)
+{
+	chipio_8051_set_address(codec, addr);
+	chipio_8051_set_data(codec, data);
+}
+
+/* Readback data from the 8051's exram. No mutex. */
+static void chipio_8051_read_exram(struct hda_codec *codec,
+		unsigned int addr, unsigned int *data)
+{
+	chipio_8051_set_address(codec, addr);
+	*data = chipio_8051_get_data(codec);
+}
+
 /*
  * Enable clocks.
  */
@@ -7422,18 +7486,10 @@ static void ca0132_init_analog_mic2(struct hda_codec *codec)
 	struct ca0132_spec *spec = codec->spec;
 
 	mutex_lock(&spec->chipio_mutex);
-	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
-			    VENDOR_CHIPIO_8051_ADDRESS_LOW, 0x20);
-	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
-			    VENDOR_CHIPIO_8051_ADDRESS_HIGH, 0x19);
-	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
-			    VENDOR_CHIPIO_8051_DATA_WRITE, 0x00);
-	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
-			    VENDOR_CHIPIO_8051_ADDRESS_LOW, 0x2D);
-	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
-			    VENDOR_CHIPIO_8051_ADDRESS_HIGH, 0x19);
-	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
-			    VENDOR_CHIPIO_8051_DATA_WRITE, 0x00);
+
+	chipio_8051_write_exram_no_mutex(codec, 0x1920, 0x00);
+	chipio_8051_write_exram_no_mutex(codec, 0x192d, 0x00);
+
 	mutex_unlock(&spec->chipio_mutex);
 }
 
@@ -7504,18 +7560,11 @@ static void ca0132_refresh_widget_caps(struct hda_codec *codec)
 static void chipio_remap_stream(struct hda_codec *codec,
 		const struct chipio_stream_remap_data *remap_data)
 {
-	unsigned int i, stream_offset, tmp;
+	unsigned int i, stream_offset;
 
 	/* Get the starting port for the stream to be remapped. */
-	tmp = 0x1578 + remap_data->stream_id;
-	for (i = 0; i < 2; i++) {
-		snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
-				    VENDOR_CHIPIO_8051_ADDRESS_LOW + i,
-				    ((tmp >> (i * 8)) & 0xff));
-	}
-
-	stream_offset = snd_hda_codec_read(codec, WIDGET_CHIP_CTRL, 0,
-				   VENDOR_CHIPIO_8051_DATA_READ, 0);
+	chipio_8051_read_exram(codec, 0x1578 + remap_data->stream_id,
+			&stream_offset);
 
 	/*
 	 * Check if the stream's port value is 0xff, because the 8051 may not
@@ -7526,9 +7575,8 @@ static void chipio_remap_stream(struct hda_codec *codec,
 		for (i = 0; i < 5; i++) {
 			msleep(25);
 
-			stream_offset = snd_hda_codec_read(codec,
-					WIDGET_CHIP_CTRL, 0,
-					VENDOR_CHIPIO_8051_DATA_READ, 0);
+			chipio_8051_read_exram(codec, 0x1578 + remap_data->stream_id,
+					&stream_offset);
 
 			if (stream_offset != 0xff)
 				break;
@@ -7863,12 +7911,7 @@ static void ae5_post_dsp_param_setup(struct hda_codec *codec)
 	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0, 0x724, 0x83);
 	chipio_set_control_param(codec, CONTROL_PARAM_ASI, 0);
 
-	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
-			    VENDOR_CHIPIO_8051_ADDRESS_LOW, 0x92);
-	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
-			    VENDOR_CHIPIO_8051_ADDRESS_HIGH, 0xfa);
-	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
-			    VENDOR_CHIPIO_8051_DATA_WRITE, 0x22);
+	chipio_8051_write_exram(codec, 0xfa92, 0x22);
 }
 
 static void ae5_post_dsp_pll_setup(struct hda_codec *codec)
@@ -8134,12 +8177,7 @@ static void ae7_post_dsp_asi_setup(struct hda_codec *codec)
 	chipio_set_control_param(codec, CONTROL_PARAM_ASI, 0);
 	snd_hda_codec_write(codec, 0x17, 0, 0x794, 0x00);
 
-	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
-			    VENDOR_CHIPIO_8051_ADDRESS_LOW, 0x92);
-	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
-			    VENDOR_CHIPIO_8051_ADDRESS_HIGH, 0xfa);
-	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
-			    VENDOR_CHIPIO_8051_DATA_WRITE, 0x22);
+	chipio_8051_write_exram(codec, 0xfa92, 0x22);
 
 	ae7_post_dsp_pll_setup(codec);
 	ae7_post_dsp_asi_stream_setup(codec);
@@ -9133,12 +9171,7 @@ static void r3d_pre_dsp_setup(struct hda_codec *codec)
 {
 	chipio_write(codec, 0x18b0a4, 0x000000c2);
 
-	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
-			    VENDOR_CHIPIO_8051_ADDRESS_LOW, 0x1E);
-	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
-			    VENDOR_CHIPIO_8051_ADDRESS_HIGH, 0x1C);
-	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
-			    VENDOR_CHIPIO_8051_DATA_WRITE, 0x5B);
+	chipio_8051_write_exram(codec, 0x1c1e, 0x5b);
 
 	snd_hda_codec_write(codec, 0x11, 0,
 			AC_VERB_SET_PIN_WIDGET_CONTROL, 0x44);
@@ -9148,21 +9181,9 @@ static void r3di_pre_dsp_setup(struct hda_codec *codec)
 {
 	chipio_write(codec, 0x18b0a4, 0x000000c2);
 
-	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
-			    VENDOR_CHIPIO_8051_ADDRESS_LOW, 0x1E);
-	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
-			    VENDOR_CHIPIO_8051_ADDRESS_HIGH, 0x1C);
-	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
-			    VENDOR_CHIPIO_8051_DATA_WRITE, 0x5B);
-
-	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
-			    VENDOR_CHIPIO_8051_ADDRESS_LOW, 0x20);
-	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
-			    VENDOR_CHIPIO_8051_ADDRESS_HIGH, 0x19);
-	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
-			    VENDOR_CHIPIO_8051_DATA_WRITE, 0x00);
-	snd_hda_codec_write(codec, WIDGET_CHIP_CTRL, 0,
-			    VENDOR_CHIPIO_8051_DATA_WRITE, 0x40);
+	chipio_8051_write_exram(codec, 0x1c1e, 0x5b);
+	chipio_8051_write_exram(codec, 0x1920, 0x00);
+	chipio_8051_write_exram(codec, 0x1921, 0x40);
 
 	snd_hda_codec_write(codec, 0x11, 0,
 			AC_VERB_SET_PIN_WIDGET_CONTROL, 0x04);
-- 
2.25.1

