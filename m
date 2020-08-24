Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9A9625093A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Aug 2020 21:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726650AbgHXT1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Aug 2020 15:27:14 -0400
Received: from smtprelay0041.hostedemail.com ([216.40.44.41]:54330 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725976AbgHXT1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 15:27:14 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 4539D837F24F;
        Mon, 24 Aug 2020 19:27:13 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:800:960:966:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1541:1593:1594:1711:1730:1747:1777:1792:2196:2198:2199:2200:2393:2553:2559:2562:2731:2828:3138:3139:3140:3141:3142:3353:3622:3865:3867:3868:3871:3872:4321:4385:5007:7903:8603:9592:10004:10400:10848:10967:11026:11232:11658:11914:12297:12555:12679:12740:12760:12895:13069:13311:13357:13439:14096:14097:14181:14659:14721:21080:21451:21627:30012:30054:30070:30090:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: lunch29_4b01b2827055
X-Filterd-Recvd-Size: 2829
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Mon, 24 Aug 2020 19:27:12 +0000 (UTC)
Message-ID: <37bbda0e0d94d3324210fa807f4061a9e9bd66bc.camel@perches.com>
Subject: Re: [PATCH] mm/mempool: Add 'else' to split mutually exclusive case
From:   Joe Perches <joe@perches.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Miaohe Lin <linmiaohe@huawei.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Mon, 24 Aug 2020 12:27:10 -0700
In-Reply-To: <20200824121840.4cd7eb3dce03e8e1473221b3@linux-foundation.org>
References: <20200824115354.7879-1-linmiaohe@huawei.com>
         <20200824121840.4cd7eb3dce03e8e1473221b3@linux-foundation.org>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2020-08-24 at 12:18 -0700, Andrew Morton wrote:
> On Mon, 24 Aug 2020 07:53:54 -0400 Miaohe Lin <linmiaohe@huawei.com> wrote:
> 
> > Add else to split mutually exclusive case and avoid some unnecessary check.
> > 
> > --- a/mm/mempool.c
> > +++ b/mm/mempool.c
> > @@ -60,9 +60,8 @@ static void check_element(mempool_t *pool, void *element)
> >  	/* Mempools backed by slab allocator */
> >  	if (pool->free == mempool_free_slab || pool->free == mempool_kfree)
> >  		__check_element(pool, element, ksize(element));
> > -
> >  	/* Mempools backed by page allocator */
> > -	if (pool->free == mempool_free_pages) {
> > +	else if (pool->free == mempool_free_pages) {
> >  		int order = (int)(long)pool->pool_data;
> >  		void *addr = kmap_atomic((struct page *)element);
> >  
> 
> It doesn't seem to change code generation (compiler is smart), but I
> think it helps readability.

style: braces should be added to the first test.

Perhaps better as:
---
 mm/mempool.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/mempool.c b/mm/mempool.c
index 79bff63ecf27..d0206eab86a4 100644
--- a/mm/mempool.c
+++ b/mm/mempool.c
@@ -57,12 +57,12 @@ static void __check_element(mempool_t *pool, void *element, size_t size)
 
 static void check_element(mempool_t *pool, void *element)
 {
-	/* Mempools backed by slab allocator */
-	if (pool->free == mempool_free_slab || pool->free == mempool_kfree)
+	if (pool->free == mempool_free_slab ||
+	    pool->free == mempool_kfree) {
+		/* Mempools backed by slab allocator */
 		__check_element(pool, element, ksize(element));
-
-	/* Mempools backed by page allocator */
-	if (pool->free == mempool_free_pages) {
+	} else if (pool->free == mempool_free_pages) {
+		/* Mempools backed by page allocator */
 		int order = (int)(long)pool->pool_data;
 		void *addr = kmap_atomic((struct page *)element);
 


