Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 293702BBED4
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Nov 2020 13:13:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbgKUMKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Nov 2020 07:10:32 -0500
Received: from smtprelay0030.hostedemail.com ([216.40.44.30]:39332 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727191AbgKUMKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Nov 2020 07:10:32 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id BB7C0837F24A;
        Sat, 21 Nov 2020 12:10:30 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:968:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2197:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3353:3622:3653:3865:3866:3867:3868:3870:3871:4321:5007:7514:7903:10004:10400:10848:11232:11658:11914:12043:12296:12297:12438:12555:12740:12895:13439:13894:14181:14659:14721:21080:21221:21451:21627:21740:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: drain07_1a158e527354
X-Filterd-Recvd-Size: 2923
Received: from XPS-9350.home (unknown [47.151.128.180])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Sat, 21 Nov 2020 12:10:29 +0000 (UTC)
Message-ID: <edc52eb1c1515a592d93799933021ff39ba8028e.camel@perches.com>
Subject: Re: [PATCH v4] checkpatch: add fix option for
 ASSIGNMENT_CONTINUATIONS
From:   Joe Perches <joe@perches.com>
To:     Aditya Srivastava <yashsri421@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 21 Nov 2020 04:10:28 -0800
In-Reply-To: <20201121120407.22942-1-yashsri421@gmail.com>
References: <1d7692d0-359f-6b6a-32d4-1627ebd8b100@gmail.com>
         <20201121120407.22942-1-yashsri421@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-11-21 at 17:34 +0530, Aditya Srivastava wrote:
> Currently, checkpatch warns us if an assignment operator is placed
> at the start of a line and not at the end of previous line.

Right, thanks.

Acked-by: Joe Perches <joe@perches.com>

> 
> E.g., running checkpatch on commit 8195b1396ec8 ("hv_netvsc: fix
> deadlock on hotplug") reports:
> 
> CHECK: Assignment operator '=' should be on the previous line
> +	struct netvsc_device *nvdev
> +		= container_of(w, struct netvsc_device, subchan_work);
> 
> Provide a simple fix by appending assignment operator to the previous
> line and removing from the current line, if both the lines are additions
> (ie start with '+')
> 
> Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
> ---
> Changes in v2:
> add check if both the lines are additions (ie start with '+')
> 
> Changes in v3:
> quote $operator; test with division assignment operator ('/=')
> 
> Changes in v4:
> fix incorrect use of quote
> 
>  scripts/checkpatch.pl | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 2749f32dffe9..d4c8d42cb13e 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3533,8 +3533,14 @@ sub process {
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
> +				$fixed[$fixlinenr] =~ s/\Q$operator\E\s*//;
> +			}
>  		}
>  
> 
>  # check for && or || at the start of a line


