Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2515F281F12
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 01:31:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725768AbgJBXbH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 19:31:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgJBXbG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 19:31:06 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79CACC0613D0
        for <linux-kernel@vger.kernel.org>; Fri,  2 Oct 2020 16:31:06 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id x2so1851985pjk.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Oct 2020 16:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=39rkTJtXlFtQ5/5T04uloKyyaaDBj+PUdUyBnDF91SY=;
        b=Wo0WXvRXCTZCYAnRy54cVvMfWfk8J8vBHzs0KphLbfDr+ANdKqCO8PbXyYgaztabd/
         X5JHMAoHAsbDH1ngAJokOBDIUEB7XGS6j7o+xLsT1G4eq+ztQLAREKYFjJkrgGEkPp/B
         BREYOg2HKQvhI2UZzwinmqw9naFXFjdnWd2JsuYV5HeLcVWCA6hoic1HcdOo5TE4OQ/k
         MsZ8e6QbAQmbpLL7IkSwpVXV+woUz1dKyhd88cPJPTRY+jboG6UX4+cMn8RdPx4FLp4f
         BrQ2l5UUQgIcbWzhMJWqQlofUixgd+o9KsVwkwlvAgGrQZJ+V59fWrW5YmwzQkHj4nVS
         VwNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=39rkTJtXlFtQ5/5T04uloKyyaaDBj+PUdUyBnDF91SY=;
        b=jHGP3Rbr06jzw0LhAN2A6z2MRgG66YjLEOYQqeoiR6a9HHf0RMm8AvEYSyAimlo0R5
         mtJpKzfipn6n25Tc8oX8QyuxZ7lcyGpaw2dZjEVp4LEb2V/RzXqiqoE8Tvi+85SvL5Wh
         76wSrDhHJiogfGwRD65pOfbvtp7nCrzxyfQJT6ZmKVWfXggv91qKFxH7uZcJ68p3iu0A
         tSo/ZHAMWeikr7N4tcodldCLvIP1dhYZ2qvZUXTB5TptRp9G2QZ7Mghcbj07KvGrB1vW
         4Kq2DHrxFRbCo7NSOu3C4rImyufBNG9+I62RC3hpfskK7kAA+YqpCDT3XTRrE8+PsCVv
         NAjA==
X-Gm-Message-State: AOAM531ZyKr/rQAp0/AdTt141cEET+1bzofNXAsg/I/4nDaUFoYVMq7T
        ZVNfnB539Gr5FkwB7UR0LuM=
X-Google-Smtp-Source: ABdhPJyUtQlg/rmFNBHDPU+1oFHbUZUbywYtOW1tMUg6dD64a2blGx0obpFn2zNJ9c452DW8VA8H0Q==
X-Received: by 2002:a17:90a:6685:: with SMTP id m5mr5010628pjj.235.1601681465996;
        Fri, 02 Oct 2020 16:31:05 -0700 (PDT)
Received: from localhost ([2001:e42:102:1532:160:16:113:140])
        by smtp.gmail.com with ESMTPSA id 11sm2704492pja.8.2020.10.02.16.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2020 16:31:05 -0700 (PDT)
From:   Coiby Xu <coiby.xu@gmail.com>
To:     devel@driverdev.osuosl.org
Cc:     Alex Elder <elder@linaro.org>,
        Vaibhav Agarwal <vaibhav.sr@gmail.com>,
        Mark Greer <mgreer@animalcreek.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org (moderated list:GREYBUS SUBSYSTEM),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 2/3] staging: greybus: codecs: use SNDRV_PCM_FMTBIT_S16_LE for format bitmask
Date:   Sat,  3 Oct 2020 07:30:55 +0800
Message-Id: <20201002233057.74462-2-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201002233057.74462-1-coiby.xu@gmail.com>
References: <20201002233057.74462-1-coiby.xu@gmail.com>
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

Reviewed-by: Alex Elder <elder@linaro.org>
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

