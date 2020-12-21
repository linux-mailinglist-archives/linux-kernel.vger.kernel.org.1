Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C51E2DFFE9
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 19:37:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726963AbgLUSgX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 13:36:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726855AbgLUSgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 13:36:23 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14DBFC0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 10:35:42 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id o17so26063825lfg.4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Dec 2020 10:35:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nk1WbTku/ptwimEpWVF9T+Es0gLNCmrcP2x+3MKG7iM=;
        b=JOeMsmrMEqBux4BNP1j8g04oh0OzDgap7eVMEvDocXqACKFHd1t/rBIJ6RZvaHFE2i
         K8LYMk77pPBkHpLMbeCIx8VCOUujqfswqenZw4UNX6X7Dh2Pi53dbvmazJ0oxf81dg3t
         wM7nmbhAhodkQr08hkGOG1sE1gzJXdr4IxSCN//ZxoALzdZ70PY5w5BKG0/0kZ+pg4Cn
         gYfBETlB2MKucmYgUEohEIW9LSpz4naKpk6uuc8ssXjZR6N/oBIE+LvgN9NXW+m7vchU
         ZLMPmsC60u/YO1xDP14uN7BrAm+kir6WgHB4/kPyNXPU3DkJ/jPrw85UZDZIpwl3JCtK
         MHpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nk1WbTku/ptwimEpWVF9T+Es0gLNCmrcP2x+3MKG7iM=;
        b=Q+A6wDDiURmryJPwUMriA1XPjhsJ0zZu64Dt8peuriDIOHoEdnYQeqy81trYjirrtP
         DifImYZSBgeGK0Ld+zhN8Y1WE8v7umKbuuyjvrXqHkaJHyp1moLHoYGI8FGs0Ub5eowV
         vyV91CLXbWTEFp5Wui8NKnuoa0+lRsp2CYkB+QWQqC0fv1OCco+4/c1hUG6+JaVTGDuI
         CamcyPYE/d607OtsALiiqpVUe+BirT7GcXRPUi9SUDesZ0vHk1wCjGx4ntRjHGUzFPJO
         B5tNbq5PPhIQrth4JtTJxKTC17yYl1ZALVlEG4w7QbmbuzdJeuytOqcnKZWVvgcmuKgO
         Qffg==
X-Gm-Message-State: AOAM531MPndjg6vmb2HM5WRB0vijz+khgZcdwxK5pOSD4v94T+9OWh2v
        ASKRbAM2KL2BhVw6wB8Q0cZXwsbYzLFxZQaE
X-Google-Smtp-Source: ABdhPJwxnber/WN8Pp2C6NggYOZ2JTzIpi4X/wQW6fI06E255TkxOz5y9ZiUzA3T9Gh+laChy4PUbQ==
X-Received: by 2002:a17:906:ae0c:: with SMTP id le12mr16500568ejb.283.1608572142949;
        Mon, 21 Dec 2020 09:35:42 -0800 (PST)
Received: from starbuck.lan (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.googlemail.com with ESMTPSA id dd18sm9338408ejb.53.2020.12.21.09.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Dec 2020 09:35:42 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] usb: gadget: u_audio: factorize ssize to alsa fmt conversion
Date:   Mon, 21 Dec 2020 18:35:29 +0100
Message-Id: <20201221173531.215169-3-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201221173531.215169-1-jbrunet@baylibre.com>
References: <20201221173531.215169-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Factorize format related code common to the capture and playback path.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/usb/gadget/function/u_audio.c | 43 +++++++++++++--------------
 1 file changed, 21 insertions(+), 22 deletions(-)

diff --git a/drivers/usb/gadget/function/u_audio.c b/drivers/usb/gadget/function/u_audio.c
index 71dd9f16c246..2f69bd572ed7 100644
--- a/drivers/usb/gadget/function/u_audio.c
+++ b/drivers/usb/gadget/function/u_audio.c
@@ -244,6 +244,25 @@ static snd_pcm_uframes_t uac_pcm_pointer(struct snd_pcm_substream *substream)
 	return bytes_to_frames(substream->runtime, prm->hw_ptr);
 }
 
+static unsigned long uac_ssize_to_fmt(int ssize)
+{
+	unsigned long ret;
+
+	switch (ssize) {
+	case 3:
+		ret = SNDRV_PCM_FMTBIT_S24_3LE;
+		break;
+	case 4:
+		ret = SNDRV_PCM_FMTBIT_S32_LE;
+		break;
+	default:
+		ret = SNDRV_PCM_FMTBIT_S16_LE;
+		break;
+	}
+
+	return ret;
+}
+
 static int uac_pcm_open(struct snd_pcm_substream *substream)
 {
 	struct snd_uac_chip *uac = snd_pcm_substream_chip(substream);
@@ -269,34 +288,14 @@ static int uac_pcm_open(struct snd_pcm_substream *substream)
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		spin_lock_init(&uac->p_prm.lock);
 		runtime->hw.rate_min = p_srate;
-		switch (p_ssize) {
-		case 3:
-			runtime->hw.formats = SNDRV_PCM_FMTBIT_S24_3LE;
-			break;
-		case 4:
-			runtime->hw.formats = SNDRV_PCM_FMTBIT_S32_LE;
-			break;
-		default:
-			runtime->hw.formats = SNDRV_PCM_FMTBIT_S16_LE;
-			break;
-		}
+		runtime->hw.formats = uac_ssize_to_fmt(p_ssize);
 		runtime->hw.channels_min = num_channels(p_chmask);
 		runtime->hw.period_bytes_min = 2 * uac->p_prm.max_psize
 						/ runtime->hw.periods_min;
 	} else {
 		spin_lock_init(&uac->c_prm.lock);
 		runtime->hw.rate_min = c_srate;
-		switch (c_ssize) {
-		case 3:
-			runtime->hw.formats = SNDRV_PCM_FMTBIT_S24_3LE;
-			break;
-		case 4:
-			runtime->hw.formats = SNDRV_PCM_FMTBIT_S32_LE;
-			break;
-		default:
-			runtime->hw.formats = SNDRV_PCM_FMTBIT_S16_LE;
-			break;
-		}
+		runtime->hw.formats = uac_ssize_to_fmt(c_ssize);
 		runtime->hw.channels_min = num_channels(c_chmask);
 		runtime->hw.period_bytes_min = 2 * uac->c_prm.max_psize
 						/ runtime->hw.periods_min;
-- 
2.29.2

