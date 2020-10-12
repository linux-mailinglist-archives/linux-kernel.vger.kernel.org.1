Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1890D28B51D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 14:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388572AbgJLMyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 08:54:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:20406 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730033AbgJLMyj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 08:54:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602507278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PBVd+cfb+oMQo0gKEyeJIaaM87zvbM5gVEM/HK/ldHU=;
        b=dCG5DKlWgq+WQTC9x1fRBhFyrqfDEWbDZIz3xO3XPu5A2SUA7FjtuPaTRrwGk6ju6rQKX6
        PZrKmMxwxXuJ0HpY4mDk6DZzSbwk47hBbRAxvR0xl51qT0TY2nw01UQBuAhXlAM8Rg3QLn
        a/TcDVRp7GekK5ZTW/PmG+z17pz+cZU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-70-LBUteH8eOUyHpYpDE3qTdg-1; Mon, 12 Oct 2020 08:54:36 -0400
X-MC-Unique: LBUteH8eOUyHpYpDE3qTdg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A497018A8224;
        Mon, 12 Oct 2020 12:54:35 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-251.ams2.redhat.com [10.36.113.251])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1AB4860C07;
        Mon, 12 Oct 2020 12:54:32 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, virtualization@lists.linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Subject: [PATCH v1 08/29] virtio-mem: drop last_mb_id
Date:   Mon, 12 Oct 2020 14:53:02 +0200
Message-Id: <20201012125323.17509-9-david@redhat.com>
In-Reply-To: <20201012125323.17509-1-david@redhat.com>
References: <20201012125323.17509-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No longer used, let's drop it.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 37a0e338ae4a..5c93f8a65eba 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -84,8 +84,6 @@ struct virtio_mem {
 
 	/* Id of the first memory block of this device. */
 	unsigned long first_mb_id;
-	/* Id of the last memory block of this device. */
-	unsigned long last_mb_id;
 	/* Id of the last usable memory block of this device. */
 	unsigned long last_usable_mb_id;
 	/* Id of the next memory bock to prepare when needed. */
@@ -1689,8 +1687,6 @@ static int virtio_mem_init(struct virtio_mem *vm)
 	vm->first_mb_id = virtio_mem_phys_to_mb_id(vm->addr - 1 +
 						   memory_block_size_bytes());
 	vm->next_mb_id = vm->first_mb_id;
-	vm->last_mb_id = virtio_mem_phys_to_mb_id(vm->addr +
-			 vm->region_size) - 1;
 
 	dev_info(&vm->vdev->dev, "start address: 0x%llx", vm->addr);
 	dev_info(&vm->vdev->dev, "region size: 0x%llx", vm->region_size);
-- 
2.26.2

