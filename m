Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7441F10F6
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jun 2020 03:02:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728366AbgFHBCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Jun 2020 21:02:48 -0400
Received: from smtprelay0113.hostedemail.com ([216.40.44.113]:33036 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727999AbgFHBCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 21:02:48 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay06.hostedemail.com (Postfix) with ESMTP id 1784B1808E84C;
        Mon,  8 Jun 2020 01:02:47 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:960:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:1978:1981:2194:2199:2393:2559:2562:2692:2828:3138:3139:3140:3141:3142:3352:3622:3865:3866:3867:3868:3870:3871:3872:3874:4321:5007:8957:10004:10400:10848:11232:11658:11914:12114:12295:12296:12297:12438:12555:12740:12760:12895:12986:13069:13311:13357:13439:14096:14097:14180:14659:14721:21060:21080:21212:21451:21627:21660:30012:30041:30054:30070:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: love83_601194f26db5
X-Filterd-Recvd-Size: 2236
Received: from XPS-9350.home (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Mon,  8 Jun 2020 01:02:45 +0000 (UTC)
Message-ID: <3bf931c6ea0cae3e23f3485801986859851b4f04.camel@perches.com>
Subject: Re: [PATCH] lib/lz4: smatch warning in LZ4_decompress_generic()
From:   Joe Perches <joe@perches.com>
To:     Yann Collet <cyan@fb.com>, Vasily Averin <vvs@virtuozzo.com>,
        Gao Xiang <hsiangkao@aol.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Gao Xiang <xiang@kernel.org>
Date:   Sun, 07 Jun 2020 18:02:44 -0700
In-Reply-To: <D4762145-BBC5-4574-BF68-8C1A3AF41D98@fb.com>
References: <20200606143646.GB10839.ref@hsiangkao-HP-ZHAN-66-Pro-G1>
         <20200606143646.GB10839@hsiangkao-HP-ZHAN-66-Pro-G1>
         <330eccf1-6d4b-07dd-4e55-ffe3a179e4b8@virtuozzo.com>
         <D4762145-BBC5-4574-BF68-8C1A3AF41D98@fb.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-06-08 at 00:40 +0000, Yann Collet wrote:
> Hi Vasily
> 
> 
> If I do understand the discussion, the question is about usage of `&` instead of `&&`,
> and the speculation that it might be an error.
> 
> It's not an error. Unfortunately, explaining the reasoning behind this decision is a bit long.

Likely better to add a comment around the use so that
another patch like this doesn't get submitted again.

Perhaps something like:
---
 lib/lz4/lz4_decompress.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/lz4/lz4_decompress.c b/lib/lz4/lz4_decompress.c
index 0c9d3ad17e0f..5371dab6b481 100644
--- a/lib/lz4/lz4_decompress.c
+++ b/lib/lz4/lz4_decompress.c
@@ -141,6 +141,9 @@ static FORCE_INLINE int LZ4_decompress_generic(
 		 * space in the output for those 18 bytes earlier, upon
 		 * entering the shortcut (in other words, there is a
 		 * combined check for both stages).
+		 *
+		 * The & in the likely() below is intentionally not && so that
+		 * some compilers can produce better parallelized runtime code
 		 */
 		if ((endOnInput ? length != RUN_MASK : length <= 8)
 		   /*


