Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6E90277A00
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 22:14:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgIXUNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 16:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbgIXUNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 16:13:34 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 467D6C0613DA
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 13:05:31 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id 197so378329pge.8
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 13:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CEKITIo/fE6uNxy1Lcs9VsvYxy+SP2eUzht/P3sZLuo=;
        b=ZfQhqdjEK+3LztQ/ENGVGHbtPR6QLu/iTI2FvudqJjkfCyhvNU2hV2AncQWTtkono3
         O39I9un0oCb5MG1o0ONewH5rDqnql/R6O6QEt0/CH2vOHQRu6ZOhRbRXNIBmm7tLq5p9
         YeLMDPuFbXou9MlcfeVNUkB+cMpuGPYZxEZGfoGX0960mINdyGOcyj+zplo57oFay8PK
         MYtHLU/6Irq5KXjtPywITOjAUSGFBj212iqcQSw6O0RxYqq0p/JLbt9PGpVajLZRbiJh
         rM2erPouVkweSheXaGB4RLIuA1dNoFSJ0vBcKCYVPgidfieOMAeSjme/c4d/l5hI7Un5
         XVlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CEKITIo/fE6uNxy1Lcs9VsvYxy+SP2eUzht/P3sZLuo=;
        b=trfmFueCPBGPdweRacNuMj0SEkHZNTAo5gh8J8x1azw2idFyQ5MjTZwbwqVWOKqq71
         eCYYD/Dp0DDOiL7Amv3aDq8d+EqfLokjwl8+ixo9w8P4F3e8b9I8qUM+qZhlXBImHPZb
         HYa75EJuKOBm+CyJK7ET4U5f7gS6AzArqqdW+dJm/hUNS6qZrhoTQRasSFvH8BGMbbEz
         JKEQA/CzKro/j6sHAekLbsaiNCwoXd5JZLjIfcEr2mmwiCaHVpsqVfAK2w71OJP83b7G
         A4yuosrt/mtpa9jcWX1OsiTgJ6pgpk6tlJIhjjaYG3JVnUwUUc4X9Fl2Lr6jN6x7IoRw
         BQvw==
X-Gm-Message-State: AOAM532nIuKgq4KjiQRKQYUho4c+0jY/K95wuhcVotL8pllxd2uY7GJ6
        nUjXuknkjZ/EqgJtlrYl/VBys4Eypa/n9MgJ5sL2PA==
X-Google-Smtp-Source: ABdhPJzNUrQcMPFuCTSy3bJ0vrcfkhqbCZUH5VOGBFRcs8Xog5ppfqpt7q5T6l+70U1WCGJJAdvYF8Bb3vEYwicQ7OI=
X-Received: by 2002:a63:1e0c:: with SMTP id e12mr605763pge.346.1600977930500;
 Thu, 24 Sep 2020 13:05:30 -0700 (PDT)
MIME-Version: 1.0
References: <20200924170928.466191266@goodmis.org> <20200924171846.993048030@goodmis.org>
 <2006335081.68212.1600969345189.JavaMail.zimbra@efficios.com>
 <20200924143025.58dc3c1f@gandalf.local.home> <166273261.68446.1600974510284.JavaMail.zimbra@efficios.com>
In-Reply-To: <166273261.68446.1600974510284.JavaMail.zimbra@efficios.com>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Thu, 24 Sep 2020 13:04:53 -0700
Message-ID: <CAJHvVch3QTdArP24rNsWKkNpsCHyA7TT7s9M0=KS9+59ADjGgA@mail.gmail.com>
Subject: Re: [PATCH 1/2] tracepoints: Add helper to test if tracepoint is
 enabled in a header
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     rostedt <rostedt@goodmis.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Yafang Shao <laoar.shao@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michel Lespinasse <walken@google.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        linux-mm <linux-mm@kvack.org>, Ingo Molnar <mingo@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 24, 2020 at 12:08 PM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
>
>
> ----- On Sep 24, 2020, at 2:30 PM, rostedt rostedt@goodmis.org wrote:
>
> > On Thu, 24 Sep 2020 13:42:25 -0400 (EDT)
> > Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> >
> >> > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> >> > ---
> >> > Documentation/trace/tracepoints.rst | 25 ++++++++++++++++++++++
> >> > include/linux/tracepoint-defs.h     | 33 +++++++++++++++++++++++++++++
> >> > 2 files changed, 58 insertions(+)
> >> >
> >> > diff --git a/Documentation/trace/tracepoints.rst
> >> > b/Documentation/trace/tracepoints.rst
> >> > index 6e3ce3bf3593..833d39ee1c44 100644
> >> > --- a/Documentation/trace/tracepoints.rst
> >> > +++ b/Documentation/trace/tracepoints.rst
> >> > @@ -146,3 +146,28 @@ with jump labels and avoid conditional branches.
> >> >       define tracepoints. Check http://lwn.net/Articles/379903,
> >> >       http://lwn.net/Articles/381064 and http://lwn.net/Articles/383362
> >> >       for a series of articles with more details.
> >> > +
> >> > +If you require calling a tracepoint from a header file, it is not
> >> > +recommended to call one directly or to use the trace_<tracepoint>_enabled()
> >> > +function call, as tracepoints in header files can have side effects if a
> >> > +header is included from a file that has CREATE_TRACE_POINTS set. Instead,
> >> > +include tracepoint-defs.h and use trace_enabled().
> >>
> >> Tracepoints per-se have no issues being used from header files. The TRACE_EVENT
> >> infrastructure seems to be the cause of this problem. We should fix trace events
> >> rather than require all users to use weird work-arounds thorough the kernel code
> >> base.
> >
> > That's like saying "let's solve include hell". Note, in the past there has
> > also been issues with the headers included also having issues including
> > other headers and cause a dependency loop.
>
> AFAIU, there are a few scenarios we care about here:
>
> 1) Includes done by tracepoint.h (directly and indirectly). Some additional
>    includes may have crept in and bloated tracepoint.h since its original
>    implementation. We should identify and fix those.

