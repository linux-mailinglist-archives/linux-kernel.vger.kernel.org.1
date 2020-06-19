Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21C6E200881
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jun 2020 14:17:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732895AbgFSMRe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Jun 2020 08:17:34 -0400
Received: from foss.arm.com ([217.140.110.172]:55204 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728712AbgFSMRd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 08:17:33 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F07F101E;
        Fri, 19 Jun 2020 05:17:32 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 926453F6CF;
        Fri, 19 Jun 2020 05:17:30 -0700 (PDT)
References: <20200618195525.7889-1-qais.yousef@arm.com> <20200618195525.7889-3-qais.yousef@arm.com> <jhjwo43cpfl.mognet@arm.com> <20200619115723.GF3129@suse.de>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Mel Gorman <mgorman@suse.de>
Cc:     Qais Yousef <qais.yousef@arm.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Chris Redpath <chrid.redpath@arm.com>,
        Lukasz Luba <lukasz.luba@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] sched/uclamp: Protect uclamp fast path code with static key
In-reply-to: <20200619115723.GF3129@suse.de>
Date:   Fri, 19 Jun 2020 13:17:28 +0100
Message-ID: <jhjtuz7ckrr.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 19/06/20 12:57, Mel Gorman wrote:
> On Fri, Jun 19, 2020 at 11:36:46AM +0100, Valentin Schneider wrote:
>> >                                    nouclamp                 uclamp      uclamp-static-key
>> > Hmean     send-64         162.43 (   0.00%)      157.84 *  -2.82%*      163.39 *   0.59%*
>> > Hmean     send-128        324.71 (   0.00%)      314.78 *  -3.06%*      326.18 *   0.45%*
>> > Hmean     send-256        641.55 (   0.00%)      628.67 *  -2.01%*      648.12 *   1.02%*
>> > Hmean     send-1024      2525.28 (   0.00%)     2448.26 *  -3.05%*     2543.73 *   0.73%*
>> > Hmean     send-2048      4836.14 (   0.00%)     4712.08 *  -2.57%*     4867.69 *   0.65%*
>> > Hmean     send-3312      7540.83 (   0.00%)     7425.45 *  -1.53%*     7621.06 *   1.06%*
>> > Hmean     send-4096      9124.53 (   0.00%)     8948.82 *  -1.93%*     9276.25 *   1.66%*
>> > Hmean     send-8192     15589.67 (   0.00%)    15486.35 *  -0.66%*    15819.98 *   1.48%*
>> > Hmean     send-16384    26386.47 (   0.00%)    25752.25 *  -2.40%*    26773.74 *   1.47%*
>> >
>>
>> Am I reading this correctly in that compiling in uclamp but having the
>> static key enabled gives a slight improvement compared to not compiling in
>> uclamp? I suppose the important bit is that we're not seeing regressions
>> anymore, but still.
>>
>
> I haven't reviewed the series in depth because from your review, another
> version is likely in the works.

I don't wait Qais to hate me here - I think you could start the performance
testing on this version if you feel like it, given my comments were mostly
on changelog / debug options - the core of that patch shouldn't change
much.

> However, it is not that unusual to
> see small fluctuations like this that are counter-intuitive. The report
> indicates the difference is likely outside of the noise with * around the
> percentage difference instead of () but it could be small boot-to-boot
> variance, differences in code layout, slight differences in slab usage
> patterns etc. The definitive evidence that uclamp overhead is no there
> is whether the uclamp functions show up in annotated profiles or not.

I see, thanks! I suppose if we have access to individual samples we can
also run some statistical tests / stare at some boxplots to see how it
compares.
