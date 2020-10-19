Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E16D292AB0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 17:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730344AbgJSPnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 11:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730025AbgJSPna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 11:43:30 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7648C0613CE
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 08:43:29 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id a7so14730803lfk.9
        for <linux-kernel@vger.kernel.org>; Mon, 19 Oct 2020 08:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XExGzAcdQVZ+Wsl0Ih6yKEGYRJsLil4v2iKvYQXD8O8=;
        b=moaW1E0vHgrFCU56qBl5pxhY6LYq9YuCPprIFZ3cObBUncUN1wPU5tXf1fT5w/2xsI
         ZIO1Y9wYHsLGviMnPKj+i6dniHjtZPUXu7AKr/pPdhUwUpDZ3LZCIelMTE1DXR3TkY55
         aMERY0OrhpJ4zI1lU9QVAK+f8Oa/Djutgs7oEi7b+Mj5I+hCbUxtuqoCWPTAZxApezDb
         9gHCXRH4/GURRHkvYDTKVNMyeY2dO8qKlBqDRIilr2eF84/5aUqqi5Au3MvQ4Zp/losz
         hbtKdJtT6OOFQo+Blh3ivz7Jm/mLH+rufFHzU+KpCr4S1MBqoAVcIpJ6lxt1G9FD4Pky
         W1Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XExGzAcdQVZ+Wsl0Ih6yKEGYRJsLil4v2iKvYQXD8O8=;
        b=rb3US2L+QNRBGZFi3tATaEGpvZoVLnRp02TrarVy9+tT9ELZy4v4z8HRhCPIsY9ULJ
         BMLlYIZSAGz1Z7xBC4LZ5Ari0u41VMtAN7XHGzHmAanbdd7XKY1sD7BR6Dr4b49ZKxzt
         qgQnY3rTxMb20ZxrIjvQfigkjiRdRJKYGZtG85Bxi9BuyyESk5VI1xP49iiwXtQs6QYS
         8xg/J/dh6qah06LwCdkBmAWzYiUi91OUYAAq76AB9fUKCeK7gvP8Q5aEZpGvrF58xYVl
         xvKtqc1KvGnexq1qjCiOGSPVgMEN2XrnTe8fOL1ZtNGBzik/VkSSjjhRy3uKXFgrv9Xc
         O9wg==
X-Gm-Message-State: AOAM533qsUewtLLQ0Nt2r+GOiIJt9ZS+mrkox6nHizsfKqfrw1BDUZ1n
        HKF94hN/puGOvayrX3L3v4fQ8nMZ0eUEo8xp6CT4yw==
X-Google-Smtp-Source: ABdhPJyyEHCGeedlETa86EdcrbjLr0FuCnBU+As+mylycg6aD5k+hzMdjO1OPT2oZ/S4w0/q9F8B5ncFxf2jTx3yLo8=
X-Received: by 2002:ac2:5a4f:: with SMTP id r15mr113032lfn.258.1603122208344;
 Mon, 19 Oct 2020 08:43:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200901144324.1071694-1-maz@kernel.org> <20200901144324.1071694-4-maz@kernel.org>
 <CAKfTPtDjPpri5Gt6kLeFp_B_zJUZ5DYXEqtJ+0VKohU-y9bFEQ@mail.gmail.com> <353f13b0dcc6c7ea1b44012d9632a0cc@kernel.org>
In-Reply-To: <353f13b0dcc6c7ea1b44012d9632a0cc@kernel.org>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 19 Oct 2020 17:43:16 +0200
Message-ID: <CAKfTPtBjw5ay_BcPmEXpHOHbNxNZuYmdCoHQM53u3c+RXnKONg@mail.gmail.com>
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

