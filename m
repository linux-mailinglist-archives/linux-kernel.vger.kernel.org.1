Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75E0329E869
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 11:07:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726395AbgJ2KHo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 06:07:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726345AbgJ2KHm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 06:07:42 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21864C0613CF
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 03:07:42 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id x13so1924475pgp.7
        for <linux-kernel@vger.kernel.org>; Thu, 29 Oct 2020 03:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QNZY32cDasX8W6NS9YxVOrELwcy6A3anBtmmEKNCzAA=;
        b=QT9PiP4AyQFjWNFAmbHqSwtAwK6JqAzM9FCZiRMmH/ZRTdxyRRd3/rzNXyQwMNY49Q
         4CycHOllQDsCCsOwHHV17lICPWgrcIujjvna+uHu7BnnhFYdjkM1L7dsjKobZjRn0nuq
         Xg0FEMg4FNiTCCyTyyIAMMKfZI33YuEBDJD60H05JpFIsA2t/1qcRzrA84fdjkCj1GbY
         QAHbkr9cH6THIISXmeLXH1RnXgH/3+L9IA8Wx0F2W+XYmD1benJzgEoMFwoDskDsmema
         RjQzjp7bETqQfhR5FmNMhI/nWqJARmgE8Nfeq/qY87Kt9PcXJQ/8myCS7e1UdrZdH85s
         HViA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QNZY32cDasX8W6NS9YxVOrELwcy6A3anBtmmEKNCzAA=;
        b=lMkz8l1hDtvNTwA1+5+bB3z10CC0d0lo70stsKLcSDHnPQZ5nJDvWqgIjsN5AlIYx0
         274p7AsYnyztoqdsuHkmzu1GGwkIc4g5lWDKMG5n1eXPBCD82EdpDyAwfkWct7x4LmHd
         rKaynCMWKAXBQGYNtVLaqlS7axz+LOZAplni9Byrtn0eSZshHyw9MLSQzXtp3A/jJTRB
         CcoGWmYYCmKEDv9LSLBslrt2Ez1VGVok3fvtSmG4gr2xwsrxUoJtbdK8j+TCketlHtaa
         IZTfMzS2t+j8cUm3tni03P6sShz3pywCR1nvvfTwvhEqCVnsyBJe5WCjwqbJ9u6q0YjN
         nkfg==
X-Gm-Message-State: AOAM53255y01rkHVfdsSQZqa8JSf2wcN3BBzao0vSLcpdBpxitGVqGhE
        CekS3GljtFsZx3FUcqmwkI8=
X-Google-Smtp-Source: ABdhPJwXZOsWd79JwIF9iliUaOj5QnKHO/zWZpONvHGWCg8/LCEXo2D+OWWqeIS+5PuvVtdTiWbRog==
X-Received: by 2002:a17:90a:f206:: with SMTP id bs6mr3433003pjb.219.1603966061710;
        Thu, 29 Oct 2020 03:07:41 -0700 (PDT)
Received: from localhost ([2409:8a28:3c42:6840:9efc:e8ff:fef2:1cdc])
        by smtp.gmail.com with ESMTPSA id h20sm2131907pgv.23.2020.10.29.03.07.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2020 03:07:41 -0700 (PDT)
From:   Coiby Xu <coiby.xu@gmail.com>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-kernel@vger.kernel.org (open list:MAXIM PMIC AND MUIC DRIVERS FOR
        EXYNOS BASED BO...)
Subject: [PATCH 8/9] mfd: max14577: remove unnecessary CONFIG_PM_SLEEP
Date:   Thu, 29 Oct 2020 18:06:46 +0800
Message-Id: <20201029100647.233361-8-coiby.xu@gmail.com>
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
 drivers/mfd/max14577.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/mfd/max14577.c b/drivers/mfd/max14577.c
index be185e9d5f16..c619dd8172d5 100644
--- a/drivers/mfd/max14577.c
+++ b/drivers/mfd/max14577.c
@@ -482,7 +482,6 @@ static const struct i2c_device_id max14577_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, max14577_i2c_id);
 
-#ifdef CONFIG_PM_SLEEP
 static int max14577_suspend(struct device *dev)
 {
 	struct i2c_client *i2c = to_i2c_client(dev);
@@ -515,7 +514,6 @@ static int max14577_resume(struct device *dev)
 
 	return 0;
 }
-#endif /* CONFIG_PM_SLEEP */
 
 static SIMPLE_DEV_PM_OPS(max14577_pm, max14577_suspend, max14577_resume);
 
-- 
2.28.0

