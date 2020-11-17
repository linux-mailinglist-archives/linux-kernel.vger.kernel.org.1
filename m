Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC212B692F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 16:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726742AbgKQP6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 10:58:23 -0500
Received: from smtprelay0003.hostedemail.com ([216.40.44.3]:36376 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725767AbgKQP6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 10:58:23 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 56C59182CF66C;
        Tue, 17 Nov 2020 15:58:22 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:968:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2197:2199:2393:2559:2562:2691:2828:3138:3139:3140:3141:3142:3352:3622:3653:3865:3866:3867:3868:3871:3872:4321:5007:10004:10400:10848:11232:11658:11914:12043:12297:12438:12740:12895:13069:13311:13357:13439:13894:14181:14659:21080:21221:21627:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: push88_2a0d62927332
X-Filterd-Recvd-Size: 1813
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Tue, 17 Nov 2020 15:58:21 +0000 (UTC)
Message-ID: <756a22eddf82cbbdcdfe5bef1735154d123cd081.camel@perches.com>
Subject: Re: [PATCH v2] checkpatch: add fix option for
 ASSIGNMENT_CONTINUATIONS
From:   Joe Perches <joe@perches.com>
To:     Aditya Srivastava <yashsri421@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com
Date:   Tue, 17 Nov 2020 07:58:20 -0800
In-Reply-To: <20201117105237.757-1-yashsri421@gmail.com>
References: <20201117105237.757-1-yashsri421@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-11-17 at 16:22 +0530, Aditya Srivastava wrote:
> Currently, checkpatch warns us if an assignment operator is placed
> at the start of a line and not at the end of previous line.
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -3542,8 +3542,14 @@ sub process {
>  
> 
>  # check for assignments on the start of a line
>  		if ($sline =~ /^\+\s+($Assignment)[^=]/) {
> -			CHK("ASSIGNMENT_CONTINUATIONS",
> -			    "Assignment operator '$1' should be on the previous line\n" . $hereprev);
> +			my $operator = $1;
> +			if (CHK("ASSIGNMENT_CONTINUATIONS",
> +				"Assignment operator '$1' should be on the previous line\n" . $hereprev) &&
> +			    $fix && $prevrawline =~ /^\+/) {
> +				# add assignment operator to the previous line, remove from current line
> +				$fixed[$fixlinenr - 1] .= " $operator";
> +				$fixed[$fixlinenr] =~ s/$operator\s*//;

As $operator could be a division, I believe it needs to be quoted.


