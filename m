Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15F7B2B06B6
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 14:39:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbgKLNjX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 08:39:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51603 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728460AbgKLNjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 08:39:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605188356;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z2DDCEYotCg7CrVvT/pYKCd57AzkAB9uXuuvCbRMSt0=;
        b=GG15zZfZsEoMOOglm3uDkVuU+twcWH9KXX+Y58R/K5/cFYycaDrV+3I/Eli6z6IrVWg6/q
        xZVVeoyFgmBy0gvr+mnGh7QDDUcf4dqXyKxiy+im25R4zhVI0/XLRlTuJbIh3ROW/81KB9
        2XOGawqhDLmbmf3ZSC3RBdQSCAbQls4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-N5B35TAoNlmANoPW33Xcrw-1; Thu, 12 Nov 2020 08:39:12 -0500
X-MC-Unique: N5B35TAoNlmANoPW33Xcrw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 53F41CE649;
        Thu, 12 Nov 2020 13:39:11 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-115-61.ams2.redhat.com [10.36.115.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C5EA875132;
        Thu, 12 Nov 2020 13:39:09 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        "Michael S . Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Subject: [PATCH v2 16/29] virtio-mem: generalize handling when memory is getting onlined deferred
Date:   Thu, 12 Nov 2020 14:38:02 +0100
Message-Id: <20201112133815.13332-17-david@redhat.com>
In-Reply-To: <20201112133815.13332-1-david@redhat.com>
References: <20201112133815.13332-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We don't want to add too much memory when it's not getting onlined
immediately, to avoid running OOM. Generalize the handling, to avoid
making use of memory block states. Use a threshold of 1 GiB for now.

Properly adjust the offline size when adding/removing memory. As we are
not always protected by a lock when touching the offline size, use an
atomic64_t. We don't care about races (e.g., someone offlining memory
while we are adding more), only about consistent values.

(1 GiB needs a memmap of ~16MiB - which sounds reasonable even for
 setups with little boot memory and (possibly) one virtio-mem device per
 node)

We don't want to retrigger when onlining is caused immediately by our
action (e.g., adding memory which immediately gets onlined), so use a
flag to indicate if the workqueue is active and use that as an
indicator whether to trigger a retry. This will also be especially relevant
for Big Block Mode (BBM), whereby we might re-online memory in case
offlining of another memory block failed.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 95 ++++++++++++++++++++++++-------------
 1 file changed, 63 insertions(+), 32 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index f86654af8b6b..cbd0aa5eb95c 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -51,6 +51,7 @@ struct virtio_mem {
 
 	/* Workqueue that processes the plug/unplug requests. */
 	struct work_struct wq;
+	atomic_t wq_active;
 	atomic_t config_changed;
 
 	/* Virtqueue for guest->host requests. */
@@ -99,7 +100,15 @@ struct virtio_mem {
 
 	/* Summary of all memory block states. */
 	unsigned long nb_mb_state[VIRTIO_MEM_MB_STATE_COUNT];
-#define VIRTIO_MEM_NB_OFFLINE_THRESHOLD		10
+
+	/*
+	 * We don't want to add too much memory if it's not getting onlined,
+	 * to avoid running OOM. Besides this threshold, we allow to have at
+	 * least two offline blocks at a time (whatever is bigger).
+	 */
+#define VIRTIO_MEM_DEFAULT_OFFLINE_THRESHOLD		(1024 * 1024 * 1024)
+	atomic64_t offline_size;
+	uint64_t offline_threshold;
 
 	/*
 	 * One byte state per memory block.
@@ -405,6 +414,18 @@ static int virtio_mem_sb_bitmap_prepare_next_mb(struct virtio_mem *vm)
 	return 0;
 }
 
+/*
+ * Test if we could add memory without creating too much offline memory -
+ * to avoid running OOM if memory is getting onlined deferred.
+ */
+static bool virtio_mem_could_add_memory(struct virtio_mem *vm, uint64_t size)
+{
+	if (WARN_ON_ONCE(size > vm->offline_threshold))
+		return false;
+
+	return atomic64_read(&vm->offline_size) + size <= vm->offline_threshold;
+}
+
 /*
  * Try to add a memory block to Linux. This will usually only fail
  * if out of memory.
@@ -417,6 +438,8 @@ static int virtio_mem_sb_bitmap_prepare_next_mb(struct virtio_mem *vm)
 static int virtio_mem_mb_add(struct virtio_mem *vm, unsigned long mb_id)
 {
 	const uint64_t addr = virtio_mem_mb_id_to_phys(mb_id);
+	const uint64_t size = memory_block_size_bytes();
+	int rc;
 
 	/*
 	 * When force-unloading the driver and we still have memory added to
@@ -430,10 +453,13 @@ static int virtio_mem_mb_add(struct virtio_mem *vm, unsigned long mb_id)
 	}
 
 	dev_dbg(&vm->vdev->dev, "adding memory block: %lu\n", mb_id);
-	return add_memory_driver_managed(vm->nid, addr,
-					 memory_block_size_bytes(),
-					 vm->resource_name,
-					 MEMHP_MERGE_RESOURCE);
+	/* Memory might get onlined immediately. */
+	atomic64_add(size, &vm->offline_size);
+	rc = add_memory_driver_managed(vm->nid, addr, size, vm->resource_name,
+				       MEMHP_MERGE_RESOURCE);
+	if (rc)
+		atomic64_sub(size, &vm->offline_size);
+	return rc;
 }
 
 /*
@@ -448,16 +474,19 @@ static int virtio_mem_mb_add(struct virtio_mem *vm, unsigned long mb_id)
 static int virtio_mem_mb_remove(struct virtio_mem *vm, unsigned long mb_id)
 {
 	const uint64_t addr = virtio_mem_mb_id_to_phys(mb_id);
+	const uint64_t size = memory_block_size_bytes();
 	int rc;
 
 	dev_dbg(&vm->vdev->dev, "removing memory block: %lu\n", mb_id);
-	rc = remove_memory(vm->nid, addr, memory_block_size_bytes());
-	if (!rc)
+	rc = remove_memory(vm->nid, addr, size);
+	if (!rc) {
+		atomic64_sub(size, &vm->offline_size);
 		/*
 		 * We might have freed up memory we can now unplug, retry
 		 * immediately instead of waiting.
 		 */
 		virtio_mem_retry(vm);
+	}
 	return rc;
 }
 
