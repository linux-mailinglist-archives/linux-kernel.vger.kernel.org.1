Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12059292BBB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 18:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730616AbgJSQtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 12:49:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:52468 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730186AbgJSQtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 12:49:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1603126147;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=sJQCEGKu+7J2g9sl/DD8wOwXP+mAnDlq/0Z9hSiUcos=;
        b=dTqJjMyiSq3rKfPH7qkKbtxLVHe4uT/DDDxWWzW2FXwrN/NQ8KH1cW0YYxEnYf65yUu4Ns
        l43FZcPbcpZ8TXu15Q4XpVR++P9KPl6s2nYTjb9EObhVcPZ7XuT6fq5QNuX+kywQovbmIW
        m3RO3C0TVwB/EXVoXnsiva4FYa262x8=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-477-9fMOXGVoMoqBZJplPewsCQ-1; Mon, 19 Oct 2020 12:49:05 -0400
X-MC-Unique: 9fMOXGVoMoqBZJplPewsCQ-1
Received: by mail-qt1-f197.google.com with SMTP id t4so309637qtd.23
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 09:49:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=sJQCEGKu+7J2g9sl/DD8wOwXP+mAnDlq/0Z9hSiUcos=;
        b=F0YKvZjnh0rCPQ6NZ3wL0nyajQTwFE4i0ztz/RZKJqBrFfkNB2N5LpF12UxetnHxTI
         tGisEoLfAf34y27nrlB9qspVIs+5ABOGDOoaZFPyPCG9GGabulguRlBg2QbCiygRLJb/
         VV8jp3J3eJTxJM0h0/JG/xI6E/aAuBaXIwkUiXIvs0jUFyMenvPjAbqlR/5zXiXOSbdR
         PSHDeWP/WK3gpO6vm7m/7wrXWBDY4QDlJgkD97s9G8cUqFyvNc4jDV2wp/GJsZdycvri
         KLzS1uuGEKHMJJddbl1eYy7AerOBOJdO7AtCwwzYceQduOkVO7CDUoWtcUapAQln9rSI
         tjvQ==
X-Gm-Message-State: AOAM533CnnaCOs8z+KEOQGXj0Z7ke2/0O1RuVm0ssozeR960Hdsnv0hr
        ZzFplhKW0Mxm/I12Ptt+WnBf6Fg8oGhq80vN14YbRmXRDZ8diYdfT8oXf8/ui137BSALCGFlAxO
        M0xc1wyHm1VwTVzxGz48roz5i
X-Received: by 2002:ac8:578f:: with SMTP id v15mr302560qta.81.1603126145280;
        Mon, 19 Oct 2020 09:49:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJztOuWU9eE0mRhBQidaHF2cKWIUv8qEqHdvb+DEEKb9KvF6xBY+qI+Yp3ARCp3WCzDS2HZ50w==
X-Received: by 2002:ac8:578f:: with SMTP id v15mr302531qta.81.1603126145032;
        Mon, 19 Oct 2020 09:49:05 -0700 (PDT)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id w40sm181382qtj.48.2020.10.19.09.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2020 09:49:04 -0700 (PDT)
From:   trix@redhat.com
To:     perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
        broonie@kernel.org, cezary.rojewski@intel.com,
        pierre-louis.bossart@linux.intel.com, yang.jie@linux.intel.com,
        peter.ujfalusi@ti.com, arnd@arndb.de, romain.perier@gmail.com,
        naoki.hayama@lineo.co.jp, allen.lkml@gmail.com,
        kuninori.morimoto.gx@renesas.com, srinivas.kandagatla@linaro.org,
        ranjani.sridharan@linux.intel.com, baolin.wang@linaro.org,
        Julia.Lawall@inria.fr
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] sound: remove unneeded break
Date:   Mon, 19 Oct 2020 09:48:57 -0700
Message-Id: <20201019164857.27223-1-trix@redhat.com>
X-Mailer: git-send-email 2.18.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

A break is not needed if it is preceded by a return, goto
or break

Signed-off-by: Tom Rix <trix@redhat.com>
---
 sound/pci/rme32.c                 | 1 -
 sound/pci/rme9652/hdspm.c         | 8 --------
 sound/pci/rme9652/rme9652.c       | 7 -------
 sound/soc/codecs/wcd-clsh-v2.c    | 1 -
 sound/soc/codecs/wl1273.c         | 1 -
 sound/soc/intel/skylake/skl-pcm.c | 1 -
 sound/soc/ti/davinci-mcasp.c      | 1 -
 7 files changed, 20 deletions(-)

diff --git a/sound/pci/rme32.c b/sound/pci/rme32.c
index 869af8a32c98..4eabece4dcba 100644
--- a/sound/pci/rme32.c
+++ b/sound/pci/rme32.c
@@ -468,7 +468,6 @@ static int snd_rme32_capture_getrate(struct rme32 * rme32, int *is_adat)
 			return 32000;
 		default:
 			return -1;
