Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFE6629002E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 10:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405200AbgJPIvW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 04:51:22 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:59442 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2404520AbgJPIvW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 04:51:22 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UCBd6i5_1602838275;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0UCBd6i5_1602838275)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 16 Oct 2020 16:51:16 +0800
Date:   Fri, 16 Oct 2020 16:51:15 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        virtualization@lists.linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Subject: Re: [PATCH v1 20/29] virtio-mem: nb_sb_per_mb and subblock_size are
 specific to Sub Block Mode (SBM)
Message-ID: <20201016085115.GC44269@L-31X9LVDL-1304.local>
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20201012125323.17509-1-david@redhat.com>
 <20201012125323.17509-21-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012125323.17509-21-david@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 02:53:14PM +0200, David Hildenbrand wrote:
>Let's rename to "sbs_per_mb" and "sb_size" and move accordingly.
>
>Cc: "Michael S. Tsirkin" <mst@redhat.com>
>Cc: Jason Wang <jasowang@redhat.com>
>Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
>Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Wei Yang <richard.weiyang@linux.alibaba.com>

>---
> drivers/virtio/virtio_mem.c | 96 ++++++++++++++++++-------------------
> 1 file changed, 48 insertions(+), 48 deletions(-)
>
>diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
>index fc2b1ff3beed..3a772714fec9 100644
>--- a/drivers/virtio/virtio_mem.c
>+++ b/drivers/virtio/virtio_mem.c
>@@ -96,11 +96,6 @@ struct virtio_mem {
> 	/* Maximum region size in bytes. */
> 	uint64_t region_size;
> 
>-	/* The subblock size. */
>-	uint64_t subblock_size;
>-	/* The number of subblocks per memory block. */
>-	uint32_t nb_sb_per_mb;
>-
> 	/* Id of the first memory block of this device. */
> 	unsigned long first_mb_id;
> 	/* Id of the last usable memory block of this device. */
>@@ -126,6 +121,11 @@ struct virtio_mem {
> 	uint64_t offline_threshold;
> 
> 	struct {
>+		/* The subblock size. */
>+		uint64_t sb_size;
>+		/* The number of subblocks per Linux memory block. */
>+		uint32_t sbs_per_mb;
>+
> 		/* Summary of all memory block states. */
> 		unsigned long mb_count[VIRTIO_MEM_SBM_MB_COUNT];
> 
>@@ -256,7 +256,7 @@ static unsigned long virtio_mem_phys_to_sb_id(struct virtio_mem *vm,
> 	const unsigned long mb_id = virtio_mem_phys_to_mb_id(addr);
> 	const unsigned long mb_addr = virtio_mem_mb_id_to_phys(mb_id);
> 
>-	return (addr - mb_addr) / vm->subblock_size;
>+	return (addr - mb_addr) / vm->sbm.sb_size;
> }
> 
> /*
>@@ -334,7 +334,7 @@ static int virtio_mem_sbm_mb_states_prepare_next_mb(struct virtio_mem *vm)
> static int virtio_mem_sbm_sb_state_bit_nr(struct virtio_mem *vm,
> 					  unsigned long mb_id, int sb_id)
> {
>-	return (mb_id - vm->first_mb_id) * vm->nb_sb_per_mb + sb_id;
>+	return (mb_id - vm->first_mb_id) * vm->sbm.sbs_per_mb + sb_id;
> }
> 
> /*
>@@ -397,7 +397,7 @@ static bool virtio_mem_sbm_test_sb_unplugged(struct virtio_mem *vm,
> }
> 
> /*
>- * Find the first unplugged subblock. Returns vm->nb_sb_per_mb in case there is
>+ * Find the first unplugged subblock. Returns vm->sbm.sbs_per_mb in case there is
>  * none.
>  */
> static int virtio_mem_sbm_first_unplugged_sb(struct virtio_mem *vm,
>@@ -406,7 +406,7 @@ static int virtio_mem_sbm_first_unplugged_sb(struct virtio_mem *vm,
> 	const int bit = virtio_mem_sbm_sb_state_bit_nr(vm, mb_id, 0);
> 
> 	return find_next_zero_bit(vm->sbm.sb_states,
>-				  bit + vm->nb_sb_per_mb, bit) - bit;
>+				  bit + vm->sbm.sbs_per_mb, bit) - bit;
> }
> 
> /*
>@@ -415,8 +415,8 @@ static int virtio_mem_sbm_first_unplugged_sb(struct virtio_mem *vm,
> static int virtio_mem_sbm_sb_states_prepare_next_mb(struct virtio_mem *vm)
> {
> 	const unsigned long old_nb_mb = vm->next_mb_id - vm->first_mb_id;
>-	const unsigned long old_nb_bits = old_nb_mb * vm->nb_sb_per_mb;
>-	const unsigned long new_nb_bits = (old_nb_mb + 1) * vm->nb_sb_per_mb;
>+	const unsigned long old_nb_bits = old_nb_mb * vm->sbm.sbs_per_mb;
>+	const unsigned long new_nb_bits = (old_nb_mb + 1) * vm->sbm.sbs_per_mb;
> 	int old_pages = PFN_UP(BITS_TO_LONGS(old_nb_bits) * sizeof(long));
> 	int new_pages = PFN_UP(BITS_TO_LONGS(new_nb_bits) * sizeof(long));
> 	unsigned long *new_bitmap, *old_bitmap;
>@@ -642,15 +642,15 @@ static void virtio_mem_notify_online(struct virtio_mem *vm, unsigned long mb_id)
> static void virtio_mem_notify_going_offline(struct virtio_mem *vm,
> 					    unsigned long mb_id)
> {
>-	const unsigned long nr_pages = PFN_DOWN(vm->subblock_size);
>+	const unsigned long nr_pages = PFN_DOWN(vm->sbm.sb_size);
> 	unsigned long pfn;
> 	int sb_id;
> 
>-	for (sb_id = 0; sb_id < vm->nb_sb_per_mb; sb_id++) {
>+	for (sb_id = 0; sb_id < vm->sbm.sbs_per_mb; sb_id++) {
> 		if (virtio_mem_sbm_test_sb_plugged(vm, mb_id, sb_id, 1))
> 			continue;
> 		pfn = PFN_DOWN(virtio_mem_mb_id_to_phys(mb_id) +
>-			       sb_id * vm->subblock_size);
>+			       sb_id * vm->sbm.sb_size);
> 		virtio_mem_fake_offline_going_offline(pfn, nr_pages);
> 	}
> }
>@@ -658,15 +658,15 @@ static void virtio_mem_notify_going_offline(struct virtio_mem *vm,
> static void virtio_mem_notify_cancel_offline(struct virtio_mem *vm,
> 					     unsigned long mb_id)
> {
>-	const unsigned long nr_pages = PFN_DOWN(vm->subblock_size);
>+	const unsigned long nr_pages = PFN_DOWN(vm->sbm.sb_size);
> 	unsigned long pfn;
> 	int sb_id;
> 
>-	for (sb_id = 0; sb_id < vm->nb_sb_per_mb; sb_id++) {
>+	for (sb_id = 0; sb_id < vm->sbm.sbs_per_mb; sb_id++) {
> 		if (virtio_mem_sbm_test_sb_plugged(vm, mb_id, sb_id, 1))
> 			continue;
> 		pfn = PFN_DOWN(virtio_mem_mb_id_to_phys(mb_id) +
>-			       sb_id * vm->subblock_size);
>+			       sb_id * vm->sbm.sb_size);
> 		virtio_mem_fake_offline_cancel_offline(pfn, nr_pages);
> 	}
> }
>@@ -1079,8 +1079,8 @@ static int virtio_mem_sbm_plug_sb(struct virtio_mem *vm, unsigned long mb_id,
> 				  int sb_id, int count)
> {
> 	const uint64_t addr = virtio_mem_mb_id_to_phys(mb_id) +
>-			      sb_id * vm->subblock_size;
>-	const uint64_t size = count * vm->subblock_size;
>+			      sb_id * vm->sbm.sb_size;
>+	const uint64_t size = count * vm->sbm.sb_size;
> 	int rc;
> 
> 	dev_dbg(&vm->vdev->dev, "plugging memory block: %lu : %i - %i\n", mb_id,
>@@ -1100,8 +1100,8 @@ static int virtio_mem_sbm_unplug_sb(struct virtio_mem *vm, unsigned long mb_id,
> 				    int sb_id, int count)
> {
> 	const uint64_t addr = virtio_mem_mb_id_to_phys(mb_id) +
>-			      sb_id * vm->subblock_size;
>-	const uint64_t size = count * vm->subblock_size;
>+			      sb_id * vm->sbm.sb_size;
>+	const uint64_t size = count * vm->sbm.sb_size;
> 	int rc;
> 
> 	dev_dbg(&vm->vdev->dev, "unplugging memory block: %lu : %i - %i\n",
>@@ -1128,7 +1128,7 @@ static int virtio_mem_sbm_unplug_any_sb(struct virtio_mem *vm,
> 	int sb_id, count;
> 	int rc;
> 
>-	sb_id = vm->nb_sb_per_mb - 1;
>+	sb_id = vm->sbm.sbs_per_mb - 1;
> 	while (*nb_sb) {
> 		/* Find the next candidate subblock */
> 		while (sb_id >= 0 &&
>@@ -1163,7 +1163,7 @@ static int virtio_mem_sbm_unplug_any_sb(struct virtio_mem *vm,
>  */
> static int virtio_mem_sbm_unplug_mb(struct virtio_mem *vm, unsigned long mb_id)
> {
>-	uint64_t nb_sb = vm->nb_sb_per_mb;
>+	uint64_t nb_sb = vm->sbm.sbs_per_mb;
> 
> 	return virtio_mem_sbm_unplug_any_sb(vm, mb_id, &nb_sb);
> }
>@@ -1203,7 +1203,7 @@ static int virtio_mem_sbm_prepare_next_mb(struct virtio_mem *vm,
> static int virtio_mem_sbm_plug_and_add_mb(struct virtio_mem *vm,
> 					  unsigned long mb_id, uint64_t *nb_sb)
> {
>-	const int count = min_t(int, *nb_sb, vm->nb_sb_per_mb);
>+	const int count = min_t(int, *nb_sb, vm->sbm.sbs_per_mb);
> 	int rc;
> 
> 	if (WARN_ON_ONCE(!count))
>@@ -1221,7 +1221,7 @@ static int virtio_mem_sbm_plug_and_add_mb(struct virtio_mem *vm,
> 	 * Mark the block properly offline before adding it to Linux,
> 	 * so the memory notifiers will find the block in the right state.
> 	 */
>-	if (count == vm->nb_sb_per_mb)
>+	if (count == vm->sbm.sbs_per_mb)
> 		virtio_mem_sbm_set_mb_state(vm, mb_id,
> 					    VIRTIO_MEM_SBM_MB_OFFLINE);
> 	else
>@@ -1271,11 +1271,11 @@ static int virtio_mem_sbm_plug_any_sb(struct virtio_mem *vm,
> 
> 	while (*nb_sb) {
> 		sb_id = virtio_mem_sbm_first_unplugged_sb(vm, mb_id);
>-		if (sb_id >= vm->nb_sb_per_mb)
>+		if (sb_id >= vm->sbm.sbs_per_mb)
> 			break;
> 		count = 1;
> 		while (count < *nb_sb &&
>-		       sb_id + count < vm->nb_sb_per_mb &&
>+		       sb_id + count < vm->sbm.sbs_per_mb &&
> 		       !virtio_mem_sbm_test_sb_plugged(vm, mb_id, sb_id + count, 1))
> 			count++;
> 
>@@ -1288,12 +1288,12 @@ static int virtio_mem_sbm_plug_any_sb(struct virtio_mem *vm,
> 
> 		/* fake-online the pages if the memory block is online */
> 		pfn = PFN_DOWN(virtio_mem_mb_id_to_phys(mb_id) +
>-			       sb_id * vm->subblock_size);
>-		nr_pages = PFN_DOWN(count * vm->subblock_size);
>+			       sb_id * vm->sbm.sb_size);
>+		nr_pages = PFN_DOWN(count * vm->sbm.sb_size);
> 		virtio_mem_fake_online(pfn, nr_pages);
> 	}
> 
>-	if (virtio_mem_sbm_test_sb_plugged(vm, mb_id, 0, vm->nb_sb_per_mb)) {
>+	if (virtio_mem_sbm_test_sb_plugged(vm, mb_id, 0, vm->sbm.sbs_per_mb)) {
> 		if (online)
> 			virtio_mem_sbm_set_mb_state(vm, mb_id,
> 						    VIRTIO_MEM_SBM_MB_ONLINE);
>@@ -1310,7 +1310,7 @@ static int virtio_mem_sbm_plug_any_sb(struct virtio_mem *vm,
>  */
> static int virtio_mem_plug_request(struct virtio_mem *vm, uint64_t diff)
> {
>-	uint64_t nb_sb = diff / vm->subblock_size;
>+	uint64_t nb_sb = diff / vm->sbm.sb_size;
> 	unsigned long mb_id;
> 	int rc;
> 
>@@ -1393,13 +1393,13 @@ static int virtio_mem_sbm_unplug_any_sb_offline(struct virtio_mem *vm,
> 	rc = virtio_mem_sbm_unplug_any_sb(vm, mb_id, nb_sb);
> 
> 	/* some subblocks might have been unplugged even on failure */
>-	if (!virtio_mem_sbm_test_sb_plugged(vm, mb_id, 0, vm->nb_sb_per_mb))
>+	if (!virtio_mem_sbm_test_sb_plugged(vm, mb_id, 0, vm->sbm.sbs_per_mb))
> 		virtio_mem_sbm_set_mb_state(vm, mb_id,
> 					    VIRTIO_MEM_SBM_MB_OFFLINE_PARTIAL);
> 	if (rc)
> 		return rc;
> 
>-	if (virtio_mem_sbm_test_sb_unplugged(vm, mb_id, 0, vm->nb_sb_per_mb)) {
>+	if (virtio_mem_sbm_test_sb_unplugged(vm, mb_id, 0, vm->sbm.sbs_per_mb)) {
> 		/*
> 		 * Remove the block from Linux - this should never fail.
> 		 * Hinder the block from getting onlined by marking it
>@@ -1426,12 +1426,12 @@ static int virtio_mem_sbm_unplug_sb_online(struct virtio_mem *vm,
> 					   unsigned long mb_id, int sb_id,
> 					   int count)
> {
>-	const unsigned long nr_pages = PFN_DOWN(vm->subblock_size) * count;
>+	const unsigned long nr_pages = PFN_DOWN(vm->sbm.sb_size) * count;
> 	unsigned long start_pfn;
> 	int rc;
> 
> 	start_pfn = PFN_DOWN(virtio_mem_mb_id_to_phys(mb_id) +
>-			     sb_id * vm->subblock_size);
>+			     sb_id * vm->sbm.sb_size);
> 
> 	rc = virtio_mem_fake_offline(start_pfn, nr_pages);
> 	if (rc)
>@@ -1467,19 +1467,19 @@ static int virtio_mem_sbm_unplug_any_sb_online(struct virtio_mem *vm,
> 	int rc, sb_id;
> 
> 	/* If possible, try to unplug the complete block in one shot. */
>-	if (*nb_sb >= vm->nb_sb_per_mb &&
>-	    virtio_mem_sbm_test_sb_plugged(vm, mb_id, 0, vm->nb_sb_per_mb)) {
>+	if (*nb_sb >= vm->sbm.sbs_per_mb &&
>+	    virtio_mem_sbm_test_sb_plugged(vm, mb_id, 0, vm->sbm.sbs_per_mb)) {
> 		rc = virtio_mem_sbm_unplug_sb_online(vm, mb_id, 0,
>-						     vm->nb_sb_per_mb);
>+						     vm->sbm.sbs_per_mb);
> 		if (!rc) {
>-			*nb_sb -= vm->nb_sb_per_mb;
>+			*nb_sb -= vm->sbm.sbs_per_mb;
> 			goto unplugged;
> 		} else if (rc != -EBUSY)
> 			return rc;
> 	}
> 
> 	/* Fallback to single subblocks. */
>-	for (sb_id = vm->nb_sb_per_mb - 1; sb_id >= 0 && *nb_sb; sb_id--) {
>+	for (sb_id = vm->sbm.sbs_per_mb - 1; sb_id >= 0 && *nb_sb; sb_id--) {
> 		/* Find the next candidate subblock */
> 		while (sb_id >= 0 &&
> 		       !virtio_mem_sbm_test_sb_plugged(vm, mb_id, sb_id, 1))
>@@ -1501,7 +1501,7 @@ static int virtio_mem_sbm_unplug_any_sb_online(struct virtio_mem *vm,
> 	 * remove it. This will usually not fail, as no memory is in use
> 	 * anymore - however some other notifiers might NACK the request.
> 	 */
>-	if (virtio_mem_sbm_test_sb_unplugged(vm, mb_id, 0, vm->nb_sb_per_mb)) {
>+	if (virtio_mem_sbm_test_sb_unplugged(vm, mb_id, 0, vm->sbm.sbs_per_mb)) {
> 		mutex_unlock(&vm->hotplug_mutex);
> 		rc = virtio_mem_mb_offline_and_remove(vm, mb_id);
> 		mutex_lock(&vm->hotplug_mutex);
>@@ -1518,7 +1518,7 @@ static int virtio_mem_sbm_unplug_any_sb_online(struct virtio_mem *vm,
>  */
> static int virtio_mem_unplug_request(struct virtio_mem *vm, uint64_t diff)
> {
>-	uint64_t nb_sb = diff / vm->subblock_size;
>+	uint64_t nb_sb = diff / vm->sbm.sb_size;
> 	unsigned long mb_id;
> 	int rc;
> 
>@@ -1805,11 +1805,11 @@ static int virtio_mem_init(struct virtio_mem *vm)
> 	 * - Is required for now for alloc_contig_range() to work reliably -
> 	 *   it doesn't properly handle smaller granularity on ZONE_NORMAL.
> 	 */
>-	vm->subblock_size = max_t(uint64_t, MAX_ORDER_NR_PAGES,
>-				  pageblock_nr_pages) * PAGE_SIZE;
>-	vm->subblock_size = max_t(uint64_t, vm->device_block_size,
>-				  vm->subblock_size);
>-	vm->nb_sb_per_mb = memory_block_size_bytes() / vm->subblock_size;
>+	vm->sbm.sb_size = max_t(uint64_t, MAX_ORDER_NR_PAGES,
>+				pageblock_nr_pages) * PAGE_SIZE;
>+	vm->sbm.sb_size = max_t(uint64_t, vm->device_block_size,
>+				vm->sbm.sb_size);
>+	vm->sbm.sbs_per_mb = memory_block_size_bytes() / vm->sbm.sb_size;
> 
> 	/* Round up to the next full memory block */
> 	vm->first_mb_id = virtio_mem_phys_to_mb_id(vm->addr - 1 +
>@@ -1827,7 +1827,7 @@ static int virtio_mem_init(struct virtio_mem *vm)
> 	dev_info(&vm->vdev->dev, "memory block size: 0x%lx",
> 		 memory_block_size_bytes());
> 	dev_info(&vm->vdev->dev, "subblock size: 0x%llx",
>-		 (unsigned long long)vm->subblock_size);
>+		 (unsigned long long)vm->sbm.sb_size);
> 	if (vm->nid != NUMA_NO_NODE && IS_ENABLED(CONFIG_NUMA))
> 		dev_info(&vm->vdev->dev, "nid: %d", vm->nid);
> 
>-- 
>2.26.2

-- 
Wei Yang
Help you, Help me
