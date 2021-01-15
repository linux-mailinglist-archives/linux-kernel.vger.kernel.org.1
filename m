Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D4412F84CB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jan 2021 19:53:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387816AbhAOSxn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jan 2021 13:53:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:53080 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726065AbhAOSxn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jan 2021 13:53:43 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 51804238D7
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 18:53:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610736782;
        bh=eBPMgkqdNGN5q0VLCx1BXi45hrDcP5DmDltyPgSUakE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=CJMSSEoRS81MJc5sec3sQxOi1Iq4OOnq7+wE5ZHHwFsV2udTj2vdWe5430MR5Q/JL
         WK2UU6BtaNckbrPX4RqQkRU797Oq/iUd7w1RSfKKpWguHMtP5E6XVJkTlZYhnJ5nY4
         sHTFJDOPpCWaRNoHisPpdr8G+3LcUEqRF+2w+l9V12OFC/1Z4HTajfz5BqGR8pHtdp
         eq/YjcHmarmUknmYn/pjwTrhwFuZo37mAn79p1yyudDsiH8NUPh6WT6SmUWf2Tah32
         C8CuduG/z3+Q2xDwEGMfzbbl/KrnrPSGk6pBPTkYAIS9IX0dtqdD/kOtP92wfdi3Np
         U3PEI6WHdIqXg==
Received: by mail-ed1-f48.google.com with SMTP id by27so10654043edb.10
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jan 2021 10:53:02 -0800 (PST)
X-Gm-Message-State: AOAM532lNfqjJ9UWGZjG7UOtHObKgR2iloO3zPczoo3Z3L+FegEjxHGg
        lCPdRrL/9hv4qFf1fmtekfc42FAkMAKsGB6XMt0H2A==
X-Google-Smtp-Source: ABdhPJynrYlEzsGeJwo+4L8uJID8hyP5P3NnjxakIf4SVRJAP698dPyCd6HLEmUXDG1L6OMWYIHZ00rnNww4eH09O1s=
X-Received: by 2002:a05:6402:1d3b:: with SMTP id dh27mr11106606edb.238.1610736780889;
 Fri, 15 Jan 2021 10:53:00 -0800 (PST)
MIME-Version: 1.0
References: <20210115180733.5663-1-marco.faltelli@uniroma2.it>
In-Reply-To: <20210115180733.5663-1-marco.faltelli@uniroma2.it>
From:   Andy Lutomirski <luto@kernel.org>
Date:   Fri, 15 Jan 2021 10:52:49 -0800
X-Gmail-Original-Message-ID: <CALCETrWfnL=3M3nmmHs-a3si5JptSCtF6cEtHVtsDNwA5mHnRg@mail.gmail.com>
Message-ID: <CALCETrWfnL=3M3nmmHs-a3si5JptSCtF6cEtHVtsDNwA5mHnRg@mail.gmail.com>
Subject: Re: [PATCH] kernel/time: Add hr_sleep syscall, a high-resolution
 sleep service
To:     Marco Faltelli <marco.faltelli@uniroma2.it>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 10:14 AM Marco Faltelli
<marco.faltelli@uniroma2.it> wrote:
>
> hr_sleep is a new system call engineered for nanosecond time scale
> granularities.
> With respect to nanosleep, it uses a single value representation
> of the sleep period.
> hr_sleep achieves 15x improvement for microsecond scale timers
> w.r.t. nanosleep:

You need to explain what 15x means.

> +/**
> + * hr_sleep - a high-resolution sleep service for fine-grained timeouts
> + * @nanoseconds:       the requested sleep period in nanoseconds
> + *
> + * Returns:
> + * 0 when the sleep request successfully terminated
> + * -EINVAL if a sleep period < 0 is requested
> + */
> +SYSCALL_DEFINE1(hr_sleep, long, nanoseconds)
> +{
> +       DECLARE_WAIT_QUEUE_HEAD(the_queue);//here we use a private queue
> +       control_record *control;
> +       ktime_t ktime_interval;
> +
> +       if (nanoseconds < 0)
> +               return -EINVAL;
> +
> +       if (nanoseconds == 0)
> +               return 0;
> +
> +       ktime_interval = ktime_set(0, nanoseconds);
> +       control = (control_record *)((void *) current->stack + sizeof(struct thread_info));

What is this trying to do other than writing to memory you don't own?

In C, the way you create a structure on the stack is:

struct control_record control;

done, problem solved.  (Also, on modern kernels, thread_info is not on
the stack, so your arithmetic makes no sense.

> +       wait_event_interruptible(the_queue, control->awake == 1);

Once you start checking the return value (which is absolutely
necessary), you will discover that you need to do something sensible
when the return value is nonzero.  At that point you will start
contemplating how to restart an interrupted wait, and you will have to
consider the merits of absolute vs relative timeouts and you might
discover that the complexity of nanosleep(2) is not an accident.

Sure, the seconds/nanoseconds split in nanosleep(2) is probably not
ideal, and a better API could probably be designed, but your hr_sleep
needs a lot of work to cover all the cases.


--Andy
