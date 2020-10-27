Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F27CE29AA05
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 11:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1420605AbgJ0Kux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 06:50:53 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35623 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437103AbgJ0Kuw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 06:50:52 -0400
Received: by mail-lj1-f196.google.com with SMTP id x16so1227734ljh.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 03:50:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rX192+5/GCOl6ncQVEemrlnBsQN0DVPaoj5gLLoEIgQ=;
        b=F1ySWpC6wzldOCJDsNatsgn3qsOUclEhK7WZ2iQXkXRJaGCUmA/bdOAzcGrKw6QdAC
         SrQ6s7UHxXORMQkD8dcJsgK7KQBgG0IVG3ymymnYsCZCTMh/PkJOL+dajovJsooztPhD
         Y73sURTACyjS6XZwAWRy1X+hkdbXO9pdiiBZW9GLRXdsA+xI71n6YPKjybi5BALltQzf
         35XdvXFlDli1zQDAJ7deBl2yeuhjs4OJZJPT+cF85GASo4B+6uuW1mbUcxJLi2ojnDnd
         Rjjjj/alX/Ru/6a7maRNgDNcoWev4H+mo0qlCvzp2C8yaQ7t2o7G41brSoTi0NFxC4tA
         HOXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rX192+5/GCOl6ncQVEemrlnBsQN0DVPaoj5gLLoEIgQ=;
        b=SyXYtW/4eLMTl6zsZiCBp57eyOpaMZlsLYTFEH7p5+nswNDEOfB9Zj7DbUDuENeNJw
         +4AaQDhx/G8DN/oh2GQujvTAQVfSUfhHLPprDWSUP2Wqe1ts5uOhCyFfyq2fvJjBsGRy
         MrVapPcbIIpZ9manu+QRvPlLyAEKVH0SXveRrdMtqhExivaId0Dp/DEeSiAeBHxKlZsZ
         5iqIvEPnq7zedv9FfBf+wQ4bMPvfLj0ylkPoTi8oGxj03gTzqhGZId6v/IYCklJIOFfY
         GQCC6k8O6KDbkdXx30ltwivSc4FYatnhCJJ3I2BV7R0JyJ979lj49Zwp0Tj2f3TfNddF
         NK4w==
X-Gm-Message-State: AOAM530HSL9fiDWe2U24935oCM065MPt4q/S93QBIL8bcARnOGM/Glam
        WN2/r3etHErxyHerO2BHpMhAHhG37FoA/jihqj0WF4uYGQM=
X-Google-Smtp-Source: ABdhPJxIWQ8Y6D6pkmW3tMpR9kxLFdxtj74oDzkLgSFgugIxQfpqchIxNmM7P0zq0hp144C0tWd3+ad0nKpphiD+TaI=
X-Received: by 2002:a2e:9a43:: with SMTP id k3mr850315ljj.69.1603795850701;
 Tue, 27 Oct 2020 03:50:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200901144324.1071694-1-maz@kernel.org> <20200901144324.1071694-4-maz@kernel.org>
 <CAKfTPtDjPpri5Gt6kLeFp_B_zJUZ5DYXEqtJ+0VKohU-y9bFEQ@mail.gmail.com>
 <353f13b0dcc6c7ea1b44012d9632a0cc@kernel.org> <CAKfTPtBjw5ay_BcPmEXpHOHbNxNZuYmdCoHQM53u3c+RXnKONg@mail.gmail.com>
 <CAKfTPtBURraZh8E8p3PmncoDRVV5N42yTyJcpPf0OROciM2+xg@mail.gmail.com> <7b754dfe579044902d3468b9f864bd37@kernel.org>
In-Reply-To: <7b754dfe579044902d3468b9f864bd37@kernel.org>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 27 Oct 2020 11:50:39 +0100
Message-ID: <CAKfTPtBQd8LcXAq_TkUx6uY3NGu72RAAftawtHxEqB=18C3D8A@mail.gmail.com>
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

On Tue, 27 Oct 2020 at 11:37, Marc Zyngier <maz@kernel.org> wrote:
>
> On 2020-10-27 10:12, Vincent Guittot wrote:
> > HI Marc,
> >
> > On Mon, 19 Oct 2020 at 17:43, Vincent Guittot
> > <vincent.guittot@linaro.org> wrote:
> >>
> >> On Mon, 19 Oct 2020 at 15:04, Marc Zyngier <maz@kernel.org> wrote:
> >> >
> >
> > ...
> >
> >> > >>
> >> > >> One of the major difference is that we end up, in some cases
> >> > >> (such as when performing IRQ time accounting on the scheduler
> >> > >> IPI), end up with nested irq_enter()/irq_exit() pairs.
> >> > >> Other than the (relatively small) overhead, there should be
> >> > >> no consequences to it (these pairs are designed to nest
> >> > >> correctly, and the accounting shouldn't be off).
> >> > >
> >> > > While rebasing on mainline, I have faced a performance regression for
> >> > > the benchmark:
> >> > > perf bench sched pipe
> >> > > on my arm64 dual quad core (hikey) and my 2 nodes x 112 CPUS (thx2)
> >> > >
> >> > > The regression comes from:
> >> > > commit: d3afc7f12987 ("arm64: Allow IPIs to be handled as normal
> >> > > interrupts")
> >> >
> >> > That's interesting, as this patch doesn't really change anything (most
> >> > of the potential overhead comes in later). The only potential overhead
> >> > I can see is that the scheduler_ipi() call is now wrapped around
> >> > irq_enter()/irq_exit().
> >> >
> >> > >
> >> > >           v5.9              + this patch
> >> > > hikey :   48818(+/- 0.31)   37503(+/- 0.15%)  -23.2%
> >> > > thx2  :  132410(+/- 1.72)  122646(+/- 1.92%)   -7.4%
> >> > >
> >> > > By + this patch,  I mean merging branch from this patch. Whereas
> >> > > merging the previous:
> >> > > commit: 83cfac95c018 ("genirq: Allow interrupts to be excluded from
> >> > > /proc/interrupts")
> >> > >  It doesn't show any regression
> >> >
> >> > Since you are running perf, can you spot where the overhead occurs?
> >
> > Any idea about the root cause of the regression ?
> > I have faced it on more arm64 platforms in the meantime
>
> two possible causes:
>
> (1) irq_enter/exit on the rescheduling IPI means we reschedule much more
> often
> (2) irq_domain lookups add some overhead.
>
> For (1), I have this series[1] which is ugly as sin and needs much more
> testing.

Ok, I'm going to test this series to see if it fixes the perf regression

>
> For (2), I have some ideas which need more work (let the irq domain
> resolve to
> an irq_desc instead of an interrupt number, avoiding another radix-tree
> lookup).
>
>          M.
>
> [1]
> https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/log/?h=irq/ipi-fixes
> --
> Jazz is not dead. It just smells funny...
