Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0164E289073
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 20:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390288AbgJISBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 14:01:21 -0400
Received: from smtprelay0021.hostedemail.com ([216.40.44.21]:33560 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730110AbgJISBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 14:01:21 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 6CA43181D3030;
        Fri,  9 Oct 2020 18:01:20 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 91,10,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2197:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3167:3315:3353:3622:3653:3865:3866:3868:3870:3871:3872:3874:4321:5007:7576:7903:10004:10400:10848:11026:11232:11473:11658:11914:12043:12297:12438:12740:12760:12895:13184:13229:13255:13439:14181:14659:14721:21080:21221:21433:21451:21627:21740:21741:21891:21990:30025:30034:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: boys36_610ce33271e2
X-Filterd-Recvd-Size: 3039
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Fri,  9 Oct 2020 18:01:19 +0000 (UTC)
Message-ID: <b57a59bc80e432c7696b347a223eb12339013970.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Check for .byte-spelled insn opcodes
 documentation on x86
From:   Joe Perches <joe@perches.com>
To:     Borislav Petkov <bp@alien8.de>, X86 ML <x86@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andy Whitcroft <apw@canonical.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Date:   Fri, 09 Oct 2020 11:01:18 -0700
In-Reply-To: <20201009161423.14583-1-bp@alien8.de>
References: <20201009161423.14583-1-bp@alien8.de>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-10-09 at 18:14 +0200, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> Instruction opcode bytes spelled using the gas directive .byte should
> carry a comment above them stating which binutils version has added
> support for the instruction mnemonic so that they can be replaced with
> the mnemonic when that binutils version is equal or less than the
> minimum-supported version by the kernel.
> 
> Add a check for that.

OK but several notes:

> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -6858,6 +6858,18 @@ sub process {
>  			WARN("DUPLICATED_SYSCTL_CONST",
>  				"duplicated sysctl range checking value '$1', consider using the shared one in include/linux/sysctl.h\n" . $herecurr);
>  		}
> +
> +# document which binutils version supports the actual insn mnemonic so that the naked opcode bytes can be replaced.
> +# x86-only.
> +		if ($rawline =~ /(\.byte(?:0[xX][0-9a-fA-F]+0-9a-fx,]+)/ && $realfile =~ "^arch/x86/") {

Given the location, this only works on .c and .h files.
It does not work on .S files.  Should it?

No need for a capture group.

Please use @ not " as all the other $realfile comparisons
use that form when expecting a /

So it looks like the regex would be more complete as:

	if ($realfile =~ m@^arch/x86/@ &&
	    $rawline =~ /\.byte\s+(?:$Constant|(?:\\)?$Ident|"\s*$Ident)\b/) {

etc...

> +			my $comment = ctx_locate_comment(0, $linenr);

A patch can modify any number of files.

This should use ctx_locate_comment($file ? 0 : $first_line, $linenr)
as checkpatch tests work on patch contexts not the entire
file before this line.

> +			if (! $comment || ($comment !~ /binutils version [0-9.]+/(ms)) {

No need for the $!comment test

> +				WARN("MISSING_BINUTILS_VERSION",
> +				     "Please document which binutils version supports these .byte-spelled\n" .
> +				     "\tinsn opcodes by adding \"binutils version <num>\" in a comment" .
> +				     " above them.\n" . $herecurr);

checkpatch uses only a single line output only before $herecurr
Output line length doesn't matter.


