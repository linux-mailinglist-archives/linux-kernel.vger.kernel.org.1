Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E53312F2B06
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 10:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390402AbhALJRL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 04:17:11 -0500
Received: from mx2.suse.de ([195.135.220.15]:39778 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389835AbhALJRJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 04:17:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 403A5AC8F;
        Tue, 12 Jan 2021 09:16:28 +0000 (UTC)
Date:   Tue, 12 Jan 2021 09:16:25 +0000
From:   Mel Gorman <mgorman@suse.de>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, valentin.schneider@arm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3 v2] sched/fair: reduce cases for active balance
Message-ID: <20210112091625.GH3524@suse.de>
References: <20210107103325.30851-1-vincent.guittot@linaro.org>
 <20210107103325.30851-4-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20210107103325.30851-4-vincent.guittot@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 07, 2021 at 11:33:25AM +0100, Vincent Guittot wrote:
> Active balance is triggered for a number of voluntary cases like misfit
> or pinned tasks cases but also after that a number of load balance
> attempts failed to migrate a task. There is no need to use active load
> balance when the group is overloaded because an overloaded state means
> that there is at least one waiting task. Nevertheless, the waiting task
> is not selected and detached until the threshold becomes higher than its
> load. This threshold increases with the number of failed lb (see the
> condition if ((load >> env->sd->nr_balance_failed) > env->imbalance) in
> detach_tasks()) and the waiting task will end up to be selected after a
> number of attempts.
> 
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>

I didn't see major problems so.

Acked-by: Mel Gorman <mgorman@suse.de>

Like you, I do not see significant performance differences, either
positive or negative (minor gains and losses that are borderline).
However, I didn't track the stats necessary to see what impact it had on
alb_* stats which is an oversight but schedstat tracking interferes with
results on its own. It would have been nice to see how often this case
is even hit in the overloaded case.

-- 
Mel Gorman
SUSE Labs
