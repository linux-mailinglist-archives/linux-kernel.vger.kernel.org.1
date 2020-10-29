Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C9CA29E864
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 11:07:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgJ2KH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 06:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbgJ2KH1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 06:07:27 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 681FAC0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 03:07:27 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id x13so1924015pgp.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 03:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xzfokQalXxdAHUBK/rxtge5l+Ejl9k1RpHJ2eAwHePM=;
        b=AS5MLfUfSO7SCqwhzooT5LlHM+JKT2X0NH7cEyiYqPayL++nGTzB2UdQJHcOYz2Nf2
         6KIbeLcaXa01KIqkYN+S3Jv6qkI7QDaGY8ZaUq8IHPQukCmMRTahCLGpWQlgexPgSbYp
         7Ebiucpewq0HlubO8VD4hO+64Jf7khP/6VFTPIqD0j/1ZzYAXUqfuVTW4M0tD5x3a6SR
         W0wMBJSfoWqMBQtDQ5wxCvEEXuhAxKSdkIwJHHJIKz0m++sdR8TCSbB+yfWkrA7w0F1a
         DQQZbv2e/DKntHX6h0AMdJy+ER07XYQd85NT+l+RvDXobvPoZKIjdTJ8yC1Uu4gADw5t
         mbew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xzfokQalXxdAHUBK/rxtge5l+Ejl9k1RpHJ2eAwHePM=;
        b=PueWzuw/f2QAzAozE0kHTS3s3EbXrZFtixgwAKVwPT88Jphl7C8Xn8oRDwG1Rvy2jj
         J/Ax2Od8NAjQ0a3774ujvzrCF7+sLXU+WRUs6RbevhQZRuWTZHNoLOpdcHFaKWyYASUS
         mVX4s/qpmRkAUNs2z50ucakaeC3P8BDkJDjKK7UbAQ+QzXUCWt4jf+KX4v4b1OAg50F7
         O8giPNQ1Gr1OQFbImG8DD8vYCtSgV1SOVamifylulKtUGWco9dA3gunRFS5HeQtWt5bj
         3r+mv6eiBHndP7j9e7JIh/nfre1KPTP4q7cOx79ZN57AMzMAmgorR4uXMILGpBxQQsc2
         /QWg==
X-Gm-Message-State: AOAM532UWuLSHXOKWtn4dv+Wc8Ic4lC8cvG6/Ig4ygrFv7qAfHwIAuJC
        uL3tjPzh44E7aOi+4QIo2iI=
X-Google-Smtp-Source: ABdhPJyK17Q4LviAzTooxG2YOgu7eLShEg5jPN6d8enDg7tl37gO4QClChrpEUuydirarVJn0/WQTQ==
X-Received: by 2002:a63:4909:: with SMTP id w9mr3323963pga.294.1603966047016;
        Thu, 29 Oct 2020 03:07:27 -0700 (PDT)
Received: from localhost ([2409:8a28:3c42:6840:9efc:e8ff:fef2:1cdc])
        by smtp.gmail.com with ESMTPSA id j138sm2375325pfd.19.2020.10.29.03.07.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 03:07:26 -0700 (PDT)
From:   Coiby Xu <coiby.xu@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 5/9] mfd: stpmic1: remove unnecessary CONFIG_PM_SLEEP
Date:   Thu, 29 Oct 2020 18:06:43 +0800
Message-Id: <20201029100647.233361-5-coiby.xu@gmail.com>
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
 drivers/mfd/stpmic1.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mfd/stpmic1.c b/drivers/mfd/stpmic1.c
index eb3da558c3fb..8be7a6dd9bbb 100644
--- a/drivers/mfd/stpmic1.c
+++ b/drivers/mfd/stpmic1.c
@@ -162,7 +162,6 @@ static int stpmic1_probe(struct i2c_client *i2c,
 	return devm_of_platform_populate(dev);
 }
 
-#ifdef CONFIG_PM_SLEEP
 static int stpmic1_suspend(struct device *dev)
 {
 	struct i2c_client *i2c = to_i2c_client(dev);
@@ -187,7 +186,6 @@ static int stpmic1_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(stpmic1_pm, stpmic1_suspend, stpmic1_resume);
 
-- 
2.28.0

