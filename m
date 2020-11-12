Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D109C2B06C8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 14:40:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbgKLNkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 08:40:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:32945 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728515AbgKLNji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 08:39:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605188376;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YYZ/44bYFNl+MA3M7aAiNRRJNWtw3KuCwMzVi7UofM0=;
        b=N2IQYUrLWE4rCkm1vq/uIQqpMcGNwqJ4oWxNOHbA9Z19emzQ5xi9O5/F7A6Yv99rm3VdKB
        hoxuIg0TWYd/p/XzUM3dpBvZLZiP4lKusSVpM31z3LnUrh293d74ZbcsrHEmlutfxtZK3U
        B6fOlrxK5pxnl+njSr4nCU+MGYWFyIw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-Vy1FwKaDMFyMgf0IZFRGBw-1; Thu, 12 Nov 2020 08:39:33 -0500
X-MC-Unique: Vy1FwKaDMFyMgf0IZFRGBw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EAAA81030986;
        Thu, 12 Nov 2020 13:39:31 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-115-61.ams2.redhat.com [10.36.115.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6B65175138;
        Thu, 12 Nov 2020 13:39:30 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        "Michael S . Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Subject: [PATCH v2 23/29] virtio-mem: memory notifier callbacks are specific to Sub Block Mode (SBM)
Date:   Thu, 12 Nov 2020 14:38:09 +0100
Message-Id: <20201112133815.13332-24-david@redhat.com>
In-Reply-To: <20201112133815.13332-1-david@redhat.com>
References: <20201112133815.13332-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
index ec81f9d4bccf..cdcf67e55a56 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -587,8 +587,8 @@ static bool virtio_mem_contains_range(struct virtio_mem *vm, uint64_t start,
 	return start >= vm->addr && start + size <= vm->addr + vm->region_size;
 }
 
-static int virtio_mem_notify_going_online(struct virtio_mem *vm,
-					  unsigned long mb_id)
+static int virtio_mem_sbm_notify_going_online(struct virtio_mem *vm,
+					      unsigned long mb_id)
 {
 	switch (virtio_mem_sbm_get_mb_state(vm, mb_id)) {
 	case VIRTIO_MEM_SBM_MB_OFFLINE_PARTIAL:
@@ -602,8 +602,8 @@ static int virtio_mem_notify_going_online(struct virtio_mem *vm,
 	return NOTIFY_BAD;
 }
 
-static void virtio_mem_notify_offline(struct virtio_mem *vm,
-				      unsigned long mb_id)
+static void virtio_mem_sbm_notify_offline(struct virtio_mem *vm,
+					  unsigned long mb_id)
 {
 	switch (virtio_mem_sbm_get_mb_state(vm, mb_id)) {
 	case VIRTIO_MEM_SBM_MB_ONLINE_PARTIAL:
@@ -620,7 +620,8 @@ static void virtio_mem_notify_offline(struct virtio_mem *vm,
 	}
 }
 
-static void virtio_mem_notify_online(struct virtio_mem *vm, unsigned long mb_id)
+static void virtio_mem_sbm_notify_online(struct virtio_mem *vm,
+					 unsigned long mb_id)
 {
 	switch (virtio_mem_sbm_get_mb_state(vm, mb_id)) {
 	case VIRTIO_MEM_SBM_MB_OFFLINE_PARTIAL:
@@ -637,8 +638,8 @@ static void virtio_mem_notify_online(struct virtio_mem *vm, unsigned long mb_id)
 	}
 }
 
-static void virtio_mem_notify_going_offline(struct virtio_mem *vm,
-					    unsigned long mb_id)
+static void virtio_mem_sbm_notify_going_offline(struct virtio_mem *vm,
+						unsigned long mb_id)
 {
 	const unsigned long nr_pages = PFN_DOWN(vm->sbm.sb_size);
 	unsigned long pfn;
@@ -653,8 +654,8 @@ static void virtio_mem_notify_going_offline(struct virtio_mem *vm,
 	}
 }
 
-static void virtio_mem_notify_cancel_offline(struct virtio_mem *vm,
-					     unsigned long mb_id)
+static void virtio_mem_sbm_notify_cancel_offline(struct virtio_mem *vm,
+						 unsigned long mb_id)
 {
 	const unsigned long nr_pages = PFN_DOWN(vm->sbm.sb_size);
 	unsigned long pfn;
@@ -714,7 +715,7 @@ static int virtio_mem_memory_notifier_cb(struct notifier_block *nb,
 			break;
 		}
 		vm->hotplug_active = true;
-		virtio_mem_notify_going_offline(vm, mb_id);
+		virtio_mem_sbm_notify_going_offline(vm, mb_id);
 		break;
 	case MEM_GOING_ONLINE:
 		mutex_lock(&vm->hotplug_mutex);
@@ -724,10 +725,10 @@ static int virtio_mem_memory_notifier_cb(struct notifier_block *nb,
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
@@ -741,7 +742,7 @@ static int virtio_mem_memory_notifier_cb(struct notifier_block *nb,
 		mutex_unlock(&vm->hotplug_mutex);
 		break;
 	case MEM_ONLINE:
-		virtio_mem_notify_online(vm, mb_id);
+		virtio_mem_sbm_notify_online(vm, mb_id);
 
 		atomic64_sub(size, &vm->offline_size);
 		/*
@@ -760,7 +761,7 @@ static int virtio_mem_memory_notifier_cb(struct notifier_block *nb,
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

