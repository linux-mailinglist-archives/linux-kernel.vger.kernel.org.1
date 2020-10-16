Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E31AA290055
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 11:00:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394786AbgJPI76 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 04:59:58 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:41488 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2394642AbgJPI75 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 04:59:57 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UCBNCzY_1602838793;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0UCBNCzY_1602838793)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 16 Oct 2020 16:59:54 +0800
Date:   Fri, 16 Oct 2020 16:59:53 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        virtualization@lists.linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Subject: Re: [PATCH v1 23/29] virtio-mem: factor out adding/removing memory
 from Linux
Message-ID: <20201016085953.GF44269@L-31X9LVDL-1304.local>
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20201012125323.17509-1-david@redhat.com>
 <20201012125323.17509-24-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012125323.17509-24-david@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 02:53:17PM +0200, David Hildenbrand wrote:
>Let's use wrappers for the low-level functions that dev_dbg/dev_warn
>and work on addr + size, such that we can reuse them for adding/removing
>in other granularity.
>
>We only warn when adding memory failed, because that's something to pay
>attention to. We won't warn when removing failed, we'll reuse that in
>racy context soon (and we do have proper BUG_ON() statements in the
>current cases where it must never happen).
>
>Cc: "Michael S. Tsirkin" <mst@redhat.com>
>Cc: Jason Wang <jasowang@redhat.com>
>Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
>Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Wei Yang <richard.weiyang@linux.alibaba.com>

