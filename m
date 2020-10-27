Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6EAB29ACFE
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 14:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751857AbgJ0NRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 09:17:25 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:43821 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440805AbgJ0NRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 09:17:25 -0400
Received: by mail-lf1-f66.google.com with SMTP id l28so2236614lfp.10
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 06:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EMbv013hxb/4gPOUK8hbOEdoU8C2dgtEhB0AjU3ttHw=;
        b=gF4XWhuwKAoT+jOkMwMRRmdiuFKvMmsahf8xpHF1u+MNcvDBKAJeh91xSP7SU+tV+N
         zd0Dx7yJjL6ua/9m8rHrI37ObGjikYyLQMzBoIIY8Y7e2n+sCj2IKYpHahWUaNa1icoV
         Ndj/+L+NUDrwuBgJmyeMyat31xHWM5oFT+kN+KJBQxbCZK+PH93MrUxcJg7i/t3nc5/y
         cyAsgQVdgD75idmwmFPnCCuhABF9SaPCaa7Bx3JY4XXYBEF946brtQVxAUmsBwuMnxmL
         m5wVj6rxX9Jb2z2b/uuVUfYSzwDNqcS27NR4CxFg1Q8K1nGW3tFuRC3pcFKNk8XU4QOZ
         1iOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EMbv013hxb/4gPOUK8hbOEdoU8C2dgtEhB0AjU3ttHw=;
        b=H7AYpHFmPKYuOjN35IYBghZu1GNdrHlMDwDMp/YQxE/qLzvajjOp0Ow+/sJFeEHnaq
         HXVESuln57/ZLc7/x9Y4Ix2YjPZqNz4SPaxnR6YtHwMn3rlKQL+g0I4zylSFlxT6dNS3
         yudvusY5z5Bxs6kAMNlgVF+es0Na/Al7UMjnDG71jUC9j5/Wmv6fH+3Qdt25t3bq7M6j
         xvOD1YHFMEKo5KE2oHtP0uFrH5/wIzUV86bC4jct8GHn7aSlBJ/Ht2bXhnLEnJmHBdKO
         iTHL18rKVneItdo5Q+1oRgHxhdrWFq5F/lQRkbnast/i25yJc9F5FV5XjQQbmqbr3Kv1
         lqug==
X-Gm-Message-State: AOAM5303CgGKsKRpxhFjoH3js9X/NNuWT4Rn9Jy3+yLLXL8KRhmNgr5T
        6xGVxqO6l4Xvg34llns0992wdvQGJgKzk5HqEVrrzQ==
X-Google-Smtp-Source: ABdhPJxoLo8+UbuJ1akjQQrRDgYIHm/stpjtvXIP1H1xgxaPxv0SZMggkLi+gCJ2iOQQm2c9LFes9W1VH5WEOXiPg7c=
X-Received: by 2002:ac2:5a4f:: with SMTP id r15mr988614lfn.258.1603804642325;
 Tue, 27 Oct 2020 06:17:22 -0700 (PDT)
MIME-Version: 1.0
References: <20200901144324.1071694-1-maz@kernel.org> <20200901144324.1071694-4-maz@kernel.org>
 <CAKfTPtDjPpri5Gt6kLeFp_B_zJUZ5DYXEqtJ+0VKohU-y9bFEQ@mail.gmail.com>
 <353f13b0dcc6c7ea1b44012d9632a0cc@kernel.org> <CAKfTPtBjw5ay_BcPmEXpHOHbNxNZuYmdCoHQM53u3c+RXnKONg@mail.gmail.com>
 <CAKfTPtBURraZh8E8p3PmncoDRVV5N42yTyJcpPf0OROciM2+xg@mail.gmail.com>
 <7b754dfe579044902d3468b9f864bd37@kernel.org> <CAKfTPtBQd8LcXAq_TkUx6uY3NGu72RAAftawtHxEqB=18C3D8A@mail.gmail.com>
 <CAKfTPtAfaTFXT5seyia=qwpX0BB7e6VpGo5iSYbF0JZwmC1nWg@mail.gmail.com> <11951c39bc676b83def46150e58e8df3@kernel.org>
