Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58BA628B51A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 14:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730051AbgJLMyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 08:54:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24533 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727436AbgJLMye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 08:54:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602507273;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sQDWeH2qYFqH9wAdtLA1r7drvKX0EXkimbPBAYSfLvU=;
        b=KIsdUJoE29a0A2voKF2vWkMofS4DCAfkLpVJUTIts6EhVDrJQXiH1o+6y2PCONr3353BPa
        BFJBO2Kzytt/QG8EHxIbXeEPTwcDvdietBjHwhk2ePvFnIq7HRvy81+NzvFhEEy7Lmd6IL
        XqB6HxdgftZLHw0dsFD0SZK1kQempc4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-83-aCYmZaVGOvSMCy6HIaBuKw-1; Mon, 12 Oct 2020 08:54:31 -0400
X-MC-Unique: aCYmZaVGOvSMCy6HIaBuKw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5B2DF1084D60;
        Mon, 12 Oct 2020 12:54:30 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-251.ams2.redhat.com [10.36.113.251])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7957260C07;
        Mon, 12 Oct 2020 12:54:28 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, virtualization@lists.linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Subject: [PATCH v1 06/29] virtio-mem: generalize virtio_mem_owned_mb()
Date:   Mon, 12 Oct 2020 14:53:00 +0200
Message-Id: <20201012125323.17509-7-david@redhat.com>
In-Reply-To: <20201012125323.17509-1-david@redhat.com>
References: <20201012125323.17509-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid using memory block ids. Rename it to virtio_mem_contains_range().

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 6bbd1cfd10d3..821143db14fe 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -500,12 +500,13 @@ static bool virtio_mem_overlaps_range(struct virtio_mem *vm,
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
@@ -800,7 +801,7 @@ static void virtio_mem_online_page_cb(struct page *page, unsigned int order)
 	 */
 	rcu_read_lock();
 	list_for_each_entry_rcu(vm, &virtio_mem_devices, next) {
-		if (!virtio_mem_owned_mb(vm, mb_id))
+		if (!virtio_mem_contains_range(vm, addr, PFN_PHYS(1 << order)))
 			continue;
 
 		sb_id = virtio_mem_phys_to_sb_id(vm, addr);
-- 
2.26.2

