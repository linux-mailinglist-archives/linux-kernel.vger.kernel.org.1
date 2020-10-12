Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C42728B548
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 14:56:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730236AbgJLM4f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 08:56:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:42829 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726863AbgJLM4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 08:56:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602507388;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JHR5D8sA0HIDc7HwQ6f0+KqNbCPLWQmlx+xqVzasTCw=;
        b=a+T4jKpph8zd/H5cZuof32n2tkc7TyFMdLplc2WBiQNY61wXPCUvzVZJgfF8p0ifKaiia8
        vQUmntg1JD8BoOVC3BGfvKHhx5w2HeSihC/o+5N/QJJIX70N5mAq3y/OETMmzAylMyklrO
        grwjjRqTXye54q60dL8D1p8QU678hpc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-589-kASBXn0gPneiWH6X_Z8vZw-1; Mon, 12 Oct 2020 08:56:24 -0400
X-MC-Unique: kASBXn0gPneiWH6X_Z8vZw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 84831802B6A;
        Mon, 12 Oct 2020 12:56:23 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-251.ams2.redhat.com [10.36.113.251])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B622D6198B;
        Mon, 12 Oct 2020 12:56:11 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, virtualization@lists.linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Subject: [PATCH v1 21/29] virtio-mem: memory notifier callbacks are specific to Sub Block Mode (SBM)
Date:   Mon, 12 Oct 2020 14:53:15 +0200
Message-Id: <20201012125323.17509-22-david@redhat.com>
In-Reply-To: <20201012125323.17509-1-david@redhat.com>
References: <20201012125323.17509-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's rename accordingly.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 3a772714fec9..d06c8760b337 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -589,8 +589,8 @@ static bool virtio_mem_contains_range(struct virtio_mem *vm, uint64_t start,
 	return start >= vm->addr && start + size <= vm->addr + vm->region_size;
 }
 
-static int virtio_mem_notify_going_online(struct virtio_mem *vm,
-					  unsigned long mb_id)
+static int virtio_mem_sbm_notify_going_online(struct virtio_mem *vm,
+					      unsigned long mb_id)
 {
 	switch (virtio_mem_sbm_get_mb_state(vm, mb_id)) {
 	case VIRTIO_MEM_SBM_MB_OFFLINE_PARTIAL:
@@ -604,8 +604,8 @@ static int virtio_mem_notify_going_online(struct virtio_mem *vm,
 	return NOTIFY_BAD;
 }
 
-static void virtio_mem_notify_offline(struct virtio_mem *vm,
-				      unsigned long mb_id)
+static void virtio_mem_sbm_notify_offline(struct virtio_mem *vm,
+					  unsigned long mb_id)
 {
 	switch (virtio_mem_sbm_get_mb_state(vm, mb_id)) {
 	case VIRTIO_MEM_SBM_MB_ONLINE_PARTIAL:
@@ -622,7 +622,8 @@ static void virtio_mem_notify_offline(struct virtio_mem *vm,
 	}
 }
 
-static void virtio_mem_notify_online(struct virtio_mem *vm, unsigned long mb_id)
+static void virtio_mem_sbm_notify_online(struct virtio_mem *vm,
+					 unsigned long mb_id)
 {
 	switch (virtio_mem_sbm_get_mb_state(vm, mb_id)) {
 	case VIRTIO_MEM_SBM_MB_OFFLINE_PARTIAL:
@@ -639,8 +640,8 @@ static void virtio_mem_notify_online(struct virtio_mem *vm, unsigned long mb_id)
 	}
 }
 
-static void virtio_mem_notify_going_offline(struct virtio_mem *vm,
-					    unsigned long mb_id)
+static void virtio_mem_sbm_notify_going_offline(struct virtio_mem *vm,
+						unsigned long mb_id)
 {
 	const unsigned long nr_pages = PFN_DOWN(vm->sbm.sb_size);
 	unsigned long pfn;
@@ -655,8 +656,8 @@ static void virtio_mem_notify_going_offline(struct virtio_mem *vm,
 	}
 }
 
-static void virtio_mem_notify_cancel_offline(struct virtio_mem *vm,
-					     unsigned long mb_id)
+static void virtio_mem_sbm_notify_cancel_offline(struct virtio_mem *vm,
+						 unsigned long mb_id)
 {
 	const unsigned long nr_pages = PFN_DOWN(vm->sbm.sb_size);
 	unsigned long pfn;
@@ -716,7 +717,7 @@ static int virtio_mem_memory_notifier_cb(struct notifier_block *nb,
 			break;
 		}
 		vm->hotplug_active = true;
-		virtio_mem_notify_going_offline(vm, mb_id);
+		virtio_mem_sbm_notify_going_offline(vm, mb_id);
 		break;
 	case MEM_GOING_ONLINE:
 		mutex_lock(&vm->hotplug_mutex);
@@ -726,10 +727,10 @@ static int virtio_mem_memory_notifier_cb(struct notifier_block *nb,
 			break;
 		}
 		vm->hotplug_active = true;
-		rc = virtio_mem_notify_going_online(vm, mb_id);
+		rc = virtio_mem_sbm_notify_going_online(vm, mb_id);
 		break;
 	case MEM_OFFLINE:
-		virtio_mem_notify_offline(vm, mb_id);
+		virtio_mem_sbm_notify_offline(vm, mb_id);
 
 		atomic64_add(size, &vm->offline_size);
 		/*
@@ -743,7 +744,7 @@ static int virtio_mem_memory_notifier_cb(struct notifier_block *nb,
 		mutex_unlock(&vm->hotplug_mutex);
 		break;
 	case MEM_ONLINE:
-		virtio_mem_notify_online(vm, mb_id);
+		virtio_mem_sbm_notify_online(vm, mb_id);
 
 		atomic64_sub(size, &vm->offline_size);
 		/*
@@ -762,7 +763,7 @@ static int virtio_mem_memory_notifier_cb(struct notifier_block *nb,
 	case MEM_CANCEL_OFFLINE:
 		if (!vm->hotplug_active)
 			break;
-		virtio_mem_notify_cancel_offline(vm, mb_id);
+		virtio_mem_sbm_notify_cancel_offline(vm, mb_id);
 		vm->hotplug_active = false;
 		mutex_unlock(&vm->hotplug_mutex);
 		break;
-- 
2.26.2

