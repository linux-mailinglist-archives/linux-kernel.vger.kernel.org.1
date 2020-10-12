Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5F728B51C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 14:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730065AbgJLMym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 08:54:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58781 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729992AbgJLMyi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 08:54:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602507277;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x476fsOPtDKoPzdDWx2OPPtKsSqlx/nZAGKrnlXmEL8=;
        b=jGEv3F24F7KHbFNr6bKOeWSXf61hvF7R7QIMbQ8RKMokxFxGTcJTvLgHgq2IxjWlEWhDk2
        KurrHrJo7MeBTP33bwfuKYZZy6LZsZ0ilKVk9AyTNwCZsBTP3hCA0l2xJmX7kDwPpCfS52
        tD15+Roh9fHN4xBos3LHyh/qCadfWKk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-587-8V6AV1PQPDGtM5KwMzCx3Q-1; Mon, 12 Oct 2020 08:54:34 -0400
X-MC-Unique: 8V6AV1PQPDGtM5KwMzCx3Q-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AEC8080B713;
        Mon, 12 Oct 2020 12:54:32 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-251.ams2.redhat.com [10.36.113.251])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D6A2360C07;
        Mon, 12 Oct 2020 12:54:30 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, virtualization@lists.linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Subject: [PATCH v1 07/29] virtio-mem: generalize virtio_mem_overlaps_range()
Date:   Mon, 12 Oct 2020 14:53:01 +0200
Message-Id: <20201012125323.17509-8-david@redhat.com>
In-Reply-To: <20201012125323.17509-1-david@redhat.com>
References: <20201012125323.17509-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid using memory block ids. While at it, use uint64_t for
address/size.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 821143db14fe..37a0e338ae4a 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -489,14 +489,10 @@ static int virtio_mem_translate_node_id(struct virtio_mem *vm, uint16_t node_id)
  * Test if a virtio-mem device overlaps with the given range. Can be called
  * from (notifier) callbacks lockless.
  */
-static bool virtio_mem_overlaps_range(struct virtio_mem *vm,
-				      unsigned long start, unsigned long size)
+static bool virtio_mem_overlaps_range(struct virtio_mem *vm, uint64_t start,
+				      uint64_t size)
 {
-	unsigned long dev_start = virtio_mem_mb_id_to_phys(vm->first_mb_id);
-	unsigned long dev_end = virtio_mem_mb_id_to_phys(vm->last_mb_id) +
-				memory_block_size_bytes();
-
-	return start < dev_end && dev_start < start + size;
+	return start < vm->addr + vm->region_size && vm->addr < start + size;
 }
 
 /*
-- 
2.26.2

