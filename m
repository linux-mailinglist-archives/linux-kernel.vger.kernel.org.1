Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B14B829E861
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 11:07:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725966AbgJ2KHQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 06:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725385AbgJ2KHQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 06:07:16 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FBF6C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 03:07:16 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id 15so1908289pgd.12
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 03:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aeP0x6n1a0s75DexSzIVy0CaEuEKcfsKH9UQhx7ZvLk=;
        b=VgNtPuroCzF8uTmSWiB4pMBWXwbltpRSDCwhH6twhRbXnWNo/rZ/ByIVXe58lg7w2e
         zekj3t1MAuNdJK/34p9SD6KkQALLOwptQ98TpIoaVk1g9y7J+VXWHjfaiMmp9pBFXset
         W5x82rUT/hwRv5/NFL1QFGnwbj9+dJpAmXFBmxxH27vw7iH8BkRkUUHfshyd4TJI9UKQ
         egPtuOz068A4n+l11xEE8Rhe398BjlyV+LrNxJ6GzhtZeCAG7flwdRrv5eDe7l4pFmAZ
         cOeGuM0hUozb1OG9+auiV1skPFL/0q/432jvEmLbAIImP9+Dlmo/MqqwwAbhEfKFta6y
         z5xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aeP0x6n1a0s75DexSzIVy0CaEuEKcfsKH9UQhx7ZvLk=;
        b=dlLKjh9tiO2R7nOXE9MQtf/7D5o341bLppi8VvSSANqBDvEmUBeWA55eXrFrCgpPAB
         MaM/1siiNNKLY07m/+771yjwTKJ8G0T9aL4E/fyR6Fg/QGYS0bV9LXQe+dpBSpjtXiyY
         rpn6C+Gw0rSHK5DWkRyQuEwCGXZiy0dn9bT7mfaf3MrZv8lxxCEjF0WZYCkDdfBcsdKM
         Jth+zy3c5NPUTH80W2xd0t2l970MjGlgZM3J1dRNzzz8/zdK9aaE/0gH5h8j7sSmBuz+
         UezOrmryWVt7lNGe0WyzNmSesCKl6RBKFFWHzNPEZSleGMhZWr3h+lNATT7N9GUZSRY2
         87yQ==
X-Gm-Message-State: AOAM533D4tgncG0ioe+bgclkKuTchvBNjaqHF1vPhvvJby9EtZNz63yc
        0uhtfUkvsaVQCt8wZiFtodo9ovaXuNnaVHOz
X-Google-Smtp-Source: ABdhPJwt/FU2aUbdRPsn98bxjPcyNc1+Kl9+FAWe47vhvLycujFu50uVneHXEf89h9FrGiFRih8yNw==
X-Received: by 2002:a63:731e:: with SMTP id o30mr3327966pgc.179.1603966030870;
        Thu, 29 Oct 2020 03:07:10 -0700 (PDT)
Received: from localhost ([2409:8a28:3c42:6840:9efc:e8ff:fef2:1cdc])
        by smtp.gmail.com with ESMTPSA id b67sm2383858pfa.151.2020.10.29.03.07.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 03:07:10 -0700 (PDT)
From:   Coiby Xu <coiby.xu@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/9] mfd: motorola-cpcap: remove unnecessary CONFIG_PM_SLEEP
Date:   Thu, 29 Oct 2020 18:06:40 +0800
Message-Id: <20201029100647.233361-2-coiby.xu@gmail.com>
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
 drivers/mfd/motorola-cpcap.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mfd/motorola-cpcap.c b/drivers/mfd/motorola-cpcap.c
index 2283d88adcc2..97c07a5641c5 100644
--- a/drivers/mfd/motorola-cpcap.c
+++ b/drivers/mfd/motorola-cpcap.c
@@ -214,7 +214,6 @@ static const struct regmap_config cpcap_regmap_config = {
 	.val_format_endian = REGMAP_ENDIAN_LITTLE,
 };
 
-#ifdef CONFIG_PM_SLEEP
 static int cpcap_suspend(struct device *dev)
 {
 	struct spi_device *spi = to_spi_device(dev);
@@ -232,7 +231,6 @@ static int cpcap_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(cpcap_pm, cpcap_suspend, cpcap_resume);
 
-- 
2.28.0

