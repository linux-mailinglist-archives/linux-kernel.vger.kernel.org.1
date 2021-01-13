Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43F922F5803
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jan 2021 04:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbhANCMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jan 2021 21:12:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729236AbhAMWAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jan 2021 17:00:52 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71BE4C061795
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 14:00:11 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id by27so3570393edb.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jan 2021 14:00:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mT4FJ5faHT6kx4m/+VpI3KjNLQvDBDZDe9LTS609qwU=;
        b=uT51003CLT7E627tBqLkwWrU1PVJGq2/ZMQqORYgP/O2pHjSbQU/+++0TXmm4i8is6
         OARUSIgqWunXkWiEvn7QA6CKb35uF8Ku1QQbQxnLocI54fY87d1EbdIGaxJQgPGPPNpG
         sKynEK0BQxUKiAsyo3I9mUReOW0Yrn9p14437+A6dsPP1Ah98uXS0jQMFvcovol60ZyS
         mpErIteohbvU2Vbc+tBEoTDcHUGjD8plBHS/VvZ8bC2qUmYs/Fh4YqJFb8PwkbC7S/Rl
         h50qDhicSqelFiRP/M/ZqC6YzDMO9fwpdFAwGPpyDIkmBqB7cEsEmSgmsxP3cOFv8Hau
         BwqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mT4FJ5faHT6kx4m/+VpI3KjNLQvDBDZDe9LTS609qwU=;
        b=HeIpPVMvjYsTokl/Gj6mj8MGKCkgrlXbJvbvyliC8VWDITYUKDfD1aDvoUYwElzwug
         sSfvRduZ48juF9Se2FaoYPva2yKiSVwumAXcSM1H9SpgxQSpzV7IxpGVPO0B2A+5cXXJ
         dJQEPA6RO+Pn7Y/xzzJ6HagjKriKkPFIbWuLDsFrdAA7vraH4WC/4uYr0aJ+h25u97c6
         MHAVwrAzdQ+ApRwsDWzvhNXl7i0NmbEz5IDJUoXIojPC4JyjUqrx0BJPkjH+/CipOQyG
         lbypkVxs7jrYYQAJobUJmvHDhB647fHx3ss5iXj4x/3M8AcBkKlCVM4ICO6Z5qY4zzp/
         axog==
X-Gm-Message-State: AOAM533RjyFkPN/TZSUeNpCdvf5XdL2jLYJe4Rfujs4cI6/IKGq8ASXd
        HEHN1/8pwwC06Tsq0396c/ay6R1anUC1JUwM6ZLv
X-Google-Smtp-Source: ABdhPJyE5JEDE4oM6JhTLtfMhJ6qJ3TrnMrYS6u1lrad/w+TvlD7eZ8Y1v59rsqWDpKMCpdfypcrgKeOBUbXOvRRpc4=
X-Received: by 2002:a05:6402:513:: with SMTP id m19mr3469396edv.244.1610575209296;
 Wed, 13 Jan 2021 14:00:09 -0800 (PST)
MIME-Version: 1.0
References: <20210112053113.4180271-1-morbo@google.com> <20210113061958.886723-1-morbo@google.com>
 <20210113205547.GA21653@Ryzen-9-3900X.localdomain>
In-Reply-To: <20210113205547.GA21653@Ryzen-9-3900X.localdomain>
From:   Bill Wendling <morbo@google.com>
Date:   Wed, 13 Jan 2021 13:59:57 -0800
Message-ID: <CAGG=3QVK9KvxDi7b51Fyh=NLKVQka8ZxJeWzchaiDM=78_X3Tw@mail.gmail.com>
Subject: Re: [PATCH v4] pgo: add clang's Profile Guided Optimization infrastructure
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Sami Tolvanen <samitolvanen@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 13, 2021 at 12:55 PM Nathan Chancellor
<natechancellor@gmail.com> wrote:
>
> Hi Bill,
>
> On Tue, Jan 12, 2021 at 10:19:58PM -0800, Bill Wendling wrote:
> > From: Sami Tolvanen <samitolvanen@google.com>
> >
> > Enable the use of clang's Profile-Guided Optimization[1]. To generate a
> > profile, the kernel is instrumented with PGO counters, a representative
> > workload is run, and the raw profile data is collected from
> > /sys/kernel/debug/pgo/profraw.
> >
> > The raw profile data must be processed by clang's "llvm-profdata" tool
> > before it can be used during recompilation:
> >
> >   $ cp /sys/kernel/debug/pgo/profraw vmlinux.profraw
> >   $ llvm-profdata merge --output=vmlinux.profdata vmlinux.profraw
> >
> > Multiple raw profiles may be merged during this step.
> >
> > The data can now be used by the compiler:
> >
> >   $ make LLVM=1 KCFLAGS=-fprofile-use=vmlinux.profdata ...
> >
> > This initial submission is restricted to x86, as that's the platform we
> > know works. This restriction can be lifted once other platforms have
> > been verified to work with PGO.
> >
> > Note that this method of profiling the kernel is clang-native, unlike
> > the clang support in kernel/gcov.
> >
> > [1] https://clang.llvm.org/docs/UsersManual.html#profile-guided-optimization
> >
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> > Co-developed-by: Bill Wendling <morbo@google.com>
> > Signed-off-by: Bill Wendling <morbo@google.com>
> > Change-Id: Ic78e69c682286d3a44c4549a0138578c98138b77
>
> Small nit: This should be removed.
>
Grrr....The git hook keeps adding it in there. :-(

> I applied this patch on top of v5.11-rc3, built it with LLVM 12
> (f1d5cbbdee5526bc86eac0a5652b115d9bc158e5 + D94470) with Microsoft's
> WSL 5.4 config [1] + CONFIG_PGO_CLANG=y, and ran it on WSL2.
>
> $ zgrep PGO /proc/config.gz
> # Profile Guided Optimization (PGO) (EXPERIMENTAL)
> CONFIG_ARCH_SUPPORTS_PGO_CLANG=y
> CONFIG_PGO_CLANG=y
> # end of Profile Guided Optimization (PGO) (EXPERIMENTAL)
>
> However, I see an issue with actually using the data:
>
> $ sudo -s
> # mount -t debugfs none /sys/kernel/debug
> # cp -a /sys/kernel/debug/pgo/profraw vmlinux.profraw
> # chown nathan:nathan vmlinux.profraw
> # exit
> $ tc-build/build/llvm/stage1/bin/llvm-profdata merge --output=vmlinux.profdata vmlinux.profraw
> warning: vmlinux.profraw: Invalid instrumentation profile data (bad magic)
> error: No profiles could be merged.
>
> Am I holding it wrong? :) Note, this is virtualized, I do not have any
> "real" x86 hardware that I can afford to test on right now.
>
> [1]: https://github.com/microsoft/WSL2-Linux-Kernel/raw/linux-msft-wsl-5.4.y/Microsoft/config-wsl
>
Could you send me the vmlinux.profraw file? (Don't CC this list.)

-bw
