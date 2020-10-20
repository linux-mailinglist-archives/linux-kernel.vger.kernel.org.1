Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 630BC2856F5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 05:17:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727287AbgJGDRG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 23:17:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbgJGDRD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 23:17:03 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 139C2C0613D2
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 20:17:02 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id o9so276342plx.10
        for <linux-kernel@vger.kernel.org>; Tue, 06 Oct 2020 20:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IeHm/TqHuwhnyA0b8jgMCPZcrzDYgMpNDupCMS7Ulu4=;
        b=OXhsLhZANeWmSx3hdFzd3o12iVc4LODgV8gXnAsZsGXkYEngD1RXAFBGyzKOo7d6CM
         k9FbCBgD/PuBchdnvqx5zjGUBgGD/VyIwWxfbnMCmUR7oHJvKn9VdwQkPbuaKLBWp8zq
         BUeqiM/eu6HBB4gkMpypoXTIAoQeUw5oUyQ44PGZrrfsCB+hUVFwBv5BCKuU278t5lsS
         ze/kVpC5m14/YNI+78t0kgyGvNASPOkGEb+PMYbvcBPJMyHEcFIcoDOrgx1jOZb8ooWZ
         nll6wLvNPh8bwBnzLcXYNuiPGQje1G6dZBaYHOcoQto0W4Epx2+Ur3Ukka5eu8PN8PdJ
         E7cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IeHm/TqHuwhnyA0b8jgMCPZcrzDYgMpNDupCMS7Ulu4=;
        b=M8bNpzq84169fqi6NrB5W0psqlARbtocytAsEurJPngXorT3UgQhXZRA5ta/6b/KIQ
         g+H/bspzs3RdMyohkj4vui0XLnGSL5U9SEFvByqCTThhv9KvTCbENjXW1IxNVCwKln4O
         wUu+EEh+St5UQLQvU7xcJsjtMf6IpoAnM7oQRbCs/uheRzcEtTd5sCnFAsjwmzPEqqWM
         I8pqf/VGUhnIHoyPa72I3rr6W6ortmYoGhha5Fx4E1tKcXAKU90KK3r3hxUKlAJYCRMK
         HGqdZMv3tHkSeuxeL615vKCo3MznP2xxVztQuFowKt86bDXCeZHb1/v6+Bt24QKyb4xs
         HsNA==
X-Gm-Message-State: AOAM531bsM4mTD4PBKk3+V5fHzFca4gv7740Kp3TS1QKFYewyNtExP1X
        QkdMWGGY4QmHTQFoo+bBKAiInA==
X-Google-Smtp-Source: ABdhPJxqB7qnbj5NCKL+OPKSzMbBMdXutgjfSrgRUieSvOOoBBQFsAv50cao3PjdgcSTlq5nNPZJ8g==
X-Received: by 2002:a17:902:7882:b029:d3:b3bc:9d8a with SMTP id q2-20020a1709027882b02900d3b3bc9d8amr975601pll.46.1602040621656;
        Tue, 06 Oct 2020 20:17:01 -0700 (PDT)
Received: from localhost.localdomain ([103.136.221.72])
        by smtp.gmail.com with ESMTPSA id e1sm729094pfd.198.2020.10.06.20.16.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Oct 2020 20:17:01 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhuyinyin@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v3 2/4] io_uring: Fix missing smp_mb() in io_cancel_async_work()
Date:   Wed,  7 Oct 2020 11:16:33 +0800
Message-Id: <20201007031635.65295-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20201007031635.65295-1-songmuchun@bytedance.com>
References: <20201007031635.65295-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The store to req->flags and load req->work_task should not be
reordering in io_cancel_async_work(). We should make sure that
either we store REQ_F_CANCE flag to req->flags or we see the
req->work_task setted in io_sq_wq_submit_work().

Fixes: 1c4404efcf2c ("io_uring: make sure async workqueue is canceled on exit")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 fs/io_uring.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 2f46def7f5832..5d9583e3d0d25 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2252,6 +2252,12 @@ static void io_sq_wq_submit_work(struct work_struct *work)
 
 		if (!ret) {
 			req->work_task = current;
+
+			/*
+			 * Pairs with the smp_store_mb() (B) in
+			 * io_cancel_async_work().
+			 */
+			smp_mb(); /* A */
 			if (req->flags & REQ_F_CANCEL) {
 				ret = -ECANCELED;
 				goto end_req;
@@ -3730,7 +3736,15 @@ static void io_cancel_async_work(struct io_ring_ctx *ctx,
 
 		req = list_first_entry(&ctx->task_list, struct io_kiocb, task_list);
 		list_del_init(&req->task_list);
-		req->flags |= REQ_F_CANCEL;
+
+		/*
+		 * The below executes an smp_mb(), which matches with the
+		 * smp_mb() (A) in io_sq_wq_submit_work() such that either
+		 * we store REQ_F_CANCEL flag to req->flags or we see the
+		 * req->work_task setted in io_sq_wq_submit_work().
+		 */
+		smp_store_mb(req->flags, req->flags | REQ_F_CANCEL); /* B */
+
 		if (req->work_task && (!files || req->files == files))
 			send_sig(SIGINT, req->work_task, 1);
 	}
-- 
2.11.0

