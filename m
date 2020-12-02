Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2A7D2CC346
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 18:17:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387615AbgLBRRS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 12:17:18 -0500
Received: from smtprelay0019.hostedemail.com ([216.40.44.19]:40802 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727641AbgLBRRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 12:17:18 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 5E9C318029136;
        Wed,  2 Dec 2020 17:16:37 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2691:2828:3138:3139:3140:3141:3142:3353:3622:3653:3865:3866:3867:3868:3870:3871:3872:3874:4321:5007:7903:10004:10400:11026:11232:11473:11658:11914:12043:12050:12109:12297:12438:12740:12895:13069:13163:13229:13311:13357:13439:13894:14181:14659:14721:21080:21324:21611:21627:21990:30054:30062:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: gate97_4517256273b4
X-Filterd-Recvd-Size: 2256
Received: from XPS-9350.home (unknown [47.151.128.180])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Wed,  2 Dec 2020 17:16:36 +0000 (UTC)
Message-ID: <280235acc0e91365f3fd3b5be5a5244eced1ff61.camel@perches.com>
Subject: Re: [PATCH] checkpatch: add fix for non-standard signature -
 co-authored-by
From:   Joe Perches <joe@perches.com>
To:     Aditya Srivastava <yashsri421@gmail.com>
Cc:     lukas.bulwahn@gmail.com, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Date:   Wed, 02 Dec 2020 09:16:35 -0800
In-Reply-To: <20201202090828.12934-1-yashsri421@gmail.com>
References: <ceb3ffcdae151d6ea1d7f1a45bf61b3d2a1c183c.camel@perches.com>
         <20201202090828.12934-1-yashsri421@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-12-02 at 14:38 +0530, Aditya Srivastava wrote:
> Currently, checkpatch.pl warns for BAD_SIGN_OFF on the usage of
> non-standard signatures.
> 
> An evaluation on v4.13..v5.8 showed that out of 539 warnings due to
> non-standard signatures, 43 are due to the use of 'Co-authored-by'
> tag, which may seem correct, but is not standard.
> 
> The standard signature equivalent for 'Co-authored-by' is
> 'Co-developed-by'.
> 
> Provide a fix by suggesting users with this signature alternative and
> replacing.

This doesn't apply to either today's linux or -next.

It is dependent on a patch that is only in Andrew Morton's mmots.
Your patch subject should show that in the brackets.
Something like:

[PATCH -mmots] checkpatch: etc...

Adding --fix options to the obvious spelling typos in these signature
by-lines tags are a different case but I think this is a relatively low
value patch as I don't believe these tags should be limited in this way.

Maybe Andrew likes it.

> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -2832,6 +2832,9 @@ sub process {
>  
> 
>  			if ($sign_off !~ /$signature_tags/) {
>  				my $suggested_signature = find_standard_signature($sign_off);
> +				if ($sign_off =~ /co-authored-by:/i) {
> +					$suggested_signature = "Co-developed-by:";
> +				}


