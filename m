Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACC228B50B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 14:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729939AbgJLMx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 08:53:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:36041 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725941AbgJLMx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 08:53:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602507236;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RvlIrmP7pDfti7mpO1J7dVgqWMijPzb2nPlsVawRGOw=;
        b=T9JnB6yu++9DISYdKtaTxFnFJFFJrsIEoLrR41nefWZ3CkMfJz6DFBuTHnvt9Y3bxXyjj4
        YVJyAWSoZImiIMwXTMAYesqaKn077ZOcLIYbqnjd2kKHKE5AFLodk6kU21JSqDeooY9QKD
        00vrdHe0CD1SZNM+cFDTgHl+L6zHIFk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-eBDLZPd9Nq2ptRftjy7E_g-1; Mon, 12 Oct 2020 08:53:54 -0400
X-MC-Unique: eBDLZPd9Nq2ptRftjy7E_g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2F9281017DC1;
        Mon, 12 Oct 2020 12:53:53 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-251.ams2.redhat.com [10.36.113.251])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DABB960C07;
        Mon, 12 Oct 2020 12:53:48 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, virtualization@lists.linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Subject: [PATCH v1 01/29] virtio-mem: determine nid only once using memory_add_physaddr_to_nid()
Date:   Mon, 12 Oct 2020 14:52:55 +0200
Message-Id: <20201012125323.17509-2-david@redhat.com>
In-Reply-To: <20201012125323.17509-1-david@redhat.com>
References: <20201012125323.17509-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's determine the target nid only once in case we have none specified -
usually, we'll end up with node 0 either way.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index ba4de598f663..a1f5bf7a571a 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -70,7 +70,7 @@ struct virtio_mem {
 
 	/* The device block size (for communicating with the device). */
 	uint64_t device_block_size;
-	/* The translated node id. NUMA_NO_NODE in case not specified. */
+	/* The determined node id for all memory of the device. */
 	int nid;
 	/* Physical start address of the memory region. */
 	uint64_t addr;
@@ -406,10 +406,6 @@ static int virtio_mem_sb_bitmap_prepare_next_mb(struct virtio_mem *vm)
 static int virtio_mem_mb_add(struct virtio_mem *vm, unsigned long mb_id)
 {
 	const uint64_t addr = virtio_mem_mb_id_to_phys(mb_id);
-	int nid = vm->nid;
-
-	if (nid == NUMA_NO_NODE)
-		nid = memory_add_physaddr_to_nid(addr);
 
 	/*
 	 * When force-unloading the driver and we still have memory added to
@@ -423,7 +419,8 @@ static int virtio_mem_mb_add(struct virtio_mem *vm, unsigned long mb_id)
 	}
 
 	dev_dbg(&vm->vdev->dev, "adding memory block: %lu\n", mb_id);
-	return add_memory_driver_managed(nid, addr, memory_block_size_bytes(),
+	return add_memory_driver_managed(vm->nid, addr,
+					 memory_block_size_bytes(),
 					 vm->resource_name,
 					 MEMHP_MERGE_RESOURCE);
 }
@@ -440,13 +437,9 @@ static int virtio_mem_mb_add(struct virtio_mem *vm, unsigned long mb_id)
 static int virtio_mem_mb_remove(struct virtio_mem *vm, unsigned long mb_id)
 {
 	const uint64_t addr = virtio_mem_mb_id_to_phys(mb_id);
-	int nid = vm->nid;
-
-	if (nid == NUMA_NO_NODE)
-		nid = memory_add_physaddr_to_nid(addr);
 
 	dev_dbg(&vm->vdev->dev, "removing memory block: %lu\n", mb_id);
-	return remove_memory(nid, addr, memory_block_size_bytes());
+	return remove_memory(vm->nid, addr, memory_block_size_bytes());
 }
 
 /*
@@ -461,14 +454,11 @@ static int virtio_mem_mb_offline_and_remove(struct virtio_mem *vm,
 					    unsigned long mb_id)
 {
 	const uint64_t addr = virtio_mem_mb_id_to_phys(mb_id);
-	int nid = vm->nid;
-
-	if (nid == NUMA_NO_NODE)
-		nid = memory_add_physaddr_to_nid(addr);
 
 	dev_dbg(&vm->vdev->dev, "offlining and removing memory block: %lu\n",
 		mb_id);
-	return offline_and_remove_memory(nid, addr, memory_block_size_bytes());
+	return offline_and_remove_memory(vm->nid, addr,
+					 memory_block_size_bytes());
 }
 
 /*
@@ -1659,6 +1649,10 @@ static int virtio_mem_init(struct virtio_mem *vm)
 	virtio_cread_le(vm->vdev, struct virtio_mem_config, region_size,
 			&vm->region_size);
 
+	/* Determine the nid for the device based on the lowest address. */
+	if (vm->nid == NUMA_NO_NODE)
+		vm->nid = memory_add_physaddr_to_nid(vm->addr);
+
 	/*
 	 * We always hotplug memory in memory block granularity. This way,
 	 * we have to wait for exactly one memory block to online.
@@ -1707,7 +1701,7 @@ static int virtio_mem_init(struct virtio_mem *vm)
 		 memory_block_size_bytes());
 	dev_info(&vm->vdev->dev, "subblock size: 0x%llx",
 		 (unsigned long long)vm->subblock_size);
-	if (vm->nid != NUMA_NO_NODE)
+	if (vm->nid != NUMA_NO_NODE && IS_ENABLED(CONFIG_NUMA))
 		dev_info(&vm->vdev->dev, "nid: %d", vm->nid);
 
 	return 0;
-- 
2.26.2

