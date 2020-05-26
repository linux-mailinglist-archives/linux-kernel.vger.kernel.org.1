Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B5ACA19C66F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Apr 2020 17:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389567AbgDBPwK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Apr 2020 11:52:10 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:46277 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389507AbgDBPwG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 11:52:06 -0400
Received: by mail-pg1-f193.google.com with SMTP id k191so2004056pgc.13
        for <linux-kernel@vger.kernel.org>; Thu, 02 Apr 2020 08:52:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=91TGSK7f3sZaNHrNjwv3lknFeXeezpxf66N2To7Vp6E=;
        b=ErbvY8r5SSroUWCgQcdORhlfrOOLrwx14vPvHlg/HqOvXU3jY+UWBJbMt0u3NpWhkg
         ZrrfQ+rYXIpGE2A8SN1byjVo3YEHplZeah09GFCUfFEOGiSR8cp+Xwzkq7CgbLE7VQet
         cYOnWvck9Qo2PnxG8bHN18C87gB0ojosODpbY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=91TGSK7f3sZaNHrNjwv3lknFeXeezpxf66N2To7Vp6E=;
        b=ldcdMvt4NvurAG7ia8Ep/C9jSZqJr9Cvfw8FU7N5SvsVP9lKBivVjIq7jc2JKWZJlF
         6058tL7dHtYtoKajlhyGOdTCsUbaA2/YndIwi7gWVW0+R2Zu6ld2fErC9nwc2EjnL53P
         q/bFcGGc8qVwg6Etfkz2GTM5fa7/g/K8dysPAD7tnRzY1B/jnKnKvJd8vpLul5AAGHOq
         guDEHjSuNeS/p2Sq6t5GWRZQWCcEcXc+zom3EwTThgcrKQDybNiepUl81iuw/3ttv48r
         kZjGzMJQY1ZFP9zCDnusxtEUIpoBRKCHJcyYo6GRZLrsvnhX1xdeGkApyiOI0nWC1Qdc
         +aaw==
X-Gm-Message-State: AGi0PuZsWST9FhHZ8V81xsBdAa6Gx5UkzKG6nvhzYHzl53Dq7xgka6Di
        rvKOprzTocmlSTMlU2tTx/201g==
X-Google-Smtp-Source: APiQypImzOCBUNtsbiPzjiDW9PuoxYILaMINgF1fKvv0r+xRLgvzitqDl42wjh7kUfwQMvp2cwkd2w==
X-Received: by 2002:a63:134e:: with SMTP id 14mr3943484pgt.380.1585842725090;
        Thu, 02 Apr 2020 08:52:05 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id x68sm2578815pfb.5.2020.04.02.08.52.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Apr 2020 08:52:04 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     axboe@kernel.dk, jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     paolo.valente@linaro.org, sqazi@google.com,
        linux-block@vger.kernel.org, linux-scsi@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>, groeck@chromium.org,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] blk-mq: In blk_mq_dispatch_rq_list() "no budget" is a reason to kick
Date:   Thu,  2 Apr 2020 08:51:29 -0700
Message-Id: <20200402085050.v2.1.I1f95c459e51962b8d2c83e869913b6befda2255c@changeid>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
In-Reply-To: <20200402155130.8264-1-dianders@chromium.org>
References: <20200402155130.8264-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In blk_mq_dispatch_rq_list(), if blk_mq_sched_needs_restart() returns
true and the driver returns BLK_STS_RESOURCE then we'll kick the
queue.  However, there's another case where we might need to kick it.
If we were unable to get budget we can be in much the same state as
when the driver returns BLK_STS_RESOURCE, so we should treat it the
same.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v2: None

 block/blk-mq.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index d92088dec6c3..2cd8d2b49ff4 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1189,6 +1189,7 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
 	bool no_tag = false;
 	int errors, queued;
 	blk_status_t ret = BLK_STS_OK;
+	bool no_budget_avail = false;
 
 	if (list_empty(list))
 		return false;
@@ -1205,8 +1206,10 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
 		rq = list_first_entry(list, struct request, queuelist);
 
 		hctx = rq->mq_hctx;
-		if (!got_budget && !blk_mq_get_dispatch_budget(hctx))
+		if (!got_budget && !blk_mq_get_dispatch_budget(hctx)) {
+			no_budget_avail = true;
 			break;
+		}
 
 		if (!blk_mq_get_driver_tag(rq)) {
 			/*
@@ -1311,13 +1314,15 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
 		 *
 		 * If driver returns BLK_STS_RESOURCE and SCHED_RESTART
 		 * bit is set, run queue after a delay to avoid IO stalls
-		 * that could otherwise occur if the queue is idle.
+		 * that could otherwise occur if the queue is idle.  We'll do
+		 * similar if we couldn't get budget and SCHED_RESTART is set.
 		 */
 		needs_restart = blk_mq_sched_needs_restart(hctx);
 		if (!needs_restart ||
 		    (no_tag && list_empty_careful(&hctx->dispatch_wait.entry)))
 			blk_mq_run_hw_queue(hctx, true);
-		else if (needs_restart && (ret == BLK_STS_RESOURCE))
+		else if (needs_restart && (ret == BLK_STS_RESOURCE ||
+					   no_budget_avail))
 			blk_mq_delay_run_hw_queue(hctx, BLK_MQ_RESOURCE_DELAY);
 
 		blk_mq_update_dispatch_busy(hctx, true);
-- 
2.26.0.rc2.310.g2932bb562d-goog

