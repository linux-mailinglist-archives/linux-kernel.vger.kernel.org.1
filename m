Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C11F29E4BD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 08:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733284AbgJ2HqO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 03:46:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729590AbgJ2HqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 03:46:05 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55185C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:46:05 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id g12so1648801pgm.8
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+fK2OKGG4p6bBRTtmFHio3t91tYIgqc0DsdsIh3WcuQ=;
        b=fwqb1spmwvHpmlB/d75reyt5h4z8ocPuPqiM5mdXJ4T+5K5P3vH0oGF9ARZygflH/n
         U59mds2tnw0KPqvD29hNFDxSwvdfFFSzpCI4IGontMbmIKSaxNNPCF4tw5aoKCQUILjf
         N11tN+SfI+XP8CxhR62N6F6+XoeJUE3do3F09QQSOuiFikVLq24Wwp3noTJuy38yAECR
         IgVSb8K4cMuuvyYHHNiJ6exSrBlwaRDuAjY331AnzGIoxHudk34o+2Ox6ukP6llzNVRs
         URWyEEeBofEw8Yte+xw7m/TpGD6vxdNPm1tNJRbdBV+5Jb9Gj/ApIa8FsuMTAppW7g5+
         d9cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+fK2OKGG4p6bBRTtmFHio3t91tYIgqc0DsdsIh3WcuQ=;
        b=iOmXWpzseidpy8GEQlCiRrH/x5e7wX1JnHtnKis8zJzeGTwR3FX1FXt15hqeljcf11
         BX6mmgR34/do448ZgxWl6K5JV4w8WdJJAhFkCmKF0SyGxiC5GcUBrocAWwG2qtASrH1P
         +6pXUT69fdY+pr6JEOhljMqzFp+/8e74eAXFq4JU5q6/WlcgTacx93/SSfI/Oe0ktmTr
         J1y3ep2nF38OssY9rk73xEAWBmuLqA1UncXa5SOTVDz5XIsNbiCaq5X4cMLJaz+RFaai
         pJOHXDG4vavqJ67ZbMFFdsf1BjthBOl9KaXpr87DhLKQ81q2e5kax7DL2gUZS2WGJZm3
         4yGQ==
X-Gm-Message-State: AOAM533/goLJshfO9LbxAhO2mkCiVBkiGkVIl0m/pSfSMnYeHW6VmmO3
        m1mEj9d3PHw1FJZgatKzUFk=
X-Google-Smtp-Source: ABdhPJxAard+MstQQ74IvRjEm3mHbgNxVhSDNfaQyzhEUf/VKrm9IqsMsBxCjyNF9MRXU+CSHRKg5w==
X-Received: by 2002:a17:90a:348e:: with SMTP id p14mr3047577pjb.75.1603957564962;
        Thu, 29 Oct 2020 00:46:04 -0700 (PDT)
Received: from localhost ([2409:8a28:3c42:6840:9efc:e8ff:fef2:1cdc])
        by smtp.gmail.com with ESMTPSA id e5sm1945312pfl.216.2020.10.29.00.46.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 00:46:04 -0700 (PDT)
From:   Coiby Xu <coiby.xu@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org (moderated list:SOUND - SOC LAYER / DYNAMIC
        AUDIO POWER MANAGEM...), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 20/25] ASoC: max98390: remove unnecessary CONFIG_PM_SLEEP
Date:   Thu, 29 Oct 2020 15:42:56 +0800
Message-Id: <20201029074301.226644-20-coiby.xu@gmail.com>
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
 sound/soc/codecs/max98390.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/max98390.c b/sound/soc/codecs/max98390.c
index ff5cc9bbec29..50b37e39bb6d 100644
--- a/sound/soc/codecs/max98390.c
+++ b/sound/soc/codecs/max98390.c
@@ -889,7 +889,6 @@ static int max98390_probe(struct snd_soc_component *component)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int max98390_suspend(struct device *dev)
 {
 	struct max98390_priv *max98390 = dev_get_drvdata(dev);
@@ -913,7 +912,6 @@ static int max98390_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static const struct dev_pm_ops max98390_pm = {
 	SET_SYSTEM_SLEEP_PM_OPS(max98390_suspend, max98390_resume)
-- 
2.28.0

