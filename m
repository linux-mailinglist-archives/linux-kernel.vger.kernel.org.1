Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 042F229A836
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 10:49:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895977AbgJ0JtW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 05:49:22 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:43600 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2895968AbgJ0JtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 05:49:21 -0400
Received: by mail-yb1-f194.google.com with SMTP id d15so692605ybl.10
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 02:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EoN33UgcFziWWiQ4PnBVNhZP5pXbQCgzUb9zsOxzaek=;
        b=m3oiTCTdji6IvQxnLYvCHd8m57mQNKKf1qrsXcP2EKUZis+8+nzcNkX1bzdpt9/pnn
         EsDh2YrPJ4+53nJ6bjkecTfDxu/7jcHJVGwMHjsSUBql7MasdHoFGjOJqRfya3MalFNT
         Se2zF1NimiKx8R1NPMFAmsgLiDp1d/0rsm9H+YyDoTlgvk6LUcqCcUmTir5lAcgUrxAt
         ylbtlPW0s6DyDiUYvIntKsQUtUAA6GswRsb0XPwwQw1QnM+SzFNkT1n+E4NIOrUVq3Ip
         M6G2jE3WabJs078e/c5lGJJoJF24KLMQHxnzCkBNvMVP+TFfzW7Z4mKeEE5IrxoDn5Bq
         nhPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EoN33UgcFziWWiQ4PnBVNhZP5pXbQCgzUb9zsOxzaek=;
        b=jen5A+HkxkJ4zEdy6SqRHh0gUT1uqyRtdJb/tP+eHa92wQvfSOOw2hB/0pGpaNBF3H
         mg1pedSpGHvRz19eXkHxYOHQzbjNdHbHBQIEdROft48V4lJY0Wf8n+6TtDpDKOPaR/Kc
         UOQRSgktq9KXZx+uicdQmiLuDY/namr6o50YT+ZdRydcxDYHd7DR4qz3rBU14Zrx0x2p
         yFNNVedTHT0XtfFg7nVQ7w1o7z9NhvDaLIpKwBO1qzQAWHOfKrQLHzUcfxsFgbR5tSi3
         4mAfpPytzlVMAgSFmsiGwoQcrwrMamLrjUAxQC9ul7xaycwtehMQPoC405YyEkEp5kST
         338A==
X-Gm-Message-State: AOAM531aDHrP9cOzcqvNkhsvY+n4ZLD7y70FYgdDW2BzwIhOFML1nBYn
        CSAgZJSw6F3zedLq8tV++AMgqRRSvU9oXPTUbe0=
X-Google-Smtp-Source: ABdhPJz7IpNwgeFvWmWqXmQak5tvQ2tRy5W9xPtR2zzyv04QtOqgE4wuIY+OzY9pI+QnJ5d6dA8Fx2KMQIKYB2DAooM=
X-Received: by 2002:a25:2389:: with SMTP id j131mr1833294ybj.25.1603792159885;
 Tue, 27 Oct 2020 02:49:19 -0700 (PDT)
MIME-Version: 1.0
References: <a5cf643b-842f-7a60-73c7-85d738a9276f@suse.com>
 <20201026114009.GN2594@hirez.programming.kicks-ass.net> <0c0d815c-bd5a-ff2d-1417-28a41173f2b4@suse.com>
 <20201026125524.GP2594@hirez.programming.kicks-ass.net> <20201026152256.GB2651@hirez.programming.kicks-ass.net>
In-Reply-To: <20201026152256.GB2651@hirez.programming.kicks-ass.net>
From:   Anatoly Pugachev <matorola@gmail.com>
Date:   Tue, 27 Oct 2020 12:49:10 +0300
Message-ID: <CADxRZqxjw7wdfQw8DoD2DvQyhJKaW0C01wWYGMD-+L2au_jGBw@mail.gmail.com>
Subject: Re: possible lockdep regression introduced by 4d004099a668 ("lockdep:
 Fix lockdep recursion")
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Filipe Manana <fdmanana@suse.com>,
        LKML <linux-kernel@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        David Sterba <dsterba@suse.com>, Ingo Molnar <mingo@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 26, 2020 at 6:23 PM Peter Zijlstra <peterz@infradead.org> wrote:
> On Mon, Oct 26, 2020 at 01:55:24PM +0100, Peter Zijlstra wrote:
> > On Mon, Oct 26, 2020 at 11:56:03AM +0000, Filipe Manana wrote:
> > > > That smells like the same issue reported here:
> > > >
> > > >   https://lkml.kernel.org/r/20201022111700.GZ2651@hirez.programming.kicks-ass.net
> > > >
> > > > Make sure you have commit:
> > > >
> > > >   f8e48a3dca06 ("lockdep: Fix preemption WARN for spurious IRQ-enable")
> > > >
> > > > (in Linus' tree by now) and do you have CONFIG_DEBUG_PREEMPT enabled?
> > >
> > > Yes, CONFIG_DEBUG_PREEMPT is enabled.
> >
> > Bummer :/
> >
> > > I'll try with that commit and let you know, however it's gonna take a
> > > few hours to build a kernel and run all fstests (on that test box it
> > > takes over 3 hours) to confirm that fixes the issue.
> >
> > *ouch*, 3 hours is painful. How long to make it sick with the current
> > kernel? quicker I would hope?
> >
> > > Thanks for the quick reply!
> >
> > Anyway, I don't think that commit can actually explain the issue :/
> >
> > The false positive on lockdep_assert_held() happens when the recursion
> > count is !0, however we _should_ be having IRQs disabled when
> > lockdep_recursion > 0, so that should never be observable.
> >
> > My hope was that DEBUG_PREEMPT would trigger on one of the
> > __this_cpu_{inc,dec}(lockdep_recursion) instance, because that would
> > then be a clear violation.
> >
> > And you're seeing this on x86, right?
> >
> > Let me puzzle moar..
>
> So I might have an explanation for the Sparc64 fail, but that can't
> explain x86 :/
>
> I initially thought raw_cpu_read() was OK, since if it is !0 we have
> IRQs disabled and can't get migrated, so if we get migrated both CPUs
> must have 0 and it doesn't matter which 0 we read.
>
> And while that is true; it isn't the whole store, on pretty much all
> architectures (except x86) this can result in computing the address for
> one CPU, getting migrated, the old CPU continuing execution with another
> task (possibly setting recursion) and then the new CPU reading the value
> of the old CPU, which is no longer 0.
>
> I already fixed a bunch of that in:
>
>   baffd723e44d ("lockdep: Revert "lockdep: Use raw_cpu_*() for per-cpu variables"")
>
> but clearly this one got crossed.
>
> Still, that leaves me puzzled over you seeing this on x86 :/
>
> Anatoly, could you try linus+tip/locking/urgent and the below on your
> Sparc, please?

Peter,
let me test first. Thanks.

PS: sorry for the delay, a weekend and got ill a bit ...
