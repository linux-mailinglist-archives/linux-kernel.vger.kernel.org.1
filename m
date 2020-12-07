Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 018802D10B1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 13:40:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725991AbgLGMiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 07:38:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725802AbgLGMiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 07:38:54 -0500
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E85B5C0613D2
        for <linux-kernel@vger.kernel.org>; Mon,  7 Dec 2020 04:38:13 -0800 (PST)
Received: by mail-qv1-xf41.google.com with SMTP id ek7so6378002qvb.6
        for <linux-kernel@vger.kernel.org>; Mon, 07 Dec 2020 04:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+PTUJT/idtBQgSL9lEX0jZu/szKSBgzCqPF6wc7xp2Q=;
        b=lnpAQpGw/wsXrdR6OuiE59SInOwI9VtKtoQei3IfL0CUsZHOB+/ZgLGcHMj6w7knjm
         YTuqEQ5IBby2T8/JU6wFbr+2IX7Awd0YYdE1IMASwbpJM1OukXm+AIyf4Z7ohuguGMT6
         yX/T85/VrUfc29FSu4hlSZpnD2oDr1+6UwWUaF0hLAvmJzVCLNlFJY33tlVqKM7VdFnc
         ryK/MFVHmKImImUUDAknbfNHKmmyapAUzEl+um6ochHpV9IDk5FLe59CLywOsDQRiZcR
         FXzrRjp9AwuTYjk9BZfC8NVwOJRMShOzcN5pxADn6mFmX2h4Qydn9oP7IWOBH82mh8lT
         U+Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+PTUJT/idtBQgSL9lEX0jZu/szKSBgzCqPF6wc7xp2Q=;
        b=OUj3sOZM1pp+gUcn0KN+5TTHPsSE6+Q8XAvmT4Q8iMKkS688ehbiLl/dh8xM228LYD
         oZ2V79jmWH1Yw18G6JltSG+Touz4jsi2jsETPUUJZDyPP6U75w2+w5z4RRmmIQPyqxrq
         K2bVzblu7Llpg6GOipBboj+MMo32+6vtItyX9bjalZAPAssyiVrj+ho4RPimhmTcd1Z9
         cURUp3Kypon/r1Y0Zbho0uPluHhOpoE6fM9H4IJLcTXDto1pWNb1Iw3zi3ubXqZw0Lwv
         ef8f15brRe0DQ1uxZMPkyZ12mO+hUmK8p35oUnnhxLcSKcz96yRTgpM9zpLc8r3hqFRc
         du/g==
X-Gm-Message-State: AOAM531WfTRqTKvlbZeUCKbT1V2p188wV24KMHODTggpOc4k5HustkpI
        tkxTYh1Z+LGWBpG5PDhm4XPqw3ilya/zK94/2eqJN3PKIqxRbg==
X-Google-Smtp-Source: ABdhPJzjbWfCnuyC2/6pGcPmUWwcw+i4f6EL2XJMxTt4XdurdcTaiVlF3e5aoEelANoit1NS/u9hbPhKmTB+p0chwN8=
X-Received: by 2002:a0c:b20d:: with SMTP id x13mr16917256qvd.18.1607344692881;
 Mon, 07 Dec 2020 04:38:12 -0800 (PST)
MIME-Version: 1.0
References: <20201204210000.660293c6@canb.auug.org.au> <20201204211923.a88aa12dc06b61780282dd1b@linux-foundation.org>
 <CACT4Y+bYVC=r+bPF7MziOZpJCYqrUj7CFt47Z5PSWjohZLYm+w@mail.gmail.com>
In-Reply-To: <CACT4Y+bYVC=r+bPF7MziOZpJCYqrUj7CFt47Z5PSWjohZLYm+w@mail.gmail.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 7 Dec 2020 13:38:01 +0100
Message-ID: <CACT4Y+bPPSQ1OgZ1NmUckOO2=07RE3C=deW6BpF0cOR9wnJsoA@mail.gmail.com>
Subject: Re: linux-next: build warning after merge of the akpm tree
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@google.com>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Kees Cook <keescook@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 7, 2020 at 1:08 PM Dmitry Vyukov <dvyukov@google.com> wrote:
> > > Hi all,
> > >
> > > After merging the akpm tree, today's linux-next build (powerpc
> > > allyesconfig) produced warnings like this:
> > >
> > > kernel/kcov.c:296:14: warning: conflicting types for built-in function '__sanitizer_cov_trace_switch'; expected 'void(long unsigned int,  void *)' [-Wbuiltin-declaration-mismatch]
> > >   296 | void notrace __sanitizer_cov_trace_switch(u64 val, u64 *cases)
> > >       |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> > Odd.  clang wants that signature, according to
> > https://clang.llvm.org/docs/SanitizerCoverage.html.  But gcc seems to
> > want a different signature.  Beats me - best I can do is to cc various
> > likely culprits ;)
> >
> > Which gcc version?  Did you recently update gcc?
> >
> > > ld: warning: orphan section `.data..Lubsan_data177' from `arch/powerpc/oprofile/op_model_pa6t.o' being placed in section `.data..Lubsan_data177'
> > >
> > > (lots of these latter ones)
> > >
> > > I don't know what produced these, but it is in the akpm-current or
> > > akpm trees.
>
> I can reproduce this in x86_64 build as well but only if I enable
> UBSAN as well. There were some recent UBSAN changes by Kees, so maybe
> that's what affected the warning.
> Though, the warning itself looks legit and unrelated to UBSAN. In
> fact, if the compiler expects long and we accept u64, it may be broken
> on 32-bit arches...

No, I think it works, the argument should be uint64.

I think both gcc and clang signatures are correct and both want
uint64_t. The question is just how uint64_t is defined :) The old
printf joke that one can't write portable format specifier for
uint64_t.

What I know so far:
clang 11 does not produce this warning even with obviously wrong
signatures (e.g. short).
I wasn't able to trigger it with gcc on 32-bits at all. KCOV is not
supported on i386 and on arm I got no warnings even with obviously
wrong signatures (e.g. short).
Using "(unsigned long val, void *cases)" fixes the warning on x86_64.

I am still puzzled why gcc considers this as a builtin because we
don't enable -fsanitizer-coverage on this file. I am also puzzled how
UBSAN affects things.

We could change the signature to long, but it feels wrong/dangerous
because the variable should really be 64-bits (long is broken on
32-bits).
Or we could introduce a typedef that is long on 64-bits and 'long
long' on 32-bits.
