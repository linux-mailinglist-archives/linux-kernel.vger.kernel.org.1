Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EB1C2F3574
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 17:21:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406478AbhALQRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 11:17:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:52986 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2406451AbhALQRp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 11:17:45 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id EAF022222F
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 16:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610468225;
        bh=NkHyc1BkLz30+sbgIVGOr7kZ1HRA45HZcKcwbwOevaA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=hTCqWeglsHd9t2VCYPlxXCFxlzNrqEOd1LShyhXEcETwvj7KahJyGezqCa6chRZ6b
         FaNQRwGNgNLu8tJy5bMbXLrR59VqN8SSt/yhH/F82AC9HcrZR3zohzTP2O+h9GUrpc
         IUNj13fvAtTwsW/W9w8wrL8wsB3QLt02ZhqbiTC7AGk7grEMb9TP+RbN+VZPGfMSdQ
         6DAQOmc2T6mudOtXbKyosvZbEU2rPdneut6zBhV2ySrWF2RKEBqIAAjbHWhTbe1EhH
         McQHX6oiINp9uLx/SQQ7f5XSE14W7pxL2++7vBFLDbjxT4ELT6gir6h7Osjn27ajyk
         hwjuBJwcO3/Bw==
Received: by mail-ed1-f43.google.com with SMTP id by27so2715800edb.10
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jan 2021 08:17:04 -0800 (PST)
X-Gm-Message-State: AOAM532jRfgdaeGJXR00uEowNRMNpNK5MRzzuTKyhLORBvrgo3oWnwDK
        Rtbf1KBg7xVU77JKPuITv/+0ujtLYPt3rjJD7g==
X-Google-Smtp-Source: ABdhPJxqKXonHzoCdkUxbtNZm7Q5s+u9NOu0+Xa5ZBqC9SODwMdhisFICXfh6ISdn4FBGuGZN/szv7O7sjaYQOrp70w=
X-Received: by 2002:a05:6402:1841:: with SMTP id v1mr4131969edy.194.1610468223460;
 Tue, 12 Jan 2021 08:17:03 -0800 (PST)
MIME-Version: 1.0
References: <20210108000136.1556129-1-robh@kernel.org> <X/3BDlQxTCYd2HJs@hirez.programming.kicks-ass.net>
In-Reply-To: <X/3BDlQxTCYd2HJs@hirez.programming.kicks-ass.net>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 12 Jan 2021 10:16:50 -0600
X-Gmail-Original-Message-ID: <CAL_JsqK+eKef5NaVnBfARCjRE3MYhfBfe54F9YHKbsTnWqLmLw@mail.gmail.com>
Message-ID: <CAL_JsqK+eKef5NaVnBfARCjRE3MYhfBfe54F9YHKbsTnWqLmLw@mail.gmail.com>
Subject: Re: [RFC] perf/x86: Only expose userspace rdpmc for events on current CPU
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Will Deacon <will@kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 12, 2021 at 9:33 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Jan 07, 2021 at 05:01:36PM -0700, Rob Herring wrote:
> > Userspace access using rdpmc only makes sense if the event is valid for
> > the current CPU. However, cap_user_rdpmc is currently set no matter which
> > CPU the event is associated with. The result is userspace reading another
> > CPU's event thinks it can use rdpmc to read the counter. In doing so, the
> > wrong counter will be read.
>
> Don't do that then?

I could check this in userspace I suppose, but then it's yet another
thing the rdpmc loop has to check. I think it's better to not add more
overhead there.

Or we just ignore this. This issue came up in the referenced thread
with Jiri. I'm not all that convinced that per CPU events and
userspace rdpmc is too useful of a combination. It would only reduce
the overhead on 1 out of N cpus. In this case, we'd have to limit the
userspace read to per thread events (and ones on any cpu I suppose).

>
> > diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
> > index a88c94d65693..6e6d4c1d03ca 100644
> > --- a/arch/x86/events/core.c
> > +++ b/arch/x86/events/core.c
> > @@ -2490,7 +2490,8 @@ void arch_perf_update_userpage(struct perf_event *event,
> >       userpg->cap_user_time = 0;
> >       userpg->cap_user_time_zero = 0;
> >       userpg->cap_user_rdpmc =
> > -             !!(event->hw.flags & PERF_X86_EVENT_RDPMC_ALLOWED);
> > +             !!(event->hw.flags & PERF_X86_EVENT_RDPMC_ALLOWED) &&
> > +             (event->oncpu == smp_processor_id());
> >       userpg->pmc_width = x86_pmu.cntval_bits;
> >
> >       if (!using_native_sched_clock() || !sched_clock_stable())
>
> Isn't that a nop? That is, from the few sites I checked, we're always
> calling this on the event's CPU.

If cpu0 opens and mmaps an event for cpu1, then cpu0 will see
cap_user_rdpmc set and think it can use rdpmc.

Rob
