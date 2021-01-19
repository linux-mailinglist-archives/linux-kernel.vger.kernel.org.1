Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC1BA2FBCC5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 17:46:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388983AbhASQoi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 11:44:38 -0500
Received: from foss.arm.com ([217.140.110.172]:39494 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389388AbhASQlR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 11:41:17 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8B736D6E;
        Tue, 19 Jan 2021 08:40:31 -0800 (PST)
Received: from e107158-lin (e107158-lin.cambridge.arm.com [10.1.194.78])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 754583F66E;
        Tue, 19 Jan 2021 08:40:30 -0800 (PST)
Date:   Tue, 19 Jan 2021 16:40:27 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     Quentin Perret <qperret@google.com>
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org,
        Valentin Schneider <valentin.schneider@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>
Subject: Re: [PATCH] sched/eas: Don't update misfit status if the task is
 pinned
Message-ID: <20210119164027.drfpmrol3xhf4ckc@e107158-lin>
References: <20210119120755.2425264-1-qais.yousef@arm.com>
 <YAb8XGyp3NtrHl+U@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YAb8XGyp3NtrHl+U@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/19/21 15:35, Quentin Perret wrote:
> On Tuesday 19 Jan 2021 at 12:07:55 (+0000), Qais Yousef wrote:
> > If the task is pinned to a cpu, setting the misfit status means that
> > we'll unnecessarily continuously attempt to migrate the task but fail.
> > 
> > This continuous failure will cause the balance_interval to increase to
> > a high value, and eventually cause unnecessary significant delays in
> > balancing the system when real imbalance happens.
> > 
> > Caught while testing uclamp where rt-app calibration loop was pinned to
> > cpu 0, shortly after which we spawn another task with high util_clamp
> > value. The task was failing to migrate after over 40ms of runtime due to
> > balance_interval unnecessary expanded to a very high value from the
> > calibration loop.
> > 
> > Not done here, but it could be useful to extend the check for pinning to
> > verify that the affinity of the task has a cpu that fits. We could end
> > up in a similar situation otherwise.
> 
> Do you mean failing the sched_setaffinity syscall if e.g. the task
> has a min clamp that is higher than the capacity of the CPUs to which it
> will be pinned? If so, I'm not sure if we really want that.

No. In Android for instance, I'm worried a background task affined to little
cores that has a utilization > capacity_of(little) will trigger the same
problem. It'll be affined to more than just 1 cpu, but none of the little cpus
will actually fit.

Makes sense?

> But this patch makes sense on its own for sure, so:
> 
> Reviewed-by: Quentin Perret <qperret@google.com>

Thanks

--
Qais Yousef