On Mon, 19 Oct 2020 at 15:04, Marc Zyngier <maz@kernel.org> wrote:
>
> Hi Vincent,
>
> On 2020-10-19 13:42, Vincent Guittot wrote:
> > Hi Marc,
> >
> > On Tue, 1 Sep 2020 at 16:44, Marc Zyngier <maz@kernel.org> wrote:
> >>
> >> In order to deal with IPIs as normal interrupts, let's add
> >> a new way to register them with the architecture code.
> >>
> >> set_smp_ipi_range() takes a range of interrupts, and allows
> >> the arch code to request them as if the were normal interrupts.
> >> A standard handler is then called by the core IRQ code to deal
> >> with the IPI.
> >>
> >> This means that we don't need to call irq_enter/irq_exit, and
> >> that we don't need to deal with set_irq_regs either. So let's
> >> move the dispatcher into its own function, and leave handle_IPI()
> >> as a compatibility function.
> >>
> >> On the sending side, let's make use of ipi_send_mask, which
> >> already exists for this purpose.
> >>
> >> One of the major difference is that we end up, in some cases
> >> (such as when performing IRQ time accounting on the scheduler
> >> IPI), end up with nested irq_enter()/irq_exit() pairs.
> >> Other than the (relatively small) overhead, there should be
> >> no consequences to it (these pairs are designed to nest
> >> correctly, and the accounting shouldn't be off).
> >
> > While rebasing on mainline, I have faced a performance regression for
> > the benchmark:
> > perf bench sched pipe
> > on my arm64 dual quad core (hikey) and my 2 nodes x 112 CPUS (thx2)
> >
> > The regression comes from:
> > commit: d3afc7f12987 ("arm64: Allow IPIs to be handled as normal
> > interrupts")
>
> That's interesting, as this patch doesn't really change anything (most
> of the potential overhead comes in later). The only potential overhead
> I can see is that the scheduler_ipi() call is now wrapped around
> irq_enter()/irq_exit().
>
> >
> >           v5.9              + this patch
> > hikey :   48818(+/- 0.31)   37503(+/- 0.15%)  -23.2%
> > thx2  :  132410(+/- 1.72)  122646(+/- 1.92%)   -7.4%
> >
> > By + this patch,  I mean merging branch from this patch. Whereas
> > merging the previous:
> > commit: 83cfac95c018 ("genirq: Allow interrupts to be excluded from
> > /proc/interrupts")
> >  It doesn't show any regression
>
> Since you are running perf, can you spot where the overhead occurs?

hmm... Difficult to say because tracing the bench decreases a lot the
result. I have pasted the perf reports.

With this patch :

# Samples: 634  of event 'cpu-clock'
# Event count (approx.): 158500000
#
# Overhead  Command     Shared Object       Symbol
# ........  ..........  ..................  ..................................
#
    31.86%  sched-pipe  [kernel.kallsyms]   [k] _raw_spin_unlock_irqrestore
     8.68%  sched-pipe  [kernel.kallsyms]   [k] _raw_spin_unlock_irq
     6.31%  sched-pipe  [kernel.kallsyms]   [k] __schedule
     5.21%  sched-pipe  [kernel.kallsyms]   [k] schedule
     4.73%  sched-pipe  [kernel.kallsyms]   [k] pipe_read
     3.31%  sched-pipe  [kernel.kallsyms]   [k] el0_svc_common.constprop.3
     2.84%  sched-pipe  [kernel.kallsyms]   [k] ww_mutex_lock_interruptible
     2.52%  sched-pipe  [kernel.kallsyms]   [k] init_wait_entry
     2.37%  sched-pipe  [kernel.kallsyms]   [k] mutex_unlock
     2.21%  sched-pipe  [kernel.kallsyms]   [k] new_sync_read
     1.89%  sched-pipe  [kernel.kallsyms]   [k] new_sync_write
     1.74%  sched-pipe  [kernel.kallsyms]   [k] security_file_permission
     1.74%  sched-pipe  [kernel.kallsyms]   [k] vfs_read
     1.58%  sched-pipe  [kernel.kallsyms]   [k] __my_cpu_offset
     1.26%  sched-pipe  libpthread-2.24.so  [.] 0x0000000000010a2c
     1.10%  sched-pipe  [kernel.kallsyms]   [k] mutex_lock
     1.10%  sched-pipe  [kernel.kallsyms]   [k] vfs_write

After reverting this patch which gives a result similar to v5.9:

# Samples: 659  of event 'cpu-clock'
# Event count (approx.): 164750000
#
# Overhead  Command     Shared Object       Symbol
# ........  ..........  ..................  ...............................
#
    29.29%  sched-pipe  [kernel.kallsyms]   [k] _raw_spin_unlock_irqrestore
    21.40%  sched-pipe  [kernel.kallsyms]   [k] _raw_spin_unlock_irq
     4.86%  sched-pipe  [kernel.kallsyms]   [k] pipe_read
     4.55%  sched-pipe  [kernel.kallsyms]   [k] ww_mutex_lock_interruptible
     2.88%  sched-pipe  [kernel.kallsyms]   [k] __schedule
     2.88%  sched-pipe  [kernel.kallsyms]   [k] _raw_spin_lock_irqsave
     2.88%  sched-pipe  [kernel.kallsyms]   [k] schedule
     2.12%  sched-pipe  [kernel.kallsyms]   [k] new_sync_read
     1.82%  sched-pipe  [kernel.kallsyms]   [k] mutex_lock
     1.67%  sched-pipe  [kernel.kallsyms]   [k] el0_svc_common.constprop.3
     1.67%  sched-pipe  [kernel.kallsyms]   [k] pipe_write
     1.21%  sched-pipe  [kernel.kallsyms]   [k] rw_verify_area
     1.21%  sched-pipe  [kernel.kallsyms]   [k] security_file_permission
     1.06%  sched-pipe  [kernel.kallsyms]   [k] fsnotify

I have only put symbol with overhead above 1%

so _raw_spin_unlock_irq, schedule and __schedule seem the most
impacted but i can't get any conclusion

I can sent you perf.data files if you want


>
> Thanks,
>
>          M.
> --
> Jazz is not dead. It just smells funny...
