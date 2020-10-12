Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5251F28C019
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 20:56:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730802AbgJLSz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 14:55:58 -0400
Received: from mail.skyhub.de ([5.9.137.197]:46432 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727115AbgJLSz5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 14:55:57 -0400
Received: from zn.tnic (p200300ec2f06920038fd325cadbd10b1.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:9200:38fd:325c:adbd:10b1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 885461EC0315;
        Mon, 12 Oct 2020 20:55:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1602528956;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ye79oQs00YCWYcutClhU3fnVihxDm0dQBQ6D8uftVIA=;
        b=l3NvqdMgybR7IEqd3FHJ/UN2M7aXe9qz/nS2W+y9biDXkSWqxrh8LJuGhNfEl+iIYgv+T4
        rPlpgEgPHiD5dbb0nsTl4G5z2E0WGUsRNp/iZAGSAUFTFAVzvyr4c98sHxsgI0B4xu4m9y
        9w5UzZEKwQsJc9VpsVFFk9/KQ4Z6fUc=
Date:   Mon, 12 Oct 2020 20:55:47 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Uros Bizjak <ubizjak@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL] x86/asm updates for v5.10
Message-ID: <20201012185547.GK22829@zn.tnic>
References: <20201012110557.GK25311@zn.tnic>
 <CAHk-=wiVoLoZS1v9SCQzH4mkpz6akE3pPrHPxM2hamOXPcaW9w@mail.gmail.com>
 <CAFULd4Z1_UKN6haGbNJMi0_tGddPZcawRDfoYnLdn-Qe6UR3-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFULd4Z1_UKN6haGbNJMi0_tGddPZcawRDfoYnLdn-Qe6UR3-Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 08:41:32PM +0200, Uros Bizjak wrote:
> On Mon, Oct 12, 2020 at 8:11 PM Linus Torvalds <
> torvalds@linux-foundation.org> wrote:
> 
> > On Mon, Oct 12, 2020 at 4:06 AM Borislav Petkov <bp@suse.de> wrote:
> > >
> > > * Use XORL instead of XORQ to avoid a REX prefix and save some bytes in
> > > the .fixup section, by Uros Bizjak.
> >
> > I think this one is actually buggy.
> >
> > For the 1-byte case, it does this:
> >
> >      __get_user_asm(x_u8__, ptr, retval, "b", "=q");
> >
> > and ends up doing "xorl" on a register that we told the compiler is a
> > byte register (with that "=q")
> >
> > Yes, it uses "%k[output]" to turn that byte register into the word
> > version of the register, but there's no fundamental reason why the
> > register might not be something like "%ah".
> >
> 
> GCC does not distinguish between %ah and %al and it is not possible to pass
> "%ah" to the assembly. To access the high part of the %ax register, %h
> modifier has to be used in the assembly template.

Btw, did those get documented in the meantime? I can find them only in
gcc sources:

   k --  likewise, print the SImode name of the register.
   h -- print the QImode name for a "high" register, either ah, bh, ch or dh.

and SImode you guys call

@findex SImode
@item SImode
``Single Integer'' mode represents a four-byte integer.


and QImode:

@findex QImode
@item QImode
``Quarter-Integer'' mode represents a single byte treated as an integer.

so the above %k would turn that into %eax, IINM, since it is a SImode,
i.e., 4 bytes.

> The compiler uses high registers only as a kind of bit insert / bit extract
> operation of 8 bits at the position of 8. The compiler is free to
> substitute "movb %al, %bl" with "movl %eax, %ebx", and there are many
> instruction patterns that exercise this to implement "impossible" reg-reg
> moves involving %sil and %dil registers in 32bit mode.
> 
> Based on the above facts, the value in %ah can only live as a part of a
> wider register, %ax (and wider) in this case.

Is this going to be the case for future gccs too or is that subject to
change at some point?

> > Annoying. Because the other patch in this pull request is fine, and
> > people want it.

@Linus: I'll send you a new one with only that one tomorrow.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
