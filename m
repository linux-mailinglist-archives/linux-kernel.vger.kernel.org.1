Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D86FE2521A4
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Aug 2020 22:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgHYULq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Aug 2020 16:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbgHYULh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 16:11:37 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A738AC061755
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 13:11:37 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id x12so10045503qtp.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 13:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M8q6dm5mmw5Td1zETyvacyXoL82xchupi74RSawN6Ew=;
        b=imQNwuyLRMz5z0nzGwpPGnvNRsiTUDsrlb+zOR2FcUlFwU250vFohtXoCv4nlWk+Wx
         eTYcFbLTxBF8JzPhxleqYGePOa53egjh2l9A/4rS6xW4Rr9Z1VP1PadByPS9eex02Gfm
         C1lfqMvVAAsHKiwsX1mSceREoHLK1Tc5b/NK3poSMbhDZPQigQgL91raIs6kRFwgZKZ1
         upvFSlKAZuvFZ1vaweFxvMmxoeJrPKOS172nOqF7wZxnnJu4R+GdBbjCYzFn1TTeiQUP
         8Ta9i3hjBbm/m+aSulhS7O402Dy6kg03KjCGk2YS8x68Mngnko2geUs5ApYQsTcisz2x
         4hHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M8q6dm5mmw5Td1zETyvacyXoL82xchupi74RSawN6Ew=;
        b=f+64t+RM84f0eHv8IAAIbM0NuhFqmfGpHvNs/NoKBQJoRlvZx1p/ts8AJGeAiL0ESn
         HRhFclpSg9dMEd1IZQUJokhGMUJnNb0RQ1zvV1mWK9BvfdKQGAjps6fbTKwP+ml9CAas
         QSBP7QRgxHyk1aDGnS5FGEkQaLiKBZCZDG2Sca7WCUxl3F3ngFAUot5TvKzRs6/iA/I6
         LZRJMsLoOcwsvvrMa0kDUgXzN1ISlxiTeE4SHyqHfm+Mrv3Nhmob93QhrssjKwhrJ4dO
         r/iZRJu45Lzf20jxqoN9SsvfIV8zCWbzyC6aWzXtYbVUQ0a9q1IZYX96IefrzfY4rz24
         fOtw==
X-Gm-Message-State: AOAM533gH06Xgb12oCefRsqJncachrOvbUH1Cb97cryNI/rHTUr3OwxP
        Z0FxJbaAAFut2Nc512rzV8U=
X-Google-Smtp-Source: ABdhPJx39Ct45gM/LOal2j67L7+GsQQ64KOaqVJApGUDQWFazLfIF2VZeVgHVOeJe8XD/oYWuABbeA==
X-Received: by 2002:ac8:5546:: with SMTP id o6mr10591181qtr.211.1598386296965;
        Tue, 25 Aug 2020 13:11:36 -0700 (PDT)
Received: from localhost.localdomain (cpe-71-65-111-223.cinci.res.rr.com. [71.65.111.223])
        by smtp.googlemail.com with ESMTPSA id n23sm12453459qkk.105.2020.08.25.13.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 13:11:36 -0700 (PDT)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 19/20] ALSA: hda/ca0132 - Add AE-7 custom controls.
Date:   Tue, 25 Aug 2020 16:10:38 -0400
Message-Id: <20200825201040.30339-20-conmanx360@gmail.com>
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

Add headphone gain and DAC filter controls, which use the same commands
as the AE-5. Also, change input source enumerated control item count to
exclude front microphone.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 8c6e38734489..52f6d3740e0a 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -5839,6 +5839,13 @@ static int ca0132_alt_input_source_put(struct snd_kcontrol *kcontrol,
 	int sel = ucontrol->value.enumerated.item[0];
 	unsigned int items = IN_SRC_NUM_OF_INPUTS;
 
+	/*
+	 * The AE-7 has no front microphone, so limit items to 2: rear mic and
+	 * line-in.
+	 */
+	if (ca0132_quirk(spec) == QUIRK_AE7)
+		items = 2;
+
 	if (sel >= items)
 		return 0;
 
@@ -7029,20 +7036,25 @@ static int ca0132_build_controls(struct hda_codec *codec)
 		}
 	}
 
-	if (ca0132_quirk(spec) == QUIRK_AE5) {
+	switch (ca0132_quirk(spec)) {
+	case QUIRK_AE5:
+	case QUIRK_AE7:
 		err = ae5_add_headphone_gain_enum(codec);
 		if (err < 0)
 			return err;
 		err = ae5_add_sound_filter_enum(codec);
 		if (err < 0)
 			return err;
-	}
-
-	if (ca0132_quirk(spec) == QUIRK_ZXR) {
+		break;
+	case QUIRK_ZXR:
 		err = zxr_add_headphone_gain_switch(codec);
 		if (err < 0)
 			return err;
+		break;
+	default:
+		break;
 	}
+
 #ifdef ENABLE_TUNING_CONTROLS
 	add_tuning_ctls(codec);
 #endif
-- 
2.20.1

