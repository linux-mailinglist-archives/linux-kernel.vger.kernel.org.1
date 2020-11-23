Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 573742BFFB7
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 06:48:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgKWFrS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 00:47:18 -0500
Received: from smtprelay0166.hostedemail.com ([216.40.44.166]:51520 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726802AbgKWFrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 00:47:17 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 0BAAB182CF665;
        Mon, 23 Nov 2020 05:47:16 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2197:2198:2199:2200:2393:2559:2562:2828:3138:3139:3140:3141:3142:3353:3622:3653:3865:3866:3867:3868:3873:4321:5007:7514:7903:10004:10400:10848:11232:11658:11914:12297:12438:12555:12740:12895:13069:13311:13357:13439:13894:14181:14659:14721:21080:21221:21451:21627:21740:21774:30030:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: room91_1714d1927363
X-Filterd-Recvd-Size: 2627
Received: from XPS-9350.home (unknown [47.151.128.180])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Mon, 23 Nov 2020 05:47:15 +0000 (UTC)
Message-ID: <afaa79a6d86a4184878595ced3f2de1a92a4058c.camel@perches.com>
Subject: Re: [PATCH v6] checkpatch: add fix option for LOGICAL_CONTINUATIONS
From:   Joe Perches <joe@perches.com>
To:     Aditya Srivastava <yashsri421@gmail.com>
Cc:     lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Date:   Sun, 22 Nov 2020 21:47:13 -0800
In-Reply-To: <20201122125908.22212-1-yashsri421@gmail.com>
References: <368300090d93ad66f7fb19076d076d4321a04c42.camel@perches.com>
         <20201122125908.22212-1-yashsri421@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-11-22 at 18:29 +0530, Aditya Srivastava wrote:
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
> Provide a simple fix by inserting logical operator at the last
> non-comment, non-whitespace char of the previous line and removing from
> current line, if both the lines are additions(ie start with '+')
> 
> Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -3553,8 +3553,16 @@ sub process {
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
> +				# insert logical operator at last non-comment, non-whitepsace char on previous line
> +				$prevline =~ /[\s$;]*$/;
> +				my $line_end = substr($prevrawline, $-[0]);
> +				$fixed[$fixlinenr - 1] =~ s/\Q$line_end\E/ $operator$line_end/;

This doesn't work when the same leading whitespace and trailing whitespace
characters exist.

You need to use something like:

				$fixed[$fixlinenr - 1] =~ s/\Q$line_end\E$/ $operator$line_end/;

(note the $ after \E to use EOL)


