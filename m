Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3E282872C9
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 12:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729620AbgJHKsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 06:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbgJHKsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 06:48:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB849C061755
        for <linux-kernel@vger.kernel.org>; Thu,  8 Oct 2020 03:48:11 -0700 (PDT)
Date:   Thu, 8 Oct 2020 12:48:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602154090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H6GJ43ndjv86S4x39kXxEOJV6Z/jS6Lg3feoyzr53KU=;
        b=KCZTaIMOwDE+nLCb6/4NVWEOh7qDzNRWyWnaHzyM1ea0hrl+enx4/LwkN6Ya55HuPj77aA
        T5IC7wVQFkNXvWeQRPtwrutktNTXeQsUOn+5KMZkvDUFa4i3a4qQeLXIPF9Af2ZbUusm6Y
        bb10/NGwADRcg7Oopw+4MZaPc9yS/JwRArseoJQUol/8J2XCZQbjaSrtfGVrJ4X/wZNmTn
        IRuEIHxCFFC3Fi9sqwjhllMGEkk4LLc6DzNkt7+Gk96vWlvMiSwcaBNnWeSCyLJRmtKJ7s
        SyB/NT7+s3uXr93/FNU/+dO6sDlmf7Gqi6HED/uFK3wvt1SvDGA+y9UQkccByA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602154090;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=H6GJ43ndjv86S4x39kXxEOJV6Z/jS6Lg3feoyzr53KU=;
        b=OIKdCJpQAS6RLlvt7OSXfKp0wCzsu1Hk49AWFldMQ8szdwLNRWtPDTyF2dYWGcrdPKjbzY
        QwORcRIcLlge9PCw==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        qais.yousef@arm.com, swood@redhat.com, valentin.schneider@arm.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vincent.donnefort@arm.com,
        tj@kernel.org
Subject: Re: [PATCH -v2 15/17] sched: Fix migrate_disable() vs rt/dl balancing
Message-ID: <20201008104808.b35lvigjaz7dvclf@linutronix.de>
References: <20201005145717.346020688@infradead.org>
 <20201005150922.458081448@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201005150922.458081448@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-10-05 16:57:32 [+0200], Peter Zijlstra wrote:
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

So there is a task running at priority 99.9 and then scheduler decides
to interrupt it while pushing it to a new CPU? But this does happen if
the task is pinned to one CPU. Then this shouldn't do much harm.

Usually the tasks with high priority are pinned to a single CPU because
otherwise it causes noise/latency when the scheduler bounces it to a
different CPUs.
Then there are the cases where the first lock limits the CPU mask and
the second lock is occupied. After the lock has been released the task
can't acquire it because the CPU is occupied by a task with higher
priority. This would be a win if the high-prio task would move to
another CPU if possible.

Sebastian
