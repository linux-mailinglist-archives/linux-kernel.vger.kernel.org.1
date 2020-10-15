Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 902CB28EBC0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Oct 2020 05:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730522AbgJOD4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Oct 2020 23:56:45 -0400
Received: from out30-43.freemail.mail.aliyun.com ([115.124.30.43]:39066 "EHLO
        out30-43.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727281AbgJOD4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Oct 2020 23:56:44 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UC448V1_1602734199;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0UC448V1_1602734199)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 15 Oct 2020 11:56:40 +0800
Date:   Thu, 15 Oct 2020 11:56:39 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        virtualization@lists.linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Subject: Re: [PATCH v1 01/29] virtio-mem: determine nid only once using
 memory_add_physaddr_to_nid()
Message-ID: <20201015035639.GA86495@L-31X9LVDL-1304.local>
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20201012125323.17509-1-david@redhat.com>
 <20201012125323.17509-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012125323.17509-2-david@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 02:52:55PM +0200, David Hildenbrand wrote:
>Let's determine the target nid only once in case we have none specified -
>usually, we'll end up with node 0 either way.
>
>Cc: "Michael S. Tsirkin" <mst@redhat.com>
>Cc: Jason Wang <jasowang@redhat.com>
>Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
>Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Wei Yang <richard.weiyang@linux.alibaba.com>

>---
> drivers/virtio/virtio_mem.c | 28 +++++++++++-----------------
> 1 file changed, 11 insertions(+), 17 deletions(-)
>
>diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
>index ba4de598f663..a1f5bf7a571a 100644
>--- a/drivers/virtio/virtio_mem.c
>+++ b/drivers/virtio/virtio_mem.c
>@@ -70,7 +70,7 @@ struct virtio_mem {
> 
> 	/* The device block size (for communicating with the device). */
> 	uint64_t device_block_size;
>-	/* The translated node id. NUMA_NO_NODE in case not specified. */
>+	/* The determined node id for all memory of the device. */
> 	int nid;
> 	/* Physical start address of the memory region. */
> 	uint64_t addr;
>@@ -406,10 +406,6 @@ static int virtio_mem_sb_bitmap_prepare_next_mb(struct virtio_mem *vm)
> static int virtio_mem_mb_add(struct virtio_mem *vm, unsigned long mb_id)
> {
> 	const uint64_t addr = virtio_mem_mb_id_to_phys(mb_id);
>-	int nid = vm->nid;
>-
>-	if (nid == NUMA_NO_NODE)
>-		nid = memory_add_physaddr_to_nid(addr);
> 
> 	/*
> 	 * When force-unloading the driver and we still have memory added to
>@@ -423,7 +419,8 @@ static int virtio_mem_mb_add(struct virtio_mem *vm, unsigned long mb_id)
> 	}
> 
> 	dev_dbg(&vm->vdev->dev, "adding memory block: %lu\n", mb_id);
>-	return add_memory_driver_managed(nid, addr, memory_block_size_bytes(),
>+	return add_memory_driver_managed(vm->nid, addr,
>+					 memory_block_size_bytes(),
> 					 vm->resource_name,
> 					 MEMHP_MERGE_RESOURCE);
> }
>@@ -440,13 +437,9 @@ static int virtio_mem_mb_add(struct virtio_mem *vm, unsigned long mb_id)
> static int virtio_mem_mb_remove(struct virtio_mem *vm, unsigned long mb_id)
> {
> 	const uint64_t addr = virtio_mem_mb_id_to_phys(mb_id);
>-	int nid = vm->nid;
>-
>-	if (nid == NUMA_NO_NODE)
>-		nid = memory_add_physaddr_to_nid(addr);
> 
> 	dev_dbg(&vm->vdev->dev, "removing memory block: %lu\n", mb_id);
>-	return remove_memory(nid, addr, memory_block_size_bytes());
>+	return remove_memory(vm->nid, addr, memory_block_size_bytes());
> }
> 
> /*
>@@ -461,14 +454,11 @@ static int virtio_mem_mb_offline_and_remove(struct virtio_mem *vm,
> 					    unsigned long mb_id)
> {
> 	const uint64_t addr = virtio_mem_mb_id_to_phys(mb_id);
>-	int nid = vm->nid;
>-
>-	if (nid == NUMA_NO_NODE)
>-		nid = memory_add_physaddr_to_nid(addr);
> 
> 	dev_dbg(&vm->vdev->dev, "offlining and removing memory block: %lu\n",
> 		mb_id);
>-	return offline_and_remove_memory(nid, addr, memory_block_size_bytes());
>+	return offline_and_remove_memory(vm->nid, addr,
>+					 memory_block_size_bytes());
> }
> 
> /*
>@@ -1659,6 +1649,10 @@ static int virtio_mem_init(struct virtio_mem *vm)
> 	virtio_cread_le(vm->vdev, struct virtio_mem_config, region_size,
> 			&vm->region_size);
> 
>+	/* Determine the nid for the device based on the lowest address. */
>+	if (vm->nid == NUMA_NO_NODE)
>+		vm->nid = memory_add_physaddr_to_nid(vm->addr);
>+
> 	/*
> 	 * We always hotplug memory in memory block granularity. This way,
> 	 * we have to wait for exactly one memory block to online.
>@@ -1707,7 +1701,7 @@ static int virtio_mem_init(struct virtio_mem *vm)
> 		 memory_block_size_bytes());
> 	dev_info(&vm->vdev->dev, "subblock size: 0x%llx",
> 		 (unsigned long long)vm->subblock_size);
>-	if (vm->nid != NUMA_NO_NODE)
>+	if (vm->nid != NUMA_NO_NODE && IS_ENABLED(CONFIG_NUMA))
> 		dev_info(&vm->vdev->dev, "nid: %d", vm->nid);
> 
> 	return 0;
>-- 
>2.26.2

-- 
Wei Yang
Help you, Help me
