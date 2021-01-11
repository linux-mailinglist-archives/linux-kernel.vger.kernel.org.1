Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 593B92F127D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 13:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727409AbhAKMn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 07:43:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59127 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726686AbhAKMnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 07:43:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1610368918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1jltblhu2Dd6iDOxJ7ANMmEZ7SYdZNOGQ9HGQetpvC0=;
        b=GMQDkrQDkm425Poi4EBy1MEkDaeCvw8IrGyXlSWLiVTw2bTRJREx66PkxSuw2lAqzwDD1n
        UHDjvFhpMOOO0adUSxItHQPkZUBo5ppuqvTQHlBX3zPmQ60x9UADczidKzp5nXeUDL081K
        RASybt+Qf7DuUNc1fqBMrj7APB+xcDw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-na-pWaWAN-6waX9uPlQz_w-1; Mon, 11 Jan 2021 07:41:55 -0500
X-MC-Unique: na-pWaWAN-6waX9uPlQz_w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 83A7C190A7A3;
        Mon, 11 Jan 2021 12:41:52 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-115-103.ams2.redhat.com [10.36.115.103])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 981BF1349A;
        Mon, 11 Jan 2021 12:41:41 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        catalin.marinas@arm.com, teawater <teawaterz@linux.alibaba.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Pankaj Gupta <pankaj.gupta@cloud.ionos.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        hca@linux.ibm.com, Vasily Gorbik <gor@linux.ibm.com>,
        Will Deacon <will@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH RFC] virtio-mem: check against memhp_get_pluggable_range() which memory we can hotplug
Date:   Mon, 11 Jan 2021 13:41:40 +0100
Message-Id: <20210111124140.11423-1-david@redhat.com>
In-Reply-To: <1608218912-28932-1-git-send-email-anshuman.khandual@arm.com>
References: <1608218912-28932-1-git-send-email-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now, we only check against MAX_PHYSMEM_BITS - but turns out there
are more restrictions of which memory we can actually hotplug, especially
om arm64 or s390x once we support them: we might receive something like
-E2BIG or -ERANGE from add_memory_driver_managed(), stopping device
operation.

So, check right when initializing the device which memory we can add,
warning the user. Try only adding actually pluggable ranges: in the worst
case, no memory provided by our device is pluggable.

In the usual case, we expect all device memory to be pluggable, and in
corner cases only some memory at the end of the device-managed memory
region to not be pluggable.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: catalin.marinas@arm.com
Cc: teawater <teawaterz@linux.alibaba.com>
Cc: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Pankaj Gupta <pankaj.gupta@cloud.ionos.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: hca@linux.ibm.com
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Will Deacon <will@kernel.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Michal Hocko <mhocko@kernel.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---

This is an example how virito-mem intends to use an interface like
memhp_get_pluggable_range() once around. See:

"[PATCH V2 0/3] mm/hotplug: Pre-validate the address range with platform"
https://lkml.kernel.org/r/1608218912-28932-1-git-send-email-anshuman.khandual@arm.com

@Anshuman, feel free to pick up and carry this patch. I'll retest the final
result / new versions of you series.

