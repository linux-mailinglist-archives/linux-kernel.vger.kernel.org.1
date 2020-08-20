Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9090524C115
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Aug 2020 16:56:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbgHTO43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Aug 2020 10:56:29 -0400
Received: from foss.arm.com ([217.140.110.172]:40566 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727090AbgHTO41 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 10:56:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1B64331B;
        Thu, 20 Aug 2020 07:56:26 -0700 (PDT)
Received: from [192.168.178.2] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F99D3F6CF;
        Thu, 20 Aug 2020 07:56:20 -0700 (PDT)
Subject: Re: CFS flat runqueue proposal fixes/update
To:     Rik van Riel <riel@surriel.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Paul Turner <pjt@google.com>,
        "vincent.guittot" <vincent.guittot@linaro.org>, kernel-team@fb.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dietmar.eggeman" <dietmar.eggeman@arm.com>
References: <1609106d05a6a4a5938233e993548510f599d7d9.camel@surriel.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <0e7a9174-6ed9-752d-dacb-4dce182852cf@arm.com>
Date:   Thu, 20 Aug 2020 16:56:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1609106d05a6a4a5938233e993548510f599d7d9.camel@surriel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rik,

On 31/07/2020 09:42, Rik van Riel wrote:

[...]

> Lets revisit the hierarchy from above, and assign priorities
> to the cgroups, with the fixed point one being 1000. Lets
> say cgroups A, A1, and B have priority 1000, while cgroup
> A2 has priority 1.
> 
>         /\
>        /  \
>       A    B
>      / \    \ 
>     A1 A2   t3
>    /     \
>   t1     t2
> 
> One consequence of this is that when t1, t2, and t3 each
> get a time slice, the vruntime of tasks t1 and t3 advances
> at roughly the same speed as the clock time, while the
> vruntime of task t2 advances 1000x faster.
> 
> This is fine if all three tasks continue to be runnable,
> since t1, t2 and t3 each get their fair share of CPU time.
> 
> However, if t1 goes to sleep, t2 is the only thing running
> inside cgroup A, which has the same priority as cgroup B,
> and tasks t2 and t3 should be getting the same amount of
> CPU time.
> 
> They eventually will, but not before task t3 has used up
> enough CPU time to catch up with the enormous vruntime
> advance that t2 just suffered.
> 
> That needs to be fixed, to get near-immediate convergence,
> and not convergence after some unknown (potentially long)
> period of time.

I'm trying to understand this issue in detail ...

Since t1 and t2 are single tasks in A1 and A2, this taskgroup level
shouldn't matter for tick preemption after t1 went to sleep?

check_preempt_tick() is only invoked for 'cfs_rq->nr_running > 1' from
entity_tick().

IMHO, tick preemption is handled between A and B and since they have the
same cpu.weight (cpu.shares) t2 and t3 get the same time slice after t1
went to sleep.

I think that here tick preemption happens in the 'if (delta_exec >
ideal_runtime)' condition w/ delta_exec = curr->sum_exec_runtime -
curr->prev_sum_exec_runtime.

Did I miss anything?

[...]
