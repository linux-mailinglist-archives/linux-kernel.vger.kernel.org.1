Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3048B29E4AB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 08:45:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730056AbgJ2Hor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 03:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729831AbgJ2Hog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 03:44:36 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF80C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:44:36 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id g12so1646169pgm.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=UiWE1BDnMzq0w4cStIBBDPtKZjCua/B3Fm6Q5y7KxII=;
        b=dpXSOm0JyRrfZu6jwKKjBwt+khOLjMt/zuXhuZ0xq+dcyzm90bzcocd647Isfuz5yt
         SRyjBEVneC8nsATMpp6ZusV+e1rFTKDZXxXsTiZtXBAqQPPAfeToEDNfksUQoeZ51S5C
         icfesQUgvmiDyFqv25rtw8jFbZGX0EaLxpY7WHJT5bLTepargjKHO3ZchaQzYzUBwKke
         +FnYKpRUzjSg5chE747eSDPNkLdORqDYKhCzD7Lv1zqc0vuMLw/wapZvyACTqdI3i1pT
         to4pkCiBwEro1T1gUu5i6Mf3DI0Cs6DFpCDq/924BHimW8HMhDjZu57JhmnYN9Q1j1YE
         K5wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=UiWE1BDnMzq0w4cStIBBDPtKZjCua/B3Fm6Q5y7KxII=;
        b=JsRCdO5cLfOy1kMiADDZw/uvbPxGH2hBDrs73MRVa9KdPhbfr6g2ve+GwD77jQNDWa
         PD8ldAzAetxVD5ibgmpF7C01+y27pKbwLJ3Il6VOvemXOtY9t1Ywh5IkT0Y4GdSPifqx
         uEtUTjzyke+DzN8aWX72RHmo7u/tyHsiMyYRoy/d3RRaOVE3xLwCsPfBPteY4KLoBHE6
         88SfkGYSJoXed+JQAK8m5knNpB/DI3aPRYN/WC20iVloVRDVZPBBFk4NRC8T7j/uoMA4
         9cPqyhiMvvzatTi+sqoAXC5UaFLTFnJ/1Nu9f7BJHQcKegNaFEFYZ7GyE2lRMx8uLTO0
         z+9A==
X-Gm-Message-State: AOAM532y2YlRf9uhcO7kzZTsrSiZPMxZ9llYqVNy3a37RnDKZRe6IqZS
        AZnXacI3b2KCsadzQIrO6uU=
X-Google-Smtp-Source: ABdhPJw+g/uyNSWUT43pQjWbmj0HYrQtDyg3buKh1aC7FdNCWaAB7PGuvClSfB5HBIPm6hc6PiDxOw==
X-Received: by 2002:a63:7c56:: with SMTP id l22mr264873pgn.19.1603957476052;
        Thu, 29 Oct 2020 00:44:36 -0700 (PDT)
Received: from localhost ([2409:8a28:3c42:6840:9efc:e8ff:fef2:1cdc])
        by smtp.gmail.com with ESMTPSA id w6sm1560937pgr.71.2020.10.29.00.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 00:44:35 -0700 (PDT)
From:   Coiby Xu <coiby.xu@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Olivier Moysan <olivier.moysan@st.com>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        alsa-devel@alsa-project.org (moderated list:STM32 AUDIO (ASoC) DRIVERS),
        linux-stm32@st-md-mailman.stormreply.com (moderated list:ARM/STM32
        ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/STM32
        ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 14/25] ASoC: stm32: i2s: remove unnecessary CONFIG_PM_SLEEP
Date:   Thu, 29 Oct 2020 15:42:50 +0800
Message-Id: <20201029074301.226644-14-coiby.xu@gmail.com>
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
 sound/soc/stm/stm32_i2s.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/stm/stm32_i2s.c b/sound/soc/stm/stm32_i2s.c
index 7c4d63c33f15..138acfb26882 100644
--- a/sound/soc/stm/stm32_i2s.c
+++ b/sound/soc/stm/stm32_i2s.c
@@ -984,7 +984,6 @@ static int stm32_i2s_probe(struct platform_device *pdev)
 
 MODULE_DEVICE_TABLE(of, stm32_i2s_ids);
 
-#ifdef CONFIG_PM_SLEEP
 static int stm32_i2s_suspend(struct device *dev)
 {
 	struct stm32_i2s_data *i2s = dev_get_drvdata(dev);
@@ -1002,7 +1001,6 @@ static int stm32_i2s_resume(struct device *dev)
 	regcache_cache_only(i2s->regmap, false);
 	return regcache_sync(i2s->regmap);
 }
-#endif /* CONFIG_PM_SLEEP */
 
 static const struct dev_pm_ops stm32_i2s_pm_ops = {
 	SET_SYSTEM_SLEEP_PM_OPS(stm32_i2s_suspend, stm32_i2s_resume)
-- 
2.28.0

