Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59B7F279DC6
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 05:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730281AbgI0DhK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 23:37:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730270AbgI0DhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 23:37:08 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8DB2C0613D4
        for <linux-kernel@vger.kernel.org>; Sat, 26 Sep 2020 20:37:08 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id kk9so1622584pjb.2
        for <linux-kernel@vger.kernel.org>; Sat, 26 Sep 2020 20:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=maouQTMrsxpLVka2tVtG0rlrDbgTOcw+DDAUcgByUy4=;
        b=mDm4W3yzeoJY+tZFkjPI3tfkbfyNUclLCUL1s58y4r+qkYirCaTDVbgkut8Qk/0O1W
         nSwlT58KMxitVWUO6r6WO5Fa4euN7/laD0prLOVlixZEP4Sp/AaCSpJPwov8pFq8PYGJ
         miVC1DPcUag2RjgjoO2w8zXByus1aWk6LfnwwIF1aKmCGzhemSjUbvQklwokKL/kVdwO
         WYM2tCKaxIuYpaXo1ykKA5GDrrZzcTglmJk0MU21O6Ykwq0m0Z1O+BEaiMQmUovcti7+
         hIV20ljHjTC5w4tmJ7fQWTbG5Sr+W2Z1EjjiWlw4f5cayc9QDvP95dfsIdyYiHZMcFpG
         bm/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=maouQTMrsxpLVka2tVtG0rlrDbgTOcw+DDAUcgByUy4=;
        b=bmdUMA9RlWqfu19IBnE6mX+BO2OiUoct4VddUYitL4CbzoBRogPjIm3+4x7Qj28FjA
         XIJFsfnQoC5wbthPIR1UGpstVhT1d8adUKsIAAJhmgLcOb5+66eWB7pS8wddqXjGooBZ
         ToiELdxWgNlaxQL/E6GwGBVS045ZAuuuWQYTPOHQcb0oVBEZVb6p95oVQo+pmGbe8Y/9
         sp0LRYwzR4EsU3dOmo+LvmTL/4jXF5cTX1QggvjlfeWwoyFGr70QVaJqvp67VdRjigIj
         x9dVzZljlJtQWmbL0vI7jD+1e1hECN5iji6KQhRVDYiTQmA3XCo4I7cDyOGRljNk+eUC
         Acpw==
X-Gm-Message-State: AOAM532EuRszy05d9M88GmhzkKLibzcljwe/RTCOBL8Y25Y8rDm/DqD2
        57gEIHRVGqT9MTd2qUnWw0HM
X-Google-Smtp-Source: ABdhPJwrErclynGaEZE5sPmYLXCSncUJHBxojuovN4E4lY20+mh0jHBYSckPwV8wQyqYHjyjdKAvyQ==
X-Received: by 2002:a17:90a:81:: with SMTP id a1mr4033993pja.136.1601177828330;
        Sat, 26 Sep 2020 20:37:08 -0700 (PDT)
Received: from Mani-XPS-13-9360.localdomain ([2409:4072:980:cb63:5c53:a3bf:dd6b:614d])
        by smtp.gmail.com with ESMTPSA id gx5sm2821439pjb.57.2020.09.26.20.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2020 20:37:07 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        linux-arm-msm@vger.kernel.org, jhugo@codeaurora.org,
        linux-kernel@vger.kernel.org,
        Loic Poulain <loic.poulain@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 2/5] bus: mhi: debugfs: Print channel context read-pointer
Date:   Sun, 27 Sep 2020 09:06:49 +0530
Message-Id: <20200927033652.11789-3-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200927033652.11789-1-manivannan.sadhasivam@linaro.org>
References: <20200927033652.11789-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Loic Poulain <loic.poulain@linaro.org>

This value was missing in the channel debugfs output.

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/core/debugfs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/bus/mhi/core/debugfs.c b/drivers/bus/mhi/core/debugfs.c
index f50d73054db4..3a48801e01f4 100644
--- a/drivers/bus/mhi/core/debugfs.c
+++ b/drivers/bus/mhi/core/debugfs.c
@@ -115,8 +115,9 @@ static int mhi_debugfs_channels_show(struct seq_file *m, void *d)
 		seq_printf(m, " type: 0x%x event ring: %u", chan_ctxt->chtype,
 			   chan_ctxt->erindex);
 
-		seq_printf(m, " base: 0x%llx len: 0x%llx wp: 0x%llx",
-			   chan_ctxt->rbase, chan_ctxt->rlen, chan_ctxt->wp);
+		seq_printf(m, " base: 0x%llx len: 0x%llx rp: 0x%llx wp: 0x%llx",
+			   chan_ctxt->rbase, chan_ctxt->rlen, chan_ctxt->rp,
+			   chan_ctxt->wp);
 
 		seq_printf(m, " local rp: 0x%pK local wp: 0x%pK db: 0x%pad\n",
 			   ring->rp, ring->wp,
-- 
2.17.1

