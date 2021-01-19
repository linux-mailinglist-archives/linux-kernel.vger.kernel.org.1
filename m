Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBB152FC1AD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 21:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729932AbhASU4o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 15:56:44 -0500
Received: from foss.arm.com ([217.140.110.172]:50462 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391991AbhASUwD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 15:52:03 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 16C41D6E;
        Tue, 19 Jan 2021 12:51:12 -0800 (PST)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D24723F719;
        Tue, 19 Jan 2021 12:51:10 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Quentin Perret <qperret@google.com>
Subject: Re: [PATCH] sched/deadline: Reduce rq lock contention in dl_add_task_root_domain()
In-Reply-To: <20210119083542.19856-1-dietmar.eggemann@arm.com>
References: <20210119083542.19856-1-dietmar.eggemann@arm.com>
User-Agent: Notmuch/0.21 (http://notmuchmail.org) Emacs/26.3 (x86_64-pc-linux-gnu)
Date:   Tue, 19 Jan 2021 20:51:06 +0000
Message-ID: <jhjeeig4pmt.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/01/21 09:35, Dietmar Eggemann wrote:
> dl_add_task_root_domain() is called during sched domain rebuild:
>
>   rebuild_sched_domains_locked()
>     partition_and_rebuild_sched_domains()
>       rebuild_root_domains()
>          for all top_cpuset descendants:
>            update_tasks_root_domain()
>              for all tasks of cpuset:
>                dl_add_task_root_domain()
>
> Change it so that only the task pi lock is taken to check if the task
> has a SCHED_DEADLINE (DL) policy. In case that p is a DL task take the
> rq lock as well to be able to safely de-reference root domain's DL
> bandwidth structure.
>

A task's policy is stable under ->pi_lock, so LGTM.

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>

> Most of the tasks will have another policy (namely SCHED_NORMAL) and
> can now bail without taking the rq lock.
>
> One thing to note here: Even in case that there aren't any DL user
> tasks, a slow frequency switching system with cpufreq gov schedutil has
> a DL task (sugov) per frequency domain running which participates in DL
> bandwidth management.
>
> Reviewed-by: Quentin Perret <qperret@google.com>
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