I was recalling that tracepoint.h transiently included linux/mm.h, but
that appears to not be the case. Either I'm misremembering, or I at
some point fixed the issue by switching to forward declarations
instead.

>
> 2) Includes done by trace event headers when CREATE_TRACE_POINTS is defined.
>    define_trace.h already takes care of #undef/#define CREATE_TRACE_POINTS to
>    prevent recursion, so it should not be an issue.
>
> 3) Includes done by a compile unit after #define CREATE_TRACE_POINTS, but which
>    are not meant to create trace point probes. For this case, requiring to
>    #undef CREATE_TRACE_POINTS after all the relevant headers are included should
>    solve it.
>
> So what additional issues am I missing here ?
>
> >
> > But the magic of trace events (for both perf and ftrace, sorry if you
> > refused to use it),
>
> I cannot not use it to this day because changes I needed to upstream in order
> to make it useful to me were rejected.
>
> > is that people who add tracepoints do not need to know
> > how tracepoints work. There's no adding of registering of them, or anything
> > else. The formats and everything they record appear in the tracefs file
> > system.
>
> That's all fine by me.
>
> >
> > How are your trace events created?  All manual, or do you have helper
> > macros.
>
> I suspect you mean LTTng's trace events. Those are created with helper macros
> (LTTNG_TRACEPOINT_EVENT) which have a few improvements over TRACE_EVENT, namely:
>
> - Ability to create arrays of events (because lots of semicolons are removed), removing
>   the need to dynamically register each event at init time,
> - Ability to do pre-filtering of events, before they hit the ring buffer, allowed by
>   combining TP_struct and TP_fast_assign into a single structured TP_FIELDS.
>
> LTTng also has an include pass which uses TRACE_EVENT from the kernel to perform
> tracepoint prototype signature validation of LTTNG_TRACEPOINT_EVENT against TRACE_EVENT
> prototypes.
>
> > Would these be safe if a bunch were included?
>
> Can you elaborate on this question ? I have a hard time figuring out what
> scenario(s) you are after.
>
> >
> >>
> >> I am not against the idea of a tracepoint_enabled(tp), but I am against the
> >> motivation behind this patch and the new tracepoint user requirements it
> >> documents.
> >
> > It removes the open coded code that has been in the kernel for the last 4
> > years.
>
> There are indeed many cases where a tracepoint_enabled() macro makes sense. In
> some situations we encounter in user-space for lttng-ust, there is need to
> prepare data before it is passed as tracepoint arguments. Having this "enabled"
> macros allows to only prepare the data when needed.
>
> >
> >>
> >> > +
> >> > +In a C file::
> >> > +
> >> > +  void do_trace_foo_bar_wrapper(args)
> >> > +  {
> >> > +          trace_foo_bar(args);
> >> > +  }
> >> > +
> >> > +In the header file::
> >> > +
> >> > +  DECLEARE_TRACEPOINT(foo_bar);
> >> > +
> >> > +  static inline void some_inline_function()
> >> > +  {
> >> > +          [..]
> >> > +          if (trace_enabled(foo_bar))
> >>
> >> Is it trace_enabled() or tracepoint_enabled() ? There is a mismatch
> >> between the commit message/code and the documentation.
> >
> > Yes, it should be tracepoint_enabled(). Thanks for catching that.
> >
> > Anyway, this shouldn't affect you in any way, as it's just adding wrappers
> > around locations that have been doing this for years.
> >
> > If you want, I can change the name to trace_event_enabled() and put the
> > code in trace_events-defs.h instead. Which would simply include
> > tracepoints-defs.h and have the exact same code.
>
> I'm ok with tracepoint_enabled(). However, I would have placed it in tracepoint.h
> rather than tracepoint-defs.h, and we should figure out why people complain that
> tracepoint.h is including headers too eagerly.
>
> Thanks,
>
> Mathieu
>
> >
> > -- Steve
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
