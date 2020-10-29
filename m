Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 310C729E4C1
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 08:47:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387484AbgJ2Hqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 03:46:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387454AbgJ2Hqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 03:46:36 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B69FC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:46:36 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id 1so910461ple.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YfuBmTvMg9MUKxvXP6ERdTgdyYc2LTvWkNxHfpwVAwc=;
        b=vQuYh02YfBH3Q+Cu83OMh2Zw+ddNnqCqUof8ZKGw2KlqXfKzFZgQ3CKG7n4D04vneY
         VIveM2fn6WoY+IaxjawuSGrxQac5F9E4ANI6VTeELqU82avE9JRXNCnS6LUEtmrH6thS
         4OJMnyNpzOZU5Sd6GpLLXjgcS/OaTHx+D1IxWBTCTFNV6ZuPp5AUAZq+s4Se4VrpbL6i
         bJYrAPOy87/ZvYuzKR8N+zeFKT/b+nN02CPJqOMQkGz4XcOdkdss3dqVhGllpWfL8wm6
         it6HxpZ336KvN6kbphzOfgTxQ/D14TG9gEOA68EaBOGJeHX9+Y4PKt13gw3gykmzb/+I
         yCNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YfuBmTvMg9MUKxvXP6ERdTgdyYc2LTvWkNxHfpwVAwc=;
        b=fI4XNawfEpBct6sJ2T3GKzNuiQNzxiAucO02rwSxEM16q74l2wSquvOW/r+olujqoj
         LJRPLNISPbzkT0K7B+syPKBvc/AoAh0/jjJ6N9ME5RhXNhPTWMMzqZnjn42ORaajQdBq
         u9SdGXw+QdJc6RZltN6eACnfjgtN+uCQ/kb6oxrG35A/Y7zN0Y/6CZlDP9vuAttKOPzW
         G+Ot5rlcE6HSuI6YLcyKsIH/lq54yRnX+H+XnuyMxbwDWIvX5v20lwXZxsEPOPzPgV9P
         EMUJfhVYDQKUQINwi0uxrSgtcRz7g8QyJXYG1Yea/YM/PX4G6532WT8+uE3N5hoCGGrM
         FHyQ==
X-Gm-Message-State: AOAM533e9rcN3v6FLAFeraFcOAKVq9QTjinwSRKREkHs2Z4Q1vmrVYk3
        VFAFpsMKeFqDCujfGd4bxzg=
X-Google-Smtp-Source: ABdhPJxf8E/8cKa23EfUte88B96UerFuRSXyvagG8YXcECd1HyINeZl2Eec9Usnqoet1h037d3io5A==
X-Received: by 2002:a17:902:23:b029:d5:b88a:c782 with SMTP id 32-20020a1709020023b02900d5b88ac782mr2750215pla.5.1603957595930;
        Thu, 29 Oct 2020 00:46:35 -0700 (PDT)
Received: from localhost ([2409:8a28:3c42:6840:9efc:e8ff:fef2:1cdc])
        by smtp.gmail.com with ESMTPSA id s4sm1737502pjp.17.2020.10.29.00.46.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 00:46:35 -0700 (PDT)
From:   Coiby Xu <coiby.xu@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        linuxppc-dev@lists.ozlabs.org (open list:AOA (Apple Onboard Audio) ALSA
        DRIVER),
        alsa-devel@alsa-project.org (moderated list:AOA (Apple Onboard Audio)
        ALSA DRIVER), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 25/25] ALSA: aoa: remove unnecessary CONFIG_PM_SLEEP
Date:   Thu, 29 Oct 2020 15:43:01 +0800
Message-Id: <20201029074301.226644-25-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201029074301.226644-1-coiby.xu@gmail.com>
References: <20201029074301.226644-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SIMPLE_DEV_PM_OPS has already took good care of CONFIG_PM_CONFIG.

Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
---
 sound/aoa/fabrics/layout.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/sound/aoa/fabrics/layout.c b/sound/aoa/fabrics/layout.c
index d2e85b83f7ed..197d13f23141 100644
--- a/sound/aoa/fabrics/layout.c
+++ b/sound/aoa/fabrics/layout.c
@@ -1126,7 +1126,6 @@ static int aoa_fabric_layout_remove(struct soundbus_dev *sdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int aoa_fabric_layout_suspend(struct device *dev)
 {
 	struct layout_dev *ldev = dev_get_drvdata(dev);
@@ -1150,7 +1149,6 @@ static int aoa_fabric_layout_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(aoa_fabric_layout_pm_ops,
 	aoa_fabric_layout_suspend, aoa_fabric_layout_resume);
 
-#endif
 
 static struct soundbus_driver aoa_soundbus_driver = {
 	.name = "snd_aoa_soundbus_drv",
@@ -1159,9 +1157,7 @@ static struct soundbus_driver aoa_soundbus_driver = {
 	.remove = aoa_fabric_layout_remove,
 	.driver = {
 		.owner = THIS_MODULE,
-#ifdef CONFIG_PM_SLEEP
 		.pm = &aoa_fabric_layout_pm_ops,
-#endif
 	}
 };
 
-- 
2.28.0

