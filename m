Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA54C29E4BE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 08:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733302AbgJ2HqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 03:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733303AbgJ2HqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 03:46:18 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 734E0C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:46:18 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id 1so910131ple.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DqWaovVCPL/Bqrn37hn7W1rsqDZ6SlCUd1zEodOEgN8=;
        b=MnncO8tPOgIhA9PC4r2IzlM9lcXfkaicR8JQE4AgbFDrgX9Pu5cBANM6HRnFoLMn0c
         rSCotDOjsH0zi6C/Hnvdy/Cv6zcU5KLe2NP5Y85IHMM44pj1Dgqj77aNn4QD+3UjuQUb
         pgmk2DmksmAuOeOi8yWK9HnhjMwEkuI6AoAd9cPAtmecKboFqtUzeZCjU+t6eWTojnhr
         QgCgLo/11V8nr1KO+WiTSMA4eVzucOFdXZpi9lg8V4c/tYw7GhaT8QUNUerXvgv2Qk4r
         xAc3x5+KWJ6J3oyNyiwQHcNAm5KWCfcTersQXPCm4M7elwAViUne+RPUkLhZX54ZaZ/i
         g5cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DqWaovVCPL/Bqrn37hn7W1rsqDZ6SlCUd1zEodOEgN8=;
        b=IYjCOO4W90n2uXUa7w+m+HdH1aAlyBzz2XQ+v6Nm5ZsMXKXW6xVa0kkLwCuFoCF+re
         QHt5KaIXOmIl1xICziZuCTKDaHptCXkzXd5KZ5A+k6AY97mKXk3Le0dQUJny26fEXUFH
         EOzyNbrjQZ6OGf+xM3nWT4oqaVC37PwqZXyS9imS8ts11gh3wwcyPLpO1vnugaerV7sj
         ENpajc/ktGkFcmtPRw8F6DQynzIOc3seZX18LIBC3Lvk7RdnRuPucs1M9nuAnNlv7jLx
         Qi0UMyOb5EP93ydvO4wZMC3M8+SOanubRBoSjv8l/R4NEDrVeXoOgewT/HNtIYB4L/Vr
         JHVw==
X-Gm-Message-State: AOAM5336+Cp2QNJ8i4BfWLasbxDYVYFZsDz5fjiKvQZAxf8Ck2aWXTCs
        t5zzvGOImPr1yyGz8jMygYU=
X-Google-Smtp-Source: ABdhPJy+M1UIinoo2AEmLXQsGG3cg9gop3Jegb7FgZ80OjLmb5b3L8AQ0Sdx44L9Pm8IEoN6rwHMWw==
X-Received: by 2002:a17:902:740b:b029:d5:cbb0:fbe7 with SMTP id g11-20020a170902740bb02900d5cbb0fbe7mr2792992pll.27.1603957578094;
        Thu, 29 Oct 2020 00:46:18 -0700 (PDT)
Received: from localhost ([2409:8a28:3c42:6840:9efc:e8ff:fef2:1cdc])
        by smtp.gmail.com with ESMTPSA id ev5sm2462381pjb.2.2020.10.29.00.46.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 00:46:17 -0700 (PDT)
From:   Coiby Xu <coiby.xu@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org (moderated list:SOUND - SOC LAYER / DYNAMIC
        AUDIO POWER MANAGEM...), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 22/25] ASoC: max98927: remove unnecessary CONFIG_PM_SLEEP
Date:   Thu, 29 Oct 2020 15:42:58 +0800
Message-Id: <20201029074301.226644-22-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201029074301.226644-1-coiby.xu@gmail.com>
References: <20201029074301.226644-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SET_SYSTEM_SLEEP_PM_OPS has already took good care of CONFIG_PM_CONFIG.

Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
---
 sound/soc/codecs/max98927.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/max98927.c b/sound/soc/codecs/max98927.c
index 8b206ee77709..48c6aa78a410 100644
--- a/sound/soc/codecs/max98927.c
+++ b/sound/soc/codecs/max98927.c
@@ -794,7 +794,6 @@ static int max98927_probe(struct snd_soc_component *component)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int max98927_suspend(struct device *dev)
 {
 	struct max98927_priv *max98927 = dev_get_drvdata(dev);
@@ -813,7 +812,6 @@ static int max98927_resume(struct device *dev)
 	regcache_sync(max98927->regmap);
 	return 0;
 }
-#endif
 
 static const struct dev_pm_ops max98927_pm = {
 	SET_SYSTEM_SLEEP_PM_OPS(max98927_suspend, max98927_resume)
-- 
2.28.0

