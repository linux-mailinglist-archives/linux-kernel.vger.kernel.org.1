Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2270A2D6151
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Dec 2020 17:11:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392336AbgLJQK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Dec 2020 11:10:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392328AbgLJQHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Dec 2020 11:07:44 -0500
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59488C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 08:07:25 -0800 (PST)
Received: by mail-qt1-x841.google.com with SMTP id c14so4023369qtn.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Dec 2020 08:07:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IaJnWNUybnDRToq59E44bnvu+Jic0mLbhcwyhGMTzRg=;
        b=g+mxm6coxLYmTo9xcwa8YCqTf/r9WRXpwm6Kb9H8g1fxJKcJ+6wVd6LcC1oLcPdWnI
         +qcmDfv8DiB7ePiicz6BLJknwjPytnPnm2coOvXjjnawdOi1wyGON0jUX9MvyKW0dFAl
         ziPlFGzz82SC4HA8wvHPWFltP23SbL0PO3CM3XmgbLPnq8Yo8J7UAEJdAWgViMgkDawX
         wlrRIzLZZeHfdFgGDy1Dq3LloFvc8nV8WyO8XsalHLPj+9olE+Hi8gSpWJ5Nqi3hmbHl
         UTEbfjNQIVcYYevJIZ9m6EV4a2Uym+Fsnm7ICg2WkCDm0iE91xVIxBcziQPIVgEOhNrA
         1rZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IaJnWNUybnDRToq59E44bnvu+Jic0mLbhcwyhGMTzRg=;
        b=hJgAt5576Xqav9WQZtRwM53T1CenqyccXeN1v9NSpBU6RYgq0SKQy5LsWA5eloxWXZ
         N/vLUSN7kVFwuOI0mBjqrtZ44lrxMB7LE07K5g+bwZ/OEOvf7H9ynEaNVIezGL5HGPer
         Iiz/cJig5/CKxb11Oan7VcDJWNbHOJYs/fTkicJG+wTndAq6uLD3qZPvStsEnKCWVdHV
         5+jgLcwb3nDRxM5cqK7P3aWCmt9viHtCcgDbrh4iPn5JMT3CTgEfa+oQDxo/8u4+2bdh
         C3B0f1izPZbJvPpLpvfem+pm83fUIRMsehTnFvYk3fnOZDaAOreSs5/CziIK6lbRlqV3
         JN9w==
X-Gm-Message-State: AOAM530sckoIZrYkxWZxHuzmEqWR8k9km2gyTduD+t6Tbo6CXZHAZM5M
        lPFSJWEd9mPlmfKCIL3K9rc=
X-Google-Smtp-Source: ABdhPJy9R5XGjJibBGGyFMY5hnkxdoG/RC/758l2eEMy+43kGHS2+NHDuMYDV/BPfzWhOFMlkRvFcQ==
X-Received: by 2002:ac8:6bc9:: with SMTP id b9mr10135474qtt.51.1607616444591;
        Thu, 10 Dec 2020 08:07:24 -0800 (PST)
Received: from localhost.localdomain (cpe-71-65-111-223.cinci.res.rr.com. [71.65.111.223])
        by smtp.googlemail.com with ESMTPSA id d190sm3852290qkf.112.2020.12.10.08.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Dec 2020 08:07:24 -0800 (PST)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] ALSA: hda/ca0132 - Reset codec upon initialization.
Date:   Thu, 10 Dec 2020 11:06:53 -0500
Message-Id: <20201210160658.461739-2-conmanx360@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201210160658.461739-1-conmanx360@gmail.com>
References: <20201210160658.461739-1-conmanx360@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reset the codec upon initialization to clear out anything that may have
been setup on a previous boot into Windows, or in case of an improper
shutdown.

Signed-off-by: Connor McAdams <conmanx360@gmail.com>
---
 sound/pci/hda/patch_ca0132.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
index 6d647d461eab..7ce4a966b733 100644
--- a/sound/pci/hda/patch_ca0132.c
+++ b/sound/pci/hda/patch_ca0132.c
@@ -8642,6 +8642,22 @@ static void ca0132_init_chip(struct hda_codec *codec)
 
 	mutex_init(&spec->chipio_mutex);
 
+	/*
+	 * The Windows driver always does this upon startup, which seems to
+	 * clear out any previous configuration. This should help issues where
+	 * a boot into Windows prior to a boot into Linux breaks things. Also,
+	 * Windows always sends the reset twice.
+	 */
+	if (ca0132_use_alt_functions(spec)) {
+		chipio_set_control_flag(codec, CONTROL_FLAG_IDLE_ENABLE, 0);
+		chipio_write_no_mutex(codec, 0x18b0a4, 0x000000c2);
+
+		snd_hda_codec_write(codec, codec->core.afg, 0,
+			    AC_VERB_SET_CODEC_RESET, 0);
+		snd_hda_codec_write(codec, codec->core.afg, 0,
+			    AC_VERB_SET_CODEC_RESET, 0);
+	}
+
 	spec->cur_out_type = SPEAKER_OUT;
 	if (!ca0132_use_alt_functions(spec))
 		spec->cur_mic_type = DIGITAL_MIC;
@@ -9262,11 +9278,6 @@ static void ae5_register_set(struct hda_codec *codec)
 
 	if (ca0132_quirk(spec) == QUIRK_AE5)
 		ca0113_mmio_command_set(codec, 0x48, 0x07, 0x83);
-
-	chipio_write(codec, 0x18b0a4, 0x000000c2);
-
-	snd_hda_codec_write(codec, 0x01, 0, 0x7ff, 0x00);
-	snd_hda_codec_write(codec, 0x01, 0, 0x7ff, 0x00);
 }
 
 /*
-- 
2.25.1

