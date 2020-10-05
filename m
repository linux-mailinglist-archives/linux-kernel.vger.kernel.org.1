Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1FA32830C2
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 09:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725935AbgJEHSV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 03:18:21 -0400
Received: from smtprelay0023.hostedemail.com ([216.40.44.23]:58888 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725873AbgJEHSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 03:18:20 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay05.hostedemail.com (Postfix) with ESMTP id 70A4F18029210;
        Mon,  5 Oct 2020 07:18:19 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1543:1593:1594:1605:1711:1730:1747:1777:1792:2197:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3622:3653:3865:3866:3867:3868:3871:3872:3874:4250:4321:4605:5007:6119:7514:7903:10004:10400:10848:11026:11232:11473:11658:11914:12297:12438:12740:12760:12895:13095:13439:14181:14659:14721:21063:21080:21221:21433:21451:21627:21819:21987:30003:30026:30029:30030:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:3,LUA_SUMMARY:none
X-HE-Tag: worm55_1211179271bc
X-Filterd-Recvd-Size: 4609
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf15.hostedemail.com (Postfix) with ESMTPA;
        Mon,  5 Oct 2020 07:18:18 +0000 (UTC)
Message-ID: <a5cba9bb723626091f8790c794efe8de4ab184b8.camel@perches.com>
Subject: Re: [PATCH RFC] checkpatch: add new warnings to author signoff
 checks.
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        lukas.bulwahn@gmail.com, linux-kernel@vger.kernel.org
Date:   Mon, 05 Oct 2020 00:18:17 -0700
In-Reply-To: <20201005064842.33495-1-dwaipayanray1@gmail.com>
References: <20201005064842.33495-1-dwaipayanray1@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-10-05 at 12:18 +0530, Dwaipayan Ray wrote:
> The author signed-off-by checks are currently very vague.
> Cases like same name or same address are not handled separately.
> 
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
> Introduced three new types of warnings:
> 
> 1) Address matches, but names are different.
>    "James Watson <james@gmail.com>", "James <james@gmail.com>"
> 
> 2) Name matches, but addresses are different.
>    "James Watson <james@watson.com>", "James Watson <james@gmail.com>"
> 
> 3) Name matches, but addresses without mail extensions are same.
>    "James Watson <james@gmail.com>", "James Watson <james+a@gmail.com>"
> 
> For the 3rd class, a --strict check message is generated, and for the
> other two, warnings are generated.

I don't have any issue with the concept, but please
be consistent with spacing after if tests.

Always use a single space after if

> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl

> @@ -2347,6 +2347,7 @@ sub process {
>  	my $signoff = 0;
>  	my $author = '';
>  	my $authorsignoff = 0;
> +	my $authorsignoff_ctx = '';

ctx isn't a descriptive name.

Maybe $author_sob

> @@ -2674,9 +2675,34 @@ sub process {
>  		if ($line =~ /^\s*signed-off-by:\s*(.*)/i) {
>  			$signoff++;
>  			$in_commit_log = 0;
> -			if ($author ne '') {
> +			if ($author ne ''  && $authorsignoff != 1) {

Has space after if

>  				if (same_email_addresses($1, $author)) {
>  					$authorsignoff = 1;
> +				} else {
> +					my $ctx = $1;
> +					my ($email_name, $email_comment, $email_address, $comment1) = parse_email($ctx);
> +					my ($author_name, $author_comment, $author_address, $comment2) = parse_email($author);
> +
> +					if($email_address eq $author_address) {

No space after if, etc...

> @@ -6891,9 +6917,32 @@ sub process {
>  		if ($signoff == 0) {
>  			ERROR("MISSING_SIGN_OFF",
>  			      "Missing Signed-off-by: line(s)\n");
> -		} elsif (!$authorsignoff) {
> -			WARN("NO_AUTHOR_SIGN_OFF",
> -			     "Missing Signed-off-by: line by nominal patch author '$author'\n");
> +		} elsif ($authorsignoff != 1) {
> +			# authorsignoff values:
> +			# 0 -> missing sign off
> +			# 1 -> sign off present

sign off identical

> +			# 2 -> address matches, name different
> +			# 3 -> name matches, address different
> +			# 4 -> name matches, address matches without extension

extension here isn't obvious

> +
> +			my $ctx_msg = "'Signed-off-by: $authorsignoff_ctx' should be:\n'Signed-off-by: $author'";

New line not necessary or useful really.

And for mismatches, it's really not known that
it should be one way or the or the other is it?

> +
> +			if($authorsignoff == 0) {
> +				WARN("NO_AUTHOR_SIGN_OFF",
> +					"Missing Signed-off-by: line by nominal patch author '$author'\n");
> +			}
> +			elsif($authorsignoff == 2) {
> +				WARN("NO_AUTHOR_SIGN_OFF",
> +					"Author name mismatch:\n$ctx_msg\n");
> +			}
> +			elsif($authorsignoff == 3) {
> +				WARN("NO_AUTHOR_SIGN_OFF",
> +					"Author address mismatch:\n$ctx_msg\n");
> +			}
> +			elsif($authorsignoff == 4) {
> +				CHK("NO_AUTHOR_SIGN_OFF",
> +					"Author mail extension mismatch:\n$ctx_msg\n");
> +			}
>  		}
>  	}
>  

