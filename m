Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80C85303BD8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 12:41:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405337AbhAZLkk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 06:40:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404448AbhAZKwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 05:52:00 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFD97C0613ED
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 02:51:19 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id a9so15933546wrt.5
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 02:51:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kPe9/bC+fapDM9TyJPKrxL534jOiWcGHIwwJRVky7EU=;
        b=OqVjkA2ciaTvaPcheuyRt1SetUn8Cn9eiDfOks1lNQ0KhavOCQ5vHCAbaHip0qlUV9
         C0MnMHOVDo5egF9h14gwy6ggaES2ZqNF/fjajaERGJDfFZFJe0MBxCYnsF4DAPN/tJJO
         fECQBlcPUz/1nq05YendvbJoMIDJLveSjIsh9vlXZSzUhpNXEeEVP38GiPIze65MEXER
         iF4dypnmf8rRmuGKYVmhtEA8y6oDfcm9IaVyldRYXqIVgAULa9jkNkuxfhvkEmPdHwEj
         c1vbc81yOwT1V7Ffg0qAHofokiUgxgQhZ68UmaSEFkj7i27dZq7IQiWsx1FBg7h9ydez
         G5Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kPe9/bC+fapDM9TyJPKrxL534jOiWcGHIwwJRVky7EU=;
        b=ColKEwOmQ9u8+ae9EUM9TbHleZz9zShzLivQf6xyJLTeJZUbsGKgeyEcfiyFpPxe8j
         TQgHFxEvBxlqOjup3Yawctn6+JKqgLnIm9iQAFvk2aks7i6XzVlpUwOZ2iODWMkzuDVO
         Uoe7xRYSieuvzwRtDx4IwgSQdkmDR+WvK9gm6Il/wtg/cuMayubEXu3Q2N7icXwiRFvD
         dZ3+nj80vk5eTP54/bXH0uLVN45HGf9ot136NP1mCI7YoDQjJnNeKvs6hIyuYuNjtP13
         FSIPLq6k4EEQd5KDjuPVpR1JPGPLwTDhHdMTcXUaOnoZCEfWeiskKC4ceUzsfEFGrYHE
         A+ug==
X-Gm-Message-State: AOAM5309loA5dLD+H5ad1OpfypyauYmwv/gXlKEO+RCSVDjo8yETsX8B
        mJ/SoOXK4rLhhh+Xxqx66x/WwA==
X-Google-Smtp-Source: ABdhPJwTmI9AK+E7QAqlT2/FajyUAKTEwOhi4zQFqWexzunKCays3a2knrkCYOYxMAweTUNfyRPD/Q==
X-Received: by 2002:adf:fe46:: with SMTP id m6mr5420092wrs.48.1611658278637;
        Tue, 26 Jan 2021 02:51:18 -0800 (PST)
Received: from localhost.localdomain ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id h18sm7177879wru.65.2021.01.26.02.51.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jan 2021 02:51:18 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH BUGFIX/IMPROVEMENT 1/6] block, bfq: always inject I/O of queues blocked by wakers
Date:   Tue, 26 Jan 2021 11:50:57 +0100
Message-Id: <20210126105102.53102-2-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210126105102.53102-1-paolo.valente@linaro.org>
References: <20210126105102.53102-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Suppose that I/O dispatch is plugged, to wait for new I/O for the
in-service bfq-queue, say bfqq.  Suppose then that there is a further
bfq_queue woken by bfqq, and that this woken queue has pending I/O. A
woken queue does not steal bandwidth from bfqq, because it remains
soon without I/O if bfqq is not served. So there is virtually no risk
of loss of bandwidth for bfqq if this woken queue has I/O dispatched
while bfqq is waiting for new I/O. In contrast, this extra I/O
injection boosts throughput. This commit performs this extra
injection.

Tested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 32 +++++++++++++++++++++++++++-----
 block/bfq-wf2q.c    |  8 ++++++++
 2 files changed, 35 insertions(+), 5 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 445cef9c0bb9..a83149407336 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -4487,9 +4487,15 @@ static struct bfq_queue *bfq_select_queue(struct bfq_data *bfqd)
 			bfq_bfqq_busy(bfqq->bic->bfqq[0]) &&
 			bfqq->bic->bfqq[0]->next_rq ?
 			bfqq->bic->bfqq[0] : NULL;
