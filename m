Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D33972BC0BD
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 17:58:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727301AbgKUQ4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Nov 2020 11:56:09 -0500
Received: from smtprelay0167.hostedemail.com ([216.40.44.167]:40936 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727071AbgKUQ4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Nov 2020 11:56:08 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id BBB80182CED2A;
        Sat, 21 Nov 2020 16:56:07 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:968:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2197:2198:2199:2200:2393:2559:2562:2828:3138:3139:3140:3141:3142:3353:3622:3653:3865:3866:3867:3868:3871:4321:5007:7903:10004:10400:10848:11232:11658:11914:12297:12438:12555:12740:12895:13069:13311:13357:13439:13894:14181:14659:14721:21080:21221:21451:21627:21774:30030:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: push52_240621927355
X-Filterd-Recvd-Size: 2363
Received: from XPS-9350.home (unknown [47.151.128.180])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Sat, 21 Nov 2020 16:56:06 +0000 (UTC)
Message-ID: <d68afd4b87e2ce3fc846d8ca5ab9a401ce04344a.camel@perches.com>
Subject: Re: [PATCH v2] checkpatch: add fix option for LOGICAL_CONTINUATIONS
From:   Joe Perches <joe@perches.com>
To:     Aditya Srivastava <yashsri421@gmail.com>
Cc:     lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 21 Nov 2020 08:56:05 -0800
In-Reply-To: <20201121121557.23528-1-yashsri421@gmail.com>
References: <20201121121557.23528-1-yashsri421@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-11-21 at 17:45 +0530, Aditya Srivastava wrote:
> Currently, checkpatch warns if logical continuations are placed at the
> start of a line and not at the end of previous line.
> 
> E.g., running checkpatch on commit 3485507fc272 ("staging:
> bcm2835-camera: Reduce length of enum names") reports:
> 
> CHECK:LOGICAL_CONTINUATIONS: Logical continuations should be on the
> previous line
> +	if (!ret
> +	    && camera_port ==
> 
> Provide a simple fix by adding logical operator at the end of previous
> line and removing from current line, if both the lines are additions
> (ie start with '+')
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -3553,8 +3553,14 @@ sub process {
>  
> 
>  # check for && or || at the start of a line
>  		if ($rawline =~ /^\+\s*(&&|\|\|)/) {
> -			CHK("LOGICAL_CONTINUATIONS",
> -			    "Logical continuations should be on the previous line\n" . $hereprev);
> +			my $operator = $1;
> +			if (CHK("LOGICAL_CONTINUATIONS",
> +				"Logical continuations should be on the previous line\n" . $hereprev) &&
> +			    $fix && $prevrawline =~ /^\+/) {
> +				# add logical operator to the previous line, remove from current line
> +				$fixed[$fixlinenr - 1] .= " $operator";
> +				$fixed[$fixlinenr] =~ s/\Q$operator\E\s*//;
> +			}

One thing to be concerned about is a statement like

	if (foo		// comment
	    && bar)

This should really perform the insertion at the last
non-comment, non-whitespace char of the previous line.


