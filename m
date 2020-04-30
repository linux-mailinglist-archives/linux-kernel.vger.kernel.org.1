Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6D471BFAE7
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Apr 2020 15:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbgD3N4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Apr 2020 09:56:40 -0400
Received: from foss.arm.com ([217.140.110.172]:55172 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728732AbgD3N4h (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 09:56:37 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7F4691063;
        Thu, 30 Apr 2020 06:56:36 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2DC263F68F;
        Thu, 30 Apr 2020 06:56:35 -0700 (PDT)
References: <20200428050242.17717-1-swood@redhat.com> <jhjzhatdgxh.mognet@arm.com> <CAKfTPtDktpTB7d6qhmcX0HtryezzFygk4kOC22Qf=OM77QpLYg@mail.gmail.com> <jhjy2qdcmc2.mognet@arm.com> <CAKfTPtA_duZpnvMx+czAosCikVL=cESKhPQcRrQUdKWKobZBaA@mail.gmail.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Scott Wood <swood@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Rik van Riel <riel@surriel.com>,
        Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Subject: Re: [RFC PATCH 0/3] newidle_balance() latency mitigation
In-reply-to: <CAKfTPtA_duZpnvMx+czAosCikVL=cESKhPQcRrQUdKWKobZBaA@mail.gmail.com>
Date:   Thu, 30 Apr 2020 14:56:29 +0100
Message-ID: <jhjwo5xcc1e.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 30/04/20 13:42, Vincent Guittot wrote:
>> >> Random thought that just occurred to me; in the grand scheme of things,
>> >> with something in the same spirit as task-stealing (i.e. don't bother with
>> >> a full fledged balance at newidle, just pick one spare task somewhere),
>> >> none of this would be required.
>> >
>> > newly idle load balance already stops after picking 1 task
>>
>> Mph, I had already forgotten your changes there. Is that really always the
>> case for newidle? In e.g. the busiest->group_type == group_fully_busy case,
>> I think we can pull more than one task.
>
> for newly_idle load balance, detach_tasks stops after finding 1 suitable task
>

Right, I hadn't noticed

  7e96fa5875d4 ("sched: pull only one task during NEWIDLE balancing to limit critical section")

>>
>> > Now if your proposal is to pick one random task on one random cpu, I'm
>> > clearly not sure that's a good idea
>> >
>>
>> IIRC Steve's implementation was to "simply" pull one task from any CPU
>> within the LLC domain that had > 1 runnable tasks. I quite like this since
>> picking any one task is almost always better than switching to the idle
>> task, but it wasn't a complete newidle_balance() replacement just yet.
>>
>> >
>> >>
>> >> Sadly I don't think anyone has been looking at it any recently.
