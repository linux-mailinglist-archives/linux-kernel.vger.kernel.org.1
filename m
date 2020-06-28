Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 281F020C8DD
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jun 2020 17:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726374AbgF1P6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Jun 2020 11:58:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:34996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726060AbgF1P6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Jun 2020 11:58:19 -0400
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15C5C212CC;
        Sun, 28 Jun 2020 15:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593359898;
        bh=DtSgSNZ/Y8U3u/G8yXdkRl6jp5GXV8zZCwtET5iW7YQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=m/G/JA6T3ERyNd0FPHSgEKS8tTNRsohOE46yfF7HKb6YY6w4ZT0/9dyr+ZQBO+Rcy
         5gBbOPMK/QF2j8Z2LUej1qJzRF3Ws9kW8GHyJAbvbC8yAx30F/Z/9mt3tFw8OYtyL6
         CIpjJ3lKhW8+7iD4QmR0L7FWf66sYiVyjIhVoFYc=
Received: by mail-lj1-f173.google.com with SMTP id n24so15377012lji.10;
        Sun, 28 Jun 2020 08:58:18 -0700 (PDT)
X-Gm-Message-State: AOAM532Hh8JVsloQY2bemMQhb3OzmPgF2uYiYR1Yy0AueFOqs8QRhn2M
        51MpVwWJ7qHX9z1vX8zuygjOe8xmVn7kTud6lWQ=
X-Google-Smtp-Source: ABdhPJw4kdL62d9Qc3oTqep1ffBfGno76ikBsgH8wOkGMZ5nl95LHD/hd+wQ0lUVl4czTIHBb//DO1un06L12zHH2/s=
X-Received: by 2002:a2e:a0cc:: with SMTP id f12mr5820411ljm.250.1593359896350;
 Sun, 28 Jun 2020 08:58:16 -0700 (PDT)
MIME-Version: 1.0
References: <1593274802-46332-1-git-send-email-guoren@kernel.org>
 <20200628115945.335b92c517cb8a8fa87be759@kernel.org> <CAJF2gTTCHMHp-+RoG8DoDhbJStzmOf5AK=Z3K26FUmd_hbgR=g@mail.gmail.com>
 <20200628235226.dbbe2256ea6e846abfb63feb@kernel.org>
In-Reply-To: <20200628235226.dbbe2256ea6e846abfb63feb@kernel.org>
From:   Guo Ren <guoren@kernel.org>
Date:   Sun, 28 Jun 2020 23:58:04 +0800
X-Gmail-Original-Message-ID: <CAJF2gTTaG6U-A9kwJotbgjYSkMUNsV=Wc-u4GM0i4zr2YCEX_A@mail.gmail.com>
Message-ID: <CAJF2gTTaG6U-A9kwJotbgjYSkMUNsV=Wc-u4GM0i4zr2YCEX_A@mail.gmail.com>
Subject: Re: [PATCH] riscv: Fixup compile error BUILD_BUG_ON failed
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Palmer Dabbelt <palmerdabbelt@google.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Anup Patel <anup@brainfault.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        Zong Li <zong.li@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-csky@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 28, 2020 at 10:52 PM Masami Hiramatsu <mhiramat@kernel.org> wro=
te:
>
> On Sun, 28 Jun 2020 14:12:07 +0800
> Guo Ren <guoren@kernel.org> wrote:
>
> > On Sun, Jun 28, 2020 at 10:59 AM Masami Hiramatsu <mhiramat@kernel.org>=
 wrote:
