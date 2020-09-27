Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E1BD279DC3
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 05:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730268AbgI0DhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 23:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730191AbgI0DhE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 23:37:04 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95093C0613CE
        for <linux-kernel@vger.kernel.org>; Sat, 26 Sep 2020 20:37:04 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id j7so1490200plk.11
        for <linux-kernel@vger.kernel.org>; Sat, 26 Sep 2020 20:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WCUPmHYtcecToV38t2DlfIgpoympluaCI7mC24k2euU=;
        b=hL5ttpELNTHIzHTM0NXc1KB+orhq+qOuVQMdmV/HBUP85y98fg7Hdfn+Lo/bzu1RNH
         XWoJDDi2cKtnM0dCTYzENiIUiwJ3+z4nsLOrqNcTtlDWtoti4snZc3U/6EzF1vszsILm
         ZRP5EuDdvCGj9POET21nl5sEudcoCCrbc6kRPXEqMjM/7wIjXrirk2AZv6ryHUI4NLqA
         rZflNKVy6vhuQjEQ70ow/XxIotdleVYGkWDgtQ1vVlAd2NTqgbTRAWl490JY6Ze4BnLu
         UIPo+Z0UsZgF1LOnA7sPyztsprdrORYiSayhkd5J2Ye6qwvG1gFCMz0NntyZ4siQUUAF
         axLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WCUPmHYtcecToV38t2DlfIgpoympluaCI7mC24k2euU=;
        b=ltx2Q1oc5ROt71/2LRNI6nZIvJlTqbJMLE4RPQHT2fHvT8F9dJVbTtguuPQeTqcdsj
         RV4M8fIVjxYDnfGd84KMIRFlZdXSYrux8o9oa3e4WFf1SOFSo9kHreyji7H+55ZLf8R8
         JSlSNS0DeurpX+oRbpZV17JwAWrymC+lNKUGhWmBD5cL/x6tiajeVgySyYmk/Md1vO9O
         oc0IC0aaXY3EEXUuIseOzWtPhaYlPALPZH8KxaNq9+kiH0tBlLSnUtbl9nmzYpy7NUr5
         8aqvxy/8VQMHzX//r14IbX+Wp+IgmNHNi/COerghttJtrtHAUPPax5uUbzf1QVk2BXeU
         v6SQ==
X-Gm-Message-State: AOAM533X3sVFFhCa/AsXqPAduZOsKFHI2HFWfOjt7tHbpXu8dzCFvYnp
        XOe2wEgN5BBqY/MQbVXgI8Bb
X-Google-Smtp-Source: ABdhPJwWDGBZpsLbbF/gWY0cgCUr4ze7esNeitBNIYDCgOsRqkuPCkOkxKqCkOC8VJhGuocTpbym8Q==
X-Received: by 2002:a17:90a:e291:: with SMTP id d17mr4033617pjz.156.1601177824025;
        Sat, 26 Sep 2020 20:37:04 -0700 (PDT)
Received: from Mani-XPS-13-9360.localdomain ([2409:4072:980:cb63:5c53:a3bf:dd6b:614d])
        by smtp.gmail.com with ESMTPSA id gx5sm2821439pjb.57.2020.09.26.20.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2020 20:37:03 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        linux-arm-msm@vger.kernel.org, jhugo@codeaurora.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 1/5] bus: mhi: core: debugfs: Use correct format specifiers for addresses
Date:   Sun, 27 Sep 2020 09:06:48 +0530
Message-Id: <20200927033652.11789-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200927033652.11789-1-manivannan.sadhasivam@linaro.org>
References: <20200927033652.11789-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For exposing the addresses of read/write pointers and doorbell register,
let's use the correct format specifiers. This fixes the following issues
generated using W=1 build in ARM32 and reported by Kbuild bot:

All warnings (new ones prefixed by >>):

>> drivers/bus/mhi/core/debugfs.c:75:7: warning: format specifies type 'unsigned long long' but the argument has type 'dma_addr_t' (aka 'unsigned int') [-Wformat]
                              mhi_event->db_cfg.db_val);
                              ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/bus/mhi/core/debugfs.c:123:7: warning: format specifies type 'unsigned long long' but the argument has type 'dma_addr_t' (aka 'unsigned int') [-Wformat]
                              mhi_chan->db_cfg.db_val);
                              ^~~~~~~~~~~~~~~~~~~~~~~
   2 warnings generated.

drivers/bus/mhi/core/debugfs.c: In function ‘mhi_debugfs_events_show’:
drivers/bus/mhi/core/debugfs.c:74:51: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
   seq_printf(m, " local rp: 0x%llx db: 0x%pad\n", (u64)ring->rp,
                                                   ^
drivers/bus/mhi/core/debugfs.c: In function ‘mhi_debugfs_channels_show’:
drivers/bus/mhi/core/debugfs.c:122:7: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
       (u64)ring->rp, (u64)ring->wp,
       ^
drivers/bus/mhi/core/debugfs.c:122:22: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
       (u64)ring->rp, (u64)ring->wp,
                      ^
drivers/bus/mhi/core/debugfs.c:121:62: warning: format ‘%llx’ expects argument of type ‘long long unsigned int’, but argument 5 has type ‘dma_addr_t {aka unsigned int}’ [-Wformat=]
   seq_printf(m, " local rp: 0x%llx local wp: 0x%llx db: 0x%llx\n",
                                                           ~~~^
                                                           %x
drivers/bus/mhi/core/debugfs.c:123:7:
       mhi_chan->db_cfg.db_val);

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/core/debugfs.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/bus/mhi/core/debugfs.c b/drivers/bus/mhi/core/debugfs.c
index 53d05a8e168d..f50d73054db4 100644
--- a/drivers/bus/mhi/core/debugfs.c
+++ b/drivers/bus/mhi/core/debugfs.c
@@ -71,8 +71,8 @@ static int mhi_debugfs_events_show(struct seq_file *m, void *d)
 		seq_printf(m, " rp: 0x%llx wp: 0x%llx", er_ctxt->rp,
 			   er_ctxt->wp);
 
-		seq_printf(m, " local rp: 0x%llx db: 0x%llx\n", (u64)ring->rp,
-			   mhi_event->db_cfg.db_val);
+		seq_printf(m, " local rp: 0x%pK db: 0x%pad\n", ring->rp,
+			   &mhi_event->db_cfg.db_val);
 	}
 
 	return 0;
@@ -118,9 +118,9 @@ static int mhi_debugfs_channels_show(struct seq_file *m, void *d)
 		seq_printf(m, " base: 0x%llx len: 0x%llx wp: 0x%llx",
 			   chan_ctxt->rbase, chan_ctxt->rlen, chan_ctxt->wp);
 
-		seq_printf(m, " local rp: 0x%llx local wp: 0x%llx db: 0x%llx\n",
-			   (u64)ring->rp, (u64)ring->wp,
-			   mhi_chan->db_cfg.db_val);
+		seq_printf(m, " local rp: 0x%pK local wp: 0x%pK db: 0x%pad\n",
+			   ring->rp, ring->wp,
+			   &mhi_chan->db_cfg.db_val);
 	}
 
 	return 0;
-- 
2.17.1

