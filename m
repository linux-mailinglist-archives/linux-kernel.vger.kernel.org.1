Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E269F28B54B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 14:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388594AbgJLM4y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 08:56:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:25296 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388576AbgJLM4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 08:56:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602507410;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0W8H+Eppwo/SCQzkVeDdbAcVbZKbYgif5wttVSOP2BA=;
        b=D9cmhk1pvGCwk9FTXWlhxuWNvgq+pFBqgp5CekelnFpsVFPKIWWrF+6VWISCdXqPNm3zPl
        r9jCOJt7OGxSmwveejUEpTstIdFb0lm1n61PBiJvnUkyzzAEBc6f4pammkyBQqrP9kpj6j
        s/U559Luek+03GOOCoMRucdHJd5r/b4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-2-T0HyHURqNQS580ecS-Y9RA-1; Mon, 12 Oct 2020 08:56:48 -0400
X-MC-Unique: T0HyHURqNQS580ecS-Y9RA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 18060107465A;
        Mon, 12 Oct 2020 12:56:47 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-251.ams2.redhat.com [10.36.113.251])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EED4A60C07;
        Mon, 12 Oct 2020 12:56:42 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, virtualization@lists.linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Subject: [PATCH v1 24/29] virtio-mem: print debug messages from virtio_mem_send_*_request()
Date:   Mon, 12 Oct 2020 14:53:18 +0200
Message-Id: <20201012125323.17509-25-david@redhat.com>
In-Reply-To: <20201012125323.17509-1-david@redhat.com>
References: <20201012125323.17509-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's move the existing dev_dbg() into the functions, print if something
went wrong, and also print for virtio_mem_send_unplug_all_request().

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 50 ++++++++++++++++++++++++++-----------
 1 file changed, 35 insertions(+), 15 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index eb2ad31a8d8a..e68d0d99590c 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -1053,23 +1053,33 @@ static int virtio_mem_send_plug_request(struct virtio_mem *vm, uint64_t addr,
 		.u.plug.addr = cpu_to_virtio64(vm->vdev, addr),
 		.u.plug.nb_blocks = cpu_to_virtio16(vm->vdev, nb_vm_blocks),
 	};
+	int rc = -ENOMEM;
 
 	if (atomic_read(&vm->config_changed))
 		return -EAGAIN;
 
+	dev_dbg(&vm->vdev->dev, "plugging memory: 0x%llx - 0x%llx\n", addr,
+		addr + size - 1);
+
 	switch (virtio_mem_send_request(vm, &req)) {
 	case VIRTIO_MEM_RESP_ACK:
 		vm->plugged_size += size;
 		return 0;
 	case VIRTIO_MEM_RESP_NACK:
-		return -EAGAIN;
+		rc = -EAGAIN;
+		break;
 	case VIRTIO_MEM_RESP_BUSY:
-		return -ETXTBSY;
+		rc = -ETXTBSY;
+		break;
 	case VIRTIO_MEM_RESP_ERROR:
-		return -EINVAL;
+		rc = -EINVAL;
+		break;
 	default:
-		return -ENOMEM;
+		break;
 	}
+
+	dev_dbg(&vm->vdev->dev, "plugging memory failed: %d\n", rc);
+	return rc;
 }
 
 static int virtio_mem_send_unplug_request(struct virtio_mem *vm, uint64_t addr,
@@ -1081,21 +1091,30 @@ static int virtio_mem_send_unplug_request(struct virtio_mem *vm, uint64_t addr,
 		.u.unplug.addr = cpu_to_virtio64(vm->vdev, addr),
 		.u.unplug.nb_blocks = cpu_to_virtio16(vm->vdev, nb_vm_blocks),
 	};
+	int rc = -ENOMEM;
 
 	if (atomic_read(&vm->config_changed))
 		return -EAGAIN;
 
+	dev_dbg(&vm->vdev->dev, "unplugging memory: 0x%llx - 0x%llx\n", addr,
+		addr + size - 1);
+
 	switch (virtio_mem_send_request(vm, &req)) {
 	case VIRTIO_MEM_RESP_ACK:
 		vm->plugged_size -= size;
 		return 0;
 	case VIRTIO_MEM_RESP_BUSY:
-		return -ETXTBSY;
+		rc = -ETXTBSY;
+		break;
 	case VIRTIO_MEM_RESP_ERROR:
-		return -EINVAL;
+		rc = -EINVAL;
+		break;
 	default:
-		return -ENOMEM;
+		break;
 	}
+
+	dev_dbg(&vm->vdev->dev, "unplugging memory failed: %d\n", rc);
+	return rc;
 }
 
 static int virtio_mem_send_unplug_all_request(struct virtio_mem *vm)
@@ -1103,6 +1122,9 @@ static int virtio_mem_send_unplug_all_request(struct virtio_mem *vm)
 	const struct virtio_mem_req req = {
 		.type = cpu_to_virtio16(vm->vdev, VIRTIO_MEM_REQ_UNPLUG_ALL),
 	};
+	int rc = -ENOMEM;
+
+	dev_dbg(&vm->vdev->dev, "unplugging all memory");
 
 	switch (virtio_mem_send_request(vm, &req)) {
 	case VIRTIO_MEM_RESP_ACK:
@@ -1112,10 +1134,14 @@ static int virtio_mem_send_unplug_all_request(struct virtio_mem *vm)
 		atomic_set(&vm->config_changed, 1);
 		return 0;
 	case VIRTIO_MEM_RESP_BUSY:
-		return -ETXTBSY;
+		rc = -ETXTBSY;
+		break;
 	default:
-		return -ENOMEM;
+		break;
 	}
+
+	dev_dbg(&vm->vdev->dev, "unplugging all memory failed: %d\n", rc);
+	return rc;
 }
 
 /*
@@ -1130,9 +1156,6 @@ static int virtio_mem_sbm_plug_sb(struct virtio_mem *vm, unsigned long mb_id,
 	const uint64_t size = count * vm->sbm.sb_size;
 	int rc;
 
-	dev_dbg(&vm->vdev->dev, "plugging memory block: %lu : %i - %i\n", mb_id,
-		sb_id, sb_id + count - 1);
-
 	rc = virtio_mem_send_plug_request(vm, addr, size);
 	if (!rc)
 		virtio_mem_sbm_set_sb_plugged(vm, mb_id, sb_id, count);
@@ -1151,9 +1174,6 @@ static int virtio_mem_sbm_unplug_sb(struct virtio_mem *vm, unsigned long mb_id,
 	const uint64_t size = count * vm->sbm.sb_size;
 	int rc;
 
-	dev_dbg(&vm->vdev->dev, "unplugging memory block: %lu : %i - %i\n",
-		mb_id, sb_id, sb_id + count - 1);
-
 	rc = virtio_mem_send_unplug_request(vm, addr, size);
 	if (!rc)
 		virtio_mem_sbm_set_sb_unplugged(vm, mb_id, sb_id, count);
-- 
2.26.2

