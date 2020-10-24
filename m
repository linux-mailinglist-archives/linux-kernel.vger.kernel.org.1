Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0FB0297A32
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Oct 2020 03:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758561AbgJXBhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Oct 2020 21:37:05 -0400
Received: from smtprelay0113.hostedemail.com ([216.40.44.113]:41140 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1758540AbgJXBhF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Oct 2020 21:37:05 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 6B111181D3039;
        Sat, 24 Oct 2020 01:37:19 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:334:355:368:369:379:599:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1543:1593:1594:1605:1711:1730:1747:1777:1792:1801:2198:2199:2393:2553:2559:2562:2828:3138:3139:3140:3141:3142:3622:3834:3865:3866:3867:3868:3870:3871:3872:3873:3874:4321:4560:4605:4823:5007:7903:8957:9010:10004:10400:10848:11026:11232:11658:11783:11914:12043:12297:12438:12740:12895:13095:13439:13894:14181:14659:14721:21080:21324:21433:21451:21627:21660:30003:30012:30054:30070:30089:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: stove76_3d02c7c2725e
X-Filterd-Recvd-Size: 4265
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Sat, 24 Oct 2020 01:37:18 +0000 (UTC)
Message-ID: <5bc34c6faf989f528c92f5e631607f1774f08d20.camel@perches.com>
Subject: Re: [PATCH v4] checkpatch: fix false positives in REPEATED_WORD
 warning
From:   Joe Perches <joe@perches.com>
To:     Aditya Srivastava <yashsri421@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        lukas.bulwahn@gmail.com, dwaipayanray1@gmail.com
Date:   Fri, 23 Oct 2020 18:37:16 -0700
In-Reply-To: <20201024000830.12871-1-yashsri421@gmail.com>
References: <20201024000830.12871-1-yashsri421@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2020-10-24 at 05:38 +0530, Aditya Srivastava wrote:
> Presence of hexadecimal address or symbol results in false warning
> message by checkpatch.pl.
> 
> For example, running checkpatch on commit b8ad540dd4e4 ("mptcp: fix
> memory leak in mptcp_subflow_create_socket()") results in warning:
> 
> WARNING:REPEATED_WORD: Possible repeated word: 'ff'
>     00 00 00 00 00 00 00 00 00 2f 30 0a 81 88 ff ff  ........./0.....
> 
> Similarly, the presence of list command output in commit results in
> an unnecessary warning.
> 
> For example, running checkpatch on commit 899e5ffbf246 ("perf record:
> Introduce --switch-output-event") gives:
> 
> WARNING:REPEATED_WORD: Possible repeated word: 'root'
>   dr-xr-x---. 12 root root    4096 Apr 27 17:46 ..
> 
> Here, it reports 'ff' and 'root to be repeated, but it is in fact part

'root'

> of some address or code, where it has to be repeated.
> 
> In these cases, the intent of the warning to find stylistic issues in
> commit messages is not met and the warning is just completely wrong in
> this case.
> 
> To avoid these warnings, add additional regex check for the

add an

> directory permission pattern and avoid checking the line for this
> class of warning. Similarly, to avoid hex pattern, check if the word
> consists of hex symbols and skip this warning if it is not among the
> common english words formed using hex letters.
> 
> A quick evaluation on v5.6..v5.8 showed that this fix reduces
> REPEATED_WORD warnings from 2797 to 907.

How many of these 907 remaining are still false positive?
 
> A quick manual check found all cases are related to hex output or
> list command outputs in commit messages.

You mean 1890 of the 2797 are now no longer reported and all 1890
were false positives yes?

> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -3049,7 +3049,9 @@ sub process {
>  		}
>  
> 
>  # check for repeated words separated by a single space
> -		if ($rawline =~ /^\+/ || $in_commit_log) {
> +# avoid false positive from list command eg, '-rw-r--r-- 1 root root'
> +		if (($rawline =~ /^\+/ || $in_commit_log) &&
> +                    $rawline !~ /[bcCdDlMnpPs\?-][rwxsStT-]{9}/) {

Use maximal tab indentation and spaces to align please.
2 tabs, 4 spaces

>  			pos($rawline) = 1 if (!$in_commit_log);
>  			while ($rawline =~ /\b($word_pattern) (?=($word_pattern))/g) {
>  
> 
> @@ -3074,6 +3076,17 @@ sub process {
>  				next if ($start_char =~ /^\S$/);
>  				next if (index(" \t.,;?!", $end_char) == -1);
>  
> 
> +                                # avoid repeating hex occurrences like 'ff ff fe 09 ...'
> +                                my %allow_repeated_words = (
> +                                        add => '',
> +                                        added => '',
> +                                        bad => '',
> +                                        be => '',
> +                                );

If perl caches this local hash declaration, fine,
but I think it better to use 'our %allow_repeated_words'
and move it so it's only declared using the file scope.

> +                                if ($first =~ /\b[0-9a-f]{2,}\b/) {

This regex matches only lower case so it wouldn't match "Add".

I think this regex would be clearer using
	/^[0-9a-f]+$/i or /^[A-Fa-f0-9]+$/


