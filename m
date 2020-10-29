Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD1F829E4B1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 08:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733042AbgJ2HpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 03:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733028AbgJ2HpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 03:45:04 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7E6C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:45:04 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id b3so1665621pfo.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yud4LFo3ZtN8YB5h2zgMiUFZ5gtVLkjhEUnn5lF5Ujo=;
        b=oisQJdTzCQ1BpXv3Ln1D5dP8ROZCbsZGjFZ6m944zrR8HRDDm2St51OhpWpuOqy8S5
         ClpBqdSH7BlOncB5aYQqBsdxdQAUBKmOMcfIn1+R5TjfHRpBZdkhJi1eTzgjaAHMFOCw
         fc0AvqTxuk8rvCHhoCzKNbu6WgCVSizKQCTETCND3zYc8/x2L3KdIXweJBNS3gdQ4DI7
         bdzNWvJjr5uvqfTfLe7V3StvR5rmPFHi3kAXDl1Bo0PzBWAc0RfWTzI+uqyY1kXdZuZM
         ORxrkpYRK6SfLT3xEEled1rVjzESfhmwa/ctxRqBZfrutBdYATAtNGj57xQpN2aN97sD
         6hZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yud4LFo3ZtN8YB5h2zgMiUFZ5gtVLkjhEUnn5lF5Ujo=;
        b=ZHMVjcEA1xdqHtyIN6Qc+nIhEMJW1bTonB7+6UiIGmGR+2j2zyBpbK0AKdQsVNU1W4
         6u80FBF0bzyt26KYkO2lUmWOS/0YYZ/aLuL7m74lSXUd5qt36Pp9wM5gTsWqPaaReX+g
         NCH3yePY/CLsLarjlFox67BVVs7gWBLvoX2Iuo0TUtbBKNrRt9liSRu3j1etW13C5v6C
         7+hasfhP/6u+CZJODJoJdHHHLEbjwzd+p+80ShnLmnaLtlQGiuHRjyZgRp5dWgZYN+J4
         xZK0laD3Xo+moS2k5WuD48AwyHSx75txYGp+qz5HAc2bGLo27Nat7283MnYAXolwCyfi
         8FcQ==
X-Gm-Message-State: AOAM533gltIaqkkfoLEaqy7YLLQwfkC0NM4p1lOvafSSKJVvC+VFWfUM
        pLHb2s8Nyacsl0RU0n7+SXc=
X-Google-Smtp-Source: ABdhPJzYOaREJky9YPVbrpsi34cw/1JYIXt6d1J7PjFokyFWL3AZPbsBHCjkKDcJlm3lKgjwNeJwCg==
X-Received: by 2002:a17:90a:10c1:: with SMTP id b1mr3057967pje.58.1603957503735;
        Thu, 29 Oct 2020 00:45:03 -0700 (PDT)
Received: from localhost ([2409:8a28:3c42:6840:9efc:e8ff:fef2:1cdc])
        by smtp.gmail.com with ESMTPSA id j6sm1650239pgt.77.2020.10.29.00.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 00:45:03 -0700 (PDT)
From:   Coiby Xu <coiby.xu@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Barry Song <baohua@kernel.org>,
        alsa-devel@alsa-project.org (moderated list:SOUND - SOC LAYER / DYNAMIC
        AUDIO POWER MANAGEM...),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/CSR SIRFPRIMA2
        MACHINE SUPPORT), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 16/25] ASoC: sirf: remove unnecessary CONFIG_PM_SLEEP
Date:   Thu, 29 Oct 2020 15:42:52 +0800
Message-Id: <20201029074301.226644-16-coiby.xu@gmail.com>
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
 sound/soc/sirf/sirf-usp.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/sirf/sirf-usp.c b/sound/soc/sirf/sirf-usp.c
index 2af0c6f14ee6..ae2890827414 100644
--- a/sound/soc/sirf/sirf-usp.c
+++ b/sound/soc/sirf/sirf-usp.c
@@ -313,7 +313,6 @@ static int sirf_usp_pcm_runtime_resume(struct device *dev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int sirf_usp_pcm_suspend(struct device *dev)
 {
 	struct sirf_usp *usp = dev_get_drvdata(dev);
@@ -340,7 +339,6 @@ static int sirf_usp_pcm_resume(struct device *dev)
 	}
 	return 0;
 }
-#endif
 
 static const struct snd_soc_component_driver sirf_usp_component = {
 	.name		= "sirf-usp",
-- 
2.28.0

