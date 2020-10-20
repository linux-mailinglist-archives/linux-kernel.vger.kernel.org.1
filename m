Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC531293ED4
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 16:37:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408231AbgJTOhA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 10:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728712AbgJTOg7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 10:36:59 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A46C061755
        for <linux-kernel@vger.kernel.org>; Tue, 20 Oct 2020 07:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=8H3150gj3obwP8uh+NX1JstVv2SvYj4QAxAa8GSKXIM=; b=WjXrkfTZTNc4OPe1FvNLTC18Fp
        0UbNjNK7vRSBRd35ZCARbvEe4k2Y2PFMoQjXY/hZYhDLKsTvmu61a9HwS2B7ZIhl3B/L127Tm54BS
        Kxf2/YA8PlmZflelcC89E237IT/8IBRj1wlYR/LG7UWsUgIXxExnvx/vejl8UYj5NHhbxzz1/CO49
        qAXqdOGD++6upErA6dnAHot5TRlCn/qPZGMGoJZWB9vyErFOj+usMHymMCmerpoMT/1K6u44KeBNb
        paKZwehp+ZnMKpNIwFZh+OsQT78NDwFmWkEN4Cj6OCrfQdeN9u5reyc0zwSQsG9CUvT+jgstcWNvd
        8JcbHRcA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kUsks-0008Fo-MG; Tue, 20 Oct 2020 14:36:50 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id E14C93012C3;
        Tue, 20 Oct 2020 16:36:48 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id C701C21463183; Tue, 20 Oct 2020 16:36:48 +0200 (CEST)
Date:   Tue, 20 Oct 2020 16:36:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
        Will Deacon <will@kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alan Stern <stern@rowland.harvard.edu>, linux-mm@kvack.org
Subject: Re: [PATCH 1/3] sched: fix exit_mm vs membarrier (v4)
Message-ID: <20201020143648.GU2628@hirez.programming.kicks-ass.net>
References: <20201020134715.13909-1-mathieu.desnoyers@efficios.com>
 <20201020134715.13909-2-mathieu.desnoyers@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201020134715.13909-2-mathieu.desnoyers@efficios.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 09:47:13AM -0400, Mathieu Desnoyers wrote:
> +void membarrier_update_current_mm(struct mm_struct *next_mm)
> +{
> +	struct rq *rq = this_rq();
> +	int membarrier_state = 0;
> +
> +	if (next_mm)
> +		membarrier_state = atomic_read(&next_mm->membarrier_state);
> +	if (READ_ONCE(rq->membarrier_state) == membarrier_state)
> +		return;
> +	WRITE_ONCE(rq->membarrier_state, membarrier_state);
> +}

This is suspisioucly similar to membarrier_switch_mm().

Would something like so make sense?

---
--- a/kernel/sched/membarrier.c
+++ b/kernel/sched/membarrier.c
@@ -206,14 +206,7 @@ void membarrier_exec_mmap(struct mm_stru
 
 void membarrier_update_current_mm(struct mm_struct *next_mm)
 {
-	struct rq *rq = this_rq();
-	int membarrier_state = 0;
-
-	if (next_mm)
-		membarrier_state = atomic_read(&next_mm->membarrier_state);
-	if (READ_ONCE(rq->membarrier_state) == membarrier_state)
-		return;
-	WRITE_ONCE(rq->membarrier_state, membarrier_state);
+	membarrier_switch_mm(this_rq(), NULL, next_mm);
 }
 
 static int membarrier_global_expedited(void)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index d2621155393c..3d589c2ffd28 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2645,12 +2645,14 @@ static inline void membarrier_switch_mm(struct rq *rq,
 					struct mm_struct *prev_mm,
 					struct mm_struct *next_mm)
 {
-	int membarrier_state;
+	int membarrier_state = 0;
 
 	if (prev_mm == next_mm)
 		return;
 
-	membarrier_state = atomic_read(&next_mm->membarrier_state);
+	if (next_mm)
+		membarrier_state = atomic_read(&next_mm->membarrier_state);
+
 	if (READ_ONCE(rq->membarrier_state) == membarrier_state)
 		return;
 
