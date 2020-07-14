Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEA4321EED4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jul 2020 13:14:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgGNLOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jul 2020 07:14:41 -0400
Received: from smtprelay0192.hostedemail.com ([216.40.44.192]:57282 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726041AbgGNLOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 07:14:40 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 7DE5D100E7B43;
        Tue, 14 Jul 2020 11:14:39 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 64,4,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1434:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2332:2393:2559:2562:2693:2828:3138:3139:3140:3141:3142:3352:3622:3653:3865:3870:3872:4321:4362:5007:7576:7903:10004:10400:10848:11232:11658:11914:12043:12297:12555:12740:12760:12895:12986:13069:13311:13357:13439:14181:14659:14721:21063:21080:21451:21627:30054:30064:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: mom61_3f0063526ef0
X-Filterd-Recvd-Size: 1811
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Tue, 14 Jul 2020 11:14:38 +0000 (UTC)
Message-ID: <cd892c33922c477622ede83d80592e71098c4dc2.camel@perches.com>
Subject: Re: [PATCH] checkpatch.pl: Allow '+' in compatible strings
From:   Joe Perches <joe@perches.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Andy Whitcroft <apw@canonical.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Date:   Tue, 14 Jul 2020 04:14:36 -0700
In-Reply-To: <20200714094141.147418-1-thierry.reding@gmail.com>
References: <20200714094141.147418-1-thierry.reding@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-07-14 at 11:41 +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> The current checks will interpret a '+' character as special because
> they use regular expression matching. Escape the '+' character if it
> appears in a compatible string.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>

Thanks

> ---
>  scripts/checkpatch.pl | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 4c820607540b..8104d0736e7f 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -3145,6 +3145,7 @@ sub process {
>  			my $vp_file = $dt_path . "vendor-prefixes.yaml";
>  
>  			foreach my $compat (@compats) {
> +				$compat =~ s/\+/\\+/;

This changes the @compats array for each line
>  				my $compat2 = $compat;
>  				$compat2 =~ s/\,[a-zA-Z0-9]*\-/\,<\.\*>\-/;
>  				my $compat3 = $compat;

