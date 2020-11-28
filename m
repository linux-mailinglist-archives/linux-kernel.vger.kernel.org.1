Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37F302C714F
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 22:56:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391590AbgK1V4W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 16:56:22 -0500
Received: from smtprelay0210.hostedemail.com ([216.40.44.210]:53708 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387750AbgK1U62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 15:58:28 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 715D6837F24F;
        Sat, 28 Nov 2020 20:58:00 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:968:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1535:1544:1593:1594:1605:1711:1730:1747:1777:1792:2198:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3622:3653:3865:3866:3867:3868:3870:3871:3874:4321:4362:5007:6120:7514:7875:7901:7903:8957:10004:10848:11026:11232:11473:11658:11914:12043:12291:12297:12438:12555:12683:12740:12895:12986:13095:13255:13439:13894:14181:14659:14721:21080:21212:21324:21433:21451:21611:21627:21660:21990:30030:30034:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: wax38_2617ef727393
X-Filterd-Recvd-Size: 5612
Received: from XPS-9350.home (unknown [47.151.128.180])
        (Authenticated sender: joe@perches.com)
        by omf04.hostedemail.com (Postfix) with ESMTPA;
        Sat, 28 Nov 2020 20:57:59 +0000 (UTC)
Message-ID: <db1195235752685fc85fb52ecb1b1af3f35b5394.camel@perches.com>
Subject: Re: [PATCH v6] checkpatch: add fix and improve warning msg for
 non-standard signature
From:   Joe Perches <joe@perches.com>
To:     Aditya Srivastava <yashsri421@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     lukas.bulwahn@gmail.com, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Date:   Sat, 28 Nov 2020 12:57:58 -0800
In-Reply-To: <20201128204333.7054-1-yashsri421@gmail.com>
References: <c2087e41b85c3d45f1d224373b36ecff88d80298.camel@perches.com>
         <20201128204333.7054-1-yashsri421@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2020-11-29 at 02:13 +0530, Aditya Srivastava wrote:
> Currently checkpatch warns for BAD_SIGN_OFF on non-standard signature
> styles.

Thanks.

Acked-by: Joe Perches <joe@perches.com>

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
> applies on next-20201120
> 
> changes in v2: modify commit message: replace specific example with overall evaluation, minor changes
> 
> changes in v3: summarize commit message
> 
> changes in v4: improve commit message; remove signature suggestions of small length (ie 'cc' and 'to')
> 
> changes in v5: modify coding styles: improve function names, whitespaces
> 
> changes in v6: Simplify foreach loop; change standard signature tag values to normal ucfirst; modify warning message
> 
>  scripts/checkpatch.pl | 71 +++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 69 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index fdfd5ec09be6..4a026926139f 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -506,6 +506,64 @@ our $signature_tags = qr{(?xi:
>  	Cc:
>  )};
>  
> 
> +sub edit_distance_min {
> +	my (@arr) = @_;
> +	my $len = scalar @arr;
> +	if ((scalar @arr) < 1) {
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
> +	$str1 = lc($str1);
> +	$str2 = lc($str2);
> +	$str1 =~ s/-//g;
> +	$str2 =~ s/-//g;
> +	my $len1 = length($str1);
> +	my $len2 = length($str2);
> +	# two dimensional array storing minimum edit distance
> +	my @distance;
> +	for my $i (0 .. $len1) {
> +		for my $j (0 .. $len2) {
> +			if ($i == 0) {
> +				$distance[$i][$j] = $j;
> +			} elsif ($j == 0) {
> +				$distance[$i][$j] = $i;
> +			} elsif (substr($str1, $i-1, 1) eq substr($str2, $j-1, 1)) {
> +				$distance[$i][$j] = $distance[$i - 1][$j - 1];
> +			} else {
> +				my $dist1 = $distance[$i][$j - 1]; #insert distance
> +				my $dist2 = $distance[$i - 1][$j]; # remove
> +				my $dist3 = $distance[$i - 1][$j - 1]; #replace
> +				$distance[$i][$j] = 1 + edit_distance_min($dist1, $dist2, $dist3);
> +			}
> +		}
> +	}
> +	return $distance[$len1][$len2];
> +}
> +
> +sub find_standard_signature {
> +	my ($sign_off) = @_;
> +	my @standard_signature_tags = (
> +		'Signed-off-by:', 'Co-developed-by:', 'Acked-by:', 'Tested-by:',
> +		'Reviewed-by:', 'Reported-by:', 'Suggested-by:'
> +	);
> +	foreach my $signature (@standard_signature_tags) {
> +		return $signature if (get_edit_distance($sign_off, $signature) <= 2);
> +	}
> +
> +	return "";
> +}
> +
>  our @typeListMisordered = (
>  	qr{char\s+(?:un)?signed},
>  	qr{int\s+(?:(?:un)?signed\s+)?short\s},
> @@ -2773,8 +2831,17 @@ sub process {
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
> +						 "Non-standard signature: '$sign_off' - perhaps '$suggested_signature'?\n" . $herecurr) &&
> +					    $fix) {
> +						$fixed[$fixlinenr] =~ s/$sign_off/$suggested_signature/;
> +					}
> +				}
>  			}
>  			if (defined $space_before && $space_before ne "") {
>  				if (WARN("BAD_SIGN_OFF",


