Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E440277863
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 20:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728734AbgIXSUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 14:20:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727753AbgIXSUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 14:20:10 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597ACC0613CE
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 11:20:10 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id mm21so157300pjb.4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Sep 2020 11:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eQMwhMR95n+3FqBYI5WeAox8ddPXZxaoyC5f5KTzv1Q=;
        b=GdfyMCbqMOKTkZTGUricXEzpXRPXMc0br4yflxhC7hdlpcAcJ41FcQce+qdccc3z87
         MMHOf+8H5Qr7RybcJieBQ5EQNHlLU5mUBdxeE64mi7MqDPzFTD8FlUGOrNkDsD3zyonP
         cZvcfl8xL5uDWI7gIgAXwh2E3zr9TiPG7nH676ZY8oREoV9x/hm2xZY621hV4+O5Obyn
         FzkZiPfL3s8lCz0lJhzkW2b7vZnlvGlJmmvTq3UFIh29qUQ4q7K0h7b0kWCmUVcE3j22
         8ctZwQVXWEnL7SHF/Pk+KGEEY4RL75w0Lg0VL8ZNiJbHODxZsUa+28YyqqxNSOWrwW7p
         5Wnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eQMwhMR95n+3FqBYI5WeAox8ddPXZxaoyC5f5KTzv1Q=;
        b=ddEI31P+rSYkGEPHPVwGGFPreLvMq3zjunmEJfab2dyzvZpntH224ld3YRx9gO5O9+
         N9YB+v8ImbSlB6Wk4RE7adYiDUvjLS7P7PqOkXMkHLCBanyuOJ4fwYOeVbKrJ9A/XMyr
         nlmB0Hn66iO3jwsVl00jXeT9jFxAgbzwMBIiHLlMUNNMUGV/qBeG+qOqLrEr1D0IneJZ
         gB5iwyFjl5goP27iTWii5f06NcT+oVmHtzdOZgKkb3ZtcKjwj4iY2/pV6AEIpq2cL82p
         To9BxOk91hfxL+eP/6uDujsLaR0ybKxTcKcAPJKjARi1OCiNVvN5LJrQ9sOzmCNdt83l
         WW1Q==
X-Gm-Message-State: AOAM530g/qMmhN+JUwrB4ggCawf3SaN4Pg/8Exo65+Aq++7x+qvv+p9c
        X8xBBI2uYtPRBdfYYrszgTMwg0fYGUGw+0J7v7Ib3Q==
X-Google-Smtp-Source: ABdhPJxGK7ykG4+qfUScNswCNWsCaTVZXUZJkcNZiTFJ0sltfxqVFMju3BXl5ivw2bkup5SuTddERmoUfauwxLhCPrg=
X-Received: by 2002:a17:90a:c17:: with SMTP id 23mr182252pjs.127.1600971609587;
 Thu, 24 Sep 2020 11:20:09 -0700 (PDT)
MIME-Version: 1.0
References: <20200924170928.466191266@goodmis.org> <20200924171846.993048030@goodmis.org>
 <2006335081.68212.1600969345189.JavaMail.zimbra@efficios.com>
In-Reply-To: <2006335081.68212.1600969345189.JavaMail.zimbra@efficios.com>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Thu, 24 Sep 2020 11:19:33 -0700
Message-ID: <CAJHvVcjcehxKV2dmc8+j5ke-JcqGRvGoQTf2iKSN4istLQKseQ@mail.gmail.com>
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

