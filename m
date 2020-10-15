Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A495028E987
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 02:43:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726980AbgJOAmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 20:42:43 -0400
Received: from smtprelay0136.hostedemail.com ([216.40.44.136]:52958 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726018AbgJOAmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 20:42:43 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 0CDEA100E7B44;
        Thu, 15 Oct 2020 00:42:42 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:968:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1434:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3653:3865:3866:3871:4321:4605:5007:7576:10004:10400:10848:11026:11232:11473:11658:11914:12297:12740:12760:12895:13069:13071:13095:13311:13357:13439:14180:14181:14659:14721:21060:21080:21433:21627:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: wave33_0e0ab4727210
X-Filterd-Recvd-Size: 1611
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Thu, 15 Oct 2020 00:42:41 +0000 (UTC)
Message-ID: <7983b5dcb7f589e31fb954cfc1472a93244984fb.camel@perches.com>
Subject: Re: [PATCH] checkpatch: add a fixer for missing newline at eof
From:   Joe Perches <joe@perches.com>
To:     trix@redhat.com, apw@canonical.com
Cc:     linux-kernel@vger.kernel.org
Date:   Wed, 14 Oct 2020 17:42:40 -0700
In-Reply-To: <20201014211540.15732-1-trix@redhat.com>
References: <20201014211540.15732-1-trix@redhat.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-10-14 at 14:15 -0700, trix@redhat.com wrote:
> From: Tom Rix <trix@redhat.com>
> 
> Remove the trailing error message from the fixed lines

Hi Tom.

> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -3393,8 +3393,11 @@ sub process {
>  
>  # check for adding lines without a newline.
>  		if ($line =~ /^\+/ && defined $lines[$linenr] && $lines[$linenr] =~ /^\\ No newline at end of file/) {
> -			WARN("MISSING_EOF_NEWLINE",
> -			     "adding a line without newline at end of file\n" . $herecurr);
> +			if (WARN("MISSING_EOF_NEWLINE",
> +			         "adding a line without newline at end of file\n" . $herecurr) &&
> +			    $fix) {
> +			    fix_delete_line($fixlinenr+1, "No newline at end of file");

This is misindented, the 4 spaces before fix_delete_line
should be a tab, otherwise this looks fine, thanks.


