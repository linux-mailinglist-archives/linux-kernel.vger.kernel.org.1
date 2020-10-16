Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73C3029000C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 10:40:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394677AbgJPIkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 04:40:21 -0400
Received: from out30-56.freemail.mail.aliyun.com ([115.124.30.56]:37398 "EHLO
        out30-56.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2394468AbgJPIkU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 04:40:20 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0UCBd4n4_1602837612;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0UCBd4n4_1602837612)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 16 Oct 2020 16:40:13 +0800
Date:   Fri, 16 Oct 2020 16:40:12 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        virtualization@lists.linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Subject: Re: [PATCH v1 16/29] virtio-mem: memory block states are specific to
 Sub Block Mode (SBM)
Message-ID: <20201016084012.GO86495@L-31X9LVDL-1304.local>
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20201012125323.17509-1-david@redhat.com>
 <20201012125323.17509-17-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012125323.17509-17-david@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 02:53:10PM +0200, David Hildenbrand wrote:
>let's use a new "sbm" sub-struct to hold SBM-specific state and rename +
>move applicable definitions, frunctions, and variables (related to
>memory block states).
>
>While at it:
>- Drop the "_STATE" part from memory block states
>- Rename "nb_mb_state" to "mb_count"
>- "set_mb_state" / "get_mb_state" vs. "mb_set_state" / "mb_get_state"
>- Don't use lengthy "enum virtio_mem_smb_mb_state", simply use "uint8_t"
>
>Cc: "Michael S. Tsirkin" <mst@redhat.com>
>Cc: Jason Wang <jasowang@redhat.com>
>Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
>Signed-off-by: David Hildenbrand <david@redhat.com>
>---
> drivers/virtio/virtio_mem.c | 215 ++++++++++++++++++------------------
> 1 file changed, 109 insertions(+), 106 deletions(-)
>
>diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
>index fd8685673fe4..e76d6f769aa5 100644
>--- a/drivers/virtio/virtio_mem.c
>+++ b/drivers/virtio/virtio_mem.c
>@@ -42,20 +42,23 @@ MODULE_PARM_DESC(unplug_online, "Try to unplug online memory");
>  * onlined to the same zone - virtio-mem relies on this behavior.
>  */
> 
>-enum virtio_mem_mb_state {
>+/*
>+ * State of a Linux memory block in SBM.
>+ */
>+enum virtio_mem_sbm_mb_state {
> 	/* Unplugged, not added to Linux. Can be reused later. */
>-	VIRTIO_MEM_MB_STATE_UNUSED = 0,
>+	VIRTIO_MEM_SBM_MB_UNUSED = 0,
> 	/* (Partially) plugged, not added to Linux. Error on add_memory(). */
>-	VIRTIO_MEM_MB_STATE_PLUGGED,
>+	VIRTIO_MEM_SBM_MB_PLUGGED,
> 	/* Fully plugged, fully added to Linux, offline. */
>-	VIRTIO_MEM_MB_STATE_OFFLINE,
>+	VIRTIO_MEM_SBM_MB_OFFLINE,
> 	/* Partially plugged, fully added to Linux, offline. */
>-	VIRTIO_MEM_MB_STATE_OFFLINE_PARTIAL,
>+	VIRTIO_MEM_SBM_MB_OFFLINE_PARTIAL,
> 	/* Fully plugged, fully added to Linux, online. */
>-	VIRTIO_MEM_MB_STATE_ONLINE,
>+	VIRTIO_MEM_SBM_MB_ONLINE,
> 	/* Partially plugged, fully added to Linux, online. */
>-	VIRTIO_MEM_MB_STATE_ONLINE_PARTIAL,
>-	VIRTIO_MEM_MB_STATE_COUNT
>+	VIRTIO_MEM_SBM_MB_ONLINE_PARTIAL,
>+	VIRTIO_MEM_SBM_MB_COUNT
> };
> 
> struct virtio_mem {
>@@ -113,9 +116,6 @@ struct virtio_mem {
> 	 */
> 	const char *resource_name;
> 
>-	/* Summary of all memory block states. */
>-	unsigned long nb_mb_state[VIRTIO_MEM_MB_STATE_COUNT];
>-
> 	/*
> 	 * We don't want to add too much memory if it's not getting onlined,
> 	 * to avoid running OOM. Besides this threshold, we allow to have at
>@@ -125,27 +125,29 @@ struct virtio_mem {
> 	atomic64_t offline_size;
> 	uint64_t offline_threshold;
> 
>-	/*
>-	 * One byte state per memory block.
>-	 *
>-	 * Allocated via vmalloc(). When preparing new blocks, resized
>-	 * (alloc+copy+free) when needed (crossing pages with the next mb).
>-	 * (when crossing pages).
>-	 *
>-	 * With 128MB memory blocks, we have states for 512GB of memory in one
>-	 * page.
>-	 */
>-	uint8_t *mb_state;
>+	struct {
>+		/* Summary of all memory block states. */
>+		unsigned long mb_count[VIRTIO_MEM_SBM_MB_COUNT];
>+
>+		/*
>+		 * One byte state per memory block. Allocated via vmalloc().
>+		 * Resized (alloc+copy+free) on demand.
>+		 *
>+		 * With 128 MiB memory blocks, we have states for 512 GiB of
>+		 * memory in one 4 KiB page.
>+		 */
>+		uint8_t *mb_states;
>+	} sbm;
> 
> 	/*
>-	 * $nb_sb_per_mb bit per memory block. Handled similar to mb_state.
>+	 * $nb_sb_per_mb bit per memory block. Handled similar to sbm.mb_states.
> 	 *
> 	 * With 4MB subblocks, we manage 128GB of memory in one page.
> 	 */
> 	unsigned long *sb_bitmap;

Why not include this into sbm? As I expect this is not necessary for BBM.

> 
> 	/*
>-	 * Mutex that protects the nb_mb_state, mb_state, and sb_bitmap.
>+	 * Mutex that protects the sbm.mb_count, sbm.mb_states, and sb_bitmap.
> 	 *
> 	 * When this lock is held the pointers can't change, ONLINE and
> 	 * OFFLINE blocks can't change the state and no subblocks will get
>@@ -254,70 +256,70 @@ static unsigned long virtio_mem_phys_to_sb_id(struct virtio_mem *vm,
> /*
>  * Set the state of a memory block, taking care of the state counter.
>  */
>-static void virtio_mem_mb_set_state(struct virtio_mem *vm, unsigned long mb_id,
>-				    enum virtio_mem_mb_state state)
>+static void virtio_mem_sbm_set_mb_state(struct virtio_mem *vm,
>+					unsigned long mb_id, uint8_t state)
> {
> 	const unsigned long idx = mb_id - vm->first_mb_id;
>-	enum virtio_mem_mb_state old_state;
>+	uint8_t old_state;
> 
>-	old_state = vm->mb_state[idx];
>-	vm->mb_state[idx] = state;
>+	old_state = vm->sbm.mb_states[idx];
>+	vm->sbm.mb_states[idx] = state;
> 
>-	BUG_ON(vm->nb_mb_state[old_state] == 0);
>-	vm->nb_mb_state[old_state]--;
>-	vm->nb_mb_state[state]++;
>+	BUG_ON(vm->sbm.mb_count[old_state] == 0);
>+	vm->sbm.mb_count[old_state]--;
>+	vm->sbm.mb_count[state]++;
> }
> 
> /*
>  * Get the state of a memory block.
>  */
>-static enum virtio_mem_mb_state virtio_mem_mb_get_state(struct virtio_mem *vm,
>-							unsigned long mb_id)
>+static uint8_t virtio_mem_sbm_get_mb_state(struct virtio_mem *vm,
>+					   unsigned long mb_id)
> {
> 	const unsigned long idx = mb_id - vm->first_mb_id;
> 
>-	return vm->mb_state[idx];
>+	return vm->sbm.mb_states[idx];
> }
> 
> /*
>  * Prepare the state array for the next memory block.
>  */
>-static int virtio_mem_mb_state_prepare_next_mb(struct virtio_mem *vm)
>+static int virtio_mem_sbm_mb_states_prepare_next_mb(struct virtio_mem *vm)
> {
> 	unsigned long old_bytes = vm->next_mb_id - vm->first_mb_id;
> 	unsigned long new_bytes = old_bytes + 1;
> 	int old_pages = PFN_UP(old_bytes);
> 	int new_pages = PFN_UP(new_bytes);
>-	uint8_t *new_mb_state;
>+	uint8_t *new_array;
> 
>-	if (vm->mb_state && old_pages == new_pages)
>+	if (vm->sbm.mb_states && old_pages == new_pages)
> 		return 0;
> 
>-	new_mb_state = vzalloc(new_pages * PAGE_SIZE);
>-	if (!new_mb_state)
>+	new_array = vzalloc(new_pages * PAGE_SIZE);
>+	if (!new_array)
> 		return -ENOMEM;
> 
> 	mutex_lock(&vm->hotplug_mutex);
>-	if (vm->mb_state)
>-		memcpy(new_mb_state, vm->mb_state, old_pages * PAGE_SIZE);
>-	vfree(vm->mb_state);
>-	vm->mb_state = new_mb_state;
>+	if (vm->sbm.mb_states)
>+		memcpy(new_array, vm->sbm.mb_states, old_pages * PAGE_SIZE);
>+	vfree(vm->sbm.mb_states);
>+	vm->sbm.mb_states = new_array;
> 	mutex_unlock(&vm->hotplug_mutex);
> 
> 	return 0;
> }
> 
>-#define virtio_mem_for_each_mb_state(_vm, _mb_id, _state) \
>+#define virtio_mem_sbm_for_each_mb(_vm, _mb_id, _state) \
> 	for (_mb_id = _vm->first_mb_id; \
>-	     _mb_id < _vm->next_mb_id && _vm->nb_mb_state[_state]; \
>+	     _mb_id < _vm->next_mb_id && _vm->sbm.mb_count[_state]; \
> 	     _mb_id++) \
>-		if (virtio_mem_mb_get_state(_vm, _mb_id) == _state)
>+		if (virtio_mem_sbm_get_mb_state(_vm, _mb_id) == _state)
> 
>-#define virtio_mem_for_each_mb_state_rev(_vm, _mb_id, _state) \
>+#define virtio_mem_sbm_for_each_mb_rev(_vm, _mb_id, _state) \
> 	for (_mb_id = _vm->next_mb_id - 1; \
>-	     _mb_id >= _vm->first_mb_id && _vm->nb_mb_state[_state]; \
>+	     _mb_id >= _vm->first_mb_id && _vm->sbm.mb_count[_state]; \
> 	     _mb_id--) \
>-		if (virtio_mem_mb_get_state(_vm, _mb_id) == _state)
>+		if (virtio_mem_sbm_get_mb_state(_vm, _mb_id) == _state)
> 
> /*
>  * Mark all selected subblocks plugged.
>@@ -573,9 +575,9 @@ static bool virtio_mem_contains_range(struct virtio_mem *vm, uint64_t start,
> static int virtio_mem_notify_going_online(struct virtio_mem *vm,
> 					  unsigned long mb_id)
> {
>-	switch (virtio_mem_mb_get_state(vm, mb_id)) {
>-	case VIRTIO_MEM_MB_STATE_OFFLINE_PARTIAL:
>-	case VIRTIO_MEM_MB_STATE_OFFLINE:
>+	switch (virtio_mem_sbm_get_mb_state(vm, mb_id)) {
>+	case VIRTIO_MEM_SBM_MB_OFFLINE_PARTIAL:
>+	case VIRTIO_MEM_SBM_MB_OFFLINE:
> 		return NOTIFY_OK;
> 	default:
> 		break;
>@@ -588,14 +590,14 @@ static int virtio_mem_notify_going_online(struct virtio_mem *vm,
> static void virtio_mem_notify_offline(struct virtio_mem *vm,
> 				      unsigned long mb_id)
> {
>-	switch (virtio_mem_mb_get_state(vm, mb_id)) {
>-	case VIRTIO_MEM_MB_STATE_ONLINE_PARTIAL:
>-		virtio_mem_mb_set_state(vm, mb_id,
>-					VIRTIO_MEM_MB_STATE_OFFLINE_PARTIAL);
>+	switch (virtio_mem_sbm_get_mb_state(vm, mb_id)) {
>+	case VIRTIO_MEM_SBM_MB_ONLINE_PARTIAL:
>+		virtio_mem_sbm_set_mb_state(vm, mb_id,
>+					    VIRTIO_MEM_SBM_MB_OFFLINE_PARTIAL);
> 		break;
>-	case VIRTIO_MEM_MB_STATE_ONLINE:
>-		virtio_mem_mb_set_state(vm, mb_id,
>-					VIRTIO_MEM_MB_STATE_OFFLINE);
>+	case VIRTIO_MEM_SBM_MB_ONLINE:
>+		virtio_mem_sbm_set_mb_state(vm, mb_id,
>+					    VIRTIO_MEM_SBM_MB_OFFLINE);
> 		break;
> 	default:
> 		BUG();
>@@ -605,13 +607,14 @@ static void virtio_mem_notify_offline(struct virtio_mem *vm,
> 
> static void virtio_mem_notify_online(struct virtio_mem *vm, unsigned long mb_id)
> {
>-	switch (virtio_mem_mb_get_state(vm, mb_id)) {
>-	case VIRTIO_MEM_MB_STATE_OFFLINE_PARTIAL:
>-		virtio_mem_mb_set_state(vm, mb_id,
>-					VIRTIO_MEM_MB_STATE_ONLINE_PARTIAL);
>+	switch (virtio_mem_sbm_get_mb_state(vm, mb_id)) {
>+	case VIRTIO_MEM_SBM_MB_OFFLINE_PARTIAL:
>+		virtio_mem_sbm_set_mb_state(vm, mb_id,
>+					VIRTIO_MEM_SBM_MB_ONLINE_PARTIAL);
> 		break;
>-	case VIRTIO_MEM_MB_STATE_OFFLINE:
>-		virtio_mem_mb_set_state(vm, mb_id, VIRTIO_MEM_MB_STATE_ONLINE);
>+	case VIRTIO_MEM_SBM_MB_OFFLINE:
>+		virtio_mem_sbm_set_mb_state(vm, mb_id,
>+					    VIRTIO_MEM_SBM_MB_ONLINE);
> 		break;
> 	default:
> 		BUG();
>@@ -1160,7 +1163,7 @@ static int virtio_mem_prepare_next_mb(struct virtio_mem *vm,
> 		return -ENOSPC;
> 
> 	/* Resize the state array if required. */
>-	rc = virtio_mem_mb_state_prepare_next_mb(vm);
>+	rc = virtio_mem_sbm_mb_states_prepare_next_mb(vm);
> 	if (rc)
> 		return rc;
> 
>@@ -1169,7 +1172,7 @@ static int virtio_mem_prepare_next_mb(struct virtio_mem *vm,
> 	if (rc)
> 		return rc;
> 
>-	vm->nb_mb_state[VIRTIO_MEM_MB_STATE_UNUSED]++;
>+	vm->sbm.mb_count[VIRTIO_MEM_SBM_MB_UNUSED]++;
> 	*mb_id = vm->next_mb_id++;
> 	return 0;
> }
>@@ -1203,16 +1206,16 @@ static int virtio_mem_mb_plug_and_add(struct virtio_mem *vm,
> 	 * so the memory notifiers will find the block in the right state.
> 	 */
> 	if (count == vm->nb_sb_per_mb)
>-		virtio_mem_mb_set_state(vm, mb_id,
>-					VIRTIO_MEM_MB_STATE_OFFLINE);
>+		virtio_mem_sbm_set_mb_state(vm, mb_id,
>+					    VIRTIO_MEM_SBM_MB_OFFLINE);
> 	else
>-		virtio_mem_mb_set_state(vm, mb_id,
>-					VIRTIO_MEM_MB_STATE_OFFLINE_PARTIAL);
>+		virtio_mem_sbm_set_mb_state(vm, mb_id,
>+					    VIRTIO_MEM_SBM_MB_OFFLINE_PARTIAL);
> 
> 	/* Add the memory block to linux - if that fails, try to unplug. */
> 	rc = virtio_mem_mb_add(vm, mb_id);
> 	if (rc) {
>-		enum virtio_mem_mb_state new_state = VIRTIO_MEM_MB_STATE_UNUSED;
>+		int new_state = VIRTIO_MEM_SBM_MB_UNUSED;
> 
> 		dev_err(&vm->vdev->dev,
> 			"adding memory block %lu failed with %d\n", mb_id, rc);
>@@ -1222,8 +1225,8 @@ static int virtio_mem_mb_plug_and_add(struct virtio_mem *vm,
> 		 * where adding of memory failed - especially on -ENOMEM.
> 		 */
> 		if (virtio_mem_mb_unplug_sb(vm, mb_id, 0, count))
>-			new_state = VIRTIO_MEM_MB_STATE_PLUGGED;
>-		virtio_mem_mb_set_state(vm, mb_id, new_state);
>+			new_state = VIRTIO_MEM_SBM_MB_PLUGGED;
>+		virtio_mem_sbm_set_mb_state(vm, mb_id, new_state);
> 		return rc;
> 	}
> 
>@@ -1276,11 +1279,11 @@ static int virtio_mem_mb_plug_any_sb(struct virtio_mem *vm, unsigned long mb_id,
> 
> 	if (virtio_mem_mb_test_sb_plugged(vm, mb_id, 0, vm->nb_sb_per_mb)) {
> 		if (online)
>-			virtio_mem_mb_set_state(vm, mb_id,
>-						VIRTIO_MEM_MB_STATE_ONLINE);
>+			virtio_mem_sbm_set_mb_state(vm, mb_id,
>+						    VIRTIO_MEM_SBM_MB_ONLINE);
> 		else
>-			virtio_mem_mb_set_state(vm, mb_id,
>-						VIRTIO_MEM_MB_STATE_OFFLINE);
>+			virtio_mem_sbm_set_mb_state(vm, mb_id,
>+						    VIRTIO_MEM_SBM_MB_OFFLINE);
> 	}
> 
> 	return 0;
>@@ -1302,8 +1305,8 @@ static int virtio_mem_plug_request(struct virtio_mem *vm, uint64_t diff)
> 	mutex_lock(&vm->hotplug_mutex);
> 
> 	/* Try to plug subblocks of partially plugged online blocks. */
>-	virtio_mem_for_each_mb_state(vm, mb_id,
>-				     VIRTIO_MEM_MB_STATE_ONLINE_PARTIAL) {
>+	virtio_mem_sbm_for_each_mb(vm, mb_id,
>+				   VIRTIO_MEM_SBM_MB_ONLINE_PARTIAL) {
> 		rc = virtio_mem_mb_plug_any_sb(vm, mb_id, &nb_sb, true);
> 		if (rc || !nb_sb)
> 			goto out_unlock;
>@@ -1311,8 +1314,8 @@ static int virtio_mem_plug_request(struct virtio_mem *vm, uint64_t diff)
> 	}
> 
> 	/* Try to plug subblocks of partially plugged offline blocks. */
>-	virtio_mem_for_each_mb_state(vm, mb_id,
>-				     VIRTIO_MEM_MB_STATE_OFFLINE_PARTIAL) {
>+	virtio_mem_sbm_for_each_mb(vm, mb_id,
>+				   VIRTIO_MEM_SBM_MB_OFFLINE_PARTIAL) {
> 		rc = virtio_mem_mb_plug_any_sb(vm, mb_id, &nb_sb, false);
> 		if (rc || !nb_sb)
> 			goto out_unlock;
>@@ -1326,7 +1329,7 @@ static int virtio_mem_plug_request(struct virtio_mem *vm, uint64_t diff)
> 	mutex_unlock(&vm->hotplug_mutex);
> 
> 	/* Try to plug and add unused blocks */
>-	virtio_mem_for_each_mb_state(vm, mb_id, VIRTIO_MEM_MB_STATE_UNUSED) {
>+	virtio_mem_sbm_for_each_mb(vm, mb_id, VIRTIO_MEM_SBM_MB_UNUSED) {
> 		if (!virtio_mem_could_add_memory(vm, memory_block_size_bytes()))
> 			return -ENOSPC;
> 
>@@ -1375,8 +1378,8 @@ static int virtio_mem_mb_unplug_any_sb_offline(struct virtio_mem *vm,
> 
> 	/* some subblocks might have been unplugged even on failure */
> 	if (!virtio_mem_mb_test_sb_plugged(vm, mb_id, 0, vm->nb_sb_per_mb))
>-		virtio_mem_mb_set_state(vm, mb_id,
>-					VIRTIO_MEM_MB_STATE_OFFLINE_PARTIAL);
>+		virtio_mem_sbm_set_mb_state(vm, mb_id,
>+					    VIRTIO_MEM_SBM_MB_OFFLINE_PARTIAL);
> 	if (rc)
> 		return rc;
> 
>@@ -1387,8 +1390,8 @@ static int virtio_mem_mb_unplug_any_sb_offline(struct virtio_mem *vm,
> 		 * unplugged. Temporarily drop the mutex, so
> 		 * any pending GOING_ONLINE requests can be serviced/rejected.
> 		 */
>-		virtio_mem_mb_set_state(vm, mb_id,
>-					VIRTIO_MEM_MB_STATE_UNUSED);
>+		virtio_mem_sbm_set_mb_state(vm, mb_id,
>+					    VIRTIO_MEM_SBM_MB_UNUSED);
> 
> 		mutex_unlock(&vm->hotplug_mutex);
> 		rc = virtio_mem_mb_remove(vm, mb_id);
>@@ -1426,8 +1429,8 @@ static int virtio_mem_mb_unplug_sb_online(struct virtio_mem *vm,
> 		return rc;
> 	}
> 
>-	virtio_mem_mb_set_state(vm, mb_id,
>-				VIRTIO_MEM_MB_STATE_ONLINE_PARTIAL);
>+	virtio_mem_sbm_set_mb_state(vm, mb_id,
>+				    VIRTIO_MEM_SBM_MB_ONLINE_PARTIAL);
> 	return 0;
> }
> 
>@@ -1487,8 +1490,8 @@ static int virtio_mem_mb_unplug_any_sb_online(struct virtio_mem *vm,
> 		rc = virtio_mem_mb_offline_and_remove(vm, mb_id);
> 		mutex_lock(&vm->hotplug_mutex);
> 		if (!rc)
>-			virtio_mem_mb_set_state(vm, mb_id,
>-						VIRTIO_MEM_MB_STATE_UNUSED);
>+			virtio_mem_sbm_set_mb_state(vm, mb_id,
>+						    VIRTIO_MEM_SBM_MB_UNUSED);
> 	}
> 
> 	return 0;
>@@ -1514,8 +1517,8 @@ static int virtio_mem_unplug_request(struct virtio_mem *vm, uint64_t diff)
> 	mutex_lock(&vm->hotplug_mutex);
> 
> 	/* Try to unplug subblocks of partially plugged offline blocks. */
>-	virtio_mem_for_each_mb_state_rev(vm, mb_id,
>-					 VIRTIO_MEM_MB_STATE_OFFLINE_PARTIAL) {
>+	virtio_mem_sbm_for_each_mb_rev(vm, mb_id,
>+				       VIRTIO_MEM_SBM_MB_OFFLINE_PARTIAL) {
> 		rc = virtio_mem_mb_unplug_any_sb_offline(vm, mb_id,
> 							 &nb_sb);
> 		if (rc || !nb_sb)
>@@ -1524,8 +1527,7 @@ static int virtio_mem_unplug_request(struct virtio_mem *vm, uint64_t diff)
> 	}
> 
> 	/* Try to unplug subblocks of plugged offline blocks. */
>-	virtio_mem_for_each_mb_state_rev(vm, mb_id,
>-					 VIRTIO_MEM_MB_STATE_OFFLINE) {
>+	virtio_mem_sbm_for_each_mb_rev(vm, mb_id, VIRTIO_MEM_SBM_MB_OFFLINE) {
> 		rc = virtio_mem_mb_unplug_any_sb_offline(vm, mb_id,
> 							 &nb_sb);
> 		if (rc || !nb_sb)
>@@ -1539,8 +1541,8 @@ static int virtio_mem_unplug_request(struct virtio_mem *vm, uint64_t diff)
> 	}
> 
> 	/* Try to unplug subblocks of partially plugged online blocks. */
>-	virtio_mem_for_each_mb_state_rev(vm, mb_id,
>-					 VIRTIO_MEM_MB_STATE_ONLINE_PARTIAL) {
>+	virtio_mem_sbm_for_each_mb_rev(vm, mb_id,
>+				       VIRTIO_MEM_SBM_MB_ONLINE_PARTIAL) {
> 		rc = virtio_mem_mb_unplug_any_sb_online(vm, mb_id,
> 							&nb_sb);
> 		if (rc || !nb_sb)
>@@ -1551,8 +1553,7 @@ static int virtio_mem_unplug_request(struct virtio_mem *vm, uint64_t diff)
> 	}
> 
> 	/* Try to unplug subblocks of plugged online blocks. */
>-	virtio_mem_for_each_mb_state_rev(vm, mb_id,
>-					 VIRTIO_MEM_MB_STATE_ONLINE) {
>+	virtio_mem_sbm_for_each_mb_rev(vm, mb_id, VIRTIO_MEM_SBM_MB_ONLINE) {
> 		rc = virtio_mem_mb_unplug_any_sb_online(vm, mb_id,
> 							&nb_sb);
> 		if (rc || !nb_sb)
>@@ -1578,11 +1579,12 @@ static int virtio_mem_unplug_pending_mb(struct virtio_mem *vm)
> 	unsigned long mb_id;
> 	int rc;
> 
>-	virtio_mem_for_each_mb_state(vm, mb_id, VIRTIO_MEM_MB_STATE_PLUGGED) {
>+	virtio_mem_sbm_for_each_mb(vm, mb_id, VIRTIO_MEM_SBM_MB_PLUGGED) {
> 		rc = virtio_mem_mb_unplug(vm, mb_id);
> 		if (rc)
> 			return rc;
>-		virtio_mem_mb_set_state(vm, mb_id, VIRTIO_MEM_MB_STATE_UNUSED);
>+		virtio_mem_sbm_set_mb_state(vm, mb_id,
>+					    VIRTIO_MEM_SBM_MB_UNUSED);
> 	}
> 
> 	return 0;
>@@ -1974,11 +1976,12 @@ static void virtio_mem_remove(struct virtio_device *vdev)
> 	 * After we unregistered our callbacks, user space can online partially
> 	 * plugged offline blocks. Make sure to remove them.
> 	 */
>-	virtio_mem_for_each_mb_state(vm, mb_id,
>-				     VIRTIO_MEM_MB_STATE_OFFLINE_PARTIAL) {
>+	virtio_mem_sbm_for_each_mb(vm, mb_id,
>+				   VIRTIO_MEM_SBM_MB_OFFLINE_PARTIAL) {
> 		rc = virtio_mem_mb_remove(vm, mb_id);
> 		BUG_ON(rc);
>-		virtio_mem_mb_set_state(vm, mb_id, VIRTIO_MEM_MB_STATE_UNUSED);
>+		virtio_mem_sbm_set_mb_state(vm, mb_id,
>+					    VIRTIO_MEM_SBM_MB_UNUSED);
> 	}
> 	/*
> 	 * After we unregistered our callbacks, user space can no longer
>@@ -2003,7 +2006,7 @@ static void virtio_mem_remove(struct virtio_device *vdev)
> 	}
> 
> 	/* remove all tracking data - no locking needed */
>-	vfree(vm->mb_state);
>+	vfree(vm->sbm.mb_states);
> 	vfree(vm->sb_bitmap);
> 
> 	/* reset the device and cleanup the queues */
>-- 
>2.26.2

-- 
Wei Yang
Help you, Help me
