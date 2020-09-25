Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7D62793A4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 23:37:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728733AbgIYVhO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 17:37:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727495AbgIYVhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 17:37:14 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EA6CC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 14:37:14 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id mm21so168046pjb.4
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 14:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TW6wlmmfMd4aKumjZRuqMrr4jbBaACouFEXMzF3b4zg=;
        b=eLDZbRtoVy4VydFLnbYK5iZ6uaMxjoYEvpd//jvLPkn0cL9HuuHKw1petsfWZnRHDK
         SdlJzJJvmDrf7CXh/AzJdh5sr0eXRBip0oCiez+KVPahBWODvk11O8ys3IbB9t1ulqjw
         vYXN6lffRPPN9sXgBjkkxqlUAhD1GSpkQqmH+16NtsCLhLEmoJQAlbopBsRvwHVM5md/
         EniFLu+gXxSgGOvUjOOh5V3Z6PQFOh55sdkQDuysdYf04LJljhrt/mu4jpbISUgywfXK
         Iz1D5PAcrwn8XYmSNEANYCMt7Ps7gpcoPsNdLNr7re/yNpGlLYvH/QwAIrlXJ+C297pt
         wPYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TW6wlmmfMd4aKumjZRuqMrr4jbBaACouFEXMzF3b4zg=;
        b=RDrnwyGligCKs4xydc8JuO8G9mXGSg788ix9Jn6ye6SwfIh5qAqQNEiF/b1mzzKFle
         bLxs+VjlhFL0gGocU6Ckgmq0SIWc4G827pzxLyokYCI5JOJHw/Lz+8Q2dP41AD7/ERDi
         /uk7zQEz23YoX7VTVi4rcQDkJoSC9AQ3TgxDuj8InbqEKGURPwsnyRXAnq4Si9YPrgoV
         vB2zFJ79wr51VWZ1tXy1RMwNS5kNhSxvybhSZL7pWWcR7kHw84cFc4bwskzKN1xGTCKG
         LxQZtcMLJGpMJy8l5ud6s5Dc8wrcq/h38xPKLm61Zi10d/uaMytjO5rN/ExE3jF+TEZE
         IFOA==
X-Gm-Message-State: AOAM533nkIWgu1M1SwcRQLXSK6x+vL+zypEjMaFRLbhiOWfcN1TbV/B3
        BeCXZYpwQtVg3p1+9QWEKhST9qe45u99VGAID3iXvQ==
X-Google-Smtp-Source: ABdhPJweWYHxudjQMVOBW7Gj3F73F5BA3V0qipJ2JCG/uVqPAPgDRT5YAo01pi8LD2GOO7+8Qz1tE17pXvY6Y28yD+k=
X-Received: by 2002:a17:90a:9403:: with SMTP id r3mr506486pjo.52.1601069833708;
 Fri, 25 Sep 2020 14:37:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200925211206.423598568@goodmis.org> <20200925211819.767526657@goodmis.org>
