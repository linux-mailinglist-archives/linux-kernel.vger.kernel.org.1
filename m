Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B2962FBD1F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 18:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390637AbhASRB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 12:01:57 -0500
Received: from foss.arm.com ([217.140.110.172]:40152 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388905AbhASQ4m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 11:56:42 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5C9BD6E;
        Tue, 19 Jan 2021 08:55:53 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 00E573F66E;
        Tue, 19 Jan 2021 08:55:52 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Qais Yousef <qais.yousef@arm.com>,
        "Peter Zijlstra \(Intel\)" <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>
Subject: Re: [PATCH] sched/eas: Don't update misfit status if the task is pinned
In-Reply-To: <CAKfTPtCRPViF7B1iqeNVDi31X2sgOWKDJSGCBSzbj0c_Zb=mzA@mail.gmail.com>
References: <20210119120755.2425264-1-qais.yousef@arm.com> <CAKfTPtD+wU9-UitvnBmZFeAgXbsDO+qcsv-hYr0xxuewB_Kp+A@mail.gmail.com> <jhjmtx53ucp.mognet@arm.com> <CAKfTPtCRPViF7B1iqeNVDi31X2sgOWKDJSGCBSzbj0c_Zb=mzA@mail.gmail.com>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/26.3 (x86_64-pc-linux-gnu)
Date:   Tue, 19 Jan 2021 16:55:43 +0000
Message-ID: <jhjim7s50j4.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/01/21 15:19, Vincent Guittot wrote:
> On Tue, 19 Jan 2021 at 14:54, Valentin Schneider
> <valentin.schneider@arm.com> wrote:
>> On 19/01/21 14:34, Vincent Guittot wrote:
>> >> -       if (!p) {
>> >> +       if (!p || p->nr_cpus_allowed == 1) {
>> >
>> > Side question: What happens if there is 2 misfit tasks and the current
>> > one is pinned but not the other waiting one
>> >
>>
>> update_misfit_status() is called either on the current task (at tick) or
>> on the task picked by pick_next_task_fair() - i.e. CFS current or
>> about-to-be-current.
>>
>> So if you have 2 CPU hogs enqueued on a single LITTLE, and one of them
>> is pinned, the other one will be moved away either via regular load
>
> This doesn't seem reliable because it uses load or nr_running
>

Right

>> balance, or via misfit balance sometime after it's picked as the next
>> task to run.
>>
>> Admittedly that second case suffers from unfortunate timing mostly
>> related to the load balance interval. There was an old patch in the
>> Android stack that would reduce the balance interval upon detecting a
>
> Shouldn't we keep track of enqueue misfit tasks instead ?
>

That might help. This being CFS however, the maintenance of it might
prove prohibitive. I faintly recall having concerns about expanding the
misfit logic to non-current tasks, but nothing comes to mind right
now...

Historically (before PELT time scaling) I think it wasn't possible to
have a steady state with more than one misfit task on a rq, as two
similar CPU hogs would end up with a utilization value of at most half
the CPU's capacity. If those were at e.g. opposite ends of the NICE
spectrum, if one would be flagged as misfit then the other wouldn't
(can't have two slices greater than 80%!)

I *think* that's still true with timescaling, but then we did add the
uclamp stuff to make tasks look bigger than they are...

>> misfit task to "accelerate" its upmigration; this might need to be
>> revisited...
>>
>> >>                 rq->misfit_task_load = 0;
>> >>                 return;
>> >>         }
>> >> --
>> >> 2.25.1
>> >>
