Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 942C72C6D48
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 23:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732267AbgK0WjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 17:39:06 -0500
Received: from mail.skyhub.de ([5.9.137.197]:34016 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731911AbgK0Wfm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 17:35:42 -0500
Received: from zn.tnic (p200300ec2f0ffb009c6c53492ede31ac.dip0.t-ipconnect.de [IPv6:2003:ec:2f0f:fb00:9c6c:5349:2ede:31ac])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8F7EC1EC0118;
        Fri, 27 Nov 2020 23:35:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1606516530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=dZ3mHdQ0lbEuQV8aUfqCHF5IJILvSN+7JpQAC5fiVAo=;
        b=VkqyZ00btsJCAgAU/2Mo43ArKRgMmjMNHHLjRpminREe9yYurwuwEJbE4pHBC47Suptn+W
        Lm8x0OpUHNMg+m1vDPU32APwPH8IvcAgB2xOmQKifwHQGa6o7WVpISRHMCF0ThQJrwPpGq
        QFdGMFL3zCK1olrUkAFkHOIUkJ+9xy8=
Date:   Fri, 27 Nov 2020 23:35:23 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Andy Lutomirski <luto@amacapital.net>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, X86 ML <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v0 00/19] x86/insn: Add an insn_decode() API
Message-ID: <20201127223523.GF13163@zn.tnic>
References: <20201124101952.7909-1-bp@alien8.de>
 <20201124174647.GI4009@zn.tnic>
 <CALCETrXXuUmM6LPj36h2KLw5zuKUPnmrACcOq2-8XfXzWXQt7Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CALCETrXXuUmM6LPj36h2KLw5zuKUPnmrACcOq2-8XfXzWXQt7Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 27, 2020 at 09:45:39AM -0800, Andy Lutomirski wrote:
> Is -22 (-EINVAL) the same error it returns if you pass in garbage?

Define garbage.

Yes, if you have a sequence of bytes which you can unambiguously
determine to be

 - an invalid instruction in some of the tables

 - REX prefix with the wrong bits set

 - a byte says that some insn part like ModRM or SIB is following but
 the buffer falls short

 - ... other error condition

then maybe you can say, yes, I'm looking at garbage and can error out
right then and there. But you need to have enough bytes of information
to determine that.

For example (those are random bytes):

00000000000011ff <.asm_start>:
    11ff:       95                      xchg   %eax,%ebp
    1200:       14 60                   adc    $0x60,%al
    1202:       77 74                   ja     1278 <__libc_csu_init+0x28>
    1204:       82                      (bad)  
    1205:       67 dc 55 35             fcoml  0x35(%ebp)

The 0x82 is usually in opcode group 1 but that opcode is invalid in
64-bit mode. So if this is a 64-bit executable, you know that that is an
invalid insn.

Another example:

              18:       a0                      .byte 0xa0
              19:       17                       (bad)
              1a:       27                       (bad)
              1b:       ea                       (bad)
              1c:       90                      nop
              1d:       90                      nop
              1e:       90                      nop
              1f:       90                      nop

0xa0 is the opcode for

	MOV AL, moffset8

where moffset8 is an address-sized memory offset, which in 64-bit mode
is 64-bit. But we have only 7 bytes after the 0xa0 thus we know that the
buffer is truncated.

If it had one byte more, it would be a valid insn:

               18:       a0 17 27 ea 90 90 90    movabs 0x9090909090ea2717,%al
               20:       90 90 


I'm sure you get the idea: if you have enough unambiguous bits which
tell you that this cannot be a valid insn, then you can return early
from the decoder and signal that fact.

I'm not sure that you can do that for all possible byte combinations
and also I'm not sure that it won't ever happen that it per chance
misinterprets garbage data as valid instructions.

> How hard would it be to teach it to return a different error code when
> the buffer is too small?

Yap, see above. Unambiguous cases are clear but I don't know it would
work in all cases. For example, let's say you give it a zeroed out
buffer of 8 bytes which doesn't contain anything - you've just zeroed it
out and haven't put any insns in there yet.

But those are perfectly valid insns:

               0:       00 00                   add %al,(%rax)
               2:       00 00                   add %al,(%rax)
               4:       00 00                   add %al,(%rax)
               6:       00 00                   add %al,(%rax)

So now you go about your merry way working with those although they're
not real instructions which some tool generated.

See what I mean?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
