Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A14B2279B54
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 19:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729445AbgIZRVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 13:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgIZRVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 13:21:42 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC2BC0613D3
        for <linux-kernel@vger.kernel.org>; Sat, 26 Sep 2020 10:21:41 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id f18so5851742pfa.10
        for <linux-kernel@vger.kernel.org>; Sat, 26 Sep 2020 10:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vE+lYeuJds3ccRN3OwXIjY1LUbM5sVlk/OC8ULx/bQM=;
        b=FeCp2On5/N4RD8Roua4UykHpWJwwS42tCkD+QdXUWupLJZOsCd3JYA3HAZ++crywDy
         SOls6vyLmmlzkU4rKA9UIp+eKI/rpIHE5EzR1ZviqcWelfu1HdtCtIgY6OB6EsLknUmN
         V+j8L8brJpfztinMAwRJzOKDesg/k1oWJn2HzK3x8pVawf6S1Incz0Ae3IZxpbR09YV4
         JxGbmP1MQjtxfWRPvX1ylNegqsJjmsWyjrtqo2NsWcyvCIW1STTEy+Cymx1pRMADxveE
         2B2VgA711k7I/Iz3jCDmO462h3sEqLUowsHHfrCJV/yRhQ1Qi4jjuKjqpXNdvgBuXKYK
         PNcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=vE+lYeuJds3ccRN3OwXIjY1LUbM5sVlk/OC8ULx/bQM=;
        b=OKKy91wHKYs43cS0uay/7pDI5q0jqdj8tKdlwfe1qU9jmge/H7nr43id7OHSQ/0o3J
         6ThfCNblHMTK1hiPIAlhCzaZVI+QOf91182wlZLCbYz3wGBAcio+Tu3Hd7JZBRols+g/
         IcHrOu7yBoQDE2RcyCT/GZQgUqWtAID9Ao9C7UHnbXdUKU0YvRV4GPeljBtsPVHa2slN
         ZU9bsvWQ4hXpawL/m8Nk3pcKS/7Mm/1xUrxKHwQ2IpAs8dOVyO/lUl0VzdZYKFFbzW3L
         BWQM1Ezup3NUr1fUHEmt53dDUzXYCW00QfOHpN6EarwFWthUPKf64votxRpogfIEXSUv
         KY0g==
X-Gm-Message-State: AOAM530LxxsNjHIYWQK+lbQleWWBjmLqpMb50XkJfTcLTlK4Q91f6B95
        jYLhBjE1WLx3ugcDlP4t2CM3
X-Google-Smtp-Source: ABdhPJwFb59V6/SVoVMxRwkBZ1017jWA1Ra508qWGOOm+NuKOBk1aBVGfU6dvidmEZGAeXjSdE9bsA==
X-Received: by 2002:aa7:939b:0:b029:142:2501:39de with SMTP id t27-20020aa7939b0000b0290142250139demr3643311pfe.45.1601140901310;
        Sat, 26 Sep 2020 10:21:41 -0700 (PDT)
Received: from Mani-XPS-13-9360.localdomain ([2409:4072:20d:ee7b:91b:1587:faf3:6b2b])
        by smtp.gmail.com with ESMTPSA id gm17sm2232663pjb.46.2020.09.26.10.21.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2020 10:21:40 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        linux-arm-msm@vger.kernel.org, jhugo@codeaurora.org,
        linux-kernel@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2] bus: mhi: core: debugfs: Use correct format specifiers for addresses
Date:   Sat, 26 Sep 2020 22:51:29 +0530
Message-Id: <20200926172129.15484-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.17.1
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

Changes in v2:

* Used %pK format specifier to hash addresses by default

Greg: This fixes the issue seen while testing the char-misc/char-misc-testing
branch.

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