On Thu, Sep 24, 2020 at 10:42 AM Mathieu Desnoyers
<mathieu.desnoyers@efficios.com> wrote:
>
> ----- On Sep 24, 2020, at 1:09 PM, rostedt rostedt@goodmis.org wrote:
>
> > From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> >
> > As tracepoints are discouraged from being added in a header because it can
> > cause side effects if other tracepoints are in headers, the common
> > workaround is to add a function call that calls a wrapper function in a
> > C file that then calls the tracepoint. But as function calls add overhead,
> > this function should only be called when the tracepoint in question is
> > enabled. To get around the overhead, a static_branch can be used that only
> > gets set when the tracepoint is enabled, and then inside the block of the
> > static branch can contain the call to the tracepoint wrapper.
> >
> > Add a tracepoint_enabled(tp) macro that gets passed the name of the
> > tracepoint, and this becomes a static_branch that is enabled when the
> > tracepoint is enabled and is a nop when the tracepoint is disabled.
> >
> > Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> > ---
> > Documentation/trace/tracepoints.rst | 25 ++++++++++++++++++++++
> > include/linux/tracepoint-defs.h     | 33 +++++++++++++++++++++++++++++
> > 2 files changed, 58 insertions(+)
> >
> > diff --git a/Documentation/trace/tracepoints.rst
> > b/Documentation/trace/tracepoints.rst
> > index 6e3ce3bf3593..833d39ee1c44 100644
> > --- a/Documentation/trace/tracepoints.rst
> > +++ b/Documentation/trace/tracepoints.rst
> > @@ -146,3 +146,28 @@ with jump labels and avoid conditional branches.
> >       define tracepoints. Check http://lwn.net/Articles/379903,
> >       http://lwn.net/Articles/381064 and http://lwn.net/Articles/383362
> >       for a series of articles with more details.
> > +
> > +If you require calling a tracepoint from a header file, it is not
> > +recommended to call one directly or to use the trace_<tracepoint>_enabled()
> > +function call, as tracepoints in header files can have side effects if a
> > +header is included from a file that has CREATE_TRACE_POINTS set. Instead,
> > +include tracepoint-defs.h and use trace_enabled().
>
> Tracepoints per-se have no issues being used from header files. The TRACE_EVENT
> infrastructure seems to be the cause of this problem. We should fix trace events
> rather than require all users to use weird work-arounds thorough the kernel code
> base.
>
> I am not against the idea of a tracepoint_enabled(tp), but I am against the
> motivation behind this patch and the new tracepoint user requirements it documents.

Perhaps anecdotally, I've found that the situation Steven described
occurs not just because of the TRACE_EVENT infrastructure. We also run
into this problem when adding tracepoints under any "very core" APIs,
i.e. anything that is transiently included from linux/tracepoint.h.
For example, I ran into this issue while adding tracepoints under the
linux/mmap_lock.h API, because that header is somehow transiently
included by linux/tracepoint.h (sorry, I don't have the exact
transient include path on hand; I can dig it up if it would be
useful).



>
> > +
> > +In a C file::
> > +
> > +     void do_trace_foo_bar_wrapper(args)
> > +     {
> > +             trace_foo_bar(args);
> > +     }
> > +
> > +In the header file::
> > +
> > +     DECLEARE_TRACEPOINT(foo_bar);
> > +
> > +     static inline void some_inline_function()
> > +     {
> > +             [..]
> > +             if (trace_enabled(foo_bar))
>
> Is it trace_enabled() or tracepoint_enabled() ? There is a mismatch
> between the commit message/code and the documentation.
>
> Thanks,
>
> Mathieu
>
> > +                     do_trace_foo_bar_wrapper(args);
> > +             [..]
> > +     }
> > diff --git a/include/linux/tracepoint-defs.h b/include/linux/tracepoint-defs.h
> > index b29950a19205..ca2f1f77f6f8 100644
> > --- a/include/linux/tracepoint-defs.h
> > +++ b/include/linux/tracepoint-defs.h
> > @@ -48,4 +48,37 @@ struct bpf_raw_event_map {
> >       u32                     writable_size;
> > } __aligned(32);
> >
> > +/*
> > + * If a tracepoint needs to be called from a header file, it is not
> > + * recommended to call it directly, as tracepoints in header files
> > + * may cause side-effects. Instead, use trace_enabled() to test
> > + * if the tracepoint is enabled, then if it is, call a wrapper
> > + * function defined in a C file that will then call the tracepoint.
> > + *
> > + * For "trace_foo()", you would need to create a wrapper function
> > + * in a C file to call trace_foo():
> > + *   void trace_bar(args) { trace_foo(args); }
> > + * Then in the header file, declare the tracepoint:
> > + *   DECLARE_TRACEPOINT(foo);
> > + * And call your wrapper:
> > + *   static inline void some_inlined_function() {
> > + *            [..]
> > + *            if (tracepoint_enabled(foo))
> > + *                    trace_bar(args);
> > + *            [..]
> > + *   }
> > + *
> > + * Note: tracepoint_enabled(foo) is equivalent to trace_foo_enabled()
> > + *   but is safe to have in headers, where trace_foo_enabled() is not.
> > + */
> > +#define DECLARE_TRACEPOINT(tp) \
> > +     extern struct tracepoint __tracepoint_##tp
> > +
> > +#ifdef CONFIG_TRACEPOINTS
> > +# define tracepoint_enabled(tp) \
> > +     static_key_false(&(__tracepoint_##tp).key)
> > +#else
> > +# define tracepoint_enabled(tracepoint) false
> > +#endif
> > +
> > #endif
> > --
> > 2.28.0
>
> --
> Mathieu Desnoyers
> EfficiOS Inc.
> http://www.efficios.com
