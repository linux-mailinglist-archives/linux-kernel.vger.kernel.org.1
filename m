Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A12532EBEE3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jan 2021 14:40:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727052AbhAFNia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jan 2021 08:38:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726988AbhAFNi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jan 2021 08:38:28 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E3DEC06135C
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jan 2021 05:37:10 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id jx16so4984316ejb.10
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jan 2021 05:37:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EeqCcTaM9uvJ+oUlpZc6QqWpLGu/QRph3nZs6qZSs40=;
        b=SYg4zbGWg3hS7QGGgC6xByH65gg9gDp3bagriZ4Qy2fVe4+8PuT8FdnWmdC+11XeQI
         bBKpAWPMsL+qwm/mLQ2KzrNLRrKWD468oOnpHN17cX0HFGV8JFmwNUIuDW+8pgtV/9BI
         onh7FoeC7kXzwF9w3MogcxQf+zmhmCEFyVYqG4E/+XNOZ0VtHQz/mQXB0M7jv7/bbZ+Z
         t+bcaqaBeh/vlFyjSHHfcho/j1La8TWGyjG0jnn0dBQN3OTz407pq+Umk+Zb0YOdElAk
         VQRCVFWg6+kioOAclDx89+7L/h4in3iLkJpE+lw85MzPMO7oH9BqlRw01yKtnl/gXKl0
         +V7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EeqCcTaM9uvJ+oUlpZc6QqWpLGu/QRph3nZs6qZSs40=;
        b=h/v8JFCxXKBCH+g+oBkKRrAnmA8Tiyr3XOd7QMNr58Lf3gnSKCAdU7Ys2MmCywHqI3
         W3PvclAsrJy00+CNlYSPFpsiGo27eBj2NRYRiSpNjQFZFrr6A2y1qfXuxHwZoytw+klW
         EbG9yic6hTLDCBovsKiLhuKAzWydndqKzMdzuNZRMxb8APZRCrBn2GgZOVBomOeEohKV
         XK+BrsJR/R7WRH6bD/D3+S+PHZ7c82F5LOwyujvRbZPeydnoGw+lq9+X/ALHVsxhVkZt
         OAIQoVVRk404UGaUVkTMzcnoQtsTOIKA+LdTwWxj4GB/rsOLGdo7Z9CQ9Wt+aTlUQKkC
         zf4A==
X-Gm-Message-State: AOAM531Jb/D/3q9wZV4uKoBzb2ptxLsBeApR0SsaSHdiDWqAPDVO1fJY
        rphj9IUZPKeaKuqRFlfiRlFuKw==
X-Google-Smtp-Source: ABdhPJwC9ki5CDdYpvYkHbirBbP2qKR4RcLxWRZRHQSIpcoH71TJ7ccWEfKFjVefbUPsSqgWGpEiEg==
X-Received: by 2002:a17:906:4d47:: with SMTP id b7mr2798016ejv.420.1609940229125;
        Wed, 06 Jan 2021 05:37:09 -0800 (PST)
Received: from localhost.localdomain (82-65-169-74.subs.proxad.net. [82.65.169.74])
        by smtp.googlemail.com with ESMTPSA id n20sm1259275ejo.83.2021.01.06.05.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jan 2021 05:37:08 -0800 (PST)
From:   Jerome Brunet <jbrunet@baylibre.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Jack Pham <jackp@codeaurora.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] usb: gadget: u_audio: factorize ssize to alsa fmt conversion
Date:   Wed,  6 Jan 2021 14:36:50 +0100
Message-Id: <20210106133652.512178-4-jbrunet@baylibre.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210106133652.512178-1-jbrunet@baylibre.com>
References: <20210106133652.512178-1-jbrunet@baylibre.com>
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
index 71dd9f16c246..045f237472a7 100644
--- a/drivers/usb/gadget/function/u_audio.c
+++ b/drivers/usb/gadget/function/u_audio.c
@@ -244,6 +244,25 @@ static snd_pcm_uframes_t uac_pcm_pointer(struct snd_pcm_substream *substream)
 	return bytes_to_frames(substream->runtime, prm->hw_ptr);
 }
 
+static u64 uac_ssize_to_fmt(int ssize)
+{
+	u64 ret;
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

