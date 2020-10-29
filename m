Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42D8929E860
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 11:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725839AbgJ2KHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 06:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbgJ2KHH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 06:07:07 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AFAEC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 03:07:07 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id r10so1917964pgb.10
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 03:07:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S3kHSWIilLP2+glsXXm0DrugnF4KD2+QYKmUZDh/MBU=;
        b=VSDc8MBA4Rsnbkd8ukwPrNLm0Wxze4j+61AA3L+fYJSEvk9KpSfLrPLRHpSxTHEalM
         +NiT1w8YR1ymrbClO5ugWdTnA/ZHp1mG0/WWV9/4IRJPFl/rnb5GMeQsvtZpAXfsvmcj
         MW7yE3m5agunUYGjNePdZJTs7VDinBrMsFdP4gpozym9HJEtMBUqy5UN85b+CXf+5KS0
         NWuPkbIAN1SCRpwXGL3D2kTAs3CQ+QuoPILQ4gB1fNwTDpF4m/V+Pp++bVPy351B1Ndt
         mY8SCHVInCX3gNZkHDlBT+KYQkcnrtIgC1b1Z8Hrl80tj371lbp0U0cp3FBlpCw/Ow6Y
         gHzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=S3kHSWIilLP2+glsXXm0DrugnF4KD2+QYKmUZDh/MBU=;
        b=uRS/WC4klWlIHWD6+6mEM1P40dSeAo7Am9WLuFuMEOxNhD63DBmOCSnAdLwdhWaHDt
         fA3+bwW4XMO1ndrqcxPD8nFU49D4g6C22dlSf8nzoW5IZ1942DIrIAsv/baB9icDwgFx
         GIoLCEMoTwxQTh/FTdjjEco5542C9yKFAi/flyjZ7DOdRsMF53UaR4hUwTZz9TG3q7fG
         9Vi7UBuR6fPIqTHU+BPfHCbMydca4PowICm78LtVwtNmfHerI3Zb+CfAQdwgfxLJFrIs
         MD2fJf3VF8kQ7gRmSri1hMvFkPPq/ddoOCAT2RtryYvHBIkvP3T9HJIUreobUTJovdfc
         nhdA==
X-Gm-Message-State: AOAM533i8wyH6SzxriqdTpT+2eg4+2xmFIz/NNh/p+78qwOFxXutQU9R
        Iay5+Elt7i/4knBXBH4OVrw=
X-Google-Smtp-Source: ABdhPJz3wugNWCNi6M3IewJZRbBIOppIXgqIiCXQHuqpQ4cwyZqWRajnctd0Bl5s527O6RdjrWvNKQ==
X-Received: by 2002:a17:90a:bb0e:: with SMTP id u14mr3578458pjr.112.1603966025721;
        Thu, 29 Oct 2020 03:07:05 -0700 (PDT)
Received: from localhost ([2409:8a28:3c42:6840:9efc:e8ff:fef2:1cdc])
        by smtp.gmail.com with ESMTPSA id e8sm2348184pfn.175.2020.10.29.03.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 03:07:05 -0700 (PDT)
From:   Coiby Xu <coiby.xu@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-kernel@vger.kernel.org (open list:MAXIM PMIC AND MUIC DRIVERS FOR
        EXYNOS BASED BO...)
Subject: [PATCH 1/9] mfd: maxim: remove unnecessary CONFIG_PM_SLEEP
Date:   Thu, 29 Oct 2020 18:06:39 +0800
Message-Id: <20201029100647.233361-1-coiby.xu@gmail.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SIMPLE_DEV_PM_OPS has already took good care of CONFIG_PM_CONFIG.

Signed-off-by: Coiby Xu <coiby.xu@gmail.com>
---
 drivers/mfd/max77686.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mfd/max77686.c b/drivers/mfd/max77686.c
index 71faf503844b..8c701f8a9dd5 100644
--- a/drivers/mfd/max77686.c
+++ b/drivers/mfd/max77686.c
@@ -227,7 +227,6 @@ static int max77686_i2c_probe(struct i2c_client *i2c)
 	return 0;
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int max77686_suspend(struct device *dev)
 {
 	struct i2c_client *i2c = to_i2c_client(dev);
@@ -262,7 +261,6 @@ static int max77686_resume(struct device *dev)
 
 	return 0;
 }
-#endif /* CONFIG_PM_SLEEP */
 
 static SIMPLE_DEV_PM_OPS(max77686_pm, max77686_suspend, max77686_resume);
 
-- 
2.28.0

