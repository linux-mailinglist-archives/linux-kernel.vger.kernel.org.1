Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7247B279751
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 08:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbgIZGrH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Sep 2020 02:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726037AbgIZGrH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Sep 2020 02:47:07 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F54C0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 23:47:07 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id d1so4227965qtr.6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 23:47:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0UiAMmLV3chB4WVnJpu5YMg6M65xGLtvRdJzsmaCauk=;
        b=msjlhrZAS9Z1A4+YKQkGnuOQtxQgvmljON6WA7gkZnZLaOLTD8uriI6oU6Q6s6KVAv
         9pD91LJF3BVTWHtI0LW9Olgj6d3bQJsMMal7SlLsN+0ZgqxTWmI/MdJrfIGjzef5juTc
         xpWQOnaf81Ei/Ap1eiCDjq5HHxL6ZeoJsgONPi+QGLgNVyom/rZTdm4NqgI8B9Bb3yRv
         F7HX+92PZAQNr87gYeZlX/rgmkWcMAFMov0lBE9o33oQjviGknLYUBHbdeBPwLr6ZTnO
         t2V2O+s3DAE480cVZ4AcC0mT8xY7+XFpH7pL0WTlM5QtMcrDew1WHdENqU/y8zmc5dvE
         JeVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0UiAMmLV3chB4WVnJpu5YMg6M65xGLtvRdJzsmaCauk=;
        b=CJU3Sz3Wwobeg+N6UjijBAD14FcVM19LKG7GEQci+snFppaDfRtGBaisSekWwP4pTJ
         PECTo6R8Xbq89JITjHhH2HiSBd+z4qKv/ixo08NS4dSSK1ZLBsKdZ/gZh3FxLlOc6dcC
         jm1iS58FXCMPjpvA0OxBx8mZBSnDg0NDjERDF/GBxi/Ib0jfDYca0+mC7w/rCpcuhKfe
         NMEWQFz4kO8XOJ9RAJhuyxHlFbvooODO0FMjTbpN4K4tgnKfIghi7P6hSmoYnZk/lBYc
         w7FFwV03RCGSsVJRCoPrsi3yYl6GwRtVHXMUwajn9uOjnDdIrBw7HfKiGjmm+yk2XMcd
         Q2Sg==
X-Gm-Message-State: AOAM533cQPK7afy/GkehGY/cmLTSKi+v1q3DOlZZDDDaf7KFWrMbrp/Z
        yXAU452BPDPVaiojawNdbPX+9sebM4sVzQ1NQgHmfQ==
X-Google-Smtp-Source: ABdhPJzwxTkn5V+Fh0IiM+1vMU4uPZorP/C+8s+hF6uzJJtZ/S/8/5d8/1X91dUfAFsFgjRqRn5e8i6JE/rtnsl1dSE=
X-Received: by 2002:ac8:4806:: with SMTP id g6mr3318476qtq.380.1601102826168;
 Fri, 25 Sep 2020 23:47:06 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000052569205afa67426@google.com> <20200919110831.GD7462@zn.tnic>
 <CACT4Y+ZhofJhNjfav22YNVpxtH4_+3Qaut6rOiqv4MLNU5mcEg@mail.gmail.com>
 <CACT4Y+b9ZCKJkOmwbEC6sZxEQ-9g2g=-v4+X0aWv7AsrZo7utA@mail.gmail.com>
 <CAKwvOdmKcn=FNzwtBZ8z0evLz4BXgWtsoz9+QTC6GLqtNp1bXg@mail.gmail.com>
 <20200921221336.GN5901@zn.tnic> <CAKwvOd=E11KriNqeVv2-Tvq5sQy=4vyBzDEH22D5h5LgBeFsVw@mail.gmail.com>
 <20200923090336.GD28545@zn.tnic> <CACT4Y+Y4-vqdv01ebyzhUoggUCUyvbhjut7Wvj=r4dBfyxLeng@mail.gmail.com>
 <20200923103431.GF28545@zn.tnic> <CACT4Y+ayTBwBwsnV9Kp-vMQ=hgu9-r9g4qzAfd+HdQXX95PX9g@mail.gmail.com>
 <CACT4Y+bjyAfO-TRjBHT9wR194=prH2C284Oc9akVVHR1492WZA@mail.gmail.com> <CAKwvOdkYEP=oRtEu_89JBq2g41PL9_FuFyfeB94XwBKuSz4XLg@mail.gmail.com>
In-Reply-To: <CAKwvOdkYEP=oRtEu_89JBq2g41PL9_FuFyfeB94XwBKuSz4XLg@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Sat, 26 Sep 2020 08:46:54 +0200
Message-ID: <CACT4Y+YhLFzkoqfUWy3rh86KnpLEaffGHXhfk1xSv__60uvGeQ@mail.gmail.com>
Subject: Re: general protection fault in perf_misc_flags
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Borislav Petkov <bp@alien8.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        syzbot <syzbot+ce179bc99e64377c24bc@syzkaller.appspotmail.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Jiri Olsa <jolsa@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 26, 2020 at 2:32 AM 'Nick Desaulniers' via syzkaller-bugs
<syzkaller-bugs@googlegroups.com> wrote:
> > > > On Wed, Sep 23, 2020 at 11:24:48AM +0200, Dmitry Vyukov wrote:
> > > > > 3. Run syzkaller locally with custom patches.
> > > >
> > > > Let's say I wanna build the kernel with clang-10 using your .config and
> > > > run it in a vm locally. What are the steps in order to reproduce the
> > > > same workload syzkaller runs in the guest on the GCE so that I can at
> > > > least try get as close as possible to reproducing locally?
> > >
> > > It's a random fuzzing workload. You can get this workload by running
> > > syzkaller locally:
> > > https://github.com/google/syzkaller/blob/master/docs/linux/setup_ubuntu-host_qemu-vm_x86-64-kernel.md
>
> These are virtualized guests, right?  Has anyone played with getting
> `rr` working to record traces of guests in QEMU?
>
> I had seen the bug that generated this on github:
> https://julialang.org/blog/2020/09/rr-memory-magic/
>
> That way, even if syzkaller didn't have a reproducer binary, it would
> at least have a replayable trace.

These are virtualized guests, but they run on GCE, not in QEMU.

> Boris, one question I have. Doesn't the kernel mark pages backing
> executable code as read only at some point?  If that were the case,
> then I don't see how the instruction stream could be modified.  I
> guess static key patching would have to undo that permission mapping
> before patching.
>
> You're right about the length shorter than what I would have expected
> from static key patching.  That could very well be a write through
> dangling int pointer...
>
> > >
> > > The exact clang compiler syzbot used is available here:
> > > https://github.com/google/syzkaller/blob/master/docs/syzbot.md#crash-does-not-reproduce
> >
> > I've marked all other similar ones a dup of this one. Now you can see
> > all manifestations on the dashboard:
> > https://syzkaller.appspot.com/bug?extid=ce179bc99e64377c24bc
> >
> > Another possible debugging vector on this:
> > The location of crashes does not seem to be completely random and
> > evenly spread across kernel code. I think there are many more static
> > branches (mm, net), but we have 3 crashes in vdso and 9 in paravirt
> > code + these 6 crashes in perf_misc_flags which looks a bit like an
> > outlier (?). What's special about paravirt/vdso?..
>
>
>
> --
> Thanks,
> ~Nick Desaulniers
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/CAKwvOdkYEP%3DoRtEu_89JBq2g41PL9_FuFyfeB94XwBKuSz4XLg%40mail.gmail.com.
