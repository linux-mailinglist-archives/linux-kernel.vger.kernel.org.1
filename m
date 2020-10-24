Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA52297F84
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 01:22:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762910AbgJXXVj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Oct 2020 19:21:39 -0400
Received: from smtprelay0225.hostedemail.com ([216.40.44.225]:57300 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1762900AbgJXXVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Oct 2020 19:21:39 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 47821837F24C;
        Sat, 24 Oct 2020 23:21:38 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:968:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:1981:2194:2197:2198:2199:2200:2201:2393:2559:2562:2828:3138:3139:3140:3141:3142:3353:3622:3653:3865:3866:3867:3868:3870:3871:3872:3874:4321:4605:5007:10004:10400:10848:11026:11232:11473:11658:11914:12043:12296:12297:12438:12740:12760:12895:13439:14659:14721:21080:21221:21627:30054:30070:30079:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: ants30_3d13d1a27266
X-Filterd-Recvd-Size: 3099
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Sat, 24 Oct 2020 23:21:37 +0000 (UTC)
Message-ID: <1d9d4793a6f89dda2e06ae73065ed7a28b50e02f.camel@perches.com>
Subject: Re: [PATCH v3] checkpatch: extend attributes check to handle more
 patterns
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com
Date:   Sat, 24 Oct 2020 16:21:36 -0700
In-Reply-To: <20201024090557.45092-1-dwaipayanray1@gmail.com>
References: <20201024090557.45092-1-dwaipayanray1@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-10-24 at 14:35 +0530, Dwaipayan Ray wrote:
> It is generally preferred that the macros from
> include/linux/compiler_attributes.h are used, unless there
> is a reason not to.
> 
> checkpatch currently checks __attribute__ for each of
> packed, aligned, printf, scanf, and weak. Other declarations
> in compiler_attributes.h are not handled.
> 
> Add a generic test to check the presence of such attributes.
> Some attributes require more specific handling and are kept
> separate.
[]
> -		}
> +		    $line =~ /__attribute__\s*\(\s*($balanced_parens)\s*\)/) {
> +			my $attr = $1;
> +			$attr =~ s/\s*\(\s*(.*)\)\s*/$1/;
> +
> +			my %attr_list = (
> +				"alias"				=> "__alias",
> +				"aligned"			=> "__aligned",
> +				"always_inline"			=> "__always_inline",
> +				"assume_aligned"		=> "__assume_aligned",
> +				"cold"				=> "__cold",
> +				"const"				=> "__const",
> +				"copy"				=> "__copy",
> +				"designated_init"		=> "__designated_init",
> +				"externally_visible"		=> "__visible",
> +				"fallthrough"			=> "fallthrough",

I'd remove fallthrough.

It doesn't make sense as the attribute could be in any line
of a switch/case block and fallthrough; must be the last line
of the block.

> +			if ($attr =~ /^(\w+)\s*(${balanced_parens})?/) {
> +				my $curr_attr = $1;
> +				my $params = '';
> +				$params = $2 if defined($2);
> +				$curr_attr =~ s/^[\s_]+|[\s_]+$//g;
> +
> +				if (exists($attr_list{$curr_attr})) {
> +					my $new = $attr_list{$curr_attr};
> +					WARN("PREFER_DEFINED_ATTRIBUTE_MACRO",
> +					     "$new$params is preffered over __attribute__(($attr))\n" . $herecurr);

Be nice to have a $fix option here

> +			# Check for __attribute__ format(printf, prefer __printf
> +			if ($attr =~ /^_*format_*\s*\(\s*printf/) {
> +				if (WARN("PREFER_DEFINED_ATTRIBUTE_MACRO",
> +				         "__printf(string-index, first-to-check) is preferred over __attribute__((format(printf, string-index, first-to-check)))\n" . $herecurr) &&
> +					$fix) {
> +					$fixed[$fixlinenr] =~ s/\b__attribute__\s*\(\s*\(\s*format\s*\(\s*printf\s*,\s*(.*)\)\s*\)\s*\)/"__printf(" . trim($1) . ")"/ex;

like for format(printf, index, pos)
and format(scanf, index, pos)


