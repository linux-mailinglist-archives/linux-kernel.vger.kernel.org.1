Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB6CE29AA72
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 12:22:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1421929AbgJ0LVl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 07:21:41 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:35518 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437445AbgJ0LVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 07:21:41 -0400
Received: by mail-lj1-f196.google.com with SMTP id x16so1328946ljh.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 04:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g8CUsQ2yUJu8CurUQHCJF02okEAEF4eL111lZlhYJq0=;
        b=CB1mqX1vdG0vm4aE7gYASyyAlu4pbIO2XfL+LldbcAHPMK78HGEzCXTuGVg+QDUJAP
         rJhfFe1wBY4wbywe2xLsFFcL68vecWysE8GQcEWuMhFBOTEdJHd2+OPBO0f+kZ9EoKwM
         KWALE766VnxMoTD4eBYYiwOMNdisxMpxoCQopfb0RAGMbdkAGlFEaKP7fYOY38PzncGv
         bSvjdydIRSarEsNT9TDMnXG92pNHTQ29V1r921PehP2Yk+Qi6lXNJFt95bKunXWz31Zv
         b7NPXOKHhA240kn9NHVGcBlFGtoF0qb/75bVqUBJyX9qErR7iPPwumI8eXX3vQUxL0Uq
         /THQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g8CUsQ2yUJu8CurUQHCJF02okEAEF4eL111lZlhYJq0=;
        b=ORL29GubFxZg6yRUDiMxl2DTruKDBCkIbLOiiqdVWWJZtWZkghfm3LFO+GbSK2Wh/m
         mizAewpRhzrqNm07tujRF64jRJoL5Pp7KULGyPIwtavzs9+hKaPppQ0DNNtXsuaQyYSz
         WQ/fex3Lj6/BXSVxhOTFFUqEJZOjPQU6rxN2CrXViFfSDi4F7TYf6WcVU6XOBA1MaBGb
         +hchi/yjeS54lyJoZY+spM+60nnndc/5efS1/cUXAnUTc6fs6iEi7ocMGKagxWluKFIB
         /nH2cMsZF91lB1j8mrmj9J0heD7vVozliRBbK1/US3D5tJT+jiPRbGw4w1PZGLxYo2y4
         N3dg==
X-Gm-Message-State: AOAM5320Fe95c/0+J4mxRxuH47IZ2hZ5r2xJ8D/0ZPKR6YPISMHFIMHM
        SOnrfLlEWkiiw0epD6enAPI1IWLFXDbKOXRI5YgN8Q==
X-Google-Smtp-Source: ABdhPJzze0z50qsFDnc3eDqzYtUvpifrdynE/dnuFUndYS4181J7hAwm8wzBYqMPTCG1xd2eP++7sp04nlLLM4iLTgQ=
X-Received: by 2002:a05:651c:11d2:: with SMTP id z18mr834491ljo.423.1603797698491;
 Tue, 27 Oct 2020 04:21:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200901144324.1071694-1-maz@kernel.org> <20200901144324.1071694-4-maz@kernel.org>
 <CAKfTPtDjPpri5Gt6kLeFp_B_zJUZ5DYXEqtJ+0VKohU-y9bFEQ@mail.gmail.com>
 <353f13b0dcc6c7ea1b44012d9632a0cc@kernel.org> <CAKfTPtBjw5ay_BcPmEXpHOHbNxNZuYmdCoHQM53u3c+RXnKONg@mail.gmail.com>
 <CAKfTPtBURraZh8E8p3PmncoDRVV5N42yTyJcpPf0OROciM2+xg@mail.gmail.com>
 <7b754dfe579044902d3468b9f864bd37@kernel.org> <CAKfTPtBQd8LcXAq_TkUx6uY3NGu72RAAftawtHxEqB=18C3D8A@mail.gmail.com>
In-Reply-To: <CAKfTPtBQd8LcXAq_TkUx6uY3NGu72RAAftawtHxEqB=18C3D8A@mail.gmail.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 27 Oct 2020 12:21:27 +0100
Message-ID: <CAKfTPtAfaTFXT5seyia=qwpX0BB7e6VpGo5iSYbF0JZwmC1nWg@mail.gmail.com>
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

On Tue, 27 Oct 2020 at 11:50, Vincent Guittot
<vincent.guittot@linaro.org> wrote:
>
> On Tue, 27 Oct 2020 at 11:37, Marc Zyngier <maz@kernel.org> wrote:
> >
> > On 2020-10-27 10:12, Vincent Guittot wrote:
> > > HI Marc,
> > >
> > > On Mon, 19 Oct 2020 at 17:43, Vincent Guittot
> > > <vincent.guittot@linaro.org> wrote:
> > >>
> > >> On Mon, 19 Oct 2020 at 15:04, Marc Zyngier <maz@kernel.org> wrote:
> > >> >
> > >
> > > ...
> > >
> > >> > >>
> > >> > >> One of the major difference is that we end up, in some cases
> > >> > >> (such as when performing IRQ time accounting on the scheduler
> > >> > >> IPI), end up with nested irq_enter()/irq_exit() pairs.
> > >> > >> Other than the (relatively small) overhead, there should be
> > >> > >> no consequences to it (these pairs are designed to nest
> > >> > >> correctly, and the accounting shouldn't be off).
> > >> > >
> > >> > > While rebasing on mainline, I have faced a performance regression for
> > >> > > the benchmark:
> > >> > > perf bench sched pipe
> > >> > > on my arm64 dual quad core (hikey) and my 2 nodes x 112 CPUS (thx2)
> > >> > >
> > >> > > The regression comes from:
> > >> > > commit: d3afc7f12987 ("arm64: Allow IPIs to be handled as normal
> > >> > > interrupts")
> > >> >
> > >> > That's interesting, as this patch doesn't really change anything (most
> > >> > of the potential overhead comes in later). The only potential overhead
> > >> > I can see is that the scheduler_ipi() call is now wrapped around
> > >> > irq_enter()/irq_exit().
> > >> >
> > >> > >
> > >> > >           v5.9              + this patch
> > >> > > hikey :   48818(+/- 0.31)   37503(+/- 0.15%)  -23.2%
> > >> > > thx2  :  132410(+/- 1.72)  122646(+/- 1.92%)   -7.4%
> > >> > >
> > >> > > By + this patch,  I mean merging branch from this patch. Whereas
> > >> > > merging the previous:
> > >> > > commit: 83cfac95c018 ("genirq: Allow interrupts to be excluded from
> > >> > > /proc/interrupts")
> > >> > >  It doesn't show any regression
> > >> >
> > >> > Since you are running perf, can you spot where the overhead occurs?
> > >
> > > Any idea about the root cause of the regression ?
> > > I have faced it on more arm64 platforms in the meantime
> >
> > two possible causes:
> >
> > (1) irq_enter/exit on the rescheduling IPI means we reschedule much more
> > often
> > (2) irq_domain lookups add some overhead.
> >
> > For (1), I have this series[1] which is ugly as sin and needs much more
> > testing.
>
> Ok, I'm going to test this series to see if it fixes the perf regression

You have spotted the root cause of the regression. We are back to ~1%
performance diff on the hikey

>
> >
> > For (2), I have some ideas which need more work (let the irq domain
> > resolve to
> > an irq_desc instead of an interrupt number, avoiding another radix-tree
> > lookup).
> >
> >          M.
> >
> > [1]
> > https://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git/log/?h=irq/ipi-fixes
> > --
> > Jazz is not dead. It just smells funny...
