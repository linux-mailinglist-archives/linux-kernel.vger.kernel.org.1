Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02A892457B9
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Aug 2020 14:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728919AbgHPMyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Aug 2020 08:54:10 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:60744 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728558AbgHPMxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 08:53:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597582433;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w9ZUZrGsZF4VfyZVqdjH6Ul9tpn6Afno+T7mgrtfMv4=;
        b=Lyi4tuwT5xXZOvvU8RQGCxCUVHZSz0nw6kwrE+4SIVBP7toqNEuF7pppdrLjWKFSdvzQc8
        ESJyoNujL1bClGdFZNKDlBw6u+VEDW6qArs6ElLASd2M8chEQbkPY/ZEvHOg14gZ8r98Pz
        zHdfIOLjUhrizl/F559kiIwjr3mrPY8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-515-Fl5ZwC1-NUGhFFsaik1b7g-1; Sun, 16 Aug 2020 08:53:49 -0400
X-MC-Unique: Fl5ZwC1-NUGhFFsaik1b7g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 324E8801AAE;
        Sun, 16 Aug 2020 12:53:48 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-112-43.ams2.redhat.com [10.36.112.43])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D72DC6E717;
        Sun, 16 Aug 2020 12:53:45 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>,
        Baoquan He <bhe@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        "Michael S . Tsirkin" <mst@redhat.com>, Qian Cai <cai@lca.pw>
Subject: [PATCH v5 2/6] mm/page_isolation: exit early when pageblock is isolated in set_migratetype_isolate()
Date:   Sun, 16 Aug 2020 14:53:29 +0200
Message-Id: <20200816125333.7434-3-david@redhat.com>
In-Reply-To: <20200816125333.7434-1-david@redhat.com>
References: <20200816125333.7434-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Right now, if we have two isolations racing on a pageblock that's in the
MOVABLE zone, we would trigger the WARN_ON_ONCE(). Let's just return
directly, simplifying error handling.

The change was introduced in commit 3d680bdf60a5 ("mm/page_isolation: fix
potential warning from user"). As far as I can see, we currently don't have
alloc_contig_range() users that use the ZONE_MOVABLE (anymore), so it's
currently more a cleanup and a preparation for the future than a fix.

Reviewed-by: Baoquan He <bhe@redhat.com>
Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Acked-by: Mike Kravetz <mike.kravetz@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Qian Cai <cai@lca.pw>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/page_isolation.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index f6d07c5f0d34d..7d7d263ce7f4b 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -29,10 +29,12 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
 	/*
 	 * We assume the caller intended to SET migrate type to isolate.
 	 * If it is already set, then someone else must have raced and
-	 * set it before us.  Return -EBUSY
+	 * set it before us.
 	 */
-	if (is_migrate_isolate_page(page))
-		goto out;
+	if (is_migrate_isolate_page(page)) {
+		spin_unlock_irqrestore(&zone->lock, flags);
+		return -EBUSY;
+	}
 
 	/*
 	 * FIXME: Now, memory hotplug doesn't call shrink_slab() by itself.
@@ -52,7 +54,6 @@ static int set_migratetype_isolate(struct page *page, int migratetype, int isol_
 		ret = 0;
 	}
 
-out:
 	spin_unlock_irqrestore(&zone->lock, flags);
 	if (!ret) {
 		drain_all_pages(zone);
-- 
2.26.2

