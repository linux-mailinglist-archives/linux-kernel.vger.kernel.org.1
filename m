Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30F43303CFA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 13:28:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404495AbhAZM1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 07:27:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404332AbhAZKwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 05:52:02 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64338C061788
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 02:51:21 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id e15so2336345wme.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jan 2021 02:51:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ldZICOD4+ui/kUfiZ0vMoBvq1PCCAphXE29xFBVIlys=;
        b=G7ICBg/HX4w9a1GqJB27JAqz8cc0X+kgoIkcDQuZenp2gsTZ6mTqoSdCRx2eU+IwKP
         f5wj1S20RZAybyxk4/MFclkHANhWhRWHb/fcC4gAASOO2hG/iGRZh2GMekfcgoHqVe2H
         ZTqQPDHc32sLwRfFBznLHU/4kV7jbB5EXWGbJM/81ppffPe6nEeV9ZCATOM9/BNrjTaO
         stBVUNGL+6fVd5urSrOyGPEIsWOU81GNcrsGKozsA63vc2nkttojVn8rcOJM1SitPMIP
         mu/yrZvXFY0L5bTAml5HRVLfAWeX1zPB0dapun8rAPq3RsVhHhEHXmvzzUH3MmLz/vm/
         t2WA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ldZICOD4+ui/kUfiZ0vMoBvq1PCCAphXE29xFBVIlys=;
        b=N0YHnIeGW8C0DghBAqMSeH9bPeD9DuJjbOVIjHGR92zUUGKcIV2zP2tveVYeyx91By
         d5fQy6eVzk3lufKX4k49tcvzNP0AaBbWffKz2YIFiKbpteRMQMaLNywJ7dxeR30zeVSh
         KdR30s69OibjgdfRQAbpGo6JSHMbCdm/PcbbCpUj/ImgmUnrahkKZSXXl8aIkZ9Dp3Gj
         euoEoCNojsPjyHEFHNbGiTnYB8RI8M4bUawvci3zRJLCntTh9MabVFpdsQsXj6qzCBg4
         4SX3kbflYyKJ5mSQxtcd4fYqSxyxiqHsCH9EJzMsqblr0ZH5WJYpo6KSFlp7UfWABjgH
         Oa8w==
X-Gm-Message-State: AOAM532CCuCs4vtfIBr8cYlxSvSChpNZ7Djyv8SO2bAxM5boJ0LD8x1c
        JKvMhRzOib48J09TaowU8AR3+g==
X-Google-Smtp-Source: ABdhPJwJW9GfocdFPmrjj+lUfufIOZMzP5Wi4MiM4O4hzEq21ri6ywTRe8vvpEuZThiA0f+A54Zg1w==
X-Received: by 2002:a1c:5456:: with SMTP id p22mr4111219wmi.81.1611658280142;
        Tue, 26 Jan 2021 02:51:20 -0800 (PST)
Received: from localhost.localdomain ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id h18sm7177879wru.65.2021.01.26.02.51.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jan 2021 02:51:19 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH BUGFIX/IMPROVEMENT 2/6] block, bfq: put reqs of waker and woken in dispatch list
Date:   Tue, 26 Jan 2021 11:50:58 +0100
Message-Id: <20210126105102.53102-3-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210126105102.53102-1-paolo.valente@linaro.org>
References: <20210126105102.53102-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Consider a new I/O request that arrives for a bfq_queue bfqq. If, when
this happens, the only active bfq_queues are bfqq and either its waker
bfq_queue or one of its woken bfq_queues, then there is no point in
queueing this new I/O request in bfqq for service. In fact, the
in-service queue and bfqq agree on serving this new I/O request as
soon as possible. So this commit puts this new I/O request directly
into the dispatch list.

Tested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index a83149407336..e5b83910fbe0 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5640,7 +5640,22 @@ static void bfq_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 
 	spin_lock_irq(&bfqd->lock);
 	bfqq = bfq_init_rq(rq);
-	if (!bfqq || at_head || blk_rq_is_passthrough(rq)) {
+
+	/*
+	 * Additional case for putting rq directly into the dispatch
+	 * queue: the only active bfq_queues are bfqq and either its
+	 * waker bfq_queue or one of its woken bfq_queues. In this
+	 * case, there is no point in queueing rq in bfqq for
+	 * service. In fact, the in-service queue and bfqq agree on
+	 * serving this new I/O request as soon as possible.
+	 */
+	if (!bfqq ||
+	    (bfqq != bfqd->in_service_queue &&
+	     bfqd->in_service_queue != NULL &&
+	     bfq_tot_busy_queues(bfqd) == 1 + bfq_bfqq_busy(bfqq) &&
+	     (bfqq->waker_bfqq == bfqd->in_service_queue ||
+	      bfqd->in_service_queue->waker_bfqq == bfqq)) ||
+	    at_head || blk_rq_is_passthrough(rq)) {
 		if (at_head)
 			list_add(&rq->queuelist, &bfqd->dispatch);
 		else
-- 
2.20.1

