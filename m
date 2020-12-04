Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B9C22CE831
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 07:37:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbgLDGhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 01:37:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgLDGhK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 01:37:10 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC194C061A4F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 22:36:29 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id r9so2499470pjl.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 22:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d8zcL1eX6CvAPfDYqfT78b23zOBds1VQznv7wReCOyU=;
        b=GEVjSLhLfO+7YBd6hC05bIWrNYzx9F2pnutdRFYJ1+IKuwS7ZoUn+AVv3CfetyArsD
         BImgo9Bb20guGnnzUemlfcMdGuP3VedWB9JRgoVlZvF4Vzn1rg7TU6GG20nfreOHkT7o
         4WBwN2u5Gzdc8w+2F+KpN7yaPqgJzPQUFSKsg6p6uJeDLuB2b2qJzRYqf0spO33BNW23
         XCMXW68hf9FGj+nW0Wjrj6CtRsaYFkTm2bUqKJxvBQteC0Z3icJJmwEe4jL+5bpTbIC/
         5WJdbB74CAYI6JJYCOKUSVbhZW29sRSqHV+RRwMC95v8DiliBfqzLXJyVdKSGVKGrBZC
         zQYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=d8zcL1eX6CvAPfDYqfT78b23zOBds1VQznv7wReCOyU=;
        b=M0CbO+C6Nro0J2qN6UCGxOxgKdPKWCsaFqtyawLhdeB8CP0+Fcuk59JsCAQSGQngNe
         avwbor4pZUqy3EsdknZ7JSRcQJmD/eeJLUPIa6rTPSIGxCXeKJpz6BvgFyeNG377+XRi
         NTHm/xfxtxCLaoDgdiRHDGPULBK1QrljV4ZK4oevH+tpQA9TeouKcoMABZCOzlcpzKlm
         +W2eD1nz+qg4ifhjgzuhZLdI4tRSkiNYo0vY77NvvWsIrXNQV5dLzQZJNkCA7yqdS1Mr
         TjJ+rK9Dg2SrO5ycLmWbaqWrGKz4U7mk+gs2jH9IlQ5FoXK4RS8MpoQqLvQ0rGY1pjmC
         UPbg==
X-Gm-Message-State: AOAM533lIcBC4nthsAFvu5lpbUxjAwh0Rka7qfpi75G9PFgsGf2uGBiT
        Y+pH5t+YL5EZErSbNn++S/A=
X-Google-Smtp-Source: ABdhPJx6UqI+qe96zyrcJ0fjsLM79ORJhXCDk3xmBRveOXZPHpMfdOZ91FML3RrmePr0Fd+UGUrG6g==
X-Received: by 2002:a17:90a:550d:: with SMTP id b13mr2697496pji.133.1607063789062;
        Thu, 03 Dec 2020 22:36:29 -0800 (PST)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id s7sm1061799pju.37.2020.12.03.22.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 22:36:28 -0800 (PST)
From:   Chuhong Yuan <hslester96@gmail.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Agrawal Akshu <Akshu.Agrawal@amd.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Chuhong Yuan <hslester96@gmail.com>
Subject: [PATCH v2] ASoC: amd: change clk_get() to devm_clk_get() and add missed checks
Date:   Fri,  4 Dec 2020 14:36:10 +0800
Message-Id: <20201204063610.513556-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cz_da7219_init() does not check the return values of clk_get(),
while da7219_clk_enable() calls clk_set_rate() to dereference
the pointers.
Add checks to fix the problems.
Also, change clk_get() to devm_clk_get() to avoid data leak after
failures.

Fixes: bb24a31ed584 ("ASoC: AMD: Configure wclk and bclk of master codec")
Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
Changes in v2:
  - Replace clk_get() with devm_clk_get() to prevent data leak.

 sound/soc/amd/acp-da7219-max98357a.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index a7702e64ec51..849288d01c6b 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -73,8 +73,13 @@ static int cz_da7219_init(struct snd_soc_pcm_runtime *rtd)
 		return ret;
 	}
 
-	da7219_dai_wclk = clk_get(component->dev, "da7219-dai-wclk");
-	da7219_dai_bclk = clk_get(component->dev, "da7219-dai-bclk");
+	da7219_dai_wclk = devm_clk_get(component->dev, "da7219-dai-wclk");
+	if (IS_ERR(da7219_dai_wclk))
+		return PTR_ERR(da7219_dai_wclk);
+
+	da7219_dai_bclk = devm_clk_get(component->dev, "da7219-dai-bclk");
+	if (IS_ERR(da7219_dai_bclk))
+		return PTR_ERR(da7219_dai_bclk);
 
 	ret = snd_soc_card_jack_new(card, "Headset Jack",
 				SND_JACK_HEADSET | SND_JACK_LINEOUT |
-- 
2.26.2

