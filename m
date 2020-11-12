Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAA182B06A0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 14:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbgKLNit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 08:38:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:29706 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728198AbgKLNih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 08:38:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605188315;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bj0DKxluQya7IdKMjC0YW3CYR9bPN7tHSjtUVL7Eyyg=;
        b=fNukqSaxJ97+wLhDTr8WSmsjCFYg0KWD8L6C+ArCQeiO7PJhvTFrW6ZcdlujYsRaxOSImO
        7iO8/VMCuRQjdIphW2WsroTpgLf7BCZ/1HB4VCjvpHrYFjKfuzoyO2QtML0+/FDIpGxNJW
        /g7mCZqePf/Ae1RSt1dL6k7cdBMaEOM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20--b0kf3i0M6GTTdJ6moAhCw-1; Thu, 12 Nov 2020 08:38:33 -0500
X-MC-Unique: -b0kf3i0M6GTTdJ6moAhCw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7808D18B9FA9;
        Thu, 12 Nov 2020 13:38:32 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-115-61.ams2.redhat.com [10.36.115.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B53FE75138;
        Thu, 12 Nov 2020 13:38:30 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        "Michael S . Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Jason Wang <jasowang@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Subject: [PATCH v2 03/29] virtio-mem: simplify MAX_ORDER - 1 / pageblock_order handling
Date:   Thu, 12 Nov 2020 14:37:49 +0100
Message-Id: <20201112133815.13332-4-david@redhat.com>
In-Reply-To: <20201112133815.13332-1-david@redhat.com>
References: <20201112133815.13332-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's use pageblock_nr_pages and MAX_ORDER_NR_PAGES instead where
possible to simplify.

Add a comment why we have that restriction for now.

Reviewed-by: Wei Yang <richard.weiyang@linux.alibaba.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index dee46865bae2..0f9d854e8e42 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -753,14 +753,15 @@ static void virtio_mem_clear_fake_offline(unsigned long pfn,
  */
 static void virtio_mem_fake_online(unsigned long pfn, unsigned int nr_pages)
 {
-	const int order = MAX_ORDER - 1;
+	const unsigned long max_nr_pages = MAX_ORDER_NR_PAGES;
 	int i;
 
 	/*
-	 * We are always called with subblock granularity, which is at least
-	 * aligned to MAX_ORDER - 1.
+	 * We are always called at least with MAX_ORDER_NR_PAGES
+	 * granularity/alignment (e.g., the way subblocks work). All pages
+	 * inside such a block are alike.
 	 */
-	for (i = 0; i < nr_pages; i += 1 << order) {
+	for (i = 0; i < nr_pages; i += max_nr_pages) {
 		struct page *page = pfn_to_page(pfn + i);
 
 		/*
@@ -770,14 +771,14 @@ static void virtio_mem_fake_online(unsigned long pfn, unsigned int nr_pages)
 		 * alike.
 		 */
 		if (PageDirty(page)) {
-			virtio_mem_clear_fake_offline(pfn + i, 1 << order,
+			virtio_mem_clear_fake_offline(pfn + i, max_nr_pages,
 						      false);
-			generic_online_page(page, order);
+			generic_online_page(page, MAX_ORDER - 1);
 		} else {
-			virtio_mem_clear_fake_offline(pfn + i, 1 << order,
+			virtio_mem_clear_fake_offline(pfn + i, max_nr_pages,
 						      true);
-			free_contig_range(pfn + i, 1 << order);
-			adjust_managed_page_count(page, 1 << order);
+			free_contig_range(pfn + i, max_nr_pages);
+			adjust_managed_page_count(page, max_nr_pages);
 		}
 	}
 }
@@ -790,7 +791,7 @@ static void virtio_mem_online_page_cb(struct page *page, unsigned int order)
 	int sb_id;
 
 	/*
-	 * We exploit here that subblocks have at least MAX_ORDER - 1
+	 * We exploit here that subblocks have at least MAX_ORDER_NR_PAGES.
 	 * size/alignment and that this callback is is called with such a
 	 * size/alignment. So we cannot cross subblocks and therefore
 	 * also not memory blocks.
@@ -1673,13 +1674,15 @@ static int virtio_mem_init(struct virtio_mem *vm)
 			 "Some memory is not addressable. This can make some memory unusable.\n");
 
 	/*
-	 * Calculate the subblock size:
-	 * - At least MAX_ORDER - 1 / pageblock_order.
-	 * - At least the device block size.
-	 * In the worst case, a single subblock per memory block.
+	 * We want subblocks to span at least MAX_ORDER_NR_PAGES and
+	 * pageblock_nr_pages pages. This:
+	 * - Simplifies our page onlining code (virtio_mem_online_page_cb)
+	 *   and fake page onlining code (virtio_mem_fake_online).
+	 * - Is required for now for alloc_contig_range() to work reliably -
+	 *   it doesn't properly handle smaller granularity on ZONE_NORMAL.
 	 */
-	vm->subblock_size = PAGE_SIZE * 1ul << max_t(uint32_t, MAX_ORDER - 1,
-						     pageblock_order);
+	vm->subblock_size = max_t(uint64_t, MAX_ORDER_NR_PAGES,
+				  pageblock_nr_pages) * PAGE_SIZE;
 	vm->subblock_size = max_t(uint64_t, vm->device_block_size,
 				  vm->subblock_size);
 	vm->nb_sb_per_mb = memory_block_size_bytes() / vm->subblock_size;
-- 
2.26.2

