Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B63F62CCFE5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 07:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729661AbgLCGzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 01:55:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728524AbgLCGzo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 01:55:44 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90C1EC061A4D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 22:55:03 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id x22so1668503wmc.5
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 22:55:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=AKmXevT8drdUH2skv3DTg3x+JAfuhsvELYJQvYu/Upc=;
        b=OVXUVppObbNgGzbktdcsv9I5gq22Tr7SGewBgJsJY3fVwWtGPcLfABKyeScwnIAxhS
         35Dr33bZXY11uecwk/GGz1oLK3CfQay82aTGAKG23k7hIm77hlsVijcXp9C9Maik9x3Q
         0Ui8Lo31s64v7uyTdMN40z+G37REecnWMHByPNB30IAEZq9zleF6FCwiQdquq+q+t93D
         udBeaXXPGZMpVhLXWRB/8BeRrFqDOY0NjSncEKhMFF4Zm1/XLjgB82T/OBSrLHYsvmnQ
         huTlPX/fASZkgBFDu+oj6CGtgUPY3NeCTaw5I16gN1TCwMtjlG7+/LFasBKElvahFVwO
         iuzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=AKmXevT8drdUH2skv3DTg3x+JAfuhsvELYJQvYu/Upc=;
        b=Q/AbBZoDrHCQMaFYWN1IYBNWH7P+1zDSW0zGB1JYBswJNNaW1Hv/JUzOOrBEuPfd//
         1ZqFaSPfastVoLcSu86w9OuJQYs4j2yvY+QwJl6fl85Ma1/VTrzULJZQfa/uimB0S9zR
         T1o8giu8lsOXATU6y0ZmMOZjuAyUpMmUpWmEqYAOanQo3k0rbcht+8E9Gp5RJVvMBzN8
         j5fldRDWvF1LNWEDbpc5CsEXCvlrOvYEthWQaq38CN/sTb1Rg73WQQGP5SakH6V5GhiW
         UNjpYPVgERC4KFw1aF3V/V6AQM+yfnzI/lnezNGsG4jfCE5gljTpe6LnpsQu4cNFozVv
         ofaA==
X-Gm-Message-State: AOAM533Z0+SzQye3+QmXFvLl++f11UzLTLsVwQnLPa8iTuC4aauGM5WY
        tzc/1m+dFGTPRyUR2VMeq2vIKbmuirX2jw==
X-Google-Smtp-Source: ABdhPJwPof0T9rcDrsp5436Aum0R/KLU+3Qsrr/Q0ML3g3VbMuPO7CGAZtm7Vm3mj4/Rq/WZ27jfLg==
X-Received: by 2002:a1c:9dd8:: with SMTP id g207mr1560810wme.15.1606978502320;
        Wed, 02 Dec 2020 22:55:02 -0800 (PST)
Received: from rum-mikhail-dt.world.mentorg.com (nat-rum.mentorg.com. [139.181.33.34])
        by smtp.gmail.com with ESMTPSA id l11sm118738wmh.46.2020.12.02.22.55.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Dec 2020 22:55:01 -0800 (PST)
From:   mdurnev@gmail.com
X-Google-Original-From: mikhail_durnev@mentor.com
To:     kuninori.morimoto.gx@renesas.com, linux-kernel@vger.kernel.org
Cc:     mikhail_durnev@mentor.com
Subject: [PATCH v1] ASoC: rsnd: core: Check convert rate in rsnd_hw_params
Date:   Thu,  3 Dec 2020 16:54:27 +1000
Message-Id: <1606978467-13806-1-git-send-email-mikhail_durnev@mentor.com>
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
 sound/soc/sh/rcar/core.c | 69 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 68 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 6e670b3..289928d 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -1428,8 +1428,75 @@ static int rsnd_hw_params(struct snd_soc_component *component,
 		}
 		if (io->converted_chan)
 			dev_dbg(dev, "convert channels = %d\n", io->converted_chan);
-		if (io->converted_rate)
+		if (io->converted_rate) {
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
 			dev_dbg(dev, "convert rate     = %d\n", io->converted_rate);
+
+			channel = io->converted_chan ? io->converted_chan :
+				  params_channels(hw_params);
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
+				fallthrough;
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

