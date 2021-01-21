Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3F492FED0B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 15:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728456AbhAUOhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 09:37:14 -0500
Received: from foss.arm.com ([217.140.110.172]:38280 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731525AbhAUOgw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 09:36:52 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9E489139F;
        Thu, 21 Jan 2021 06:36:04 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 17EFE3F68F;
        Thu, 21 Jan 2021 06:36:02 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@kernel.org, tglx@linutronix.de, linux-kernel@vger.kernel.org,
        jiangshanlai@gmail.com, cai@redhat.com, vincent.donnefort@arm.com,
        decui@microsoft.com, paulmck@kernel.org,
        vincent.guittot@linaro.org, rostedt@goodmis.org, tj@kernel.org
Subject: Re: [PATCH -v3 8/9] sched: Fix CPU hotplug / tighten is_per_cpu_kthread()
In-Reply-To: <YAmNIsyaiO6teljH@hirez.programming.kicks-ass.net>
References: <20210121101702.402798862@infradead.org> <20210121103507.102416009@infradead.org> <jhjeeiemlsw.mognet@arm.com> <YAmNIsyaiO6teljH@hirez.programming.kicks-ass.net>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/26.3 (x86_64-pc-linux-gnu)
Date:   Thu, 21 Jan 2021 14:36:00 +0000
Message-ID: <jhj7do6mk6n.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/01/21 15:18, Peter Zijlstra wrote:
> On Thu, Jan 21, 2021 at 02:01:03PM +0000, Valentin Schneider wrote:
>> On 21/01/21 11:17, Peter Zijlstra wrote:
>> > @@ -7504,6 +7525,9 @@ int sched_cpu_deactivate(unsigned int cp
>> >        * preempt-disabled and RCU users of this state to go away such that
>> >        * all new such users will observe it.
>> >        *
>> > +	 * Specifically, we rely on ttwu to no longer target this CPU, see
>> > +	 * ttwu_queue_cond() and is_cpu_allowed().
>> > +	 *
>> 
>> So the last time ttwu_queue_wakelist() can append a task onto a dying
>> CPU's wakelist is before sched_cpu_deactivate()'s synchronize_rcu()
>> returns. 
>> 
>> As discussed on IRC, paranoia would have us issue a
>> 
>>   flush_smp_call_function_from_idle()
>> 
>> upon returning from said sync, but this will require further surgery.
>
> Right, specifically RCU needs a little more help there.
>
>> Do we want something like the below in the meantime? Ideally we'd warn on
>> setting rq->ttwu_pending when !cpu_active(), but as per the above this is
>> allowed before the synchronize_rcu() returns.
>
> I'm not sure I'm brave enough to add that just now :/

I get you; I couldn't come up with a better scheme that would give us a bit
more info than the sched_cpu_dying() splat :/
