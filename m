Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B03A82DE3FB
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 15:27:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727845AbgLRO00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 09:26:26 -0500
Received: from foss.arm.com ([217.140.110.172]:36412 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727358AbgLRO0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 09:26:25 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 071E41FB;
        Fri, 18 Dec 2020 06:25:40 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2A6EE3F66B;
        Fri, 18 Dec 2020 06:25:38 -0800 (PST)
References: <20201218103258.GA3040@hirez.programming.kicks-ass.net> <jhjsg83s616.mognet@arm.com> <20201218133655.GA10123@e123083-lin>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Morten Rasmussen <morten.rasmussen@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        dietmar.eggemann@arm.com, patrick.bellasi@matbug.net,
        lenb@kernel.org, linux-kernel@vger.kernel.org,
        ionela.voinescu@arm.com, qperret@google.com,
        viresh.kumar@linaro.org
Subject: Re: [PATCH] sched: Add schedutil overview
In-reply-to: <20201218133655.GA10123@e123083-lin>
Date:   Fri, 18 Dec 2020 14:25:33 +0000
Message-ID: <jhjr1nnry1u.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 18/12/20 13:40, Morten Rasmussen wrote:
> On Fri, Dec 18, 2020 at 11:33:09AM +0000, Valentin Schneider wrote:
>> (also, does this need a word about runnable rt tasks => goto max?)
>
> What is actually the intended policy there? I thought it was goto max
> unless rt was clamped, but if I read the code correctly in
> schedutil_cpu_util() the current policy is only goto max if uclamp isn't
> in use at all, including cfs.
>

Right, so the policy pretty much is: by default, if there are runnable rt
tasks, goto max freq.

When uclamp isn't used, that's hardcoded.

When uclamp is in use, the default RT uclamp.min is 1024, so it "naturally"
drives frequency selection to the max when there are runnable RT tasks
(rq-aggregated uclamp.min == 1024). That default
(uclamp_util_min_rt_default) can be tweaked.

> The write-up looks good to me.
>
> Reviewed-by: Morten Rasmussen <morten.rasmussen@arm.com>
>
> Morten
