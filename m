Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78D362CBB3C
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 12:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbgLBLJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 06:09:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726603AbgLBLJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 06:09:32 -0500
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF55DC0613CF
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 03:08:51 -0800 (PST)
Received: by mail-wr1-x442.google.com with SMTP id l1so3332347wrb.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 03:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=AhN8VnnxsPwYIhG0xpPOPolapNC7nTNchT/tIDEYUxQ=;
        b=oe+cFmFNydVXspmjL1nXuukXUFbWFk0kDJNytpICL0M6T+gAzaI4DuJlFoDWwXODVL
         QrcNL4KbvS0WqFr6QM+1RN0vNxYV7Lmx6x2DGHIgIaJN5n72mmaSGyUbImWJ26iJH92u
         jzqYefHOyH59dqoSgm3SkvqhAtE6+GMOMjudFbmH+9bhAkU/frY857t2ndcefEXxmS71
         BQ/ASrlpd2p5o6J34FsL3PjYGQgHLXwv4YCbH/BsK81ioehv9/XhvBOXh4orsRaOIXxk
         ycWwuSme05XYQqgQfD1k3rpjujTLsS7JSkftAgbwu9fh8/YQt4u0eYfzgi1OVTedpSoP
         LgTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AhN8VnnxsPwYIhG0xpPOPolapNC7nTNchT/tIDEYUxQ=;
        b=b3hKvdC8eCcatYlwOZWMyT1pvB5rCWyGLQIdetWSDiQc5cA9rW2xMBYzEF++xSBvKJ
         9xlsN7nnrI3VodbmEatsLl395ALpcXiJJWcAsGoBhVADbJrrLUjF0t/VzxwcCAMlzOqZ
         7ZwH5+9plI2HyLG4eoxfzEag5W3Pn1F1DQPzVOxHopbsEsGfU/2cviBYOR7IBOldQn8y
         +GQK6aMasIUWQBMqZlxxnrU7w89TkYun5fpb5ZtmZafinNKAUJcXrrQeG0tDwkpm8L4M
         baJZoOb1VTNgaxZQMpuQ1drjLxAaMm9E6KVxYGK2ndJ1th/TMJydaiXYhkBO4Zu4cgnw
         krwg==
X-Gm-Message-State: AOAM5311WDw0zmRt7UCjkL54WITn1A7Jo3W6FK4/2Hu1cGoPNz/iQnjq
        vJ6RAcMJ7URImKMJnp/pxDU=
X-Google-Smtp-Source: ABdhPJzpyOSGbx+vWZ8DCFxAOkX0Ba9skJHgohXvL+KIseVKFJdLFXD7kdwaxe723gihUJtGewXjCA==
X-Received: by 2002:a5d:69d1:: with SMTP id s17mr2813008wrw.104.1606907330456;
        Wed, 02 Dec 2020 03:08:50 -0800 (PST)
Received: from rum-mikhail-dt.world.mentorg.com (nat-rum.mentorg.com. [139.181.33.34])
        by smtp.gmail.com with ESMTPSA id 35sm1639225wro.71.2020.12.02.03.08.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Dec 2020 03:08:49 -0800 (PST)
From:   mdurnev@gmail.com
X-Google-Original-From: mikhail_durnev@mentor.com
To:     kuninori.morimoto.gx@renesas.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     mikhail_durnev@mentor.com
Subject: [PATCH v0] ASoC: rsnd: core: Check convert rate in rsnd_hw_params
Date:   Wed,  2 Dec 2020 21:08:06 +1000
Message-Id: <1606907286-32104-1-git-send-email-mikhail_durnev@mentor.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikhail Durnev <mikhail_durnev@mentor.com>

snd_pcm_hw_params_set_rate_near can return incorrect sample rate in
some cases, e.g. when the backend output rate is set to some value higher
than 48000 Hz and the input rate is 8000 Hz. So passing the value returned
by snd_pcm_hw_params_set_rate_near to snd_pcm_hw_params will result in
"FSO/FSI ratio error" and playing no audio at all while the userland
is not properly notified about the issue.

If SRC is unable to convert the requested sample rate to the sample rate
the backend is using, then the requested sample rate should be adjusted in
rsnd_hw_params. The userland will be notified about that change in the
returned hw_params structure.

Signed-off-by: Mikhail Durnev <mikhail_durnev@mentor.com>
---
 sound/soc/sh/rcar/core.c | 67 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 66 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 6e670b3..8ca3fb7 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -1428,8 +1428,73 @@ static int rsnd_hw_params(struct snd_soc_component *component,
 		}
 		if (io->converted_chan)
 			dev_dbg(dev, "convert channels = %d\n", io->converted_chan);
-		if (io->converted_rate)
+		if (io->converted_rate) {
 			dev_dbg(dev, "convert rate     = %d\n", io->converted_rate);
+
+			/*
+			 * SRC supports convert rates from params_rate(hw_params)/k_down
+			 * to params_rate(hw_params)*k_up, where k_up is always 6, and
+			 * k_down depends on number of channels and SRC unit.
+			 * So all SRC units can upsample audio up to 6 times regardless
+			 * its number of channels. And all SRC units can downsample
+			 * 2 channel audio up to 6 times too.
+			 */
+			int k_up = 6;
+			int k_down = 6;
+			int channel;
+			struct rsnd_mod *src_mod = rsnd_io_to_mod_src(io);
+
+			channel = io->converted_chan ? io->converted_chan : fe_channel;
+
+			switch (rsnd_mod_id(src_mod)) {
+			/*
+			 * SRC0 can downsample 4, 6 and 8 channel audio up to 4 times.
+			 * SRC1, SRC3 and SRC4 can downsample 4 channel audio
+			 * up to 4 times.
+			 * SRC1, SRC3 and SRC4 can downsample 6 and 8 channel audio
+			 * no more than twice.
+			 */
+			case 1:
+			case 3:
+			case 4:
+				if (channel > 4) {
+					k_down = 2;
+					break;
+				}
+			case 0:
+				if (channel > 2)
+					k_down = 4;
+				break;
+
+			/* Other SRC units do not support more than 2 channels */
+			default:
+				if (channel > 2)
+					return -EINVAL;
+			}
+
+			if (params_rate(hw_params) > io->converted_rate * k_down) {
+				hw_param_interval(hw_params, SNDRV_PCM_HW_PARAM_RATE)->min =
+					io->converted_rate * k_down;
+				hw_param_interval(hw_params, SNDRV_PCM_HW_PARAM_RATE)->max =
+					io->converted_rate * k_down;
+				hw_params->cmask |= SNDRV_PCM_HW_PARAM_RATE;
+			} else if (params_rate(hw_params) * k_up < io->converted_rate) {
+				hw_param_interval(hw_params, SNDRV_PCM_HW_PARAM_RATE)->min =
+					(io->converted_rate + k_up - 1) / k_up;
+				hw_param_interval(hw_params, SNDRV_PCM_HW_PARAM_RATE)->max =
+					(io->converted_rate + k_up - 1) / k_up;
+				hw_params->cmask |= SNDRV_PCM_HW_PARAM_RATE;
+			}
+
+			/*
+			 * TBD: Max SRC input and output rates also depend on number
+			 * of channels and SRC unit:
+			 * SRC1, SRC3 and SRC4 do not support more than 128kHz
+			 * for 6 channel and 96kHz for 8 channel audio.
+			 * Perhaps this function should return EINVAL if the input or
+			 * the output rate exceeds the limitation.
+			 */
+		}
 	}
 
 	return rsnd_dai_call(hw_params, io, substream, hw_params);
-- 
2.7.4

