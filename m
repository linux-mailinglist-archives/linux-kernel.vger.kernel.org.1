Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5799284E22
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 16:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgJFOhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 10:37:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20404 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725970AbgJFOhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 10:37:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601995031;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ave6LqKn7/dJT7rO/GSpbJJIz0tD1EsTWoWxc02mh90=;
        b=BNgD80DPMo1zzA4xuwRmT2CEoDZu3SKFSWs5AlzCeQaOJlNePiXcnFhDJ7BAQdmFeh8+Si
        s2XHOU3edVPCDfY6+yOfljxU/R8vJ+PkNsNLKSLXTmb5nqUSG/fL9vORCLYDKeyh6w9Xvk
        NUpeaYf8CqqYznh4lXX2e8MEh/fvROo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-0j2uOLQvMR6c6DsZG4Q-Iw-1; Tue, 06 Oct 2020 10:37:09 -0400
X-MC-Unique: 0j2uOLQvMR6c6DsZG4Q-Iw-1
Received: by mail-wr1-f72.google.com with SMTP id r16so5410067wrm.18
        for <linux-kernel@vger.kernel.org>; Tue, 06 Oct 2020 07:37:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ave6LqKn7/dJT7rO/GSpbJJIz0tD1EsTWoWxc02mh90=;
        b=k+gkjxUvY9DZe+rLcf349fFF2Fn7ddmHcROyrwrw/6Zun3jCGCcAj6yS69p4LDUbS6
         iH52RL5lLJwPo4yfRDnLpB2Ob3O7xsl8W6yJwwI5QGYGVc5mRAKhVT3QgtEhrpVWYUFL
         grrjZHtDeoGH2M2SuE4isPev7F6a4KZtfRmktlFZNfoakTqqL+YVyQhcgw60Azckqb3J
         X+vD3cQQObvhtSkMs9K3hXSOLYFgnIiyOIPCjn3hPNOLI9D8GJQE80pBMFS2w9bqY+24
         Ge5GgBt/QZSchqWZgBMoRs97YQsZL6mn8B4cjtUMJsJQDklby2eG2s24BK4eH0Ftcc1t
         Aa+A==
X-Gm-Message-State: AOAM533H7x4GhiTyL9/Mx2d4lB8///bd+eZAiR7MGnWPrm8wK9baxPcB
        j55ArcYi1FDhBmENLxqkvppO9Aovf+k+yteCuT5e/SZrkoT6/mtgGoat/VlgfmPTbSSx/Y9oWfg
        6UdGhDxw5zV/uoOMocbET131S
X-Received: by 2002:a1c:3b8a:: with SMTP id i132mr3855242wma.189.1601995028333;
        Tue, 06 Oct 2020 07:37:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxtdCxl/4ZfRiZsQX8ji4RJt7HyTvoaFpjZiFwjVw1Am7Q3YgNDu+vZ3R3U9g54BVSXybo0Ew==
X-Received: by 2002:a1c:3b8a:: with SMTP id i132mr3855210wma.189.1601995028040;
        Tue, 06 Oct 2020 07:37:08 -0700 (PDT)
Received: from localhost.localdomain ([151.29.91.67])
        by smtp.gmail.com with ESMTPSA id o129sm4553289wmb.25.2020.10.06.07.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2020 07:37:06 -0700 (PDT)
Date:   Tue, 6 Oct 2020 16:37:04 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        tglx@linutronix.de, mingo@kernel.org, linux-kernel@vger.kernel.org,
        bigeasy@linutronix.de, qais.yousef@arm.com, swood@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, vincent.donnefort@arm.com, tj@kernel.org
Subject: Re: [PATCH -v2 15/17] sched: Fix migrate_disable() vs rt/dl balancing
Message-ID: <20201006143704.GJ4352@localhost.localdomain>
References: <20201005145717.346020688@infradead.org>
 <20201005150922.458081448@infradead.org>
 <jhjv9fnmwhg.mognet@arm.com>
 <20201006134850.GV2628@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201006134850.GV2628@hirez.programming.kicks-ass.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/10/20 15:48, Peter Zijlstra wrote:
> On Tue, Oct 06, 2020 at 12:20:43PM +0100, Valentin Schneider wrote:
> > 
> > On 05/10/20 15:57, Peter Zijlstra wrote:
> > > In order to minimize the interference of migrate_disable() on lower
> > > priority tasks, which can be deprived of runtime due to being stuck
> > > below a higher priority task. Teach the RT/DL balancers to push away
> > > these higher priority tasks when a lower priority task gets selected
> > > to run on a freshly demoted CPU (pull).

Still digesting the whole lot, but can't we "simply" force push the
higest prio (that we preempt to make space for the migrate_disabled
lower prio) directly to the cpu that would accept the lower prio that
cannot move?

Asking because AFAIU we are calling find_lock_rq from push_cpu_stop and
that selects the best cpu for the high prio. I'm basically wondering if
we could avoid moving, potentially multiple, high prio tasks around to
make space for a lower prio task.

> > > This adds migration interference to the higher priority task, but
> > > restores bandwidth to system that would otherwise be irrevocably lost.
> > > Without this it would be possible to have all tasks on the system
> > > stuck on a single CPU, each task preempted in a migrate_disable()
> > > section with a single high priority task running.
> > >
> > > This way we can still approximate running the M highest priority tasks
> > > on the system.
> > >
> > 
> > Ah, so IIUC that's the important bit that makes it we can't just say go
> > through the pushable_tasks list and skip migrate_disable() tasks.
> > 
> > Once the highest-prio task exits its migrate_disable() region, your patch
> > pushes it away. If we ended up with a single busy CPU, it'll spread the
> > tasks around one migrate_enable() at a time.
> > 
> > That time where the top task is migrate_disable() is still a crappy time,
> > and as you pointed out earlier today if it is a genuine pcpu task then the
> > whole thing is -EBORKED...
> > 
> > An alternative I could see would be to prevent those piles from forming
> > altogether, say by issuing a similar push_cpu_stop() on migrate_disable()
> > if the next pushable task is already migrate_disable(); but that's a
> > proactive approach whereas yours is reactive, so I'm pretty sure that's
> > bound to perform worse.
> 
> I think it is always possible to form pileups. Just start enough tasks
> such that newer, higher priority, tasks have to preempt existing tasks.
> 
> Also, we might not be able to place the task elsewhere, suppose we have
> all our M CPUs filled with an RT task, then when the lowest priority
> task has migrate_disable(), wake the highest priority task.
> 
> Per the SMP invariant, this new highest priority task must preempt the
> lowest priority task currently running, otherwise we would not be
> running the M highest prio tasks.
> 
> That's not to say it might not still be beneficial from trying to avoid
> them, but we must assume a pilup will occur, therefore my focus was on
> dealing with them as best we can first.
> 

