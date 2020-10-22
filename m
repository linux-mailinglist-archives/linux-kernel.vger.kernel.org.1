Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CEA3E29625E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Oct 2020 18:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2895862AbgJVQLD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Oct 2020 12:11:03 -0400
Received: from smtprelay0200.hostedemail.com ([216.40.44.200]:32866 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2509975AbgJVQLC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Oct 2020 12:11:02 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id C8C0E180A7FFC;
        Thu, 22 Oct 2020 16:11:01 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:334:355:368:369:379:599:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3354:3622:3653:3865:3866:3867:3868:3870:3871:3872:4321:5007:7903:8957:9010:10004:10400:10848:11026:11232:11658:11914:12043:12297:12740:12760:12895:13069:13095:13311:13357:13439:14181:14659:14721:21080:21433:21451:21627:21660:30003:30012:30054:30070:30089:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: ink14_5a132ed27252
X-Filterd-Recvd-Size: 2675
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Thu, 22 Oct 2020 16:11:00 +0000 (UTC)
Message-ID: <4cbbd8d8b6c4d686f71648af8bc970baa4b0ee9b.camel@perches.com>
Subject: Re: [PATCH v2] checkpatch: fix false positives in REPEATED_WORD
 warning
From:   Joe Perches <joe@perches.com>
To:     Aditya Srivastava <yashsri421@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        lukas.bulwahn@gmail.com, dwaipayanray1@gmail.com
Date:   Thu, 22 Oct 2020 09:10:59 -0700
In-Reply-To: <20201022145021.28211-1-yashsri421@gmail.com>
References: <20201022145021.28211-1-yashsri421@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2020-10-22 at 20:20 +0530, Aditya Srivastava wrote:
> Presence of hexadecimal address or symbol results in false warning
> message by checkpatch.pl.
[]
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -3051,7 +3051,10 @@ sub process {
>  		}
>  
>  # check for repeated words separated by a single space
> -		if ($rawline =~ /^\+/ || $in_commit_log) {
> +# avoid false positive from list command eg, '-rw-r--r-- 1 root root'
> +		if (($rawline =~ /^\+/ || $in_commit_log) &&
> +		$rawline !~ /[bcCdDlMnpPs\?-][rwxsStT-]{9}/) {

Alignment and use \b before and after the regex please.

		if (($rawline =~ /^\+/ || $in_commit_log) &&
		    $rawline !~ /\b[bcCdDlMnpPs\?-][rwxsStT-]{9}\b/) {
> @@ -3065,6 +3068,34 @@ sub process {
>  				next if ($first ne $second);
>  				next if ($first eq 'long');
>  
> +				# avoid repeating hex occurrences like 'ff ff fe 09 ...'
> +				if ($first =~ /\b[0-9a-f]{2,}/) {
> +					# if such sequence occurs more than 4, it is most probably part of some of code
> +					next if ((scalar @hex_seq)>4);
> +					# for hex occurrences which are less than 4
> +					# get first hex word in the line
> +					if ($rawline =~ /\b[0-9a-f]{2,} /) {
> +						my $post_hex_seq = $';
> +
> +						# set suffieciently high default values to avoid ignoring or counting in absence of another
> +						my $non_hex_char_pos = 1000;
> +						my $special_chars_pos = 500;
> +
> +						if ($post_hex_seq =~ /[g-z]+/) {
> +							# first non hex character in post_hex_seq
> +							$non_hex_char_pos = $-[0];
> +						}
> +						if($post_hex_seq =~ /[^a-zA-Z0-9]{2,}/) {
> +							# first occurrence of 2 or more special chars
> +							$special_chars_pos = $-[0];
> +						}

What does all this code actually avoid?


