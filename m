Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C179279597
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Sep 2020 02:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729672AbgIZAc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 20:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728966AbgIZAc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 20:32:26 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988AFC0613CE
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 17:32:26 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id x16so3150657pgj.3
        for <linux-kernel@vger.kernel.org>; Fri, 25 Sep 2020 17:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7A7wvtihbUasQazeiP5kITL56ahdnZrHt6WOUS33Asc=;
        b=HVnZBsEHgmW3ESkk4aqYC6omb7ULZ67kwqwmYAzjWXa8TFoXckg42OCH30+esk2XR/
         JfX9RwmhvwCqvbalZYs9m4D2OurZxqlQZPYuyoBjURcmTdvccFSmRzeRA8/fRvKCQwZ9
         FPHThA/lIi5usVvPporvNtzyOjRf2FXy5NP4AitESPgKrLXaw7oatYo/j0uwJiniuOBB
         7mtCUgcv/RI70ubwMXNjUXTQVSFYY1XR3Xo0cv2D5TMGHyOFH9gZfnJF6A5MMzrguywI
         gexqVSRF7o3ufOPaipuPFSV7J+LN7zejF+9/z4WiC5CAVUgsDsFTZMgjeQli8LILSaBh
         rEcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7A7wvtihbUasQazeiP5kITL56ahdnZrHt6WOUS33Asc=;
        b=diaJviRwrusmxjprX/5o175rOip2/ho5vRo8KIDEhXpAM4dIiB1X2mE2xcXBor2cs4
         umMz4o/5Vzbk1PvzVeVJYwpbSlAYNlqvDShtU9tztaGh0+/0K1LFLK+raJUjx166TF3E
         iEtrHSmYO3m1R7JGI2st0JIZhhNyqsRR5lpuU4ICUZaGiR6VuJvP9We2Q1TE6xam8z2R
         ow7I1O3NwkaF6xGAgWpsjdsb9viPeqMTAJedCDngarfKcu+50im40OjIc7YkPOF5x1/H
         kXIEKBpykMAmB2TaTOeqHs9nufvtZkqjX/qd0czZU1vozj9E9IIqR1dh+ED6KDjv4Zdt
         MeQA==
X-Gm-Message-State: AOAM533Oa4yZ26A2MtapiXperPiIQDODN/UkduxkfeyioZ0Xp2CXS0Lz
        zqzmQCGWDboB9DGbcrvWCy8qvHvsv69z03RApbEhIw==
X-Google-Smtp-Source: ABdhPJx6pOSmtqbXAf/q/7QSOjp9LtxM9Q98l5N8zdnNxxycPwufyGXGZK/XbULKxGHp8lEvBVU6puF3DZCWf+gxQ8s=
X-Received: by 2002:a63:78b:: with SMTP id 133mr1058914pgh.381.1601080345839;
 Fri, 25 Sep 2020 17:32:25 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000052569205afa67426@google.com> <20200919110831.GD7462@zn.tnic>
 <CACT4Y+ZhofJhNjfav22YNVpxtH4_+3Qaut6rOiqv4MLNU5mcEg@mail.gmail.com>
 <CACT4Y+b9ZCKJkOmwbEC6sZxEQ-9g2g=-v4+X0aWv7AsrZo7utA@mail.gmail.com>
 <CAKwvOdmKcn=FNzwtBZ8z0evLz4BXgWtsoz9+QTC6GLqtNp1bXg@mail.gmail.com>
 <20200921221336.GN5901@zn.tnic> <CAKwvOd=E11KriNqeVv2-Tvq5sQy=4vyBzDEH22D5h5LgBeFsVw@mail.gmail.com>
 <20200923090336.GD28545@zn.tnic> <CACT4Y+Y4-vqdv01ebyzhUoggUCUyvbhjut7Wvj=r4dBfyxLeng@mail.gmail.com>
 <20200923103431.GF28545@zn.tnic> <CACT4Y+ayTBwBwsnV9Kp-vMQ=hgu9-r9g4qzAfd+HdQXX95PX9g@mail.gmail.com>
 <CACT4Y+bjyAfO-TRjBHT9wR194=prH2C284Oc9akVVHR1492WZA@mail.gmail.com>
In-Reply-To: <CACT4Y+bjyAfO-TRjBHT9wR194=prH2C284Oc9akVVHR1492WZA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 25 Sep 2020 17:32:14 -0700
Message-ID: <CAKwvOdkYEP=oRtEu_89JBq2g41PL9_FuFyfeB94XwBKuSz4XLg@mail.gmail.com>
Subject: Re: general protection fault in perf_misc_flags
To:     Dmitry Vyukov <dvyukov@google.com>, Borislav Petkov <bp@alien8.de>
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
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

On Fri, Sep 25, 2020 at 5:22 AM Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Wed, Sep 23, 2020 at 5:20 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> >
> > On Wed, Sep 23, 2020 at 12:34 PM Borislav Petkov <bp@alien8.de> wrote:
> > >
> > > On Wed, Sep 23, 2020 at 11:24:48AM +0200, Dmitry Vyukov wrote:
> > > > 3. Run syzkaller locally with custom patches.
> > >
> > > Let's say I wanna build the kernel with clang-10 using your .config and
> > > run it in a vm locally. What are the steps in order to reproduce the
> > > same workload syzkaller runs in the guest on the GCE so that I can at
> > > least try get as close as possible to reproducing locally?
> >
> > It's a random fuzzing workload. You can get this workload by running
> > syzkaller locally:
> > https://github.com/google/syzkaller/blob/master/docs/linux/setup_ubuntu-host_qemu-vm_x86-64-kernel.md

These are virtualized guests, right?  Has anyone played with getting
`rr` working to record traces of guests in QEMU?

I had seen the bug that generated this on github:
https://julialang.org/blog/2020/09/rr-memory-magic/

That way, even if syzkaller didn't have a reproducer binary, it would
at least have a replayable trace.

Boris, one question I have. Doesn't the kernel mark pages backing
executable code as read only at some point?  If that were the case,
then I don't see how the instruction stream could be modified.  I
guess static key patching would have to undo that permission mapping
before patching.

You're right about the length shorter than what I would have expected
from static key patching.  That could very well be a write through
dangling int pointer...

> >
> > The exact clang compiler syzbot used is available here:
> > https://github.com/google/syzkaller/blob/master/docs/syzbot.md#crash-does-not-reproduce
>
> I've marked all other similar ones a dup of this one. Now you can see
> all manifestations on the dashboard:
> https://syzkaller.appspot.com/bug?extid=ce179bc99e64377c24bc
>
> Another possible debugging vector on this:
> The location of crashes does not seem to be completely random and
> evenly spread across kernel code. I think there are many more static
> branches (mm, net), but we have 3 crashes in vdso and 9 in paravirt
> code + these 6 crashes in perf_misc_flags which looks a bit like an
> outlier (?). What's special about paravirt/vdso?..



-- 
Thanks,
~Nick Desaulniers
