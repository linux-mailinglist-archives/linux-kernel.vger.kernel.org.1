Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC9752B06D4
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 14:40:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728463AbgKLNkl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 08:40:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40497 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728446AbgKLNjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 08:39:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605188352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1De/72jTC48N8FUN7AbAzRMLH8HlAk91PIa2MW/wHTs=;
        b=K2OKfhGPqOZwgrQHm9jizZHh8xNCAkDSKjX5Zr5L/om1Il9jFK5Fr4h7+BFRPX+dN2yP9I
        3YHzDgMgBytuO7pWnKY7vadNw0ITsGexg/FmLmnQE6yLu4+hGv0UpMnMzkGSOaCmuIYzMp
        cKacr76kVL0CSKJE7qCqkllnU/+U16Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-567-1YgB8SiAMnCT6Tzuw_w-lA-1; Thu, 12 Nov 2020 08:39:08 -0500
X-MC-Unique: 1YgB8SiAMnCT6Tzuw_w-lA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 93B78CE642;
        Thu, 12 Nov 2020 13:39:07 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-115-61.ams2.redhat.com [10.36.115.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DEFB655765;
        Thu, 12 Nov 2020 13:39:05 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        "Michael S . Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Jason Wang <jasowang@redhat.com>
Subject: [PATCH v2 14/29] virtio-mem: drop last_mb_id
Date:   Thu, 12 Nov 2020 14:38:00 +0100
Message-Id: <20201112133815.13332-15-david@redhat.com>
In-Reply-To: <20201112133815.13332-1-david@redhat.com>
References: <20201112133815.13332-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No longer used, let's drop it.

Reviewed-by: Wei Yang <richard.weiyang@linux.alibaba.com>
Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index bd76aa79a82e..a7beac5942e0 100644
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
@@ -1773,8 +1771,6 @@ static int virtio_mem_init(struct virtio_mem *vm)
 	vm->first_mb_id = virtio_mem_phys_to_mb_id(vm->addr - 1 +
 						   memory_block_size_bytes());
 	vm->next_mb_id = vm->first_mb_id;
-	vm->last_mb_id = virtio_mem_phys_to_mb_id(vm->addr +
-			 vm->region_size) - 1;
 
 	dev_info(&vm->vdev->dev, "start address: 0x%llx", vm->addr);
 	dev_info(&vm->vdev->dev, "region size: 0x%llx", vm->region_size);
-- 
2.26.2

