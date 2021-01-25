Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0471C3039E0
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 11:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403820AbhAZKJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 05:09:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731286AbhAYTD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 14:03:59 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63E0C0613D6
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 11:03:17 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id b5so14076255wrr.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 11:03:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9YzGYM8jUXZx1tyLF6Ot8at1yHr+fDjnAOr+cHSlKDo=;
        b=eKB/v1ZKYxKzCyfUQ3RlHEbASNKmHj/1ABogRXpO8XGKL7h6fVjTkJLMCrk+8Zv/1h
         6eu1Vr68gXKGnjoaQfE2wGqpS2x6oGkoEBLpsvv8u65yqJ0vMIBk/b/saUKPxIeHdlXo
         kJs/jbX5n88ivf/e2JmAJB0GsuOlM18Htul9WHQDSPLTzNz6aJr9dvDlQ3ZVDBq8FOnX
         czXD/VVqqXQs5QiOXYKCwyMCOiwgYay2ahkX7aUhlZpbs2+vpBA4b4zKyrqs9t3Xx301
         JsL0MHYmbNzLDGaTpHNXSHi8p9tjOEFxsKpvqthRk6kaFT3Ko2E2itMlpTQ6BR93q9Tm
         HR5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9YzGYM8jUXZx1tyLF6Ot8at1yHr+fDjnAOr+cHSlKDo=;
        b=VmLimAR77df70jpyxnMn3CuVEwc825oxXgt2OgBD3ofBZnQvmLcTxb6bdIi7Vkh97E
         TFvQ5Ss4ldX9k35VdlddW3YbBC+zthMIfsDfwQUYWT+cA7MOzvDE4fqjJgeZgX98g1uG
         iMCHXIBRiwRN+l5izyLTIpcb8hg1AGaW91PnXPdf3th6UFymT4CEnMR1VtLhocjFqoq3
         ojRtQ9cMcZpGr1XHrZy/ODmw/PvEoSpFmvASR1UN4dcyz51vE9CePJUr0OBHQ7WUP38y
         TBsjJQAsNnIFWUPUM3tT1WFQEA12P3K4sP73y3k1Yb+8ItDsv9g2852apiXOD7Pj7fl+
         +YWw==
X-Gm-Message-State: AOAM530DPqnm7P8WnpfhzW0GDqzBhnI0pJH7XuaRR5FCJdFYeb4H9KgE
        6yBwhVkYEP7J/nJ5YHZlKoe7ZA==
X-Google-Smtp-Source: ABdhPJzrKET5xztkr2KE3VrQH01OZZtc811nnF8Yy2xPDMMGnJnt/o4zYl+o47XMQccmdAoHDzHLdg==
X-Received: by 2002:adf:f743:: with SMTP id z3mr2543929wrp.165.1611601396486;
        Mon, 25 Jan 2021 11:03:16 -0800 (PST)
Received: from localhost.localdomain ([37.160.159.175])
        by smtp.gmail.com with ESMTPSA id g194sm222534wme.39.2021.01.25.11.03.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jan 2021 11:03:15 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH BUGFIX/IMPROVEMENT 2/6] block, bfq: re-evaluate convenience of I/O plugging on rq arrivals
Date:   Mon, 25 Jan 2021 20:02:44 +0100
Message-Id: <20210125190248.49338-3-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210125190248.49338-1-paolo.valente@linaro.org>
References: <20210125190248.49338-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Upon an I/O-dispatch attempt, BFQ may detect that it was better to
plug I/O dispatch, and to wait for a new request to arrive for the
currently in-service queue. But the arrival of a new request for an
empty bfq_queue, and thus the switch from idle to busy of the
bfq_queue, may cause the scenario to change, and make plugging no
longer needed for service guarantees, or more convenient for
throughput. In this case, keeping I/O-dispatch plugged would certainly
lower throughput.

To address this issue, this commit makes such a check, and stops
plugging I/O if it is better to stop plugging I/O.

Tested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 24 +++++++++++++++++++-----
 1 file changed, 19 insertions(+), 5 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index db393f5d70ba..6a02a12ff553 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -1649,6 +1649,8 @@ static bool bfq_bfqq_higher_class_or_weight(struct bfq_queue *bfqq,
 	return bfqq_weight > in_serv_weight;
 }
 
+static bool bfq_better_to_idle(struct bfq_queue *bfqq);
+
 static void bfq_bfqq_handle_idle_busy_switch(struct bfq_data *bfqd,
 					     struct bfq_queue *bfqq,
 					     int old_wr_coeff,
@@ -1750,10 +1752,10 @@ static void bfq_bfqq_handle_idle_busy_switch(struct bfq_data *bfqd,
 	bfq_add_bfqq_busy(bfqd, bfqq);
 
 	/*
-	 * Expire in-service queue only if preemption may be needed
-	 * for guarantees. In particular, we care only about two
-	 * cases. The first is that bfqq has to recover a service
-	 * hole, as explained in the comments on
+	 * Expire in-service queue if preemption may be needed for
+	 * guarantees or throughput. As for guarantees, we care
+	 * explicitly about two cases. The first is that bfqq has to
+	 * recover a service hole, as explained in the comments on
 	 * bfq_bfqq_update_budg_for_activation(), i.e., that
 	 * bfqq_wants_to_preempt is true. However, if bfqq does not
 	 * carry time-critical I/O, then bfqq's bandwidth is less
@@ -1780,11 +1782,23 @@ static void bfq_bfqq_handle_idle_busy_switch(struct bfq_data *bfqd,
 	 * timestamps of the in-service queue would need to be
 	 * updated, and this operation is quite costly (see the
 	 * comments on bfq_bfqq_update_budg_for_activation()).
+	 *
+	 * As for throughput, we ask bfq_better_to_idle() whether we
+	 * still need to plug I/O dispatching. If bfq_better_to_idle()
+	 * says no, then plugging is not needed any longer, either to
+	 * boost throughput or to perserve service guarantees. Then
+	 * the best option is to stop plugging I/O, as not doing so
+	 * would certainly lower throughput. We may end up in this
+	 * case if: (1) upon a dispatch attempt, we detected that it
+	 * was better to plug I/O dispatch, and to wait for a new
+	 * request to arrive for the currently in-service queue, but
+	 * (2) this switch of bfqq to busy changes the scenario.
 	 */
 	if (bfqd->in_service_queue &&
 	    ((bfqq_wants_to_preempt &&
 	      bfqq->wr_coeff >= bfqd->in_service_queue->wr_coeff) ||
-	     bfq_bfqq_higher_class_or_weight(bfqq, bfqd->in_service_queue)) &&
+	     bfq_bfqq_higher_class_or_weight(bfqq, bfqd->in_service_queue) ||
+	     !bfq_better_to_idle(bfqd->in_service_queue)) &&
 	    next_queue_may_preempt(bfqd))
 		bfq_bfqq_expire(bfqd, bfqd->in_service_queue,
 				false, BFQQE_PREEMPTED);
-- 
2.20.1

