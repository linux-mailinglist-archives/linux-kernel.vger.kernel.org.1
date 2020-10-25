Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 672642982FA
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 18:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1417064AbgJYR7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 13:59:12 -0400
Received: from smtprelay0068.hostedemail.com ([216.40.44.68]:54044 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1417043AbgJYR7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 13:59:12 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 2D00418224D61;
        Sun, 25 Oct 2020 17:59:11 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:1981:2194:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3353:3622:3653:3865:3866:3867:3868:3870:3871:3872:3874:4321:4605:5007:10004:10400:10848:11026:11232:11473:11658:11914:12043:12296:12297:12438:12740:12895:13069:13311:13357:13439:13618:13894:14181:14659:14721:21080:21627:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: nest53_241321d2726c
X-Filterd-Recvd-Size: 2513
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Sun, 25 Oct 2020 17:59:10 +0000 (UTC)
Message-ID: <52f88d0bb938c5063ede693a05bf64961af5a496.camel@perches.com>
Subject: Re: [PATCH v5] checkpatch: extend attributes check to handle more
 patterns
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com
Date:   Sun, 25 Oct 2020 10:59:09 -0700
In-Reply-To: <20201025101537.59133-1-dwaipayanray1@gmail.com>
References: <20201025101537.59133-1-dwaipayanray1@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-10-25 at 15:45 +0530, Dwaipayan Ray wrote:
> It is generally preferred that the macros from
> include/linux/compiler_attributes.h are used, unless there
> is a reason not to.
> 
> checkpatch currently checks __attribute__ for each of
> packed, aligned, section, printf, scanf, and weak. Other
> declarations in compiler_attributes.h are not handled.
> 
> Add a generic test to check the presence of such attributes.
> Some attributes require more specific handling and are kept
> separate.
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -6155,50 +6155,95 @@ sub process {
>  			}
>  		}
>  
> 
> -# Check for __attribute__ packed, prefer __packed
> +# Check for compiler attributes
>  		if ($realfile !~ m@\binclude/uapi/@ &&
> -		    $line =~ /\b__attribute__\s*\(\s*\(.*\bpacked\b/) {
> -			WARN("PREFER_PACKED",
> -			     "__packed is preferred over __attribute__((packed))\n" . $herecurr);
> -		}
> +		    $rawline =~ /\b__attribute__\s*\(\s*($balanced_parens)\s*\)/) {

Using $rawline would also change comments and that seems wrong.
Any reason to use $rawline instead of $line?

[]

> +			if (scalar @conv_array > 0 && $conv_possible == 1) {
> +				my $replace = join(' ', @conv_array);
> +				if (WARN("PREFER_DEFINED_ATTRIBUTE_MACRO",
> +				         "$replace is preferred over __attribute__(($attr))\n" . $herecurr) &&
> +					$fix) {
> +					$fixed[$fixlinenr] =~ s/\b__attribute__\s*\(\s*\(\s*\Q$attr\E\s*\)\s*\)/$replace/;

I looks it would be useful to add
					$fixed[$fixlinenr] =~ s/\}\Q$replace\E/} $replace/;
so there's a space added between } and any replacements.


