Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B47C1B4341
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Apr 2020 13:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727870AbgDVL35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Apr 2020 07:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727003AbgDVL3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 07:29:39 -0400
Received: from merlin.infradead.org (unknown [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E84D6C03C1A8
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 04:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-Id:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=3bAokr5NILG1h/Bx/ZUJG/Nj4cpaotPiRJOOn7QkaIs=; b=2+8v67rb7pJohkSqOLleVrtjVa
        rvh/jb2TdTbGdK3M9POBH524IRiVIUlSv3ictUOBSQP+H6qnqrqHD11GPcET3yEHNLDY2VfUvbQeb
        AjhNQpz+T3S3GznmwAbyksiAZ0YyZnzJ9/g+IMJVE1Zz75zmvLMpoHHlxpa8WlKRE36SL/QxNx0Q6
        NgLW7MFT+Uu9y+lp0Pg9FczKYNsRNE7eQYMkLDjRKc0NDFolx/NYi6R4hGA7m9Y4lej6NN/kj4n02
        IlxOr/rrQeDQX2gbwu+uPzgf6FdUJouAqP085k5Cv/T0iGiZNcEXOhQ5dhSkJd3Eqm+As6aSBoPgQ
        scefLT/Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jRDYw-0006ql-Ce; Wed, 22 Apr 2020 11:29:06 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 2F17C30783F;
        Wed, 22 Apr 2020 13:29:03 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id C43D0201946E4; Wed, 22 Apr 2020 13:29:02 +0200 (CEST)
Message-Id: <20200422112831.515522261@infradead.org>
User-Agent: quilt/0.65
Date:   Wed, 22 Apr 2020 13:27:24 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, rostedt@goodmis.org, qais.yousef@arm.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com, mgorman@suse.de,
        peterz@infradead.org, axboe@kernel.dk
Subject: [PATCH 05/23] sched,drbd: Convert to sched_set_fifo*()
References: <20200422112719.826676174@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because SCHED_FIFO is a broken scheduler model (see previous patches)
take away the priority field, the kernel can't possibly make an
informed decision.

In this case, use fifo_low, because it only cares about being above
SCHED_NORMAL. Effectively changes prio from 2 to 1.

Cc: axboe@kernel.dk
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/block/drbd/drbd_receiver.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -6020,9 +6020,8 @@ int drbd_ack_receiver(struct drbd_thread
 	unsigned int header_size = drbd_header_size(connection);
 	int expect   = header_size;
 	bool ping_timeout_active = false;
-	struct sched_param param = { .sched_priority = 2 };
 
-	rv = sched_setscheduler(current, SCHED_RR, &param);
+	rv = sched_set_fifo_low(current);
 	if (rv < 0)
 		drbd_err(connection, "drbd_ack_receiver: ERROR set priority, ret=%d\n", rv);
 


