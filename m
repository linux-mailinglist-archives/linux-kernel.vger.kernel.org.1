Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4435D29E4BF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 08:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387417AbgJ2Hq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 03:46:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733303AbgJ2HqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 03:46:24 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EF1AC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:46:23 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id a200so1637254pfa.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:46:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mKrg1J0hIePVXQXkTT7U+Izo63Hxn8pT7uIj0drTK1U=;
        b=s9AEqi+RnJT45EUtJzN3jm/eOmIcV0IVBleAkDOoNYGsnCjnnW6YdPdIVO0Scxv5y0
         MBpwekR0XZgzAV+7dajkVS2yqEVs0WkSJpJYPH7/5nZ0yRFuAGk9qR2zRpDRkhFHFxle
         yLICcQSvl13x1F90Zftr5ixFbkkrGG7PC7TIXSE9Obordf7JcB1AZf7wNqeHN4EFuiK6
         4IE9TN4CZ/5yWuhwft5yZdUn13Louv40BsJGLpsG6u20fU9lwU3ImMvXxdGwCenX6Cmf
         ab/k1JF7mMfAmNPRO60LVSEgxVq3EaVgRG56+oN4H8kbAMILYDE9u9z1M/G5cD1cpCNM
         PXVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mKrg1J0hIePVXQXkTT7U+Izo63Hxn8pT7uIj0drTK1U=;
        b=QJqL+3WlRuCrEgCxIlFZCUhMAmDAWI1PSPMBYxhxqSKAIRxNsNz4AdhDnopys2gD0T
         Z+xQwCBn34Q7Hiy/eEz4gTqKsitFIuqo6V4l6pqpfArDluNogpNkC60rfBpuat2Y7lW5
         T3YQk7OUKNKN8ra6rNJx/2QvpovU8KZjSRDk3pSXhZFcXoIjyvSA7zZ3NL0oe3zeNPsM
         cksscRgRcYEtb1X7zD55cdGmOoGUA8QJifwrk8J7OZf6eSKuT4TcFzRD7MQLQMVKUAB8
         loFDQfkXAhK0p9qMUwEuaNYB6t/RAO9HCYrrOe2KD93/20Ku0eP2mp71loXs35KnG1cP
         rB5g==
X-Gm-Message-State: AOAM532ntJirr6mQ3ajMJ9UmHD5tsFeNN6butuRDNDuZEdlvgJtuRSWF
        /90Vs7d0f5biAqpxIRRNkGQ=
X-Google-Smtp-Source: ABdhPJzh4iM4udtBfzaWyKyEdasZLfhkR4CpL3B+tUcGzTZNh1FCHDe9m6Nv+/LvQXQ5eDp9Y8FAKg==
X-Received: by 2002:aa7:9f90:0:b029:164:bcf:de16 with SMTP id z16-20020aa79f900000b02901640bcfde16mr3303380pfr.3.1603957583129;
        Thu, 29 Oct 2020 00:46:23 -0700 (PDT)
Received: from localhost ([2409:8a28:3c42:6840:9efc:e8ff:fef2:1cdc])
        by smtp.gmail.com with ESMTPSA id j23sm1549643pgm.76.2020.10.29.00.46.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 00:46:22 -0700 (PDT)
From:   Coiby Xu <coiby.xu@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org (moderated list:SOUND - SOC LAYER / DYNAMIC
        AUDIO POWER MANAGEM...), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 23/25] ASoC: ts3a227e: remove unnecessary CONFIG_PM_SLEEP
Date:   Thu, 29 Oct 2020 15:42:59 +0800
Message-Id: <20201029074301.226644-23-coiby.xu@gmail.com>
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
 sound/soc/codecs/ts3a227e.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/ts3a227e.c b/sound/soc/codecs/ts3a227e.c
index 3ed3b45fa7ba..95d17cf7695a 100644
--- a/sound/soc/codecs/ts3a227e.c
+++ b/sound/soc/codecs/ts3a227e.c
@@ -334,7 +334,6 @@ static int ts3a227e_i2c_probe(struct i2c_client *i2c,
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int ts3a227e_suspend(struct device *dev)
 {
 	struct ts3a227e *ts3a227e = dev_get_drvdata(dev);
@@ -354,7 +353,6 @@ static int ts3a227e_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static const struct dev_pm_ops ts3a227e_pm = {
 	SET_SYSTEM_SLEEP_PM_OPS(ts3a227e_suspend, ts3a227e_resume)
-- 
2.28.0

