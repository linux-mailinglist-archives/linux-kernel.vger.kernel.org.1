Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 910071A8430
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Apr 2020 18:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388271AbgDNQH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Apr 2020 12:07:59 -0400
Received: from foss.arm.com ([217.140.110.172]:59090 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728527AbgDNQHy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 12:07:54 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9FFAE30E;
        Tue, 14 Apr 2020 09:07:53 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.30.4])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F323C3F6C4;
        Tue, 14 Apr 2020 09:07:51 -0700 (PDT)
Date:   Tue, 14 Apr 2020 17:07:49 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Fangrui Song <maskray@google.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] arm64: Delete the space separator in __emit_inst
Message-ID: <20200414160749.GL2486@C02TD0UTHF1T.local>
References: <20200413033811.75074-1-maskray@google.com>
 <20200414095904.GB1278@C02TD0UTHF1T.local>
 <20200414154307.2cke3x5ocz3q2as4@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200414154307.2cke3x5ocz3q2as4@google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 14, 2020 at 08:43:07AM -0700, Fangrui Song wrote:
> 
> On 2020-04-14, Mark Rutland wrote:
> > Hi Fangrui,
> > 
> > On Sun, Apr 12, 2020 at 08:38:11PM -0700, Fangrui Song wrote:
> > > Many instances of __emit_inst(x) expand to a directive. In a few places
> > > it is used as a macro argument, e.g.
> > > 
> > >   arch/arm64/include/asm/sysreg.h
> > >   #define __emit_inst(x)                       .inst (x)
> > > 
> > >   arch/arm64/include/asm/sysreg.h
> > >   #define SET_PSTATE_PAN(x)            __emit_inst(0xd500401f | PSTATE_PAN | ((!!x) << PSTATE_Imm_shift))
> > > 
> > >   arch/arm64/kvm/hyp/entry.S
> > >   ALTERNATIVE(nop, SET_PSTATE_PAN(1), ARM64_HAS_PAN, CONFIG_ARM64_PAN)
> > > 
> > > Clang integrated assembler parses `.inst (x)` as two arguments passing
> > > to a macro. We delete the space separator so that `.inst(x)` will be
> > > parsed as one argument.
> > 
> > I'm a little confused by the above; sorry if the below sounds stupid or
> > pedantic, but I just want to make sure I've understood the problem
> > correctly.
> > 
> > For the above, ALTERNATIVE() and SET_PSTATE_PAN() are both preprocessor
> > macros, so I would expect those to be expanded before either the
> > integrated assembler or an external assembler consumes any of the
> > assembly (and both would see the same expanded text). Given that, I'm a
> > bit confused as to why the integrated assembly would have an impact on
> > preprocessing.
> > 
> > Does compiling the pre-processed source using the integrated assembler
> > result in the same behaviour? Can we see the expanded text to make that
> > clear?
> > 
> > ... at what stage exactly does this go wrong?
> > 
> > Thanks,
> > Mark.
> 
> Hi Mark,
> 
> The C preprocessor expands arch/arm64/kvm/hyp/entry.S
>    ALTERNATIVE(nop, SET_PSTATE_PAN(1), ARM64_HAS_PAN, CONFIG_ARM64_PAN)
> 
> to:
>    alternative_insn nop, .inst (0xd500401f | ((0) << 16 | (4) << 5) | ((!!1) << 8)), 4, 1
> 
> `alternative_insn` is an assembler macro, not handled by the C preprocessor.
> 
> Both comma and space are separators, with an exception that content
> inside a pair of parentheses/quotes is not split, so clang -cc1as or GNU
> as x86 splits arguments this way:
> 
>    nop, .inst, (0xd500401f | ((0) << 16 | (4) << 5) | ((!!1) << 8)), 4, 1

Thanks for this; I understand now.

Could we fold that into the commit message? I think this is much clearer
than the current wording. The explicit description of separator
behaviour, the pre-expansion of the CPP macros, and the example of how
the assembler will split this really help.

> I actually feel that GNU as arm64's behavior is a little bit buggy. It
> works just because GNU as has another preprocessing step `do_scrub_chars`
> and its arm64 backend deletes the space before '('
> 
>    alternative_insn nop,.inst(0xd500401f|((0)<<16|(4)<<5)|((!!1)<<8)),4,1
> 
> The x86 backend keeps the space before the outmost '('
> 
>   alternative_insn nop,.inst (0xd500401f|((0)<<16|(4)<<5)|((!!1)<<8)),4,1
> 
> By reading its state machine, I think keeping the spaces will be the
> most reasonable behavior.

I think I agree. This deviation across architectures is unfortunate for
such a low-level but common tool.

> If .inst were only used as arguments,
> 
>    alternative_insn nop, ".inst (0xd500401f | ((0) << 16 | (4) << 5) | ((!!1) << 8))", 4, 1
> 
> would be the best to avoid parsing issues.
> 
> > > 
> > > Note, GNU as parsing `.inst (x)` as one argument is unintentional (for
> > > example the x86 backend will parse the construct as two arguments).
> > > See https://sourceware.org/bugzilla/show_bug.cgi?id=25750#c10
> > > 
> > > Link: https://github.com/ClangBuiltLinux/linux/issues/939
> > > Cc: clang-built-linux@googlegroups.com
> > > Signed-off-by: Fangrui Song <maskray@google.com>
> > > ---
> > >  arch/arm64/include/asm/sysreg.h | 4 +++-
> > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sysreg.h
> > > index ebc622432831..af21e2ec5e3e 100644
> > > --- a/arch/arm64/include/asm/sysreg.h
> > > +++ b/arch/arm64/include/asm/sysreg.h
> > > @@ -49,7 +49,9 @@
> > >  #ifndef CONFIG_BROKEN_GAS_INST
> > > 
> > >  #ifdef __ASSEMBLY__
> > > -#define __emit_inst(x)			.inst (x)
> > > +// The space separator is omitted so that __emit_inst(x) can be parsed as
> > > +// either a directive or a macro argument.
> > > +#define __emit_inst(x)			.inst(x)

Can we make this a bit more explicit and say "assembler macro argument"?
That way we can avoid any confusion with a CPP macro.

With that (and with the details above folded into the commit message):

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.

> > >  #else
> > >  #define __emit_inst(x)			".inst " __stringify((x)) "\n\t"
> > >  #endif
> > > --
> > > 2.26.0.110.g2183baf09c-goog
> > > 
