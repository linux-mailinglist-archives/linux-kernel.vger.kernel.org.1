Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F02B129A943
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 11:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2897544AbgJ0KMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 06:12:30 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:35334 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2410273AbgJ0KMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 06:12:30 -0400
Received: by mail-lj1-f194.google.com with SMTP id x16so1106259ljh.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 03:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dTr1fRNpMHLfo9uIYu1a+qbqidfQRtOS2wMyDIXIvoE=;
        b=BnMvVGUtISR8eqgnBBm4s0BIzk596JFtPDSSolBC6bDuoUKMYvpwArBvvDW1VAtr82
         VyJoB78YGt/U3DSo2gSWHW0rM0GDiaoVbOPxPqI+nMy3Bbt//S4SID2i9oQvzfsxuFSl
         Yxgl67TNa7GzNpEoeqe76ohQa0Is2liDfZVhG++U1hja9QkWURRSeFRpkkYhPqZXS3QC
         yoIk+s8SZBMTzr24AWNyM4gOfxvia5sn5qz7wB7kACBiULNB/Hi/VWBylbHJxZf7mj9L
         wUUT8PuCihNAcpRSr0nH204BG5pHGD5W0U97BfNDUgLUBGKxh5r5PYWEQuRFz0ayJhSP
         HVxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dTr1fRNpMHLfo9uIYu1a+qbqidfQRtOS2wMyDIXIvoE=;
        b=Nws5vHRoT213AkO2w+cft+9YXi5YcESrFhGSL8wY2dWnQePPCFgIDtSl3zl0I7Hfbb
         oC1IlNIszM8pdwpfpSArhufWgtyWPqRoBYB4+GMWe2kLuYgDJToTUAFmRUDHTp53fHw7
         p8hKopWAVA8SM0+EYCnhlAxpYgg7ijCG8Fos6tvpl2avwOwNwrhKxzKvajMOj5+we35v
         b8TF9DZMOORoivlVgJfSP9Josp1PG4+hUc07/T4MaqOFZvZK1GyODUXxLR7oG4dXNnLB
         eKSH4Rl1K2angFYCy5G89jmaCqlhq1ZyU+gL3hsDVSil/ydBn9noiLWvPnfDIBClOopD
         reug==
X-Gm-Message-State: AOAM533x88jrkH8M/a6FXKLNFCPiRlAF3dVsM5UoG8mTTP2+ooElV2HO
        srZS/QK27as5KcMjHsbmmnG+iETDHnkEhyeEKcD6lw==
X-Google-Smtp-Source: ABdhPJwZu6Mlmed4WNhA0+IUgd4LmRv8kJeCiPXaIDVoDKbkyRks4xZ9NM/Q22NkbeWIaiNW6gnzaJASJrnN/IRitU4=
X-Received: by 2002:a2e:b0fc:: with SMTP id h28mr796995ljl.226.1603793546565;
 Tue, 27 Oct 2020 03:12:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200901144324.1071694-1-maz@kernel.org> <20200901144324.1071694-4-maz@kernel.org>
 <CAKfTPtDjPpri5Gt6kLeFp_B_zJUZ5DYXEqtJ+0VKohU-y9bFEQ@mail.gmail.com>
 <353f13b0dcc6c7ea1b44012d9632a0cc@kernel.org> <CAKfTPtBjw5ay_BcPmEXpHOHbNxNZuYmdCoHQM53u3c+RXnKONg@mail.gmail.com>
In-Reply-To: <CAKfTPtBjw5ay_BcPmEXpHOHbNxNZuYmdCoHQM53u3c+RXnKONg@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 27 Oct 2020 11:12:15 +0100
Message-ID: <CAKfTPtBURraZh8E8p3PmncoDRVV5N42yTyJcpPf0OROciM2+xg@mail.gmail.com>
Subject: Re: [PATCH v3 03/16] arm64: Allow IPIs to be handled as normal interrupts
To:     Marc Zyngier <maz@kernel.org>
Cc:     LAK <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Russell King <linux@arm.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Sumit Garg <sumit.garg@linaro.org>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Saravana Kannan <saravanak@google.com>,
        Android Kernel Team <kernel-team@android.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Marc,

On Mon, 19 Oct 2020 at 17:43, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Mon, 19 Oct 2020 at 15:04, Marc Zyngier <maz@kernel.org> wrote:
> >

...

