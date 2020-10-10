Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1347528A43D
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 01:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388535AbgJJWyF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 18:54:05 -0400
Received: from smtprelay0061.hostedemail.com ([216.40.44.61]:51882 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731333AbgJJTKz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 15:10:55 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave02.hostedemail.com (Postfix) with ESMTP id C279B1800BEB6
        for <linux-kernel@vger.kernel.org>; Sat, 10 Oct 2020 16:48:02 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 471D98384367;
        Sat, 10 Oct 2020 16:48:02 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:1801:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3167:3353:3622:3653:3865:3867:3868:3870:3871:3872:3873:3874:4321:4605:5007:6117:7903:10004:10400:10848:11232:11658:11914:12043:12297:12740:12760:12895:13255:13439:14093:14097:14659:14721:21080:21451:21611:21627:30054:30055:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: car31_1c18000271ea
X-Filterd-Recvd-Size: 4032
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Sat, 10 Oct 2020 16:48:00 +0000 (UTC)
Message-ID: <a534ed57c23ff35f6b84057ba3c0d1b55f0b03b9.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Check for .byte-spelled insn opcodes
 documentation on x86
From:   Joe Perches <joe@perches.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Date:   Sat, 10 Oct 2020 09:47:59 -0700
In-Reply-To: <20201010161112.GC24674@zn.tnic>
References: <20201009161423.14583-1-bp@alien8.de>
         <b57a59bc80e432c7696b347a223eb12339013970.camel@perches.com>
         <20201010105421.GA24674@zn.tnic>
         <4147e49c0b1251343181b5580d946c2273247927.camel@perches.com>
         <20201010161112.GC24674@zn.tnic>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-10-10 at 18:11 +0200, Borislav Petkov wrote:
> On Sat, Oct 10, 2020 at 08:27:20AM -0700, Joe Perches wrote:
> > Then this could use:
> > 
> > /"\s*\.byte\s+(?:0x[0-9a-fA-F]{1,2}\s*,\s*){2,4}/
> 
> Yes, this is getting close.
> 
> I've tweaked it a bit to:
> 
> '/\s*\.byte\s+(?:0x[0-9a-f]{1,2}[\s,]*){2,}/i'
    ^^^                                       ^
now useless without the "                     matches .BYTE

you probably want (?i:0x[etc...]

I'd prefer to add an upper bound to the {m,n} use.
Unbounded multiple
matches {m,} can cause perl aborts.

This regex would also match

.byte 0x020x02

(which admittedly wouldn't compile, but I've seen really
 bad patches submitted too)

> which assumes at least 2 opcode bytes; upper limit can be more than 4.
> It still has some false positives in crypto but I'd say that's good
> enough. I'll play more with it later

A readability convenience would be to add and use:

our $Hex_byte	= qr{(?i)0x[0-9a-f]{1,2}\b};

So if the minimum length if the isns .byte block is 2,
with a separating comma then the regex could be:

/\.byte\s+$Hex_byte\s*,\s*$Hex_byte\b/

which I think is pretty readable.

$ git grep -P '\.byte\s+(?i:0x[0-9a-f]{1,2}\s*,\s*0x[0-9a-f]{1,2})\b' -- 'arch/x86/*.[ch]'
arch/x86/include/asm/bug.h:#define ASM_UD0              ".byte 0x0f, 0xff" /* + ModRM (for Intel) */
arch/x86/include/asm/bug.h:#define ASM_UD1              ".byte 0x0f, 0xb9" /* + ModRM */
arch/x86/include/asm/bug.h:#define ASM_UD2              ".byte 0x0f, 0x0b"
arch/x86/include/asm/inst.h:    .byte 0x0f, 0xc7
arch/x86/include/asm/intel_pconfig.h:#define PCONFIG ".byte 0x0f, 0x01, 0xc5"
arch/x86/include/asm/mwait.h:   asm volatile(".byte 0x0f, 0x01, 0xc8;"
arch/x86/include/asm/mwait.h:   asm volatile(".byte 0x0f, 0x01, 0xfa;"
arch/x86/include/asm/mwait.h:   asm volatile(".byte 0x0f, 0x01, 0xc9;"
arch/x86/include/asm/mwait.h:   asm volatile(".byte 0x0f, 0x01, 0xfb;"
arch/x86/include/asm/mwait.h:   asm volatile("sti; .byte 0x0f, 0x01, 0xc9;"
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


