Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3527F2B06D0
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 14:40:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728468AbgKLNjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 08:39:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:35311 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728457AbgKLNjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 08:39:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605188354;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ft1YSvY9BgdFEI8pvmy+sn5jf3hse4l/Z931OuLpsyQ=;
        b=MLpJDyqogHj91jySvGrnFanXIWS/oaLo611j8BTa1oUm1RW82TyO6LIPuAg2Dcrpx6Uad+
        U+XBW022ZyqksliYuXJsZt6YmNrUzs0hAdmf01XELC164GO4YHeoaRP72biTeCurqYeBlR
        foXQIWnpFcKpxa8dQL7Vg5jmmbB72e0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-491-bCjUfemBM1CFGjtQ-6RGAA-1; Thu, 12 Nov 2020 08:39:10 -0500
X-MC-Unique: bCjUfemBM1CFGjtQ-6RGAA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 757B9809DE2;
        Thu, 12 Nov 2020 13:39:09 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-115-61.ams2.redhat.com [10.36.115.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E060A75138;
        Thu, 12 Nov 2020 13:39:07 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        "Michael S . Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Subject: [PATCH v2 15/29] virtio-mem: don't always trigger the workqueue when offlining memory
Date:   Thu, 12 Nov 2020 14:38:01 +0100
Message-Id: <20201112133815.13332-16-david@redhat.com>
In-Reply-To: <20201112133815.13332-1-david@redhat.com>
References: <20201112133815.13332-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's trigger from offlining code only when we're not allowed to unplug
online memory. Handle the other case (memmap possibly freeing up another
memory block) when actually removing memory. We now also properly handle
the case when removing already offline memory blocks via
virtio_mem_mb_remove(). When removing via virtio_mem_remove(), when
unloading the driver, virtio_mem_retry() is a NOP and safe to use.

While at it, move retry handling when offlining out of
virtio_mem_notify_offline(), to share it with Big Block Mode (BBM)
soon.

This is a preparation for Big Block Mode (BBM), whereby we can see some
temporary offlining of memory blocks without actually making progress.
Imagine you have a Big Block that spans to Linux memory blocks. Assume
the first Linux memory blocks has no unmovable data on it. When we would
call offline_and_remove_memory() on the big block, we would
	1. Try to offline the first block. Works, notifiers triggered.
	   virtio_mem_retry() called.
	2. Try to offline the second block. Does not work.
	3. Re-online first block.
	4. Exit to main loop, exit workqueue.
	5. Retry immediately (due to virtio_mem_retry()), go to 1.
The result are endless retries.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 40 ++++++++++++++++++++++++++-----------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index a7beac5942e0..f86654af8b6b 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -162,6 +162,7 @@ static void virtio_mem_fake_offline_going_offline(unsigned long pfn,
 						  unsigned long nr_pages);
 static void virtio_mem_fake_offline_cancel_offline(unsigned long pfn,
 						   unsigned long nr_pages);
+static void virtio_mem_retry(struct virtio_mem *vm);
 
 /*
  * Register a virtio-mem device so it will be considered for the online_page
@@ -447,9 +448,17 @@ static int virtio_mem_mb_add(struct virtio_mem *vm, unsigned long mb_id)
 static int virtio_mem_mb_remove(struct virtio_mem *vm, unsigned long mb_id)
 {
 	const uint64_t addr = virtio_mem_mb_id_to_phys(mb_id);
+	int rc;
 
 	dev_dbg(&vm->vdev->dev, "removing memory block: %lu\n", mb_id);
-	return remove_memory(vm->nid, addr, memory_block_size_bytes());
+	rc = remove_memory(vm->nid, addr, memory_block_size_bytes());
+	if (!rc)
+		/*
+		 * We might have freed up memory we can now unplug, retry
+		 * immediately instead of waiting.
+		 */
+		virtio_mem_retry(vm);
+	return rc;
 }
 
 /*
@@ -464,11 +473,19 @@ static int virtio_mem_mb_offline_and_remove(struct virtio_mem *vm,
 					    unsigned long mb_id)
 {
 	const uint64_t addr = virtio_mem_mb_id_to_phys(mb_id);
+	int rc;
 
 	dev_dbg(&vm->vdev->dev, "offlining and removing memory block: %lu\n",
 		mb_id);
-	return offline_and_remove_memory(vm->nid, addr,
-					 memory_block_size_bytes());
+	rc = offline_and_remove_memory(vm->nid, addr,
+				       memory_block_size_bytes());
+	if (!rc)
+		/*
+		 * We might have freed up memory we can now unplug, retry
+		 * immediately instead of waiting.
+		 */
+		virtio_mem_retry(vm);
+	return rc;
 }
 
 /*
@@ -546,15 +563,6 @@ static void virtio_mem_notify_offline(struct virtio_mem *vm,
 		BUG();
 		break;
 	}
-
-	/*
-	 * Trigger the workqueue, maybe we can now unplug memory. Also,
-	 * when we offline and remove a memory block, this will re-trigger
-	 * us immediately - which is often nice because the removal of
-	 * the memory block (e.g., memmap) might have freed up memory
-	 * on other memory blocks we manage.
-	 */
-	virtio_mem_retry(vm);
 }
 
 static void virtio_mem_notify_online(struct virtio_mem *vm, unsigned long mb_id)
@@ -672,6 +680,14 @@ static int virtio_mem_memory_notifier_cb(struct notifier_block *nb,
 		break;
 	case MEM_OFFLINE:
 		virtio_mem_notify_offline(vm, mb_id);
+
+		/*
+		 * Trigger the workqueue. Now that we have some offline memory,
+		 * maybe we can handle pending unplug requests.
+		 */
+		if (!unplug_online)
+			virtio_mem_retry(vm);
+
 		vm->hotplug_active = false;
 		mutex_unlock(&vm->hotplug_mutex);
 		break;
-- 
2.26.2

