Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 800A32F8E00
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jan 2021 18:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726780AbhAPRKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jan 2021 12:10:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728339AbhAPRKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jan 2021 12:10:37 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78DD0C06135E
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jan 2021 08:14:46 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id u17so24322807iow.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jan 2021 08:14:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ee2WNqGNvbcVmc69Zvx/j7MrYt0u8UOawahie9yb7f4=;
        b=PrEWV6kr1XyrHNJFa7YNo2pBPPiD6xd+D06HRc6JgcjkHQCjtIgjgCdupgOXBw0VCQ
         MwfAFgbIBlIbdPJihZgaOl+AHyMUnl6GXTexuiM8ebHb273mTFcIRGoHf5hyiTTZkFfN
         FGVul0vvzdOqWNzQXqkEvMIQ6VkchpudBr7XY+jnUp9V4IPP6K89Mo+2BOCLcSQUHggK
         +ju9AZTVZfpnZv/Jj6tQUvV4nGjSgzbGFDYpNdn7Z09vvjVa01cfZpHD1Oto6aSG/hrR
         eY3S4TvZXnkpLebWQwjozJ2gWcuPP0dHOt7p4ALn0aexDwN//6/EOJAGNyaIhE/97ZyH
         jWTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ee2WNqGNvbcVmc69Zvx/j7MrYt0u8UOawahie9yb7f4=;
        b=QaZJ9gDLiK6JCLCk6CCT6izEV2tb9HHyMv5vdpQcZJw2EJJx1WsfNuvMmWLAhJO9Yf
         SUKIMBdlFLmfVfV+CcNlyWOMwocpZ4n0rHJ1sBo3X5s7vrxDPDtW79XVm/AYqyldggYr
         VdczKp58wRtLY9daLPQQXsqG5FjqDdWHxaMIf1qBGxQbL6vQUmbdptlGGbPV69I+C5qN
         V4BCkdMVr+BxRtx3ViODajo3ghD3Ll1XOOSTFlpjGggjIlOrxPv3ME3HD7ToTdSZ+DFy
         7dyfarD4i0dNEx5inrN3FLVrCXyj/OeMww9pGYiiOkdI5FC9bGdCjDygAYGoNvqWKXcb
         5W1Q==
X-Gm-Message-State: AOAM532XThtc9bp5S9aavPLRx8RKeK5Qy2P0C5fIsFVjFdbPWFX5AdcV
        rvxvkMd2rupWgX4RfjLirrrZnoOa8/5TaMNfCa8=
X-Google-Smtp-Source: ABdhPJzm7UAoZ7rktA+SBFMrZYGVB7ycmqTUR5CXM/0YBlIUw8ef92QJgNexLp0/sasANmsOealOtsSSPJprDFwyhmY=
X-Received: by 2002:a5d:8c85:: with SMTP id g5mr12226334ion.154.1610813685872;
 Sat, 16 Jan 2021 08:14:45 -0800 (PST)
MIME-Version: 1.0
References: <20210112144344.850850975@infradead.org> <20210112144843.849135905@infradead.org>
 <CAJhGHyD_xuSpYOp5A9PumWGsBA=DNqM0ge3_NgRkfro7fafGqA@mail.gmail.com>
 <YABDI6Qkp5PNslUS@hirez.programming.kicks-ass.net> <jhjlfcvhcx5.mognet@arm.com>
 <YABknAqDe4h35+GY@hirez.programming.kicks-ass.net> <CAJhGHyBazDix9tLTV0HnobeSzneUK8Y9GKf6AgXspf=c9O5dhQ@mail.gmail.com>
 <YALf4xDwTKCERPbf@hirez.programming.kicks-ass.net> <CAJhGHyDT2FWsn15-_DQ4b_bkrRi74MzNnWt7YWTO49cSv4yjbg@mail.gmail.com>
 <YAMDUQ7JX2Fr8D+/@hirez.programming.kicks-ass.net>
In-Reply-To: <YAMDUQ7JX2Fr8D+/@hirez.programming.kicks-ass.net>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Sun, 17 Jan 2021 00:14:34 +0800
Message-ID: <CAJhGHyBKexR+UmR2Hzf-OU9_9zfc0V6r=s2rS=N8sc+2VnN3mw@mail.gmail.com>
Subject: Re: [PATCH 3/4] workqueue: Tag bound workers with KTHREAD_IS_PER_CPU
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, Qian Cai <cai@redhat.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Dexuan Cui <decui@microsoft.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>, Tejun Heo <tj@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 16, 2021 at 11:16 PM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Sat, Jan 16, 2021 at 10:45:04PM +0800, Lai Jiangshan wrote:
> > On Sat, Jan 16, 2021 at 8:45 PM Peter Zijlstra <peterz@infradead.org> wrote:
> > > It is also the exact sequence normal per-cpu threads (smpboot) use to
> > > preserve affinity.
> >
> > Other per-cpu threads normally do short-live works. wq's work can be
> > lengthy, cpu-intensive, heavy-lock-acquiring or even call
> > get_online_cpus() which might result in a deadlock with kthread_park().
>
> kthread_park() is called by the migration thread running the
> workqueue_online_cpu() callback.
>
> kthread_parkme() is called by the worker thread, after it completes a
> work and has no locks held from that context.
>
>

BP:                 AP:                  worker:
cpus_write_lock()
bringup_cpu()                            work_item_func()
  bringup_wait_for_ap                      get_online_cpus()
                    kthread_park(worker)
