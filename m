Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEDBB275757
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 13:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726645AbgIWLpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 07:45:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726661AbgIWLo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 07:44:57 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F17F1C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 04:44:56 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id y6so6692485plt.9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 04:44:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+WN/2aVaL/WoH1KRLeXq71c9eCEQAH6H70sGmLsN6lU=;
        b=01ysSC8hFBY3eDCc/RpgxJQX9B/h7CFkxAz+3QPQEB4/2blFaWo2etOmLBAfgEwCLF
         htkynXCLOqwtDLHb2P3xVS18HiakMBmVeSRYcvK483uOAbvMjgMV6ab1RH2p2VenTUAE
         D1J+/xyjSO+CWX+W5w1pdGifoy4pgPF0pA1vk9YXf2q72kxNKoPCH1vDImG7PBQrUC7x
         z7SmInT0MpIX9IQXDKiIeHRxD9Sg6pBo5W/eIil3EFGoS8QltH3XIJNTHoT7/n55nTce
         7pFHLCULrR+wMCma+pUNV2X+ZtwQ56keEc+2DBmf/BiAIpgh5vmrlvniWAzxnFBPmzog
         iSHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+WN/2aVaL/WoH1KRLeXq71c9eCEQAH6H70sGmLsN6lU=;
        b=pOCT5ONNkqWqVjEYFZPW5gi3JBE2++jdlznCIFWekLRbtskm3ktqT/mBzNy1bZkle+
         9LuLxUAVjXvwsN/LIKiouE1KUuGdhCdTJhRbKF+lswRg8wENCzSUD/kpvEyCECh9SALG
         7KqJX+zpA5qwDCQF2rsl2/FD3bQ4Er1GilY+Fdqn6G6j7yymMnpsNDCOP+pakUZZNh20
         WVd9AUl49IG8TYmu/SZYnrC1+EhdcUoNYHZuI27g3vHg6yCSF7rquCN5ogmmdRQgRofo
         OL1KqjaQFK+ObbBPYWfZ5MVm/4Ele5iAFT8CuOxM8rqhiAZqcdCqMgPahseTWdHxVS/0
         RoPg==
X-Gm-Message-State: AOAM530GkaS17LWPdAdS3iRv9/yWcepPUhxQHbrX4vIyfw+ovIXVAU4K
        3tS24hi3BCz6kBeyKcJU76kUZg==
X-Google-Smtp-Source: ABdhPJwdxYXVAqCqvVIAa3BXdJbmtpQ0JBjfJ1hB7+Gji0Vv4dxpIc7rUeJaGhMul6qvv9McfULcPg==
X-Received: by 2002:a17:90a:d304:: with SMTP id p4mr8215672pju.138.1600861496349;
        Wed, 23 Sep 2020 04:44:56 -0700 (PDT)
Received: from Smcdef-MBP.local.net ([103.136.220.72])
        by smtp.gmail.com with ESMTPSA id a13sm17632155pfl.184.2020.09.23.04.44.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Sep 2020 04:44:55 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhuyinyin@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 4/5] io_uring: Fix missing save the current thread files
Date:   Wed, 23 Sep 2020 19:44:18 +0800
Message-Id: <20200923114419.71218-5-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20200923114419.71218-1-songmuchun@bytedance.com>
References: <20200923114419.71218-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We forget to save the current thread files, in this case, we can not
send SIGINT signal to the kworker because the files is not equal.

Fixes: 54ee77961e79 ("io_uring: Fix NULL pointer dereference in io_sq_wq_submit_work()")
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
---
 fs/io_uring.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 12e68ea00a543..c65f78f395655 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2391,6 +2391,8 @@ static bool io_add_to_prev_work(struct async_list *list, struct io_kiocb *req)
 	if (ret) {
 		struct io_ring_ctx *ctx = req->ctx;
 
+		req->files = current->files;
+
 		spin_lock_irq(&ctx->task_lock);
 		list_add(&req->task_list, &ctx->task_list);
 		req->work_task = NULL;
-- 
2.11.0

