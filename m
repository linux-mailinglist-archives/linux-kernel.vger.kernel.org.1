Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23DBE2CD936
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Dec 2020 15:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729431AbgLCOcO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Dec 2020 09:32:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726237AbgLCOcM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Dec 2020 09:32:12 -0500
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 331AEC061A4E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Dec 2020 06:31:26 -0800 (PST)
Received: by mail-pl1-x642.google.com with SMTP id p6so1235202plr.7
        for <linux-kernel@vger.kernel.org>; Thu, 03 Dec 2020 06:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hnyiBvxmu2Imkb8YDUhf4+16pZ6KZ+zRDyXRDSKsA8M=;
        b=syD0iLsQa6z1saep79dA/xw7JPVfQyJKbp45iEqgSjeQwcTNVtZIQkTT+PVkG6sa3+
         Nh94KSSs0XAR1Vi6QAdBWTQVpVGNDZEuN7AHMg9ZdLWGaxFg6kG0u+dR8sUcA58H7Zbk
         dzhR8W8EgeD/Wv6oG2uFkz2CyClqnlfsAFVgnnBcIfsF5eUZHyY25b2mVTSTN2YAw301
         bmz8Q5poPfBv3ZxnjBsKCUVcKyC4FDm5v7U12ZQTUw6PRwdQPXNaCmx5iXSHPtI99cXG
         0iVAs6RyRn2E7Rqz1EwnNtDMY8lOUSTMq/qRwGuNfroBteC1NsaaMLJhKZXrGQL3S1rt
         Ftnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hnyiBvxmu2Imkb8YDUhf4+16pZ6KZ+zRDyXRDSKsA8M=;
        b=g5c2N4CUbLqz1iLvicHLoISwbSz+hszhIACaYdPO+cCQKlZ5yPFIqDLQWzgF72Y0nQ
         dLCr/VmTfKEij3mosFh5+nbgQzOxXfTRyzK+dRIU84KJE09fE8zlaBscOJJo3jjygm2E
         v7KCYuR2QyTKOvLXgJVg45pEVBL/CZYML0RfTx4NmBPSNJYR2J53buzMGHAXDHc6xaSP
         dCTWDu9xG7F6Aln+FiIW1oauN68hvswx92OM1naCwwSeKJiT85iKJvm5MFWh3UaWfDs4
         pcFeOYp4+oSEns4aNaot83A7/wGlouYlyMtl1emjwn4wrLV2n5sTk5K3fxvcxb7ejo6N
         svqw==
X-Gm-Message-State: AOAM53387Mc/R308hdqP/KfJw+BVc79eK3HhD49sbX0Vh+hqHaBfH0Ko
        +AnNeIjiPzyoPKm2pVzp9Cw=
X-Google-Smtp-Source: ABdhPJygAEK71UM3UL3r/3tAF+CXzkZXYCEnKN3leuYBtdEK/YM3FiaDOt0VCIDAqg4EN0wj2I8KRQ==
X-Received: by 2002:a17:902:7c8d:b029:da:625c:8218 with SMTP id y13-20020a1709027c8db02900da625c8218mr3339949pll.26.1607005885797;
        Thu, 03 Dec 2020 06:31:25 -0800 (PST)
Received: from suzukaze.ipads-lab.se.sjtu.edu.cn ([202.120.40.82])
        by smtp.gmail.com with ESMTPSA id h70sm1971909pfe.49.2020.12.03.06.31.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 06:31:25 -0800 (PST)
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
Subject: [PATCH] ASoC: amd: add missed checks for clk_get()
Date:   Thu,  3 Dec 2020 22:31:16 +0800
Message-Id: <20201203143116.405930-1-hslester96@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cz_da7219_init() does not check the return value of clk_get(),
while da7219_clk_enable() calls clk_set_rate() to dereference
the pointers.
Add checks to fix the problems.

Fixes: bb24a31ed584 ("ASoC: AMD: Configure wclk and bclk of master codec")
Signed-off-by: Chuhong Yuan <hslester96@gmail.com>
---
 sound/soc/amd/acp-da7219-max98357a.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index a7702e64ec51..d5185cd3106b 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -74,7 +74,12 @@ static int cz_da7219_init(struct snd_soc_pcm_runtime *rtd)
 	}
 
 	da7219_dai_wclk = clk_get(component->dev, "da7219-dai-wclk");
+	if (IS_ERR(da7219_dai_wclk))
+		return PTR_ERR(da7219_dai_wclk);
+
 	da7219_dai_bclk = clk_get(component->dev, "da7219-dai-bclk");
+	if (IS_ERR(da7219_dai_bclk))
+		return PTR_ERR(da7219_dai_bclk);
 
 	ret = snd_soc_card_jack_new(card, "Headset Jack",
 				SND_JACK_HEADSET | SND_JACK_LINEOUT |
-- 
2.26.2