@@ -473,18 +502,20 @@ static int virtio_mem_mb_offline_and_remove(struct virtio_mem *vm,
 					    unsigned long mb_id)
 {
 	const uint64_t addr = virtio_mem_mb_id_to_phys(mb_id);
+	const uint64_t size = memory_block_size_bytes();
 	int rc;
 
 	dev_dbg(&vm->vdev->dev, "offlining and removing memory block: %lu\n",
 		mb_id);
-	rc = offline_and_remove_memory(vm->nid, addr,
-				       memory_block_size_bytes());
-	if (!rc)
+	rc = offline_and_remove_memory(vm->nid, addr, size);
+	if (!rc) {
+		atomic64_sub(size, &vm->offline_size);
 		/*
 		 * We might have freed up memory we can now unplug, retry
 		 * immediately instead of waiting.
 		 */
 		virtio_mem_retry(vm);
+	}
 	return rc;
 }
 
@@ -567,8 +598,6 @@ static void virtio_mem_notify_offline(struct virtio_mem *vm,
 
 static void virtio_mem_notify_online(struct virtio_mem *vm, unsigned long mb_id)
 {
-	unsigned long nb_offline;
-
 	switch (virtio_mem_mb_get_state(vm, mb_id)) {
 	case VIRTIO_MEM_MB_STATE_OFFLINE_PARTIAL:
 		virtio_mem_mb_set_state(vm, mb_id,
@@ -581,12 +610,6 @@ static void virtio_mem_notify_online(struct virtio_mem *vm, unsigned long mb_id)
 		BUG();
 		break;
 	}
-	nb_offline = vm->nb_mb_state[VIRTIO_MEM_MB_STATE_OFFLINE] +
-		     vm->nb_mb_state[VIRTIO_MEM_MB_STATE_OFFLINE_PARTIAL];
-
-	/* see if we can add new blocks now that we onlined one block */
-	if (nb_offline == VIRTIO_MEM_NB_OFFLINE_THRESHOLD - 1)
-		virtio_mem_retry(vm);
 }
 
 static void virtio_mem_notify_going_offline(struct virtio_mem *vm,
@@ -681,6 +704,7 @@ static int virtio_mem_memory_notifier_cb(struct notifier_block *nb,
 	case MEM_OFFLINE:
 		virtio_mem_notify_offline(vm, mb_id);
 
+		atomic64_add(size, &vm->offline_size);
 		/*
 		 * Trigger the workqueue. Now that we have some offline memory,
 		 * maybe we can handle pending unplug requests.
@@ -693,6 +717,18 @@ static int virtio_mem_memory_notifier_cb(struct notifier_block *nb,
 		break;
 	case MEM_ONLINE:
 		virtio_mem_notify_online(vm, mb_id);
+
+		atomic64_sub(size, &vm->offline_size);
+		/*
+		 * Start adding more memory once we onlined half of our
+		 * threshold. Don't trigger if it's possibly due to our actipn
+		 * (e.g., us adding memory which gets onlined immediately from
+		 * the core).
+		 */
+		if (!atomic_read(&vm->wq_active) &&
+		    virtio_mem_could_add_memory(vm, vm->offline_threshold / 2))
+			virtio_mem_retry(vm);
+
 		vm->hotplug_active = false;
 		mutex_unlock(&vm->hotplug_mutex);
 		break;
@@ -1151,18 +1187,6 @@ static int virtio_mem_prepare_next_mb(struct virtio_mem *vm,
 	return 0;
 }
 
-/*
- * Don't add too many blocks that are not onlined yet to avoid running OOM.
- */
-static bool virtio_mem_too_many_mb_offline(struct virtio_mem *vm)
-{
-	unsigned long nb_offline;
-
-	nb_offline = vm->nb_mb_state[VIRTIO_MEM_MB_STATE_OFFLINE] +
-		     vm->nb_mb_state[VIRTIO_MEM_MB_STATE_OFFLINE_PARTIAL];
-	return nb_offline >= VIRTIO_MEM_NB_OFFLINE_THRESHOLD;
-}
-
 /*
  * Try to plug the desired number of subblocks and add the memory block
  * to Linux.
@@ -1316,7 +1340,7 @@ static int virtio_mem_plug_request(struct virtio_mem *vm, uint64_t diff)
 
 	/* Try to plug and add unused blocks */
 	virtio_mem_for_each_mb_state(vm, mb_id, VIRTIO_MEM_MB_STATE_UNUSED) {
-		if (virtio_mem_too_many_mb_offline(vm))
+		if (!virtio_mem_could_add_memory(vm, memory_block_size_bytes()))
 			return -ENOSPC;
 
 		rc = virtio_mem_mb_plug_and_add(vm, mb_id, &nb_sb);
@@ -1327,7 +1351,7 @@ static int virtio_mem_plug_request(struct virtio_mem *vm, uint64_t diff)
 
 	/* Try to prepare, plug and add new blocks */
 	while (nb_sb) {
-		if (virtio_mem_too_many_mb_offline(vm))
+		if (!virtio_mem_could_add_memory(vm, memory_block_size_bytes()))
 			return -ENOSPC;
 
 		rc = virtio_mem_prepare_next_mb(vm, &mb_id);
@@ -1620,6 +1644,7 @@ static void virtio_mem_run_wq(struct work_struct *work)
 	if (vm->broken)
 		return;
 
+	atomic_set(&vm->wq_active, 1);
 retry:
 	rc = 0;
 
@@ -1680,6 +1705,8 @@ static void virtio_mem_run_wq(struct work_struct *work)
 			"unknown error, marking device broken: %d\n", rc);
 		vm->broken = true;
 	}
+
+	atomic_set(&vm->wq_active, 0);
 }
 
 static enum hrtimer_restart virtio_mem_timer_expired(struct hrtimer *timer)
@@ -1788,6 +1815,10 @@ static int virtio_mem_init(struct virtio_mem *vm)
 						   memory_block_size_bytes());
 	vm->next_mb_id = vm->first_mb_id;
 
+	/* Prepare the offline threshold - make sure we can add two blocks. */
+	vm->offline_threshold = max_t(uint64_t, 2 * memory_block_size_bytes(),
+				      VIRTIO_MEM_DEFAULT_OFFLINE_THRESHOLD);
+
 	dev_info(&vm->vdev->dev, "start address: 0x%llx", vm->addr);
 	dev_info(&vm->vdev->dev, "region size: 0x%llx", vm->region_size);
 	dev_info(&vm->vdev->dev, "device block size: 0x%llx",
-- 
2.26.2

