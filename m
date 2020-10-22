Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C4FC295A8E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 10:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2509374AbgJVIi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 04:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2508182AbgJVIi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 04:38:58 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74D5EC0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 01:38:58 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id 1so588074ple.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Oct 2020 01:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id;
        bh=WRjTSaJ7aRlukBrkL+M/gdXKqvUBRft0vm/xDGjNJRU=;
        b=R6oYUPcjBuASTz2/24ysShG+PREqfrEHx2kkOrsiSsB2c4Hl72f9rRMkwW0/OCL7oL
         vUcf7EWmn76UAHpNtVQDkAAO1KAPJsuRLDkkW+bbeTbAx0Nlh5m5/CZlHe1Lp9+44EaG
         0Diy/i+6xHgJK/78XvZ20MOoXn3uCM5ttumJvqusoqhh4D5PRETOv126c9G2E2XRSZ7S
         6dJ6842Z6eVOpeNkoJn7TzW5JmKJTPz4s1LwkVM8Jl+vQ0RKE1nzLIEYwBGJeArSFYjm
         ZidFXsPwwULRTFVyhQJzS35e74qU1QPgNOtkZ5ERgt6gAwOXAZVCXVno+aVg6rh0cvPD
         YlIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WRjTSaJ7aRlukBrkL+M/gdXKqvUBRft0vm/xDGjNJRU=;
        b=qPqj0d05MftKVZpWxt487K9QhCd3lRExWfPonymhNyXHUPIOhJw6Ll9Ka0PaIO6y4L
         ILjS6usgIIzWMVH3Duujs5qvvxhGB1f5dzzH/i2VRJwPyV1DaY5BviP6HHRi/GxR6TNq
         wXzz/oPqgAuNFcbPeLlTdVAtfD9muXsVcMds3+bt9v5XTQPlv5vcextDhOHCwZuPeBdB
         DQ0BxuHxDD5xtp5y5shv6W+tVpJX2qIcaRPl+6GpSjhhibr+WoLDYEt+4YkGJoKQQ7zE
         hRQlapFzNcF+1EmR9dy0iptXZfNcf0pJ0Wjp3pqYAbbpaLfvqAGINitzudQr4IUrR9UX
         b7Dw==
X-Gm-Message-State: AOAM531jYxerKCAI9hy0NK9qyVvLvPntvh30r76A6AO4ihf8mAjAQtZM
        EjDdCOal/+SG5JqheESTsHAdwg==
X-Google-Smtp-Source: ABdhPJym+5wrTVQPViwggX5vf9tIWTbsFDSKvohjwsGtuvWbA/bPDX3JjQgol2fAv6lpf1QnNPo/hg==
X-Received: by 2002:a17:902:8c88:b029:d5:ffe1:6653 with SMTP id t8-20020a1709028c88b02900d5ffe16653mr1556061plo.22.1603355938037;
        Thu, 22 Oct 2020 01:38:58 -0700 (PDT)
Received: from libai.bytedance.net ([61.120.150.71])
        by smtp.gmail.com with ESMTPSA id v7sm1436396pfi.0.2020.10.22.01.38.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Oct 2020 01:38:57 -0700 (PDT)
From:   zhenwei pi <pizhenwei@bytedance.com>
To:     kbusch@kernel.org, hch@lst.de, sagi@grimberg.me, axboe@fb.com
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        pizhenwei@bytedance.com
Subject: [PATCH] nvme-rdma: handle nvme completion data length
Date:   Thu, 22 Oct 2020 16:38:50 +0800
Message-Id: <20201022083850.1334880-1-pizhenwei@bytedance.com>
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

Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
---
 drivers/nvme/host/rdma.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 9e378d0a0c01..9f5112040d43 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1767,6 +1767,17 @@ static void nvme_rdma_recv_done(struct ib_cq *cq, struct ib_wc *wc)
 		return;
 	}
 
+	if (unlikely(!wc->byte_len)) {
+		/* zero bytes message could be ignored */
+		return;
+	} else if (unlikely(wc->byte_len < len)) {
+		/* Corrupted completion, try to recovry */
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

