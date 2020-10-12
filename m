Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3042B28BEE8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 19:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404062AbgJLRSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 13:18:00 -0400
Received: from smtprelay0103.hostedemail.com ([216.40.44.103]:51126 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2403845AbgJLRSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 13:18:00 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 301F11822451E;
        Mon, 12 Oct 2020 17:17:59 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 90,9,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:334:355:368:369:379:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:2911:3138:3139:3140:3141:3142:3167:3354:3622:3653:3865:3866:3867:3868:3870:3871:3873:3874:4250:4321:4425:4605:5007:7576:7903:7974:10004:10400:10848:11232:11658:11914:12043:12297:12679:12740:12760:12895:13095:13180:13229:13255:13439:14181:14659:14721:21080:21433:21451:21627:21740:21741:30029:30054:30070:30089:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: waste17_2c18500271fc
X-Filterd-Recvd-Size: 3769
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Mon, 12 Oct 2020 17:17:57 +0000 (UTC)
Message-ID: <5590cd3df8b28cdd077230dda8c99e80436bdcf3.camel@perches.com>
Subject: Re: [PATCH -v4] checkpatch: Check for .byte-spelled insn opcodes
 documentation on x86
From:   Joe Perches <joe@perches.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>, X86 ML <x86@kernel.org>,
        Andy Whitcroft <apw@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Date:   Mon, 12 Oct 2020 10:17:56 -0700
In-Reply-To: <20201012171544.GH22829@zn.tnic>
References: <20201009161423.14583-1-bp@alien8.de>
         <b57a59bc80e432c7696b347a223eb12339013970.camel@perches.com>
         <20201010105421.GA24674@zn.tnic>
         <4147e49c0b1251343181b5580d946c2273247927.camel@perches.com>
         <20201010161112.GC24674@zn.tnic>
         <a534ed57c23ff35f6b84057ba3c0d1b55f0b03b9.camel@perches.com>
         <20201012142148.GA22829@zn.tnic>
         <b74a95944a4bc6be1ea4ae8cf065c23e03511ba5.camel@perches.com>
         <20201012171544.GH22829@zn.tnic>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-10-12 at 19:15 +0200, Borislav Petkov wrote:
> On Mon, Oct 12, 2020 at 10:09:44AM -0700, Joe Perches wrote:
> > From: Borislav Petkov <bp@suse.de>
> > 
> > Instruction opcode bytes spelled using the gas directive .byte should
> > carry a comment above them stating which binutils version has added
> > support for the instruction mnemonic so that they can be replaced with
> > the mnemonic when that binutils version is equal or less than the
> > minimum-supported version by the kernel.
> > 
> > Add a check for that.
> > 
> > Requested-by: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Borislav Petkov <bp@suse.de>
> > Signed-off-by: Joe Perches <joe@perches.com>
> > ---
> > 
> > v4: trivial neatening of $Hex_byte and adding a mechanism to
> >     only emit the message once per patched file (Joe)
> > 
> >  scripts/checkpatch.pl | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> 
> ./scripts/checkpatch.pl /tmp/test
> Global symbol "$rawline" requires explicit package name (did you forget to declare "my $rawline"?) at ./scripts/checkpatch.pl line 6943.
> Global symbol "$herecurr" requires explicit package name (did you forget to declare "my $herecurr"?) at ./scripts/checkpatch.pl line 6948.
> Execution of ./scripts/checkpatch.pl aborted due to compilation errors.
> 
> No workie.

Workie here.  This is against -next.

$ ./scripts/checkpatch.pl -f arch/x86/include/asm/smap.h
WARNING: Please consider documenting which binutils version supports these .byte-spelled insn opcodes by adding "binutils version <num>" in a comment above them
#16: FILE: arch/x86/include/asm/smap.h:16:
+#define __ASM_CLAC	".byte 0x0f,0x01,0xca"

WARNING: Prefer using '"%s...", __func__' to using 'smap_save', this function's name, in a string
#60: FILE: arch/x86/include/asm/smap.h:60:
+	asm volatile ("# smap_save\n\t"

WARNING: Prefer using '"%s...", __func__' to using 'smap_restore', this function's name, in a string
#71: FILE: arch/x86/include/asm/smap.h:71:
+	asm volatile ("# smap_restore\n\t"

total: 0 errors, 3 warnings, 99 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

arch/x86/include/asm/smap.h has style problems, please review.

NOTE: If any of the errors are false positives, please report
      them to the maintainer, see CHECKPATCH in MAINTAINERS.


