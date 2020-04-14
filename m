Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4269E1A8CFE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 22:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633500AbgDNU5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 16:57:34 -0400
Received: from foss.arm.com ([217.140.110.172]:34490 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2633476AbgDNU4v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 16:56:51 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 694451FB;
        Tue, 14 Apr 2020 13:56:47 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4EFF53F73D;
        Tue, 14 Apr 2020 13:56:45 -0700 (PDT)
References: <20200414150556.10920-1-qais.yousef@arm.com> <jhjh7xlvqqe.mognet@arm.com> <20200414162742.0ef4d9ee@gandalf.local.home>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Qais Yousef <qais.yousef@arm.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yury Norov <yury.norov@gmail.com>,
        Paul Turner <pjt@google.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Josh Don <joshdon@google.com>,
        Pavan Kondeti <pkondeti@codeaurora.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] sched/rt: Distribute tasks in find_lowest_rq()
In-reply-to: <20200414162742.0ef4d9ee@gandalf.local.home>
Date:   Tue, 14 Apr 2020 21:56:43 +0100
Message-ID: <jhjftd5vl9w.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 14/04/20 21:27, Steven Rostedt wrote:
> On Tue, 14 Apr 2020 19:58:49 +0100
> Valentin Schneider <valentin.schneider@arm.com> wrote:
>
>> To move this forward, I would suggest renaming the current cpumask_any_*()
>> into cpumask_first_*(), and THEN introduce the new pseudo-random
>> ones. People are then free to hand-fix specific locations if it makes sense
>> there, like you're doing for RT.
>
> Or leave "cpumask_any()" as is, and create a new "cpumask_random()" for
> this purpose.
>

Sure; I'll be happy as long as there isn't a blanket replacement of
existing callsites.

> -- Steve
