Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 173483004C9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 15:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728088AbhAVODj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 09:03:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34348 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728102AbhAVOBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 09:01:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611324016;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=OYKXe0LwvkCV6oYZjgb0l0tdopJgegZlST8zSrtCleo=;
        b=G7xscyVGbAyQNn++4tv8/Z/p6wBcWV9/KGvCAPvmSkdFqJ/OKN84dteWKE3mQ0AOztOFo/
        G+5KIlfLvVnQ+G+1OzCEdfBfi+J/f3NN2RE3vto+WR3PdA0y9GtS/pK1SxssyPpchuWrS1
        aQyvUxGqpeTa+VQ1ofYEZ+16QhqU1U4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-50-SzsDFnbcM0eOXizJp8UA6A-1; Fri, 22 Jan 2021 09:00:11 -0500
X-MC-Unique: SzsDFnbcM0eOXizJp8UA6A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ABDD1806661;
        Fri, 22 Jan 2021 14:00:10 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-114.pek2.redhat.com [10.72.12.114])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2FE0519C59;
        Fri, 22 Jan 2021 14:00:07 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, rppt@kernel.org,
        david@redhat.com, bhe@redhat.com, lkp@intel.com
Subject: [PATCH v5 1/5] mm: fix prototype warning from kernel test robot
Date:   Fri, 22 Jan 2021 21:59:52 +0800
Message-Id: <20210122135956.5946-2-bhe@redhat.com>
In-Reply-To: <20210122135956.5946-1-bhe@redhat.com>
References: <20210122135956.5946-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel test robot calling make with 'W=1' is triggering warning like
below for memmap_init_zone() function.

mm/page_alloc.c:6259:23: warning: no previous prototype for 'memmap_init_zone' [-Wmissing-prototypes]
 6259 | void __meminit __weak memmap_init_zone(unsigned long size, int nid,
      |                       ^~~~~~~~~~~~~~~~

Fix it by adding the function declaration in include/linux/mm.h.
Since memmap_init_zone() has a generic version with '__weak',
the declaratoin in ia64 header file can be simply removed.

Signed-off-by: Baoquan He <bhe@redhat.com>
Reported-by: kernel test robot <lkp@intel.com>
---
 arch/ia64/include/asm/pgtable.h | 6 ------
 include/linux/mm.h              | 2 ++
 2 files changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/ia64/include/asm/pgtable.h b/arch/ia64/include/asm/pgtable.h
index 779b6972aa84..9b4efe89e62d 100644
--- a/arch/ia64/include/asm/pgtable.h
+++ b/arch/ia64/include/asm/pgtable.h
@@ -517,12 +517,6 @@ extern struct page *zero_page_memmap_ptr;
 	__changed;							\
 })
 #endif
-
-#  ifdef CONFIG_VIRTUAL_MEM_MAP
-  /* arch mem_map init routine is needed due to holes in a virtual mem_map */
-    extern void memmap_init (unsigned long size, int nid, unsigned long zone,
-			     unsigned long start_pfn);
-#  endif /* CONFIG_VIRTUAL_MEM_MAP */
 # endif /* !__ASSEMBLY__ */
 
 /*
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 3dac7bc667ee..3d82b4f7cabc 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2401,6 +2401,8 @@ extern void set_dma_reserve(unsigned long new_dma_reserve);
 extern void memmap_init_zone(unsigned long, int, unsigned long,
 		unsigned long, unsigned long, enum meminit_context,
 		struct vmem_altmap *, int migratetype);
+extern void memmap_init(unsigned long size, int nid,
+		unsigned long zone, unsigned long range_start_pfn);
 extern void setup_per_zone_wmarks(void);
 extern int __meminit init_per_zone_wmark_min(void);
 extern void mem_init(void);
-- 
2.17.2

