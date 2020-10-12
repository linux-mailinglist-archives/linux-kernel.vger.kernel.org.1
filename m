Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E605E28B51F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 14:55:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730086AbgJLMyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 08:54:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24998 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727633AbgJLMyx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 08:54:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602507291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GqBRdrN+rzKtjpl2XrHaqNhvixrxohgsDeDRZkVA61Y=;
        b=NpfEra2nd72i88fNdS8+JGEuXfY5HxLzm77jvs3b283PWi9ouZm8lhqIeDdSKiiMcj6R/k
        sxqx1lAMVBQWSqTrS13l1rTVVXJCmjYKB897jtk1u+UHt4M3t+vSaLKbdcq7u72j97elB9
        7s2clVdEVSu5GoKQIv7OxhHoT69RqG0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-447-T30Fq8AONu2AuXWUt9jDqA-1; Mon, 12 Oct 2020 08:54:47 -0400
X-MC-Unique: T30Fq8AONu2AuXWUt9jDqA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 40C4E1800D4A;
        Mon, 12 Oct 2020 12:54:46 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-251.ams2.redhat.com [10.36.113.251])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 009C060C13;
        Mon, 12 Oct 2020 12:54:35 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, virtualization@lists.linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Subject: [PATCH v1 09/29] virtio-mem: don't always trigger the workqueue when offlining memory
Date:   Mon, 12 Oct 2020 14:53:03 +0200
Message-Id: <20201012125323.17509-10-david@redhat.com>
In-Reply-To: <20201012125323.17509-1-david@redhat.com>
References: <20201012125323.17509-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's trigger from offlining code when we're not allowed to touch online
memory.

Handle the other case (memmap possibly freeing up another memory block)
when actually removing memory. When removing via virtio_mem_remove(),
virtio_mem_retry() is a NOP and safe to use.

While at it, move retry handling when offlining out of
virtio_mem_notify_offline(), to share it with Device Block Mode (DBM)
soon.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 40 ++++++++++++++++++++++++++-----------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 5c93f8a65eba..8ea00f0b2ecd 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -158,6 +158,7 @@ static DEFINE_MUTEX(virtio_mem_mutex);
 static LIST_HEAD(virtio_mem_devices);
 
 static void virtio_mem_online_page_cb(struct page *page, unsigned int order);
+static void virtio_mem_retry(struct virtio_mem *vm);
 
 /*
  * Register a virtio-mem device so it will be considered for the online_page
@@ -435,9 +436,17 @@ static int virtio_mem_mb_add(struct virtio_mem *vm, unsigned long mb_id)
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
@@ -452,11 +461,19 @@ static int virtio_mem_mb_offline_and_remove(struct virtio_mem *vm,
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
@@ -534,15 +551,6 @@ static void virtio_mem_notify_offline(struct virtio_mem *vm,
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
@@ -679,6 +687,14 @@ static int virtio_mem_memory_notifier_cb(struct notifier_block *nb,
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

