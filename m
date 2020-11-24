Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E3A52C2295
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 11:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731235AbgKXKOh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 05:14:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727923AbgKXKOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 05:14:37 -0500
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F89C0613D6
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 02:14:37 -0800 (PST)
Received: by mail-qk1-x741.google.com with SMTP id n132so19926135qke.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Nov 2020 02:14:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=M8HFvC6koH2vnTmM34smDb99U2wEfBkWSIiLyvwwry8=;
        b=ju06R1hNWiCOb6rqv8oGfKcqjVSFb55qOG+beGRkfhn1wE57EkvgNOTrNjOVviTatJ
         hV/NobBhrxxSuAPsdrnaYtGrJeuSI7u5lRFKORSII//+dIfAIbiebAbF757FzP2TMwdM
         RvCO7hRXQao4NQ4QL6zyJO+ZtywVzZSSZ/97E4AmOIvwR3LhmxBuKYSLR/zboB43J/9p
         MoHRueK5L0y827OilRI4GocCVc8Vi2GY54h3R586nEEMjWQx5pchGnnfLrieOUIiH0oi
         Wr7FHUhpo51I4orKbdRlwfbHZnO+OK7qnqCKuDvk8Hb68jJbzbygS8lhHySxDzKY5eDr
         TPPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=M8HFvC6koH2vnTmM34smDb99U2wEfBkWSIiLyvwwry8=;
        b=IImIrbG5LkJHC81ci82SJlawUzbUvwK2nWpP+urcFqz9OAAIorpmFSmlDmqJlwq+Wj
         JUH+KAP9gSLvI1sXSZpEyGTf3DcU7a/1EefbROk2rH8y87pR6F/uWx5lKN6rMn/kcmf4
         oImKGrE1nq9aWDjY2x9WRUs/ApQ9SSjOB8zxEATXCwKeV9rUk63pYsOxN7cDNJEQGbZ3
         ND1jClCvLOuwK195u4PacRYHGfzRi53CorKflSJIcCXXNVw4Ln8DxvL6At74gJxtQ56X
         g8LcePVG5/z5OKlzoTYVYpCX+QiJ8YRFdTnEUinK3gyPkLuP5qxq9XpJOOL+2j/u5lvF
         zRjw==
X-Gm-Message-State: AOAM5331BeQfNe5nvIcvOv1uLwqW8oG74pu5ofz0f8dmgef7VvDpLQIR
        iGxNoJMBh9Z9AWIQgQA1UKj0hq5esk25K3BqAL8m6aNv9/kB3g==
X-Google-Smtp-Source: ABdhPJx8KnJT2ss3M5nTNF9ljEoBEKAxQOdFeUI7etoHEmWe8fNcJ5wxh4Ul5Dsz0CAVKv5vEH2qrsDlhiCGfdYLJXI=
X-Received: by 2002:a37:a101:: with SMTP id k1mr3649363qke.447.1606212876108;
 Tue, 24 Nov 2020 02:14:36 -0800 (PST)
MIME-Version: 1.0
References: <20201123073634.6854-1-swpenim@gmail.com> <20201123181602.GA2637357@ubuntu-m3-large-x86>
 <20201124074211.GA26157@penyung-VirtualBox>
In-Reply-To: <20201124074211.GA26157@penyung-VirtualBox>
From:   Antony Yu <swpenim@gmail.com>
Date:   Tue, 24 Nov 2020 18:14:25 +0800
Message-ID: <CAC5oF3W+RkcO-dSiKXGxVvhBGb0n7fQ-KvdjbPNJJVadv6qNBw@mail.gmail.com>
Subject: Re: [RESEND,PATCH] ARM: fix __div64_32() error when compiling with clang
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com, Pen-Yung Yu <swpenim@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Antony Yu <swpenim@gmail.com> =E6=96=BC 2020=E5=B9=B411=E6=9C=8824=E6=97=A5=
 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=883:43=E5=AF=AB=E9=81=93=EF=BC=9A
>
> On Mon, Nov 23, 2020 at 11:16:02AM -0700, Nathan Chancellor wrote:
> > On Mon, Nov 23, 2020 at 03:36:32PM +0800, Antony Yu wrote:
> > > __do_div64 clobbers the input register r0 in little endian system.
> > > According to the inline assembly document, if an input operand is
> > > modified, it should be tied to a output operand. This patch can
> > > prevent compilers from reusing r0 register after asm statements.
> > >
> > > Signed-off-by: Antony Yu <swpenim@gmail.com>
> > > ---
> > >  arch/arm/include/asm/div64.h | 5 +++--
> > >  1 file changed, 3 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/arch/arm/include/asm/div64.h b/arch/arm/include/asm/div6=
4.h
> > > index 898e9c78a7e7..809efc51e90f 100644
> > > --- a/arch/arm/include/asm/div64.h
> > > +++ b/arch/arm/include/asm/div64.h
> > > @@ -39,9 +39,10 @@ static inline uint32_t __div64_32(uint64_t *n, uin=
t32_t base)
> > >     asm(    __asmeq("%0", __xh)
> > >             __asmeq("%1", "r2")
> > >             __asmeq("%2", "r0")
> > > -           __asmeq("%3", "r4")
> > > +           __asmeq("%3", "r0")
> > > +           __asmeq("%4", "r4")
> > >             "bl     __do_div64"
> > > -           : "=3Dr" (__rem), "=3Dr" (__res)
> > > +           : "=3Dr" (__rem), "=3Dr" (__res), "=3Dr" (__n)
> > >             : "r" (__n), "r" (__base)
> > >             : "ip", "lr", "cc");
> > >     *n =3D __res;
> > > --
> > > 2.23.0
> > >
> >
> > I am not sure that I am qualified to review this (my assembly knowledge
> > is not the best) but your commit title mentions an error when compiling
> > with clang. What is the exact error, what configuration generates it,
> > and what version of clang? We have done fairly decent testing for
> > 32-bit ARM, I would like to know what we are missing.
> >
> > Cheers,
> > Nathan
>
> We have run fail on android R vts vts_libsnapshot_test with kernel 4.14.
> This bug is triggered accidently by a workaround patch in our code base.
> It is fine on a pure clean 4.14 branch since __do_div64 may not be
> executed in skip_metadata.
>
> The attachment are .i and generated .s file. .s file can be reproduced
> with clang -target arm-linux-eabi -march=3Darmv8.2-a -O2.
>
> In function skip_metadata, it loads some value to r0, calls __do_div64,
> adds 1 to r0 and stores it to [r5]. It gets wrong value since __do_div64
> clobbers r0 register.
>
> We have tried clang-10, clang-11 and android prebuilt clang-r383902b. All
> of them have the same problem.

Sorry for the large attachment.
I put .i and .s files on
https://gist.github.com/penyung/274b0c697062a1c776994bb40243cfff

Antony Yu
