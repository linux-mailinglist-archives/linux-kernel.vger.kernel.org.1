Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7D4C286914
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 22:30:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728573AbgJGUaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 16:30:19 -0400
Received: from smtprelay0035.hostedemail.com ([216.40.44.35]:60876 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726434AbgJGUaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 16:30:19 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 73EBF837F253;
        Wed,  7 Oct 2020 20:30:17 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:2:41:355:379:599:800:960:967:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1535:1593:1594:1605:1712:1730:1747:1777:1792:2197:2199:2393:2525:2560:2563:2682:2685:2828:2859:2902:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3622:3653:3865:3866:3867:3868:3871:3872:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4051:4120:4250:4321:4362:4605:5007:6119:7514:7576:7903:8825:9025:9165:10004:11026:11232:11473:11658:11914:12043:12219:12291:12296:12297:12438:12555:12683:12740:12760:12895:13439:14659:21063:21080:21221:21433:21451:21627:21811:21819:21939:21987:21990:30003:30022:30029:30030:30054:30070:30074:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: egg60_050b0d7271d2
X-Filterd-Recvd-Size: 9384
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf17.hostedemail.com (Postfix) with ESMTPA;
        Wed,  7 Oct 2020 20:30:16 +0000 (UTC)
Message-ID: <945aa49a6fcaefebbd7c8343661fc1a0d2ece539.camel@perches.com>
Subject: Re: [PATCH v6] checkpatch: add new warnings to author signoff
 checks.
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com
Date:   Wed, 07 Oct 2020 13:30:14 -0700
In-Reply-To: <20201007192029.551744-1-dwaipayanray1@gmail.com>
References: <20201007192029.551744-1-dwaipayanray1@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-10-08 at 00:50 +0530, Dwaipayan Ray wrote:
> The author signed-off-by checks are currently very vague.
> Cases like same name or same address are not handled separately.

Thanks Dwaipayan.

This might have to eventually change case #5 to CHK, but
otherwise this seems sensible and let's see how it goes...

Acked-by: Joe Perches <joe@perches.com>

> For example, running checkpatch on commit be6577af0cef
> ("parisc: Add atomic64_set_release() define to avoid CPU soft lockups"),
> gives:
> 
> WARNING: Missing Signed-off-by: line by nominal patch author
> 'John David Anglin <dave.anglin@bell.net>'
> 
> The signoff line was:
> "Signed-off-by: Dave Anglin <dave.anglin@bell.net>"
> 
> Clearly the author has signed off but with a slightly different version
> of his name. A more appropriate warning would have been to point out
> at the name mismatch instead.
> 
> Previously, the values assumed by $authorsignoff were either 0 or 1
> to indicate whether a proper sign off by author is present.
> Extended the checks to handle four new cases.
> 
> $authorsignoff values now denote the following:
> 
> 0: Missing sign off by patch author.
> 
> 1: Sign off present and identical.
> 
> 2: Addresses and names match, but comments differ.
>    "James Watson(JW) <james@gmail.com>", "James Watson <james@gmail.com>"
> 
> 3: Addresses match, but names are different.
>    "James Watson <james@gmail.com>", "James <james@gmail.com>"
> 
> 4: Names match, but addresses are different.
>    "James Watson <james@watson.com>", "James Watson <james@gmail.com>"
> 
> 5: Names match, addresses excluding subaddress details (RFC 5233) match.
>    "James Watson <james@gmail.com>", "James Watson <james+a@gmail.com>"
> 
> Also introduced a new message type FROM_SIGN_OFF_MISMATCH
> for cases 2, 3, 4 and 5.
> 
> Link: https://lore.kernel.org/linux-kernel-mentees/c1ca28e77e8e3bfa7aadf3efa8ed70f97a9d369c.camel@perches.com/
> Suggested-by: Joe Perches <joe@perches.com>
> Signed-off-by: Dwaipayan Ray <dwaipayanray1@gmail.com>
> ---
>  scripts/checkpatch.pl | 93 +++++++++++++++++++++++++++++++++++--------
>  1 file changed, 77 insertions(+), 16 deletions(-)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 31624bbb342e..124ff9432b51 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -1163,10 +1163,10 @@ sub parse_email {
>  		}
>  	}
>  
> +	$comment = trim($comment);
>  	$name = trim($name);
>  	$name =~ s/^\"|\"$//g;
> -	$name =~ s/(\s*\([^\)]+\))\s*//;
> -	if (defined($1)) {
> +	if ($name =~ s/(\s*\([^\)]+\))\s*//) {
>  		$name_comment = trim($1);
>  	}
>  	$address = trim($address);
> @@ -1181,10 +1181,12 @@ sub parse_email {
>  }
>  
>  sub format_email {
> -	my ($name, $address) = @_;
> +	my ($name, $name_comment, $address, $comment) = @_;
>  
>  	my $formatted_email;
>  
> +	$name_comment = trim($name_comment);
> +	$comment = trim($comment);
>  	$name = trim($name);
>  	$name =~ s/^\"|\"$//g;
>  	$address = trim($address);
> @@ -1197,9 +1199,9 @@ sub format_email {
>  	if ("$name" eq "") {
>  		$formatted_email = "$address";
>  	} else {
> -		$formatted_email = "$name <$address>";
> +		$formatted_email = "$name$name_comment <$address>";
>  	}
> -
> +	$formatted_email .= "$comment";
>  	return $formatted_email;
>  }
>  
> @@ -1207,17 +1209,23 @@ sub reformat_email {
>  	my ($email) = @_;
>  
>  	my ($email_name, $name_comment, $email_address, $comment) = parse_email($email);
> -	return format_email($email_name, $email_address);
> +	return format_email($email_name, $name_comment, $email_address, $comment);
>  }
>  
>  sub same_email_addresses {
> -	my ($email1, $email2) = @_;
> +	my ($email1, $email2, $match_comment) = @_;
>  
>  	my ($email1_name, $name1_comment, $email1_address, $comment1) = parse_email($email1);
>  	my ($email2_name, $name2_comment, $email2_address, $comment2) = parse_email($email2);
>  
> +	if ($match_comment != 1) {
> +		return $email1_name eq $email2_name &&
> +		       $email1_address eq $email2_address;
> +	}
>  	return $email1_name eq $email2_name &&
> -	       $email1_address eq $email2_address;
> +	       $email1_address eq $email2_address &&
> +	       $name1_comment eq $name2_comment &&
> +	       $comment1 eq $comment2;
>  }
>  
>  sub which {
> @@ -2347,6 +2355,7 @@ sub process {
>  	my $signoff = 0;
>  	my $author = '';
>  	my $authorsignoff = 0;
> +	my $author_sob = '';
>  	my $is_patch = 0;
>  	my $is_binding_patch = -1;
>  	my $in_header_lines = $file ? 0 : 1;
> @@ -2674,9 +2683,37 @@ sub process {
>  		if ($line =~ /^\s*signed-off-by:\s*(.*)/i) {
>  			$signoff++;
>  			$in_commit_log = 0;
> -			if ($author ne '') {
> -				if (same_email_addresses($1, $author)) {
> +			if ($author ne ''  && $authorsignoff != 1) {
> +				if (same_email_addresses($1, $author, 1)) {
>  					$authorsignoff = 1;
> +				} else {
> +					my $ctx = $1;
> +					my ($email_name, $email_comment, $email_address, $comment1) = parse_email($ctx);
> +					my ($author_name, $author_comment, $author_address, $comment2) = parse_email($author);
> +
> +					if ($email_address eq $author_address && $email_name eq $author_name) {
> +						$author_sob = $ctx;
> +						$authorsignoff = 2;
> +					} elsif ($email_address eq $author_address) {
> +						$author_sob = $ctx;
> +						$authorsignoff = 3;
> +					} elsif ($email_name eq $author_name) {
> +						$author_sob = $ctx;
> +						$authorsignoff = 4;
> +
> +						my $address1 = $email_address;
> +						my $address2 = $author_address;
> +
> +						if ($address1 =~ /(\S+)\+\S+(\@.*)/) {
> +							$address1 = "$1$2";
> +						}
> +						if ($address2 =~ /(\S+)\+\S+(\@.*)/) {
> +							$address2 = "$1$2";
> +						}
> +						if ($address1 eq $address2) {
> +							$authorsignoff = 5;
> +						}
> +					}
>  				}
>  			}
>  		}
> @@ -2733,7 +2770,7 @@ sub process {
>  			}
>  
>  			my ($email_name, $name_comment, $email_address, $comment) = parse_email($email);
> -			my $suggested_email = format_email(($email_name, $email_address));
> +			my $suggested_email = format_email(($email_name, $name_comment, $email_address, $comment));
>  			if ($suggested_email eq "") {
>  				ERROR("BAD_SIGN_OFF",
>  				      "Unrecognized email address: '$email'\n" . $herecurr);
> @@ -2743,9 +2780,9 @@ sub process {
>  				$dequoted =~ s/" </ </;
>  				# Don't force email to have quotes
>  				# Allow just an angle bracketed address
> -				if (!same_email_addresses($email, $suggested_email)) {
> +				if (!same_email_addresses($email, $suggested_email, 0)) {
>  					WARN("BAD_SIGN_OFF",
> -					     "email address '$email' might be better as '$suggested_email$comment'\n" . $herecurr);
> +					     "email address '$email' might be better as '$suggested_email'\n" . $herecurr);
>  				}
>  			}
>  
> @@ -6891,9 +6928,33 @@ sub process {
>  		if ($signoff == 0) {
>  			ERROR("MISSING_SIGN_OFF",
>  			      "Missing Signed-off-by: line(s)\n");
> -		} elsif (!$authorsignoff) {
> -			WARN("NO_AUTHOR_SIGN_OFF",
> -			     "Missing Signed-off-by: line by nominal patch author '$author'\n");
> +		} elsif ($authorsignoff != 1) {
> +			# authorsignoff values:
> +			# 0 -> missing sign off
> +			# 1 -> sign off identical
> +			# 2 -> names and addresses match, comments mismatch
> +			# 3 -> addresses match, names different
> +			# 4 -> names match, addresses different
> +			# 5 -> names match, addresses excluding subaddress details (refer RFC 5233) match
> +
> +			my $sob_msg = "'From: $author' != 'Signed-off-by: $author_sob'";
> +
> +			if ($authorsignoff == 0) {
> +				ERROR("NO_AUTHOR_SIGN_OFF",
> +				      "Missing Signed-off-by: line by nominal patch author '$author'\n");
> +			} elsif ($authorsignoff == 2) {
> +				CHK("FROM_SIGN_OFF_MISMATCH",
> +				    "From:/Signed-off-by: email comments mismatch: $sob_msg\n");
> +			} elsif ($authorsignoff == 3) {
> +				WARN("FROM_SIGN_OFF_MISMATCH",
> +				     "From:/Signed-off-by: email name mismatch: $sob_msg\n");
> +			} elsif ($authorsignoff == 4) {
> +				WARN("FROM_SIGN_OFF_MISMATCH",
> +				     "From:/Signed-off-by: email address mismatch: $sob_msg\n");
> +			} elsif ($authorsignoff == 5) {
> +				WARN("FROM_SIGN_OFF_MISMATCH",
> +				     "From:/Signed-off-by: email subaddress mismatch: $sob_msg\n");
> +			}
>  		}
>  	}
>  

