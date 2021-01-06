Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F35A2EBEE5
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 14:40:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbhAFNic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 08:38:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727035AbhAFNi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 08:38:29 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3CA4C061360
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 05:37:12 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id ce23so5020351ejb.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 05:37:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jMFwjDy/Cb2t1FpYK1S0P8jc5Da5ImJmRl86sM+aIPk=;
        b=hcw+HELw6+n621TvSxRMA6A84EGzFGLBubtMuoWWoBQK2ra4z+kYXSgFsrJ9QlgfSO
         T+JoKmnIfj4coHADMramA+JIL0jAMfJMf66p6Sn/NZWj3+F/R7Ipl4iTz89qp97SbjRo
         lAXG4jYm9ktwhZAEkW7qCelPEQYbfE902wSYGOMXunoEzJ2dUgQSWUQEdRRHjvzLcvJ2
         vSJk7cjLUonMBxS0On49z9BFvKtroadzDU9Iz2umCncnzZiX8ACBcBTmJo/5TYm8jTHU
         7kH+G13texDDVEqoUWWgC2hRBXMoFds78AQsiynF3KN+1g5ap4lcbGVRD5oTFlKU4jgB
         39ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jMFwjDy/Cb2t1FpYK1S0P8jc5Da5ImJmRl86sM+aIPk=;
        b=YqgxBX02CWMb2bmWwY8peWN/yHnuIJJGGPtCme1L1dDav2SjHSAW7IKPr9f1UqQHtK
         lTtY1ihe3FyBNorAXtLlz64d6VuNN7BmT8GiBCQDNK2p21O4BerQw55muI9NEEHDdnWC
         lf4eb+oPV59WpTPPvHTqu0pTtVJ1vj7oGzow7AbKPVcBNO1xHcvDEr4Rv5SCWuJzTAjF
         3bZoJp+00IZ65WIB++vpOhXcSqAKCw1pdCUIDst+7f3McGeZ2nk1l2r3euxwKzu4vUGq
         UWGZxc0u09lrAT01OtL62akEhMwm/qjSQBjW6Q3oSlmUpnR1xTiMYXWdMEAytKQlpBHl
         az+w==
X-Gm-Message-State: AOAM5330efY4QH88FtymRdGq8onXZIlz/t8DrK1O3j/sQfs3Qu+kLA3t
        eepskrSuFqPAsscpXPF0yv3VkQ==
X-Google-Smtp-Source: ABdhPJzPjr2phle+6BlSN3F/cEU/QBwoLNEZacKP2OTz7iuHYHYfQv8QqRVdKmHF9oxvROZmevrfhg==
X-Received: by 2002:a17:906:5f97:: with SMTP id a23mr3027841eju.128.1609940231514;
        Wed, 06 Jan 2021 05:37:11 -0800 (PST)
Received: from localhost.localdomain (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.googlemail.com with ESMTPSA id n20sm1259275ejo.83.2021.01.06.05.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 05:37:10 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Jack Pham <jackp@codeaurora.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] usb: gadget: u_audio: clean up locking
Date:   Wed,  6 Jan 2021 14:36:52 +0100
Message-Id: <20210106133652.512178-6-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210106133652.512178-1-jbrunet@baylibre.com>
References: <20210106133652.512178-1-jbrunet@baylibre.com>
MIME-Version: 1.0
X-Patchwork-Bot: notify
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

snd_pcm_stream_lock() is held when the ALSA .trigger() callback is called.
The lock of 'struct uac_rtd_params' is not necessary since all its locking
operation are done under the snd_pcm_stream_lock() too.

Also, usb_request .complete() is called with irqs disabled, so saving and
restoring the irqs is not necessary.

Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
---
 drivers/usb/gadget/function/u_audio.c | 23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/drivers/usb/gadget/function/u_audio.c b/drivers/usb/gadget/function/u_audio.c