---
 drivers/virtio/virtio_mem.c | 40 +++++++++++++++++++++++++------------
 1 file changed, 27 insertions(+), 13 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 9fc9ec4a25f5..1fe40b2d7b6d 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -2222,7 +2222,7 @@ static int virtio_mem_unplug_pending_mb(struct virtio_mem *vm)
  */
 static void virtio_mem_refresh_config(struct virtio_mem *vm)
 {
-	const uint64_t phys_limit = 1UL << MAX_PHYSMEM_BITS;
+	const struct range pluggable_range = memhp_get_pluggable_range(true);
 	uint64_t new_plugged_size, usable_region_size, end_addr;
 
 	/* the plugged_size is just a reflection of what _we_ did previously */
@@ -2234,15 +2234,25 @@ static void virtio_mem_refresh_config(struct virtio_mem *vm)
 	/* calculate the last usable memory block id */
 	virtio_cread_le(vm->vdev, struct virtio_mem_config,
 			usable_region_size, &usable_region_size);
-	end_addr = vm->addr + usable_region_size;
-	end_addr = min(end_addr, phys_limit);
+	end_addr = min(vm->addr + usable_region_size - 1,
+		       pluggable_range.end);
 
-	if (vm->in_sbm)
-		vm->sbm.last_usable_mb_id =
-					 virtio_mem_phys_to_mb_id(end_addr) - 1;
-	else
-		vm->bbm.last_usable_bb_id =
-				     virtio_mem_phys_to_bb_id(vm, end_addr) - 1;
+	if (vm->in_sbm) {
+		vm->sbm.last_usable_mb_id = virtio_mem_phys_to_mb_id(end_addr);
+		if (!IS_ALIGNED(end_addr + 1, memory_block_size_bytes()))
+			vm->sbm.last_usable_mb_id--;
+	} else {
+		vm->bbm.last_usable_bb_id = virtio_mem_phys_to_bb_id(vm,
+								     end_addr);
+		if (!IS_ALIGNED(end_addr + 1, vm->bbm.bb_size))
+			vm->bbm.last_usable_bb_id--;
+	}
+	/*
+	 * If we cannot plug any of our device memory (e.g., nothing in the
+	 * usable region is addressable), the last usable memory block id will
+	 * be smaller than the first usable memory block id. We'll stop
+	 * attempting to add memory with -ENOSPC from our main loop.
+	 */
 
 	/* see if there is a request to change the size */
 	virtio_cread_le(vm->vdev, struct virtio_mem_config, requested_size,
@@ -2364,6 +2374,7 @@ static int virtio_mem_init_vq(struct virtio_mem *vm)
 
 static int virtio_mem_init(struct virtio_mem *vm)
 {
+	const struct range pluggable_range = memhp_get_pluggable_range(true);
 	const uint64_t phys_limit = 1UL << MAX_PHYSMEM_BITS;
 	uint64_t sb_size, addr;
 	uint16_t node_id;
@@ -2405,9 +2416,10 @@ static int virtio_mem_init(struct virtio_mem *vm)
 	if (!IS_ALIGNED(vm->addr + vm->region_size, memory_block_size_bytes()))
 		dev_warn(&vm->vdev->dev,
 			 "The alignment of the physical end address can make some memory unusable.\n");
-	if (vm->addr + vm->region_size > phys_limit)
+	if (vm->addr < pluggable_range.start ||
+	    vm->addr + vm->region_size - 1 > pluggable_range.end)
 		dev_warn(&vm->vdev->dev,
-			 "Some memory is not addressable. This can make some memory unusable.\n");
+			 "Some device memory is not addressable/pluggable. This can make some memory unusable.\n");
 
 	/*
 	 * We want subblocks to span at least MAX_ORDER_NR_PAGES and
@@ -2429,7 +2441,8 @@ static int virtio_mem_init(struct virtio_mem *vm)
 				     vm->sbm.sb_size;
 
 		/* Round up to the next full memory block */
-		addr = vm->addr + memory_block_size_bytes() - 1;
+		addr = max_t(uint64_t, vm->addr, pluggable_range.start) +
+		       memory_block_size_bytes() - 1;
 		vm->sbm.first_mb_id = virtio_mem_phys_to_mb_id(addr);
 		vm->sbm.next_mb_id = vm->sbm.first_mb_id;
 	} else {
@@ -2450,7 +2463,8 @@ static int virtio_mem_init(struct virtio_mem *vm)
 		}
 
 		/* Round up to the next aligned big block */
-		addr = vm->addr + vm->bbm.bb_size - 1;
+		addr = max_t(uint64_t, vm->addr, pluggable_range.start) +
+		       vm->bbm.bb_size - 1;
 		vm->bbm.first_bb_id = virtio_mem_phys_to_bb_id(vm, addr);
 		vm->bbm.next_bb_id = vm->bbm.first_bb_id;
 	}
-- 
2.29.2

