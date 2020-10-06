Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74CCC284AC1
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 13:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726147AbgJFLUt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 07:20:49 -0400
Received: from foss.arm.com ([217.140.110.172]:45132 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725891AbgJFLUs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 07:20:48 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ECA7A143D;
        Tue,  6 Oct 2020 04:20:47 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EC3693F66B;
        Tue,  6 Oct 2020 04:20:45 -0700 (PDT)
References: <20201005145717.346020688@infradead.org> <20201005150922.458081448@infradead.org>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, qais.yousef@arm.com, swood@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vincent.donnefort@arm.com,
        tj@kernel.org
Subject: Re: [PATCH -v2 15/17] sched: Fix migrate_disable() vs rt/dl balancing
In-reply-to: <20201005150922.458081448@infradead.org>
Date:   Tue, 06 Oct 2020 12:20:43 +0100
Message-ID: <jhjv9fnmwhg.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 05/10/20 15:57, Peter Zijlstra wrote:
> In order to minimize the interference of migrate_disable() on lower
> priority tasks, which can be deprived of runtime due to being stuck
> below a higher priority task. Teach the RT/DL balancers to push away
> these higher priority tasks when a lower priority task gets selected
> to run on a freshly demoted CPU (pull).
>
> This adds migration interference to the higher priority task, but
> restores bandwidth to system that would otherwise be irrevocably lost.
> Without this it would be possible to have all tasks on the system
> stuck on a single CPU, each task preempted in a migrate_disable()
> section with a single high priority task running.
>
> This way we can still approximate running the M highest priority tasks
> on the system.
>

Ah, so IIUC that's the important bit that makes it we can't just say go
through the pushable_tasks list and skip migrate_disable() tasks.

Once the highest-prio task exits its migrate_disable() region, your patch
pushes it away. If we ended up with a single busy CPU, it'll spread the
tasks around one migrate_enable() at a time.

That time where the top task is migrate_disable() is still a crappy time,
and as you pointed out earlier today if it is a genuine pcpu task then the
whole thing is -EBORKED...

An alternative I could see would be to prevent those piles from forming
altogether, say by issuing a similar push_cpu_stop() on migrate_disable()
if the next pushable task is already migrate_disable(); but that's a
proactive approach whereas yours is reactive, so I'm pretty sure that's
bound to perform worse.

> Migrating the top task away is (ofcourse) still subject to
> migrate_disable() too, which means the lower task is subject to an
> interference equivalent to the worst case migrate_disable() section.
>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
