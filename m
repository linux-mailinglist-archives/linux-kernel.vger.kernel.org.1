Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E62FE2B83AA
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 19:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726181AbgKRSOz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 13:14:55 -0500
Received: from smtprelay0161.hostedemail.com ([216.40.44.161]:54512 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725947AbgKRSOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 13:14:55 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 4E8C28384364;
        Wed, 18 Nov 2020 18:14:54 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:960:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2197:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3653:3865:3866:3870:3873:3874:4321:4605:5007:6119:10004:10400:10848:11026:11232:11658:11914:12043:12297:12740:12895:13069:13311:13357:13439:13894:14181:14659:14721:21080:21221:21433:21627:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: brick87_4d0cbfa2733c
X-Filterd-Recvd-Size: 2134
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Wed, 18 Nov 2020 18:14:53 +0000 (UTC)
Message-ID: <457730448c84136be089748bea69abd2254e3832.camel@perches.com>
Subject: Re: [PATCH] checkpatch: add --fix option for OPEN_BRACE issues
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com
Date:   Wed, 18 Nov 2020 10:14:52 -0800
In-Reply-To: <20201118124035.96976-1-dwaipayanray1@gmail.com>
References: <20201118124035.96976-1-dwaipayanray1@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-11-18 at 18:10 +0530, Dwaipayan Ray wrote:
> Brace style misuses of the following types are now
> corrected:
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -3937,9 +3937,23 @@ sub process {
>  			#print "pre<$pre_ctx>\nline<$line>\nctx<$ctx>\nnext<$lines[$ctx_ln - 1]>\n";
>  
> 
>  			if ($ctx !~ /{\s*/ && defined($lines[$ctx_ln - 1]) && $lines[$ctx_ln - 1] =~ /^\+\s*{/) {
> -				ERROR("OPEN_BRACE",
> -				      "that open brace { should be on the previous line\n" .
> -					"$here\n$ctx\n$rawlines[$ctx_ln - 1]\n");
> +				if (ERROR("OPEN_BRACE",
> +					  "that open brace { should be on the previous line\n" .
> +						"$here\n$ctx\n$rawlines[$ctx_ln - 1]\n") &&
> +				    $fix) {
> +					my $line1 = $rawlines[$ctx_ln - 2];

How are you sure that in a patch context this line always starts with /^\+/ ?

> +					my $line2 = $rawlines[$ctx_ln - 1];
> +					fix_delete_line($ctx_ln - 2, $line1);
> +					fix_delete_line($ctx_ln - 1, $line2);
> +
> +					my $fixedline = rtrim($line1) . " {";
> +					fix_insert_line($ctx_ln - 1, $fixedline);
> +					$fixedline = $line2;
> +					$fixedline =~ s/^(.\s*)\{\s*/$1\t/;
> +					if ($fixedline !~ /^\+\s*$/) {
> +						fix_insert_line($ctx_ln - 1, $fixedline);
> +					}
> +				}


