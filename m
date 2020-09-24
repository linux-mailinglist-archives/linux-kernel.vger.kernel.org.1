Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 911C5277115
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 14:33:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727764AbgIXMdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 08:33:32 -0400
Received: from foss.arm.com ([217.140.110.172]:44740 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727660AbgIXMdc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 08:33:32 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 19860113E;
        Thu, 24 Sep 2020 05:33:32 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 352CC3F73B;
        Thu, 24 Sep 2020 05:33:30 -0700 (PDT)
References: <20200921163557.234036895@infradead.org> <20200921163845.769861942@infradead.org> <jhj5z83mlvu.mognet@arm.com> <20200924122934.GI2628@hirez.programming.kicks-ass.net>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, qais.yousef@arm.com, swood@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vincent.donnefort@arm.com
Subject: Re: [PATCH 7/9] sched: Add migrate_disable()
In-reply-to: <20200924122934.GI2628@hirez.programming.kicks-ass.net>
Date:   Thu, 24 Sep 2020 13:33:25 +0100
Message-ID: <jhj4knnmk16.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 24/09/20 13:29, Peter Zijlstra wrote:
> On Thu, Sep 24, 2020 at 12:53:25PM +0100, Valentin Schneider wrote:
>> On 21/09/20 17:36, Peter Zijlstra wrote:
>>
>> [...]
>>
>> > +void migrate_enable(void)
>> > +{
>> > +	if (--current->migration_disabled)
>> > +		return;
>> > +
>> > +	barrier();
>> > +
>> > +	if (p->cpus_ptr == &p->cpus_mask)
>> > +		return;
>>
>> If we get to here this means we're the migrate_enable() invocation that
>> marks the end of the migration_disabled region. How can cpus_ptr already
>> point back to current's cpus_mask?
>
> It might never have been changed away.
>
>
>       migrate_disable()
>         ->migration_disabled++;
>       |	|
>       |	|
>       |	v
>       |	migrate_disable_switch()
>       |	  if (->cpus_ptr == &->cpus_mask)
>       |	    __do_set_cpus_allowed(.new_mask = cpumask_of())
>       |	|
>       |	|
>       v	v
>       migrate_enable()
>         ->migration_disabled--;
>
>
> Only if we've passed through a context switch between migrate_disable()
> and migrate_enable() will the mask have been changed.

Doh, yes indeed. Thanks.
