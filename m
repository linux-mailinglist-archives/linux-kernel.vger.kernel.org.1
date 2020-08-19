Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 150002499EA
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Aug 2020 12:12:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgHSKMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Aug 2020 06:12:15 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:52343 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726873AbgHSKMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 06:12:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597831931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r5QdeRbhHn2AlG5sAKVL8b/64x3iAtlaAAOFCdmmchM=;
        b=O+fmKQvFYR0cTVdgAcz9mPboc0+7gyhugZVkVICgi+s/va965C1jOvnDyhqq9GJlZ5KYyl
        6TD+hi2R+lCAl20vFaZ/h6GgT2ABtnC60RRS7gMy6c9SsQeLbCd4uAvVQuE6l/4s/XL39Z
        bYOIn2woGKKClG3InUsPt71MZcOtf0c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-52-rydfKskhNaaioFQJluNu2Q-1; Wed, 19 Aug 2020 06:12:09 -0400
X-MC-Unique: rydfKskhNaaioFQJluNu2Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 52B811084C8F;
        Wed, 19 Aug 2020 10:12:08 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-11.ams2.redhat.com [10.36.114.11])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7AC4C16597;
        Wed, 19 Aug 2020 10:12:06 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Wei Yang <richard.weiyang@linux.alibaba.com>,
        Baoquan He <bhe@redhat.com>,
        Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
        Oscar Salvador <osalvador@suse.de>
Subject: [PATCH v1 01/11] mm/memory_hotplug: inline __offline_pages() into offline_pages()
Date:   Wed, 19 Aug 2020 12:11:47 +0200
Message-Id: <20200819101157.12723-2-david@redhat.com>
In-Reply-To: <20200819101157.12723-1-david@redhat.com>
References: <20200819101157.12723-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is only a single user, offline_pages(). Let's inline, to make
it look more similar to online_pages().

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
Cc: Baoquan He <bhe@redhat.com>
Cc: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc: Oscar Salvador <osalvador@suse.de>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 mm/memory_hotplug.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index 7f62d69660e06..c781d386d87f9 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1473,11 +1473,10 @@ static int count_system_ram_pages_cb(unsigned long start_pfn,
 	return 0;
 }
 
-static int __ref __offline_pages(unsigned long start_pfn,
-		  unsigned long end_pfn)
+int __ref offline_pages(unsigned long start_pfn, unsigned long nr_pages)
 {
-	unsigned long pfn, nr_pages = 0;
-	unsigned long offlined_pages = 0;
+	const unsigned long end_pfn = start_pfn + nr_pages;
+	unsigned long pfn, system_ram_pages = 0, offlined_pages = 0;
 	int ret, node, nr_isolate_pageblock;
 	unsigned long flags;
 	struct zone *zone;
@@ -1494,9 +1493,9 @@ static int __ref __offline_pages(unsigned long start_pfn,
 	 * memory holes PG_reserved, don't need pfn_valid() checks, and can
 	 * avoid using walk_system_ram_range() later.
 	 */
-	walk_system_ram_range(start_pfn, end_pfn - start_pfn, &nr_pages,
+	walk_system_ram_range(start_pfn, nr_pages, &system_ram_pages,
 			      count_system_ram_pages_cb);
-	if (nr_pages != end_pfn - start_pfn) {
+	if (system_ram_pages != nr_pages) {
 		ret = -EINVAL;
 		reason = "memory holes";
 		goto failed_removal;
@@ -1631,11 +1630,6 @@ static int __ref __offline_pages(unsigned long start_pfn,
 	return ret;
 }
 
-int offline_pages(unsigned long start_pfn, unsigned long nr_pages)
-{
-	return __offline_pages(start_pfn, start_pfn + nr_pages);
-}
-
 static int check_memblock_offlined_cb(struct memory_block *mem, void *arg)
 {
 	int ret = !is_memblock_offlined(mem);
-- 
2.26.2

