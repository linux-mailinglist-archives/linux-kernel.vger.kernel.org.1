Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E475220429D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jun 2020 23:24:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730642AbgFVVYu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 17:24:50 -0400
Received: from smtprelay0192.hostedemail.com ([216.40.44.192]:51818 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728555AbgFVVYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 17:24:50 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id EB19718029134;
        Mon, 22 Jun 2020 21:24:48 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2197:2199:2393:2559:2562:2693:2828:3138:3139:3140:3141:3142:3354:3622:3653:3865:3866:3867:3868:3870:3871:3872:3874:4250:4321:5007:7875:7903:8957:9010:10004:10400:11232:11658:11914:12043:12114:12296:12297:12740:12760:12895:13160:13229:13255:13439:14093:14097:14181:14659:14721:21063:21080:21221:21324:21451:21627:21795:30012:30034:30051:30054:30056:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: sink53_2c02d6f26e36
X-Filterd-Recvd-Size: 3649
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf08.hostedemail.com (Postfix) with ESMTPA;
        Mon, 22 Jun 2020 21:24:47 +0000 (UTC)
Message-ID: <8a218fa14cc2e1690df32d278c82587c7507a820.camel@perches.com>
Subject: Re: [PATCH] checkpatch: fix CONST_STRUCT when
 const_structs.checkpatch is missing
From:   Joe Perches <joe@perches.com>
To:     Quentin Monnet <quentin@isovalent.com>,
        Andy Whitcroft <apw@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Date:   Mon, 22 Jun 2020 14:24:47 -0700
In-Reply-To: <20200622204844.21030-1-quentin@isovalent.com>
References: <20200622204844.21030-1-quentin@isovalent.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-06-22 at 21:48 +0100, Quentin Monnet wrote:
> Checkpatch reports warnings when some specific structs are not declared
> as const in the code. The list of structs to consider was initially
> defined in the checkpatch.pl script itself, but it was later moved to an
> external file (scripts/const_structs.checkpatch). This introduced two
> minor issues:
> 
> - When file scripts/const_structs.checkpatch is not present (for
>   example, if checkpatch is run outside of the kernel directory with the
>   "--no-tree" option), a warning is printed to stderr to tell the user
>   that "No structs that should be const will be found". This is fair,
>   but the warning is printed unconditionally, even if the option
>   "--ignore CONST_STRUCT" is passed. In the latter case, we explicitly
>   ask checkpatch to skip this check, so no warning should be printed.
> 
> - When scripts/const_structs.checkpatch is missing, or even when trying
>   to silence the warning by adding an empty file, $const_structs is set
>   to "", and the regex used for finding structs that should be const,
>   "$line =~ /\bstruct\s+($const_structs)\b(?!\s*\{)/)", matches all
>   structs found in the code, thus reporting a number of false positives.
> 
> Let's fix the first item by skipping scripts/const_structs.checkpatch
> processing if "CONST_STRUCT" checks are ignored, and the second one by
> skipping the test if $const_structs is an empty string.
> 
> Fixes: bf1fa1dae68e ("checkpatch: externalize the structs that should be const")

Probably not worthy of a Fixes: line, as that's
generally used for backporting, but OK by me.

> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -781,8 +781,10 @@ sub read_words {
>  }
>  
>  my $const_structs = "";

This might be a tiny bit faster/less cpu using:

my $const_structs;

> -read_words(\$const_structs, $conststructsfile)
> -    or warn "No structs that should be const will be found - file '$conststructsfile': $!\n";
> +if (show_type("CONST_STRUCT")) {
> +	read_words(\$const_structs, $conststructsfile)
> +	    or warn "No structs that should be const will be found - file '$conststructsfile': $!\n";
> +}
>  
>  my $typeOtherTypedefs = "";
>  if (length($typedefsfile)) {
> @@ -6660,7 +6662,8 @@ sub process {
>  
>  # check for various structs that are normally const (ops, kgdb, device_tree)
>  # and avoid what seem like struct definitions 'struct foo {'
> -		if ($line !~ /\bconst\b/ &&
> +		if ($const_structs ne "" &&

instead testing

		if (defined($const_structs) &&

> +		    $line !~ /\bconst\b/ &&
>  		    $line =~ /\bstruct\s+($const_structs)\b(?!\s*\{)/) {
>  			WARN("CONST_STRUCT",
>  			     "struct $1 should normally be const\n" . $herecurr);

