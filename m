Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E78D11CB72E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 May 2020 20:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727774AbgEHS2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 May 2020 14:28:41 -0400
Received: from smtprelay0104.hostedemail.com ([216.40.44.104]:39776 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726636AbgEHS2k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 14:28:40 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id E07FA837F253;
        Fri,  8 May 2020 18:28:39 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2197:2199:2393:2559:2562:2828:3138:3139:3140:3141:3142:3352:3622:3653:3865:3866:3867:3871:4321:4605:5007:7903:9545:10004:10400:10848:11232:11658:11914:11984:12043:12048:12109:12114:12297:12555:12679:12740:12760:12895:13069:13255:13311:13357:13439:14180:14181:14659:14721:21080:21221:21451:21627:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:3,LUA_SUMMARY:none
X-HE-Tag: cake24_4b84b1fd02a33
X-Filterd-Recvd-Size: 1924
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Fri,  8 May 2020 18:28:38 +0000 (UTC)
Message-ID: <c9d89bb24c7414142414c60371e210fdcf4617d2.camel@perches.com>
Subject: Re: + checkpatch-use-patch-subject-when-reading-from-stdin.patch
 added to -mm tree
From:   Joe Perches <joe@perches.com>
To:     akpm@linux-foundation.org, geert+renesas@glider.be,
        konstantin@linuxfoundation.org,
        Pali =?ISO-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Date:   Fri, 08 May 2020 11:28:37 -0700
In-Reply-To: <20200505191846.eUGRUOXlc%akpm@linux-foundation.org>
References: <20200505191846.eUGRUOXlc%akpm@linux-foundation.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2020-05-05 at 12:18 -0700, akpm@linux-foundation.org wrote:
> The patch titled
>      Subject: checkpatch: use patch subject when reading from stdin
> has been added to the -mm tree.  Its filename is
>      checkpatch-use-patch-subject-when-reading-from-stdin.patch

Hey Andrew:

Please apply this patch on top of Geert's first one to reduce cpu usage.

For the original patch:

Acked-by: Joe Perches <joe@perches.com>
---
 scripts/checkpatch.pl | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index e5b6b9aa21d6..8223342e9b69 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1061,11 +1061,8 @@ for my $filename (@ARGV) {
 	}
 	while (<$FILE>) {
 		chomp;
-		if ($vname eq 'Your patch') {
-			my ($subject) = $_ =~ /^Subject:\s*(.*)/;
-			$vname = '"' . $subject . '"' if $subject;
-		}
 		push(@rawlines, $_);
+		$vname = qq("$1") if ($filename eq '-' && $_ =~ m/^Subject:\s+(.+)/i);
 	}
 	close($FILE);
 

