Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0EBD2C8C35
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 19:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387973AbgK3SJL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 13:09:11 -0500
Received: from mail.kernel.org ([198.145.29.99]:54720 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726316AbgK3SJL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 13:09:11 -0500
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1B46120855
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 18:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606759710;
        bh=TnCU4Aw2g9+Knu503dKHlfOBW7TvM1ez8D23YVMDj6U=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=qd583t3maKQxXJ8R75fAfkdQEp7bRQaKg/HeZTGCy1TrM37gDF+WZG4mID94Zu78J
         +xNWKAsGz6VRMPlzuFJLddqFcUZscOUd8Nv7iBhvy8Nnf5gLD6pJ9FGZbRvEJ+qSAP
         peMJP5kWxTYCx03mH5t7v84+irwpDxBI35jAnMz8=
Received: by mail-oi1-f180.google.com with SMTP id o25so15162481oie.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 10:08:30 -0800 (PST)
X-Gm-Message-State: AOAM533OmXGn5a5p8GCqSNVZOU1+7O/EAm44aU9+SUQ9QEywZ9YmTR4o
        lr7HGc1txmjynqz06+Ozt2Duu8ChspK2PgK79dM=
X-Google-Smtp-Source: ABdhPJwjJ6WdtC6vWUgbuLjgeNFmD/byB0JJ4sdUPlmNfqDph9AsNcPCJRtqfE2Kjt5G3kBf3l+ekMLmEwVQTV+2D4s=
X-Received: by 2002:aca:5ec2:: with SMTP id s185mr30062oib.33.1606759709386;
 Mon, 30 Nov 2020 10:08:29 -0800 (PST)
MIME-Version: 1.0
References: <20201123073634.6854-1-swpenim@gmail.com> <CAMj1kXGsQ9K57SvZ74pmD+_=338sGXjc_t+hCXMh-9BPanXnhA@mail.gmail.com>
 <CAMj1kXGs-woGGnM2QkhY5NbRRKP8_N4BY9ScBtga8mcyHoK2+A@mail.gmail.com>
 <89n4o5sp-4432-7r33-r9s-54po13q25pnp@syhkavp.arg> <CAMj1kXGuHw+p5=YPrVwaHjp5hQ9uxsp7hbA0Vk-ppZ3_qHDVrA@mail.gmail.com>
 <85p0oop-5pq-p6o-7560-297sn1np3os@syhkavp.arg>
In-Reply-To: <85p0oop-5pq-p6o-7560-297sn1np3os@syhkavp.arg>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Mon, 30 Nov 2020 19:08:18 +0100
X-Gmail-Original-Message-ID: <CAMj1kXFyi9uc1bNuHrmBBqgW34tUU_mxV0BqVbrihsG_HMzMCA@mail.gmail.com>
Message-ID: <CAMj1kXFyi9uc1bNuHrmBBqgW34tUU_mxV0BqVbrihsG_HMzMCA@mail.gmail.com>
Subject: Re: [RESEND,PATCH] ARM: fix __div64_32() error when compiling with clang
To:     Nicolas Pitre <nico@fluxnic.net>
Cc:     Antony Yu <swpenim@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Nov 2020 at 18:52, Nicolas Pitre <nico@fluxnic.net> wrote:
>
> On Mon, 30 Nov 2020, Ard Biesheuvel wrote:
>
> > On Mon, 30 Nov 2020 at 16:51, Nicolas Pitre <nico@fluxnic.net> wrote:
> >
> > > Here's my version of the fix which should be correct. Warning: this
> > > is completely untested, but should in theory produce the same code on
> > > modern gcc.
> > >
> > > diff --git a/arch/arm/include/asm/div64.h b/arch/arm/include/asm/div64.h
> > > index 898e9c78a7..595e538f5b 100644
> > > --- a/arch/arm/include/asm/div64.h
> > > +++ b/arch/arm/include/asm/div64.h
> > > @@ -21,29 +21,20 @@
> > >   * assembly implementation with completely non standard calling convention
> > >   * for arguments and results (beware).
> > >   */
> > > -
> > > -#ifdef __ARMEB__
> > > -#define __xh "r0"
> > > -#define __xl "r1"
> > > -#else
> > > -#define __xl "r0"
> > > -#define __xh "r1"
> > > -#endif
> > > -
> > >  static inline uint32_t __div64_32(uint64_t *n, uint32_t base)
> > >  {
> > >         register unsigned int __base      asm("r4") = base;
> > >         register unsigned long long __n   asm("r0") = *n;
> > >         register unsigned long long __res asm("r2");
> > > -       register unsigned int __rem       asm(__xh);
> > > -       asm(    __asmeq("%0", __xh)
> > > +       unsigned int __rem;
> > > +       asm(    __asmeq("%0", "r0")
> > >                 __asmeq("%1", "r2")
> > > -               __asmeq("%2", "r0")
> > > -               __asmeq("%3", "r4")
> > > +               __asmeq("%2", "r4")
> > >                 "bl     __do_div64"
> > > -               : "=r" (__rem), "=r" (__res)
> > > -               : "r" (__n), "r" (__base)
> > > +               : "+r" (__n), "=r" (__res)
> > > +               : "r" (__base)
> > >                 : "ip", "lr", "cc");
> > > +       __rem = __n >> 32;
> >
> > This treats {r0, r1} as a {low, high} pair, regardless of endianness,
> > and so it puts the value of r0 into r1. Doesn't that mean the shift
> > should only be done on little endian?
>
> Not quite. r0-r1 = low-high is for little endian. Then "__n >> 32" is
> actually translated into "mov r0, r1" to move it into __rem and returned
> through r0.
>
> On big endial it is r0-r1 = high-low.  Here "__n >> 32" picks r0 and
> moves it to __rem which is returned through r0 so no extra instruction
> needed.
>
> Of course the function is inlined so r0 can be anything, or optimized
> away if__rem is not used.
>

OK, you're right. I got myself confused there, but a quick test with
GCC confirms your explanation:

$ arm-linux-gnueabihf-gcc -mbig-endian -O2 -S -o - \
   -xc - <<<"long f(long long l) { return l >> 32; }"

just produces

bx lr

whereas removing the -mbig-endian gives

mov r0, r1
bx lr


I tested the change and it builds and runs fine (although I am not
sure how much coverage this code gets on an ordinary boot):

Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Tested-by: Ard Biesheuvel <ardb@kernel.org>
