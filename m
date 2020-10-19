Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5805292181
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 05:48:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731649AbgJSDsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Oct 2020 23:48:22 -0400
Received: from out30-133.freemail.mail.aliyun.com ([115.124.30.133]:60221 "EHLO
        out30-133.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731306AbgJSDsW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Oct 2020 23:48:22 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=richard.weiyang@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0UCQALvF_1603079297;
Received: from localhost(mailfrom:richard.weiyang@linux.alibaba.com fp:SMTPD_---0UCQALvF_1603079297)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 19 Oct 2020 11:48:18 +0800
Date:   Mon, 19 Oct 2020 11:48:17 +0800
From:   Wei Yang <richard.weiyang@linux.alibaba.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        virtualization@lists.linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: Re: [PATCH v1 28/29] virtio-mem: Big Block Mode (BBM) - basic memory
 hotunplug
Message-ID: <20201019034817.GD54484@L-31X9LVDL-1304.local>
Reply-To: Wei Yang <richard.weiyang@linux.alibaba.com>
References: <20201012125323.17509-1-david@redhat.com>
 <20201012125323.17509-29-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012125323.17509-29-david@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 12, 2020 at 02:53:22PM +0200, David Hildenbrand wrote:
>Let's try to unplug completely offline big blocks first. Then, (if
>enabled via unplug_offline) try to offline and remove whole big blocks.
>
>No locking necessary - we can deal with concurrent onlining/offlining
>just fine.
>
>Note1: This is sub-optimal and might be dangerous in some environments: we
>could end up in an infinite loop when offlining (e.g., long-term pinnings),
>similar as with DIMMs. We'll introduce safe memory hotunplug via
>fake-offlining next, and use this basic mode only when explicitly enabled.
>
>Note2: Without ZONE_MOVABLE, memory unplug will be extremely unreliable
>with bigger block sizes.
>
>Cc: "Michael S. Tsirkin" <mst@redhat.com>
>Cc: Jason Wang <jasowang@redhat.com>
>Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
>Cc: Michal Hocko <mhocko@kernel.org>
>Cc: Oscar Salvador <osalvador@suse.de>
>Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
>Cc: Andrew Morton <akpm@linux-foundation.org>
>Signed-off-by: David Hildenbrand <david@redhat.com>
>---
> drivers/virtio/virtio_mem.c | 156 +++++++++++++++++++++++++++++++++++-
> 1 file changed, 155 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
>index 94cf44b15cbf..6bcd0acbff32 100644
>--- a/drivers/virtio/virtio_mem.c
>+++ b/drivers/virtio/virtio_mem.c
>@@ -388,6 +388,12 @@ static int virtio_mem_bbm_bb_states_prepare_next_bb(struct virtio_mem *vm)
> 	     _bb_id++) \
> 		if (virtio_mem_bbm_get_bb_state(_vm, _bb_id) == _state)
> 
>+#define virtio_mem_bbm_for_each_bb_rev(_vm, _bb_id, _state) \
>+	for (_bb_id = vm->bbm.next_bb_id - 1; \
>+	     _bb_id >= vm->bbm.first_bb_id && _vm->bbm.bb_count[_state]; \
>+	     _bb_id--) \
>+		if (virtio_mem_bbm_get_bb_state(_vm, _bb_id) == _state)
>+
> /*
>  * Set the state of a memory block, taking care of the state counter.
>  */
>@@ -685,6 +691,18 @@ static int virtio_mem_sbm_remove_mb(struct virtio_mem *vm, unsigned long mb_id)
> 	return virtio_mem_remove_memory(vm, addr, size);
> }
> 
>+/*
>+ * See virtio_mem_remove_memory(): Try to remove all Linux memory blocks covered
>+ * by the big block.
>+ */
>+static int virtio_mem_bbm_remove_bb(struct virtio_mem *vm, unsigned long bb_id)
>+{
>+	const uint64_t addr = virtio_mem_bb_id_to_phys(vm, bb_id);
>+	const uint64_t size = vm->bbm.bb_size;
>+
>+	return virtio_mem_remove_memory(vm, addr, size);
>+}
>+
> /*
>  * Try offlining and removing memory from Linux.
>  *
>@@ -731,6 +749,19 @@ static int virtio_mem_sbm_offline_and_remove_mb(struct virtio_mem *vm,
> 	return virtio_mem_offline_and_remove_memory(vm, addr, size);
> }
> 
>+/*
>+ * See virtio_mem_offline_and_remove_memory(): Try to offline and remove a
>+ * all Linux memory blocks covered by the big block.
>+ */
>+static int virtio_mem_bbm_offline_and_remove_bb(struct virtio_mem *vm,
>+						unsigned long bb_id)
>+{
>+	const uint64_t addr = virtio_mem_bb_id_to_phys(vm, bb_id);
>+	const uint64_t size = vm->bbm.bb_size;
>+
>+	return virtio_mem_offline_and_remove_memory(vm, addr, size);
>+}
>+
> /*
>  * Trigger the workqueue so the device can perform its magic.
>  */
>@@ -1928,6 +1959,129 @@ static int virtio_mem_sbm_unplug_request(struct virtio_mem *vm, uint64_t diff)
> 	return rc;
> }
> 
>+/*
>+ * Try to offline and remove a big block from Linux and unplug it. Will fail
>+ * with -EBUSY if some memory is busy and cannot get unplugged.
>+ *
>+ * Will modify the state of the memory block. Might temporarily drop the
>+ * hotplug_mutex.
>+ */
>+static int virtio_mem_bbm_offline_remove_and_unplug_bb(struct virtio_mem *vm,
>+						       unsigned long bb_id)
>+{
>+	int rc;
>+
>+	if (WARN_ON_ONCE(virtio_mem_bbm_get_bb_state(vm, bb_id) !=
>+			 VIRTIO_MEM_BBM_BB_ADDED))
>+		return -EINVAL;
>+
>+	rc = virtio_mem_bbm_offline_and_remove_bb(vm, bb_id);
>+	if (rc)
>+		return rc;
>+
>+	rc = virtio_mem_bbm_unplug_bb(vm, bb_id);
>+	if (rc)
>+		virtio_mem_bbm_set_bb_state(vm, bb_id,
>+					    VIRTIO_MEM_BBM_BB_PLUGGED);
>+	else
>+		virtio_mem_bbm_set_bb_state(vm, bb_id,
>+					    VIRTIO_MEM_BBM_BB_UNUSED);
>+	return rc;
>+}
>+
>+/*
>+ * Try to remove a big block from Linux and unplug it. Will fail with
>+ * -EBUSY if some memory is online.
>+ *
>+ * Will modify the state of the memory block.
>+ */
>+static int virtio_mem_bbm_remove_and_unplug_bb(struct virtio_mem *vm,
>+					       unsigned long bb_id)
>+{
>+	int rc;
>+
>+	if (WARN_ON_ONCE(virtio_mem_bbm_get_bb_state(vm, bb_id) !=
>+			 VIRTIO_MEM_BBM_BB_ADDED))
>+		return -EINVAL;
>+
>+	rc = virtio_mem_bbm_remove_bb(vm, bb_id);
>+	if (rc)
>+		return -EBUSY;
>+
>+	rc = virtio_mem_bbm_unplug_bb(vm, bb_id);
>+	if (rc)
>+		virtio_mem_bbm_set_bb_state(vm, bb_id,
>+					    VIRTIO_MEM_BBM_BB_PLUGGED);
>+	else
>+		virtio_mem_bbm_set_bb_state(vm, bb_id,
>+					    VIRTIO_MEM_BBM_BB_UNUSED);
>+	return rc;
>+}
>+
>+/*
>+ * Test if a big block is completely offline.
>+ */
>+static bool virtio_mem_bbm_bb_is_offline(struct virtio_mem *vm,
>+					 unsigned long bb_id)
>+{
>+	const unsigned long start_pfn = PFN_DOWN(virtio_mem_bb_id_to_phys(vm, bb_id));
>+	const unsigned long nr_pages = PFN_DOWN(vm->bbm.bb_size);
>+	unsigned long pfn;
>+
>+	for (pfn = start_pfn; pfn < start_pfn + nr_pages;
>+	     pfn += PAGES_PER_SECTION) {

Can we do the check with memory block granularity?

>+		if (pfn_to_online_page(pfn))
>+			return false;
>+	}
>+
>+	return true;
>+}
>+
>+static int virtio_mem_bbm_unplug_request(struct virtio_mem *vm, uint64_t diff)
>+{
>+	uint64_t nb_bb = diff / vm->bbm.bb_size;
>+	uint64_t bb_id;
>+	int rc;
>+
>+	if (!nb_bb)
>+		return 0;
>+
>+	/* Try to unplug completely offline big blocks first. */
>+	virtio_mem_bbm_for_each_bb_rev(vm, bb_id, VIRTIO_MEM_BBM_BB_ADDED) {
>+		cond_resched();
>+		/*
>+		 * As we're holding no locks, this check is racy as memory
>+		 * can get onlined in the meantime - but we'll fail gracefully.
>+		 */
>+		if (!virtio_mem_bbm_bb_is_offline(vm, bb_id))
>+			continue;
>+		rc = virtio_mem_bbm_remove_and_unplug_bb(vm, bb_id);
>+		if (rc == -EBUSY)
>+			continue;
>+		if (!rc)
>+			nb_bb--;
>+		if (rc || !nb_bb)
>+			return rc;
>+	}
>+
>+	if (!unplug_online)
>+		return 0;
>+
>+	/* Try to unplug any big blocks. */
>+	virtio_mem_bbm_for_each_bb_rev(vm, bb_id, VIRTIO_MEM_BBM_BB_ADDED) {
>+		cond_resched();
>+		rc = virtio_mem_bbm_offline_remove_and_unplug_bb(vm, bb_id);
>+		if (rc == -EBUSY)
>+			continue;
>+		if (!rc)
>+			nb_bb--;
>+		if (rc || !nb_bb)
>+			return rc;
>+	}
>+
>+	return nb_bb ? -EBUSY : 0;
>+}
>+
> /*
>  * Try to unplug the requested amount of memory.
>  */
>@@ -1935,7 +2089,7 @@ static int virtio_mem_unplug_request(struct virtio_mem *vm, uint64_t diff)
> {
> 	if (vm->in_sbm)
> 		return virtio_mem_sbm_unplug_request(vm, diff);
>-	return -EBUSY;
>+	return virtio_mem_bbm_unplug_request(vm, diff);
> }
> 
> /*
>-- 
>2.26.2

-- 
Wei Yang
Help you, Help me
