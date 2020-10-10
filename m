Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7039C28A3E9
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Oct 2020 01:12:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389434AbgJJWzl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Oct 2020 18:55:41 -0400
Received: from smtprelay0086.hostedemail.com ([216.40.44.86]:52502 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731446AbgJJTXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Oct 2020 15:23:12 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave01.hostedemail.com (Postfix) with ESMTP id 852E41801669A
        for <linux-kernel@vger.kernel.org>; Sat, 10 Oct 2020 15:44:04 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id A22061802912A;
        Sat, 10 Oct 2020 15:38:56 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3167:3352:3622:3653:3870:3871:3872:3876:4321:4605:5007:7903:10004:10400:10848:11026:11232:11473:11658:11914:12043:12297:12438:12740:12760:12895:13069:13255:13311:13357:13439:14659:14721:21080:21451:21611:21627:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: join88_5a1154d271ea
X-Filterd-Recvd-Size: 2124
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Sat, 10 Oct 2020 15:38:55 +0000 (UTC)
Message-ID: <e81ed20fbec7a90fc195237c0d2c4d8748f3a906.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Check for .byte-spelled insn opcodes
 documentation on x86
From:   Joe Perches <joe@perches.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Date:   Sat, 10 Oct 2020 08:38:54 -0700
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
> > checkpatch uses only a single line output only before $herecurr
> > Output line length doesn't matter.
[]
> WARNING: Please document which binutils version supports these .byte-spelled
>         insn opcodes by adding "binutils version <num>" in a comment above them.
> #90: FILE: arch/x86/include/asm/special_insns.h:254:
> +       asm volatile(".byte 0x66, 0x0f, 0x38, 0xf8, 0x02"
> 
> 
> is easier readable than this:
> 
> WARNING: Please document which binutils version supports these .byte-spelledinsn opcodes by adding "binutils version <num>" in a comment above them.
> #90: FILE: arch/x86/include/asm/special_insns.h:254:
> +       asm volatile(".byte 0x66, 0x0f, 0x38, 0xf8, 0x02"

Readability is a consideration but it still must be a single line.

using --terse requires single line error output

Perhaps:
			if ($comment !~ /\bbinutils version [0-9.]+/ms) {
				WARN("MISSING_BINUTILS_VERSION",
				     "Please add a comment for .byte-spelled insn opcodes with \"binutils version <minimum_required_version>\"\n" . $herecurr);

