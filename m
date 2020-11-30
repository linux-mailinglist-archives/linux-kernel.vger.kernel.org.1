Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1A012C889C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 16:52:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727151AbgK3Pv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 10:51:26 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53831 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725933AbgK3PvZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 10:51:25 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 75C6795322;
        Mon, 30 Nov 2020 10:50:40 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:in-reply-to:message-id:references:mime-version
        :content-type; s=sasl; bh=MGoJAAIPKr5Y7RVBYVQE1ZyY2TU=; b=okv2T4
        BrOyuNVFWXJoSLU/MeUqacx9p3ADsLr37DIOHmgmefXFJtWvtaiKDD3eAWCJ4FyO
        t7ZV3RZNEf4lXJf5Mxnf2gNmc8ZB6qntGeu07q5qDkENIfSt2fVeTD1mC85S3nLl
        puoe9DiKQuyvNLwCJk/q+7JDHSwABtW5OvGg4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6D90295321;
        Mon, 30 Nov 2020 10:50:40 -0500 (EST)
        (envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=4yikyKXtLMMocEyc8KqH7ABo32efDj9mLKFJV1IRGfg=; b=JHT/ResHVDKTLYjytDDwPP24pC9XX4zSpfmvlKDH/armP+O2JdXvTdjXDDokuQJYqHTLwDmXb+3gkpDzS3KE0f8HGec+zOoPDsomQXWR8cKU5Ilbn5eed8bYvH34gvF+UuWpG+r3LXrbPzXLa0TK1WFoHjubFrFeEZVFi6vVNsI=
Received: from yoda.home (unknown [24.203.50.76])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E17CB95320;
        Mon, 30 Nov 2020 10:50:39 -0500 (EST)
        (envelope-from nico@fluxnic.net)
Received: from xanadu.home (xanadu.home [192.168.2.2])
        by yoda.home (Postfix) with ESMTPSA id D9CAD2DA09EC;
        Mon, 30 Nov 2020 10:50:38 -0500 (EST)
Date:   Mon, 30 Nov 2020 10:50:38 -0500 (EST)
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
In-Reply-To: <CAMj1kXGs-woGGnM2QkhY5NbRRKP8_N4BY9ScBtga8mcyHoK2+A@mail.gmail.com>
Message-ID: <89n4o5sp-4432-7r33-r9s-54po13q25pnp@syhkavp.arg>
References: <20201123073634.6854-1-swpenim@gmail.com> <CAMj1kXGsQ9K57SvZ74pmD+_=338sGXjc_t+hCXMh-9BPanXnhA@mail.gmail.com> <CAMj1kXGs-woGGnM2QkhY5NbRRKP8_N4BY9ScBtga8mcyHoK2+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID: CBB48D18-3323-11EB-AB6F-D152C8D8090B-78420484!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Nov 2020, Ard Biesheuvel wrote:

> (+ Nico)
> 
> On Mon, 30 Nov 2020 at 11:11, Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > On Mon, 23 Nov 2020 at 08:39, Antony Yu <swpenim@gmail.com> wrote:
> > >
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
> > > diff --git a/arch/arm/include/asm/div64.h b/arch/arm/include/asm/div64.h
> > > index 898e9c78a7e7..809efc51e90f 100644
> > > --- a/arch/arm/include/asm/div64.h
> > > +++ b/arch/arm/include/asm/div64.h
> > > @@ -39,9 +39,10 @@ static inline uint32_t __div64_32(uint64_t *n, uint32_t base)
> > >         asm(    __asmeq("%0", __xh)
> > >                 __asmeq("%1", "r2")
> > >                 __asmeq("%2", "r0")
> > > -               __asmeq("%3", "r4")
> > > +               __asmeq("%3", "r0")
> > > +               __asmeq("%4", "r4")
> > >                 "bl     __do_div64"
> > > -               : "=r" (__rem), "=r" (__res)
> > > +               : "=r" (__rem), "=r" (__res), "=r" (__n)
> > >                 : "r" (__n), "r" (__base)
> > >                 : "ip", "lr", "cc");
> > >         *n = __res;
> > > --
> > > 2.23.0
> > >
> >
> > Agree that using r0 as an input operand only is incorrect, and not
> > only on Clang. The compiler might assume that r0 will retain its value
> > across the asm() block, which is obviously not the case.

You're right.

This was done like that most likely to work around some stupid code 
generation with "__n >> 32" while using gcc from about 20 years ago. IOW 
I don't exactly remember why I did it like that, but it is certainly 
flawed.

Here's my version of the fix which should be correct. Warning: this 
is completely untested, but should in theory produce the same code on 
modern gcc.

diff --git a/arch/arm/include/asm/div64.h b/arch/arm/include/asm/div64.h
index 898e9c78a7..595e538f5b 100644
--- a/arch/arm/include/asm/div64.h
+++ b/arch/arm/include/asm/div64.h
@@ -21,29 +21,20 @@
  * assembly implementation with completely non standard calling convention
  * for arguments and results (beware).
  */
-
-#ifdef __ARMEB__
-#define __xh "r0"
-#define __xl "r1"
-#else
-#define __xl "r0"
-#define __xh "r1"
-#endif
-
 static inline uint32_t __div64_32(uint64_t *n, uint32_t base)
 {
 	register unsigned int __base      asm("r4") = base;
 	register unsigned long long __n   asm("r0") = *n;
 	register unsigned long long __res asm("r2");
-	register unsigned int __rem       asm(__xh);
-	asm(	__asmeq("%0", __xh)
+	unsigned int __rem;
+	asm(	__asmeq("%0", "r0")
 		__asmeq("%1", "r2")
-		__asmeq("%2", "r0")
-		__asmeq("%3", "r4")
+		__asmeq("%2", "r4")
 		"bl	__do_div64"
-		: "=r" (__rem), "=r" (__res)
-		: "r" (__n), "r" (__base)
+		: "+r" (__n), "=r" (__res)
+		: "r" (__base)
 		: "ip", "lr", "cc");
+	__rem = __n >> 32;
 	*n = __res;
 	return __rem;
 }

I'll submit it if someone confirms it works.


Nicolas
