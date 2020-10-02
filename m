Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51477281C1F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Oct 2020 21:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388317AbgJBTjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 15:39:15 -0400
Received: from smtprelay0143.hostedemail.com ([216.40.44.143]:44564 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725991AbgJBTjO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 15:39:14 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id CB712100E7B43;
        Fri,  2 Oct 2020 19:39:13 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:152:355:379:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:3138:3139:3140:3141:3142:3353:3622:3865:3866:3867:3870:3871:3872:4250:4321:4362:5007:6117:6690:7903:10004:10400:10848:11026:11232:11473:11658:11914:12043:12295:12297:12438:12555:12679:12740:12895:13141:13146:13161:13229:13230:13894:14181:14659:14721:21080:21451:21611:21627:21740:30012:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: bed23_4009da8271a6
X-Filterd-Recvd-Size: 3290
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Fri,  2 Oct 2020 19:39:12 +0000 (UTC)
Message-ID: <c87ecc94d62fb18ff48d4fb12d1c27013612b2c9.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Fix false positive on empty block comment
 lines
From:   Joe Perches <joe@perches.com>
To:     =?UTF-8?Q?=C5=81ukasz?= Stelmach <l.stelmach@samsung.com>,
        Andy Whitcroft <apw@canonical.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?Q?Bart=C5=82omiej_?= =?UTF-8?Q?=C5=BBolnierkiewicz?= 
        <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Date:   Fri, 02 Oct 2020 12:39:11 -0700
In-Reply-To: <20201002191525.18942-1-l.stelmach@samsung.com>
References: <CGME20201002191546eucas1p13545280767220c473c19d1071c87d107@eucas1p1.samsung.com>
         <20201002191525.18942-1-l.stelmach@samsung.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-10-02 at 21:15 +0200, Łukasz Stelmach wrote:
> To avoid false positives in presence of SPDX-License-Identifier in
> networking files it is required to increase the leeway for empty block
> comment lines by one line.

Thanks.

An example in the commit description would be nice.

The intent here is to avoid the below error so the
second line of a networking file can be an initial blank

/*

$ ./scripts/checkpatch.pl -f drivers/net/Space.c
WARNING: networking block comments don't use an empty /* line, use /* Comment...
#3: FILE: drivers/net/Space.c:3:
+/*
+ * INET		An implementation of the TCP/IP protocol suite for the LINUX

total: 0 errors, 1 warnings, 0 checks, 155 lines checked

> Signed-off-by: Łukasz Stelmach <l.stelmach@samsung.com>
> ---
>  scripts/checkpatch.pl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index a213cdb82ab0..60e10da4cccb 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3460,7 +3460,7 @@ sub process {
>  		if ($realfile =~ m@^(drivers/net/|net/)@ &&
>  		    $prevrawline =~ /^\+[ \t]*\/\*[ \t]*$/ &&
>  		    $rawline =~ /^\+[ \t]*\*/ &&
> -		    $realline > 2) {
> +		    $realline > 3) {
>  			WARN("NETWORKING_BLOCK_COMMENT_STYLE",
>  			     "networking block comments don't use an empty /* line, use /* Comment...\n" . $hereprev);
>  		}

Maybe add a comment in the code too:

---
 scripts/checkpatch.pl | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index a213cdb82ab0..632c543b108d 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3457,10 +3457,11 @@ sub process {
 
 # Block comment styles
 # Networking with an initial /*
+# allow an initial blank /* at the top of the file with or without an SPDX line
 		if ($realfile =~ m@^(drivers/net/|net/)@ &&
 		    $prevrawline =~ /^\+[ \t]*\/\*[ \t]*$/ &&
 		    $rawline =~ /^\+[ \t]*\*/ &&
-		    $realline > 2) {
+		    $realline > 3) {
 			WARN("NETWORKING_BLOCK_COMMENT_STYLE",
 			     "networking block comments don't use an empty /* line, use /* Comment...\n" . $hereprev);
 		}


