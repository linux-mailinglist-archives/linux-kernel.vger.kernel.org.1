Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF5B29E866
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 11:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbgJ2KHd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 06:07:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbgJ2KHc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 06:07:32 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 402B2C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 03:07:32 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id o9so1046033plx.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 03:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tI5oeu083/nL6GJhPsqc4gO0SNUKlgZsyMixSW/3ceg=;
        b=nSAByfXcQaloLeZ8FOeVHFsqjjm2/caWkiYYZXQGPJqnlWz7Bn83icp5D9q1sD5/Bu
         hSzqZO9EChV1mkauO5ZBbGCqt5JW9mikWmnMl91EKIGgiC5IveqOPDpGqEtiySDXdQKL
         FcnRCoiC2OE7h1Q5Bs8eruWKmzC8N3i+77Nz2w3++hIa3+2dvpnToXmYSNVm9m1egVUA
         pA+vQ3J5sdPBNGbK2Qt7Y/m3oCCXnLFN4jsmAVH4ug0s2BP4RVKkpRIusRhR375vuq64
         /OfnD61VkY2Lc0GbORc7TmQn1OKouobuIr6SP3FrBT53Z5MAnxrt20UanKnbI/3lTnC+
         zPsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tI5oeu083/nL6GJhPsqc4gO0SNUKlgZsyMixSW/3ceg=;
        b=Ula1H4EJeDZh4qoPjQaMymWdZvo1sq6FI1OsC81pteCA8A6UrPSjx5i9E6ixXCyjyQ
         8d8WcXFl6AGDVE5oVUOVKd9yTL8R3kXh9BMfiwObNTg1bwCCiDVS1fL+jCFU4es+cfO5
         LTnIOAa3qkBMlooX+XTiq+GCTkL98gHRePs1fcZ0ZLQO/KayBWmlu5K9ylj2koL0cn7v
         0/UnVbL3kxkVQnPZt4s0k6IJeELK6ko4ovBkrqnF1Wfoo6ZfsFLu56XPH/lOAUvs555z
         6JcM3Nkw8O3ffF5PBCboxa8YJY693gtL4p+CZbiMd8C1W7nSNMNcU7v8TpIwWnw/YeHC
         yWFw==
X-Gm-Message-State: AOAM533CQr2iSjE4lx9NqLc3TqoEtBON76qJjePzVsy7MxKubMMgaSK9
        FxGYvGDjAS9p5MsFQk8JYLo=
X-Google-Smtp-Source: ABdhPJwUIb6dKOxpzzTARpwdqzVB5dK/+w1vuIyMljKChJSLGbb8XuMUw6KK3ODz8tr1yXw6ppGc7A==
X-Received: by 2002:a17:902:8c8a:b029:d6:42d5:1cb7 with SMTP id t10-20020a1709028c8ab02900d642d51cb7mr3175494plo.73.1603966051875;
        Thu, 29 Oct 2020 03:07:31 -0700 (PDT)
Received: from localhost ([2409:8a28:3c42:6840:9efc:e8ff:fef2:1cdc])
        by smtp.gmail.com with ESMTPSA id l18sm2447529pfd.210.2020.10.29.03.07.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 03:07:31 -0700 (PDT)
From:   Coiby Xu <coiby.xu@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-stm32@st-md-mailman.stormreply.com (moderated list:ARM/STM32
        ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/STM32
        ARCHITECTURE), linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 6/9] mfd: stmfx: remove unnecessary CONFIG_PM_SLEEP
Date:   Thu, 29 Oct 2020 18:06:44 +0800
Message-Id: <20201029100647.233361-6-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201029100647.233361-1-coiby.xu@gmail.com>
References: <20201029100647.233361-1-coiby.xu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SIMPLE_DEV_PM_OPS has already took good care of CONFIG_PM_CONFIG.

Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
---
 drivers/mfd/stmfx.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mfd/stmfx.c b/drivers/mfd/stmfx.c
index 5e680bfdf5c9..e760cf2be02e 100644
--- a/drivers/mfd/stmfx.c
+++ b/drivers/mfd/stmfx.c
@@ -469,7 +469,6 @@ static int stmfx_remove(struct i2c_client *client)
 	return stmfx_chip_exit(client);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int stmfx_suspend(struct device *dev)
 {
 	struct stmfx *stmfx = dev_get_drvdata(dev);
@@ -535,7 +534,6 @@ static int stmfx_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(stmfx_dev_pm_ops, stmfx_suspend, stmfx_resume);
 
-- 
2.28.0

