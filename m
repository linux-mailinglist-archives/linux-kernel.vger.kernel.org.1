Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25DFF28581D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 07:28:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgJGF2b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 01:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726009AbgJGF2a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 01:28:30 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCB09C061755
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 22:28:30 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id u24so679521pgi.1
        for <linux-kernel@vger.kernel.org>; Tue, 06 Oct 2020 22:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessos-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5R1+WgHB899glUqb8KbPKiy6g38Z8v80NhMIn5rxp+M=;
        b=GVjJLEf3KLhU3aU5wXKe2gxs+CIz5UrbiXgK5tp94tZFODdyuKxpGx0lda16MRKAQW
         tp+Y725uYxKcBbznp/od78gZZL5I73XJLxXNE6x4SjjDA76bwdATwgMSGfZ9bMe452aK
         jp81rKvAVR9bvF9dg4Gc9xnViCLSHPGd5WsyBM52KO1n85gUSKizmwFMPQexg1x/rSJJ
         S8oYJcz5OHCUUk+0NBfpF8OJnMY9Vx2MuWyY+hP2HlemeIcmDRM6EnxrbpotpWiMujWW
         f+TRyv5b/42pv5nG4k3bVp29SwsG7OdzRhXSv94DxxOrgjSTbxnPmbSI9GlSAcBtPiUq
         SZJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5R1+WgHB899glUqb8KbPKiy6g38Z8v80NhMIn5rxp+M=;
        b=CP19GG/eQzdc21WF039Ju9dXluapcSlwk+Zgh55qGC5CtZ4nW+5BSNXIIfQHSz4pEu
         DOOClodglfF7h1hCLY17ypDCKFqGKN32BLR6WJMEUZBHKU4Smk+YV+da7BKERuMuy26Q
         AXHxe5P77N7txQ9dJ30LUxL48MMAN7cAYA+7/3bRrd6eINlo+vZOu6jm0sjtnpE5Qi85
         2HzLGzH7PgROwbRBuyZxl/z2A/I4sPDOiDPxAZXtleZlf+EPX1gtJgS26rjOc5Ix2BUH
         +buP9dIcjrAqYpGba5h3k2lu5Sw/3w31Zz9Lfcyl4Sm1xqpgPaf110JrTuUm3cga9shn
         oP8w==
X-Gm-Message-State: AOAM533cfPdNvPc3WmozZiPPrQjrKHvZA6kWsVUTZyaZ4IzyY2Tv2Iq9
        cIhg0V3nroCDHupl743APos7xg==
X-Google-Smtp-Source: ABdhPJzxM4iKLy72jLDLQyt5SxIfiDhZJSu72jnrTucg/rLTlovJU1ezXZ9r8sEoVERDfNQGwOxdOQ==
X-Received: by 2002:aa7:9421:0:b029:13e:d13d:a08d with SMTP id y1-20020aa794210000b029013ed13da08dmr1422685pfo.36.1602048510347;
        Tue, 06 Oct 2020 22:28:30 -0700 (PDT)
Received: from starnight.endlessm-sf.com (ec2-34-209-191-27.us-west-2.compute.amazonaws.com. [34.209.191.27])
        by smtp.googlemail.com with ESMTPSA id j19sm1171897pfe.108.2020.10.06.22.28.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 22:28:29 -0700 (PDT)
From:   Jian-Hong Pan <jhp@endlessos.org>
To:     Takashi Iwai <tiwai@suse.com>
Cc:     Kailang Yang <kailang@realtek.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, linux@endlessm.com,
        Jian-Hong Pan <jhp@endlessos.org>
Subject: [PATCH v2] ALSA: hda/realtek: Enable audio jacks of ASUS D700SA with ALC887
Date:   Wed,  7 Oct 2020 13:22:25 +0800
Message-Id: <20201007052224.22611-1-jhp@endlessos.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <s5hmu0z5ypi.wl-tiwai@suse.de>
References: <s5hmu0z5ypi.wl-tiwai@suse.de>
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
v2:
 - Change the magic numbers to meaningful macros.
 - Change snd_hda_codec_write to snd_hda_set_pin_ctl and
   snd_hda_set_pin_ctl_cache accroding to Takashi's suggestion

 sound/pci/hda/patch_realtek.c | 42 +++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index d4f17b465892..56c3ee95c8d3 100644
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
@@ -2141,6 +2143,31 @@ static void alc1220_fixup_clevo_pb51ed(struct hda_codec *codec,
 	alc_fixup_headset_mode_no_hp_mic(codec, fix, action);
 }
 
+static void alc887_asus_hp_automute_hook(struct hda_codec *codec,
+					 struct hda_jack_callback *jack)
+{
+	struct alc_spec *spec = codec->spec;
+	unsigned int vref;
+
+	snd_hda_gen_hp_automute(codec, jack);
+
+	if (spec->gen.hp_jack_present)
+		vref = AC_PINCTL_VREF_80;
+	else
+		vref = AC_PINCTL_VREF_HIZ;
+	snd_hda_set_pin_ctl(codec, 0x19, PIN_HP | vref);
+}
+
+static void alc887_fixup_asus_jack(struct hda_codec *codec,
+				     const struct hda_fixup *fix, int action)
+{
+	struct alc_spec *spec = codec->spec;
+	if (action != HDA_FIXUP_ACT_PROBE)
+		return;
+	snd_hda_set_pin_ctl_cache(codec, 0x1b, PIN_HP);
+	spec->gen.hp_automute_hook = alc887_asus_hp_automute_hook;
+}
+
 static const struct hda_fixup alc882_fixups[] = {
 	[ALC882_FIXUP_ABIT_AW9D_MAX] = {
 		.type = HDA_FIXUP_PINS,
@@ -2398,6 +2425,20 @@ static const struct hda_fixup alc882_fixups[] = {
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
@@ -2431,6 +2472,7 @@ static const struct snd_pci_quirk alc882_fixup_tbl[] = {
 	SND_PCI_QUIRK(0x1043, 0x13c2, "Asus A7M", ALC882_FIXUP_EAPD),
 	SND_PCI_QUIRK(0x1043, 0x1873, "ASUS W90V", ALC882_FIXUP_ASUS_W90V),
 	SND_PCI_QUIRK(0x1043, 0x1971, "Asus W2JC", ALC882_FIXUP_ASUS_W2JC),
+	SND_PCI_QUIRK(0x1043, 0x2390, "Asus D700SA", ALC887_FIXUP_ASUS_HMIC),
 	SND_PCI_QUIRK(0x1043, 0x835f, "Asus Eee 1601", ALC888_FIXUP_EEE1601),
 	SND_PCI_QUIRK(0x1043, 0x84bc, "ASUS ET2700", ALC887_FIXUP_ASUS_BASS),
 	SND_PCI_QUIRK(0x1043, 0x8691, "ASUS ROG Ranger VIII", ALC882_FIXUP_GPIO3),
-- 
2.28.0

