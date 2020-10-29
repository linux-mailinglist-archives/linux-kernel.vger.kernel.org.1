Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3071429E4DE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 08:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732119AbgJ2HsZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 03:48:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732104AbgJ2HoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 03:44:06 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1757C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:44:05 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id b12so907832plr.4
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TpBMm8g68pTx9DqIx3h+hx1vGqrNoMOX/Q5L49wwIlo=;
        b=f6yk89vg+qNSCOZtGKP6o4XSw44ktFR5O/1XFznnntptHHnL0+qBgyXM4wq7ghfeyo
         I3JupIjev6TG41pCUKUEOvPuEywsgWMReZZ7NlzrqcAPpjMh6Pxlj/WGA4SkEjbP0qwC
         vjv495mn1+cr0bglnS2V4hf4SCXBwYTrSJQZst+MQDNfWnb4sZB40YXw6u66l8FXjNY+
         w0E4lPqr7m/ENjVS/PeGpCEc85t1xSQ1/hznWT9to1SyQBNi3sj5JOVagFg2IhtRunmf
         nJUSVpTKk6c842awUDRUOdSHzH+SgP2oOEz8o5iIXjf5qrm+/+4hD5RgzvbR8AotFXS6
         ec6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TpBMm8g68pTx9DqIx3h+hx1vGqrNoMOX/Q5L49wwIlo=;
        b=kotBr2deSrFOk9eLrfvpo60wLn1ENi1iqOEb8oF92++z2bdS0z285tIq6xFfuSojoJ
         Ky3zi1oH/lxbGcOdI8cj2NT/e2vnA4uoINvn9HAdft4xopiNm5V78rvYmoEberOx+9F7
         pW+GnjQvRL8d6Vf26k3tGGbfwWv+vt4Iw5V/UYAI89ZgD97qhV9Xlb+5v8ppNnx3Tce8
         ay8ntvgAWh+x7oHy35lG0upP99b9/Z9468Hq0uo9OHukIxmaLURk5QsOPmKkSUQquFxU
         0HbEHKQThwKBIs6z4ZfEGOfKZPfc+VJpWI9vhR7YbNS9Mp3prugXPgn1VRPX2iBbOmVT
         721g==
X-Gm-Message-State: AOAM532m1ECTYWiPQ8X81kMioyn3JJlDKHs6xa517L4rBiPrOgS41+jo
        RQ9SjygtIc3WN2L56Q2Jx1g=
X-Google-Smtp-Source: ABdhPJyJYs8Hm3RbNRVfredcnwtafkPurb0Ozj/n6XbH3XxzaDaN5PEg476VGV/RBDSEyV7o9cImKg==
X-Received: by 2002:a17:902:8647:b029:d3:d448:98a8 with SMTP id y7-20020a1709028647b02900d3d44898a8mr2865766plt.29.1603957445560;
        Thu, 29 Oct 2020 00:44:05 -0700 (PDT)
Received: from localhost ([2409:8a28:3c42:6840:9efc:e8ff:fef2:1cdc])
        by smtp.gmail.com with ESMTPSA id n6sm1562177pjj.34.2020.10.29.00.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 00:44:05 -0700 (PDT)
From:   Coiby Xu <coiby.xu@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org (moderated list:SOUND - SOC LAYER / DYNAMIC
        AUDIO POWER MANAGEM...), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 08/25] ASoC: img-i2s-out: remove unnecessary CONFIG_PM_SLEEP
Date:   Thu, 29 Oct 2020 15:42:44 +0800
Message-Id: <20201029074301.226644-8-coiby.xu@gmail.com>
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
 sound/soc/img/img-i2s-out.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/img/img-i2s-out.c b/sound/soc/img/img-i2s-out.c
index b56a18e7f3ac..7693b7fdf299 100644
--- a/sound/soc/img/img-i2s-out.c
+++ b/sound/soc/img/img-i2s-out.c
@@ -551,7 +551,6 @@ static int img_i2s_out_dev_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int img_i2s_out_suspend(struct device *dev)
 {
 	struct img_i2s_out *i2s = dev_get_drvdata(dev);
@@ -598,7 +597,6 @@ static int img_i2s_out_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static const struct of_device_id img_i2s_out_of_match[] = {
 	{ .compatible = "img,i2s-out" },
-- 
2.28.0

