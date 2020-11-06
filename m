Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A5F2E2A9FB7
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 23:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728771AbgKFWED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 17:04:03 -0500
Received: from smtprelay0179.hostedemail.com ([216.40.44.179]:43034 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728365AbgKFWEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 17:04:02 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id A7E1B182CF666;
        Fri,  6 Nov 2020 22:04:01 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 90,9,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1542:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3653:3865:3866:3867:3868:3870:3872:3873:4321:4823:5007:7903:10004:10400:10848:11026:11473:11658:11914:12043:12297:12438:12740:12895:13095:13161:13229:13439:13891:13894:14181:14659:14721:21080:21433:21451:21627:21660:21740:21741:21819:30022:30029:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: town76_4b09d98272d6
X-Filterd-Recvd-Size: 3214
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf11.hostedemail.com (Postfix) with ESMTPA;
        Fri,  6 Nov 2020 22:04:00 +0000 (UTC)
Message-ID: <38c2889ad15c0f34ce8c223518f1f6dbc9945286.camel@perches.com>
Subject: Re: [PATCH v4] checkpatch: improve email parsing
From:   Joe Perches <joe@perches.com>
To:     Dwaipayan Ray <dwaipayanray1@gmail.com>
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com,
        yashsri421@gmail.com
Date:   Fri, 06 Nov 2020 14:03:59 -0800
In-Reply-To: <20201106214530.367247-1-dwaipayanray1@gmail.com>
References: <20201106214530.367247-1-dwaipayanray1@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-11-07 at 03:15 +0530, Dwaipayan Ray wrote:
> checkpatch doesn't report warnings for many common mistakes
> in emails. Some of which are trailing commas and incorrect
> use of email comments.

Assuming it all works, this looks good.  I haven't tested it.

How did you test the $fix bits?

Trivial notes:

> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> +				# stable@vger.kernel.org or stable@kernel.org shouldn't
> +				# have an email name. In addition commments should strictly
> +				# begin with a #
> +				if ($email =~ /^.*stable\@(?:vger\.)?kernel\.org/) {

Likely better to test with a case insensitive match so
STABLE@vger.kernel.org and such are still warned.

				if ($email =~ /\bstable\@(?:vger\.)?kernel\.org\b/i) {

> +					if ($sign_off =~ /cc:$/i && (($comment ne "" && $comment !~ /^#.+/) ||
> +					    ($email_name ne ""))) {

|| $sign_off !~ /^cc:/i ?

> +						my $cur_name = $email_name;
> +						my $new_comment = $comment;
> +
> +						$cur_name =~ s/[a-zA-Z\s\-\"]+//g;
> +						$new_comment =~ s/^[\s\#\(\[]+|[\s\)\]]+$//g;
> +						$new_comment = trim("$new_comment $cur_name") if $cur_name ne $new_comment;
> +						$new_comment = " # $new_comment" if length($new_comment) > 0;
> +						my $new_email = "$email_address$new_comment";
> +
> +						if (WARN("BAD_SIGN_OFF",
> +						    "Invalid email format for stable: '$email', prefer '$new_email'\n" . $herecurr) &&

These message lines should be aligned to the next open parenthesis
(7 tabs, 1 space)

> +						    $fix) {
> +							$fixed[$fixlinenr] =~ s/\Q$email\E/$new_email/;
> +						}

As a cc to stable isn't a sign-off, perhaps this should be a different
"BAD_<FOO>" like "BAD_STABLE_ADDRESS_STYLE" or such.

> +					}
> +				} else {

elsif ?

> +					if ($comment ne "" && $comment !~ /^(?:#.+|\(.+\))$/) {
> +						if (WARN("BAD_SIGN_OFF",
> +						    "Unexpected content after email: '$email'\n" . $herecurr) &&

7 tabs, 1 space

> +						    $fix) {
> +							my $new_comment = $comment;
> +							$new_comment =~ s/^(?:\/\*|\.|\,)//g;
> +							$new_comment =~ s/^[\s\{\[]+|[\s\}\]]+$//g;
> +							$new_comment = " ($new_comment)" if length($new_comment) > 0;
> +							$fixed[$fixlinenr] =~ s/\s*\Q$comment\E$/$new_comment/;
> +						}
> +					}
>  				}
>  			}
>  
> 


