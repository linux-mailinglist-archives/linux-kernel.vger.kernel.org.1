Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87B73293F1E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 17:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394433AbgJTPAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 11:00:00 -0400
Received: from mail.efficios.com ([167.114.26.124]:53820 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394426AbgJTO77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 10:59:59 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 8E2452DA89E;
        Tue, 20 Oct 2020 10:59:58 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id cLr9ZG3puwEB; Tue, 20 Oct 2020 10:59:58 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 451FA2DA982;
        Tue, 20 Oct 2020 10:59:58 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 451FA2DA982
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1603205998;
        bh=SAjLjf17dWQe0Eet/XV19eAlvtvSV2KEbCMmoK1Uq+w=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=KFvzt7tJiNIxWGq0+78cIeL5TRbDtze09BmBs9OTvUazOR9o/bTdAqpyDHteVgekt
         Yu8RM35XQ1rCUhFW5aI+WFwQSFQuhmCMO7ngKTvkwlXURbrgBHZVwGqG+jdCU5LahN
         B8m3b2NbFdGf6G9fzih/Xj6rse72DW3N9xbgJvYXK0Mp76MyAV+z0GpQQhDPUuqgiG
         YoNDoukSITHrmEN991jJjw/QQaPnmzq/xrevvzpuihB8uCcfb+tJjwYNHzWNArMk2E
         19ibiF+3kJuccvlbm7Jub1629j0DU66LkofqvU3QaM2ANn0b3w9Le6uRtxE7uH1eYV
         WY9z9341qaf6g==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id bWA7Rdzf3jiq; Tue, 20 Oct 2020 10:59:58 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id 34C5F2DA980;
        Tue, 20 Oct 2020 10:59:58 -0400 (EDT)
Date:   Tue, 20 Oct 2020 10:59:58 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>, paulmck <paulmck@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        linux-mm <linux-mm@kvack.org>
Message-ID: <1123875792.30589.1603205998119.JavaMail.zimbra@efficios.com>
In-Reply-To: <20201020143648.GU2628@hirez.programming.kicks-ass.net>
References: <20201020134715.13909-1-mathieu.desnoyers@efficios.com> <20201020134715.13909-2-mathieu.desnoyers@efficios.com> <20201020143648.GU2628@hirez.programming.kicks-ass.net>
Subject: Re: [PATCH 1/3] sched: fix exit_mm vs membarrier (v4)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_3968 (ZimbraWebClient - FF81 (Linux)/8.8.15_GA_3968)
Thread-Topic: sched: fix exit_mm vs membarrier (v4)
Thread-Index: 3TQyEekaUSRarv/NoIfssTVvmqquog==
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- On Oct 20, 2020, at 10:36 AM, Peter Zijlstra peterz@infradead.org wrote:

> On Tue, Oct 20, 2020 at 09:47:13AM -0400, Mathieu Desnoyers wrote:
>> +void membarrier_update_current_mm(struct mm_struct *next_mm)
>> +{
>> +	struct rq *rq = this_rq();
>> +	int membarrier_state = 0;
>> +
>> +	if (next_mm)
>> +		membarrier_state = atomic_read(&next_mm->membarrier_state);
>> +	if (READ_ONCE(rq->membarrier_state) == membarrier_state)
>> +		return;
>> +	WRITE_ONCE(rq->membarrier_state, membarrier_state);
>> +}
> 
> This is suspisioucly similar to membarrier_switch_mm().
> 
> Would something like so make sense?

Very much yes. Do you want me to re-send the series, or you
want to fold this in as you merge it ?

Thanks,

Mathieu

> 
> ---
> --- a/kernel/sched/membarrier.c
> +++ b/kernel/sched/membarrier.c
> @@ -206,14 +206,7 @@ void membarrier_exec_mmap(struct mm_stru
> 
> void membarrier_update_current_mm(struct mm_struct *next_mm)
> {
> -	struct rq *rq = this_rq();
> -	int membarrier_state = 0;
> -
> -	if (next_mm)
> -		membarrier_state = atomic_read(&next_mm->membarrier_state);
> -	if (READ_ONCE(rq->membarrier_state) == membarrier_state)
> -		return;
> -	WRITE_ONCE(rq->membarrier_state, membarrier_state);
> +	membarrier_switch_mm(this_rq(), NULL, next_mm);
> }
> 
> static int membarrier_global_expedited(void)
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index d2621155393c..3d589c2ffd28 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2645,12 +2645,14 @@ static inline void membarrier_switch_mm(struct rq *rq,
> 					struct mm_struct *prev_mm,
> 					struct mm_struct *next_mm)
> {
> -	int membarrier_state;
> +	int membarrier_state = 0;
> 
> 	if (prev_mm == next_mm)
> 		return;
> 
> -	membarrier_state = atomic_read(&next_mm->membarrier_state);
> +	if (next_mm)
> +		membarrier_state = atomic_read(&next_mm->membarrier_state);
> +
> 	if (READ_ONCE(rq->membarrier_state) == membarrier_state)
>  		return;

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
