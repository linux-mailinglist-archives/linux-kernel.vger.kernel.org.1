Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44C9226C7ED
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 20:36:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbgIPSgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 14:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728074AbgIPS3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 14:29:13 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E175C035434
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 05:04:34 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id d15so6657331lfq.11
        for <linux-kernel@vger.kernel.org>; Wed, 16 Sep 2020 05:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z06F5xs8rOeFbMpImAz4XH2OtRkrnuxG8td3c2+DORY=;
        b=G0guapgKGXfsR56yg5UXFtPAfwtlgpf1PB0JgI5nlwwS1uc3vr1LzbuJm51wuX8E0u
         IPiG5wTyhPfiRzanaVY8jkB/smVSiMRounukFkEtLu2Oz1TickegTdpiEv2T7nX9Y0wB
         m9i3LOhWt7GTodEBDOGCoLejrlquqp8I/R2rjKHOfDHYgXAiKmUNWZ0HRXyCAns0k9g8
         bIfqHZgIOgkG62B4wpSRFZPo9+fGHsqO41BZGVl9NhDpM/T3aL1l9ITgSNXXz68nK+mV
         0LHWhUlQAOBM9M9kakNLu9c6IVlOEi7tjgYTQBZEpFGl6q54EIryzobWSCWpK+NqbDDR
         LHdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z06F5xs8rOeFbMpImAz4XH2OtRkrnuxG8td3c2+DORY=;
        b=F+t67Q1UHyCGaO9VTR9QHQgK2byzyhRcYoEDz0yuONaQTdDNmlRT1omr7usaX/0w3a
         PdtOLO1bMBFp96za5M2aX+gYpvAUt8XmmX0Yy5Bi3mgD3sQyI9dYkQ6XtsU2ykb9WiKY
         rBIgWalarO/3rdDNU2gYKlD1M7h+US6mEUkcXbNyCpxgOiVLoq77RuHdO4sUoYesiduU
         D+0owJpSzECdmDQGdBMxG171/o/v7kB7bWtmnH1WtNA74ioPf1c5Irw4VSjEsiYOn73q
         XtjH5tLjfXJeQaVaY8I3HSb5z3lPla1izVGiUcHp9mIWUDbooxJBNM+0+k658dNnLZjn
         u9eg==
X-Gm-Message-State: AOAM531sH7YHew5pvbjTb1/ZywUb/tNY+Siw9HpYiURyhHPEe2Fe0QEb
        laOA0tIs/ll1VtX326HGeuQLWvEYiNSbtNw1/oYIHw==
X-Google-Smtp-Source: ABdhPJwsA2eWrqx7yOZZyshlq1TzXR1oYTzFvBQx4tEyST+vmICSOx+qsj/iBqp4t8fKFGK464wnZ0sM3o1PTFlh9UE=
X-Received: by 2002:ac2:43c2:: with SMTP id u2mr7338318lfl.573.1600257872742;
 Wed, 16 Sep 2020 05:04:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200916043103.606132-1-aubrey.li@linux.intel.com> <20200916110039.GG3117@suse.de>
In-Reply-To: <20200916110039.GG3117@suse.de>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 16 Sep 2020 14:04:20 +0200
Message-ID: <CAKfTPtAD59oRG2PWxu=Xme4ak1JaZXwb_iK6nnfPbhNEr9JgyQ@mail.gmail.com>
Subject: Re: [RFC PATCH v2] sched/fair: select idle cpu from idle cpumask in
 sched domain
To:     Mel Gorman <mgorman@suse.de>
Cc:     Aubrey Li <aubrey.li@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Qais Yousef <qais.yousef@arm.com>,
        Jiang Biao <benbjiang@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Sep 2020 at 13:00, Mel Gorman <mgorman@suse.de> wrote:
>
> On Wed, Sep 16, 2020 at 12:31:03PM +0800, Aubrey Li wrote:
> > Added idle cpumask to track idle cpus in sched domain. When a CPU
> > enters idle, its corresponding bit in the idle cpumask will be set,
> > and when the CPU exits idle, its bit will be cleared.
> >
> > When a task wakes up to select an idle cpu, scanning idle cpumask
> > has low cost than scanning all the cpus in last level cache domain,
> > especially when the system is heavily loaded.
> >
> > The following benchmarks were tested on a x86 4 socket system with
> > 24 cores per socket and 2 hyperthreads per core, total 192 CPUs:
> >
>
> This still appears to be tied to turning the tick off. An idle CPU
> available for computation does not necessarily have the tick turned off
> if it's for short periods of time. When nohz is disabled or a machine is
> active enough that CPUs are not disabling the tick, select_idle_cpu may
> fail to select an idle CPU and instead stack tasks on the old CPU.
>
> The other subtlety is that select_idle_sibling() currently allows a
> SCHED_IDLE cpu to be used as a wakeup target. The CPU is not really
> idle as such, it's simply running a low priority task that is suitable
> for preemption. I suspect this patch breaks that.

Yes, good point. I completely missed this

>
> --
> Mel Gorman
> SUSE Labs
