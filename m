Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0365429E4C5
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 08:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387553AbgJ2HrC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 03:47:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733226AbgJ2HqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 03:46:10 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053DEC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:46:10 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id n16so1635023pgv.13
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xjj5xWJ9FV84cpQMmB6KMC3hiQFFHX6QXSYfK7Sl5ao=;
        b=Hpu37JgWrjQxEt663nH8uB2W7ILKGM7z3qWFfZpgnrFEcFeIK3xA0HVQKLh9KN1ZX8
         lHIsLEyPhyxIOJ+MBSD2Z84N7PqRxaK7sNQ8w71VniGjrOWPkMc9kcbKBojWUgS3//eZ
         YbWjZ2J3ssSKoU0kFW3wq8wl3SK+4zQwCVACHu9AqJH3heSnU+AdUSYQ+yv2kLTW/kqS
         2WSd9YZ4ID400GWfQQnmOkabwZWpwu1kzJ9QDZZrkR11bW18dtazy4hOAi/YVSFcCpCv
         9gamosSezd7HxtU8h+Py6VMH50ocQn6P5g5pmaj4s6rvu2Sk2yg8Yt7MSR/GjI6Qewlg
         dvMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xjj5xWJ9FV84cpQMmB6KMC3hiQFFHX6QXSYfK7Sl5ao=;
        b=OE37qWvEkj6t1cl0JcDtxiu31UhrN/l5bvWxH9kWFlqtoU8ubfJcm9TWhIfDePaixP
         12Hh1wycaGlznu/jB/3SeEGlJIvChQOEGtYfiVogHYjrUpsrbixYdCeg2vl7dyHUOk0t
         vHML+R2teQPjOfCQovo1GE7q5ipzkkoYNGSdBcgYSiCUxtwNU71/KnVdVEDbrXFxBh9s
         ok4TKO/odZ1f3eVgBsTtLzBAia56L0YsiKbpgVmO/3gUlum2hKQf5ca09hMua5f8FrqY
         /qTo5ptYIxb60Jg84npZnQwWYm3xRIq+e4M84lVw1U0Jvu3SHhv1r4rdAwA2vD+mOk4J
         n2nA==
X-Gm-Message-State: AOAM532VwUSxB/QNg0pPcNjfyfgVkOa/BZRq2QU+x8P+RcFOLGseWMIl
        A0CxS7vbIqjqPfh4yg7xBFs=
X-Google-Smtp-Source: ABdhPJxi3eINEcdp5sUgDPI05F5UZjtYEVshNYP+69Q0bVkg2BZFWVCs06Kcmm+RLdaDBnWSQPWT4A==
X-Received: by 2002:a65:41c4:: with SMTP id b4mr2195258pgq.223.1603957569666;
        Thu, 29 Oct 2020 00:46:09 -0700 (PDT)
Received: from localhost ([2409:8a28:3c42:6840:9efc:e8ff:fef2:1cdc])
        by smtp.gmail.com with ESMTPSA id 38sm1564272pgx.43.2020.10.29.00.46.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 00:46:09 -0700 (PDT)
From:   Coiby Xu <coiby.xu@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org (moderated list:SOUND - SOC LAYER / DYNAMIC
        AUDIO POWER MANAGEM...), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 21/25] ASoC: codecs: max98090: remove unnecessary CONFIG_PM_SLEEP
Date:   Thu, 29 Oct 2020 15:42:57 +0800
Message-Id: <20201029074301.226644-21-coiby.xu@gmail.com>
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
 sound/soc/codecs/max98090.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index 945a79e4f3eb..97175d7c99cc 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -2636,7 +2636,6 @@ static int max98090_runtime_suspend(struct device *dev)
 }
 #endif
 
-#ifdef CONFIG_PM_SLEEP
 static int max98090_resume(struct device *dev)
 {
 	struct max98090_priv *max98090 = dev_get_drvdata(dev);
@@ -2653,7 +2652,6 @@ static int max98090_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static const struct dev_pm_ops max98090_pm = {
 	SET_RUNTIME_PM_OPS(max98090_runtime_suspend,
-- 
2.28.0