>---
> drivers/virtio/virtio_mem.c | 107 ++++++++++++++++++++++++------------
> 1 file changed, 73 insertions(+), 34 deletions(-)
>
>diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
>index d3ab04f655ee..eb2ad31a8d8a 100644
>--- a/drivers/virtio/virtio_mem.c
>+++ b/drivers/virtio/virtio_mem.c
>@@ -453,18 +453,16 @@ static bool virtio_mem_could_add_memory(struct virtio_mem *vm, uint64_t size)
> }
> 
> /*
>- * Try to add a memory block to Linux. This will usually only fail
>- * if out of memory.
>+ * Try adding memory to Linux. Will usually only fail if out of memory.
>  *
>  * Must not be called with the vm->hotplug_mutex held (possible deadlock with
>  * onlining code).
>  *
>- * Will not modify the state of the memory block.
>+ * Will not modify the state of memory blocks in virtio-mem.
>  */
>-static int virtio_mem_mb_add(struct virtio_mem *vm, unsigned long mb_id)
>+static int virtio_mem_add_memory(struct virtio_mem *vm, uint64_t addr,
>+				 uint64_t size)
> {
>-	const uint64_t addr = virtio_mem_mb_id_to_phys(mb_id);
>-	const uint64_t size = memory_block_size_bytes();
> 	int rc;
> 
> 	/*
>@@ -478,32 +476,50 @@ static int virtio_mem_mb_add(struct virtio_mem *vm, unsigned long mb_id)
> 			return -ENOMEM;
> 	}
> 
>-	dev_dbg(&vm->vdev->dev, "adding memory block: %lu\n", mb_id);
>+	dev_dbg(&vm->vdev->dev, "adding memory: 0x%llx - 0x%llx\n", addr,
>+		addr + size - 1);
> 	/* Memory might get onlined immediately. */
> 	atomic64_add(size, &vm->offline_size);
> 	rc = add_memory_driver_managed(vm->nid, addr, size, vm->resource_name,
> 				       MEMHP_MERGE_RESOURCE);
>-	if (rc)
>+	if (rc) {
> 		atomic64_sub(size, &vm->offline_size);
>+		dev_warn(&vm->vdev->dev, "adding memory failed: %d\n", rc);
>+		/*
>+		 * TODO: Linux MM does not properly clean up yet in all cases
>+		 * where adding of memory failed - especially on -ENOMEM.
>+		 */
>+	}
> 	return rc;
> }
> 
> /*
>- * Try to remove a memory block from Linux. Will only fail if the memory block
>- * is not offline.
>+ * See virtio_mem_add_memory(): Try adding a single Linux memory block.
>+ */
>+static int virtio_mem_sbm_add_mb(struct virtio_mem *vm, unsigned long mb_id)
>+{
>+	const uint64_t addr = virtio_mem_mb_id_to_phys(mb_id);
>+	const uint64_t size = memory_block_size_bytes();
>+
>+	return virtio_mem_add_memory(vm, addr, size);
>+}
>+
>+/*
>+ * Try removing memory from Linux. Will only fail if memory blocks aren't
>+ * offline.
>  *
>  * Must not be called with the vm->hotplug_mutex held (possible deadlock with
>  * onlining code).
>  *
>- * Will not modify the state of the memory block.
>+ * Will not modify the state of memory blocks in virtio-mem.
>  */
>-static int virtio_mem_mb_remove(struct virtio_mem *vm, unsigned long mb_id)
>+static int virtio_mem_remove_memory(struct virtio_mem *vm, uint64_t addr,
>+				    uint64_t size)
> {
>-	const uint64_t addr = virtio_mem_mb_id_to_phys(mb_id);
>-	const uint64_t size = memory_block_size_bytes();
> 	int rc;
> 
>-	dev_dbg(&vm->vdev->dev, "removing memory block: %lu\n", mb_id);
>+	dev_dbg(&vm->vdev->dev, "removing memory: 0x%llx - 0x%llx\n", addr,
>+		addr + size - 1);
> 	rc = remove_memory(vm->nid, addr, size);
> 	if (!rc) {
> 		atomic64_sub(size, &vm->offline_size);
>@@ -512,27 +528,41 @@ static int virtio_mem_mb_remove(struct virtio_mem *vm, unsigned long mb_id)
> 		 * immediately instead of waiting.
> 		 */
> 		virtio_mem_retry(vm);
>+	} else {
>+		dev_dbg(&vm->vdev->dev, "removing memory failed: %d\n", rc);
> 	}
> 	return rc;
> }
> 
> /*
>- * Try to offline and remove a memory block from Linux.
>+ * See virtio_mem_remove_memory(): Try removing a single Linux memory block.
>+ */
>+static int virtio_mem_sbm_remove_mb(struct virtio_mem *vm, unsigned long mb_id)
>+{
>+	const uint64_t addr = virtio_mem_mb_id_to_phys(mb_id);
>+	const uint64_t size = memory_block_size_bytes();
>+
>+	return virtio_mem_remove_memory(vm, addr, size);
>+}
>+
>+/*
>+ * Try offlining and removing memory from Linux.
>  *
>  * Must not be called with the vm->hotplug_mutex held (possible deadlock with
>  * onlining code).
>  *
>- * Will not modify the state of the memory block.
>+ * Will not modify the state of memory blocks in virtio-mem.
>  */
>-static int virtio_mem_mb_offline_and_remove(struct virtio_mem *vm,
>-					    unsigned long mb_id)
>+static int virtio_mem_offline_and_remove_memory(struct virtio_mem *vm,
>+						uint64_t addr,
>+						uint64_t size)
> {
>-	const uint64_t addr = virtio_mem_mb_id_to_phys(mb_id);
>-	const uint64_t size = memory_block_size_bytes();
> 	int rc;
> 
>-	dev_dbg(&vm->vdev->dev, "offlining and removing memory block: %lu\n",
>-		mb_id);
>+	dev_dbg(&vm->vdev->dev,
>+		"offlining and removing memory: 0x%llx - 0x%llx\n", addr,
>+		addr + size - 1);
>+
> 	rc = offline_and_remove_memory(vm->nid, addr, size);
> 	if (!rc) {
> 		atomic64_sub(size, &vm->offline_size);
>@@ -541,10 +571,26 @@ static int virtio_mem_mb_offline_and_remove(struct virtio_mem *vm,
> 		 * immediately instead of waiting.
> 		 */
> 		virtio_mem_retry(vm);
>+	} else {
>+		dev_dbg(&vm->vdev->dev,
>+			"offlining and removing memory failed: %d\n", rc);
> 	}
> 	return rc;
> }
> 
>+/*
>+ * See virtio_mem_offline_and_remove_memory(): Try offlining and removing
>+ * a single Linux memory block.
>+ */
>+static int virtio_mem_sbm_offline_and_remove_mb(struct virtio_mem *vm,
>+						unsigned long mb_id)
>+{
>+	const uint64_t addr = virtio_mem_mb_id_to_phys(mb_id);
>+	const uint64_t size = memory_block_size_bytes();
>+
>+	return virtio_mem_offline_and_remove_memory(vm, addr, size);
>+}
>+
> /*
>  * Trigger the workqueue so the device can perform its magic.
>  */
>@@ -1230,17 +1276,10 @@ static int virtio_mem_sbm_plug_and_add_mb(struct virtio_mem *vm,
> 					    VIRTIO_MEM_SBM_MB_OFFLINE_PARTIAL);
> 
> 	/* Add the memory block to linux - if that fails, try to unplug. */
>-	rc = virtio_mem_mb_add(vm, mb_id);
>+	rc = virtio_mem_sbm_add_mb(vm, mb_id);
> 	if (rc) {
> 		int new_state = VIRTIO_MEM_SBM_MB_UNUSED;
> 
>-		dev_err(&vm->vdev->dev,
>-			"adding memory block %lu failed with %d\n", mb_id, rc);
>-
>-		/*
>-		 * TODO: Linux MM does not properly clean up yet in all cases
>-		 * where adding of memory failed - especially on -ENOMEM.
>-		 */
> 		if (virtio_mem_sbm_unplug_sb(vm, mb_id, 0, count))
> 			new_state = VIRTIO_MEM_SBM_MB_PLUGGED;
> 		virtio_mem_sbm_set_mb_state(vm, mb_id, new_state);
>@@ -1411,7 +1450,7 @@ static int virtio_mem_sbm_unplug_any_sb_offline(struct virtio_mem *vm,
> 					    VIRTIO_MEM_SBM_MB_UNUSED);
> 
> 		mutex_unlock(&vm->hotplug_mutex);
>-		rc = virtio_mem_mb_remove(vm, mb_id);
>+		rc = virtio_mem_sbm_remove_mb(vm, mb_id);
> 		BUG_ON(rc);
> 		mutex_lock(&vm->hotplug_mutex);
> 	}
>@@ -1504,7 +1543,7 @@ static int virtio_mem_sbm_unplug_any_sb_online(struct virtio_mem *vm,
> 	 */
> 	if (virtio_mem_sbm_test_sb_unplugged(vm, mb_id, 0, vm->sbm.sbs_per_mb)) {
> 		mutex_unlock(&vm->hotplug_mutex);
>-		rc = virtio_mem_mb_offline_and_remove(vm, mb_id);
>+		rc = virtio_mem_sbm_offline_and_remove_mb(vm, mb_id);
> 		mutex_lock(&vm->hotplug_mutex);
> 		if (!rc)
> 			virtio_mem_sbm_set_mb_state(vm, mb_id,
>@@ -1991,7 +2030,7 @@ static void virtio_mem_remove(struct virtio_device *vdev)
> 	 */
> 	virtio_mem_sbm_for_each_mb(vm, mb_id,
> 				   VIRTIO_MEM_SBM_MB_OFFLINE_PARTIAL) {
>-		rc = virtio_mem_mb_remove(vm, mb_id);
>+		rc = virtio_mem_sbm_remove_mb(vm, mb_id);
> 		BUG_ON(rc);
> 		virtio_mem_sbm_set_mb_state(vm, mb_id,
> 					    VIRTIO_MEM_SBM_MB_UNUSED);
>-- 
>2.26.2

-- 
Wei Yang
Help you, Help me
