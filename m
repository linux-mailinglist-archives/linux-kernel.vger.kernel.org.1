Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 730C920D3C1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jun 2020 21:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730462AbgF2TBt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jun 2020 15:01:49 -0400
Received: from m12-14.163.com ([220.181.12.14]:51505 "EHLO m12-14.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728171AbgF2TBh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 15:01:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=Hvy7C
        q8rT4BgdG7jY1sZ9yj6W+j3Whjfwevbqonqeco=; b=VWuRDzoVvVJbps476+X/O
        pxQcQfJ0RRSNyB2SDRUJtYfI7W7p1bwlziWLZe2YAQy4ef7Xecs6TLDh7DDmLiw6
        ZVmAby0PFGJ7AddKuqkq2S+j37/MpAPNK2H3HtyFs81Zlvfwsc++d91kIzS2Kkvw
        IGSbttAyOkTaBgJbeTUym0=
Received: from localhost (unknown [101.86.215.249])
        by smtp10 (Coremail) with SMTP id DsCowADHscVHJfpeN+61Iw--.48796S2;
        Tue, 30 Jun 2020 01:30:48 +0800 (CST)
Date:   Tue, 30 Jun 2020 01:30:47 +0800
From:   Su Hui <sh_def@163.com>
To:     akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH] mm: remove the redundancy code
Message-ID: <20200629173047.GA38128@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CM-TRANSID: DsCowADHscVHJfpeN+61Iw--.48796S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrtw18Zw15uryDZw1xAFWrXwb_yoWxCrgEvw
        12y34FkrWYyF4S9w48Aa17Krn2qryvkF18GF13KF13t3W2y3ZYq3WkAwnxAryUWrZ7uryU
        Cr4DZFWxtryaqjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU0PPE3UUUUU==
X-Originating-IP: [101.86.215.249]
X-CM-SenderInfo: xvkbvvri6rljoofrz/1tbiLghSX1SIoztm4wAAsq
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

remove the redundancy code, the zone_start_pfn
is assigned from zone->zone_start_pfn
Signed-off-by: Su Hui <sh_def@163.com>
---
 mm/page_alloc.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3c4eb750a199..3372a8c9fbc4 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6215,8 +6215,6 @@ void __meminit init_currently_empty_zone(struct zone *zone,
 	if (zone_idx > pgdat->nr_zones)
 		pgdat->nr_zones = zone_idx;
 
-	zone->zone_start_pfn = zone_start_pfn;
-
 	mminit_dprintk(MMINIT_TRACE, "memmap_init",
 			"Initialising map node %d zone %lu pfns %lu -> %lu\n",
 			pgdat->node_id,
-- 
2.25.1


