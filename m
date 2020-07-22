Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94CC92295A8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jul 2020 12:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731673AbgGVKIP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jul 2020 06:08:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726153AbgGVKIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 06:08:13 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5AD0C0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 03:08:12 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id a14so1316053wra.5
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 03:08:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0pfIx0Qut2dD6gNBwCzcD0XIuQfHiiY0nxSbNEpbg8o=;
        b=xg9RGuW9966NcN+bBp/hoNZJTbzJ/itBLyXaNSEAdkrJiSmzd2sj2/ZagGQWkY36WW
         r0a03TYRxIj8DKxHKKGgpS+VUtYSmB08pM6e2i9G4+WyRCb+E0GSmJNFHRUMrf7tV9gk
         qo9IbI8YLINwrZGuA88aFdszQaWLc0tp6G7c7GjzC80z0a0ekYnMi+ATLvmcahvKScx+
         sLLAuJxTyTzkdbD+0/luozgBELcRRFTTc7WG6yBy7+0jihn338gb6ZMQUPB1cln7zQPl
         u+0vFU2h5bE+Jmvxe7smAlP4u0EWj0s+4UDIC52TUsVUUCnT7lC778KC5N+PfLsIX7/b
         ckJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0pfIx0Qut2dD6gNBwCzcD0XIuQfHiiY0nxSbNEpbg8o=;
        b=MFRLYx1ciyDCZO5uN8hKDhEF3hwF3inhntpvG+DIEpkoJcptRPGVAubqvB1TCA0mrA
         +y2U2VtMgKL1SBJSflp5mTY+zfK0csNjikeMcbC561XS6QSJQW3anrfoCPuztRDdvob5
         nZIH3J7IIBdiBCwGblU0H+bj4q6xYOMGdhTKUVU8BMe27Gb2+pgH/rW3JC61MKwSPLQi
         6bWwGafRDQclORUbcy5mU/ytIIgX5NPSPwfybtp8wbYnScBfCeWyv4yTsD4gGG94Xq32
         8euaIVRjS94CpJe7J7AM11goFhpWO2dK1UYfjYVJB+C+N5bsY7nDhNx1yegMxPLXcy1D
         +WXA==
X-Gm-Message-State: AOAM530znF2KOg/HKn4QmhR0RNSVmuqLZI6SAqdanIYHXIlF4U725gEF
        3axZax84zG0h5QcT4Z46/39j6xtP6Ik=
X-Google-Smtp-Source: ABdhPJyllcN8dagYVE1zQLerS6DIphs7nsBOylKTcRTvivNH8KYSmMPi/qMMioB2JB2gXZAoIHD4nw==
X-Received: by 2002:adf:a299:: with SMTP id s25mr16235528wra.106.1595412491542;
        Wed, 22 Jul 2020 03:08:11 -0700 (PDT)
Received: from srini-hackbox.lan (cpc89974-aztw32-2-0-cust43.18-1.cable.virginm.net. [86.30.250.44])
        by smtp.gmail.com with ESMTPSA id t13sm17098623wru.65.2020.07.22.03.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 03:08:10 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, Tiezhu Yang <yangtiezhu@loongson.cn>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 01/14] nvmem: sprd: Fix return value of sprd_efuse_probe()
Date:   Wed, 22 Jul 2020 11:06:52 +0100
Message-Id: <20200722100705.7772-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200722100705.7772-1-srinivas.kandagatla@linaro.org>
References: <20200722100705.7772-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tiezhu Yang <yangtiezhu@loongson.cn>

When call function devm_platform_ioremap_resource(), we should use IS_ERR()
to check the return value and return PTR_ERR() if failed.

Fixes: 096030e7f449 ("nvmem: sprd: Add Spreadtrum SoCs eFuse support")
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/sprd-efuse.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/nvmem/sprd-efuse.c b/drivers/nvmem/sprd-efuse.c
index 925feb21d5ad..59523245db8a 100644
--- a/drivers/nvmem/sprd-efuse.c
+++ b/drivers/nvmem/sprd-efuse.c
@@ -378,8 +378,8 @@ static int sprd_efuse_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	efuse->base = devm_platform_ioremap_resource(pdev, 0);
-	if (!efuse->base)
-		return -ENOMEM;
+	if (IS_ERR(efuse->base))
+		return PTR_ERR(efuse->base);
 
 	ret = of_hwspin_lock_get_id(np, 0);
 	if (ret < 0) {
-- 
2.21.0

