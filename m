Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02D162CC608
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 19:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389715AbgLBS5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 13:57:37 -0500
Received: from smtprelay0094.hostedemail.com ([216.40.44.94]:41446 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387784AbgLBS5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 13:57:37 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 80698837F27B;
        Wed,  2 Dec 2020 18:56:56 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3653:3865:3866:3867:3868:3871:3873:3874:4321:5007:7514:7875:7903:10004:10400:10848:11026:11232:11473:11658:11914:12043:12109:12297:12438:12555:12663:12740:12895:12986:13069:13255:13311:13357:13439:13894:14181:14659:14721:21080:21324:21451:21627:30054:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: tiger43_1400336273b5
X-Filterd-Recvd-Size: 2333
Received: from XPS-9350.home (unknown [47.151.128.180])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Wed,  2 Dec 2020 18:56:55 +0000 (UTC)
Message-ID: <5afbcd1423ee8fc2dfad191d94aef6efc17198c8.camel@perches.com>
Subject: Re: [PATCH -mmots] checkpatch: add fix for non-standard signature -
 co-authored-by
From:   Joe Perches <joe@perches.com>
To:     Aditya Srivastava <yashsri421@gmail.com>
Cc:     lukas.bulwahn@gmail.com, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Date:   Wed, 02 Dec 2020 10:56:54 -0800
In-Reply-To: <20201202183045.9309-1-yashsri421@gmail.com>
References: <280235acc0e91365f3fd3b5be5a5244eced1ff61.camel@perches.com>
         <20201202183045.9309-1-yashsri421@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-12-03 at 00:00 +0530, Aditya Srivastava wrote:
> Currently, checkpatch.pl warns us for BAD_SIGN_OFF on the usage of
> non-standard signatures.
>
> An evaluation on v4.13..v5.8 showed that out of 539 warnings due to
> non-standard signatures, 43 are due to the use of 'Co-authored-by'
> tag, which may seem correct, but is not standard.
> 
> The standard signature equivalent for 'Co-authored-by' is
> 'Co-developed-by'.

I'm not going to ack this as I don't mind non-standard signatures.

You should also always use patch subject versioning and include
a changelog after the --- line.

> Provide a fix by suggesting users with this signature alternative and
> replacing.
> 
> Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
> ---
>  scripts/checkpatch.pl | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 4a026926139f..fc036d545d2d 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -2832,6 +2832,9 @@ sub process {
>  
> 
>  			if ($sign_off !~ /$signature_tags/) {
>  				my $suggested_signature = find_standard_signature($sign_off);
> +				if ($sign_off =~ /co-authored-by:/i) {
> +					$suggested_signature = "Co-developed-by:";
> +				}
>  				if ($suggested_signature eq "") {
>  					WARN("BAD_SIGN_OFF",
>  					     "Non-standard signature: $sign_off\n" . $herecurr);