-			break;
 		} 
 	else
 		switch (n) {	/* supporting the CS8412 */
diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 4a1f576dd9cf..3382c069fd3d 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -2286,7 +2286,6 @@ static int hdspm_get_wc_sample_rate(struct hdspm *hdspm)
 	case AIO:
 		status = hdspm_read(hdspm, HDSPM_RD_STATUS_1);
 		return (status >> 16) & 0xF;
-		break;
 	case AES32:
 		status = hdspm_read(hdspm, HDSPM_statusRegister);
 		return (status >> HDSPM_AES32_wcFreq_bit) & 0xF;
@@ -2312,7 +2311,6 @@ static int hdspm_get_tco_sample_rate(struct hdspm *hdspm)
 		case AIO:
 			status = hdspm_read(hdspm, HDSPM_RD_STATUS_1);
 			return (status >> 20) & 0xF;
-			break;
 		case AES32:
 			status = hdspm_read(hdspm, HDSPM_statusRegister);
 			return (status >> 1) & 0xF;
@@ -2338,7 +2336,6 @@ static int hdspm_get_sync_in_sample_rate(struct hdspm *hdspm)
 		case AIO:
 			status = hdspm_read(hdspm, HDSPM_RD_STATUS_2);
 			return (status >> 12) & 0xF;
-			break;
 		default:
 			break;
 		}
@@ -2358,7 +2355,6 @@ static int hdspm_get_aes_sample_rate(struct hdspm *hdspm, int index)
 	case AES32:
 		timecode = hdspm_read(hdspm, HDSPM_timecodeRegister);
 		return (timecode >> (4*index)) & 0xF;
-		break;
 	default:
 		break;
 	}
@@ -3845,7 +3841,6 @@ static int hdspm_wc_sync_check(struct hdspm *hdspm)
 				return 1;
 		}
 		return 0;
-		break;
 
 	case MADI:
 		status2 = hdspm_read(hdspm, HDSPM_statusRegister2);
@@ -3856,7 +3851,6 @@ static int hdspm_wc_sync_check(struct hdspm *hdspm)
 				return 1;
 		}
 		return 0;
-		break;
 
 	case RayDAT:
 	case AIO:
@@ -3868,8 +3862,6 @@ static int hdspm_wc_sync_check(struct hdspm *hdspm)
 			return 1;
 		return 0;
 
-		break;
-
 	case MADIface:
 		break;
 	}
diff --git a/sound/pci/rme9652/rme9652.c b/sound/pci/rme9652/rme9652.c
index 7ab10028d9fa..012fbec5e6a7 100644
--- a/sound/pci/rme9652/rme9652.c
+++ b/sound/pci/rme9652/rme9652.c
@@ -732,34 +732,27 @@ static inline int rme9652_spdif_sample_rate(struct snd_rme9652 *s)
 	switch (rme9652_decode_spdif_rate(rate_bits)) {
 	case 0x7:
 		return 32000;
-		break;
 
 	case 0x6:
 		return 44100;
-		break;
 
 	case 0x5:
 		return 48000;
-		break;
 
 	case 0x4:
 		return 88200;
-		break;
 
 	case 0x3:
 		return 96000;
-		break;
 
 	case 0x0:
 		return 64000;
-		break;
 
 	default:
 		dev_err(s->card->dev,
 			"%s: unknown S/PDIF input rate (bits = 0x%x)\n",
 			   s->card_name, rate_bits);
 		return 0;
-		break;
 	}
 }
 
diff --git a/sound/soc/codecs/wcd-clsh-v2.c b/sound/soc/codecs/wcd-clsh-v2.c
index 1be82113c59a..817d8259758c 100644
--- a/sound/soc/codecs/wcd-clsh-v2.c
+++ b/sound/soc/codecs/wcd-clsh-v2.c
@@ -480,7 +480,6 @@ static int _wcd_clsh_ctrl_set_state(struct wcd_clsh_ctrl *ctrl, int req_state,
 	case WCD_CLSH_STATE_HPHR:
 		wcd_clsh_state_hph_r(ctrl, req_state, is_enable, mode);
 		break;
-		break;
 	case WCD_CLSH_STATE_LO:
 		wcd_clsh_state_lo(ctrl, req_state, is_enable, mode);
 		break;
diff --git a/sound/soc/codecs/wl1273.c b/sound/soc/codecs/wl1273.c
index c56b9329240f..d8ced4559bf2 100644
--- a/sound/soc/codecs/wl1273.c
+++ b/sound/soc/codecs/wl1273.c
@@ -311,7 +311,6 @@ static int wl1273_startup(struct snd_pcm_substream *substream,
 		break;
 	default:
 		return -EINVAL;
-		break;
 	}
 
 	return 0;
diff --git a/sound/soc/intel/skylake/skl-pcm.c b/sound/soc/intel/skylake/skl-pcm.c
index bbe8d782e0af..b1ca64d2f7ea 100644
--- a/sound/soc/intel/skylake/skl-pcm.c
+++ b/sound/soc/intel/skylake/skl-pcm.c
@@ -502,7 +502,6 @@ static int skl_pcm_trigger(struct snd_pcm_substream *substream, int cmd,
 		if (ret < 0)
 			return ret;
 		return skl_run_pipe(skl, mconfig->pipe);
-		break;
 
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
diff --git a/sound/soc/ti/davinci-mcasp.c b/sound/soc/ti/davinci-mcasp.c
index a6b72ad53b43..2d85cc4c67fb 100644
--- a/sound/soc/ti/davinci-mcasp.c
+++ b/sound/soc/ti/davinci-mcasp.c
@@ -2385,7 +2385,6 @@ static int davinci_mcasp_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "No DMA controller found (%d)\n", ret);
 	case -EPROBE_DEFER:
 		goto err;
-		break;
 	}
 
 	if (ret) {
-- 
2.18.1

