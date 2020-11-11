Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 514842AF421
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 15:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727344AbgKKOx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 09:53:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41941 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727279AbgKKOxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 09:53:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605106424;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3Hsf7UMhD6lshsPcxUgvuFvPmAOlqNJdpUrKbgxNpTM=;
        b=haT7YXCn1cV48CbIrR/kHFhuRSZAuW+0ciDv3AzCi9YsMrHGrj2rhkqvc02q05ciuEXjMg
        kmiQ44bLJchYabdS9gkkSnqMMpNs2KMGLK2fBBC1cOXkwJpfmv/dh1P+hDJC2o9GgbXuvg
        JEYTv1Lyw/akBVQvjS5MifIJ4UkLKVo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-4-5p_oIVPD2UIPJW38q9Qg-1; Wed, 11 Nov 2020 09:53:40 -0500
X-MC-Unique: 4-5p_oIVPD2UIPJW38q9Qg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D8054CFF25;
        Wed, 11 Nov 2020 14:53:38 +0000 (UTC)
Received: from t480s.redhat.com (ovpn-114-151.ams2.redhat.com [10.36.114.151])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 45E3727BB5;
        Wed, 11 Nov 2020 14:53:35 +0000 (UTC)
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
Subject: [PATCH v2 3/8] powerpc/mm: factor out creating/removing linear mapping
Date:   Wed, 11 Nov 2020 15:53:17 +0100
Message-Id: <20201111145322.15793-4-david@redhat.com>
In-Reply-To: <20201111145322.15793-1-david@redhat.com>
References: <20201111145322.15793-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We want to stop abusing memory hotplug infrastructure in memtrace code
to perform allocations and remove the linear mapping. Instead we will use
alloc_contig_pages() and remove the linear mapping manually.

Let's factor out creating/removing the linear mapping into
arch_create_linear_mapping() / arch_remove_linear_mapping() - so in the
future, we might be able to have whole arch_add_memory() /
arch_remove_memory() be implemented in common code.

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
 arch/powerpc/mm/mem.c          | 41 +++++++++++++++++++++++-----------
 include/linux/memory_hotplug.h |  3 +++
 2 files changed, 31 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index 01ec2a252f09..8a86d81f8df0 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -120,34 +120,26 @@ static void flush_dcache_range_chunked(unsigned long start, unsigned long stop,
 	}
 }
 
-int __ref arch_add_memory(int nid, u64 start, u64 size,
-			  struct mhp_params *params)
+int __ref arch_create_linear_mapping(int nid, u64 start, u64 size,
+				     struct mhp_params *params)
 {
-	unsigned long start_pfn = start >> PAGE_SHIFT;
-	unsigned long nr_pages = size >> PAGE_SHIFT;
 	int rc;
 
 	start = (unsigned long)__va(start);
 	rc = create_section_mapping(start, start + size, nid,
 				    params->pgprot);
 	if (rc) {
-		pr_warn("Unable to create mapping for hot added memory 0x%llx..0x%llx: %d\n",
+		pr_warn("Unable to create linear mapping for 0x%llx..0x%llx: %d\n",
 			start, start + size, rc);
 		return -EFAULT;
 	}
-
-	return __add_pages(nid, start_pfn, nr_pages, params);
+	return 0;
 }
 
-void __ref arch_remove_memory(int nid, u64 start, u64 size,
-			     struct vmem_altmap *altmap)
+void __ref arch_remove_linear_mapping(u64 start, u64 size)
 {
-	unsigned long start_pfn = start >> PAGE_SHIFT;
-	unsigned long nr_pages = size >> PAGE_SHIFT;
 	int ret;
 
-	__remove_pages(start_pfn, nr_pages, altmap);
-
 	/* Remove htab bolted mappings for this section of memory */
 	start = (unsigned long)__va(start);
 	flush_dcache_range_chunked(start, start + size, FLUSH_CHUNK_SIZE);
@@ -160,6 +152,29 @@ void __ref arch_remove_memory(int nid, u64 start, u64 size,
 	 */
 	vm_unmap_aliases();
 }
+
+int __ref arch_add_memory(int nid, u64 start, u64 size,
+			  struct mhp_params *params)
+{
+	unsigned long start_pfn = start >> PAGE_SHIFT;
+	unsigned long nr_pages = size >> PAGE_SHIFT;
+	int rc;
+
+	rc = arch_create_linear_mapping(nid, start, size, params);
+	if (rc)
+		return rc;
+	return __add_pages(nid, start_pfn, nr_pages, params);
+}
+
+void __ref arch_remove_memory(int nid, u64 start, u64 size,
+			      struct vmem_altmap *altmap)
+{
+	unsigned long start_pfn = start >> PAGE_SHIFT;
+	unsigned long nr_pages = size >> PAGE_SHIFT;
+
+	__remove_pages(start_pfn, nr_pages, altmap);
+	arch_remove_linear_mapping(start, size);
+}
 #endif
 
 #ifndef CONFIG_NEED_MULTIPLE_NODES
diff --git a/include/linux/memory_hotplug.h b/include/linux/memory_hotplug.h
index d65c6fdc5cfc..00b9e9bd3850 100644
--- a/include/linux/memory_hotplug.h
+++ b/include/linux/memory_hotplug.h
@@ -375,6 +375,9 @@ extern struct page *sparse_decode_mem_map(unsigned long coded_mem_map,
 					  unsigned long pnum);
 extern struct zone *zone_for_pfn_range(int online_type, int nid, unsigned start_pfn,
 		unsigned long nr_pages);
+extern int arch_create_linear_mapping(int nid, u64 start, u64 size,
+				      struct mhp_params *params);
+void arch_remove_linear_mapping(u64 start, u64 size);
 #endif /* CONFIG_MEMORY_HOTPLUG */
 
 #endif /* __LINUX_MEMORY_HOTPLUG_H */
-- 
2.26.2

