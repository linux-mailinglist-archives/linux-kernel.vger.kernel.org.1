Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9F0A28A1B5
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 00:51:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730979AbgJJWMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 18:12:46 -0400
Received: from smtprelay0161.hostedemail.com ([216.40.44.161]:49250 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729534AbgJJSnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 14:43:33 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave01.hostedemail.com (Postfix) with ESMTP id 96F4318022D1E
        for <linux-kernel@vger.kernel.org>; Sat, 10 Oct 2020 15:32:23 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id AE500837F253;
        Sat, 10 Oct 2020 15:27:22 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:2:41:355:379:599:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1535:1593:1594:1605:1730:1747:1777:1792:2393:2553:2559:2562:2693:2828:3138:3139:3140:3141:3142:3167:3622:3865:3867:3868:3870:3871:3872:3873:3874:4051:4120:4321:4605:5007:6117:6119:7903:7904:8531:9036:10004:10848:11026:11232:11473:11657:11658:11914:12043:12297:12438:12679:12740:12760:12895:13019:13141:13161:13229:13230:13255:13439:14659:21080:21451:21611:21627:21740:30012:30025:30029:30054:30055:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: bite14_600a377271ea
X-Filterd-Recvd-Size: 9280
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Sat, 10 Oct 2020 15:27:21 +0000 (UTC)
Message-ID: <4147e49c0b1251343181b5580d946c2273247927.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Check for .byte-spelled insn opcodes
 documentation on x86
From:   Joe Perches <joe@perches.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Date:   Sat, 10 Oct 2020 08:27:20 -0700
In-Reply-To: <20201010105421.GA24674@zn.tnic>
References: <20201009161423.14583-1-bp@alien8.de>
         <b57a59bc80e432c7696b347a223eb12339013970.camel@perches.com>
         <20201010105421.GA24674@zn.tnic>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-10-10 at 12:54 +0200, Borislav Petkov wrote:
> On Fri, Oct 09, 2020 at 11:01:18AM -0700, Joe Perches wrote:
> > Given the location, this only works on .c and .h files.
> > It does not work on .S files.  Should it?
> 
> Probably not because there will be too many false positives. .byte is
> used not only to spell instruction opcodes in .S files. And the main
> case we're addressing here is using those .byte spelled opcodes in asm
> volatile constructs so...

[]

> > So it looks like the regex would be more complete as:
> > 
> > 	if ($realfile =~ m@^arch/x86/@ &&
> > 	    $rawline =~ /\.byte\s+(?:$Constant|(?:\\)?$Ident|"\s*$Ident)\b/) {
> 
> This is much less readable than what I have now (yes, realfile test
> should come first):

I care less about readability than completeness, correctness,
and minimal false positives.

> 	if ($realfile =~ m@^arch/x86/@ && $rawline =~ /\.byte[\s0-9a-fx,]+/) {
> 
> Also, this
> 
> 	$rawline =~ /\.byte\s+(?:$Constant|(?:\\)?$Ident|"\s*$Ident)\b/) {
> 
> matches
> 
> 	".byte 0x66"

And? So does the regex you propose.

> This
> 
> 	$rawline =~ /\.byte[\s0-9a-fx,]+)) {
> 
> matches
> 
> 	".byte 0x66, 0x0f, 0x38, 0xf8, 0x02"
> 
> which is what it needs to match.

Is that the only case you are trying to match?
two or more "0x<hex>," ?

Then this could use:

/"\s*\.byte\s+(?:0x[0-9a-fA-F]{1,2}\s*,\s*){2,4}/

$ git grep -P '"\s*\.byte\s+(?:0x[0-9a-fA-F]{1,2}\s*,\s*){2,4}' arch/x86
arch/x86/include/asm/intel_pconfig.h:#define PCONFIG ".byte 0x0f, 0x01, 0xc5"
arch/x86/include/asm/mwait.h:   asm volatile(".byte 0x0f, 0x01, 0xc8;"
arch/x86/include/asm/mwait.h:   asm volatile(".byte 0x0f, 0x01, 0xfa;"
arch/x86/include/asm/mwait.h:   asm volatile(".byte 0x0f, 0x01, 0xc9;"
arch/x86/include/asm/mwait.h:   asm volatile(".byte 0x0f, 0x01, 0xfb;"
arch/x86/include/asm/mwait.h:   asm volatile(".byte 0x66, 0x0f, 0xae, 0xf1\t\n"
arch/x86/include/asm/segment.h:                 ".byte 0xf3,0x0f,0xc7,0xf8", /* RDPID %eax/rax */
arch/x86/include/asm/smap.h:#define __ASM_CLAC  ".byte 0x0f,0x01,0xca"
arch/x86/include/asm/smap.h:#define __ASM_STAC  ".byte 0x0f,0x01,0xcb"
arch/x86/include/asm/special_insns.h:   asm volatile(".byte 0x0f,0x01,0xee\n\t"
arch/x86/include/asm/special_insns.h:   asm volatile(".byte 0x0f,0x01,0xef\n\t"
arch/x86/include/asm/special_insns.h:           ".byte 0x66, 0x0f, 0xae, 0x30",  /* clwb (%%rax) */
arch/x86/include/asm/special_insns.h:   asm volatile(".byte 0x66, 0x0f, 0x38, 0xf8, 0x02"
arch/x86/include/asm/special_insns.h:   asm volatile(".byte 0xf3, 0x0f, 0x38, 0xf8, 0x02, 0x66, 0x90"
arch/x86/include/asm/special_insns.h:   asm volatile(".byte 0xf, 0x1, 0xe8" ::: "memory");

vs:

$ git grep -P '\.byte[\s0-9a-fx,]+' -- 'arch/x86/*.[ch]' | cat
arch/x86/include/asm/alternative-asm.h:	.byte \orig_len
arch/x86/include/asm/alternative-asm.h:	.byte \alt_len
arch/x86/include/asm/alternative-asm.h:	.byte \pad_len
arch/x86/include/asm/alternative.h:	" .byte " alt_total_slen "\n"			/* source len      */ \
arch/x86/include/asm/alternative.h:	" .byte " alt_rlen(num) "\n"			/* replacement len */ \
arch/x86/include/asm/alternative.h:	" .byte " alt_pad_len "\n"			/* pad len */
arch/x86/include/asm/bug.h:#define ASM_UD0		".byte 0x0f, 0xff" /* + ModRM (for Intel) */
arch/x86/include/asm/bug.h:#define ASM_UD1		".byte 0x0f, 0xb9" /* + ModRM */
arch/x86/include/asm/bug.h:#define ASM_UD2		".byte 0x0f, 0x0b"
arch/x86/include/asm/cpufeature.h:		 " .byte 3b - 1b\n"		/* src len */
arch/x86/include/asm/cpufeature.h:		 " .byte 5f - 4f\n"		/* repl len */
arch/x86/include/asm/cpufeature.h:		 " .byte 3b - 2b\n"		/* pad len */
arch/x86/include/asm/cpufeature.h:		 " .byte 3b - 1b\n"		/* src len */
arch/x86/include/asm/cpufeature.h:		 " .byte 0\n"			/* repl len */
arch/x86/include/asm/cpufeature.h:		 " .byte 0\n"			/* pad len */
arch/x86/include/asm/fpu/internal.h:#define XSAVE		".byte " REX_PREFIX "0x0f,0xae,0x27"
arch/x86/include/asm/fpu/internal.h:#define XSAVEOPT	".byte " REX_PREFIX "0x0f,0xae,0x37"
arch/x86/include/asm/fpu/internal.h:#define XSAVES		".byte " REX_PREFIX "0x0f,0xc7,0x2f"
arch/x86/include/asm/fpu/internal.h:#define XRSTOR		".byte " REX_PREFIX "0x0f,0xae,0x2f"
arch/x86/include/asm/fpu/internal.h:#define XRSTORS		".byte " REX_PREFIX "0x0f,0xc7,0x1f"
arch/x86/include/asm/idtentry.h: * Note, that the 'pushq imm8' is emitted via '.byte 0x6a, vector' because
arch/x86/include/asm/idtentry.h: * .byte achieves the same thing and the only fixup needed in the C entry
arch/x86/include/asm/idtentry.h:	.byte	0x6a, vector
arch/x86/include/asm/idtentry.h:	.byte	0x6a, vector
arch/x86/include/asm/inst.h: * Generate .byte code for some instructions not supported by old
arch/x86/include/asm/inst.h:	.byte 0x40 | ((\opd1 & 8) >> 3) | ((\opd2 & 8) >> 1) | (\W << 3)
arch/x86/include/asm/inst.h:	.byte \mod | (\opd1 & 7) | ((\opd2 & 7) << 3)
arch/x86/include/asm/inst.h:	.byte 0xf3
arch/x86/include/asm/inst.h:	.byte 0x0f, 0xc7
arch/x86/include/asm/intel_pconfig.h:#define PCONFIG ".byte 0x0f, 0x01, 0xc5"
arch/x86/include/asm/jump_label.h:		".byte " __stringify(STATIC_KEY_INIT_NOP) "\n\t"
arch/x86/include/asm/jump_label.h:		".byte 0xe9\n\t .long %l[l_yes] - 2f\n\t"
arch/x86/include/asm/jump_label.h:	.byte		0xe9
arch/x86/include/asm/jump_label.h:	.byte		STATIC_KEY_INIT_NOP
arch/x86/include/asm/jump_label.h:	.byte		STATIC_KEY_INIT_NOP
arch/x86/include/asm/jump_label.h:	.byte		0xe9
arch/x86/include/asm/mwait.h:	asm volatile(".byte 0x0f, 0x01, 0xc8;"
arch/x86/include/asm/mwait.h:	asm volatile(".byte 0x0f, 0x01, 0xfa;"
arch/x86/include/asm/mwait.h:	asm volatile(".byte 0x0f, 0x01, 0xc9;"
arch/x86/include/asm/mwait.h:	asm volatile(".byte 0x0f, 0x01, 0xfb;"
arch/x86/include/asm/mwait.h:	asm volatile("sti; .byte 0x0f, 0x01, 0xc9;"
arch/x86/include/asm/mwait.h:	asm volatile(".byte 0x66, 0x0f, 0xae, 0xf1\t\n"
arch/x86/include/asm/nops.h:#define _ASM_MK_NOP(x) .byte x
arch/x86/include/asm/nops.h:#define _ASM_MK_NOP(x) ".byte " __stringify(x) "\n"
arch/x86/include/asm/paravirt.h:	 .byte ptype;				\
arch/x86/include/asm/paravirt.h:	 .byte 772b-771b;			\
arch/x86/include/asm/paravirt_types.h:	"  .byte " type "\n"				\
arch/x86/include/asm/paravirt_types.h:	"  .byte 772b-771b\n"				\
arch/x86/include/asm/segment.h:			".byte 0xf3,0x0f,0xc7,0xf8", /* RDPID %eax/rax */
arch/x86/include/asm/smap.h:#define __ASM_CLAC	".byte 0x0f,0x01,0xca"
arch/x86/include/asm/smap.h:#define __ASM_STAC	".byte 0x0f,0x01,0xcb"
arch/x86/include/asm/special_insns.h:	asm volatile(".byte 0x0f,0x01,0xee\n\t"
arch/x86/include/asm/special_insns.h:	asm volatile(".byte 0x0f,0x01,0xef\n\t"
arch/x86/include/asm/special_insns.h:	alternative_io(".byte " __stringify(NOP_DS_PREFIX) "; clflush %P0",
arch/x86/include/asm/special_insns.h:		       ".byte 0x66; clflush %P0",
arch/x86/include/asm/special_insns.h:		".byte " __stringify(NOP_DS_PREFIX) "; clflush (%[pax])",
arch/x86/include/asm/special_insns.h:		".byte 0x66; clflush (%[pax])", /* clflushopt (%%rax) */
arch/x86/include/asm/special_insns.h:		".byte 0x66, 0x0f, 0xae, 0x30",  /* clwb (%%rax) */
arch/x86/include/asm/special_insns.h:	asm volatile(".byte 0x66, 0x0f, 0x38, 0xf8, 0x02"
arch/x86/include/asm/special_insns.h:	asm volatile(".byte 0xf3, 0x0f, 0x38, 0xf8, 0x02, 0x66, 0x90"
arch/x86/include/asm/special_insns.h:	asm volatile(".byte 0xf, 0x1, 0xe8" ::: "memory");
arch/x86/include/asm/static_call.h:	__ARCH_DEFINE_STATIC_CALL_TRAMP(name, ".byte 0xe9; .long " #func " - (. + 4)")
arch/x86/include/asm/xen/interface.h:#define XEN_EMULATE_PREFIX __ASM_FORM(.byte __XEN_EMULATE_PREFIX ;)
arch/x86/kvm/vmx/ops.h:		     ".byte 0x3e\n\t" /* branch taken hint */
arch/x86/kvm/vmx/ops.h:			  ".byte 0x2e\n\t" /* branch not taken hint */	\
arch/x86/kvm/vmx/ops.h:			  ".byte 0x2e\n\t" /* branch not taken hint */	\
arch/x86/realmode/rm/realmode.h:#define LJMPW_RM(to)	.byte 0xea ; .word (to), real_mode_seg

and if lines like:

arch/x86/include/asm/inst.h: * Generate .byte code for some instructions not supported by old
arch/x86/include/asm/paravirt_types.h:	"  .byte " type "\n"				\

are false positives then perhaps change the regex
to add required spaces after the \.byte before the
match.



