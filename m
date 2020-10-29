Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4B929E4DF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 08:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731971AbgJ2Hsj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 03:48:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731938AbgJ2HoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 03:44:01 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902F6C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:44:01 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id b19so914939pld.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AHzIBGN0BQuBgCIUGfl4ZLzJ/JT7l0StfYhAvIeJ/MM=;
        b=L+BUDkqZgHM6yV7+oOTVLr5ity64t3juhbDn2kVjjj3viJ8SZBngjBLD1QrHAwPGxE
         C5we+AdSZ5CVr/HefW9VLX/3MSn5UFGoDDOeIWvhEn+AF2ANz9V4uEEONpGuOAgTU8J8
         P5LL4ZpXHrfUaHycVOQEDHuAoRhJT8yJSXizlOvVpqSKQojJWXts+GIdudFA98eDm7gC
         d1L0B1BK4xJ2dgtgDJ1L4cF4f44eTfPcjVRy4KuTRAi8nfYlkTW1FtDenFFIYS33HMxV
         jqMfWv2QZHhCy2WOOUb9Zv+ydkly5FX2P+L7y5VRw7YUNOPrGcghXKjr6x6dHy/ALtEf
         jrkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AHzIBGN0BQuBgCIUGfl4ZLzJ/JT7l0StfYhAvIeJ/MM=;
        b=N1kcYpxtzPWJ1uJ1cqoJRu1dJv8gM8KY7wJ3FWpLU3AcpABqFDiM9BHYmka7bQpQBc
         MoD/fdL/IzFTrp3ZJZPixr/mfieZ7On0pUBTCk+1v+fyXURnd9QAjwAEAN3SKzfAhxUa
         jeBUyuyGM3+wWF6z5b9bvztyPz+RfnZK0Hn7maXsn0n0YHJTPfeGK0vjLZAY6Hgacau/
         G/w/q4Fy22Y5d6zbyztAkJPC/qG7/xETOmSv2gCQIunVduBQakAohM7csjrIO7yYz6gY
         /xRLhRbw4yZQrRCS3LRm9BUL2T8D+qSWzHWhGaDsLeYYDMBscDn4V5J0VttU7AfjvhvK
         RRNA==
X-Gm-Message-State: AOAM5332exP/uL7KbLL7ncHAmmdRztT6XUiHZlUluo2nrF+Zt8ahJpgl
        d1JdSYesn2QcQan4UR48H4Q=
X-Google-Smtp-Source: ABdhPJx7ijebngEZU7m/kqD/GAuqvQt2AdGg9Ne5c4u/3+DKAtE02bgPvipElzUVy1Bnz6dMPAIC7w==
X-Received: by 2002:a17:902:ed54:b029:d3:d0bc:e41d with SMTP id y20-20020a170902ed54b02900d3d0bce41dmr2975304plb.13.1603957441202;
        Thu, 29 Oct 2020 00:44:01 -0700 (PDT)
Received: from localhost ([2409:8a28:3c42:6840:9efc:e8ff:fef2:1cdc])
        by smtp.gmail.com with ESMTPSA id gb13sm1691152pjb.55.2020.10.29.00.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 00:44:00 -0700 (PDT)
From:   Coiby Xu <coiby.xu@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org (moderated list:SOUND - SOC LAYER / DYNAMIC
        AUDIO POWER MANAGEM...), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 07/25] ASoC: img-spdif-out: remove unnecessary CONFIG_PM_SLEEP
Date:   Thu, 29 Oct 2020 15:42:43 +0800
Message-Id: <20201029074301.226644-7-coiby.xu@gmail.com>
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
 sound/soc/img/img-spdif-out.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/img/img-spdif-out.c b/sound/soc/img/img-spdif-out.c
index b1d8e4535726..1549a8db6657 100644
--- a/sound/soc/img/img-spdif-out.c
+++ b/sound/soc/img/img-spdif-out.c
@@ -419,7 +419,6 @@ static int img_spdif_out_dev_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int img_spdif_out_suspend(struct device *dev)
 {
 	struct img_spdif_out *spdif = dev_get_drvdata(dev);
@@ -458,7 +457,6 @@ static int img_spdif_out_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 static const struct of_device_id img_spdif_out_of_match[] = {
 	{ .compatible = "img,spdif-out" },
 	{}
-- 
2.28.0

