Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66AFB2B06AE
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 14:39:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbgKLNjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 08:39:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:49699 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728414AbgKLNjA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 08:39:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605188338;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1/nNt7biy+blXgzIzbt4CpC5LP6Jojqi23BTUap8oBc=;
        b=aoPDq1x2TXVD94Tzrw/tAXTgjbtJl/BUkKY5DmSXyvz6b1RWfVFy+RKsEOoxVo8dk9E0Jh
        5+C9H7PGmi8rfm3mTBtjA6eew20t7XZHy50WiqX7kjkDYiq6wijPfGVft6cGbLJFY3jWcp
        eIKUHpWS177idTBxI1Nm8qsTFefFqUU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-155-5Fh2xBDQNl2QNPWUNGhIQg-1; Thu, 12 Nov 2020 08:38:57 -0500
X-MC-Unique: 5Fh2xBDQNl2QNPWUNGhIQg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6083A802B47;
        Thu, 12 Nov 2020 13:38:55 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-115-61.ams2.redhat.com [10.36.115.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A272055765;
        Thu, 12 Nov 2020 13:38:53 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        "Michael S . Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Jason Wang <jasowang@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Subject: [PATCH v2 11/29] virtio-mem: generalize check for added memory
Date:   Thu, 12 Nov 2020 14:37:57 +0100
Message-Id: <20201112133815.13332-12-david@redhat.com>
In-Reply-To: <20201112133815.13332-1-david@redhat.com>
References: <20201112133815.13332-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's check by traversing busy system RAM resources instead, to avoid
relying on memory block states.

Don't use walk_system_ram_range(), as that works on pages and we want to
use the bare addresses we have easily at hand.

This is a preparation for Big Block Mode (BBM), which won't have memory
block states.

Reviewed-by: Wei Yang <richard.weiyang@linux.alibaba.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 2f1ce4d4781b..3731097cd9e8 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -1833,6 +1833,20 @@ static void virtio_mem_delete_resource(struct virtio_mem *vm)
 	vm->parent_resource = NULL;
 }
 
+static int virtio_mem_range_has_system_ram(struct resource *res, void *arg)
+{
+	return 1;
+}
+
+static bool virtio_mem_has_memory_added(struct virtio_mem *vm)
+{
+	const unsigned long flags = IORESOURCE_SYSTEM_RAM | IORESOURCE_BUSY;
+
+	return walk_iomem_res_desc(IORES_DESC_NONE, flags, vm->addr,
+				   vm->addr + vm->region_size, NULL,
+				   virtio_mem_range_has_system_ram) == 1;
+}
+
 static int virtio_mem_probe(struct virtio_device *vdev)
 {
 	struct virtio_mem *vm;
@@ -1954,10 +1968,7 @@ static void virtio_mem_remove(struct virtio_device *vdev)
 	 * the system. And there is no way to stop the driver/device from going
 	 * away. Warn at least.
 	 */
-	if (vm->nb_mb_state[VIRTIO_MEM_MB_STATE_OFFLINE] ||
-	    vm->nb_mb_state[VIRTIO_MEM_MB_STATE_OFFLINE_PARTIAL] ||
-	    vm->nb_mb_state[VIRTIO_MEM_MB_STATE_ONLINE] ||
-	    vm->nb_mb_state[VIRTIO_MEM_MB_STATE_ONLINE_PARTIAL]) {
+	if (virtio_mem_has_memory_added(vm)) {
 		dev_warn(&vdev->dev, "device still has system memory added\n");
 	} else {
 		virtio_mem_delete_resource(vm);
-- 
2.26.2

