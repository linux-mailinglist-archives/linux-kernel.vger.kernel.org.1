Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D34D72B3BE7
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Nov 2020 04:44:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgKPDnW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Nov 2020 22:43:22 -0500
Received: from smtprelay0232.hostedemail.com ([216.40.44.232]:36944 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726198AbgKPDnV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Nov 2020 22:43:21 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id C36D118029151;
        Mon, 16 Nov 2020 03:43:20 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2197:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3653:3865:3867:3868:3870:3871:3872:3874:4321:4362:5007:7514:7903:10004:10400:10848:11026:11232:11658:11914:12043:12296:12297:12555:12740:12895:13069:13311:13357:13439:13894:14181:14659:14721:21067:21080:21221:21451:21627:30012:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: leaf99_1a0628d27325
X-Filterd-Recvd-Size: 2128
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Mon, 16 Nov 2020 03:43:19 +0000 (UTC)
Message-ID: <d3d6b68178b4193f04c35863163ce811a1571c0a.camel@perches.com>
Subject: Re: [PATCH] checkpatch: Fix unescaped left brace
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com
Date:   Sun, 15 Nov 2020 19:43:18 -0800
In-Reply-To: <20201115202928.81955-1-dwaipayanray1@gmail.com>
References: <20201115202928.81955-1-dwaipayanray1@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-11-16 at 01:59 +0530, Dwaipayan Ray wrote:
> There is an unescaped left brace in a regex in OPEN_BRACE
> check. This throws a runtime error when checkpatch is run
> with --fix flag and the OPEN_BRACE check is executed.
> 
> Fix it by escaping the left brace.
> 
> Fixes: 8d1824780f2f ("checkpatch: add --fix option for a couple OPEN_BRACE misuses")
> Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>

Thanks Dwaipayan.

Obviously that code path hasn't been tested in awhile.

I think the notice to require an escape for a { was added back in
perl 5.16 or so.

Acked-by: Joe Perches <joe@perches.com>

> ---
>  scripts/checkpatch.pl | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 2749f32dffe9..0da6422cd0fd 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -4505,7 +4505,7 @@ sub process {
>  			    $fix) {
>  				fix_delete_line($fixlinenr, $rawline);
>  				my $fixed_line = $rawline;
> -				$fixed_line =~ /(^..*$Type\s*$Ident\(.*\)\s*){(.*)$/;
> +				$fixed_line =~ /(^..*$Type\s*$Ident\(.*\)\s*)\{(.*)$/;
>  				my $line1 = $1;
>  				my $line2 = $2;
>  				fix_insert_line($fixlinenr, ltrim($line1));


