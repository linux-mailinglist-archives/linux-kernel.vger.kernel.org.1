Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31367272B33
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Sep 2020 18:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbgIUQLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Sep 2020 12:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727361AbgIUQLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Sep 2020 12:11:33 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC78C061755
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 09:11:33 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id d6so9660909pfn.9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Sep 2020 09:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XoxjnAxcXSK+doGfZtwAsYYDHZgQmagtLGt6UeBmKRw=;
        b=VeKxncsL1VI/xZ1xbiiWNoLrums/HMt3vbur7JrZTdPqAodBaMgQ0m1q8kvyXQ3Qzk
         lLjWxYaykZvqQwWJ3oCrM07DpQ1Z12Yp5trlNKw3TGeiuy7aI3A9jVb/u0IuTrfIIKXq
         pkXXH4Mo8HCeBVZYVZM9k/MhJJVYJ/kUlnOQ1WrFsxM57AmQKOXFHhXVMRX1D8PxHJAw
         1jSTH1np9g99Kc/HENcgrv8/osk/V9kLOPkldWOsCTm5izrBJo0AQJEzioXKqp4JKC4d
         CySgc900VaTLkpdLZkpcAaXFHIvMm4mNbiTYmqlXVAsxEqRSA2Lw1rWyKamgN71yAAeY
         QMbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XoxjnAxcXSK+doGfZtwAsYYDHZgQmagtLGt6UeBmKRw=;
        b=NQKdW2D/+g8ib87vjha9SxtJgCBGGJ7X3ebJXlWH1sF2qtFbNi77P6JaQGx3ukcwpK
         NS309u4PACxrBidkg8Fyw07smuipCh8QAz/JXZMX9XB6r0JQ8/Y8CRzjTJS69TzuIesg
         rAVGevl6WhNlxP9Dcy9DCAbb1XFTPtIRwR5NyYATEl8HbSQyAU5ywa8o2GuNZNi+xfgj
         kFAm0P2ZdXcaDJJCm/fTT1sUMYIIZL6MiWkf+K2dr/41GcNRplWwEXpxg9IBywBSSIVT
         IlGrOEG6QcM19DPU0V+iMMOCZ4+1hvPBOPb3nHg45Q8+qqNa1e8VFS5QBRjViApCv3qS
         YUBw==
X-Gm-Message-State: AOAM530y9kggifCEgdUjejatUbgKz6PjIih7sDm+/JRaf1go0TMzmmFH
        dVgVXzCewP6x+dyZHQxTRs9Q
X-Google-Smtp-Source: ABdhPJzqHcCGFdcUHtPcwks1H7hUGoxCU3aM/u+L4EjcGahZb7Sa2qHIK0kdwJnuCQbagDPA4D+9ew==
X-Received: by 2002:a63:b47:: with SMTP id a7mr291507pgl.57.1600704692608;
        Mon, 21 Sep 2020 09:11:32 -0700 (PDT)
Received: from Mani-XPS-13-9360.localdomain ([2409:4072:6d03:bd12:1004:2ccf:6900:b97])
        by smtp.gmail.com with ESMTPSA id f4sm9204577pgr.68.2020.09.21.09.11.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2020 09:11:31 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     hemantk@codeaurora.org, jhugo@codeaurora.org,
        bbhatt@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Loic Poulain <loic.poulain@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 17/18] bus: mhi: Remove unused nr_irqs_req variable
Date:   Mon, 21 Sep 2020 21:38:14 +0530
Message-Id: <20200921160815.28071-19-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200921160815.28071-1-manivannan.sadhasivam@linaro.org>
References: <20200921160815.28071-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Loic Poulain <loic.poulain@linaro.org>

nr_irqs_req is unused in MHI stack.

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/core/init.c | 3 ---
 include/linux/mhi.h         | 2 --
 2 files changed, 5 deletions(-)

diff --git a/drivers/bus/mhi/core/init.c b/drivers/bus/mhi/core/init.c
index 049a10fa42d7..799111baceba 100644
--- a/drivers/bus/mhi/core/init.c
+++ b/drivers/bus/mhi/core/init.c
@@ -694,9 +694,6 @@ static int parse_ev_cfg(struct mhi_controller *mhi_cntrl,
 		mhi_event++;
 	}
 
-	/* We need IRQ for each event ring + additional one for BHI */
-	mhi_cntrl->nr_irqs_req = mhi_cntrl->total_ev_rings + 1;
-
 	return 0;
 
 error_ev_cfg:
diff --git a/include/linux/mhi.h b/include/linux/mhi.h
index fb45a0ff9aa3..d4841e5a5f45 100644
--- a/include/linux/mhi.h
+++ b/include/linux/mhi.h
@@ -312,7 +312,6 @@ struct mhi_controller_config {
  * @total_ev_rings: Total # of event rings allocated
  * @hw_ev_rings: Number of hardware event rings
  * @sw_ev_rings: Number of software event rings
- * @nr_irqs_req: Number of IRQs required to operate (optional)
  * @nr_irqs: Number of IRQ allocated by bus master (required)
  * @family_number: MHI controller family number
  * @device_number: MHI controller device number
@@ -393,7 +392,6 @@ struct mhi_controller {
 	u32 total_ev_rings;
 	u32 hw_ev_rings;
 	u32 sw_ev_rings;
-	u32 nr_irqs_req;
 	u32 nr_irqs;
 	u32 family_number;
 	u32 device_number;
-- 
2.17.1

