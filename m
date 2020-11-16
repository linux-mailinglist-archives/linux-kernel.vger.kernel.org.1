Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54D302B5131
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 20:32:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbgKPTb1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 14:31:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726217AbgKPTb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 14:31:27 -0500
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A50CC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 11:31:25 -0800 (PST)
Received: by mail-pg1-x543.google.com with SMTP id j19so7306078pgg.5
        for <linux-kernel@vger.kernel.org>; Mon, 16 Nov 2020 11:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cGlOiQidYdOUuFpFQrkW0TeHEuSg5zbmdMF9LAJd9eM=;
        b=QDAYt3WUDWZ9zhvjKOOkr+BRgXwoz9jg0reCZVaxi9z/UBM84zmHJIbN2KOOPXOnaU
         6vuMv+XlaVvh16uX7o6HtA13aXcvYzOUSKw0B0TPTkfPtWhRdgl3f5+krfAnVoGJhx9K
         iO5gfA01lkluE6E9JdRFgavcZgYX2LxgeLVEiwyX8cMw87vqbss9l/NqeXav0rbmBNtl
         Og+aEIerF/darfGRu2IbWxb3M5osLqSGx3k+6dXNMg7UiiwgHNkbd1TCJg8qKjl+3/58
         V4gJdlFY5TuK3LcZE1ZhS7Fi54NOjb09s2oG5Or18Y2U1dfur15Dq+LcFYxkzFvLEsRo
         S61w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cGlOiQidYdOUuFpFQrkW0TeHEuSg5zbmdMF9LAJd9eM=;
        b=pGLE+zyWrVvgREWyqaD3/wyhmhJWTK4aAPgcCS1/Py9JY87YSXNi3UX6xveESeXmaf
         x0bYX8Q3+aWFVPAvgT/iJeN2R5xzn9+GrAVO1v/qwVTfXM7ez8f3ym37HAwt7ke3DGi5
         A5R6FjLyCv248elhGd65LhtwOajDFNJ/tEAS3pkQloS7uprzn8PQhW0hJ/N6Bw60Sn8p
         W5T8fVWXdlTrVH13Ao2FSNHU0FFjYUTd9K1YHgndzlF7VOo0m4nJd6AxSk+nv4geP989
         XsP+Z42DKCtIYlyJvcia93Pt9z+RBCu6dkw2UzTgZ4wDEREjD28LwF/T71pmF8679BFm
         rZCQ==
X-Gm-Message-State: AOAM5335VY3Et2W9McIc9reSutVgd/gmatq0YpycHT4UNqzM7TwNhWVx
        09k0pjNwCM929/LCHF5Ewo4aJtbX58sJJ6Kyz/3Lr20BYZn5cw==
X-Google-Smtp-Source: ABdhPJzXg3takLX1phIDPuBdZ2SMXWEBlyJrWyLsVYjrVb+IsuRmX/tfjsnyMdZ1GtK3fdxA9Dp0E6u3WM5RE/fj4hk=
X-Received: by 2002:a17:90a:4881:: with SMTP id b1mr493181pjh.32.1605555084999;
 Mon, 16 Nov 2020 11:31:24 -0800 (PST)
MIME-Version: 1.0
References: <20201014212631.207844-1-nivedita@alum.mit.edu> <87sg999ot0.fsf@igel.home>
In-Reply-To: <87sg999ot0.fsf@igel.home>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 16 Nov 2020 11:31:13 -0800
Message-ID: <CAKwvOdn8aOr0=22idJ_KetgJ_rhk5-7i29VvxofoLrRo138f_g@mail.gmail.com>
Subject: Re: [PATCH] compiler.h: Fix barrier_data() on clang
To:     Andreas Schwab <schwab@linux-m68k.org>,
        Palmer Dabbelt <palmerdabbelt@google.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Nathan Chancellor <natechancellor@gmail.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-riscv@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 16, 2020 at 9:47 AM Andreas Schwab <schwab@linux-m68k.org> wrote:
>
> On Okt 14 2020, Arvind Sankar wrote:
>
> > Commit
> >   815f0ddb346c ("include/linux/compiler*.h: make compiler-*.h mutually exclusive")
> >
> > neglected to copy barrier_data() from compiler-gcc.h into
> > compiler-clang.h. The definition in compiler-gcc.h was really to work
> > around clang's more aggressive optimization, so this broke
> > barrier_data() on clang, and consequently memzero_explicit() as well.
> >
> > For example, this results in at least the memzero_explicit() call in
> > lib/crypto/sha256.c:sha256_transform() being optimized away by clang.
> >
> > Fix this by moving the definition of barrier_data() into compiler.h.
> >
> > Also move the gcc/clang definition of barrier() into compiler.h,
> > __memory_barrier() is icc-specific (and barrier() is already defined
> > using it in compiler-intel.h) and doesn't belong in compiler.h.
> >
> > Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
> > Fixes: 815f0ddb346c ("include/linux/compiler*.h: make compiler-*.h mutually exclusive")
>
> This breaks build on riscv:
>
>   CC [M]  drivers/net/ethernet/emulex/benet/be_main.o
> In file included from ./include/vdso/processor.h:10,
>                  from ./arch/riscv/include/asm/processor.h:11,
>                  from ./include/linux/prefetch.h:15,
>                  from drivers/net/ethernet/emulex/benet/be_main.c:14:
> ./arch/riscv/include/asm/vdso/processor.h: In function 'cpu_relax':
> ./arch/riscv/include/asm/vdso/processor.h:14:2: error: implicit declaration of function 'barrier' [-Werror=implicit-function-declaration]
>    14 |  barrier();
>       |  ^~~~~~~
> cc1: some warnings being treated as errors
> make[5]: *** [scripts/Makefile.build:283: drivers/net/ethernet/emulex/benet/be_main.o] Error 1
> make[4]: *** [scripts/Makefile.build:500: drivers/net/ethernet/emulex/benet] Error 2
> make[3]: *** [scripts/Makefile.build:500: drivers/net/ethernet/emulex] Error 2
> make[2]: *** [scripts/Makefile.build:500: drivers/net/ethernet] Error 2
> make[1]: *** [scripts/Makefile.build:500: drivers/net] Error 2
> make: *** [Makefile:1799: drivers] Error 2
>
> Andreas.

A lot of VDSO's reset KBUILD_CFLAGS or use a new variable for their
compiler flags.  As such, they're missing `-include` command line flag
that injects include/linux/compiler_types.h, which `#includes`
numerous other headers if `__KERNEL__` is defined (`-D__KERNEL__`).
So the RISCV VDSO Makefile might need to `-include
$(srctree)/include/linux/compiler_types.h -D__KERNEL__`, or `#include
<linux/compiler.h>"` directly in
arch/riscv/include/asm/vdso/processor.h.
-- 
Thanks,
~Nick Desaulniers
