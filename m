Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5F12B06D7
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 14:41:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728233AbgKLNkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 08:40:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32287 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728377AbgKLNi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 08:38:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605188337;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=s7b/l63zYUaR+OsccnXVvZ/uAYcvm6kvDksVTa1Mbhc=;
        b=QpLxOCK42KkRMngF7D57VFnVqFHpfbg7CbWaPBy4PjJ2HnjGhzlnVYMNz9ucZAie08Y1eV
        PUyy1J8pDgV6iP340m4CcCCn4z/ml1cLGsnk6Wt9y8u7FPcnkGHhFAUIXxpQqS/qvQVIjt
        X9pEN2L8ydSASkXc7u4UKqeeGaiQbJ4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-19-IhACjZgxNUGOglFtNSkyqg-1; Thu, 12 Nov 2020 08:38:54 -0500
X-MC-Unique: IhACjZgxNUGOglFtNSkyqg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5257018BA282;
        Thu, 12 Nov 2020 13:38:53 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-115-61.ams2.redhat.com [10.36.115.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C589655765;
        Thu, 12 Nov 2020 13:38:51 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        "Michael S . Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Subject: [PATCH v2 10/29] virtio-mem: retry fake-offlining via alloc_contig_range() on ZONE_MOVABLE
Date:   Thu, 12 Nov 2020 14:37:56 +0100
Message-Id: <20201112133815.13332-11-david@redhat.com>
In-Reply-To: <20201112133815.13332-1-david@redhat.com>
References: <20201112133815.13332-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ZONE_MOVABLE is supposed to give some guarantees, yet,
alloc_contig_range() isn't prepared to properly deal with some racy
cases properly (e.g., temporary page pinning when exiting processed, PCP).

Retry 5 times for now. There is certainly room for improvement in the
future.

Cc: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/virtio_mem.c | 37 ++++++++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 11 deletions(-)

diff --git a/drivers/virtio/virtio_mem.c b/drivers/virtio/virtio_mem.c
index c24055248f9d..2f1ce4d4781b 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -784,19 +784,34 @@ static void virtio_mem_fake_online(unsigned long pfn, unsigned long nr_pages)
  */
 static int virtio_mem_fake_offline(unsigned long pfn, unsigned long nr_pages)
 {
-	int rc;
+	const bool is_movable = zone_idx(page_zone(pfn_to_page(pfn))) ==
+				ZONE_MOVABLE;
+	int rc, retry_count;
 
-	rc = alloc_contig_range(pfn, pfn + nr_pages, MIGRATE_MOVABLE,
-				GFP_KERNEL);
-	if (rc == -ENOMEM)
-		/* whoops, out of memory */
-		return rc;
-	if (rc)
-		return -EBUSY;
+	/*
+	 * TODO: We want an alloc_contig_range() mode that tries to allocate
+	 * harder (e.g., dealing with temporarily pinned pages, PCP), especially
+	 * with ZONE_MOVABLE. So for now, retry a couple of times with
+	 * ZONE_MOVABLE before giving up - because that zone is supposed to give
+	 * some guarantees.
+	 */
+	for (retry_count = 0; retry_count < 5; retry_count++) {
+		rc = alloc_contig_range(pfn, pfn + nr_pages, MIGRATE_MOVABLE,
+					GFP_KERNEL);
+		if (rc == -ENOMEM)
+			/* whoops, out of memory */
+			return rc;
+		else if (rc && !is_movable)
+			break;
+		else if (rc)
+			continue;
 
-	virtio_mem_set_fake_offline(pfn, nr_pages, true);
-	adjust_managed_page_count(pfn_to_page(pfn), -nr_pages);
-	return 0;
+		virtio_mem_set_fake_offline(pfn, nr_pages, true);
+		adjust_managed_page_count(pfn_to_page(pfn), -nr_pages);
+		return 0;
+	}
+
+	return -EBUSY;
 }
 
 /*
-- 
2.26.2

