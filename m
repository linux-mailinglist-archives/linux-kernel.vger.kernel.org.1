Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 320712C820C
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 11:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728632AbgK3KWP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 05:22:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbgK3KWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 05:22:14 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA13C0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 02:21:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=MLqKD3jRFo8FpPzkYIL73PYY1dH6RWPaiQHEkCwMjmw=; b=PRbkhnQnLbD5w0tItqIG+1cs/
        9wtc5J6Y29JJXqj2WLEGdA0qV6LmRqH/7qKynykIU2JloqSEhNh4DuC1uqaAtEC+rtJeONqpB2O1e
        lYdsRwUHa3bvQT/sUBLnItmFFDUC4/MqnzhAvoXV+KSeHWhLAm3ZIH98sje6B2AGg8ojrY2hDw7Mk
        I1RMFroF3oobZ/pX551OsZam9tyzJ02L/DAJxwoF/2ZMX0MsqRLmRZzLud33WnINyjgMJ5S+nHpMJ
        Hd6YstL8zS1hxisfqedfHbLsMZEpBycp+uRZ5vruCCYrbuLi7FAu1Nz9r7s6Cj0MiAYcRKpwGWkNo
        NQaMdLH4w==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:37940)
        by pandora.armlinux.org.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <linux@armlinux.org.uk>)
        id 1kjgJA-0006Yt-SU; Mon, 30 Nov 2020 10:21:24 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.92)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1kjgJ8-0004vR-V5; Mon, 30 Nov 2020 10:21:22 +0000
Date:   Mon, 30 Nov 2020 10:21:22 +0000
From:   Russell King - ARM Linux admin <linux@armlinux.org.uk>
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Antony Yu <swpenim@gmail.com>, Nicolas Pitre <nico@fluxnic.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RESEND,PATCH] ARM: fix __div64_32() error when compiling with
 clang
Message-ID: <20201130102122.GT1551@shell.armlinux.org.uk>
References: <20201123073634.6854-1-swpenim@gmail.com>
 <CAMj1kXGsQ9K57SvZ74pmD+_=338sGXjc_t+hCXMh-9BPanXnhA@mail.gmail.com>
 <CAMj1kXGs-woGGnM2QkhY5NbRRKP8_N4BY9ScBtga8mcyHoK2+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMj1kXGs-woGGnM2QkhY5NbRRKP8_N4BY9ScBtga8mcyHoK2+A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 30, 2020 at 11:12:33AM +0100, Ard Biesheuvel wrote:
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

However, you can _not_ have an asm block that names two outputs using
the same physical register - that's why both the original patch and
the posted v2 will fail.

You also can't mark r0 as clobbered because it's used as an operand
and that is not allowed by gcc.

The fact is, we have two register variables occupying the same register,
which are __n and __rem. It doesn't matter which endian-ness __rem is,
r0 will be used for both __n (input) and __rem (output).

If the compiler can't work out that if a physical register used as an
output operand will be written by the assembler, then the compiler is
quite simply buggy.

The code is correct as it stands; Clang is buggy.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
