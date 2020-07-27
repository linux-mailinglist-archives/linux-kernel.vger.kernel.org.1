Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9D6422E5BF
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Jul 2020 08:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbgG0GOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jul 2020 02:14:46 -0400
Received: from smtprelay0011.hostedemail.com ([216.40.44.11]:36592 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726116AbgG0GOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 02:14:46 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id BE710182CED5B;
        Mon, 27 Jul 2020 06:14:44 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:2902:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:4321:4605:5007:7514:8531:10004:10400:10450:10455:11026:11232:11473:11658:11914:12043:12048:12296:12297:12438:12555:12740:12760:12895:12986:13069:13255:13311:13357:13439:14093:14097:14181:14659:14721:19904:19999:21080:21433:21451:21627:21660:21939:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: start73_170cec826f5f
X-Filterd-Recvd-Size: 2345
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Mon, 27 Jul 2020 06:14:43 +0000 (UTC)
Message-ID: <66bbaec73d8f69541535db5390c0f12b304c0467.camel@perches.com>
Subject: Re: [PATCH] checkpatch: disable commit log length check warning for
 signature tag
From:   Joe Perches <joe@perches.com>
To:     Nachiket Naganure <nachiketun8@gmail.com>, apw@canonical.com,
        lukas.bulwahn@gmail.com, skhan@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Date:   Sun, 26 Jul 2020 23:14:42 -0700
In-Reply-To: <20200727055458.559558-1-nachiketun8@gmail.com>
References: <20200727055458.559558-1-nachiketun8@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-07-27 at 11:24 +0530, Nachiket Naganure wrote:
> Disable commit log length check in case of signature tag. If the commit
> log line has valid signature tags such as "Reported-and-tested-by" with
> more than 75 characters, suppress the long length warning.
> 
> For instance in commit ac854131d984 ("USB: core: Fix misleading driver bug
> report"), the corresponding patch contains a "Reported by" tag line which
> exceeds 75 chars. And there is no valid way to shorten the length.
> 
> Signed-off-by: Nachiket Naganure <nachiketun8@gmail.com>
> ---
>  scripts/checkpatch.pl | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 197436b20288..46237e9e0550 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -2806,6 +2806,8 @@ sub process {
>  					# filename then :
>  		      $line =~ /^\s*(?:Fixes:|Link:)/i ||
>  					# A Fixes: or Link: line
> +		      $line =~ /$signature_tags/ ||
> +					# Check for signature_tags
>  		      $commit_log_possible_stack_dump)) {
>  			WARN("COMMIT_LOG_LONG_LINE",
>  			     "Possible unwrapped commit description (prefer a maximum 75 chars per line)\n" . $herecurr);

OK, but the test should be:

		      $line =~ /^\s*$signature_tags/ ||

so the line has to start with a signature and
it won't match on signature tags in the middle
of other content on the same line.


