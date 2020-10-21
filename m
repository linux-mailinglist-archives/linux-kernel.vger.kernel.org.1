Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40D9F294FC1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 17:19:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2444123AbgJUPTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 11:19:00 -0400
Received: from smtprelay0048.hostedemail.com ([216.40.44.48]:45376 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2444103AbgJUPTA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 11:19:00 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 7961A180A7FFA;
        Wed, 21 Oct 2020 15:18:59 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 10,1,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:334:355:368:369:379:599:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2393:2559:2562:2828:3138:3139:3140:3141:3142:3353:3622:3653:3834:3865:3866:3867:3868:3870:3874:4321:4560:5007:7903:8784:10004:10400:10848:11026:11232:11658:11914:12043:12295:12297:12438:12555:12740:12760:12895:12986:13069:13095:13161:13229:13311:13357:13439:13523:13524:14181:14659:14721:21080:21433:21451:21627:21660:30003:30054:30070:30089:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: tail45_2c0cd3027249
X-Filterd-Recvd-Size: 2737
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Wed, 21 Oct 2020 15:18:58 +0000 (UTC)
Message-ID: <f073750511750336de5f82600600ba6cb3ddbec0.camel@perches.com>
Subject: Re: [PATCH] checkpatch: fix false positive for REPEATED_WORD warning
From:   Joe Perches <joe@perches.com>
To:     Aditya Srivastava <yashsri421@gmail.com>
Cc:     linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com,
        linux-kernel-mentees@lists.linuxfoundation.org,
        dwaipayanray1@gmail.com
Date:   Wed, 21 Oct 2020 08:18:57 -0700
In-Reply-To: <20201021150120.29920-1-yashsri421@gmail.com>
References: <20201021150120.29920-1-yashsri421@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-10-21 at 20:31 +0530, Aditya Srivastava wrote:
> Presence of hexadecimal address or symbol results in false warning
> message by checkpatch.pl.
> 
> For example, running checkpatch on commit b8ad540dd4e4 ("mptcp: fix
> memory leak in mptcp_subflow_create_socket()") results in warning:
> 
> WARNING:REPEATED_WORD: Possible repeated word: 'ff'
>     00 00 00 00 00 00 00 00 00 2f 30 0a 81 88 ff ff  ........./0.....

Right.

> To avoid all such reports, add an additional regex check for a repeating
> pattern of 4 or more 2-lettered words separated by space in a line.

> A quick evaluation on v5.6..v5.8 showed that this fix reduces
> REPEATED_WORD warnings from 2797 to 1043.

Are many of the other 1043 false positives?
Any pattern to them?

> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
[]
> @@ -3050,8 +3050,10 @@ sub process {
>  			}
>  		}
>  
> -# check for repeated words separated by a single space
> -		if ($rawline =~ /^\+/ || $in_commit_log) {
> +# check for repeated words separated by a single space and
> +# avoid repeating hex occurrences like 'ff ff fe 09 ...'
> +		if (($rawline =~ /^\+/ || $in_commit_log) &&
> +		$rawline !~ /(\b[0-9a-f]{2}( )+){4,}/) {

This might be better as \b$Hex to avoid FF FF
and FFFFFFFF FFFFFFFF

I might add that check to the line below where
the repeated words are checked against long
---
 scripts/checkpatch.pl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index fab38b493cef..929866999f81 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -3062,6 +3062,7 @@ sub process {
 
 				next if ($first ne $second);
 				next if ($first eq 'long');
+				next if ($first =~ /^$Hex$/;
 
 				if (WARN("REPEATED_WORD",
 					 "Possible repeated word: '$first'\n" . $herecurr) &&