In-Reply-To: <11951c39bc676b83def46150e58e8df3@kernel.org>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 27 Oct 2020 14:17:10 +0100
Message-ID: <CAKfTPtD3GkTd+qQvyCmyU7Atu1ictDQ82YbPRdY9a+Kkr2DjvA@mail.gmail.com>
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

On Tue, 27 Oct 2020 at 13:06, Marc Zyngier <maz@kernel.org> wrote:
>
> On 2020-10-27 11:21, Vincent Guittot wrote:
> > On Tue, 27 Oct 2020 at 11:50, Vincent Guittot
> > <vincent.guittot@linaro.org> wrote:
> >>
> >> On Tue, 27 Oct 2020 at 11:37, Marc Zyngier <maz@kernel.org> wrote:
> >> >
> >> > On 2020-10-27 10:12, Vincent Guittot wrote:
> >> > > HI Marc,
> >> > >
> >> > > On Mon, 19 Oct 2020 at 17:43, Vincent Guittot
> >> > > <vincent.guittot@linaro.org> wrote:
> >> > >>
> >> > >> On Mon, 19 Oct 2020 at 15:04, Marc Zyngier <maz@kernel.org> wrote:
> >> > >> >
> >> > >
> >> > > ...
> >> > >
> >> > >> > >>
> >> > >> > >> One of the major difference is that we end up, in some cases
> >> > >> > >> (such as when performing IRQ time accounting on the scheduler
> >> > >> > >> IPI), end up with nested irq_enter()/irq_exit() pairs.
> >> > >> > >> Other than the (relatively small) overhead, there should be
> >> > >> > >> no consequences to it (these pairs are designed to nest
> >> > >> > >> correctly, and the accounting shouldn't be off).
> >> > >> > >
> >> > >> > > While rebasing on mainline, I have faced a performance regression for
> >> > >> > > the benchmark:
> >> > >> > > perf bench sched pipe
> >> > >> > > on my arm64 dual quad core (hikey) and my 2 nodes x 112 CPUS (thx2)
> >> > >> > >
> >> > >> > > The regression comes from:
> >> > >> > > commit: d3afc7f12987 ("arm64: Allow IPIs to be handled as normal
> >> > >> > > interrupts")
> >> > >> >
> >> > >> > That's interesting, as this patch doesn't really change anything (most
> >> > >> > of the potential overhead comes in later). The only potential overhead
> >> > >> > I can see is that the scheduler_ipi() call is now wrapped around
> >> > >> > irq_enter()/irq_exit().
> >> > >> >
> >> > >> > >
> >> > >> > >           v5.9              + this patch
> >> > >> > > hikey :   48818(+/- 0.31)   37503(+/- 0.15%)  -23.2%
> >> > >> > > thx2  :  132410(+/- 1.72)  122646(+/- 1.92%)   -7.4%
> >> > >> > >
> >> > >> > > By + this patch,  I mean merging branch from this patch. Whereas
> >> > >> > > merging the previous:
> >> > >> > > commit: 83cfac95c018 ("genirq: Allow interrupts to be excluded from
> >> > >> > > /proc/interrupts")
> >> > >> > >  It doesn't show any regression
> >> > >> >
> >> > >> > Since you are running perf, can you spot where the overhead occurs?
> >> > >
> >> > > Any idea about the root cause of the regression ?
> >> > > I have faced it on more arm64 platforms in the meantime
> >> >
> >> > two possible causes:
> >> >
> >> > (1) irq_enter/exit on the rescheduling IPI means we reschedule much more
> >> > often
> >> > (2) irq_domain lookups add some overhead.
> >> >
> >> > For (1), I have this series[1] which is ugly as sin and needs much more
> >> > testing.
> >>
> >> Ok, I'm going to test this series to see if it fixes the perf
> >> regression
> >
> > You have spotted the root cause of the regression. We are back to ~1%
> > performance diff on the hikey
>
> Yeah. Only thing is that I can't look at this hack without vomiting...

At least, we know the root cause and the impact of irq_enter/exit
>
>          M.
> --
> Jazz is not dead. It just smells funny...
