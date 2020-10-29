Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D16A529F475
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 20:03:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725870AbgJ2TD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 15:03:27 -0400
Received: from foss.arm.com ([217.140.110.172]:42462 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726125AbgJ2TDX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 15:03:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 44CFC139F;
        Thu, 29 Oct 2020 12:03:22 -0700 (PDT)
Received: from e113632-lin (e113632-lin.cambridge.arm.com [10.1.194.46])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 28ABB3F719;
        Thu, 29 Oct 2020 12:03:20 -0700 (PDT)
References: <20201023101158.088940906@infradead.org>
User-agent: mu4e 0.9.17; emacs 26.3
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, qais.yousef@arm.com, swood@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vincent.donnefort@arm.com,
        tj@kernel.org, ouwen210@hotmail.com
Subject: Re: [PATCH v4 00/19] sched: Migrate disable support
In-reply-to: <20201023101158.088940906@infradead.org>
Date:   Thu, 29 Oct 2020 19:03:17 +0000
Message-ID: <jhj361wq2h6.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 23/10/20 11:11, Peter Zijlstra wrote:
> Hi,
>
> The fourth version of migrate_disable() for PREEMPT_RT.
>
> Two changes since last time:
>
>  - fixes !SMP builds (bigeasy)
>  - TLA+ validation of migrate_disable() vs sched_setaffinity() (valsch)
>
> Esp. that latter resulted in significant changes to patch #10. Huge thanks to
> Valentin.
>

I've been poking at that model some more; there's always going to be some
gap between what is being modelled vs what the code actually does, but
I'm mostly happy with the state it is in now.


So far it's been 1 victim task looping around a Migration-Disabled region
while some other threads fight over changing its affinity. The victim task
can also be preempted by some higher-priority task. I didn't make the
victim task block between Migration-Disabled regions.

Last run was 2 CPUs and 2 affinity-changing threads, I'll try to bump that
a bit but it is already somewhat lengthy to run (~10h).

In terms of what this has been checking
- Forward progress (no process forever blocked on some condition / lock)
- Refcounts always >= 0 (hit a few -1's in earlier versions)
- Affinity is respected
  I've "implemented" that as:

    If 'p' is running on a CPU, then that CPU must be in p->cpus_mask when
      !p->migration_pending && p->pi_lock is not held


I don't think I have much else to add, so feel free to add

  Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>

To patches 01-14, 16-17.

The RT side of patch 15 looked fine to me, but I didn't spend much time on
DL. We might still want to steal those .pick_task() from coresched to
implement that XXX in push_cpu_stop(), but AIUI this is more of a
performance thing than a correctness one.
