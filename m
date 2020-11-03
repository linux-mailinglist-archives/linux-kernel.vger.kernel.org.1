Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10C4E2A3B63
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Nov 2020 05:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726042AbgKCEWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 23:22:37 -0500
Received: from mail-wr1-f42.google.com ([209.85.221.42]:36368 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbgKCEWh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 23:22:37 -0500
Received: by mail-wr1-f42.google.com with SMTP id x7so16973069wrl.3;
        Mon, 02 Nov 2020 20:22:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kwvQxdCCB9ua8CwhZ8qTufxP4V9xwd/fI1X1QHmzIMA=;
        b=eaq1VsBPcrIQtilYsLxYfxSzBuN+zyKtzsJNYA/7RUSIoMjCWy4Y9B3y1aONiyWLaX
         vPB4hnqr8QAeSqQIBINIf4kY1NpbVknZpqNlrggoMiJSc2/IWdRn9vJCQxbvmdBWdI3t
         3CaEAxlkWvEWCWBu0u5SYxjXd231qb6AMfWojAd1eYmeqEqyXe0CeyWFW5BSYbTHkDuJ
         VdRsaz/cuJW2DeU1sVHOVPm0L4JKrFy6CgtvwZvxBdZ4fe+fbTclJ3aqhYig9EAVKmpP
         YztvUJllkB8uBML/56cLzTcrzfgIOUS9DuBtt6OWYCfXr7UjyC3zwAv4FYVkY7oh1RSD
         dFzw==
X-Gm-Message-State: AOAM530at8X4glJndVpALgI5uLGGUA6OOAiuCUpvQEEzns+21A2f1y8O
        MbMXOXSsakv1AyhjNaeS6QWpQdIY2y6QYZ7eRs8=
X-Google-Smtp-Source: ABdhPJw0IDJTzLuUA1umX3YyBCRiWO6anQG9mTp920WyI5NHPG0E6MgUzvfH0dCk4AMn9/bb9KZ6VHO+icU4QHnIM2c=
X-Received: by 2002:adf:84a5:: with SMTP id 34mr23487326wrg.8.1604377354918;
 Mon, 02 Nov 2020 20:22:34 -0800 (PST)
MIME-Version: 1.0
References: <20201006131703.GR2628@hirez.programming.kicks-ass.net>
 <CABPqkBSkdqXjm6QuF9j6AO8MUnt1yZ_cA2PV=Qo8e4wKmK_6Ug@mail.gmail.com>
 <20201008070231.GS2628@hirez.programming.kicks-ass.net> <50338de81b34031db8637337f08b89b588476211.camel@klomp.org>
 <CAM9d7chX+VxN+6T0y=CWfiMPWY6em3grGJL+oYnX99aOfFO2fg@mail.gmail.com>
 <20201030091649.GB3100@wildebeest.org> <20201030101004.GB2628@hirez.programming.kicks-ass.net>
 <20201102172712.0c9859124835089d80dc2348@kernel.org>
In-Reply-To: <20201102172712.0c9859124835089d80dc2348@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 3 Nov 2020 13:22:23 +0900
Message-ID: <CAM9d7cj5eBZo5Sg_-dz0QJ7ztoistRF7eMi9wby+kNio4sxsUQ@mail.gmail.com>
Subject: Re: Additional debug info to aid cacheline analysis
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mark Wielaard <mark@klomp.org>,
        Stephane Eranian <eranian@google.com>,
        linux-toolchains@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Ian Rogers <irogers@google.com>,
        "Phillips, Kim" <kim.phillips@amd.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andi Kleen <andi@firstfloor.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Masami,

On Mon, Nov 2, 2020 at 5:27 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> Hi,
>
> On Fri, 30 Oct 2020 11:10:04 +0100
> Peter Zijlstra <peterz@infradead.org> wrote:
>
> > On Fri, Oct 30, 2020 at 10:16:49AM +0100, Mark Wielaard wrote:
> > > Hi Namhyung,
> > >
> > > On Fri, Oct 30, 2020 at 02:26:19PM +0900, Namhyung Kim wrote:
> > > > On Thu, Oct 8, 2020 at 6:38 PM Mark Wielaard <mark@klomp.org> wrote:
> > > > > GCC using -fvar-tracking and -fvar-tracking-assignments is pretty good
> > > > > at keeping track of where variables are held (in memory or registers)
> > > > > when in the program, even through various optimizations.
> > > > >
> > > > > -fvar-tracking-assignments is the default with -g -O2.
> > > > > Except for the upstream linux kernel code. Most distros enable it
> > > > > again, but you do want to enable it by hand when building from the
> > > > > upstream linux git repo.
> > > >
> > > > Please correct me if I'm wrong.  This seems to track local variables.
> > > > But I'm not sure it's enough for this purpose as we want to know
> > > > types of any memory references (not directly from a variable).
> > > >
> > > > Let's say we have a variable like below:
> > > >
> > > >   struct xxx a;
> > > >
> > > >   a.b->c->d++;
> > > >
> > > > And we have a sample where 'd' is updated, then how can we know
> > > > it's from the variable 'a'?  Maybe we don't need to know it, but we
> > > > should know it accesses the 'd' field in the struct 'c'.
> > > >
> > > > Probably we can analyze the asm code and figure out it's from 'a'
> > > > and accessing 'd' at the moment.  I'm curious if there's a way in
> > > > the DWARF to help this kind of work.
> > >
> > > DWARF does have that information, but it stores it in a way that is
> > > kind of opposite to how you want to access it. Given a variable and an
> > > address, you can easily get the location where that variable is
> > > stored. But if you want to map back from a given (memory) location and
> > > address to the variable, that is more work.
> >
> > The principal idea in this thread doesn't care about the address of the
> > variables. The idea was to get the data type and member information from
> > the instruction.
> >
> > So in the above example: a.b->c->d++; what we'll end up with is
> > something like:
> >
> >       inc     8(%rax)
> >
> > Where %rax contains c, and the offset of d in c is 8.
>
> For this simple case, it is possible.
>
> This offset information is stored in the DWARF as a data-structure type
> information. (perf-probe uses it to find how to get the given local var's
> fields)
>
> So if we do this off-line, I think it is possible if it is recorded with
> instruction-pointers. For each place, we can do
>
>  - decode instruction and get the access address.
>  - get var assignment of %rax at that IP.
>  - get type information of var and find the field from offset.
>
> However, the problem is that if the DWARF has only assignment of "a",
> we need to decode the function body. (and usually this happens)
>
> func() {
>  struct xxx a;
>  ...
>  a.b->c->d++;
> }
>
> In this case, only "a" is the local variable. So DWARF records assignment of
> "a", not "b" nor "c" (since those are not a name of variables, just a name
> of fields). GCC may generate something like
>
>  mov    16(%rsp),%rdx   // rdx = a.b
>  mov    8(%rdx),%rax            // rax = b->c
>  inc    8(%rax)         // c->d++

Right, it'd be really nice if compiler can add information about the
(hidden) assignments in the rdx and rax here.

Thanks
Namhyung
