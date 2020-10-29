Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B2F0F29E4C0
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 08:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387455AbgJ2Hqh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 03:46:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387434AbgJ2Hq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 03:46:29 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04FFFC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:46:29 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t22so892560plr.9
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:46:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hgMIOmWXJ9K7HGBgYjrpbZiO//zL6oSGlqytPgNqLQI=;
        b=la+EKPpO5ct1LEVZzBW/CKbqNSoVB9EBbcTwNa8NqrRac3AeP3kR+Dk/aBG6reR1h8
         xjiNL7vgYbwfYhFetVIBRpoRPF5F3j8/+ZZjBxK++c82j1WsfQ5FOC1xL+J2zt3vP0aT
         +pA/adDZonS2lInCajm5fnXbXXfU3Okg3FAjaZuXP5h+4dDL7wGeDG3Bgp0cqSd6Qvb9
         EU/P2/ga305d8J7R232rm+2FwBTx+oAuPlV5TSFXL0NbITEOOe1vNlpSJfdvh+H2WNes
         OFWmki3fx22iiVPzteIEbxAFlsFni476OFJOHllXXDEHpu3896MowAloE45R+0uRQJBM
         ZByA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hgMIOmWXJ9K7HGBgYjrpbZiO//zL6oSGlqytPgNqLQI=;
        b=fDsh0wWY6unsW9EbWIu6x4OYCyTrVKq0FDpKMteXJ979nRQoJuYA9fmgjL3r0wGe2H
         RY5bHrwDkaHbNSeTOzc+G7+iex0v5hLEKfHPEwbJD70EyZkGaJ0X8nkpueCiHaF8HESj
         MzxFk/nqHrzEYev3/ear/mTGX86CC8aIehknXb+kWB/Ldxyhd0iF7YWrrSoI0hidUqKf
         7JRdZYjr9Jt7+AzwbTj1100KuA9550HR7vdDBjNbfE5f1e/I/bidFQuYetarMu8zOLkg
         3Eg7BvwKTBBk1Teu+AXdtek77edwaWIHEgIZuTSQxv1Zr79/pLxPy2BEOxD+VsqphgCZ
         9JdQ==
X-Gm-Message-State: AOAM533rR8yoBCRe3GmXwuc4BwEgTtuENWHgiTdtm3YzTMq20n8cfDIB
        Oqr66VBkYsgeBPvheskzDNU=
X-Google-Smtp-Source: ABdhPJwkeHvC8Be56N2RBknuP0794aGvpMrZ/6SsIv8vZ6hg6wh1m67mCsvKmNV5koJ9ORs1sunRZw==
X-Received: by 2002:a17:902:ba98:b029:d6:6b56:7131 with SMTP id k24-20020a170902ba98b02900d66b567131mr2897800pls.9.1603957588657;
        Thu, 29 Oct 2020 00:46:28 -0700 (PDT)
Received: from localhost ([2409:8a28:3c42:6840:9efc:e8ff:fef2:1cdc])
        by smtp.gmail.com with ESMTPSA id z3sm1852081pfk.159.2020.10.29.00.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 00:46:28 -0700 (PDT)
From:   Coiby Xu <coiby.xu@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        patches@opensource.cirrus.com (open list:WOLFSON MICROELECTRONICS
        DRIVERS),
        alsa-devel@alsa-project.org (moderated list:SOUND - SOC LAYER / DYNAMIC
        AUDIO POWER MANAGEM...), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 24/25] ASoC: wm8994: remove unnecessary CONFIG_PM_SLEEP
Date:   Thu, 29 Oct 2020 15:43:00 +0800
Message-Id: <20201029074301.226644-24-coiby.xu@gmail.com>
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
 sound/soc/codecs/wm8994.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index fc9ea198ac79..9294ad06f76d 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -4656,7 +4656,6 @@ static int wm8994_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int wm8994_suspend(struct device *dev)
 {
 	struct wm8994_priv *wm8994 = dev_get_drvdata(dev);
@@ -4681,7 +4680,6 @@ static int wm8994_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static const struct dev_pm_ops wm8994_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(wm8994_suspend, wm8994_resume)
-- 
2.28.0