> > >
> > > On Sat, 27 Jun 2020 16:20:02 +0000
> > > guoren@kernel.org wrote:
> > >
> > > > From: Guo Ren <guoren@linux.alibaba.com>
> > > >
> > > > Unfortunately, the current code couldn't be compiled, because
> > > > BUILD_BUG_ON needs a static defined value, not a dynamic
> > > > variable with a0 regs. Just use it inline as a solution.
> > > >
> > > >   CC      arch/riscv/kernel/patch.o
> > > > In file included from ./include/linux/kernel.h:11,
> > > >                  from ./include/linux/list.h:9,
> > > >                  from ./include/linux/preempt.h:11,
> > > >                  from ./include/linux/spinlock.h:51,
> > > >                  from arch/riscv/kernel/patch.c:6:
> > > > In function =E2=80=98fix_to_virt=E2=80=99,
> > > >     inlined from =E2=80=98patch_map=E2=80=99 at arch/riscv/kernel/p=
atch.c:37:17:
> > > > ./include/linux/compiler.h:392:38: error: call to =E2=80=98__compil=
etime_assert_205=E2=80=99 declared with attribute error: BUILD_BUG_ON faile=
d: idx >=3D __end_of_fixed_addresses
> > > >   _compiletime_assert(condition, msg, __compiletime_assert_, __COUN=
TER__)
> > > >                                       ^
> > > > ./include/linux/compiler.h:373:4: note: in definition of macro =E2=
=80=98__compiletime_assert=E2=80=99
> > > >     prefix ## suffix();    \
> > > >     ^~~~~~
> > > > ./include/linux/compiler.h:392:2: note: in expansion of macro =E2=
=80=98_compiletime_assert=E2=80=99
> > > >   _compiletime_assert(condition, msg, __compiletime_assert_, __COUN=
TER__)
> > > >   ^~~~~~~~~~~~~~~~~~~
> > > > ./include/linux/build_bug.h:39:37: note: in expansion of macro =E2=
=80=98compiletime_assert=E2=80=99
> > > >  #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), ms=
g)
> > > >                                      ^~~~~~~~~~~~~~~~~~
> > > > ./include/linux/build_bug.h:50:2: note: in expansion of macro =E2=
=80=98BUILD_BUG_ON_MSG=E2=80=99
> > > >   BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
> > > >   ^~~~~~~~~~~~~~~~
> > > > ./include/asm-generic/fixmap.h:32:2: note: in expansion of macro =
=E2=80=98BUILD_BUG_ON=E2=80=99
> > > >   BUILD_BUG_ON(idx >=3D __end_of_fixed_addresses);
> > > >   ^~~~~~~~~~~~
> > > >
> > > > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > > > Cc: Masami Hiramatsu <mhiramat@kernel.org>
> > > > Cc: Zong Li <zong.li@sifive.com>
> > > > ---
> > > >  arch/riscv/kernel/patch.c | 3 +--
> > > >  1 file changed, 1 insertion(+), 2 deletions(-)
> > > >
> > > > diff --git a/arch/riscv/kernel/patch.c b/arch/riscv/kernel/patch.c
> > > > index d4a64df..f8e84f2 100644
> > > > --- a/arch/riscv/kernel/patch.c
> > > > +++ b/arch/riscv/kernel/patch.c
> > > > @@ -20,7 +20,7 @@ struct patch_insn {
> > > >  };
> > > >
> > > >  #ifdef CONFIG_MMU
> > > > -static void *patch_map(void *addr, int fixmap)
> > > > +static inline void *patch_map(void *addr, int fixmap)
> > >
> > > Would we be better to use "__always_inline" as same as fix_to_virt?
> > Ok
> >
> > > And also, could you add a comment why we need to make it inline?
> > I've mentioned in comment:
> > > > BUILD_BUG_ON needs a static defined value, not a dynamic
> > > > variable with a0 regs.
> >
> > idx must be a const unsigned int or it will cause compile error with
> > BUILD_BUG_ON.
>
> Ah, sorry for the confusion. I meant the comment line in the code.
Ok.

> BTW, can we also use "const unsigned int" for the fixmap index so that
> no one miss it anymore?
Sure, actually I've done it in my patch V2. Thx for mention.

--=20
Best Regards
 Guo Ren

ML: https://lore.kernel.org/linux-csky/
