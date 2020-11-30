Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5DEC2C89CE
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 17:45:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728617AbgK3QoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 11:44:02 -0500
Received: from smtprelay0224.hostedemail.com ([216.40.44.224]:56998 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725859AbgK3QoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 11:44:02 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id CC309837F24C;
        Mon, 30 Nov 2020 16:43:19 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3871:3872:3874:4321:5007:7875:7903:8531:9545:10004:10400:10848:11026:11232:11658:11914:12043:12296:12297:12740:12895:13069:13311:13357:13439:13894:14181:14659:14721:21080:21451:21627:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: lip88_3b10053273a3
X-Filterd-Recvd-Size: 1906
Received: from XPS-9350.home (unknown [47.151.128.180])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Mon, 30 Nov 2020 16:43:18 +0000 (UTC)
Message-ID: <c8eeab847fc09368ce270ea3e06ea0bbbd7d1b7f.camel@perches.com>
Subject: Re: [PATCH] checkpatch: fix TYPO_SPELLING check for words with
 apostrophe
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com,
        Peilin Ye <yepeilin.cs@gmail.com>
Date:   Mon, 30 Nov 2020 08:43:17 -0800
In-Reply-To: <20201130144515.8320-1-dwaipayanray1@gmail.com>
References: <20201130144515.8320-1-dwaipayanray1@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-11-30 at 20:15 +0530, Dwaipayan Ray wrote:
> checkpatch reports a false TYPO_SPELLING warning for some words
> containing an apostrophe.
> 
> A false positive is "doesn't". Occurrence of the word causes
> checkpatch to emit the following warning:
> 
> "WARNING: 'doesn'' may be misspelled - perhaps 'doesn't'?"
> 
> Check the word boundary for such cases so that words like
> "doesn't", "zig-zag", etc. aren't misinterpreted due to wrong
> splitting of the word by the \b regex metacharacter.
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -3106,7 +3106,7 @@ sub process {
>  # Check for various typo / spelling mistakes
>  		if (defined($misspellings) &&
>  		    ($in_commit_log || $line =~ /^(?:\+|Subject:)/i)) {
> -			while ($rawline =~ /(?:^|[^a-z@])($misspellings)(?:\b|$|[^a-z@])/gi) {
> +			while ($rawline =~ /(?:^|[^a-z@])($misspellings)(?:\b(?![^\w]?[a-z@]+)|$|[^a-z@])/gi) {

Wouldn't it be simpler to change the existing [^a-z@] blocks to [^a-z@'-] ?


