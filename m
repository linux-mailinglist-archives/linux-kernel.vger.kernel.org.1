Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A2EA216EEB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jul 2020 16:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728542AbgGGOi2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jul 2020 10:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728495AbgGGOiW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 10:38:22 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5AF7C08C5EE
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 07:38:21 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id k6so45427601wrn.3
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 07:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=c4/atXJGhj1n0uTQI5cYV/gQNs+sjaOZMgJsAAMgfWA=;
        b=XexzV3KJ/Ugols+x89JArM434s7OMKFDWfksKXZoXwvRPrZMNSE+f1ahUBOak/G6cr
         Keb/Ao22IP697YEQuWmJupSw5F3K/5J4cfUmQ5Fl6aUnL1sST5sDk+u40SDimh/L/lCl
         of3/5TIli6NqTueNigm2UK09ss1j2CEvGpCp00FM4lCEZ7IoFQqsuiKaRVlDj1P9gSLK
         f2gWtR8gu6UZJvkilbAYzBQtLrjTrOV0JNNHsHbp1W1UUPujKE+2HaqwnrtxfyY+9ffT
         4Mx83dlZKFZ5StSTuhzRvUYOKDxMDqDEH3Z078Ltg9OM3w6VVK9I+0Blditu6KMrKP4B
         FRBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=c4/atXJGhj1n0uTQI5cYV/gQNs+sjaOZMgJsAAMgfWA=;
        b=qU2QBKvnTW0S25+crdT/aso60HvoAQObqhoEDfuePQNjMhzNHrOTh8xAD22ncHRIoX
         FMR4QmGwcD1E0RvByKbejF/0vxoebB0E0P3tFThhmPf8qS+tVK7YVXHPP3hBj3JrS3Wy
         h1B015P5fYwJ7XKRn8EKgPlLD+KwnH1mvE+oexyC2aqh6GCJEIg4u2rp02RJsVPzfdXX
         qNVyI0Z+g2JCJb7JQyM39xcw9kmNvOfbHIWW+gpUg2LVLWMgceZT4fJ4YvOmTA4Dh61j
         UgUkxs9uHoK0O62MRLotLpydXsfbImBEpL6Z9lTmohNvK/YA3T6817fruekqAUHN5mrN
         DfTw==
X-Gm-Message-State: AOAM531T9iX0wA/y2dGNo3xr0VgYOQH52CP0WGR8Cjn6iHL5TLj0V2j4
        iG+FZ3hdkeNooiuw5a969LEDd4DfDIk=
X-Google-Smtp-Source: ABdhPJwUIuU6BxAOBk4GhOQGfCgIR0VqwtdE96hRGr8Pp3rz/+R0BNo2yo13BD/FqfNnN+jvPo7jQw==
X-Received: by 2002:a5d:6912:: with SMTP id t18mr53340540wru.411.1594132700570;
        Tue, 07 Jul 2020 07:38:20 -0700 (PDT)
Received: from localhost.localdomain ([2.27.35.206])
        by smtp.gmail.com with ESMTPSA id y16sm1276131wro.71.2020.07.07.07.38.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jul 2020 07:38:19 -0700 (PDT)
From:   Lee Jones <lee.jones@linaro.org>
To:     broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz,
        tiwai@suse.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, Lee Jones <lee.jones@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        ter Huurne <maarten@treewalker.org>
Subject: [PATCH v2 24/28] ASoC: codecs: jz4770: Remove defined but never used variable 'mic_boost_tlv'
Date:   Tue,  7 Jul 2020 15:37:38 +0100
Message-Id: <20200707143742.2959960-25-lee.jones@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200707143742.2959960-1-lee.jones@linaro.org>
References: <20200707143742.2959960-1-lee.jones@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following W=1 kernel build warning(s):

 In file included from include/sound/tlv.h:10,
 from sound/soc/codecs/jz4770.c:19:
 sound/soc/codecs/jz4770.c:306:35: warning: ‘mic_boost_tlv’ defined but not used [-Wunused-const-variable=]
 306 | static const DECLARE_TLV_DB_SCALE(mic_boost_tlv, 0, 400, 0);
 | ^~~~~~~~~~~~~
 include/uapi/sound/tlv.h:64:15: note: in definition of macro ‘SNDRV_CTL_TLVD_DECLARE_DB_SCALE’
 64 | unsigned int name[] = { | ^~~~
 sound/soc/codecs/jz4770.c:306:14: note: in expansion of macro ‘DECLARE_TLV_DB_SCALE’
 306 | static const DECLARE_TLV_DB_SCALE(mic_boost_tlv, 0, 400, 0);
 | ^~~~~~~~~~~~~~~~~~~~

Cc: Paul Cercueil <paul@crapouillou.net>
Cc: ter Huurne <maarten@treewalker.org>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 sound/soc/codecs/jz4770.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/jz4770.c b/sound/soc/codecs/jz4770.c
index 34775aa624024..4dee585761c24 100644
--- a/sound/soc/codecs/jz4770.c
+++ b/sound/soc/codecs/jz4770.c
@@ -303,7 +303,6 @@ static int jz4770_codec_digital_mute(struct snd_soc_dai *dai, int mute)
 static const DECLARE_TLV_DB_MINMAX_MUTE(dac_tlv, -3100, 0);
 static const DECLARE_TLV_DB_SCALE(adc_tlv, 0, 100, 0);
 static const DECLARE_TLV_DB_MINMAX(out_tlv, -2500, 600);
-static const DECLARE_TLV_DB_SCALE(mic_boost_tlv, 0, 400, 0);
 static const DECLARE_TLV_DB_SCALE(linein_tlv, -2500, 100, 0);
 
 /* Unconditional controls. */
-- 
2.25.1

