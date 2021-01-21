Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4614B2FDFB8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 03:57:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436653AbhAUCB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jan 2021 21:01:57 -0500
Received: from mga17.intel.com ([192.55.52.151]:22094 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392363AbhAUBnN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jan 2021 20:43:13 -0500
IronPort-SDR: xnv54pVLWKlM+wz0zlvLDNdRxLc3vhn5BXKQogmWXZd2E3rAdC/b3rKU5ICi9tLk2doPmWr3XD
 JyGc+OK7uAjw==
X-IronPort-AV: E=McAfee;i="6000,8403,9870"; a="158979047"
X-IronPort-AV: E=Sophos;i="5.79,362,1602572400"; 
   d="scan'208";a="158979047"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2021 17:42:17 -0800
IronPort-SDR: 1OihG1Kgjr1KhWtwdRu0DPbq77xHsbumzcNymwn3HECK9ZEZsaqd9WQWTDJVl5CROmi2MZwWa+
 CaEp/RkGxJKA==
X-IronPort-AV: E=Sophos;i="5.79,362,1602572400"; 
   d="scan'208";a="351295429"
Received: from rpedgeco-mobl3.amr.corp.intel.com (HELO localhost.intel.com) ([10.212.106.147])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jan 2021 17:42:16 -0800
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     akpm@linux-foundation.org
Cc:     hch@lst.de, dja@axtens.net, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [PATCH] mm/vmalloc: Separate put pages and flush VM flags
Date:   Wed, 20 Jan 2021 17:41:18 -0800
Message-Id: <20210121014118.31922-1-rick.p.edgecombe@intel.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When VM_MAP_PUT_PAGES was added, it was defined with the same value as
VM_FLUSH_RESET_PERMS. This doesn't seem like it will cause any big
functional problems other than some excess flushing for VM_MAP_PUT_PAGES
allocations.

Redefine VM_MAP_PUT_PAGES to have its own value. Also, move the comment
and remove whitespace for VM_KASAN such that the flags lower down are less
likely to be missed in the future.

Fixes: b944afc9d64d ("mm: add a VM_MAP_PUT_PAGES flag for vmap")
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---
 include/linux/vmalloc.h | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 80c0181c411d..0b3dd135aa5d 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -23,9 +23,6 @@ struct notifier_block;		/* in notifier.h */
 #define VM_DMA_COHERENT		0x00000010	/* dma_alloc_coherent */
 #define VM_UNINITIALIZED	0x00000020	/* vm_struct is not fully initialized */
 #define VM_NO_GUARD		0x00000040      /* don't add guard page */
-#define VM_KASAN		0x00000080      /* has allocated kasan shadow memory */
-#define VM_MAP_PUT_PAGES	0x00000100	/* put pages and free array in vfree */
-
 /*
  * VM_KASAN is used slighly differently depending on CONFIG_KASAN_VMALLOC.
  *
@@ -36,12 +33,13 @@ struct notifier_block;		/* in notifier.h */
  * Otherwise, VM_KASAN is set for kasan_module_alloc() allocations and used to
  * determine which allocations need the module shadow freed.
  */
-
+#define VM_KASAN		0x00000080      /* has allocated kasan shadow memory */
 /*
  * Memory with VM_FLUSH_RESET_PERMS cannot be freed in an interrupt or with
  * vfree_atomic().
  */
 #define VM_FLUSH_RESET_PERMS	0x00000100      /* Reset direct map and flush TLB on unmap */
+#define VM_MAP_PUT_PAGES	0x00000200	/* put pages and free array in vfree */
 
 /* bits [20..32] reserved for arch specific ioremap internals */
 
-- 
2.20.1

