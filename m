Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA5B2BC55E
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Nov 2020 12:32:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727531AbgKVLb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Nov 2020 06:31:59 -0500
Received: from smtprelay0148.hostedemail.com ([216.40.44.148]:52756 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727373AbgKVLb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Nov 2020 06:31:58 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id B32FC182CED28;
        Sun, 22 Nov 2020 11:31:57 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:968:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2197:2198:2199:2200:2393:2559:2562:2693:2828:3138:3139:3140:3141:3142:3354:3622:3653:3865:3866:3867:3868:3870:4321:5007:7514:7903:10004:10400:10848:11232:11658:11914:12294:12297:12438:12555:12740:12895:12986:13439:13894:14181:14659:14721:21063:21080:21221:21451:21627:21774:30030:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: rule91_3104a872735c
X-Filterd-Recvd-Size: 3330
Received: from XPS-9350.home (unknown [47.151.128.180])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Sun, 22 Nov 2020 11:31:56 +0000 (UTC)
Message-ID: <9ede7de2b1da90e025e64c86ffbcc7f44843de69.camel@perches.com>
Subject: Re: [PATCH v5] checkpatch: add fix option for LOGICAL_CONTINUATIONS
From:   Joe Perches <joe@perches.com>
To:     Aditya Srivastava <yashsri421@gmail.com>
Cc:     lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Date:   Sun, 22 Nov 2020 03:31:55 -0800
In-Reply-To: <20201122111025.17978-1-yashsri421@gmail.com>
References: <1823e72eb92280d30457dda49e0a0036dee15dd3.camel@perches.com>
         <20201122111025.17978-1-yashsri421@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-11-22 at 16:40 +0530, Aditya Srivastava wrote:
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
> 
> Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
> ---
> changes in v2: quote $operator at substitution
> 
> changes in v3: add a check for previous line ending with comment;
> If so, insert $operator at the last non-comment, non-whitespace char of the previous line
> 
> changes in v4: improve the matching mechanism by matching line termination at comment or white space;
> insert the operator before comments (if any) separated by a whitespace;
> append the comment and its pre-whitespace after the inserted operator (if comment was present),
> ie if no comment was present nothing will be inserted after the operator
> 
> changes in v5: improve regex for comment and line end with '$;'
> 
>  scripts/checkpatch.pl | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 5b1a5a65e69a..708a56f31466 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3553,8 +3553,17 @@ sub process {
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
> +				if ($prevline =~ /[\s$;]*$/) {
> +					my $line_end = substr($prevrawline, $-[0]);
> +					$fixed[$fixlinenr - 1] =~ s/\Q$line_end\E/ $operator$line_end/;
> +				}
> +				$fixed[$fixlinenr] =~ s/\Q$operator\E\s*//;
> +			}
>  		}
>  
> 
>  # check indentation starts on a tab stop


