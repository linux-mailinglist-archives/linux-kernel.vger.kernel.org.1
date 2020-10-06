Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFDE82847F6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 09:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbgJFH4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 03:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbgJFH4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 03:56:14 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9528C061755
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 00:56:13 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id u24so7555419pgi.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Oct 2020 00:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t5k1TjFGfKLHv3RvX/XEqm6WMW98Ka1st8yEK6IBJ2w=;
        b=bgGP3X3dHLY2qGFBCDETgUuZnETOhBrm5SSdHeWbTTxBk/0woDrgJHT2uz6IknHzoF
         xLKHawWZGhi/41XIYsdchOctVgDI3fK7TRqBCZwtNAy/QS3ScWLiAZm9GdUq4I4Qmz+k
         6QOrlFQhgFAwOvPBHIjWUt8ozTG/9rJfVrPbaE17OLc+u2s7W+eADPxPp0L7JdYE0p5b
         yBIeoSBtbs8B1Fkelb8lykJir4bBNcQNomZ2Er3wbL+4w3SnayfGn3VMGO7qdowtiBqi
         gu42n6MqDCdfrvCXlhuPGqJoTrQz21ecrqm1Z8TQx6kUBlykRRv2u5KJ+d2SJK8cJiKV
         htEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t5k1TjFGfKLHv3RvX/XEqm6WMW98Ka1st8yEK6IBJ2w=;
        b=BohtyQm3qhu5uGhNUuyTfCUmeWJpuhm6c4lfk/bzyD0e2O7H6tNu1wtZs2YxlJJgxx
         lXE4c00f4tcCSJfO2AhwwF3/MRZO6NLqG+4tp3UsGoD2WUcDUtY5I+3mV/HEQgfOSooL
         7dWxKSrjKZp1apbXvI29HLEtMFS8JMNafhiYco6MtwwoXgnmx6DqhD/Zpbfhqa16DVLJ
         qvB1eE0NMWkSCbQ2bIAA8nUU7oL8TQxRYj0YDC+54dRp+1vESSPHTb6wpZS32TmZbF7+
         y1bWl5tVPc5EmKWuVFX6BQj8ZOkk5duihX4aXl1kXGKY0hNUxoVqD9Sq2pjCA4Kr4V1Y
         QNTw==
X-Gm-Message-State: AOAM53175kj2M26pdjbZTczRaL/UUfJ0Lk9AobiPrC0gr+j0gw3F0V0k
        UC6rGZINEM0FS1WGQYRt40UbSA==
X-Google-Smtp-Source: ABdhPJwtHzUm2cAS9e4kkuQt6lVyfV8Hv9Sh5DvNjZO+3EmmvkTTAL2WCvuFcrnFCISreK4hCjW0Jg==
X-Received: by 2002:aa7:8e9c:0:b029:152:8a25:548d with SMTP id a28-20020aa78e9c0000b02901528a25548dmr3655973pfr.73.1601970973435;
        Tue, 06 Oct 2020 00:56:13 -0700 (PDT)
