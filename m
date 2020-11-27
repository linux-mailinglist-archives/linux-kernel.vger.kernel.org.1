Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E48CA2C6B00
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 18:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732690AbgK0RxL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 12:53:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732663AbgK0RxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 12:53:09 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B091C0613D1
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 09:53:09 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id t3so4860176pgi.11
        for <linux-kernel@vger.kernel.org>; Fri, 27 Nov 2020 09:53:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ramerNGPDN8JQu0sTjF20UQ56cc88LDm81V2sxUvJXg=;
        b=FQm6WB2AGfGgryu4sHXSOql5gOSUNN78KkHNtyDxfHwEBcR0eIqkJxVJqdhfqLzlAJ
         NMNXr31xULLR4sNTxbph6Fv+OheR2nGJIVW+n4kQjhoh4HfhXRhX9jnbUNkCafqxrxxJ
         DUJJOLuoXOiqweSh3hft2ZHw+HUrSkoh7LSy71Qqc6nYCPEcRseLyN5M5OtKuupOIC33
         6UYOYqX1RYnuBgvoT1chHfM1sN3rIP7lT207vVUmXQYKrrAWPhE5MK/VqoGIuyeB+CZj
         zH0SEBvFqL4EiylfrJdrpHqkAU1k0oSl2Vg41e3H2oEbL0KAs57THw9Pb5MYzR54wnMG
         Do2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ramerNGPDN8JQu0sTjF20UQ56cc88LDm81V2sxUvJXg=;
        b=CF8T8t6LY95khKXylTpfKjemtP6kkryu/b0P5Ha8yDz4kPTL2Umz3AP/6y7/aVBPGk
         JpR7VfyUexFxF0BNDSspUqAgLsyuy1bYdfixwVUa4ei5KCQ0QTJ4/C0K3RHPPOvxzlDk
         XPNu7dpv+/Y421mqBOoq0pEEqtl/V8YxbFX41MApvd7iqSny4Cz+6mMxKBWOEXLn6uSQ
         aaGwpaXiqopTApAPR+JoC47lNOvi/2ZxhajCS/gpsCXBKZpGs2BE29niNkTaAPofK5ez
         KHouwJhKX4vwDUkx6ig9aZTy+z9j+dPMDM6ORR9B8lhBgdUeLZiYpznCIGpG478ZsMBO
         GnMw==
X-Gm-Message-State: AOAM533QoZOaBWo+B6yUk4S7FJEbP5phCXROFfkJOSE2geIIkqHWpgy7
        RzyflzHKlXQIyWUyKGP8bWienw==
X-Google-Smtp-Source: ABdhPJwvTDualLfsYi67Q44KtxolPRq/KwqvenTwLJOC68J8jafxMn8ssGILH7qJLd5Twi65Eo/lJA==
X-Received: by 2002:a17:90a:f314:: with SMTP id ca20mr11805963pjb.191.1606499589035;
        Fri, 27 Nov 2020 09:53:09 -0800 (PST)
Received: from xps15.cg.shawcable.net (S0106889e681aac74.cg.shawcable.net. [68.147.0.187])
        by smtp.gmail.com with ESMTPSA id t18sm10536724pji.1.2020.11.27.09.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2020 09:53:08 -0800 (PST)
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 11/15] coresight: tmc-etr: Assign boolean values to a bool variable
Date:   Fri, 27 Nov 2020 10:52:52 -0700
Message-Id: <20201127175256.1092685-12-mathieu.poirier@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201127175256.1092685-1-mathieu.poirier@linaro.org>
References: <20201127175256.1092685-1-mathieu.poirier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kaixu Xia <kaixuxia@tencent.com>

Fix the following coccinelle warnings:

./drivers/hwtracing/coresight/coresight-tmc-etr.c:957:2-15: WARNING: Assignment of 0/1 to bool variable

Fix them by assigning boolean values.

Reported-by: Tosk Robot <tencent_os_robot@tencent.com>
Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-tmc-etr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
index 714f9e867e5f..525f0ecc129c 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
@@ -954,11 +954,11 @@ static void tmc_sync_etr_buf(struct tmc_drvdata *drvdata)
 		dev_dbg(&drvdata->csdev->dev,
 			"tmc memory error detected, truncating buffer\n");
 		etr_buf->len = 0;
-		etr_buf->full = 0;
+		etr_buf->full = false;
 		return;
 	}
 
-	etr_buf->full = status & TMC_STS_FULL;
+	etr_buf->full = !!(status & TMC_STS_FULL);
 
 	WARN_ON(!etr_buf->ops || !etr_buf->ops->sync);
 
-- 
2.25.1

