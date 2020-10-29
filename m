Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20D8429E4EC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 08:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732000AbgJ2Htm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 03:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731764AbgJ2Hnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 03:43:50 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E954C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:43:50 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id f38so1663863pgm.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 00:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2f76QX6KjllBHRbyn8bbNM8MHRGSvgg1fTn2FXp9kIk=;
        b=MetyxOeiFIfccE3es6OdzGpM16CvXTlwFUbayjCo80V8vzGg71aanERZA/rSMHq57V
         yDaqdUwD8D3Q1atgb5CdG3c/XcBhaR3pDGlRd+WP5J942NshDkLWwPYlPY6Y8Sbffc1A
         ftOwJdlht0Fak+gTaqd+TT0+s5qzDf3KzUuyvWM+EHSOjr2/Ymvn+dAgVWWWK2RLCCMh
         fvlQAVgXt7CekrChkpBJDv4panvHeF9QwK070Erpwrx3KMMRSEaTiLMqn76dEt2BBCWX
         6tl9TWzUT7aHkNeTYFDKvC1A1Vvbj4oymVa8c2iEa0Kc83CBRQtUv1LmRKGV24uUfOCT
         s7cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2f76QX6KjllBHRbyn8bbNM8MHRGSvgg1fTn2FXp9kIk=;
        b=dwEY6QYrfdLfjh36ndDeUNlPH35YxY7hgFE9W4vPAcFYHqBrWxOxrLSX4O12fUtSZk
         iTNaxEw1xkExT5cYk8PoSfJWPmEpjsf/9uETAfrjsJpzTU8YyWqu2Qd+QDGv9/5i0TNQ
         KiQOHLShMcJSOQVC9GCLBFdic+i+jzMkQlqSABfBaTB9mOtXMeOAxswKBpGn3pEmS3cG
         gOW1bhE36EYK9GOyQB/SKo+PIq32UtrgCoOubmjKDzHC2CobHuGK6yjr4B4PmAN2U6m0
         c3crI/8o/9WO6TKHVDiEnsTH8MlU6F5mgXJw8PpOof6Ql4W0/aOFBCryAludmjrSKWzC
         HiYQ==
X-Gm-Message-State: AOAM5334Ixoq3WOR8CArGmDpqzhGFnvQtSfDVfp5n+bHGXFM2RE84z7H
        aRdu6RW5hYK7AR5LspvoYX0=
X-Google-Smtp-Source: ABdhPJyWkELF8JgWYyu3kFPwXgZM+B8iEgdd3IgoUA4QLO4kayW+2sAMfjxjJYUYVDIWfpSWvCK8Gg==
X-Received: by 2002:a63:7d49:: with SMTP id m9mr3024402pgn.60.1603957429902;
        Thu, 29 Oct 2020 00:43:49 -0700 (PDT)
Received: from localhost ([2409:8a28:3c42:6840:9efc:e8ff:fef2:1cdc])
        by smtp.gmail.com with ESMTPSA id t9sm1569687pgp.90.2020.10.29.00.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 00:43:49 -0700 (PDT)
From:   Coiby Xu <coiby.xu@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org (moderated list:SOUND - SOC LAYER / DYNAMIC
        AUDIO POWER MANAGEM...), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 05/25] ASoC: img: remove unnecessary CONFIG_PM_SLEEP
Date:   Thu, 29 Oct 2020 15:42:41 +0800
Message-Id: <20201029074301.226644-5-coiby.xu@gmail.com>
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
 sound/soc/img/img-i2s-in.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/img/img-i2s-in.c b/sound/soc/img/img-i2s-in.c
index 0843235d73c9..8364eb9c44bc 100644
--- a/sound/soc/img/img-i2s-in.c
+++ b/sound/soc/img/img-i2s-in.c
@@ -545,7 +545,6 @@ static int img_i2s_in_dev_remove(struct platform_device *pdev)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int img_i2s_in_suspend(struct device *dev)
 {
 	struct img_i2s_in *i2s = dev_get_drvdata(dev);
@@ -592,7 +591,6 @@ static int img_i2s_in_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static const struct of_device_id img_i2s_in_of_match[] = {
 	{ .compatible = "img,i2s-in" },
-- 
2.28.0

