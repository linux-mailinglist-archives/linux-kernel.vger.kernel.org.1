Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC5D28B52A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 14:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730137AbgJLMzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 08:55:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:56076 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730088AbgJLMzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 08:55:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1602507322;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nfx3E1E8CtjMuP9lMG33p0/a9KgSIqjdfK7bGnmRDXs=;
        b=eBBceP4tpN6lIsBhu2GnDydiR1Ud9iOTgAXczLNcJ6hLWrRtdzFXqyRxJwec33sE7ZPk9C
        JMDydK1Fv72ccEQvxifJyBxWFxjKNGSK0qvxO3hefoK11kGOW9u1sBOTJ0uXfKHOs5/pal
        vHz/QE9oUKbQAHy/Ku5Hd4JbzdyLK0Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-518-OQI5yNW_MnGAQ8K74Zdxcg-1; Mon, 12 Oct 2020 08:55:20 -0400
X-MC-Unique: OQI5yNW_MnGAQ8K74Zdxcg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 866281005E5D;
        Mon, 12 Oct 2020 12:55:19 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-113-251.ams2.redhat.com [10.36.113.251])
        by smtp.corp.redhat.com (Postfix) with ESMTP id DF04E60C07;
        Mon, 12 Oct 2020 12:55:14 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, virtualization@lists.linux-foundation.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Subject: [PATCH v1 14/29] virtio-mem: retry fake-offlining via alloc_contig_range() on ZONE_MOVABLE
Date:   Mon, 12 Oct 2020 14:53:08 +0200
Message-Id: <20201012125323.17509-15-david@redhat.com>
In-Reply-To: <20201012125323.17509-1-david@redhat.com>
References: <20201012125323.17509-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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
index a2124892e510..faeb759687fe 100644
--- a/drivers/virtio/virtio_mem.c
+++ b/drivers/virtio/virtio_mem.c
@@ -823,19 +823,34 @@ static void virtio_mem_fake_online(unsigned long pfn, unsigned long nr_pages)
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

