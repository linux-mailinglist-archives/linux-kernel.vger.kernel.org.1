Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BECD21A4ADB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Apr 2020 21:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgDJTzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Apr 2020 15:55:04 -0400
Received: from smtprelay0177.hostedemail.com ([216.40.44.177]:34314 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726203AbgDJTzD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 15:55:03 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 09712182CCCD1;
        Fri, 10 Apr 2020 19:55:03 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 93,11,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:960:973:982:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2197:2198:2199:2200:2393:2559:2562:2689:2692:2828:3138:3139:3140:3141:3142:3354:3622:3653:3865:3866:3867:3868:3870:3871:3872:3873:3874:4250:4321:4605:5007:6119:7903:8957:10004:10400:10848:11232:11658:11914:12043:12050:12297:12555:12663:12740:12895:13069:13311:13357:13439:13894:14181:14659:14721:21080:21212:21221:21324:21505:21611:21627:21660:21740:21741:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: rest74_490bbefb0e62d
X-Filterd-Recvd-Size: 3039
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf12.hostedemail.com (Postfix) with ESMTPA;
        Fri, 10 Apr 2020 19:55:01 +0000 (UTC)
Message-ID: <db2730700ab3eb7008413a1e7bba94ca7c49a031.camel@perches.com>
Subject: Re: [PATCH] checkpatch: check for missing \n at the end of logging
 message
From:   Joe Perches <joe@perches.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        apw@canonical.com, Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Date:   Fri, 10 Apr 2020 12:53:00 -0700
In-Reply-To: <c9fd4bc75812fed4799c2fb87b452b809a7e9a7a.camel@perches.com>
References: <20200407204908.10420-1-christophe.jaillet@wanadoo.fr>
         <8617a6b94c0644bce1fd4ca77309d67a612e6300.camel@perches.com>
         <6e52383e-100d-b016-32c2-6fb54938b6fe@wanadoo.fr>
         <c9fd4bc75812fed4799c2fb87b452b809a7e9a7a.camel@perches.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.34.1-2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2020-04-10 at 12:46 -0700, Joe Perches wrote:
> On Fri, 2020-04-10 at 19:35 +0200, Christophe JAILLET wrote:
> > Le 08/04/2020 à 04:14, Joe Perches a écrit :
> > > This works rather better:
> > > Perhaps you could test?
> []
> > I'm looking at some modification done in the last month that could have 
> > been spotted by the above script.
> > 
> >      ./scripts/checkpatch.pl -f drivers/usb/phy/phy-jz4770.c
> > 
> > correctly spots the 3 first cases, but the 3 last (line 202, 210 and 
> > 217) are missed.
> > I don't understand why.
> 
> It has to do with checkpatch's single statement parsing.
> 
> This case:
> 
> 	if (foo)
> 		dev_warn(...);
> 
> is parsed as a single statement but
> 
> 	if (foo) {
> 		dev_warn(...);
> 	};
> 
> is parsed as multiple statements so for the
> second case
> 
> 		dev_warn(...);
> 
> is analyzed as a separate statement.
> 
> The regex match for this missing newline test expects
> that each printk is a separate statement so the first
> case doesn't match.
> 
> Clearly the regex can be improved here.

So on top of the original patch:
---
 scripts/checkpatch.pl | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index f00a6c8..54eaa7 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -5675,8 +5675,8 @@ sub process {
 
 # check for possible missing newlines at the end of common logging functions
 		if (defined($stat) &&
-		    $stat =~ /^\+\s*($logFunctions)\s*\((?:\s*$FuncArg\s*,\s*){0,3}\s*$String/ &&
-		    $1 !~ /_cont$/ && $1 =~ /^(?:pr|dev|netdev|netif|wiphy)_/) {
+		    $stat =~ /^\+\s*(?:if\s*$balanced_parens\s*)?($logFunctions)\s*\((?:\s*$FuncArg\s*,\s*){0,3}\s*$String/ &&
+		    $2 !~ /_cont$/ && $2 =~ /^(?:pr|dev|netdev|netif|wiphy)_/) {
 			my $cnt = statement_rawlines($stat);
 			my $extracted_string = "";
 			for (my $i = 0; $i < $cnt; $i++) {


