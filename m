Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1345F27D527
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 19:54:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbgI2Rxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 13:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728670AbgI2Rxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 13:53:49 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819C4C061755
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 10:53:49 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id e18so4480131pgd.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 10:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=maouQTMrsxpLVka2tVtG0rlrDbgTOcw+DDAUcgByUy4=;
        b=DBlFCS792aAzgH+YUwYyG64zLj2k7P2a9/rWGSqHCFFdPuF5zjQJitPgucRktCcOif
         J6XBhlAKlusXgUvJMiMe5tT+Zr42S5N8wqv/9fL5Caxon8ra+EW8YTyrC/SSnz5OP5z4
         0FlUaB2kBe7nziZMZKosh4/TLmwFwyUIwG90Q9QnrUBxHKaRCGt+ddjYVH5cJWD0bnSN
         25rS9bIn91THpyIueoNDZHu5ZE7Myc+m1yVMPwjXv7RxqqNboopoE1F8rlbhAGVY2B0d
         eH8DFkXwo7LanUFcdBqvs0V+UkVS2WXCWC3wf2d4Mh4Pg8DZeIOu6kQP5m5yIqvFNFMd
         mCsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=maouQTMrsxpLVka2tVtG0rlrDbgTOcw+DDAUcgByUy4=;
        b=CzZeFAJBqDq2npZ9801Vs22PxklZW8lsTf+C4jj9EoaDmV4AK3hf0wntOcdF7DNaZm
         LoCNTKdjebsj76+XiKjuIwwNBDJk0xF1pCUeuoUhXs1Q4U1lnBpDAyGLGC3Xs+WuNjiB
         C+9f9XNY+V7QeZzWJodkPelAZiu0hMv4Wf798YTP3Fgb2PGANQlrOHNb8LBNw3iuKocD
         2OhSlgEbF6dcAh7vItl9ndLak9YhiP7dTelbomo5a5NH9+yIjj8Zyf+c1b6VosLAC6rW
         3+RV1YFOu05jIsm5KEtrPQv9lFisfcRngxCgRnqljQ+WT7opj1rJEPuKweMubNhHRO9Y
         KP9A==
X-Gm-Message-State: AOAM530BmxJqBBCWdytaFimnlk7TYqN5yztSTT2/8hLkiw6Gu3BU+lS/
        Q771WJvSHgZuNWVWedfW8HHV
X-Google-Smtp-Source: ABdhPJwsPcrCsb5NI3bCKFLI703acgMqVlHrSNfzGVuqStm8g6hRHp/Fl6+Ulg+C/ABAgsA2FcdGFA==
X-Received: by 2002:aa7:8051:0:b029:13e:d13d:a04e with SMTP id y17-20020aa780510000b029013ed13da04emr5027675pfm.20.1601402028950;
        Tue, 29 Sep 2020 10:53:48 -0700 (PDT)
Received: from Mani-XPS-13-9360.localdomain ([103.59.133.81])
        by smtp.gmail.com with ESMTPSA id r188sm6271046pfc.67.2020.09.29.10.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 10:53:48 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        linux-arm-msm@vger.kernel.org, jhugo@codeaurora.org,
        linux-kernel@vger.kernel.org,
        Loic Poulain <loic.poulain@linaro.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v3 19/19] bus: mhi: debugfs: Print channel context read-pointer
Date:   Tue, 29 Sep 2020 23:22:18 +0530
Message-Id: <20200929175218.8178-20-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929175218.8178-1-manivannan.sadhasivam@linaro.org>
References: <20200929175218.8178-1-manivannan.sadhasivam@linaro.org>
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

