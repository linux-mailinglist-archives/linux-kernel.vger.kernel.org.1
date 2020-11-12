Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FEE22B06D5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 14:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728656AbgKLNkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 08:40:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:39680 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728428AbgKLNjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 08:39:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605188343;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vdbw4BBnAlXbecdd3kz0Gf6U85wgo73x2VHWlqh8gqU=;
        b=dS9s3rYZOxh+L5NRp8y9k6L5oOZ/Qyqym9W3YYJM8qZNLAokKsCis8WPCEsMQ1/rVYJECP
        1yt41Bfze4XOLel4UH0il4hZaXYqoK88l0Mb7krqpytE89yPf4Z9crhSfawQMWDUuewDLa
        Nbk2ZWMDa5asAHz8uJZQ4B7eTfiL+8g=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-116-BYRt4WzrNyuEdueCGAxQeA-1; Thu, 12 Nov 2020 08:39:01 -0500
X-MC-Unique: BYRt4WzrNyuEdueCGAxQeA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7F976801FD4;
        Thu, 12 Nov 2020 13:39:00 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-115-61.ams2.redhat.com [10.36.115.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AF55075132;
        Thu, 12 Nov 2020 13:38:55 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        "Michael S . Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Jason Wang <jasowang@redhat.com>
Subject: [PATCH v2 12/29] virtio-mem: generalize virtio_mem_owned_mb()
Date:   Thu, 12 Nov 2020 14:37:58 +0100
Message-Id: <20201112133815.13332-13-david@redhat.com>
In-Reply-To: <20201112133815.13332-1-david@redhat.com>
References: <20201112133815.13332-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid using memory block ids. Rename it to virtio_mem_contains_range().

This is a preparation for Big Block Mode (BBM).

Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 3731097cd9e8..2193c5172195 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -512,12 +512,13 @@ static bool virtio_mem_overlaps_range(struct virtio_mem *vm,
 }
 
 /*
- * Test if a virtio-mem device owns a memory block. Can be called from
+ * Test if a virtio-mem device contains a given range. Can be called from
  * (notifier) callbacks lockless.
  */
-static bool virtio_mem_owned_mb(struct virtio_mem *vm, unsigned long mb_id)
+static bool virtio_mem_contains_range(struct virtio_mem *vm, uint64_t start,
+				      uint64_t size)
 {
-	return mb_id >= vm->first_mb_id && mb_id <= vm->last_mb_id;
+	return start >= vm->addr && start + size <= vm->addr + vm->region_size;
 }
 
 static int virtio_mem_notify_going_online(struct virtio_mem *vm,
@@ -871,7 +872,7 @@ static void virtio_mem_online_page_cb(struct page *page, unsigned int order)
 	 */
 	rcu_read_lock();
 	list_for_each_entry_rcu(vm, &virtio_mem_devices, next) {
-		if (!virtio_mem_owned_mb(vm, mb_id))
+		if (!virtio_mem_contains_range(vm, addr, PFN_PHYS(1 << order)))
 			continue;
 
 		sb_id = virtio_mem_phys_to_sb_id(vm, addr);
-- 
2.26.2

