Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91ED02DF855
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 05:42:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727903AbgLUElq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Dec 2020 23:41:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725785AbgLUElq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Dec 2020 23:41:46 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC449C0613D3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Dec 2020 20:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=RgtfVilODBWu/BQGzDM3OF/pOjyop/4FNc+1HpoSaF8=; b=F6PPr2nv6gr1/uwR4YCyQhnsmF
        aqkEPMV5llTocBl8TXqWqqc5h5ckQ4Nt1w784qEGweVp83sQbD907W+7sKO51Ed/0Cvky/f/Uj2/e
        BtcwHgva4Kc4tDveN/2nFoWvoTHhwnBX7f8mWYOMOeXpoecHmNrvZJK1ZdmihlHJ8cTc8jQwPphKw
        7bureBUq7k5oQWRNI39bSf9ZYxPCAM1We2D683yMekgp/8FGmC1H79fKu43Sd9Bkk+AVO1VUYI++0
        lOFS9ozQwMZy2zVqCkZKCGOqnICKXQPLCYGBEcv81sNjmFnBwxMenAPsqiSvLrBAK3IoUwOMKQOcs
        YBW7T10g==;
Received: from [2601:1c0:6280:3f0::64ea] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1krD0I-00036Z-M4; Mon, 21 Dec 2020 04:41:03 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: [PATCH v2] kernel: sched: delete repeated words in comments
Date:   Sun, 20 Dec 2020 20:40:58 -0800
Message-Id: <20201221044058.15301-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop repeated words in kernel/sched/.
{in, not}

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
---
v2: rebase, resend

 kernel/sched/fair.c       |    2 +-
 kernel/sched/membarrier.c |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20201218.orig/kernel/sched/fair.c
+++ linux-next-20201218/kernel/sched/fair.c
@@ -5133,7 +5133,7 @@ static void do_sched_cfs_slack_timer(str
 /*
  * When a group wakes up we want to make sure that its quota is not already
  * expired/exceeded, otherwise it may be allowed to steal additional ticks of
- * runtime as update_curr() throttling can not not trigger until it's on-rq.
+ * runtime as update_curr() throttling can not trigger until it's on-rq.
  */
 static void check_enqueue_throttle(struct cfs_rq *cfs_rq)
 {
--- linux-next-20201218.orig/kernel/sched/membarrier.c
+++ linux-next-20201218/kernel/sched/membarrier.c
@@ -454,7 +454,7 @@ static int sync_runqueues_membarrier_sta
 
 	/*
 	 * For each cpu runqueue, if the task's mm match @mm, ensure that all
-	 * @mm's membarrier state set bits are also set in in the runqueue's
+	 * @mm's membarrier state set bits are also set in the runqueue's
 	 * membarrier state. This ensures that a runqueue scheduling
 	 * between threads which are users of @mm has its membarrier state
 	 * updated.