Received: from starnight.localdomain (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.googlemail.com with ESMTPSA id n2sm1875377pja.41.2020.10.06.00.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 00:56:12 -0700 (PDT)
From:   Jian-Hong Pan <jhp@endlessos.org>
To:     Takashi Iwai <tiwai@suse.com>
Cc:     Kailang Yang <kailang@realtek.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux@endlessm.com,
        Jian-Hong Pan <jhp@endlessos.org>
Subject: [PATCH] ALSA: hda/realtek: Enable audio jacks of ASUS D700SA with ALC887
Date:   Tue,  6 Oct 2020 15:53:35 +0800
Message-Id: <20201006075334.92933-1-jhp@endlessos.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ASUS D700SA desktop's audio (1043:2390) with ALC887 cannot detect
the headset microphone and another headphone jack until
ALC887_FIXUP_ASUS_HMIC and ALC887_FIXUP_ASUS_AUDIO quirks are applied.
The NID 0x15 maps as the headset microphone and NID 0x19 maps as another
headphone jack. Also need the function like alc887_fixup_asus_jack to
enable the audio jacks.

Signed-off-by: Jian-Hong Pan <jhp@endlessos.org>
Signed-off-by: Kailang Yang <kailang@realtek.com>
---
 sound/pci/hda/patch_realtek.c | 41 +++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index d4f17b465892..8d0928bdc9ff 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -1929,6 +1929,8 @@ enum {
 	ALC1220_FIXUP_CLEVO_P950,
 	ALC1220_FIXUP_CLEVO_PB51ED,
 	ALC1220_FIXUP_CLEVO_PB51ED_PINS,
+	ALC887_FIXUP_ASUS_AUDIO,
+	ALC887_FIXUP_ASUS_HMIC,
 };
 
 static void alc889_fixup_coef(struct hda_codec *codec,
@@ -2141,6 +2143,30 @@ static void alc1220_fixup_clevo_pb51ed(struct hda_codec *codec,
 	alc_fixup_headset_mode_no_hp_mic(codec, fix, action);
 }
 
+static void alc887_asus_hp_automute_hook(struct hda_codec *codec,
+					 struct hda_jack_callback *jack)
+{
+	struct alc_spec *spec = codec->spec;
+	int vref;
+
+	snd_hda_gen_hp_automute(codec, jack);
+
+	vref = spec->gen.hp_jack_present ? 0xc4 : 0xc0;
+	snd_hda_codec_write(codec, 0x19, 0, AC_VERB_SET_PIN_WIDGET_CONTROL,
+			    vref);
+}
+
+static void alc887_fixup_asus_jack(struct hda_codec *codec,
+				     const struct hda_fixup *fix, int action)
+{
+	struct alc_spec *spec = codec->spec;
+	if (action != HDA_FIXUP_ACT_PROBE)
+		return;
+	snd_hda_codec_write(codec, 0x1b, 0, AC_VERB_SET_PIN_WIDGET_CONTROL,
+			    0xc0);
+	spec->gen.hp_automute_hook = alc887_asus_hp_automute_hook;
+}
+
 static const struct hda_fixup alc882_fixups[] = {
 	[ALC882_FIXUP_ABIT_AW9D_MAX] = {
 		.type = HDA_FIXUP_PINS,
@@ -2398,6 +2424,20 @@ static const struct hda_fixup alc882_fixups[] = {
 		.chained = true,
 		.chain_id = ALC1220_FIXUP_CLEVO_PB51ED,
 	},
+	[ALC887_FIXUP_ASUS_AUDIO] = {
+		.type = HDA_FIXUP_PINS,
+		.v.pins = (const struct hda_pintbl[]) {
+			{ 0x15, 0x02a14150 }, /* use as headset mic, without its own jack detect */
+			{ 0x19, 0x22219420 },
+			{}
+		},
+	},
+	[ALC887_FIXUP_ASUS_HMIC] = {
+		.type = HDA_FIXUP_FUNC,
+		.v.func = alc887_fixup_asus_jack,
+		.chained = true,
+		.chain_id = ALC887_FIXUP_ASUS_AUDIO,
+	},
 };
 
 static const struct snd_pci_quirk alc882_fixup_tbl[] = {
@@ -2431,6 +2471,7 @@ static const struct snd_pci_quirk alc882_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x13c2, "Asus A7M", ALC882_FIXUP_EAPD),
 	SND_PCI_QUIRK(0x1043, 0x1873, "ASUS W90V", ALC882_FIXUP_ASUS_W90V),
 	SND_PCI_QUIRK(0x1043, 0x1971, "Asus W2JC", ALC882_FIXUP_ASUS_W2JC),
+	SND_PCI_QUIRK(0x1043, 0x2390, "Asus D700SA", ALC887_FIXUP_ASUS_HMIC),
 	SND_PCI_QUIRK(0x1043, 0x835f, "Asus Eee 1601", ALC888_FIXUP_EEE1601),
 	SND_PCI_QUIRK(0x1043, 0x84bc, "ASUS ET2700", ALC887_FIXUP_ASUS_BASS),
 	SND_PCI_QUIRK(0x1043, 0x8691, "ASUS ROG Ranger VIII", ALC882_FIXUP_GPIO3),
-- 
2.28.0

