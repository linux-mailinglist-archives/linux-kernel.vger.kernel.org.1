Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95AFE26BF61
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 10:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgIPId4 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 16 Sep 2020 04:33:56 -0400
Received: from foss.arm.com ([217.140.110.172]:56318 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725840AbgIPIdz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 04:33:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 659E7101E;
        Wed, 16 Sep 2020 01:33:54 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D9913F718;
        Wed, 16 Sep 2020 01:33:53 -0700 (PDT)
References: <20200914100340.17608-1-vincent.guittot@linaro.org> <20200914100340.17608-3-vincent.guittot@linaro.org> <jhjimce6ev2.mognet@arm.com> <CAKfTPtC0Sf6SN+rqjQje-kXJiOaLzc0XnXqzS3hOF2FE=FscMA@mail.gmail.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] sched/fair: reduce minimal imbalance threshold
In-reply-to: <CAKfTPtC0Sf6SN+rqjQje-kXJiOaLzc0XnXqzS3hOF2FE=FscMA@mail.gmail.com>
Date:   Wed, 16 Sep 2020 09:33:48 +0100
Message-ID: <jhjd02m5deb.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 16/09/20 07:53, Vincent Guittot wrote:
> On Tue, 15 Sep 2020 at 21:04, Valentin Schneider
> <valentin.schneider@arm.com> wrote:
>> AIUI this is the culprit:
>>
>>                 if (100 * busiest->avg_load <=
>>                                 env->sd->imbalance_pct * local->avg_load)
>>                         goto out_balanced;
>>
>> As in your case imbalance_pct=120 becomes the tipping point.
>>
>> Now, ultimately this would need to scale based on the underlying topology,
>> right? If you have a system with 2x32 cores running {33 threads, 34
>> threads}, the tipping point becomes imbalance_pct≈103; but then since you
>> have this many more cores, it is somewhat questionable.
>
> I wanted to stay conservative and to not trigger too much task
> migration because of small imbalance so I decided to decrease the
> default threshold to the same level as the MC groups but this can
> still generate unfairness. With your example of 2x32 cores, if you end
> up with 33 tasks in one group and 38 in the other one, the system is
> overloaded so you use load and imbalance_pct but the imbalance will
> stay below the new threshold and the 33 tasks will have 13% more
> running time.
>
> This new imbalance_pct seems a reasonable step to decrease the unfairness
>

No major complaint on the change itself, it's just that this static
imbalance_pct assignment is something I've never really been satisfied with
- at the same time figuring a (or several) correct value from the topology
isn't straightforward either.

At the same time, I believe Peter would be happy to get rid of the decimal
faff and make it all simple shifts, which would limit how much we can
fine-tune these (not necessarily a bad thing).
