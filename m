Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49A991C5A02
	for <lists+linux-kernel@lfdr.de>; Tue,  5 May 2020 16:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729477AbgEEOuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 May 2020 10:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729060AbgEEOuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:50:22 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57DE6C061A10
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:50:22 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id ep1so1123384qvb.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 07:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7Pq81uf2psyNx4BKzdHn/TmsDqiXEasycTFHLZy0fzE=;
        b=Zxm+Rr7lLpiJvdemTptDsL+2zZbM+zXHxnpdq+7kYHi/FEzupKH81Jbj7V1OVb18eS
         edWuL+9LercKknTbWawmw/cdwJ956rvQ8sV52vF4ouxcaSQ0iqd+ZhOnIWDlIwCg/mTp
         ZwSkJEC1OCq5d4PdGYXyCVS2NPE7z3MUKA8AuJY7GoxHXcdxEBL+o1Q8Ha7B6xsEcgsA
         OaJZj0Ugis6t9KWvqLg1zUTYYsoXtAFuWiG+HKeOZYnKMx8LuB5MWucR0iq4aP0KFYpq
         WZB9VQE3+obD8DWNcYtJB/drR0OIcwtB03B8jG7w15m7OtCLwcOzw5OKDtcNSFaDYh1O
         BjFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7Pq81uf2psyNx4BKzdHn/TmsDqiXEasycTFHLZy0fzE=;
        b=r9JYo9hIXYmpO6MQc/TAmPjxW1TDLZr9eft7jx74oLD3rIgCYFwMjbds+nj6mniwY5
         /X8vrxTjBq8+sXDeZkB1UCm8E6wGTrQHPk+mRQou06J7RDl0qpAo9D2Qs6Rj5qJyZ1Fk
         P/196Gnjkx8yHT3d1D85kWgoNcgsZjKuAbA3vvmQNokYysw5JiA8w/G4RhNeFXhYww/c
         3/pEmEABAUuJYcmogCfq+lyGaTnFc1sA3aZPK/ybbHf+571dNMVoWuGB0Jzr6a66YpzR
         PVXI6lXfoGlw72w+1W7PQSNw/xxDCeGmEGPm1wffumWSo5p+k7ysIVJkguCPfPAnuVVH
         sYsg==
X-Gm-Message-State: AGi0PuYiBvfYHbqz9Tkz6GOpwD8SSZsLPmozWYP9azidoJsBxzEU24ai
        JX2QDohLxZMkxZFP3txPKKFryuTRKP64xyMXzktABA==
X-Google-Smtp-Source: APiQypL5uhC5XiH0WsPbx22wf8V5dxjjLdEZtLGl6qTwkFsmYzmexrrDZNczy6mxkMB1ZWimXKgUEcTpCfzri9Dvd+U=
X-Received: by 2002:a0c:f8cf:: with SMTP id h15mr2976751qvo.22.1588690221148;
 Tue, 05 May 2020 07:50:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200505142341.1096942-1-arnd@arndb.de> <CANpmjNMtGy6YK8zuqf0dmkykZMt=qkxkZrZNEKde1nbw84ZLkg@mail.gmail.com>
In-Reply-To: <CANpmjNMtGy6YK8zuqf0dmkykZMt=qkxkZrZNEKde1nbw84ZLkg@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 5 May 2020 16:50:09 +0200
Message-ID: <CACT4Y+Zpp=+JJedhMpunuUh832eJFu+af-r8631Ar0kE2nv72A@mail.gmail.com>
Subject: Re: [PATCH] ubsan, kcsan: don't combine sanitizer with kcov
To:     Marco Elver <elver@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Kees Cook <keescook@chromium.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Thomas Gleixner <tglx@linutronix.de>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 5, 2020 at 4:36 PM Marco Elver <elver@google.com> wrote:
> > Clang does not allow -fsanitize-coverage=trace-{pc,cmp} together
> > with -fsanitize=bounds or with ubsan:
> >
> > clang: error: argument unused during compilation: '-fsanitize-coverage=trace-pc' [-Werror,-Wunused-command-line-argument]
> > clang: error: argument unused during compilation: '-fsanitize-coverage=trace-cmp' [-Werror,-Wunused-command-line-argument]
> >
> > To avoid that case, add a Kconfig dependency. The dependency could
> > go either way, disabling CONFIG_KCOV or CONFIG_UBSAN_BOUNDS when the
> > other is set. I picked the second option here as this seems to have
> > a smaller impact on the resulting kernel.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> >  lib/Kconfig.kcsan | 2 +-
> >  lib/Kconfig.ubsan | 1 +
> >  2 files changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/lib/Kconfig.kcsan b/lib/Kconfig.kcsan
> > index ea28245c6c1d..8f856c8828d5 100644
> > --- a/lib/Kconfig.kcsan
> > +++ b/lib/Kconfig.kcsan
> > @@ -5,7 +5,7 @@ config HAVE_ARCH_KCSAN
> >
> >  menuconfig KCSAN
> >         bool "KCSAN: dynamic data race detector"
> > -       depends on HAVE_ARCH_KCSAN && DEBUG_KERNEL && !KASAN
> > +       depends on HAVE_ARCH_KCSAN && DEBUG_KERNEL && !KASAN && !KCOV
>
> This also disables KCOV with GCC. Why does this not work with KCSAN?
>
> This is a huge problem for us, since syzbot requires KCOV. In fact
> I've always been building KCSAN kernels with CONFIG_KCOV=y (with GCC
> or Clang) and cannot reproduce the problem.
>
> >         select STACKTRACE
> >         help
> >           The Kernel Concurrency Sanitizer (KCSAN) is a dynamic
> > diff --git a/lib/Kconfig.ubsan b/lib/Kconfig.ubsan
> > index 929211039bac..f98ef029553e 100644
> > --- a/lib/Kconfig.ubsan
> > +++ b/lib/Kconfig.ubsan
> > @@ -29,6 +29,7 @@ config UBSAN_TRAP
> >  config UBSAN_BOUNDS
> >         bool "Perform array index bounds checking"
> >         default UBSAN
> > +       depends on !(CC_IS_CLANG && KCOV)
>
> Ditto, we really need KCOV for all sanitizers. I also just tried to
> reproduce the problem but can't.
>
> Which version of clang is causing this? I'm currently using Clang 9.
> My guess is that we should not fix this by disallowing KCOV, but
> rather make Clang work with these configs.
>
> Dmitry, can you comment?

FWIW I can reproduce both with clang:

$ clang /tmp/test.c -c -fsanitize-coverage=trace-pc -fsanitize=bounds
clang-11: warning: argument unused during compilation:
'-fsanitize-coverage=trace-pc' [-Wunused-command-line-argument]

$ clang /tmp/test.c -c -fsanitize-coverage=trace-pc -fsanitize=thread
clang-11: warning: argument unused during compilation:
'-fsanitize-coverage=trace-pc' [-Wunused-command-line-argument]

with both my disto's 9.0.1 and fresher 11.0.0
(7b80cb7cf45faf462d6193cc41c2cb7ad556600d.

But both work with gcc

$ gcc /tmp/test.c -c -fsanitize-coverage=trace-pc -fsanitize=thread
$ gcc /tmp/test.c -c -fsanitize-coverage=trace-pc -fsanitize=bounds

Is it a known issue in clang?

Can we somehow disable it only for clang and not gcc?

This will immediately break KCSAN on syzbot as it enables KCSAN and KCOV:
https://syzkaller.appspot.com/upstream?manager=ci2-upstream-kcsan-gce
