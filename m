Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D567C28B528
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 14:55:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728213AbgJLMzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 08:55:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:37407 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726495AbgJLMzR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 08:55:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602507316;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GRNzaKNhWih50ca6Rdrr2BHB9XOrtl2sT3OFPr5P+gI=;
        b=efyS3ioR605bHEuAcofYR6OBRgnUioKz9oeC4/geGb9MvAXa1Nd58lp5djvwxeK3GIPNM+
        xR21Ufn/Ea/AQOO74jLnn/IQ+JLIQW9XgrA45LkXfUI1jLOG3uGPap9Y7llytNG5/p+H7m
        SxZbyZYDybCtz3TJinhwOzwjQ3ptnuw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-82-hypicrj3NCq7ZQK3pT2P4g-1; Mon, 12 Oct 2020 08:55:10 -0400
X-MC-Unique: hypicrj3NCq7ZQK3pT2P4g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C1E3464145;
        Mon, 12 Oct 2020 12:55:08 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-251.ams2.redhat.com [10.36.113.251])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 784E460C07;
        Mon, 12 Oct 2020 12:54:58 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, virtualization@lists.linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Subject: [PATCH v1 12/29] virtio-mem: factor out fake-offlining into virtio_mem_fake_offline()
Date:   Mon, 12 Oct 2020 14:53:06 +0200
Message-Id: <20201012125323.17509-13-david@redhat.com>
In-Reply-To: <20201012125323.17509-1-david@redhat.com>
References: <20201012125323.17509-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

... which now matches virtio_mem_fake_online(). We'll reuse this
functionality soon.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index 00d1cfca4713..d132bc54ef57 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -832,6 +832,27 @@ static void virtio_mem_fake_online(unsigned long pfn, unsigned long nr_pages)
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
@@ -1335,17 +1356,10 @@ static int virtio_mem_mb_unplug_sb_online(struct virtio_mem *vm,
 
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

