Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78C172AF41F
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 15:53:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727324AbgKKOxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 09:53:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:26913 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727311AbgKKOxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 09:53:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605106427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GSQatxuwdd1ehWeHPVVOm8FQ78oIMefwI0KM3vx9OUY=;
        b=VQjhgdHs8AYav6x0BunlQpdNjniSlMa84QKCQbmmskCcw+NzrbDcmdiyRUixiwyhi75nMR
        vl3sr72jrGtSgs+dgodTXcM0GmPpNOfI3TEqU6DhEehdpeaY2QhOKkLMUvcQFBemYY+aMW
        hLfj3Yozo29eK//kkJ1E/xMbRMx+510=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-310-eMn4ZS-3NWCR9QdUC20pPQ-1; Wed, 11 Nov 2020 09:53:43 -0500
X-MC-Unique: eMn4ZS-3NWCR9QdUC20pPQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D269A8049CC;
        Wed, 11 Nov 2020 14:53:41 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-151.ams2.redhat.com [10.36.114.151])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3A9F9380;
        Wed, 11 Nov 2020 14:53:39 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
        David Hildenbrand <david@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Rashmica Gupta <rashmica.g@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Oscar Salvador <osalvador@suse.de>,
        Wei Yang <richard.weiyang@linux.alibaba.com>
Subject: [PATCH v2 4/8] powerpc/mm: protect linear mapping modifications by a mutex
Date:   Wed, 11 Nov 2020 15:53:18 +0100
Message-Id: <20201111145322.15793-5-david@redhat.com>
In-Reply-To: <20201111145322.15793-1-david@redhat.com>
References: <20201111145322.15793-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This code currently relies on mem_hotplug_begin()/mem_hotplug_done() -
create_section_mapping()/remove_section_mapping() implementations
cannot tollerate getting called concurrently.

Let's prepare for callers (memtrace) not holding any such locks (and
don't force them to mess with memory hotplug locks).

Other parts in these functions don't seem to rely on external locking.

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Rashmica Gupta <rashmica.g@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Wei Yang <richard.weiyang@linux.alibaba.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/powerpc/mm/mem.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 8a86d81f8df0..ca5c4b54c366 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -58,6 +58,7 @@
 #define CPU_FTR_NOEXECUTE	0
 #endif
 
+static DEFINE_MUTEX(linear_mapping_mutex);
 unsigned long long memory_limit;
 bool init_mem_is_free;
 
@@ -126,8 +127,10 @@ int __ref arch_create_linear_mapping(int nid, u64 start, u64 size,
 	int rc;
 
 	start = (unsigned long)__va(start);
+	mutex_lock(&linear_mapping_mutex);
 	rc = create_section_mapping(start, start + size, nid,
 				    params->pgprot);
+	mutex_unlock(&linear_mapping_mutex);
 	if (rc) {
 		pr_warn("Unable to create linear mapping for 0x%llx..0x%llx: %d\n",
 			start, start + size, rc);
@@ -144,7 +147,9 @@ void __ref arch_remove_linear_mapping(u64 start, u64 size)
 	start = (unsigned long)__va(start);
 	flush_dcache_range_chunked(start, start + size, FLUSH_CHUNK_SIZE);
 
+	mutex_lock(&linear_mapping_mutex);
 	ret = remove_section_mapping(start, start + size);
+	mutex_unlock(&linear_mapping_mutex);
 	WARN_ON_ONCE(ret);
 
 	/* Ensure all vmalloc mappings are flushed in case they also
-- 
2.26.2

