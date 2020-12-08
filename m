Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D41A2D3534
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Dec 2020 22:27:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729702AbgLHV1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Dec 2020 16:27:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726104AbgLHV1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Dec 2020 16:27:02 -0500
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBCFC0613CF
        for <linux-kernel@vger.kernel.org>; Tue,  8 Dec 2020 13:26:22 -0800 (PST)
Received: by mail-qt1-x844.google.com with SMTP id y15so5493648qtv.5
        for <linux-kernel@vger.kernel.org>; Tue, 08 Dec 2020 13:26:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TekqjgSsdWTRJUqcm3lBG19qprznIlJibNa9BIZ8520=;
        b=lwl8B0bvflCaiP9+PZSNj3AqNQK7cGYKAQg2JWnnvbzy6NXBhn45+8CtanCzmgz6q8
         Rk8fd4LySvXbvYKm0oHWkpW/kt3GOMe5O1lpZvxYMKgHZmUXzZSJL2sr/73PQcxgn6U3
         NZr7/d/oKDT2SOulNog3GdaH4unxs/tMQTEJUqROr/fK/CzxY+plvWlKXqtM/PgGAEfj
         EieJCci//nxViPUIcBYqoTw2LKP6tcCBc0/sRKKtSE/W8lYY+Kje30MnWfWwsQWsslNO
         EWS/icQaVCbExyj2/J725suZNOvTJjDGXZgYBsnDjplJw8KylPAwU1VSqfb/4LkVzScF
         fHSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TekqjgSsdWTRJUqcm3lBG19qprznIlJibNa9BIZ8520=;
        b=GldIop9xfIjqTZJg5KcO2HCzz2sbf0shLkOXI/OyzbpKguSbu2S7NXAVw5GE3V8iI7
         z0eyDc7lZzQcDX8T4e4AFYQLNWnsF3/PCk0jjY8E1hHqwAEI0rI6EY20hPa8IQQTU2aH
         3L+UDteBVJjwk9zu1d4u6DA1KzhFxDDPKEr5vO99p1dPCq/nd427osDxe+wi+4mIB4xN
         9Z7QLb2/+JNSBwTPfWBMt0wxzpWz3UHBh1L4+NluOKKpkzVqptKLF/IWi+zPig5n/Q74
         uVx8SQeHan+CWqJ6sgvxrskQI04zApdT74b/u8GAsdb8k8wYYENZB0swF+EydALLOb9k
         t/uA==
X-Gm-Message-State: AOAM531zJAjBVltRVwsXbRe+m9hKfM9BTKKgyGYIWQ+aNhObC7HAYWmG
        fOi3TB9mda5F97lurtTHO4k=
X-Google-Smtp-Source: ABdhPJzGjv4tMTGgPbFeKpWWjYQoYNBsAo5cAtcyK8NsnwzCDbyjGdGmRJgjvOj/PyFNv9Qr4f5vQA==
X-Received: by 2002:ac8:6f04:: with SMTP id g4mr26375008qtv.122.1607462781299;
        Tue, 08 Dec 2020 13:26:21 -0800 (PST)
Received: from localhost.localdomain (cpe-71-65-111-223.cinci.res.rr.com. [71.65.111.223])
        by smtp.googlemail.com with ESMTPSA id l1sm16018572qkj.101.2020.12.08.13.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Dec 2020 13:26:20 -0800 (PST)
From:   Connor McAdams <conmanx360@gmail.com>
Cc:     conmanx360@gmail.com, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] ALSA: hda/ca0132 - Reset codec upon initialization.
Date:   Tue,  8 Dec 2020 16:25:41 -0500
Message-Id: <20201208212546.428392-2-conmanx360@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201208212546.428392-1-conmanx360@gmail.com>
References: <20201208212546.428392-1-conmanx360@gmail.com>
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
index 4fbec4258f58..05945f021e74 100644
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

