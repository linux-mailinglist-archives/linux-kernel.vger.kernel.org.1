Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72BAD29E4B9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 08:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732852AbgJ2HqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 03:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732734AbgJ2Hpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 03:45:46 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84EF7C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:45:45 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id j18so1668980pfa.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lZ+bCLUPWFW4dhgVkM+HvetJi7WpGsivphFjqhZjB18=;
        b=J6Pse+8qTJnodLorMXhsLMbxAUsZqi6tDRGHyvRXfxKQCWDh2jC/bIDV11ZL5Bw/3Q
         ARowBURGJUnIK+NKb7hNvjieet9WHjE1K4Ab2sMAVamYFbwjozMn86+Zo5hJQf28IFYK
         VRFnzPyydM0zp+FfX9Dv7ntSvGEF1sS3/MbJCbZDgjPSPFbhuqdHCyQKfB0adogZqfW+
         oefhCIo1ErN/lKsHP9sgQsUGRO3F4ROzewcP786E5g0hrkYaHUTEekyMU2dRxZ4Wz9/3
         jrO+eHEt0KjhdaJ2eAjx+MqoHGCM76zKG41hYs6vEfZfILGuV+V8QQFDjfAgqOUpcpdf
         i53A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lZ+bCLUPWFW4dhgVkM+HvetJi7WpGsivphFjqhZjB18=;
        b=aSRB7x605fGY6ZzEii6eM/26VSV6Pzhxdri7LZjiNhiubWuLv/P0K0od7eaTjUzXrK
         QriN7bdFX7kVLnw7Az1prUoKg9Ickfb0AuFy8ceoWzbYd7bVR0ssaMuGsnOXebilJmoa
         55pOjrc6QdVBISGuUmjgtdbdtLGKj4RQiRfkLgNTpXlK+7xQedBIiRYYZ+0rRMHNLQ/J
         j0b7x+5c/fJ6KZRuneGpW5dKkeFG05Aa9LuspCewdQiZXp0YZaZTBVQUEIseDQOPx3zk
         uPZt+bEPOJ4rWhJs0ldJODEJhcG3jWip6G8wxOyTowj8O9IU7BrVaDgLCT8mz4srGtzN
         EiFA==
X-Gm-Message-State: AOAM533bO39FV8gU2JFJq1cOVVcgyeKNhSRCVtO9h6LMh2SjPIKg9Joj
        HMe4kckb3tfJRO6bOMsjEIs=
X-Google-Smtp-Source: ABdhPJw/tJMsfwgAxL9DNye+HsiaMI0nNmTnp3B33iBd0z4Mx+94V5Um/rn74SNsIYg1B7bUMAGcQw==
X-Received: by 2002:a17:90a:1189:: with SMTP id e9mr3139594pja.124.1603957545181;
        Thu, 29 Oct 2020 00:45:45 -0700 (PDT)
Received: from localhost ([2409:8a28:3c42:6840:9efc:e8ff:fef2:1cdc])
        by smtp.gmail.com with ESMTPSA id y5sm1665220pgo.5.2020.10.29.00.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 00:45:44 -0700 (PDT)
From:   Coiby Xu <coiby.xu@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org (moderated list:SOUND - SOC LAYER / DYNAMIC
        AUDIO POWER MANAGEM...), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 18/25] ASoC: codecs: max98373: remove unnecessary CONFIG_PM_SLEEP
Date:   Thu, 29 Oct 2020 15:42:54 +0800
Message-Id: <20201029074301.226644-18-coiby.xu@gmail.com>
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
 sound/soc/codecs/max98373-i2c.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/max98373-i2c.c b/sound/soc/codecs/max98373-i2c.c
index 92921e34f948..f847e7e76635 100644
--- a/sound/soc/codecs/max98373-i2c.c
+++ b/sound/soc/codecs/max98373-i2c.c
@@ -468,7 +468,6 @@ static struct snd_soc_dai_driver max98373_dai[] = {
 	}
 };
 
-#ifdef CONFIG_PM_SLEEP
 static int max98373_suspend(struct device *dev)
 {
 	struct max98373_priv *max98373 = dev_get_drvdata(dev);
@@ -487,7 +486,6 @@ static int max98373_resume(struct device *dev)
 	regcache_sync(max98373->regmap);
 	return 0;
 }
-#endif
 
 static const struct dev_pm_ops max98373_pm = {
 	SET_SYSTEM_SLEEP_PM_OPS(max98373_suspend, max98373_resume)
-- 
2.28.0