index 1d12657b3b73..e985630fbe6e 100644
--- a/drivers/usb/gadget/function/u_audio.c
+++ b/drivers/usb/gadget/function/u_audio.c
@@ -36,9 +36,8 @@ struct uac_rtd_params {
 	void *rbuf;
 
 	unsigned int max_psize;	/* MaxPacketSize of endpoint */
-	struct usb_request **reqs;
 
-	spinlock_t lock;
+	struct usb_request **reqs;
 };
 
 struct snd_uac_chip {
@@ -74,7 +73,6 @@ static const struct snd_pcm_hardware uac_pcm_hardware = {
 static void u_audio_iso_complete(struct usb_ep *ep, struct usb_request *req)
 {
 	unsigned int pending;
-	unsigned long flags, flags2;
 	unsigned int hw_ptr;
 	int status = req->status;
 	struct snd_pcm_substream *substream;
@@ -105,16 +103,14 @@ static void u_audio_iso_complete(struct usb_ep *ep, struct usb_request *req)
 	if (!substream)
 		goto exit;
 
-	snd_pcm_stream_lock_irqsave(substream, flags2);
+	snd_pcm_stream_lock(substream);
 
 	runtime = substream->runtime;
 	if (!runtime || !snd_pcm_running(substream)) {
-		snd_pcm_stream_unlock_irqrestore(substream, flags2);
+		snd_pcm_stream_unlock(substream);
 		goto exit;
 	}
 
-	spin_lock_irqsave(&prm->lock, flags);
-
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
 		/*
 		 * For each IN packet, take the quotient of the current data
@@ -141,8 +137,6 @@ static void u_audio_iso_complete(struct usb_ep *ep, struct usb_request *req)
 
 	hw_ptr = prm->hw_ptr;
 
-	spin_unlock_irqrestore(&prm->lock, flags);
-
 	/* Pack USB load in ALSA ring buffer */
 	pending = runtime->dma_bytes - hw_ptr;
 
@@ -166,12 +160,10 @@ static void u_audio_iso_complete(struct usb_ep *ep, struct usb_request *req)
 		}
 	}
 
-	spin_lock_irqsave(&prm->lock, flags);
 	/* update hw_ptr after data is copied to memory */
 	prm->hw_ptr = (hw_ptr + req->actual) % runtime->dma_bytes;
 	hw_ptr = prm->hw_ptr;
-	spin_unlock_irqrestore(&prm->lock, flags);
-	snd_pcm_stream_unlock_irqrestore(substream, flags2);
+	snd_pcm_stream_unlock(substream);
 
 	if ((hw_ptr % snd_pcm_lib_period_bytes(substream)) < req->actual)
 		snd_pcm_period_elapsed(substream);
@@ -187,7 +179,6 @@ static int uac_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 	struct uac_rtd_params *prm;
 	struct g_audio *audio_dev;
 	struct uac_params *params;
-	unsigned long flags;
 	int err = 0;
 
 	audio_dev = uac->audio_dev;
@@ -198,8 +189,6 @@ static int uac_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 	else
 		prm = &uac->c_prm;
 
-	spin_lock_irqsave(&prm->lock, flags);
-
 	/* Reset */
 	prm->hw_ptr = 0;
 
@@ -216,8 +205,6 @@ static int uac_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
 		err = -EINVAL;
 	}
 
-	spin_unlock_irqrestore(&prm->lock, flags);
-
 	/* Clear buffer after Play stops */
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK && !prm->ss)
 		memset(prm->rbuf, 0, prm->max_psize * params->req_number);
@@ -280,14 +267,12 @@ static int uac_pcm_open(struct snd_pcm_substream *substream)
 	runtime->hw = uac_pcm_hardware;
 
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
-		spin_lock_init(&uac->p_prm.lock);
 		runtime->hw.rate_min = p_srate;
 		runtime->hw.formats = uac_ssize_to_fmt(p_ssize);
 		runtime->hw.channels_min = num_channels(p_chmask);
 		runtime->hw.period_bytes_min = 2 * uac->p_prm.max_psize
 						/ runtime->hw.periods_min;
 	} else {
-		spin_lock_init(&uac->c_prm.lock);
 		runtime->hw.rate_min = c_srate;
 		runtime->hw.formats = uac_ssize_to_fmt(c_ssize);
 		runtime->hw.channels_min = num_channels(c_chmask);
-- 
2.29.2

