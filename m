Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6512B069E
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 14:38:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbgKLNio (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 08:38:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37113 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728231AbgKLNii (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 08:38:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605188317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d2mSdn7pISMDFqg3U93U8lx3qPnaYzNUm7eZzD9N/i8=;
        b=c06GUrPvENGF88C6D/+DMn57WY9jeYo7e8Sed3LUIs9zPP1TtN3LpLt+qGoTsA6U8PAQAu
        tiB1uKmk67OkpGAMrQpwtARUDWH4Nne3YXnZYLEpRSgHzB9O4dxptF/KVzqF9UWo8i56Fa
        bw2sIiEkbACQ8YSLwLhZzXGNqm2wrF8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-vAfl626zPMuelm5schgTeQ-1; Thu, 12 Nov 2020 08:38:35 -0500
X-MC-Unique: vAfl626zPMuelm5schgTeQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 84316108E1B3;
        Thu, 12 Nov 2020 13:38:34 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-115-61.ams2.redhat.com [10.36.115.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C553275132;
        Thu, 12 Nov 2020 13:38:32 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        "Michael S . Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Jason Wang <jasowang@redhat.com>
Subject: [PATCH v2 04/29] virtio-mem: drop rc2 in virtio_mem_mb_plug_and_add()
Date:   Thu, 12 Nov 2020 14:37:50 +0100
Message-Id: <20201112133815.13332-5-david@redhat.com>
In-Reply-To: <20201112133815.13332-1-david@redhat.com>
References: <20201112133815.13332-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We can drop rc2, we don't actually need the value.

Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Reviewed-by: Wei Yang <richard.weiyang@linux.alibaba.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 0f9d854e8e42..4f18d9855a0e 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -1070,7 +1070,7 @@ static int virtio_mem_mb_plug_and_add(struct virtio_mem *vm,
 				      uint64_t *nb_sb)
 {
 	const int count = min_t(int, *nb_sb, vm->nb_sb_per_mb);
-	int rc, rc2;
+	int rc;
 
 	if (WARN_ON_ONCE(!count))
 		return -EINVAL;
@@ -1101,13 +1101,12 @@ static int virtio_mem_mb_plug_and_add(struct virtio_mem *vm,
 
 		dev_err(&vm->vdev->dev,
 			"adding memory block %lu failed with %d\n", mb_id, rc);
-		rc2 = virtio_mem_mb_unplug_sb(vm, mb_id, 0, count);
 
 		/*
 		 * TODO: Linux MM does not properly clean up yet in all cases
 		 * where adding of memory failed - especially on -ENOMEM.
 		 */
-		if (rc2)
+		if (virtio_mem_mb_unplug_sb(vm, mb_id, 0, count))
 			new_state = VIRTIO_MEM_MB_STATE_PLUGGED;
 		virtio_mem_mb_set_state(vm, mb_id, new_state);
 		return rc;
-- 
2.26.2

