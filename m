Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62F3F291260
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Oct 2020 16:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438343AbgJQO1a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Oct 2020 10:27:30 -0400
Received: from smtprelay0224.hostedemail.com ([216.40.44.224]:34802 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2437013AbgJQO13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Oct 2020 10:27:29 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave05.hostedemail.com (Postfix) with ESMTP id BCFE5182895B9
        for <linux-kernel@vger.kernel.org>; Sat, 17 Oct 2020 14:27:28 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id E81DA837F24A;
        Sat, 17 Oct 2020 14:27:27 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:968:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1434:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3653:3865:3866:3870:3873:4321:4362:4605:5007:7576:7904:7974:10004:10400:10848:11026:11232:11473:11658:11914:12297:12555:12740:12760:12895:13069:13095:13311:13357:13439:14181:14659:14721:21080:21325:21433:21627:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: test28_1d11acb27226
X-Filterd-Recvd-Size: 1964
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Sat, 17 Oct 2020 14:27:27 +0000 (UTC)
Message-ID: <25b86b7d30a3a94faf4e7279bcc34af1c522303f.camel@perches.com>
Subject: Re: [PATCH v2] checkpatch: add a fixer for missing newline at eof
From:   Joe Perches <joe@perches.com>
To:     trix@redhat.com, apw@canonical.com,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org
Date:   Sat, 17 Oct 2020 07:27:25 -0700
In-Reply-To: <20201017142546.28988-1-trix@redhat.com>
References: <20201017142546.28988-1-trix@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-10-17 at 07:25 -0700, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> Remove the trailing error message from the fixed lines
> 
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
> v2: fix whitespace

Thanks Tom.  Andrew can you pick this up please?

> ---
>  scripts/checkpatch.pl | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index fab38b493cef..f9e78a5385ad 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3393,8 +3393,11 @@ sub process {
>  
>  # check for adding lines without a newline.
>  		if ($line =~ /^\+/ && defined $lines[$linenr] && $lines[$linenr] =~ /^\\ No newline at end of file/) {
> -			WARN("MISSING_EOF_NEWLINE",
> -			     "adding a line without newline at end of file\n" . $herecurr);
> +			if (WARN("MISSING_EOF_NEWLINE",
> +			         "adding a line without newline at end of file\n" . $herecurr) &&
> +			    $fix) {
> +				fix_delete_line($fixlinenr+1, "No newline at end of file");
> +			}
>  		}
>  
>  # check we are in a valid source file C or perl if not then ignore this hunk

