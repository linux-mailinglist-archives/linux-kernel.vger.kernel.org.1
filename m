Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB57296D50
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Oct 2020 13:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S462746AbgJWLEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 07:04:46 -0400
Received: from smtprelay0115.hostedemail.com ([216.40.44.115]:54974 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S462676AbgJWLEp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 07:04:45 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id C4F128B759EE;
        Fri, 23 Oct 2020 11:04:44 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:305:355:379:599:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2197:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3354:3622:3653:3865:3866:3867:3868:3870:3871:3872:3873:3874:4321:5007:6120:7901:7903:10004:10400:10848:11026:11232:11473:11658:11914:12043:12297:12438:12740:12760:12895:13439:13972:14659:14721:21080:21221:21627:30054:30070:30079:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: bag64_200105227259
X-Filterd-Recvd-Size: 3643
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Fri, 23 Oct 2020 11:04:43 +0000 (UTC)
Message-ID: <d2b05b45adbcf3f1d16692b054862a7aa7353f6d.camel@perches.com>
Subject: Re: [PATCH RFC v2] checkpatch: extend attributes check to handle
 more patterns
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com
Date:   Fri, 23 Oct 2020 04:04:42 -0700
In-Reply-To: <20201023094307.20820-1-dwaipayanray1@gmail.com>
References: <20201023094307.20820-1-dwaipayanray1@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-10-23 at 15:13 +0530, Dwaipayan Ray wrote:
> It is generally preferred that the macros from
> include/linux/compiler_attributes.h are used, unless there
> is a reason not to.
> 
> Checkpatch currently checks __attribute__ for each of

checkpatch, no need for capitalization

and non-trivially:

> +			my $attr_list = qr {
> +				__alias__|
> +				__aligned__$|
> +				__aligned__\(.*\)|
> +				__always_inline__|
> +				__assume_aligned__\(.*\)|
> +				__cold__|
> +				__const__|
> +				__copy__\(.*\)|
> +				__designated_init__|
> +				__externally_visible__|
> +				__fallthrough__|
> +				__gnu_inline__|
> +				__malloc__|
> +				__mode__\(.*\)|
> +				__no_caller_saved_registers__|
> +				__noclone__|
> +				__noinline__|
> +				__nonstring__|
> +				__noreturn__|
> +				__packed__|
> +				__pure__|
> +				__used__
> +			}x;
[]
> +			my %attr_replace = (
> +				"__alias__"			=> "__alias",
> +				"__aligned__"		=> "__aligned_largest",
> +				"__aligned__("		=> "__aligned",
> +				"__always_inline__" 	=> "__always_inline",
> +				"__assume_aligned__("	=> "__assume_aligned",
> +				"__cold__"			=> "__cold",
> +				"__const__"			=> "__const",
> +				"__copy__("			=> "__copy",
> +				"__designated_init__"		=> "__designated_init",
> +				"__externally_visible__"	=> "__visible",
> +				"__fallthrough__"		=> "fallthrough",
> +				"__gnu_inline__"		=> "__gnu_inline",
> +				"__malloc__"		=> "__malloc",
> +				"__mode__("			=> "__mode",
> +				"__no_caller_saved_registers__" => "__no_caller_saved_registers",
> +				"__noclone__"		=> "__noclone",
> +				"__noinline__"		=> "noinline",
> +				"__nonstring__"		=> "__nonstring",
> +				"__noreturn__"		=> "__noreturn",
> +				"__packed__"		=> "__packed",
> +				"__pure__"			=> "__pure",
> +				"__used__"			=> "__used"
> +			);
> +
> +			if ($attr =~/^($attr_list)/) {

I would remove the __ from the entries here.

And you could check using

	$line =~ /__attribute__\s*\(\s*($balanced_parens)\s*)/

and check for all attributes in $1 after
stripping the leading and trailing parens
and any leading and trailing underscores
from each attribute.

And you only need one hash and you should 
check for existence of the key rather than
have multiple lists.

	if (exists($attributes($attr))) {

> +				my $old = $1;
> +				if ($old =~ /^(__.+__\()(.*)\)/) {
> +					my $new = $attr_replace{$1};
> +					WARN("PREFER_DEFINED_ATTRIBUTE_MACRO",
> +					     "$new($2) is preffered over __attribute__(($old))\n" . $herecurr);

preferred

> +				} else {
> +					my $new = $attr_replace{$old};
> +					WARN("PREFER_DEFINED_ATTRIBUTE_MACRO",
> +					     "$new is preffered over __attribute__(($old))\n" . $herecurr);
> +				}
> +			}


