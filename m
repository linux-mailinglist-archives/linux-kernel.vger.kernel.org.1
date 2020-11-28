Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA432C712D
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 22:54:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391480AbgK1Vyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 16:54:37 -0500
Received: from smtprelay0114.hostedemail.com ([216.40.44.114]:38122 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387479AbgK1TNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 14:13:43 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id B4C1B100E7B48;
        Sat, 28 Nov 2020 19:13:01 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:305:355:379:599:960:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3354:3622:3653:3865:3866:3867:3868:3870:3871:3872:4321:4605:5007:6120:7875:7901:7903:10004:10400:10848:11026:11232:11473:11658:11914:12043:12297:12438:12740:12895:13161:13229:13255:13439:13894:14181:14659:14721:21080:21212:21324:21451:21627:21660:21990:30012:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:22,LUA_SUMMARY:none
X-HE-Tag: food23_5907ea127393
X-Filterd-Recvd-Size: 3656
Received: from XPS-9350.home (unknown [47.151.128.180])
        (Authenticated sender: joe@perches.com)
        by omf13.hostedemail.com (Postfix) with ESMTPA;
        Sat, 28 Nov 2020 19:13:00 +0000 (UTC)
Message-ID: <c2087e41b85c3d45f1d224373b36ecff88d80298.camel@perches.com>
Subject: Re: [PATCH v5] checkpatch: add fix and improve warning msg for
 non-standard signature
From:   Joe Perches <joe@perches.com>
To:     Aditya Srivastava <yashsri421@gmail.com>
Cc:     lukas.bulwahn@gmail.com, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Date:   Sat, 28 Nov 2020 11:12:59 -0800
In-Reply-To: <20201128183508.1195-1-yashsri421@gmail.com>
References: <2f5c625f5f342042ab55902fe4b808bff8dd297b.camel@perches.com>
         <20201128183508.1195-1-yashsri421@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-11-29 at 00:05 +0530, Aditya Srivastava wrote:
> Currently checkpatch warns for BAD_SIGN_OFF on non-standard signature
> styles.

Seems OK, but here are some last trivial notes:

> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> +sub find_standard_signature {
> +	my ($sign_off) = @_;
> +	my @standard_signature_tags = (
> +		'signed-off-by:', 'co-developed-by:', 'acked-by:', 'tested-by:',
> +		'reviewed-by:', 'reported-by:', 'suggested-by:'

I would change this to the normal signatures:

	my @standard_signature_tags = (
		'Signed-off-by:', 'Co-developed-by:', 'Acked-by:', 'Tested-by:',
		'Reviewed-by:', 'Reported-by:', 'Suggested-by:'

> +	);
> +	my $standard_signature;
> +	my $min_edit_distance = 20; # setting default value

20 seems arbitrary, maybe (~0 << 1) ?

> +	my $edit_distance;

move this into the foreach (or maybe not use this at all)

> +	foreach (@standard_signature_tags) {

foreach style in this code uses foreach my $<something> and not $_

	foreach my $standard (@standard_signature_tags) {

> +		$edit_distance = get_edit_distance($sign_off, $_);

So:

		my $edit_distance = get_edit_distance($sign_off, $standard);

> +		if ($edit_distance < $min_edit_distance) {
> +			$min_edit_distance = $edit_distance;
> +			$standard_signature = $_;
> +		}
> +	}
> +        if ($min_edit_distance <= 2) {
> +		return ucfirst($standard_signature);

	return $standard;

Though maybe it's simpler to test in the loop if it's <= 2 as
the lowercase and dash strip is done inside get_edit_distance
so this seems rather simpler:

	foreach my $standard (@standard_signature_tags) {
		return $standard if (get_edit_distance($sign_off, $standard) <= 2);
	}

	return "";

> @@ -2773,8 +2839,17 @@ sub process {
>  			my $ucfirst_sign_off = ucfirst(lc($sign_off));
>  
> 
>  			if ($sign_off !~ /$signature_tags/) {
> -				WARN("BAD_SIGN_OFF",
> -				     "Non-standard signature: $sign_off\n" . $herecurr);
> +				my $suggested_signature = find_standard_signature($sign_off);
> +				if ($suggested_signature eq "") {
> +					WARN("BAD_SIGN_OFF",
> +					     "Non-standard signature: $sign_off\n" . $herecurr);
> +				} else {
> +					if (WARN("BAD_SIGN_OFF",
> +						 "Non-standard signature: $sign_off. Perhaps '$suggested_signature'\n" . $herecurr) &&

Please use consistent '' or nothing around signatures:

						"Non-standard signature: '$sign_off' - likely typo of '$suggested_signature'\n" . $herecurr) &&

> +					    $fix) {
> +						$fixed[$fixlinenr] =~ s/$sign_off/$suggested_signature/;
> +					}
> +				}
>  			}
>  			if (defined $space_before && $space_before ne "") {
>  				if (WARN("BAD_SIGN_OFF",


