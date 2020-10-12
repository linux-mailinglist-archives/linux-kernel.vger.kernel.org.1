Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6525428B556
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 14:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728800AbgJLM5e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 08:57:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:27575 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726130AbgJLM5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 08:57:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602507452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GC8VOJiDkG6ErANTb/WlUuIOAAehbykdKgaBnzsSpVw=;
        b=QYU4g9SSHdbM86vXZ9hm1UWh8Qs46eN6zk1sR58L32N4Y/HSRmCyGxrOs456OhwBokp6s2
        3jg4d8dBPHgZ3YR0zzpGp1EqSk4T4dC4/U/gjMOMd/CsZlGndGk4bW7Ggi1deFlcUxg6j0
        i7kfgcA9XT1Ma2kezHywSIHtN6wX2/A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-34-pUaSbvp5NBOvnPhuhjfrhg-1; Mon, 12 Oct 2020 08:57:30 -0400
X-MC-Unique: pUaSbvp5NBOvnPhuhjfrhg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E74851074658;
        Mon, 12 Oct 2020 12:57:28 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-251.ams2.redhat.com [10.36.113.251])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5621160C07;
        Mon, 12 Oct 2020 12:57:19 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, virtualization@lists.linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Michal Hocko <mhocko@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [PATCH v1 28/29] virtio-mem: Big Block Mode (BBM) - basic memory hotunplug
Date:   Mon, 12 Oct 2020 14:53:22 +0200
Message-Id: <20201012125323.17509-29-david@redhat.com>
In-Reply-To: <20201012125323.17509-1-david@redhat.com>
References: <20201012125323.17509-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's try to unplug completely offline big blocks first. Then, (if
enabled via unplug_offline) try to offline and remove whole big blocks.

No locking necessary - we can deal with concurrent onlining/offlining
just fine.

Note1: This is sub-optimal and might be dangerous in some environments: we
could end up in an infinite loop when offlining (e.g., long-term pinnings),
similar as with DIMMs. We'll introduce safe memory hotunplug via
fake-offlining next, and use this basic mode only when explicitly enabled.

Note2: Without ZONE_MOVABLE, memory unplug will be extremely unreliable
with bigger block sizes.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: Michal Hocko <mhocko@kernel.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 156 +++++++++++++++++++++++++++++++++++-
 1 file changed, 155 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 94cf44b15cbf..6bcd0acbff32 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -388,6 +388,12 @@ static int virtio_mem_bbm_bb_states_prepare_next_bb(struct virtio_mem *vm)
 	     _bb_id++) \
 		if (virtio_mem_bbm_get_bb_state(_vm, _bb_id) == _state)
 
+#define virtio_mem_bbm_for_each_bb_rev(_vm, _bb_id, _state) \
+	for (_bb_id = vm->bbm.next_bb_id - 1; \
+	     _bb_id >= vm->bbm.first_bb_id && _vm->bbm.bb_count[_state]; \
+	     _bb_id--) \
+		if (virtio_mem_bbm_get_bb_state(_vm, _bb_id) == _state)
+
 /*
  * Set the state of a memory block, taking care of the state counter.
  */
@@ -685,6 +691,18 @@ static int virtio_mem_sbm_remove_mb(struct virtio_mem *vm, unsigned long mb_id)
 	return virtio_mem_remove_memory(vm, addr, size);
 }
 
+/*
+ * See virtio_mem_remove_memory(): Try to remove all Linux memory blocks covered
+ * by the big block.
+ */
+static int virtio_mem_bbm_remove_bb(struct virtio_mem *vm, unsigned long bb_id)
+{
+	const uint64_t addr = virtio_mem_bb_id_to_phys(vm, bb_id);
+	const uint64_t size = vm->bbm.bb_size;
+
+	return virtio_mem_remove_memory(vm, addr, size);
+}
+
 /*
  * Try offlining and removing memory from Linux.
  *
@@ -731,6 +749,19 @@ static int virtio_mem_sbm_offline_and_remove_mb(struct virtio_mem *vm,
 	return virtio_mem_offline_and_remove_memory(vm, addr, size);
 }
 
+/*
+ * See virtio_mem_offline_and_remove_memory(): Try to offline and remove a
+ * all Linux memory blocks covered by the big block.
+ */
+static int virtio_mem_bbm_offline_and_remove_bb(struct virtio_mem *vm,
+						unsigned long bb_id)
+{
+	const uint64_t addr = virtio_mem_bb_id_to_phys(vm, bb_id);
+	const uint64_t size = vm->bbm.bb_size;
+
+	return virtio_mem_offline_and_remove_memory(vm, addr, size);
+}
+
 /*
  * Trigger the workqueue so the device can perform its magic.
  */
@@ -1928,6 +1959,129 @@ static int virtio_mem_sbm_unplug_request(struct virtio_mem *vm, uint64_t diff)
 	return rc;
 }
 
