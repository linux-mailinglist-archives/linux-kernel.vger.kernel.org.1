Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD4FD1F0AB1
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Jun 2020 11:37:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbgFGJhd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Jun 2020 05:37:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726430AbgFGJhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 05:37:33 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5B8C08C5C2
        for <linux-kernel@vger.kernel.org>; Sun,  7 Jun 2020 02:37:32 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id q14so12359910qtr.9
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jun 2020 02:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e2xlbfV4VPwn4qpyM6wODK/8b6ahF6KoGTstDUIrXuI=;
        b=T2nKWR5j+OTV9sb2IQ/DUt30OuGTmOwsJ/QnrYJQ+W7Niek9J00Cc3hQ1OCc1NtokM
         IwUQDLsFpkzPumkFSquq6ONBKcq5+pirA9UTY9TwKsnUe1uE/3rgBJSATq9uBuDAjhRb
         zTtz/1i3mrHj9xE6gZ1ySZO8QoF9gsT6lZ5QxuOZNOphbjKu9mjhYp1I+nZEXyiQG1Qu
         ZmGa1RnpGDCM8MjE/Py2t1rhjwihkO4/1CuIH5i0Vbm4UfUWXRPxl/cD6GVnRx9+tqhM
         aHEuTGZxUACwpckLu1fEm+2Pl37ecUJeAey9cQL6N4zLIT9jgJWyDG9t614GQ2i4NyQD
         FDVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e2xlbfV4VPwn4qpyM6wODK/8b6ahF6KoGTstDUIrXuI=;
        b=gVa77fOZI/lZ0MLZ6lgsxLmfTTkYLdggeoDDRxwBhRfvTvT4t5rdh9lgFlhAFpmZKD
         mrHsGSqwojwDCU/ATsX10Y3G/HdlDbF+NmXwmbokq7xYZVx12gaBYnVNWpmnAsASal5f
         nuF2Kmbm9IDdkbqP3HL/G0QCJN3wNfhddgn/Mqh2fono8DA5tTPMxpz8vQLGOufKlhaE
         5JcNazm/kEMpAm/ICwSuCtPHDzGj5JRIaCxQwjWc+5cVrZdGNfj48yifNFwg8hzpQwZi
         /cKcxQgzEuxP0MDE9DcLr33uN7v4dIK8ESx0huUPavQWTJNuavZDThGRAePZJG5Bq811
         eZcg==
X-Gm-Message-State: AOAM531ElpFEF/CMEZzYjgnoSQDVeRdfpzES0tjfcLU3C5iHUqu6aeri
        M78LVe/ApoMe+jMZMi/oby69/9TrFm5APiFC0I1iSw==
X-Google-Smtp-Source: ABdhPJwW+9IB7IybLpTrPLsWrOa4QP8XqvUufcQNCrPUbuAadj2lxI2CoP5UoEZE3Hd9dzx7G3vvxpGReZeEQo+qHVk=
X-Received: by 2002:ac8:7a87:: with SMTP id x7mr18590826qtr.50.1591522651451;
 Sun, 07 Jun 2020 02:37:31 -0700 (PDT)
MIME-Version: 1.0
References: <20200605082839.226418-1-elver@google.com> <CACT4Y+ZqdZD0YsPHf8UFJT94yq5KGgbDOXSiJYS0+pjgYDsx+A@mail.gmail.com>
 <20200605120352.GJ3976@hirez.programming.kicks-ass.net> <CAAeHK+zErjaB64bTRqjH3qHyo9QstDSHWiMxqvmNYwfPDWSuXQ@mail.gmail.com>
