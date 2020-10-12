Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9403928BAB3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 16:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388948AbgJLOV7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 10:21:59 -0400
Received: from mail.skyhub.de ([5.9.137.197]:60598 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388662AbgJLOV7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 10:21:59 -0400
Received: from zn.tnic (p200300ec2f06920008362ea164c1c332.dip0.t-ipconnect.de [IPv6:2003:ec:2f06:9200:836:2ea1:64c1:c332])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 56EE41EC0354;
        Mon, 12 Oct 2020 16:21:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1602512517;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=2HBhpr20wGHxmrWIiVkliQjBY+neXHsHZzH2hEr3+aU=;
        b=gpcVZL/+cvuB4XwKO7zXR9WFMYNzA6JpE+me5jxk/8LmZlG0EQiurUU7TIyD2ogFNbLn5H
        PS41KsFPIE/RuEEMBjsy0ejzBSGVLxNNkwjof/o5Hyq7cFUYz/eZHWGFK2o3D2Kt6SUKKN
        vVIRblfA4uJdPpogbDGPA8HaGTWyhcU=
Date:   Mon, 12 Oct 2020 16:21:48 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Joe Perches <joe@perches.com>
Cc:     X86 ML <x86@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH] checkpatch: Check for .byte-spelled insn opcodes
 documentation on x86
Message-ID: <20201012142148.GA22829@zn.tnic>
References: <20201009161423.14583-1-bp@alien8.de>
 <b57a59bc80e432c7696b347a223eb12339013970.camel@perches.com>
 <20201010105421.GA24674@zn.tnic>
 <4147e49c0b1251343181b5580d946c2273247927.camel@perches.com>
 <20201010161112.GC24674@zn.tnic>
 <a534ed57c23ff35f6b84057ba3c0d1b55f0b03b9.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a534ed57c23ff35f6b84057ba3c0d1b55f0b03b9.camel@perches.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 10, 2020 at 09:47:59AM -0700, Joe Perches wrote:
> > '/\s*\.byte\s+(?:0x[0-9a-f]{1,2}[\s,]*){2,}/i'
>     ^^^                                       ^
> now useless without the "

There are \.byte specifications without " so not useless.

> matches .BYTE

so what. It would have failed before, when trying to compile it.

> you probably want (?i:0x[etc...]
> 
> I'd prefer to add an upper bound to the {m,n} use.
> Unbounded multiple
> matches {m,} can cause perl aborts.

Ok, we can make that 15. Max insn length on x86 is 15 bytes and that
is unrealistically high for this use case so we should be good. And the
range must be {1,15} because you can have single-byte instructions.

And that's fine if there are *some* false positives. And whatever we do,
it won't match everything. For example:

arch/x86/include/asm/fpu/internal.h:208:#define XSAVE           ".byte " REX_PREFIX "0x0f,0xae,0x27"
arch/x86/include/asm/fpu/internal.h:209:#define XSAVEOPT        ".byte " REX_PREFIX "0x0f,0xae,0x37"
arch/x86/include/asm/fpu/internal.h:210:#define XSAVES          ".byte " REX_PREFIX "0x0f,0xc7,0x2f"
arch/x86/include/asm/fpu/internal.h:211:#define XRSTOR          ".byte " REX_PREFIX "0x0f,0xae,0x2f"
arch/x86/include/asm/fpu/internal.h:212:#define XRSTORS         ".byte " REX_PREFIX "0x0f,0xc7,0x1f"

but that's fine. I prefer for the regex to remain readable and single
outliers like those are caught in manual review.

As another example, sometimes it would be a false positive for another
reason:

arch/x86/include/asm/idtentry.h:500: * Note, that the 'pushq imm8' is emitted via '.byte 0x6a, vector' because

that's why I've changed the text to say "Please consider..." implying
thatdocumenting binutils version might not always be necessary/needed.

All in all, it's fine if there are some false positives and it can make
reviewers have a second look.

> This regex would also match
>
> .byte 0x020x02
>
> (which admittedly wouldn't compile, but I've seen really bad patches
> submitted too)

That's fine - I love reviewing !compiled patches. They will never send
!compiled again.

> A readability convenience would be to add and use:
> 
> our $Hex_byte	= qr{(?i)0x[0-9a-f]{1,2}\b};
> 
> So if the minimum length if the isns .byte block is 2,
> with a separating comma then the regex could be:
> 
> /\.byte\s+$Hex_byte\s*,\s*$Hex_byte\b/
> 
> which I think is pretty readable.

Yap, makes sense. v3 coming up...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
