Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 697412E7BF8
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Dec 2020 19:54:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgL3SxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Dec 2020 13:53:07 -0500
Received: from smtprelay0023.hostedemail.com ([216.40.44.23]:57208 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726230AbgL3SxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Dec 2020 13:53:06 -0500
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 96352181D3039;
        Wed, 30 Dec 2020 18:52:25 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:982:988:989:1260:1261:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1540:1593:1594:1711:1730:1747:1777:1792:2198:2199:2393:2553:2559:2562:2687:2691:2828:2911:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3872:3874:4184:4321:4425:5007:7652:10004:10400:10848:11026:11232:11658:11914:12297:12555:12663:12740:12760:12895:12986:13069:13071:13311:13357:13439:14096:14097:14180:14181:14659:21060:21080:21324:21451:21627,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: paste15_3a0f762274a7
X-Filterd-Recvd-Size: 1781
Received: from [192.168.1.159] (unknown [47.151.137.21])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Wed, 30 Dec 2020 18:52:24 +0000 (UTC)
Message-ID: <58de45f3a0c7a4517110523edeccf19e6cec538c.camel@perches.com>
Subject: Re: [BUG] checkpatch: non-standard types cannot be declared after
 '}'
From:   Joe Perches <joe@perches.com>
To:     Jan Schlien <list.lkml@jan-o-sch.net>,
        Andy Whitcroft <apw@canonical.com>
Cc:     linux-kernel@vger.kernel.org
Date:   Wed, 30 Dec 2020 10:52:23 -0800
In-Reply-To: <d2314c57-30c5-2af9-11ef-6ae1c35a9bb5@jan-o-sch.net>
References: <d2314c57-30c5-2af9-11ef-6ae1c35a9bb5@jan-o-sch.net>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.38.1-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2020-12-30 at 14:36 +0100, Jan Schlien wrote:
> Hi,
> 
> I found some odd behavior of checkpatch.pl, which I'm currently using
> for own projects outside the kernel, but I verified that kernel patches
> can be affected as well.

Hello Jan.

I've had this patch locally for awhile that I believe fixes this
and another issue ($stat blocks can start with a close brace).

I've been waiting for Andy to review it in case there's some other
parsing problem associated with it.
---
 scripts/checkpatch.pl | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
index 00085308ed9d..012c8dc6cb1a 100755
--- a/scripts/checkpatch.pl
+++ b/scripts/checkpatch.pl
@@ -1555,7 +1555,7 @@ sub ctx_statement_block {
 
 		# Statement ends at the ';' or a close '}' at the
 		# outermost level.
-		if ($level == 0 && $c eq ';') {
+		if ($level == 0 && ($c eq ';' || $c eq '}')) {
 			last;
 		}
 