In-Reply-To: <CAAeHK+zErjaB64bTRqjH3qHyo9QstDSHWiMxqvmNYwfPDWSuXQ@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sun, 7 Jun 2020 11:37:20 +0200
Message-ID: <CACT4Y+Zwm47qs8yco0nNoD_hFzHccoGyPznLHkBjAeg9REZ3gA@mail.gmail.com>
Subject: Re: [PATCH -tip v3 1/2] kcov: Make runtime functions noinstr-compatible
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Marco Elver <elver@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Alexander Potapenko <glider@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 5, 2020 at 3:25 PM 'Andrey Konovalov' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
> > On Fri, Jun 05, 2020 at 12:57:15PM +0200, Dmitry Vyukov wrote:
> > > On Fri, Jun 5, 2020 at 10:28 AM Marco Elver <elver@google.com> wrote:
> > > >
> > > > While we lack a compiler attribute to add to noinstr that would disable
> > > > KCOV, make the KCOV runtime functions return if the caller is in a
> > > > noinstr section, and mark them noinstr.
> > > >
> > > > Declare write_comp_data() as __always_inline to ensure it is inlined,
> > > > which also reduces stack usage and removes one extra call from the
> > > > fast-path.
> > > >
> > > > In future, our compilers may provide an attribute to implement
> > > > __no_sanitize_coverage, which can then be added to noinstr, and the
> > > > checks added in this patch can be guarded by an #ifdef checking if the
> > > > compiler has such an attribute or not.
> > >
> > > Adding noinstr attribute to instrumentation callbacks looks fine to me.
> > >
> > > But I don't understand the within_noinstr_section part.
> > > As the cover letter mentions, kcov callbacks don't do much and we
> > > already have it inserted and called. What is the benefit of bailing
> > > out a bit earlier rather than letting it run to completion?
> > > Is the only reason for potential faults on access to the vmalloc-ed
> > > region?
> >
> > Vmalloc faults (on x86, the only arch that had them IIRC) are gone, per
> > this merge window.
> >
> > The reason I mentioned them is because it is important that they are
> > gone, and that this hard relies on them being gone, and the patch didn't
> > call that out.
> >
> > There is one additional issue though; you can set hardware breakpoint on
> > vmalloc space, and that would trigger #DB and then we'd be dead when we
> > were already in #DB (IST recursion FTW).
> >
> > And that is not something you can trivially fix, because you can set the
> > breakpoint before the allocation (or perhaps on a previous allocation).
> >
> > That said; we already have this problem with task_struct (and
> > task_stack). IIRC Andy wants to fix the task_stack issue by making all
> > of noinstr run on the entry stack, but we're not there yet.
> >
> > There are no good proposals for random allocations like task_struct or
> > in your case kcov_area.
> >
> > > Andrey, Mark, do you know if it's possible to pre-fault these areas?
> >
> > Under the assumption that vmalloc faults are still a thing:
> >
> > You cannot pre-fault the remote area thing, kernel threads use the mm of
> > the previous user task, and there is no guarantee that mm will have had
> > the vmalloc fault.
>
> To clarify this part AFAIU it, even if we try to prefault the whole
> remote area each time kcov_remote_start() is called, then (let alone
> the performance impact) the kernel thread can be rescheduled between
> kcov_remote_start() and kcov_remote_stop(), and then it might be
> running with a different mm than the one that was used when
> kcov_remote_start() happened.

Ugh, this is nasty. But this has also gone, which I am happy about :)

Why I am looking at this is because with coverage instrumentation
__sanitizer_cov_trace_pc is the hottest function in the kernel and we
are adding additional branches to it.

Can we touch at least some per-cpu data within noinstr code?
If yes, we could try to affect the existing
in_task()/in_serving_softirq() check.
If not, it would be useful to have a comment clarifying that
within_noinstr_section check must happen before we touch anything
else.

I assume objtool can now also detect all violations. How bad is it now
without within_noinstr_section check? I am assuming we marking noinstr
functions to not be instrumented, but we are getting some stray
instrumentation from inlined functions or something, right? How many
are there? Is it fixable/unfixable? Marco, do you know the list, or
could you please collect the list of violations?

Is there any config that disables #DB? We could well disable it on
syzbot, I think we already disable some production hardening/debugging
confings, which are not too useful for testing setup.
E.g. we support RANDOMIZE_BASE, no problem, but if one disables it
(which we do), that becomes no-op:

#ifdef CONFIG_RANDOMIZE_BASE
    ip -= kaslr_offset();
#endif
    return ip;
