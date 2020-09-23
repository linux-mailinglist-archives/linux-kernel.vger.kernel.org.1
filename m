Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7388A275750
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Sep 2020 13:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726652AbgIWLox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Sep 2020 07:44:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbgIWLou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Sep 2020 07:44:50 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7B1C0613CE
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 04:44:49 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id d9so14881853pfd.3
        for <linux-kernel@vger.kernel.org>; Wed, 23 Sep 2020 04:44:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fGilIYrCbh50kTGRwzjJvVfohhOd0dHq1F9Kut44y9I=;
        b=bMOj5TthhClhPZZn3/SIzkBPxHYOZH75lTH2CcXUdw8UR/J+FzMyQ/KBz7hKRaA18E
         ZlSjrcfBhq5erVyx0j6CD66VdAJrqX0HfmM/0D3rabD6dkiKizTu6ztq1OKYtWN+y/75
         hQj5pqVDvtbI5d65Og1ytt+GcllEe4wiB2FwEeV7M4suASAr+87Mnpsg8jCUvIhHLba/
         2rB2qF1Ho22sboU++zkzxz4bDO7QX1CKYUDkQ7WSU+5By9kHHdnQOGTW9zbUZWHsyNT1
         2xPMaiq9HaTEvNN1xERZNOYTOplzVwhhoOw9R1DTo/979p3PKQjEeRPE5rznAiGDmRLW
         jO8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fGilIYrCbh50kTGRwzjJvVfohhOd0dHq1F9Kut44y9I=;
        b=NU5bUrgjo9g8dpw9EaslD+UGMR2yQVyQePkkMMnIG3lO4zN76mfg7BiPhNz3T9goI7
         xVVB3B5qYRqiCtky0nXUUUXd/U4ud6h4rX/VpjK00zF6Y/J+BSWr7AA2iLoHsqNikT8C
         ycnnRGp0Io4KEe3gXTS6V6lrJT2mBqX4nP2Phh0Dg2+T2TskZArHhnWVmjwffHZTMRmO
         CQXs+J1SlbwjzUCbq66lLWEOE6U2NDrBMovarcSwZ48FDEfoUJOeL7GSznJVnuhzXpN9
         M9JkUfqmJ0UMufcmNIJ0b43fjIJslArgUki0SnMkz9CVxvyj1d1OmlHBPP9gqrpcNOTv
         iaXA==
X-Gm-Message-State: AOAM530XgRAJgO9+QSghodsMnAoAk3OTongEeFPFiQS0aONlb85nQDgC
        OrvHoky547VziZwHY1DqUZdLLQ==
X-Google-Smtp-Source: ABdhPJwPQPmp9mJ3CwnGnJmncLyVBkzdNV9o4SqscJ/GohWXP7zYQ0odT2RerJw29I0rw87VsNdsHw==
X-Received: by 2002:a63:4d02:: with SMTP id a2mr7108482pgb.38.1600861489363;
        Wed, 23 Sep 2020 04:44:49 -0700 (PDT)
Received: from Smcdef-MBP.local.net ([103.136.220.72])
        by smtp.gmail.com with ESMTPSA id a13sm17632155pfl.184.2020.09.23.04.44.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Sep 2020 04:44:48 -0700 (PDT)
From:   Muchun Song <songmuchun@bytedance.com>
To:     axboe@kernel.dk, viro@zeniv.linux.org.uk
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, zhuyinyin@bytedance.com,
        Muchun Song <songmuchun@bytedance.com>
Subject: [PATCH v2 2/5] io_uring: Fix missing smp_mb() in io_cancel_async_work()
Date:   Wed, 23 Sep 2020 19:44:16 +0800
Message-Id: <20200923114419.71218-3-songmuchun@bytedance.com>
X-Mailer: git-send-email 2.21.0 (Apple Git-122)
In-Reply-To: <20200923114419.71218-1-songmuchun@bytedance.com>
References: <20200923114419.71218-1-songmuchun@bytedance.com>
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
index a1350c7c50055..c80c37ef38513 100644
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
@@ -3728,7 +3734,15 @@ static void io_cancel_async_work(struct io_ring_ctx *ctx,
 
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

