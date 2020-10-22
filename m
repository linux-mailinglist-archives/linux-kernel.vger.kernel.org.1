Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44B55295F57
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 15:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2507500AbgJVNFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 09:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2507266AbgJVNFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 09:05:38 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26C2C0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 06:05:37 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id l15so2139854wmi.3
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 06:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zD2fhi7uj9wBjpHePs1vSB8IMMPxOp1dR+wvh8+B+NQ=;
        b=SQYceg6i2VBNXJV0SqUIN3SzJ+LinPXiudKj9p4WhH20AIq99iSAzFuU0gqOhbisM1
         rx4wCimkQLGpiFi2XgQkhAPXcEoHSBKipsptBmN6/rFuOdnRxtCiqv1kbknDO9/9pKVh
         EMmPRNFHAzs+ffDamD2zct0CZESrLyZZQKGg6A3MEY9hFWyhnptcVMpI+NmI9lqGmwg8
         rNMRa9aTSkCQ8gNBR/FCE6I7YBUU2bWqLCJKY4TvOGp9ss/ATvPnA1dfkrsXqKFRFLe7
         Hd16SHdVx2VGgiLtuxKBU0nDZfJ3jNBgPtmmy+tD/S5Zo8zgDbHlJrEgvIdRe3RfE58d
         zPEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zD2fhi7uj9wBjpHePs1vSB8IMMPxOp1dR+wvh8+B+NQ=;
        b=BzechwmflKnDHXH/be+TIberUPbDtfXcu1rcTgD7c4zUQkDqV4jPsJjF86iMwFZRFR
         ejfvz5FT/movrhfC5p84Y6lTnGIL9meU+m0qs5HHR0SP6v4Gb3cEmscSWQLs1Wlz30oD
         mk2dLuoBVIsNacKeykyetvMLVu+KVg0Tm5ouNzlDymwkjXS9zuyMwwasMXAV4mvAkLoM
         48as0DAZ7wUTjJiI5gyMZqpW2Z7/AhnhfHq7QXnhRJVn4oNlRnbtXiEB4jtlW6c0P6zy
         WBArVYJs/J2rlZvQclfmLMwVrzhBzVvOZtdHwSgEry43uAIF33vvlHeLrIfPE/CazJ9W
         L4Aw==
X-Gm-Message-State: AOAM533iSGeMQWOUZlBSHq3ZkvFlqiYIFiThvp2yIR4eYgB85bKYvGH/
        oNtF2C2pBGy94A71nkg7azQgDg==
X-Google-Smtp-Source: ABdhPJwreKUFAFyls6vhjyjWZPDdzxUvqssC05P6DYwqnrR/UL+rlWKOwLkeDzlANgGwX8CnusZndg==
X-Received: by 2002:a1c:2d53:: with SMTP id t80mr2342033wmt.125.1603371935248;
        Thu, 22 Oct 2020 06:05:35 -0700 (PDT)
Received: from srini-hackbox.lan (cpc86377-aztw32-2-0-cust226.18-1.cable.virginm.net. [92.233.226.227])
        by smtp.gmail.com with ESMTPSA id y185sm3592680wmb.29.2020.10.22.06.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 06:05:34 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     broonie@kernel.org
Cc:     perex@perex.cz, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH] ASoC: codecs: wsa881x: add missing stream rates and format
Date:   Thu, 22 Oct 2020 14:05:18 +0100
Message-Id: <20201022130518.31723-1-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing supported rates and formats for the stream, without
which attempt to do playback will fail to find any matching rates/format.

Fixes: a0aab9e1404a ("ASoC: codecs: add wsa881x amplifier support")
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/codecs/wsa881x.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/wsa881x.c b/sound/soc/codecs/wsa881x.c
index d39d479e2378..5456124457a7 100644
--- a/sound/soc/codecs/wsa881x.c
+++ b/sound/soc/codecs/wsa881x.c
@@ -1026,6 +1026,8 @@ static struct snd_soc_dai_driver wsa881x_dais[] = {
 		.id = 0,
 		.playback = {
 			.stream_name = "SPKR Playback",
+			.rates = SNDRV_PCM_RATE_48000,
+			.formats = SNDRV_PCM_FMTBIT_S16_LE,
 			.rate_max = 48000,
 			.rate_min = 48000,
 			.channels_min = 1,
-- 
2.21.0

