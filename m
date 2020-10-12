Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEA8028B518
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 14:54:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730024AbgJLMyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 08:54:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:42758 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727436AbgJLMyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 08:54:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602507271;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UXluXxgVdZ1Q2vjxVm/NRlcU8ef+xQKUslYtIQfW6Qc=;
        b=IZ/wXXsDa31bYG6UoNS9CpFL+uhVwziJSkvov9n1PodWcLbTzq2o4HxinMbVRho9ERttdw
        ChQXwCp3VUfIzFRNcMYf/F51akgYLEP/fxUf0AW1yHQHwPL8lub72wJ4ogRPnfz0+0lwKZ
        TfGNAmtWGdEgzwvR+sanAtyCA2xtiL4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-208-xsC7pkQ8Mmm8uZ3wObNXAA-1; Mon, 12 Oct 2020 08:54:29 -0400
X-MC-Unique: xsC7pkQ8Mmm8uZ3wObNXAA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CB0291084D63;
        Mon, 12 Oct 2020 12:54:27 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-251.ams2.redhat.com [10.36.113.251])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ED4DC60C07;
        Mon, 12 Oct 2020 12:54:16 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, virtualization@lists.linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Subject: [PATCH v1 05/29] virtio-mem: generalize check for added memory
Date:   Mon, 12 Oct 2020 14:52:59 +0200
Message-Id: <20201012125323.17509-6-david@redhat.com>
In-Reply-To: <20201012125323.17509-1-david@redhat.com>
References: <20201012125323.17509-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's check by traversing busy system RAM resources instead, to avoid
relying on memory block states.

Don't use walk_system_ram_range(), as that works on pages and we want to
use the bare addresses we have easily at hand.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index b3eebac7191f..6bbd1cfd10d3 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -1749,6 +1749,20 @@ static void virtio_mem_delete_resource(struct virtio_mem *vm)
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
@@ -1870,10 +1884,7 @@ static void virtio_mem_remove(struct virtio_device *vdev)
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

