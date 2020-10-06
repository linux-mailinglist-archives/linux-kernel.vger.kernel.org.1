Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28EE62848BE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 10:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726000AbgJFIln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 04:41:43 -0400
Received: from smtprelay0039.hostedemail.com ([216.40.44.39]:41366 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725912AbgJFIln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 04:41:43 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id F1A551802E636;
        Tue,  6 Oct 2020 08:41:58 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:152:355:379:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2538:2559:2562:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3870:3871:3872:3873:4321:4362:4605:5007:6690:7875:7903:7974:8784:9121:10004:10400:10848:11026:11232:11233:11473:11658:11914:12043:12048:12297:12438:12555:12740:12895:13069:13141:13146:13230:13311:13357:13894:14181:14659:14721:21080:21325:21451:21627:21740:30012:30054:30067:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: blood15_5b13f4f271c5
X-Filterd-Recvd-Size: 2753
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Tue,  6 Oct 2020 08:41:57 +0000 (UTC)
Message-ID: <23e7b9e33738bfa1b1d1ac0ccd4d78235decaa30.camel@perches.com>
Subject: Re: [PATCH v2] checkpatch: Fix false positive on empty block
 comment lines
From:   Joe Perches <joe@perches.com>
To:     =?UTF-8?Q?=C5=81ukasz?= Stelmach <l.stelmach@samsung.com>,
        Andy Whitcroft <apw@canonical.com>,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     =?UTF-8?Q?Bart=C5=82omiej_?= =?UTF-8?Q?=C5=BBolnierkiewicz?= 
        <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Date:   Tue, 06 Oct 2020 01:41:56 -0700
In-Reply-To: <20201006083509.19934-1-l.stelmach@samsung.com>
References: <CGME20201006083511eucas1p213c64f56efcc905970fa2b26a05c55bf@eucas1p2.samsung.com>
         <20201006083509.19934-1-l.stelmach@samsung.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-10-06 at 10:35 +0200, Łukasz Stelmach wrote:
> To avoid false positives in presence of SPDX-License-Identifier in
> networking files it is required to increase the leeway for empty block
> comment lines by one line.
> 
> For example, checking drivers/net/loopback.c which starts with
> 
>     // SPDX-License-Identifier: GPL-2.0-or-later
>     /*
>      * INET          An implementation of the TCP/IP protocol suite for the LINUX
> 
> rsults in an unnecessary warning
> 
>     WARNING: networking block comments don't use an empty /* line, use /* Comment...
>     +/*
>     + * INET                An implementation of the TCP/IP protocol suite for the LINUX
> 
> Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>

Thank Lukasz.  Andrew, can you please pick this up?

> ---
>  scripts/checkpatch.pl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Changes in v2:
>   - added example warning in the commit description
>   - added a comment in the code
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index a213cdb82ab0..3555ac812c99 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3460,7 +3460,7 @@ sub process {
>  		if ($realfile =~ m@^(drivers/net/|net/)@ &&
>  		    $prevrawline =~ /^\+[ \t]*\/\*[ \t]*$/ &&
>  		    $rawline =~ /^\+[ \t]*\*/ &&
> -		    $realline > 2) {
> +		    $realline > 3) { # Do not warn about the initial copyright comment block after SPDX-License-Identifier
>  			WARN("NETWORKING_BLOCK_COMMENT_STYLE",
>  			     "networking block comments don't use an empty /* line, use /* Comment...\n" . $hereprev);
>  		}

