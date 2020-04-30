Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 556FD1C05A6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 21:06:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbgD3TGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Apr 2020 15:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726853AbgD3TG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 15:06:29 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2DBC035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 12:06:28 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id h11so2612459plr.11
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 12:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=w/e0sFCiHkWZ/pUleIEQQ5eNFFg5ce0+O2BEm35hI8k=;
        b=LLV3k+K1eDs0cMEs1NnGL6zPog74yxpY0C4JeWKzjsCoNXNxulXybWhvjyN55chFUo
         wi3sCflCYn3OhE4vXu3EB8fyCwNc4p52wmk1C6lEA8zVhYcrHoi3We7yaauVs1vEbsIi
         kOpZQ2nnQ+yynjxwp/khhaS7E5cSzN40/wHVFqEQ4n6zIKBmZVhh3ErfdvD1DML71Yzp
         219K5we5WrlFEcPl5pWWkNxCWeHmd0SV33UfSXD/9DRO4VDgIP/M3PLFB1rlxU6V8R0S
         5pE1t1MqxTqVcdBZ20UZdusc6kg6Gbe+Ix+bPdbUP/4RmdVqmchuTmmiNCULQBP7uMqw
         q7Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=w/e0sFCiHkWZ/pUleIEQQ5eNFFg5ce0+O2BEm35hI8k=;
        b=kyT86Gn56nQlIwmPub/GYP3ivMNI7EjUu45pJX48CNmMaL5spokI5azI5zLZQlKGxO
         JBS6IxMgzryMUGG2z/YNyywiIrJ3Vslg4aU+ZKKIR9uWDP1oklcE9bQa40YFpwdrwbL1
         clzA6OX8qmIokEw3mZR4oDQ9+VQyDLdGVBR1xpLql8w5X74/VsuvBXkVfy5iCJkchKdR
         ibchPvrxeasy/PLxQpwxHwEoDOE6BeROF2ojuYyFSky4Z2V6rWhdDFmSKjmotNpTJpF2
         i1odaS8FMO4ldfI7SClIihGIvS1aMeX/ERM7ZzV2c0jpMLtiLhhgvNNCeWTGhjfDOdBa
         /KJg==
X-Gm-Message-State: AGi0PuZhUyNohJBq8mwIMSg4EwP0qlZu3cg3Oa0a5M1eIS64jHwpAz30
        JWEteP7RBd2LhVijLtyxnAic
X-Google-Smtp-Source: APiQypJJVO0xLYp3ha4tq6wbudCY/3MtMc9vE/hG79BqTGCNQMI2rJf4+vTlq9vmCx3imNXrw26+fw==
X-Received: by 2002:a17:90a:37c4:: with SMTP id v62mr233665pjb.177.1588273587530;
        Thu, 30 Apr 2020 12:06:27 -0700 (PDT)
Received: from localhost.localdomain ([2409:4072:6081:946c:419e:a71:7237:1613])
        by smtp.gmail.com with ESMTPSA id l37sm467863pje.12.2020.04.30.12.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 12:06:26 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     hemantk@codeaurora.org, jhugo@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 5/6] bus: mhi: core: Fix typo in comment
Date:   Fri,  1 May 2020 00:35:54 +0530
Message-Id: <20200430190555.32741-6-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200430190555.32741-1-manivannan.sadhasivam@linaro.org>
References: <20200430190555.32741-1-manivannan.sadhasivam@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jeffrey Hugo <jhugo@codeaurora.org>

There is a typo - "runtimet" should be "runtime".  Fix it.

Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
Reviewed-by: Hemant Kumar <hemantk@codeaurora.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 include/linux/mhi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mhi.h b/include/linux/mhi.h
index ab737821ab89..b0739ad1bae4 100644
--- a/include/linux/mhi.h
+++ b/include/linux/mhi.h
@@ -339,7 +339,7 @@ struct mhi_controller_config {
  * @wake_put: CB function to de-assert device wake (optional)
  * @wake_toggle: CB function to assert and de-assert device wake (optional)
  * @runtime_get: CB function to controller runtime resume (required)
- * @runtimet_put: CB function to decrement pm usage (required)
+ * @runtime_put: CB function to decrement pm usage (required)
  * @map_single: CB function to create TRE buffer
  * @unmap_single: CB function to destroy TRE buffer
  * @read_reg: Read a MHI register via the physical link (required)
-- 
2.17.1

