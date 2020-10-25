Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 790682980C5
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Oct 2020 09:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1763122AbgJYIWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Oct 2020 04:22:19 -0400
Received: from smtprelay0230.hostedemail.com ([216.40.44.230]:39056 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1735439AbgJYIWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Oct 2020 04:22:18 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id F0DF418224D7E;
        Sun, 25 Oct 2020 08:22:16 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 90,9,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:1981:2194:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3653:3865:3866:3867:3868:3870:3871:3872:3874:4321:4362:4605:5007:10004:10400:10848:11026:11232:11473:11658:11914:12043:12296:12297:12438:12740:12760:12895:13069:13311:13357:13439:14181:14659:14721:21080:21433:21627:21740:21741:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: drum10_180efbf27269
X-Filterd-Recvd-Size: 2240
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Sun, 25 Oct 2020 08:22:16 +0000 (UTC)
Message-ID: <e96f8306d57e9a2ce7118b545db197e819e97b19.camel@perches.com>
Subject: Re: [PATCH v4] checkpatch: extend attributes check to handle more
 patterns
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com
Date:   Sun, 25 Oct 2020 01:22:14 -0700
In-Reply-To: <20201025065134.21737-1-dwaipayanray1@gmail.com>
References: <20201025065134.21737-1-dwaipayanray1@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-10-25 at 12:21 +0530, Dwaipayan Ray wrote:
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
> Also add fixes for the generic attributes check.
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> +				if (exists($attr_list{$curr_attr})) {
> +					my $new = $attr_list{$curr_attr};
> +					if (WARN("PREFER_DEFINED_ATTRIBUTE_MACRO",
> +					         "$new$params is preferred over __attribute__(($attr))\n" . $herecurr) &&
> +						$fix) {
> +						$fixed[$fixlinenr] =~ s/\b__attribute__\s*\(\s*\(\s*\Q$attr\E\s*\)\s*\)/$new$params/;

Thanks.

This fix would only work for the single conversions
and would not work for multiple attributes like:

	__attribute__((aligned(4), packed))

It would be nice to be able to convert this to

	__aligned(4) __packed

One mechanism to do that might be to:

	create an empty array
	for each attr
		push(@array, conversion)
	s/__attribute__(...)/join(' ', @array)/

if all attrs were converted.


