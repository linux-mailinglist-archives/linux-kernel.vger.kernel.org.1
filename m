Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 494202B052D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 13:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbgKLMwY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 07:52:24 -0500
Received: from foss.arm.com ([217.140.110.172]:49462 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727997AbgKLMwW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 07:52:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D0D0101E;
        Thu, 12 Nov 2020 04:52:22 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 598A13F718;
        Thu, 12 Nov 2020 04:52:20 -0800 (PST)
References: <20201112111201.2081902-1-qperret@google.com> <jhjh7puyczc.mognet@arm.com> <20201112123854.GA2222462@google.com>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Quentin Perret <qperret@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Quentin Perret <qperret@qperret.net>,
        "open list\:SCHEDULER" <linux-kernel@vger.kernel.org>,
        kernel-team@android.com, Rick Yiu <rickyiu@google.com>
Subject: Re: [PATCH] sched/fair: Fix overutilized update in enqueue_task_fair()
In-reply-to: <20201112123854.GA2222462@google.com>
Date:   Thu, 12 Nov 2020 12:52:18 +0000
Message-ID: <jhjeekyyby5.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 12/11/20 12:38, Quentin Perret wrote:
> On Thursday 12 Nov 2020 at 12:29:59 (+0000), Valentin Schneider wrote:
>> Alternatively: how much does not updating the overutilized status here help
>> us? The next tick will unconditionally update it, which for arm64 is
>> anywhere in the next ]0, 4]ms. That "fake" fork-time util_avg should already
>> be accounted in the rq util_avg, and even if the new task was running the
>> entire time, 4ms doesn't buy us much decay.
>
> Yes, this is arguably a dodgy hack, which will not save us in a number
> of cases. The only situation where this helps is for short-lived tasks
> that will run only once. And this is a sadly common programming pattern.
>
> So yeah, this is not the prettiest thing in the world, but it doesn't
> cost us much and helps some real-world workloads, so ...
>

Aye aye

> Thanks,
> Quentin
