Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36C8329E862
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 11:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726078AbgJ2KHT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 06:07:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725984AbgJ2KHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 06:07:18 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5765C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 03:07:17 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id f38so1941282pgm.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 03:07:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z3uyqhlqWXKuwHdQG2D0FdRfbGt1sXQ7EAxhDbh4ezQ=;
        b=HNLV6ITZYROWMcg3nrkHILswyPfLMB2wgwajTF+d28HGFft4C/e3NEf5BhVPMbM/F2
         BZ5m0b0dwZg63FCw5u0bYrCy3QJrjcQDW6cdtcafperl1dZGF0Z4IYheGRSndIywShFT
         Wov1QVKW0V1YdcIvXCpU7Z3DH8eqfLUAF9jpbWeIF/U8TuPc6yujLr+spW5LuBi5Cg8O
         ozqLt3lo7Z6p1XZIROJll5zJjihmDYM1RZH3f4VZU2w0Ki0ly5+VYWc15zlxCm4HUTlA
         RtQ1nHlGKS6xYhrryTMDLrV6LrCXC4F9WQiuY5StEbil61tC/mT3hQ4WhNkfDhrMYgSf
         /kkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z3uyqhlqWXKuwHdQG2D0FdRfbGt1sXQ7EAxhDbh4ezQ=;
        b=BXAKXnfy7hC0P02Jyy/HqYGGQgSqmqUpQ5XVHyveRE9D58Px/oX8sA9VSeGoqFJHJl
         VZAmfSfQ5bqRHrvkHHhHIP4XZWyvKJoRas9ZYrFEm3HYChSwa7xLVEXss29cfwIfhK2G
         1kekqS7m3ncKKghqkwRhWXlh+a3XjiBa2zJSdIcX5LbrRq8B5FKRcLWCta5x/paMOk96
         Bp2Ij8RQVqdCUC+BiEXlvXs2XY84kAGUH+i9MM8Bmue6Fk8NAlKVDY/JHvt79UW/vFz6
         L8E1itMELVHKg4Moe3G67sAJxXVaMUUr4jCXCFyuF5yqgx8GEONtMALciBPWSEJoKmmp
         65Vg==
X-Gm-Message-State: AOAM532N12uJke7yoJmusdUXf3VVAf3PyGmD1NctwtY/0cARMFYPZ8vt
        3SBhGAGbNKMBp0OZT2zg3co=
X-Google-Smtp-Source: ABdhPJy4yMftR39l/qpWnO30S9moYM8XOdWyu21UcI0NcBPqblQV0VdhI+pkwBuM2MqUY8+AYpSXxA==
X-Received: by 2002:aa7:9af1:0:b029:152:6101:ad17 with SMTP id y17-20020aa79af10000b02901526101ad17mr3775035pfp.25.1603966037547;
        Thu, 29 Oct 2020 03:07:17 -0700 (PDT)
Received: from localhost ([2409:8a28:3c42:6840:9efc:e8ff:fef2:1cdc])
        by smtp.gmail.com with ESMTPSA id j23sm2188033pjn.42.2020.10.29.03.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 03:07:17 -0700 (PDT)
From:   Coiby Xu <coiby.xu@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Andy Shevchenko <andy@kernel.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 3/9] mfd: intel_soc_pmic: remove unnecessary CONFIG_PM_SLEEP
Date:   Thu, 29 Oct 2020 18:06:41 +0800
Message-Id: <20201029100647.233361-3-coiby.xu@gmail.com>
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
 drivers/mfd/intel_soc_pmic_core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mfd/intel_soc_pmic_core.c b/drivers/mfd/intel_soc_pmic_core.c
index ddd64f9e3341..c980af9ae1c0 100644
--- a/drivers/mfd/intel_soc_pmic_core.c
+++ b/drivers/mfd/intel_soc_pmic_core.c
@@ -122,7 +122,6 @@ static void intel_soc_pmic_shutdown(struct i2c_client *i2c)
 	return;
 }
 
-#if defined(CONFIG_PM_SLEEP)
 static int intel_soc_pmic_suspend(struct device *dev)
 {
 	struct intel_soc_pmic *pmic = dev_get_drvdata(dev);
@@ -140,7 +139,6 @@ static int intel_soc_pmic_resume(struct device *dev)
 
 	return 0;
 }
-#endif
 
 static SIMPLE_DEV_PM_OPS(intel_soc_pmic_pm_ops, intel_soc_pmic_suspend,
 			 intel_soc_pmic_resume);
-- 
2.28.0

