Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 438132CB992
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 10:45:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388431AbgLBJoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 04:44:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388237AbgLBJoB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 04:44:01 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B4AC061A51
        for <linux-kernel@vger.kernel.org>; Wed,  2 Dec 2020 01:42:54 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id w4so732395pgg.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Dec 2020 01:42:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DLEpetMqROUc2OOQ0fVepK2+3FOFzdcD46Lm023xCZ4=;
        b=sU60JdKX1bMF/Sz7d8IzSVSDvOXsbOvwUI2moEbOr32zMImmIXisPR4ivQlpmM7GBD
         8vU1N9taSa/VTd1x+vqPqF5yJ6oGdyP3GjJR8VNb5fncOJw3lqXP0LEsSN3Q4oYTen08
         dUbgpk7gZuqw9j6ZLhcVGRUT2vwJIkRgR01Qcx4yhPc6xiIT/+hPfNfTYPchU9r4Y2E+
         UP/6nNpdVg8yEy5zSUEwbuxuLZ5gTrxBE9pWgOaSiP+fXxcGewfU0N+dPTAOw06E2kf/
         YKLPbK1jgLsfu9DbvxhXgf+J73zF3NMf/BGAk8IDgjaSwn72crV72GvqnVYcYkOnBNT0
         584Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DLEpetMqROUc2OOQ0fVepK2+3FOFzdcD46Lm023xCZ4=;
        b=lFXZny+Os7vQdwMWQphkmwg5lrkEga7b73mCOOItOnMX7zcdKCsb/ORGk0/Q5YWvPs
         IyzXpbFGW/Q3j7iSe+4q+jPQNUoQZVMeABrbI2hvyDZC4cAmHaikn8riSD4FfU4X4IVk
         br5Vot/ZZC2XvloQ+Ksz0UEn1i5E8tSJE4K3TTjDWsbOzZGonHcszcx2cjLTegqEQzcd
         tN+Zfrb6/c+Ndd41wV/Su95JlUzhJDYK1kFEXAAbPFpbQ33c22bJZounrxIOjy+NkaQ2
         r/pQgg4WoNNWUlrEUBW609WCreYh1TBNImM/kigPtR+k+5Xy+REgKnv/f99B1EiqAez5
         NIUA==
X-Gm-Message-State: AOAM532vJ6s5Jaykj1eSXjm2VaMB5O7GN/SO9rmVc9YopI9Fe65yHUQE
        U9Fui93EOZ/JGgWNj8nYXpZ8
X-Google-Smtp-Source: ABdhPJwHSq366NwHqsSA6mecJNUKt0tiWbN7DTmr/Cyx2wGsHOOFILBi1UUgxdtGZEY4wVJOMDXCew==
X-Received: by 2002:a63:c54e:: with SMTP id g14mr1900811pgd.398.1606902174395;
        Wed, 02 Dec 2020 01:42:54 -0800 (PST)
Received: from localhost.localdomain ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id bg8sm1393990pjb.52.2020.12.02.01.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 01:42:53 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        linux-arm-msm@vger.kernel.org, jhugo@codeaurora.org,
        linux-kernel@vger.kernel.org, loic.poulain@linaro.org,
        kernel test robot <lkp@intel.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 07/29] bus: mhi: core: Remove unnecessary counter from mhi_firmware_copy()
Date:   Wed,  2 Dec 2020 15:11:37 +0530
Message-Id: <20201202094159.107075-8-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201202094159.107075-1-manivannan.sadhasivam@linaro.org>
References: <20201202094159.107075-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bhaumik Bhatt <bbhatt@codeaurora.org>

There is an extra 'i' counter in the mhi_firmware_copy() function
which is unused. Remove it to clean-up code and reduce stack
space as well as improve efficiency of the function.

Fixes: cd457afb1667 ("bus: mhi: core: Add support for downloading firmware over BHIe")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/core/boot.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/bus/mhi/core/boot.c b/drivers/bus/mhi/core/boot.c
index 24422f5c3d80..6b6fd9668c3b 100644
--- a/drivers/bus/mhi/core/boot.c
+++ b/drivers/bus/mhi/core/boot.c
@@ -365,7 +365,6 @@ static void mhi_firmware_copy(struct mhi_controller *mhi_cntrl,
 	size_t remainder = firmware->size;
 	size_t to_cpy;
 	const u8 *buf = firmware->data;
-	int i = 0;
 	struct mhi_buf *mhi_buf = img_info->mhi_buf;
 	struct bhi_vec_entry *bhi_vec = img_info->bhi_vec;
 
@@ -377,7 +376,6 @@ static void mhi_firmware_copy(struct mhi_controller *mhi_cntrl,
 
 		buf += to_cpy;
 		remainder -= to_cpy;
-		i++;
 		bhi_vec++;
 		mhi_buf++;
 	}
-- 
2.25.1

