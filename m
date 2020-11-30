Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A15782C8BC2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 18:53:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387836AbgK3RxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 12:53:13 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60668 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387401AbgK3RxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 12:53:12 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 09CEF10B342;
        Mon, 30 Nov 2020 12:52:31 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=5R1AupPP2LzuDU3f4TF51/Ai7fs=; b=tWINt5
        TuU3Rap+niKJ9lle7repEoceiqf7JDzzpoIJB4hzSfW4TcHpF4juMuMnMRzDSxQE
        vUfe04DZX2t888QhdqdZLFyVli6Ty+UZj9JX1/hzXNaHoGltgZDrrNze5SQKRUf1
        H+AOJRE2U1O5kg9n6x10fFkV6lyZ0yzVAf4t8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 0221210B341;
        Mon, 30 Nov 2020 12:52:31 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=U80uzZV27XkAzKFLC71qRcAEY0mzyiAxcmoCHHmvgNc=; b=DVPLUnJeaS3e08/wQQWgU2E+BdrRMQtEuIsmviBBd8lQACuA79tsRjWt1uW++qQK9Ys8XuzlNwCoiJn1HjvDLMI6Nop5Imq95ZQighmY3gnp1AfjzBIfO2UIniRAv2jlZbzl/dHCixF3gpU6i6l9cf51nE0q3/VCSdKeMDuIn0w=
Received: from yoda.home (unknown [24.203.50.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id ECD6710B340;
        Mon, 30 Nov 2020 12:52:27 -0500 (EST)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id 1A1B92DA09EC;
        Mon, 30 Nov 2020 12:52:26 -0500 (EST)
Date:   Mon, 30 Nov 2020 12:52:25 -0500 (EST)
From:   Nicolas Pitre <nico@fluxnic.net>
To:     Ard Biesheuvel <ardb@kernel.org>
cc:     Antony Yu <swpenim@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RESEND,PATCH] ARM: fix __div64_32() error when compiling with
 clang
In-Reply-To: <CAMj1kXGuHw+p5=YPrVwaHjp5hQ9uxsp7hbA0Vk-ppZ3_qHDVrA@mail.gmail.com>
Message-ID: <85p0oop-5pq-p6o-7560-297sn1np3os@syhkavp.arg>
References: <20201123073634.6854-1-swpenim@gmail.com> <CAMj1kXGsQ9K57SvZ74pmD+_=338sGXjc_t+hCXMh-9BPanXnhA@mail.gmail.com> <CAMj1kXGs-woGGnM2QkhY5NbRRKP8_N4BY9ScBtga8mcyHoK2+A@mail.gmail.com> <89n4o5sp-4432-7r33-r9s-54po13q25pnp@syhkavp.arg>
 <CAMj1kXGuHw+p5=YPrVwaHjp5hQ9uxsp7hbA0Vk-ppZ3_qHDVrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: CFA3A43E-3334-11EB-831A-D609E328BF65-78420484!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Nov 2020, Ard Biesheuvel wrote:

> On Mon, 30 Nov 2020 at 16:51, Nicolas Pitre <nico@fluxnic.net> wrote:
> 
> > Here's my version of the fix which should be correct. Warning: this
> > is completely untested, but should in theory produce the same code on
> > modern gcc.
> >
> > diff --git a/arch/arm/include/asm/div64.h b/arch/arm/include/asm/div64.h
> > index 898e9c78a7..595e538f5b 100644
> > --- a/arch/arm/include/asm/div64.h
> > +++ b/arch/arm/include/asm/div64.h
> > @@ -21,29 +21,20 @@
> >   * assembly implementation with completely non standard calling convention
> >   * for arguments and results (beware).
> >   */
> > -
> > -#ifdef __ARMEB__
> > -#define __xh "r0"
> > -#define __xl "r1"
> > -#else
> > -#define __xl "r0"
> > -#define __xh "r1"
> > -#endif
> > -
> >  static inline uint32_t __div64_32(uint64_t *n, uint32_t base)
> >  {
> >         register unsigned int __base      asm("r4") = base;
> >         register unsigned long long __n   asm("r0") = *n;
> >         register unsigned long long __res asm("r2");
> > -       register unsigned int __rem       asm(__xh);
> > -       asm(    __asmeq("%0", __xh)
> > +       unsigned int __rem;
> > +       asm(    __asmeq("%0", "r0")
> >                 __asmeq("%1", "r2")
> > -               __asmeq("%2", "r0")
> > -               __asmeq("%3", "r4")
> > +               __asmeq("%2", "r4")
> >                 "bl     __do_div64"
> > -               : "=r" (__rem), "=r" (__res)
> > -               : "r" (__n), "r" (__base)
> > +               : "+r" (__n), "=r" (__res)
> > +               : "r" (__base)
> >                 : "ip", "lr", "cc");
> > +       __rem = __n >> 32;
> 
> This treats {r0, r1} as a {low, high} pair, regardless of endianness,
> and so it puts the value of r0 into r1. Doesn't that mean the shift
> should only be done on little endian?

Not quite. r0-r1 = low-high is for little endian. Then "__n >> 32" is 
actually translated into "mov r0, r1" to move it into __rem and returned 
through r0.

On big endial it is r0-r1 = high-low. Here "__n >> 32" picks r0 and 
moves it to __rem which is returned through r0 so no extra instruction 
needed.

Of course the function is inlined so r0 can be anything, or optimized 
away if__rem is not used.


Nicolas