+		struct bfq_queue *blocked_bfqq =
+			!hlist_empty(&bfqq->woken_list) ?
+			container_of(bfqq->woken_list.first,
+				     struct bfq_queue,
+				     woken_list_node)
+			: NULL;
 
 		/*
-		 * The next three mutually-exclusive ifs decide
+		 * The next four mutually-exclusive ifs decide
 		 * whether to try injection, and choose the queue to
 		 * pick an I/O request from.
 		 *
@@ -4522,7 +4528,15 @@ static struct bfq_queue *bfq_select_queue(struct bfq_data *bfqd)
 		 * next bfqq's I/O is brought forward dramatically,
 		 * for it is not blocked for milliseconds.
 		 *
-		 * The third if checks whether bfqq is a queue for
+		 * The third if checks whether there is a queue woken
+		 * by bfqq, and currently with pending I/O. Such a
+		 * woken queue does not steal bandwidth from bfqq,
+		 * because it remains soon without I/O if bfqq is not
+		 * served. So there is virtually no risk of loss of
+		 * bandwidth for bfqq if this woken queue has I/O
+		 * dispatched while bfqq is waiting for new I/O.
+		 *
+		 * The fourth if checks whether bfqq is a queue for
 		 * which it is better to avoid injection. It is so if
 		 * bfqq delivers more throughput when served without
 		 * any further I/O from other queues in the middle, or
@@ -4542,11 +4556,11 @@ static struct bfq_queue *bfq_select_queue(struct bfq_data *bfqd)
 		 * bfq_update_has_short_ttime(), it is rather likely
 		 * that, if I/O is being plugged for bfqq and the
 		 * waker queue has pending I/O requests that are
-		 * blocking bfqq's I/O, then the third alternative
+		 * blocking bfqq's I/O, then the fourth alternative
 		 * above lets the waker queue get served before the
 		 * I/O-plugging timeout fires. So one may deem the
 		 * second alternative superfluous. It is not, because
-		 * the third alternative may be way less effective in
+		 * the fourth alternative may be way less effective in
 		 * case of a synchronization. For two main
 		 * reasons. First, throughput may be low because the
 		 * inject limit may be too low to guarantee the same
@@ -4555,7 +4569,7 @@ static struct bfq_queue *bfq_select_queue(struct bfq_data *bfqd)
 		 * guarantees (the second alternative unconditionally
 		 * injects a pending I/O request of the waker queue
 		 * for each bfq_dispatch_request()). Second, with the
-		 * third alternative, the duration of the plugging,
+		 * fourth alternative, the duration of the plugging,
 		 * i.e., the time before bfqq finally receives new I/O,
 		 * may not be minimized, because the waker queue may
 		 * happen to be served only after other queues.
@@ -4573,6 +4587,14 @@ static struct bfq_queue *bfq_select_queue(struct bfq_data *bfqd)
 			   bfq_bfqq_budget_left(bfqq->waker_bfqq)
 			)
 			bfqq = bfqq->waker_bfqq;
+		else if (blocked_bfqq &&
+			   bfq_bfqq_busy(blocked_bfqq) &&
+			   blocked_bfqq->next_rq &&
+			   bfq_serv_to_charge(blocked_bfqq->next_rq,
+					      blocked_bfqq) <=
+			   bfq_bfqq_budget_left(blocked_bfqq)
+			)
+			bfqq = blocked_bfqq;
 		else if (!idling_boosts_thr_without_issues(bfqd, bfqq) &&
 			 (bfqq->wr_coeff == 1 || bfqd->wr_busy_queues > 1 ||
 			  !bfq_bfqq_has_short_ttime(bfqq)))
diff --git a/block/bfq-wf2q.c b/block/bfq-wf2q.c
index 26776bdbdf36..02e59931d897 100644
--- a/block/bfq-wf2q.c
+++ b/block/bfq-wf2q.c
@@ -1709,4 +1709,12 @@ void bfq_add_bfqq_busy(struct bfq_data *bfqd, struct bfq_queue *bfqq)
 
 	if (bfqq->wr_coeff > 1)
 		bfqd->wr_busy_queues++;
+
+	/* Move bfqq to the head of the woken list of its waker */
+	if (!hlist_unhashed(&bfqq->woken_list_node) &&
+	    &bfqq->woken_list_node != bfqq->waker_bfqq->woken_list.first) {
+		hlist_del_init(&bfqq->woken_list_node);
+		hlist_add_head(&bfqq->woken_list_node,
+			       &bfqq->waker_bfqq->woken_list);
+	}
 }
-- 
2.20.1

