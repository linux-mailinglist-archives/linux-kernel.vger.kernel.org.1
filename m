Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87843296A03
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 09:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S375506AbgJWHAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 03:00:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S373732AbgJWHAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 03:00:34 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05526C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 00:00:33 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id y1so366153plp.6
        for <linux-kernel@vger.kernel.org>; Fri, 23 Oct 2020 00:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=gVvp5GTF6tEYF1l4MyLe+EEACPzCJh/rTLhZ25K7Yus=;
        b=KWPJbAFMvmpj3OAzC7C9dIn2g7wa3y2PZbYxCq7caZotONOVMgoXy8ZqkhAHrJUTSJ
         ds68D0aFcyb8vTkMBMfaRF5rduNxICRu4bABQKpWk5TRzbPUcaLMnPeXNn6J9WUdmge/
         Zwg+e50jvhe0RtX4j6BcUzxnTK2SUU+zIsF7psfkuC0aqOAJRCKlz1tY88KbKg3oWDoZ
         ZxoDyY3j8K7k5TZXwMRDcUZviq6w2gV4rDjvhK1PLEdnrcq2A95liY19s/dcTuW8Igcm
         9i8FpsMUPQBkQkPH+IRowt6GVsQSiEIqWPp6ZKYPmxkX8+buhBqcj85d6XINiIjUl+wk
         TjYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=gVvp5GTF6tEYF1l4MyLe+EEACPzCJh/rTLhZ25K7Yus=;
        b=cjtyTviswMkO1OxR0F1bUG1ywZJEH1mE9nf+vOH5/uOUszwfkeEZhPWlQ5i0LVAS4n
         J4/NirRgGeEPUpGzQdZ3QIxz3XleZyMwLBX2v2e4twib4rPY+lUTUZgZhykQFtnbows8
         gSBNTC5MdAmaFQbrDyibBgkCfINe7WeYGYECR67S8W/rM54PbMHvxW352O+TJ018MP50
         S9UbL+XLgvmL87wZc2IKTHmhr2UDELNEe/s2VSMndgYS7hLPqHhV81w+FjHxn3w1gm8m
         oz2qrI+i1Gpbzrs07mUw0iIwzOw2HDFoBL57UEwth8Jt6PtK59+jfYbvPHx8OqdeR6MC
         YHtQ==
X-Gm-Message-State: AOAM533dbrXQvCcTymjfHMYKMmkdw2aGP94c5GXWwEdDs4iyjiwTZycd
        AB121xTGpRX6Luxg6qQzXFvusg==
X-Google-Smtp-Source: ABdhPJyM1RekPYb05cSt8HvXzUhVRJa3OqIUptCqYP36bORzn5wOfny7OcuR9gEWaEs3/69n6p/s/w==
X-Received: by 2002:a17:902:b70a:b029:d2:6391:a80f with SMTP id d10-20020a170902b70ab02900d26391a80fmr1186265pls.0.1603436432573;
        Fri, 23 Oct 2020 00:00:32 -0700 (PDT)
Received: from libai.bytedance.net ([61.120.150.71])
        by smtp.gmail.com with ESMTPSA id h4sm795139pgc.13.2020.10.23.00.00.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Oct 2020 00:00:31 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@fb.com
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        pizhenwei@bytedance.com
Subject: [PATCH v2] nvme-rdma: handle nvme completion data length
Date:   Fri, 23 Oct 2020 14:59:10 +0800
Message-Id: <20201023065910.1358586-1-pizhenwei@bytedance.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hit a kernel warning:
refcount_t: underflow; use-after-free.
WARNING: CPU: 0 PID: 0 at lib/refcount.c:28

RIP: 0010:refcount_warn_saturate+0xd9/0xe0
Call Trace:
 <IRQ>
 nvme_rdma_recv_done+0xf3/0x280 [nvme_rdma]
 __ib_process_cq+0x76/0x150 [ib_core]
 ...

The reason is that a zero bytes message received from target, and the
host side continues to process without length checking, then the
previous CQE is processed twice.

Handle data length, ignore zero bytes message, and try to recovery for
corrupted CQE case.

Thanks to Chao Leng for suggestions.

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/nvme/host/rdma.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 9e378d0a0c01..2ecadd309f4a 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1767,6 +1767,21 @@ static void nvme_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc)
 		return;
 	}
 
+	/* received data length checking */
+	if (unlikely(wc->byte_len < len)) {
+		/* zero bytes message could be ignored */
+		if (!wc->byte_len) {
+			nvme_rdma_post_recv(queue, qe);
+			return;
+		}
+
+		/* corrupted completion, try to recovry */
+		dev_err(queue->ctrl->ctrl.device,
+			"Unexpected nvme completion length(%d)\n", wc->byte_len);
+		nvme_rdma_error_recovery(queue->ctrl);
+		return;
+	}
+
 	ib_dma_sync_single_for_cpu(ibdev, qe->dma, len, DMA_FROM_DEVICE);
 	/*
 	 * AEN requests are special as they don't time out and can
-- 
2.11.0

