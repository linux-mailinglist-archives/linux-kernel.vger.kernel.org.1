Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2406F2A050C
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 13:10:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726317AbgJ3MKN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 08:10:13 -0400
Received: from smtprelay0084.hostedemail.com ([216.40.44.84]:52220 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725922AbgJ3MKM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 08:10:12 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 94D22180286DE;
        Fri, 30 Oct 2020 12:10:11 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:968:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:1801:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:4321:4605:5007:7903:10004:10400:11026:11232:11473:11658:11914:12043:12297:12438:12555:12679:12740:12895:13069:13311:13357:13439:13894:14181:14659:14721:21063:21080:21365:21433:21451:21627:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:3,LUA_SUMMARY:none
X-HE-Tag: turn44_2e084d327295
X-Filterd-Recvd-Size: 2361
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf06.hostedemail.com (Postfix) with ESMTPA;
        Fri, 30 Oct 2020 12:10:10 +0000 (UTC)
Message-ID: <926a2f22e12bf989d46dc36c8779c50183bf4b7e.camel@perches.com>
Subject: Re: [PATCH] checkpatch: add fix option for GERRIT_CHANGE_ID
From:   Joe Perches <joe@perches.com>
To:     Aditya Srivastava <yashsri421@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        lukas.bulwahn@gmail.com, Andrew Morton <akpm@linux-foundation.org>
Date:   Fri, 30 Oct 2020 05:10:09 -0700
In-Reply-To: <20201030114447.24199-1-yashsri421@gmail.com>
References: <20201030114447.24199-1-yashsri421@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-10-30 at 17:14 +0530, Aditya Srivastava wrote:
> Currently, whenever a Gerrit Change-Id is present in a commit,
> checkpatch.pl warns to remove the Change-Id before submitting the patch.
> 
> E.g., running checkpatch on commit adc311a5bbf6 ("iwlwifi: bump FW
> API to 53 for 22000 series") reports this error:
> 
> ERROR: Remove Gerrit Change-Id's before submitting upstream
> Change-Id: I5725e46394f3f53c3069723fd513cc53c7df383d
> 
> Provide a simple fix option by simply deleting the indicated line.
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -2852,8 +2852,11 @@ sub process {
>  
> 
>  # Check for Gerrit Change-Ids not in any patch context
>  		if ($realfile eq '' && !$has_patch_separator && $line =~ /^\s*change-id:/i) {
> -			ERROR("GERRIT_CHANGE_ID",
> -			      "Remove Gerrit Change-Id's before submitting upstream\n" . $herecurr);
> +			if (ERROR("GERRIT_CHANGE_ID",
> +			          "Remove Gerrit Change-Id's before submitting upstream\n" . $herecurr) &&
> +			    $fix) {
> +                                fix_delete_line($fixlinenr, $rawline);
> +                        }
>  		}

Seems sensible, thanks.

It might also be sensible if the line before and the line after
this change-id is also blank to remove one of those blank lines.

On second thought:

A quick check shows less than 20 of those in kernel git history
so it might not be too worthwhile.

Acked-by: Joe Perches <joe@perches.com>


