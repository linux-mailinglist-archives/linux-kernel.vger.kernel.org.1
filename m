Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5BCA2B4BEC
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 17:59:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732408AbgKPQ7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Nov 2020 11:59:32 -0500
Received: from smtprelay0199.hostedemail.com ([216.40.44.199]:40142 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729849AbgKPQ7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Nov 2020 11:59:32 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 5480B181D3026;
        Mon, 16 Nov 2020 16:59:31 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:2902:3138:3139:3140:3141:3142:3352:3622:3870:3876:4321:4362:4605:5007:8531:10004:10400:10848:11026:11232:11473:11658:11914:12043:12114:12297:12438:12740:12895:13069:13255:13311:13357:13439:13894:14181:14659:14721:21080:21451:21627:21660:21939:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: camp83_5f113d12732a
X-Filterd-Recvd-Size: 1719
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Mon, 16 Nov 2020 16:59:30 +0000 (UTC)
Message-ID: <f3ac4a646b82ef2d31bfb0e9ea953b2c961de2c2.camel@perches.com>
Subject: Re: [PATCH v3] checkpatch: avoid COMMIT_LOG_LONG_LINE warning for
 signature tags
From:   Joe Perches <joe@perches.com>
To:     Aditya Srivastava <yashsri421@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     lukas.bulwahn@gmail.com, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Date:   Mon, 16 Nov 2020 08:59:28 -0800
In-Reply-To: <20201116083754.10629-1-yashsri421@gmail.com>
References: <20201116083754.10629-1-yashsri421@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-11-16 at 14:07 +0530, Aditya Srivastava wrote:
> Currently checkpatch warns us for long lines in commits even for
> signature tag lines.

Thanks Aditya.

Acked-by: Joe Perches <joe@perches.com>

> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -2961,8 +2961,8 @@ sub process {
>  					# file delta changes
>  		      $line =~ /^\s*(?:[\w\.\-]+\/)++[\w\.\-]+:/ ||
>  					# filename then :
> -		      $line =~ /^\s*(?:Fixes:|Link:)/i ||
> -					# A Fixes: or Link: line
> +		      $line =~ /^\s*(?:Fixes:|Link:|$signature_tags)/i ||
> +					# A Fixes: or Link: line or signature tag line
>  		      $commit_log_possible_stack_dump)) {
>  			WARN("COMMIT_LOG_LONG_LINE",
>  			     "Possible unwrapped commit description (prefer a maximum 75 chars per line)\n" . $herecurr);


