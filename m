Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A52B29EEA9
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 15:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727674AbgJ2Opt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 10:45:49 -0400
Received: from foss.arm.com ([217.140.110.172]:38590 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726521AbgJ2Opt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 10:45:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A1D84139F;
        Thu, 29 Oct 2020 07:45:48 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 357D73F66E;
        Thu, 29 Oct 2020 07:45:47 -0700 (PDT)
References: <20201028174412.680-1-vincent.guittot@linaro.org> <jhjk0v9p9ic.mognet@arm.com> <CAKfTPtC1Y_3-8iRhMDe2eU5MGiHWGV4_Nokiy7LgE2OAnkNE_w@mail.gmail.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Tao Zhou <ouwen210@hotmail.com>
Subject: Re: [PATCH v2] sched/fair: prefer prev cpu in asymmetric wakeup path
In-reply-to: <CAKfTPtC1Y_3-8iRhMDe2eU5MGiHWGV4_Nokiy7LgE2OAnkNE_w@mail.gmail.com>
Date:   Thu, 29 Oct 2020 14:45:40 +0000
Message-ID: <jhjh7qdozu3.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 29/10/20 14:19, Vincent Guittot wrote:
> On Thu, 29 Oct 2020 at 12:16, Valentin Schneider
> <valentin.schneider@arm.com> wrote:
>> On legacy big.LITTLE systems, sd_asym_cpucapacity spans all CPUs, so we
>> would iterate over those in select_idle_capacity() anyway - the policy
>> we've been going for is that capacity fitness trumps cache use.
>>
>> This does require the system to have a decent interconnect, cache snooping
>> & co, but that is IMO a requirement of any sane asymmetric system.
>>
>> To put words into code, this is the kind of check I would see:
>>
>>   if (static_branch_unlikely(&sched_asym_cpucapacity))
>>         return fits_capacity(task_util, capacity_of(cpu));
>>   else
>
> You can't make the shortcut that prev will always belong to the domain
> so you have to check that prev belongs to the sd_asym_cpucapacity.
> Even if it's true with current mobile Soc, This code is generic core
> code and must handle any kind of funny topology than HW guys could
> imagine
>

Don't give them any funny ideas! :-)

But yes, you're right in that we could have more than one asym domain span,
although AFAIA that would only be permitted by DynamIQ.

I was about to say that for DynamIQ the shared L3 should make it that the
asym domain commonly matches MC (thus cpus_share_cache()), but phantom
domains wreck that :/ Arguably that isn't upstream's problem though.
