Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C05AE28B52B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 14:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730163AbgJLMz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 08:55:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:54073 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729953AbgJLMzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 08:55:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602507318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7uNq+DgFx1awbtxRCO5i53i4OzQ+SF2JZ2u66Xi43bM=;
        b=W7wrFnxGwOPW3xs8QkEz+UN4TH0ziImZhtT9QGigPZxGZrBUKxWXcYo2Up4+r7x3PAfhPh
        EU3HXbytCbaslXadJZpdYWpYvsf+82H+nPjHPHON53yx1HQIW1pzPeCkOylUVd7ikvVF41
        RgT9FBdyE6c7OsgDVdTLU7wyOA6cVnE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-398-qnEyoJ0YOFmFIFcl_UGbGQ-1; Mon, 12 Oct 2020 08:55:15 -0400
X-MC-Unique: qnEyoJ0YOFmFIFcl_UGbGQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6722164144;
        Mon, 12 Oct 2020 12:55:14 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-251.ams2.redhat.com [10.36.113.251])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C1C6460C07;
        Mon, 12 Oct 2020 12:55:09 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, virtualization@lists.linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Subject: [PATCH v1 13/29] virtio-mem: factor out handling of fake-offline pages in memory notifier
Date:   Mon, 12 Oct 2020 14:53:07 +0200
Message-Id: <20201012125323.17509-14-david@redhat.com>
In-Reply-To: <20201012125323.17509-1-david@redhat.com>
References: <20201012125323.17509-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's factor out the core pieces and place the implementation next to
virtio_mem_fake_offline(). We'll reuse this functionality soon.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 73 +++++++++++++++++++++++++------------
 1 file changed, 50 insertions(+), 23 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index d132bc54ef57..a2124892e510 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -168,6 +168,10 @@ static LIST_HEAD(virtio_mem_devices);
 
 static void virtio_mem_online_page_cb(struct page *page, unsigned int order);
 static void virtio_mem_retry(struct virtio_mem *vm);
+static void virtio_mem_fake_offline_going_offline(unsigned long pfn,
+						  unsigned long nr_pages);
+static void virtio_mem_fake_offline_cancel_offline(unsigned long pfn,
+						   unsigned long nr_pages);
 
 /*
  * Register a virtio-mem device so it will be considered for the online_page
@@ -604,27 +608,15 @@ static void virtio_mem_notify_going_offline(struct virtio_mem *vm,
 					    unsigned long mb_id)
 {
 	const unsigned long nr_pages = PFN_DOWN(vm->subblock_size);
-	struct page *page;
 	unsigned long pfn;
-	int sb_id, i;
+	int sb_id;
 
 	for (sb_id = 0; sb_id < vm->nb_sb_per_mb; sb_id++) {
 		if (virtio_mem_mb_test_sb_plugged(vm, mb_id, sb_id, 1))
 			continue;
-		/*
-		 * Drop our reference to the pages so the memory can get
-		 * offlined and add the unplugged pages to the managed
-		 * page counters (so offlining code can correctly subtract
-		 * them again).
-		 */
 		pfn = PFN_DOWN(virtio_mem_mb_id_to_phys(mb_id) +
 			       sb_id * vm->subblock_size);
-		adjust_managed_page_count(pfn_to_page(pfn), nr_pages);
-		for (i = 0; i < nr_pages; i++) {
-			page = pfn_to_page(pfn + i);
-			if (WARN_ON(!page_ref_dec_and_test(page)))
-				dump_page(page, "unplugged page referenced");
-		}
+		virtio_mem_fake_offline_going_offline(pfn, nr_pages);
 	}
 }
 
@@ -633,21 +625,14 @@ static void virtio_mem_notify_cancel_offline(struct virtio_mem *vm,
 {
 	const unsigned long nr_pages = PFN_DOWN(vm->subblock_size);
 	unsigned long pfn;
-	int sb_id, i;
+	int sb_id;
 
 	for (sb_id = 0; sb_id < vm->nb_sb_per_mb; sb_id++) {
 		if (virtio_mem_mb_test_sb_plugged(vm, mb_id, sb_id, 1))
 			continue;
-		/*
-		 * Get the reference we dropped when going offline and
-		 * subtract the unplugged pages from the managed page
-		 * counters.
-		 */
 		pfn = PFN_DOWN(virtio_mem_mb_id_to_phys(mb_id) +
 			       sb_id * vm->subblock_size);
-		adjust_managed_page_count(pfn_to_page(pfn), -nr_pages);
-		for (i = 0; i < nr_pages; i++)
-			page_ref_inc(pfn_to_page(pfn + i));
+		virtio_mem_fake_offline_cancel_offline(pfn, nr_pages);
 	}
 }
 
@@ -853,6 +838,48 @@ static int virtio_mem_fake_offline(unsigned long pfn, unsigned long nr_pages)
 	return 0;
 }
 
+/*
+ * Handle fake-offline pages when memory is going offline - such that the
+ * pages can be skipped by mm-core when offlining.
+ */
+static void virtio_mem_fake_offline_going_offline(unsigned long pfn,
+						  unsigned long nr_pages)
+{
+	struct page *page;
+	unsigned long i;
+
+	/*
+	 * Drop our reference to the pages so the memory can get offlined
+	 * and add the unplugged pages to the managed page counters (so
+	 * offlining code can correctly subtract them again).
+	 */
+	adjust_managed_page_count(pfn_to_page(pfn), nr_pages);
+	/* Drop our reference to the pages so the memory can get offlined. */
+	for (i = 0; i < nr_pages; i++) {
+		page = pfn_to_page(pfn + i);
+		if (WARN_ON(!page_ref_dec_and_test(page)))
+			dump_page(page, "fake-offline page referenced");
+	}
+}
+
+/*
+ * Handle fake-offline pages when memory offlining is canceled - to undo
+ * what we did in virtio_mem_fake_offline_going_offline().
+ */
+static void virtio_mem_fake_offline_cancel_offline(unsigned long pfn,
+						   unsigned long nr_pages)
+{
+	unsigned long i;
+
+	/*
+	 * Get the reference we dropped when going offline and subtract the
+	 * unplugged pages from the managed page counters.
+	 */
+	adjust_managed_page_count(pfn_to_page(pfn), -nr_pages);
+	for (i = 0; i < nr_pages; i++)
+		page_ref_inc(pfn_to_page(pfn + i));
+}
+
 static void virtio_mem_online_page_cb(struct page *page, unsigned int order)
 {
 	const unsigned long addr = page_to_phys(page);
-- 
2.26.2

