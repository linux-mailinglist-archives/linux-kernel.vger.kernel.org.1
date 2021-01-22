Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B09DA2FFD06
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 08:06:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbhAVHFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 02:05:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23910 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725854AbhAVHFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 02:05:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1611299048;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=t0hnQctGK3X4UR3EE/GNiX86ft/Eizbru1y+p4vYcF4=;
        b=Or7M7UQoSqbAx6sHnDeOIP7VshULSMyF3DJsB+mkbOh8zXHNwZqKnxpNbM21+A6TJgAz02
        rvWVISEABNVeFPAFTgRMbaVolJ8GVe1BHRb9qeW5P/Hh3zKg8qLVu3N5xsdNfmRnfFIokK
        NYQcOkEmvDxMxWtzgjRkGrn1AY39v/s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-356-KQZMHtASNIeQIaG8ko2wIA-1; Fri, 22 Jan 2021 02:04:04 -0500
X-MC-Unique: KQZMHtASNIeQIaG8ko2wIA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 344031DDE0;
        Fri, 22 Jan 2021 07:04:03 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-183.pek2.redhat.com [10.72.12.183])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 21518100238C;
        Fri, 22 Jan 2021 07:04:00 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, rppt@kernel.org,
        bhe@redhat.com
Subject: [PATCH] mm: fix prototype warning from kernel test robot
Date:   Fri, 22 Jan 2021 15:03:59 +0800
Message-Id: <20210122070359.24010-1-bhe@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kernel test robot calling make with 'W=1' triggering warning like below
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
 arch/ia64/include/asm/pgtable.h | 5 -----
 include/linux/mm.h              | 1 +
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/ia64/include/asm/pgtable.h b/arch/ia64/include/asm/pgtable.h
index 2c81394a2430..9b4efe89e62d 100644
--- a/arch/ia64/include/asm/pgtable.h
+++ b/arch/ia64/include/asm/pgtable.h
@@ -517,11 +517,6 @@ extern struct page *zero_page_memmap_ptr;
 	__changed;							\
 })
 #endif
-
-#  ifdef CONFIG_VIRTUAL_MEM_MAP
-  /* arch mem_map init routine is needed due to holes in a virtual mem_map */
-    extern void memmap_init_zone(struct zone *zone);
-#  endif /* CONFIG_VIRTUAL_MEM_MAP */
 # endif /* !__ASSEMBLY__ */
 
 /*
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 56bb239f9150..073049bd0b29 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2401,6 +2401,7 @@ extern void set_dma_reserve(unsigned long new_dma_reserve);
 extern void memmap_init_range(unsigned long, int, unsigned long,
 		unsigned long, unsigned long, enum meminit_context,
 		struct vmem_altmap *, int migratetype);
+extern void memmap_init_zone(struct zone *zone);
 extern void setup_per_zone_wmarks(void);
 extern int __meminit init_per_zone_wmark_min(void);
 extern void mem_init(void);
-- 
2.17.2