> > >>
> > >> One of the major difference is that we end up, in some cases
> > >> (such as when performing IRQ time accounting on the scheduler
> > >> IPI), end up with nested irq_enter()/irq_exit() pairs.
> > >> Other than the (relatively small) overhead, there should be
> > >> no consequences to it (these pairs are designed to nest
> > >> correctly, and the accounting shouldn't be off).
> > >
> > > While rebasing on mainline, I have faced a performance regression for
> > > the benchmark:
> > > perf bench sched pipe
> > > on my arm64 dual quad core (hikey) and my 2 nodes x 112 CPUS (thx2)
> > >
> > > The regression comes from:
> > > commit: d3afc7f12987 ("arm64: Allow IPIs to be handled as normal
> > > interrupts")
> >
> > That's interesting, as this patch doesn't really change anything (most
> > of the potential overhead comes in later). The only potential overhead
> > I can see is that the scheduler_ipi() call is now wrapped around
> > irq_enter()/irq_exit().
> >
> > >
> > >           v5.9              + this patch
> > > hikey :   48818(+/- 0.31)   37503(+/- 0.15%)  -23.2%
> > > thx2  :  132410(+/- 1.72)  122646(+/- 1.92%)   -7.4%
> > >
> > > By + this patch,  I mean merging branch from this patch. Whereas
> > > merging the previous:
> > > commit: 83cfac95c018 ("genirq: Allow interrupts to be excluded from
> > > /proc/interrupts")
> > >  It doesn't show any regression
> >
> > Since you are running perf, can you spot where the overhead occurs?

Any idea about the root cause of the regression ?
I have faced it on more arm64 platforms in the meantime

>
> hmm... Difficult to say because tracing the bench decreases a lot the
> result. I have pasted the perf reports.
>
> With this patch :
>
> # Samples: 634  of event 'cpu-clock'
> # Event count (approx.): 158500000
> #
> # Overhead  Command     Shared Object       Symbol
> # ........  ..........  ..................  ..................................
> #
>     31.86%  sched-pipe  [kernel.kallsyms]   [k] _raw_spin_unlock_irqrestore
>      8.68%  sched-pipe  [kernel.kallsyms]   [k] _raw_spin_unlock_irq
>      6.31%  sched-pipe  [kernel.kallsyms]   [k] __schedule
>      5.21%  sched-pipe  [kernel.kallsyms]   [k] schedule
>      4.73%  sched-pipe  [kernel.kallsyms]   [k] pipe_read
>      3.31%  sched-pipe  [kernel.kallsyms]   [k] el0_svc_common.constprop.3
>      2.84%  sched-pipe  [kernel.kallsyms]   [k] ww_mutex_lock_interruptible
>      2.52%  sched-pipe  [kernel.kallsyms]   [k] init_wait_entry
>      2.37%  sched-pipe  [kernel.kallsyms]   [k] mutex_unlock
>      2.21%  sched-pipe  [kernel.kallsyms]   [k] new_sync_read
>      1.89%  sched-pipe  [kernel.kallsyms]   [k] new_sync_write
>      1.74%  sched-pipe  [kernel.kallsyms]   [k] security_file_permission
>      1.74%  sched-pipe  [kernel.kallsyms]   [k] vfs_read
>      1.58%  sched-pipe  [kernel.kallsyms]   [k] __my_cpu_offset
>      1.26%  sched-pipe  libpthread-2.24.so  [.] 0x0000000000010a2c
>      1.10%  sched-pipe  [kernel.kallsyms]   [k] mutex_lock
>      1.10%  sched-pipe  [kernel.kallsyms]   [k] vfs_write
>
> After reverting this patch which gives a result similar to v5.9:
>
> # Samples: 659  of event 'cpu-clock'
> # Event count (approx.): 164750000
> #
> # Overhead  Command     Shared Object       Symbol
> # ........  ..........  ..................  ...............................
> #
>     29.29%  sched-pipe  [kernel.kallsyms]   [k] _raw_spin_unlock_irqrestore
>     21.40%  sched-pipe  [kernel.kallsyms]   [k] _raw_spin_unlock_irq
>      4.86%  sched-pipe  [kernel.kallsyms]   [k] pipe_read
>      4.55%  sched-pipe  [kernel.kallsyms]   [k] ww_mutex_lock_interruptible
>      2.88%  sched-pipe  [kernel.kallsyms]   [k] __schedule
>      2.88%  sched-pipe  [kernel.kallsyms]   [k] _raw_spin_lock_irqsave
>      2.88%  sched-pipe  [kernel.kallsyms]   [k] schedule
>      2.12%  sched-pipe  [kernel.kallsyms]   [k] new_sync_read
>      1.82%  sched-pipe  [kernel.kallsyms]   [k] mutex_lock
>      1.67%  sched-pipe  [kernel.kallsyms]   [k] el0_svc_common.constprop.3
>      1.67%  sched-pipe  [kernel.kallsyms]   [k] pipe_write
>      1.21%  sched-pipe  [kernel.kallsyms]   [k] rw_verify_area
>      1.21%  sched-pipe  [kernel.kallsyms]   [k] security_file_permission
>      1.06%  sched-pipe  [kernel.kallsyms]   [k] fsnotify
>
> I have only put symbol with overhead above 1%
>
> so _raw_spin_unlock_irq, schedule and __schedule seem the most
> impacted but i can't get any conclusion
>
> I can sent you perf.data files if you want
>
>
> >
> > Thanks,
> >
> >          M.
> > --
> > Jazz is not dead. It just smells funny...
