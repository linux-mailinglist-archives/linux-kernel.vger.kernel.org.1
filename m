Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F19692C7273
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 23:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389825AbgK1VuI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 16:50:08 -0500
Received: from smtprelay0170.hostedemail.com ([216.40.44.170]:58136 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732738AbgK1SJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 13:09:00 -0500
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave07.hostedemail.com (Postfix) with ESMTP id 149241801D256
        for <linux-kernel@vger.kernel.org>; Sat, 28 Nov 2020 15:40:36 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 387901800CFE6;
        Sat, 28 Nov 2020 15:40:35 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:2:41:305:355:379:599:800:960:968:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1535:1593:1594:1605:1606:1730:1747:1777:1792:2198:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3622:3653:3865:3866:3867:3868:3870:3871:3874:4117:4321:4605:5007:6119:6120:7514:7901:7903:7974:8957:10004:10848:11026:11232:11473:11658:11914:12043:12296:12297:12438:12740:12895:13255:13439:13894:14659:21080:21212:21324:21433:21451:21627:21660:21990:30012:30029:30034:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: chin74_030df9227391
X-Filterd-Recvd-Size: 6098
Received: from XPS-9350.home (unknown [47.151.128.180])
        (Authenticated sender: joe@perches.com)
        by omf05.hostedemail.com (Postfix) with ESMTPA;
        Sat, 28 Nov 2020 15:40:34 +0000 (UTC)
Message-ID: <2f5c625f5f342042ab55902fe4b808bff8dd297b.camel@perches.com>
Subject: Re: [PATCH v4] checkpatch: add fix and improve warning msg for
 non-standard signature
From:   Joe Perches <joe@perches.com>
To:     Aditya Srivastava <yashsri421@gmail.com>
Cc:     lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org
Date:   Sat, 28 Nov 2020 07:40:33 -0800
In-Reply-To: <20201128130501.23448-1-yashsri421@gmail.com>
References: <20201128130501.23448-1-yashsri421@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-11-28 at 18:35 +0530, Aditya Srivastava wrote:
> Currently checkpatch warns for BAD_SIGN_OFF on non-standard signature
> styles.
> 
> A large number of these warnings occur because of typo mistakes in
> signature tags. An evaluation over v4.13..v5.8 showed that out of 539
> warnings due to non-standard signatures, 87 are due to typo mistakes.
> 
> Following are the standard signature tags which are often incorrectly
> used, along with their individual counts of incorrect use (over
> v4.13..v5.8):
> 
>  Reviewed-by: 42
>  Signed-off-by: 25
>  Reported-by: 6
>  Acked-by: 4
>  Tested-by: 4
>  Suggested-by: 4
> 
> Provide a fix by calculating levenshtein distance for the signature tag
> with all the standard signatures and suggest a fix with a signature, whose
> edit distance is less than or equal to 2 with the misspelled signature.
> 
> Out of the 86 mispelled signatures fixed with this approach, 85 were
> found to be good corrections and 1 was bad correction.
> 
> Following was found to be a bad correction:
>  Tweeted-by (count: 1) => Tested-by
> 
> Signed-off-by: Aditya Srivastava <yashsri421@gmail.com>
> ---
> changes in v2: modify commit message: replace specific example with overall evaluation, minor changes
> 
> changes in v3: summarize commit message
> 
> changes in v4: improve commit message; remove signature suggestions of small length (ie 'cc' and 'to')

Seems OKish but this needs style modifications as there are
several whitespace uses that don't match the typical forms
and perhaps some new function naming could be improved.

> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -506,6 +506,77 @@ our $signature_tags = qr{(?xi:
>  	Cc:
>  )};
>  
> 
> +sub get_min {

probably a poor name choice.  Maybe edit_distance_min

> +	my (@arr) = @_;
> +	my $len = scalar @arr;
> +	if((scalar @arr) < 1) {

space after if

> +		# if underflow, return
> +		return;
> +	}
> +	my $min = $arr[0];
> +	for my $i (0 .. ($len-1)) {
> +		if ($arr[$i] < $min) {
> +			$min = $arr[$i];
> +		}
> +	}
> +	return $min;
> +}
> +
> +sub get_edit_distance {
> +	my ($str1, $str2) = @_;

maybe lc($str) =~ s/-//g; here instead of the code in the caller

> +	my $len1 = length($str1);
> +	my $len2 = length($str2);
> +	# two dimensional array storing minimum edit distance
> +	my @distance;
> +	for my $i (0 .. $len1) {
> +		for my $j (0 .. $len2) {
> +			if ($i == 0) {
> +				$distance[$i][$j] = $j;
> +			}
> +			elsif ($j == 0) {

} elsif {

> +				$distance[$i][$j] = $i;
> +			}
> +			elsif (substr($str1, $i-1, 1) eq substr($str2, $j-1, 1)) {
> +				$distance[$i][$j] = $distance[$i - 1][$j - 1];
> +			}
> +			else {

} else {

> +				my $dist1 = $distance[$i][$j - 1]; #insert distance
> +				my $dist2 = $distance[$i - 1][$j]; # remove
> +				my $dist3 = $distance[$i - 1][$j - 1]; #replace
> +				$distance[$i][$j] = 1 + get_min($dist1, $dist2, $dist3);
> +			}
> +		}
> +	}
> +	return $distance[$len1][$len2];
> +}
> +
> +sub get_standard_signature {

find_standard_signature ?

> +	my ($sign_off) = @_;
> +	$sign_off = lc($sign_off);
> +	$sign_off =~ s/\-//g; # to match with formed hash

why not strip the dashes in get_edit_distance instead
of using this weird dance with dashes here?

> +	my @standard_signature_tags = (
> +		'signed-off-by:', 'co-developed-by:', 'acked-by:', 'tested-by:',
> +		'reviewed-by:', 'reported-by:', 'suggested-by:'
> +	);
> +	# setting default values
> +	my $standard_signature = 'signed-off-by';

why is does this need to be given a value?

> +	my $min_edit_distance = 20;
> +	my $edit_distance;
> +	foreach (@standard_signature_tags) {
> +		my $signature = $_;
> +		$_ =~ s/\-//g;

and this dancing here

> +		$edit_distance = get_edit_distance($sign_off, $_);
> +		if ($edit_distance < $min_edit_distance) {
> +			$min_edit_distance = $edit_distance;
> +			$standard_signature = $signature;
> +		}
> +	}
> +        if($min_edit_distance<=2) {

bad indentation, if (, spaces around test <=

> +		return ucfirst($standard_signature);
> +        }

bad indentation

> +	return "";
> +}
> +
>  our @typeListMisordered = (
>  	qr{char\s+(?:un)?signed},
>  	qr{int\s+(?:(?:un)?signed\s+)?short\s},
> @@ -2773,8 +2844,18 @@ sub process {
>  			my $ucfirst_sign_off = ucfirst(lc($sign_off));
>  
> 
>  			if ($sign_off !~ /$signature_tags/) {
> -				WARN("BAD_SIGN_OFF",
> -				     "Non-standard signature: $sign_off\n" . $herecurr);
> +				my $suggested_signature = get_standard_signature($sign_off);
> +				if ($suggested_signature eq "") {
> +					WARN("BAD_SIGN_OFF",
> +					"Non-standard signature: $sign_off\n" . $herecurr);

bad alignment

> +				}
> +				else {

} else {

> +					if (WARN("BAD_SIGN_OFF",
> +						 "Non-standard signature: $sign_off. Please use '$suggested_signature' instead\n" . $herecurr) &&

"perhaps" rather than "please use" or "likely typo of"

> +					    $fix) {
> +						$fixed[$fixlinenr] =~ s/$sign_off/$suggested_signature/;
> +					}
> +				}
>  			}
>  			if (defined $space_before && $space_before ne "") {
>  				if (WARN("BAD_SIGN_OFF",


