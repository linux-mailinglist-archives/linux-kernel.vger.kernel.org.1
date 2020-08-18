Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C048F248182
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Aug 2020 11:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726631AbgHRJJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Aug 2020 05:09:24 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:34358 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726043AbgHRJJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 05:09:22 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R591e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01422;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0U67b.bN_1597741758;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0U67b.bN_1597741758)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 18 Aug 2020 17:09:18 +0800
Date:   Tue, 18 Aug 2020 17:09:18 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     Wei Yang <richard.weiyang@linux.alibaba.com>
Cc:     alexander.h.duyck@linux.intel.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org, david@redhat.com
Subject: Re: [Patch v2] mm/page_reporting: drop stale list head check in
 page_reporting_cycle
Message-ID: <20200818090917.GA34355@L-31X9LVDL-1304.local>
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20200818084448.33969-1-richard.weiyang@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200818084448.33969-1-richard.weiyang@linux.alibaba.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 18, 2020 at 04:44:48PM +0800, Wei Yang wrote:
>list_for_each_entry_safe() guarantees that we will never stumble over
>the list head; "&page->lru != list" will always evaluate to true. Let's
>simplify.

[david@redhat.com: Changelog refine.]

>
>Signed-off-by: Wei Yang <richard.weiyang@linux.alibaba.com>
>Reviewed-by: David Hildenbrand <david@redhat.com>
>---
> mm/page_reporting.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/mm/page_reporting.c b/mm/page_reporting.c
>index 3bbd471cfc81..aaaa3605123d 100644
>--- a/mm/page_reporting.c
>+++ b/mm/page_reporting.c
>@@ -178,7 +178,7 @@ page_reporting_cycle(struct page_reporting_dev_info *prdev, struct zone *zone,
> 		 * the new head of the free list before we release the
> 		 * zone lock.
> 		 */
>-		if (&page->lru != list && !list_is_first(&page->lru, list))
>+		if (!list_is_first(&page->lru, list))
> 			list_rotate_to_front(&page->lru, list);
> 
> 		/* release lock before waiting on report processing */
>-- 
>2.20.1 (Apple Git-117)

-- 
Wei Yang
Help you, Help me