+/*
+ * Try to offline and remove a big block from Linux and unplug it. Will fail
+ * with -EBUSY if some memory is busy and cannot get unplugged.
+ *
+ * Will modify the state of the memory block. Might temporarily drop the
+ * hotplug_mutex.
+ */
+static int virtio_mem_bbm_offline_remove_and_unplug_bb(struct virtio_mem *vm,
+						       unsigned long bb_id)
+{
+	int rc;
+
+	if (WARN_ON_ONCE(virtio_mem_bbm_get_bb_state(vm, bb_id) !=
+			 VIRTIO_MEM_BBM_BB_ADDED))
+		return -EINVAL;
+
+	rc = virtio_mem_bbm_offline_and_remove_bb(vm, bb_id);
+	if (rc)
+		return rc;
+
+	rc = virtio_mem_bbm_unplug_bb(vm, bb_id);
+	if (rc)
+		virtio_mem_bbm_set_bb_state(vm, bb_id,
+					    VIRTIO_MEM_BBM_BB_PLUGGED);
+	else
+		virtio_mem_bbm_set_bb_state(vm, bb_id,
+					    VIRTIO_MEM_BBM_BB_UNUSED);
+	return rc;
+}
+
+/*
+ * Try to remove a big block from Linux and unplug it. Will fail with
+ * -EBUSY if some memory is online.
+ *
+ * Will modify the state of the memory block.
+ */
+static int virtio_mem_bbm_remove_and_unplug_bb(struct virtio_mem *vm,
+					       unsigned long bb_id)
+{
+	int rc;
+
+	if (WARN_ON_ONCE(virtio_mem_bbm_get_bb_state(vm, bb_id) !=
+			 VIRTIO_MEM_BBM_BB_ADDED))
+		return -EINVAL;
+
+	rc = virtio_mem_bbm_remove_bb(vm, bb_id);
+	if (rc)
+		return -EBUSY;
+
+	rc = virtio_mem_bbm_unplug_bb(vm, bb_id);
+	if (rc)
+		virtio_mem_bbm_set_bb_state(vm, bb_id,
+					    VIRTIO_MEM_BBM_BB_PLUGGED);
+	else
+		virtio_mem_bbm_set_bb_state(vm, bb_id,
+					    VIRTIO_MEM_BBM_BB_UNUSED);
+	return rc;
+}
+
+/*
+ * Test if a big block is completely offline.
+ */
+static bool virtio_mem_bbm_bb_is_offline(struct virtio_mem *vm,
+					 unsigned long bb_id)
+{
+	const unsigned long start_pfn = PFN_DOWN(virtio_mem_bb_id_to_phys(vm, bb_id));
+	const unsigned long nr_pages = PFN_DOWN(vm->bbm.bb_size);
+	unsigned long pfn;
+
+	for (pfn = start_pfn; pfn < start_pfn + nr_pages;
+	     pfn += PAGES_PER_SECTION) {
+		if (pfn_to_online_page(pfn))
+			return false;
+	}
+
+	return true;
+}
+
+static int virtio_mem_bbm_unplug_request(struct virtio_mem *vm, uint64_t diff)
+{
+	uint64_t nb_bb = diff / vm->bbm.bb_size;
+	uint64_t bb_id;
+	int rc;
+
+	if (!nb_bb)
+		return 0;
+
+	/* Try to unplug completely offline big blocks first. */
+	virtio_mem_bbm_for_each_bb_rev(vm, bb_id, VIRTIO_MEM_BBM_BB_ADDED) {
+		cond_resched();
+		/*
+		 * As we're holding no locks, this check is racy as memory
+		 * can get onlined in the meantime - but we'll fail gracefully.
+		 */
+		if (!virtio_mem_bbm_bb_is_offline(vm, bb_id))
+			continue;
+		rc = virtio_mem_bbm_remove_and_unplug_bb(vm, bb_id);
+		if (rc == -EBUSY)
+			continue;
+		if (!rc)
+			nb_bb--;
+		if (rc || !nb_bb)
+			return rc;
+	}
+
+	if (!unplug_online)
+		return 0;
+
+	/* Try to unplug any big blocks. */
+	virtio_mem_bbm_for_each_bb_rev(vm, bb_id, VIRTIO_MEM_BBM_BB_ADDED) {
+		cond_resched();
+		rc = virtio_mem_bbm_offline_remove_and_unplug_bb(vm, bb_id);
+		if (rc == -EBUSY)
+			continue;
+		if (!rc)
+			nb_bb--;
+		if (rc || !nb_bb)
+			return rc;
+	}
+
+	return nb_bb ? -EBUSY : 0;
+}
+
 /*
  * Try to unplug the requested amount of memory.
  */
@@ -1935,7 +2089,7 @@ static int virtio_mem_unplug_request(struct virtio_mem *vm, uint64_t diff)
 {
 	if (vm->in_sbm)
 		return virtio_mem_sbm_unplug_request(vm, diff);
-	return -EBUSY;
+	return virtio_mem_bbm_unplug_request(vm, diff);
 }
 
 /*
-- 
2.26.2

