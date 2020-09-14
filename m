Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 804B82695C1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 21:39:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726061AbgINTjk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 15:39:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725914AbgINTji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 15:39:38 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA7AC06174A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 12:39:38 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id b12so712244edz.11
        for <linux-kernel@vger.kernel.org>; Mon, 14 Sep 2020 12:39:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lG5XGf95bwNJOiL8PcjSLhdHd8W32J8QXR/kZviOKdg=;
        b=KMb8YL82jYt+MdR+06nAv1SDjyBvY4xZgeT/ZSDzaA/sIk4BMgBJiDBRB+e1bufy3+
         8ZUWjMH8ilySI8ll0tpW9SGHNcwfcXvuO/ogAr+JiAJ+gLYB2oFiAISVMsXaZiFZKhG6
         rNV9jXE4AzKiGnJtbZ01dTfsAaRXm01QgaG5C8WCbA0mkKFr6J1uj1+DZPrJ9hzkpFLt
         7CafX7kXEWTa72gmB4FzIyzXC1KrE0sLckGmAtvfbSZqoUxrNCh+knJSNyZnBMhxAxTx
         dNPT5gnmXVGLWsSSXLj6HwJ+ZnTlIAmp/gH/hWa2wQfaMmrOBh6HBlLkbN6H+zlGsjQ8
         UTIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lG5XGf95bwNJOiL8PcjSLhdHd8W32J8QXR/kZviOKdg=;
        b=QmmJuz3vFGdWC9AJEgauqoX481GHClD0j4tnZHr18AHBQ5QO9zZ5mRaA2PVKMowrS/
         lG7ieufcnqKYnCPjf/2D3UlFz7zzYd+g//1H17oI31RjgSJCrPYgLj7BsRTz6C09Mcak
         MeJfDpbTrMhSM/GFmReOTnbDdA8QA4bq4/SHdGfdZ49JhpQ49Jiy6quembivzouqsYnc
         TwlmpmESZZYwITze1OqoP22QRIfrHK57bPVTDNrkJRXxGs6RCYcJEGww7gHDwL2L0n6U
         dL2OFELYlqkEU4E623HdCo3z9Ieos8ylOct9xyghmvq+DeHFYuH+4yWCyLP+yZ9n2iyV
         P1LA==
X-Gm-Message-State: AOAM533nS983c5P8lqhLMIbEm0MRGRJ6x1avP9RMZ4qugfeOCFPCLoyj
        KyKenxNJIBvgWOHXo9kjd7mxP30ufu5uEXNo3au6Ug==
X-Google-Smtp-Source: ABdhPJxc/PtfgEbkD4fcsDei9QMBxurLSxbpcXluh3HHDXLs/uUkzi3B73RmIjNWnbIXKDpCIS3Fg5qNSvIHPX0J6v4=
X-Received: by 2002:a50:e807:: with SMTP id e7mr19255309edn.84.1600112376719;
 Mon, 14 Sep 2020 12:39:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200910202107.3799376-1-keescook@chromium.org>
 <20200910202107.3799376-6-keescook@chromium.org> <202009101634.52ED6751AD@keescook>
 <CAG48ez2fP7yupg6Th+Hg0tL3o06p2PR1HtQcvy4Ro+Q5T2Nfkw@mail.gmail.com> <20200913152724.GB2873@ubuntu>
In-Reply-To: <20200913152724.GB2873@ubuntu>
From:   Jann Horn <jannh@google.com>
Date:   Mon, 14 Sep 2020 21:39:10 +0200
Message-ID: <CAG48ez3aQXb3EuGRVvLLo7BxycqJ4Y2mL83QhY9-QMK_qkfCuQ@mail.gmail.com>
Subject: Re: [RFC PATCH 5/6] security/fbfam: Detect a fork brute force attack
To:     John Wood <john.wood@gmx.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Matthew Wilcox <willy@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Iurii Zaikin <yzaikin@google.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>, linux-doc@vger.kernel.org,
        kernel list <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 13, 2020 at 6:56 PM John Wood <john.wood@gmx.com> wrote:
> On Fri, Sep 11, 2020 at 02:01:56AM +0200, Jann Horn wrote:
> > On Fri, Sep 11, 2020 at 1:49 AM Kees Cook <keescook@chromium.org> wrote:
> > > On Thu, Sep 10, 2020 at 01:21:06PM -0700, Kees Cook wrote:
> > > > diff --git a/fs/coredump.c b/fs/coredump.c
> > > > index 76e7c10edfc0..d4ba4e1828d5 100644
> > > > --- a/fs/coredump.c
> > > > +++ b/fs/coredump.c
> > > > @@ -51,6 +51,7 @@
> > > >  #include "internal.h"
> > > >
> > > >  #include <trace/events/sched.h>
> > > > +#include <fbfam/fbfam.h>
> > > >
> > > >  int core_uses_pid;
> > > >  unsigned int core_pipe_limit;
> > > > @@ -825,6 +826,7 @@ void do_coredump(const kernel_siginfo_t *siginfo)
> > > >  fail_creds:
> > > >       put_cred(cred);
> > > >  fail:
> > > > +     fbfam_handle_attack(siginfo->si_signo);
> > >
> > > I don't think this is the right place for detecting a crash -- isn't
> > > this only for the "dumping core" condition? In other words, don't you
> > > want to do this in get_signal()'s "fatal" block? (i.e. very close to the
> > > do_coredump, but without the "should I dump?" check?)
> > >
> > > Hmm, but maybe I'm wrong? It looks like you're looking at noticing the
> > > process taking a signal from SIG_KERNEL_COREDUMP_MASK ?
> > >
> > > (Better yet: what are fatal conditions that do NOT match
> > > SIG_KERNEL_COREDUMP_MASK, and should those be covered?)
> > >
> > > Regardless, *this* looks like the only place without an LSM hook. And it
> > > doesn't seem unreasonable to add one here. I assume it would probably
> > > just take the siginfo pointer, which is also what you're checking.
> >
> > Good point, making this an LSM might be a good idea.
> >
> > > e.g. for include/linux/lsm_hook_defs.h:
> > >
> > > LSM_HOOK(int, 0, task_coredump, const kernel_siginfo_t *siginfo);
> >
> > I guess it should probably be an LSM_RET_VOID hook? And since, as you
> > said, it's not really semantically about core dumping, maybe it should
> > be named task_fatal_signal or something like that.
>
> If I understand correctly you propose to add a new LSM hook without return
> value and place it here:
>
> diff --git a/kernel/signal.c b/kernel/signal.c
> index a38b3edc6851..074492d23e98 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -2751,6 +2751,8 @@ bool get_signal(struct ksignal *ksig)
>                         do_coredump(&ksig->info);
>                 }
>
> +               // Add the new LSM hook here
> +
>                 /*
>                  * Death signals, no core dump.
>                  */

It should probably be in the "if (sig_kernel_coredump(signr)) {"
branch. And I'm not sure whether it should be before or after
do_coredump() - if you do it after do_coredump(), the hook will have
to wait until the core dump file has been written, which may take a
little bit of time.
