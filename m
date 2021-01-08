Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C87C2EF407
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 15:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727466AbhAHOhm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 09:37:42 -0500
Received: from foss.arm.com ([217.140.110.172]:52174 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727242AbhAHOhl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 09:37:41 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B3548ED1;
        Fri,  8 Jan 2021 06:36:55 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 620963F70D;
        Fri,  8 Jan 2021 06:36:54 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/3 v2] sched/fair: reduce cases for active balance
In-Reply-To: <CAKfTPtDhyD2qzjmSGJSsnQwv2M7KSbFhFYkkKUJ0rmvJx632vw@mail.gmail.com>
References: <20210107103325.30851-1-vincent.guittot@linaro.org> <20210107103325.30851-4-vincent.guittot@linaro.org> <jhjczyhasy0.mognet@arm.com> <CAKfTPtAW1e=AFfD3O58sZqAW281WA43gj6VDJUVjFLK4STWfHA@mail.gmail.com> <jhjo8i063yc.mognet@arm.com> <CAKfTPtDhyD2qzjmSGJSsnQwv2M7KSbFhFYkkKUJ0rmvJx632vw@mail.gmail.com>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/26.3 (x86_64-pc-linux-gnu)
Date:   Fri, 08 Jan 2021 14:36:47 +0000
Message-ID: <jhjsg7b8phc.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/01/21 09:11, Vincent Guittot wrote:
> On Thu, 7 Jan 2021 at 18:40, Valentin Schneider
> <valentin.schneider@arm.com> wrote:
>>
>> On 07/01/21 13:20, Vincent Guittot wrote:
>> > On Thu, 7 Jan 2021 at 12:26, Valentin Schneider
>> > <valentin.schneider@arm.com> wrote:
>> >> > @@ -9499,13 +9499,32 @@ asym_active_balance(struct lb_env *env)
>> >> >  }
>> >> >
>> >> >  static inline bool
>> >> > -voluntary_active_balance(struct lb_env *env)
>> >> > +imbalanced_active_balance(struct lb_env *env)
>> >> > +{
>> >> > +     struct sched_domain *sd = env->sd;
>> >> > +
>> >> > +     /*
>> >> > +      * The imbalanced case includes the case of pinned tasks preventing a fair
>> >> > +      * distribution of the load on the system but also the even distribution of the
>> >> > +      * threads on a system with spare capacity
>> >> > +      */
>> >>
>> >> Do you mean s/imbalanced/migrate_task/? This part here will affect
>> >> group_imbalanced, group_asym_packing, and some others.
>> >
>> > I really mean the imbalanced case which refers to the function name
>> > and includes:
>> > - the pinned tasks case aka group_imbalanced and which is the primary
>> > target of this function ( which explains its name)
>> > - but also the case where we want to evenly spread tasks on system
>> > with spare capacity and removed this imbalance
>> >
>>
>> But can't this also affect other group_types? calculate_imbalance() can
>> set
>>
>>   env->migration_type = migrate_task;
>>
>> for
>>
>>   busiest->group_type > group_fully_busy
>
> yes but we are still in the case of evenly spread tasks on system with
> spare capacity. Also, this is already the behavior for such cases.

Ah, I was parsing 'imbalance' as 'group_imbalance' and didn't read
your 'evenly spread tasks' description as accounting this case.

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
