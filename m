Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44A3C291768
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Oct 2020 14:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726539AbgJRMiO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 08:38:14 -0400
Received: from out30-130.freemail.mail.aliyun.com ([115.124.30.130]:39136 "EHLO
        out30-130.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725776AbgJRMiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 08:38:14 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R721e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UCMnpef_1603024690;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0UCMnpef_1603024690)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 18 Oct 2020 20:38:10 +0800
Date:   Sun, 18 Oct 2020 20:38:10 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        virtualization@lists.linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Subject: Re: [PATCH v1 13/29] virtio-mem: factor out handling of fake-offline
 pages in memory notifier
Message-ID: <20201018123810.GA51316@L-31X9LVDL-1304.local>
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20201012125323.17509-1-david@redhat.com>
 <20201012125323.17509-14-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012125323.17509-14-david@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 02:53:07PM +0200, David Hildenbrand wrote:
>Let's factor out the core pieces and place the implementation next to
>virtio_mem_fake_offline(). We'll reuse this functionality soon.
>
>Cc: "Michael S. Tsirkin" <mst@redhat.com>
>Cc: Jason Wang <jasowang@redhat.com>
>Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
>Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Wei Yang <richard.weiyang@linux.alibaba.com>

>---
> drivers/virtio/virtio_mem.c | 73 +++++++++++++++++++++++++------------
> 1 file changed, 50 insertions(+), 23 deletions(-)
>
>diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
>index d132bc54ef57..a2124892e510 100644
>--- a/drivers/virtio/virtio_mem.c
>+++ b/drivers/virtio/virtio_mem.c
>@@ -168,6 +168,10 @@ static LIST_HEAD(virtio_mem_devices);
> 
> static void virtio_mem_online_page_cb(struct page *page, unsigned int order);
> static void virtio_mem_retry(struct virtio_mem *vm);
>+static void virtio_mem_fake_offline_going_offline(unsigned long pfn,
>+						  unsigned long nr_pages);
>+static void virtio_mem_fake_offline_cancel_offline(unsigned long pfn,
>+						   unsigned long nr_pages);
> 
> /*
>  * Register a virtio-mem device so it will be considered for the online_page
>@@ -604,27 +608,15 @@ static void virtio_mem_notify_going_offline(struct virtio_mem *vm,
> 					    unsigned long mb_id)
> {
> 	const unsigned long nr_pages = PFN_DOWN(vm->subblock_size);
>-	struct page *page;
> 	unsigned long pfn;
>-	int sb_id, i;
>+	int sb_id;
> 
> 	for (sb_id = 0; sb_id < vm->nb_sb_per_mb; sb_id++) {
> 		if (virtio_mem_mb_test_sb_plugged(vm, mb_id, sb_id, 1))
> 			continue;
>-		/*
>-		 * Drop our reference to the pages so the memory can get
>-		 * offlined and add the unplugged pages to the managed
>-		 * page counters (so offlining code can correctly subtract
>-		 * them again).
>-		 */
> 		pfn = PFN_DOWN(virtio_mem_mb_id_to_phys(mb_id) +
> 			       sb_id * vm->subblock_size);
>-		adjust_managed_page_count(pfn_to_page(pfn), nr_pages);
>-		for (i = 0; i < nr_pages; i++) {
>-			page = pfn_to_page(pfn + i);
>-			if (WARN_ON(!page_ref_dec_and_test(page)))
>-				dump_page(page, "unplugged page referenced");
>-		}
>+		virtio_mem_fake_offline_going_offline(pfn, nr_pages);
> 	}
> }
> 
>@@ -633,21 +625,14 @@ static void virtio_mem_notify_cancel_offline(struct virtio_mem *vm,
> {
> 	const unsigned long nr_pages = PFN_DOWN(vm->subblock_size);
> 	unsigned long pfn;
>-	int sb_id, i;
>+	int sb_id;
> 
> 	for (sb_id = 0; sb_id < vm->nb_sb_per_mb; sb_id++) {
> 		if (virtio_mem_mb_test_sb_plugged(vm, mb_id, sb_id, 1))
> 			continue;
>-		/*
>-		 * Get the reference we dropped when going offline and
>-		 * subtract the unplugged pages from the managed page
>-		 * counters.
>-		 */
> 		pfn = PFN_DOWN(virtio_mem_mb_id_to_phys(mb_id) +
> 			       sb_id * vm->subblock_size);
>-		adjust_managed_page_count(pfn_to_page(pfn), -nr_pages);
>-		for (i = 0; i < nr_pages; i++)
>-			page_ref_inc(pfn_to_page(pfn + i));
>+		virtio_mem_fake_offline_cancel_offline(pfn, nr_pages);
> 	}
> }
> 
>@@ -853,6 +838,48 @@ static int virtio_mem_fake_offline(unsigned long pfn, unsigned long nr_pages)
> 	return 0;
> }
> 
>+/*
>+ * Handle fake-offline pages when memory is going offline - such that the
>+ * pages can be skipped by mm-core when offlining.
>+ */
>+static void virtio_mem_fake_offline_going_offline(unsigned long pfn,
>+						  unsigned long nr_pages)
>+{
>+	struct page *page;
>+	unsigned long i;
>+
>+	/*
>+	 * Drop our reference to the pages so the memory can get offlined
>+	 * and add the unplugged pages to the managed page counters (so
>+	 * offlining code can correctly subtract them again).
>+	 */
>+	adjust_managed_page_count(pfn_to_page(pfn), nr_pages);
>+	/* Drop our reference to the pages so the memory can get offlined. */
>+	for (i = 0; i < nr_pages; i++) {
>+		page = pfn_to_page(pfn + i);
>+		if (WARN_ON(!page_ref_dec_and_test(page)))
>+			dump_page(page, "fake-offline page referenced");
>+	}
>+}
>+
>+/*
>+ * Handle fake-offline pages when memory offlining is canceled - to undo
>+ * what we did in virtio_mem_fake_offline_going_offline().
>+ */
>+static void virtio_mem_fake_offline_cancel_offline(unsigned long pfn,
>+						   unsigned long nr_pages)
>+{
>+	unsigned long i;
>+
>+	/*
>+	 * Get the reference we dropped when going offline and subtract the
>+	 * unplugged pages from the managed page counters.
>+	 */
>+	adjust_managed_page_count(pfn_to_page(pfn), -nr_pages);
>+	for (i = 0; i < nr_pages; i++)
>+		page_ref_inc(pfn_to_page(pfn + i));
>+}
>+
> static void virtio_mem_online_page_cb(struct page *page, unsigned int order)
> {
> 	const unsigned long addr = page_to_phys(page);
>-- 
>2.26.2

-- 
Wei Yang
Help you, Help me