In-Reply-To: <20200925211819.767526657@goodmis.org>
From:   Axel Rasmussen <axelrasmussen@google.com>
Date:   Fri, 25 Sep 2020 14:36:37 -0700
Message-ID: <CAJHvVcjO=c7=k2-9=iQMh8t56FL-9duFX-FU0yu-HEX+1Da8YA@mail.gmail.com>
Subject: Re: [PATCH 1/3 v2] tracepoints: Add helper to test if tracepoint is
 enabled in a header
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Yafang Shao <laoar.shao@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michel Lespinasse <walken@google.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Linux MM <linux-mm@kvack.org>, Ingo Molnar <mingo@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 25, 2020 at 2:18 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
>
> As tracepoints are discouraged from being added in a header because it can
> cause side effects if other tracepoints are in headers, as well as bloat the
> kernel as the trace_<tracepoint>() function is not a small inline, the common
> workaround is to add a function call that calls a wrapper function in a
> C file that then calls the tracepoint. But as function calls add overhead,
> this function should only be called when the tracepoint in question is
> enabled. To get around this overhead, a static_branch can be used to only
> have the tracepoint wrapper get called when the tracepoint is enabled.
>
> Add a tracepoint_enabled(tp) macro that gets passed the name of the
> tracepoint, and this becomes a static_branch that is enabled when the
> tracepoint is enabled and is a nop when the tracepoint is disabled.
>
> Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
> ---
>  Documentation/trace/tracepoints.rst | 27 +++++++++++++++++++++++
>  include/linux/tracepoint-defs.h     | 34 +++++++++++++++++++++++++++++
>  2 files changed, 61 insertions(+)
>
> diff --git a/Documentation/trace/tracepoints.rst b/Documentation/trace/tracepoints.rst
> index 6e3ce3bf3593..68579ebd1e4c 100644
> --- a/Documentation/trace/tracepoints.rst
> +++ b/Documentation/trace/tracepoints.rst
> @@ -146,3 +146,30 @@ with jump labels and avoid conditional branches.
>        define tracepoints. Check http://lwn.net/Articles/379903,
>        http://lwn.net/Articles/381064 and http://lwn.net/Articles/383362
>        for a series of articles with more details.
> +
> +If you require calling a tracepoint from a header file, it is not
> +recommended to call one directly or to use the trace_<tracepoint>_enabled()
> +function call, as tracepoints in header files can have side effects if a
> +header is included from a file that has CREATE_TRACE_POINTS set, as
> +well as the trace_<tracepoint>() is not that small of an inline
> +and can bloat the kernel if used by other inlined functions. Instead,
> +include tracepoint-defs.h and use tracepoint_enabled().
> +
> +In a C file::
> +
> +       void do_trace_foo_bar_wrapper(args)
> +       {
> +               trace_foo_bar(args);
> +       }
> +
> +In the header file::
> +
> +       DECLEARE_TRACEPOINT(foo_bar);

Should be "DECLARE_..."

> +
> +       static inline void some_inline_function()
> +       {
> +               [..]
> +               if (tracepoint_enabled(foo_bar))
> +                       do_trace_foo_bar_wrapper(args);
> +               [..]
> +       }
> diff --git a/include/linux/tracepoint-defs.h b/include/linux/tracepoint-defs.h
> index b29950a19205..60625973faaf 100644
> --- a/include/linux/tracepoint-defs.h
> +++ b/include/linux/tracepoint-defs.h
> @@ -48,4 +48,38 @@ struct bpf_raw_event_map {
>         u32                     writable_size;
>  } __aligned(32);
>
> +/*
> + * If a tracepoint needs to be called from a header file, it is not
> + * recommended to call it directly, as tracepoints in header files
> + * may cause side-effects and bloat the kernel. Instead, use
> + * tracepoint_enabled() to test if the tracepoint is enabled, then if
> + * it is, call a wrapper function defined in a C file that will then
> + * call the tracepoint.
> + *
> + * For "trace_foo_bar()", you would need to create a wrapper function
> + * in a C file to call trace_foo_bar():
> + *   void do_trace_foo_bar(args) { trace_foo_bar(args); }
> + * Then in the header file, declare the tracepoint:
> + *   DECLARE_TRACEPOINT(foo_bar);
> + * And call your wrapper:
> + *   static inline void some_inlined_function() {
> + *            [..]
> + *            if (tracepoint_enabled(foo_bar))
> + *                    do_trace_foo_bar(args);
> + *            [..]
> + *   }
> + *
> + * Note: tracepoint_enabled(foo_bar) is equivalent to trace_foo_bar_enabled()
> + *   but is safe to have in headers, where trace_foo_bar_enabled() is not.
> + */
> +#define DECLARE_TRACEPOINT(tp) \
> +       extern struct tracepoint __tracepoint_##tp
> +
> +#ifdef CONFIG_TRACEPOINTS
> +# define tracepoint_enabled(tp) \
> +       static_key_false(&(__tracepoint_##tp).key)
> +#else
> +# define tracepoint_enabled(tracepoint) false
> +#endif
> +
>  #endif
> --
> 2.28.0
>
>
