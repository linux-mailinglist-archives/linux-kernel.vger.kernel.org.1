Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4292EA823
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jan 2021 11:02:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728479AbhAEKCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jan 2021 05:02:34 -0500
Received: from smtprelay0243.hostedemail.com ([216.40.44.243]:37272 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725831AbhAEKCe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jan 2021 05:02:34 -0500
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave03.hostedemail.com (Postfix) with ESMTP id CC36918023EC2
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jan 2021 10:01:52 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id E7081837F24C;
        Tue,  5 Jan 2021 10:01:11 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:967:973:982:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2197:2199:2393:2525:2560:2563:2682:2685:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3352:3622:3653:3865:3866:3867:3868:3870:3871:3872:3874:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:6119:7652:7903:8531:8985:9025:10004:10400:11026:11232:11658:11854:11914:12043:12296:12297:12555:12698:12737:12740:12895:13069:13311:13357:13439:13894:14181:14659:14721:14764:21080:21221:21627:21939:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: salt47_5a0046f274d8
X-Filterd-Recvd-Size: 1873
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Tue,  5 Jan 2021 10:01:10 +0000 (UTC)
Message-ID: <cf102ac77eb1f9e6424f30aef835f6c61dd03407.camel@perches.com>
Subject: Re: [PATCH] checkpatch: fix unescaped left braces
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com
Date:   Tue, 05 Jan 2021 02:01:09 -0800
In-Reply-To: <20210105093507.29297-1-dwaipayanray1@gmail.com>
References: <20210105093507.29297-1-dwaipayanray1@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-01-05 at 15:05 +0530, Dwaipayan Ray wrote:
> Perl 5.22 onwards require that "A literal "{" should now be
> escaped in a pattern".

Not quite correct.

> checkpatch contains several literal "{". Fix such instances
> by preceding them with a backslash.

Not all literal left braces need to be escaped.
https://www.perlmonks.org/?node_id=1191981

> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -2036,7 +2036,7 @@ sub annotate_values {
>  			print "ASSIGN($1)\n" if ($dbg_values > 1);
>  			$type = 'N';
>  
> 
> -		} elsif ($cur =~/^(;|{|})/) {
> +		} elsif ($cur =~ /^(;|\{|\})/) {

Like this one.  And why escape the right brace too?

>  			print "END($1)\n" if ($dbg_values > 1);
>  			$type = 'E';
>  			$av_pend_colon = 'O';
> @@ -3913,7 +3913,7 @@ sub process {
>  			# it there is no point in retrying a statement scan
>  			# until we hit end of it.
>  			my $frag = $stat; $frag =~ s/;+\s*$//;
> -			if ($frag !~ /(?:{|;)/) {
> +			if ($frag !~ /(?:\{|;)/) {

And here.

etc...

