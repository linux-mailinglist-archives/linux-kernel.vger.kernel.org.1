Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8DAF276E88
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 12:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbgIXKU4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 06:20:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726380AbgIXKU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 06:20:56 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70A51C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 03:20:56 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 34so1608310pgo.13
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 03:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zm8OOlfP7iSN8Z5QEpTuGr8Ee4ut7XyUwrYhe0zYYtU=;
        b=fTFAprBBug9rHfk2WN6RzGWwlchqNO3GsCw1+qad1ydwkFtdunbM6LjrJrcZIP+WEz
         U7GBnE8ywP9tqj08t44dj++6nZqDIy42Er2JpiA7E/SzSEiJCLwaPzNRhEBK0wgbTxjH
         Zul+rnwCDFHFX7khle3dGiEjIK56b5I+eiLCnaDtb87xAhbfb94Jy2HKAKB0kUbALGa4
         kbMGPgZPv3jiYSQJ/L7gNpNPF+D8C75+xtIkbtCxePf6M+POtM5in1w3owqESCWzYaqM
         Z9VkeOs1hXKqNTmRjLg4Gwl4r3H1pzHAr6DHkAqy4lLtfe3OelaGw4ABmBz2Li0WirxP
         vt7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zm8OOlfP7iSN8Z5QEpTuGr8Ee4ut7XyUwrYhe0zYYtU=;
        b=MhhpY43wuqB+HFmiSkffxXsns2+FvS3X2RPAY5bYVvEX02T4YsQrBXNY7PtVLTEAUh
         9KDL2proQxmaXmHnCg1s7gT8Sime3yFMaKyn/wpvfZW1khd5R0s7F6fjOeqaxmZcpp9c
         vrjyVcVZ5NWozrkXWa9cAnGYr13l4iNVfUJDhcPTYk0GygBIAi2jvK9U+rAKzRu7zr51
         JOgK/kDBZx9zH0HQDTmKw0JwZSGAmxnxfZPn00OwqToVZJBfnWSRYrAI9p5AMesTdDHB
         XbzLGUQTeqvRRk/MUYQlRkl7gGbjRRs8qR+4vbQ+rnuTwpmPxNd/CKVlJC+l612l5+UX
         40xg==
X-Gm-Message-State: AOAM533Mmsoc3MPxiapGjgeGWIokld1oCcqlL1ffkUKQWIzYTIp2L1+P
        0FlJK3QYiIbPZX66OwEWWWw=
X-Google-Smtp-Source: ABdhPJy0R9nsCIkgy+cT/BvPRyn00F2XAD27I58X5YB7kjJ7M5zzUhxgSoiCipTGlvIRf2jylwyqNg==
X-Received: by 2002:aa7:81d5:0:b029:142:2501:39fa with SMTP id c21-20020aa781d50000b0290142250139famr3950860pfn.73.1600942856051;
        Thu, 24 Sep 2020 03:20:56 -0700 (PDT)
Received: from localhost ([2001:e42:102:1532:160:16:113:140])
        by smtp.gmail.com with ESMTPSA id b2sm2505030pfp.3.2020.09.24.03.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2020 03:20:55 -0700 (PDT)
From:   Coiby Xu <coiby.xu@gmail.com>
To:     devel@driverdev.osuosl.org
Cc:     Vaibhav Agarwal <vaibhav.sr@gmail.com>,
        Mark Greer <mgreer@animalcreek.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org (moderated list:GREYBUS SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/3] staging: greybus: codecs: use SNDRV_PCM_FMTBIT_S16_LE for format bitmask
Date:   Thu, 24 Sep 2020 18:20:38 +0800
Message-Id: <20200924102039.43895-2-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200924102039.43895-1-coiby.xu@gmail.com>
References: <20200924102039.43895-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

snd_soc_pcm_stream.formats should use the bitmask SNDRV_PCM_FMTBIT_*
instead of the sequential integers SNDRV_PCM_FORMAT_* as explained by
commit e712bfca1ac1f63f622f87c2f33b57608f2a4d19
("ASoC: codecs: use SNDRV_PCM_FMTBIT_* for format bitmask").

Found by sparse,

$ make C=2 drivers/staging/greybus/
drivers/staging/greybus/audio_codec.c:691:36: warning: incorrect type in initializer (different base types)
drivers/staging/greybus/audio_codec.c:691:36:    expected unsigned long long [usertype] formats
drivers/staging/greybus/audio_codec.c:691:36:    got restricted snd_pcm_format_t [usertype]
drivers/staging/greybus/audio_codec.c:701:36: warning: incorrect type in initializer (different base types)
drivers/staging/greybus/audio_codec.c:701:36:    expected unsigned long long [usertype] formats
drivers/staging/greybus/audio_codec.c:701:36:    got restricted snd_pcm_format_t [usertype]

Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
---
 drivers/staging/greybus/audio_codec.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/greybus/audio_codec.c b/drivers/staging/greybus/audio_codec.c
index 74538f8c5fa4..494aa823e998 100644
--- a/drivers/staging/greybus/audio_codec.c
+++ b/drivers/staging/greybus/audio_codec.c
@@ -688,7 +688,7 @@ static struct snd_soc_dai_driver gbaudio_dai[] = {
 		.playback = {
 			.stream_name = "I2S 0 Playback",
 			.rates = SNDRV_PCM_RATE_48000,
-			.formats = SNDRV_PCM_FORMAT_S16_LE,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE,
 			.rate_max = 48000,
 			.rate_min = 48000,
 			.channels_min = 1,
@@ -698,7 +698,7 @@ static struct snd_soc_dai_driver gbaudio_dai[] = {
 		.capture = {
 			.stream_name = "I2S 0 Capture",
 			.rates = SNDRV_PCM_RATE_48000,
-			.formats = SNDRV_PCM_FORMAT_S16_LE,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE,
 			.rate_max = 48000,
 			.rate_min = 48000,
 			.channels_min = 1,
-- 
2.28.0

