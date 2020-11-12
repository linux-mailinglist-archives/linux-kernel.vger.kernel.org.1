Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79E4B2B06AC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 14:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728433AbgKLNjF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 08:39:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59037 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728388AbgKLNix (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 08:38:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605188332;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=whRB7fqvEtHYEsoDQkuEHgauodp8esw7rtmEk6rZXVc=;
        b=JSEA0OstQUt+UHV/s5TSlGU6Xh0310ZBx9EW4eTtQg82OjT0JkSB8mXQQs5wVl4GM+7jHP
        4XvFAJO4eztQUro8IiSxudMLAxA+V6Ra0Atxjc9LEN0PN0ttice05dxjg4gZasTMW5qOEt
        fBibG2vb/UL1xKTIOo+QNrD3oBA5pno=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-0Z8WCwcuNXyAJtPJYsPZ1A-1; Thu, 12 Nov 2020 08:38:50 -0500
X-MC-Unique: 0Z8WCwcuNXyAJtPJYsPZ1A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 742FA107ACF8;
        Thu, 12 Nov 2020 13:38:49 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-115-61.ams2.redhat.com [10.36.115.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id AAB4955765;
        Thu, 12 Nov 2020 13:38:47 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        "Michael S . Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Jason Wang <jasowang@redhat.com>
Subject: [PATCH v2 08/29] virtio-mem: factor out fake-offlining into virtio_mem_fake_offline()
Date:   Thu, 12 Nov 2020 14:37:54 +0100
Message-Id: <20201112133815.13332-9-david@redhat.com>
In-Reply-To: <20201112133815.13332-1-david@redhat.com>
References: <20201112133815.13332-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

... which now matches virtio_mem_fake_online(). We'll reuse this
functionality soon.

Reviewed-by: Wei Yang <richard.weiyang@linux.alibaba.com>
Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 4742497feff0..fedfea27967e 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -793,6 +793,27 @@ static void virtio_mem_fake_online(unsigned long pfn, unsigned long nr_pages)
 	}
 }
 
+/*
+ * Try to allocate a range, marking pages fake-offline, effectively
+ * fake-offlining them.
+ */
+static int virtio_mem_fake_offline(unsigned long pfn, unsigned long nr_pages)
+{
+	int rc;
+
+	rc = alloc_contig_range(pfn, pfn + nr_pages, MIGRATE_MOVABLE,
+				GFP_KERNEL);
+	if (rc == -ENOMEM)
+		/* whoops, out of memory */
+		return rc;
+	if (rc)
+		return -EBUSY;
+
+	virtio_mem_set_fake_offline(pfn, nr_pages, true);
+	adjust_managed_page_count(pfn_to_page(pfn), -nr_pages);
+	return 0;
+}
+
 static void virtio_mem_online_page_cb(struct page *page, unsigned int order)
 {
 	const unsigned long addr = page_to_phys(page);
@@ -1328,17 +1349,10 @@ static int virtio_mem_mb_unplug_sb_online(struct virtio_mem *vm,
 
 	start_pfn = PFN_DOWN(virtio_mem_mb_id_to_phys(mb_id) +
 			     sb_id * vm->subblock_size);
-	rc = alloc_contig_range(start_pfn, start_pfn + nr_pages,
-				MIGRATE_MOVABLE, GFP_KERNEL);
-	if (rc == -ENOMEM)
-		/* whoops, out of memory */
-		return rc;
-	if (rc)
-		return -EBUSY;
 
-	/* Mark it as fake-offline before unplugging it */
-	virtio_mem_set_fake_offline(start_pfn, nr_pages, true);
-	adjust_managed_page_count(pfn_to_page(start_pfn), -nr_pages);
+	rc = virtio_mem_fake_offline(start_pfn, nr_pages);
+	if (rc)
+		return rc;
 
 	/* Try to unplug the allocated memory */
 	rc = virtio_mem_mb_unplug_sb(vm, mb_id, sb_id, count);
-- 
2.26.2

