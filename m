Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B53CD30111D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jan 2021 00:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725969AbhAVXr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 18:47:28 -0500
Received: from mga11.intel.com ([192.55.52.93]:9641 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725911AbhAVXrL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 18:47:11 -0500
IronPort-SDR: rw8z84Tv85/pLEBdxahibf68Z35f8bBk0zmnp9VdBOGpIB/LRxpIpRU/kxLY2dI77tiFpfhswF
 YekXF3C0Htdg==
X-IronPort-AV: E=McAfee;i="6000,8403,9872"; a="176016034"
X-IronPort-AV: E=Sophos;i="5.79,368,1602572400"; 
   d="scan'208";a="176016034"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2021 15:46:29 -0800
IronPort-SDR: 2+eePPLZ2snFipedv5SjeCegN51ErgC+iQKh1xPp9pxaDUCOXm0NlgOKNwBxHP2n9hAB5/5Ev7
 dIpBsJeatnDg==
X-IronPort-AV: E=Sophos;i="5.79,368,1602572400"; 
   d="scan'208";a="367627950"
Received: from rpedgeco-mobl3.amr.corp.intel.com (HELO localhost.intel.com) ([10.212.122.167])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2021 15:46:28 -0800
From:   Rick Edgecombe <rick.p.edgecombe@intel.com>
To:     akpm@linux-foundation.org
Cc:     hch@lst.de, dja@axtens.net, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, willy@infradead.org,
        linmiaohe@huawei.com, Rick Edgecombe <rick.p.edgecombe@intel.com>
Subject: [PATCH v2] mm/vmalloc: Separate put pages and flush VM flags
Date:   Fri, 22 Jan 2021 15:37:06 -0800
Message-Id: <20210122233706.9304-1-rick.p.edgecombe@intel.com>
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

Redefine VM_MAP_PUT_PAGES to have its own value. Also, rearrange things
so flags are less likely to be missed in the future.

Fixes: b944afc9d64d ("mm: add a VM_MAP_PUT_PAGES flag for vmap")
Suggested-by: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
---

[v2]
Changed comment format like suggested by Matthew and listed him as Suggested-by.
Dropped Reviewed-bys because all of the comment changes are different.

 include/linux/vmalloc.h | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 80c0181c411d..cedcda6593f6 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -24,7 +24,8 @@ struct notifier_block;		/* in notifier.h */
 #define VM_UNINITIALIZED	0x00000020	/* vm_struct is not fully initialized */
 #define VM_NO_GUARD		0x00000040      /* don't add guard page */
 #define VM_KASAN		0x00000080      /* has allocated kasan shadow memory */
-#define VM_MAP_PUT_PAGES	0x00000100	/* put pages and free array in vfree */
+#define VM_FLUSH_RESET_PERMS	0x00000100	/* reset direct map and flush TLB on unmap, can't be freed in atomic context */
+#define VM_MAP_PUT_PAGES	0x00000200	/* put pages and free array in vfree */
 
 /*
  * VM_KASAN is used slighly differently depending on CONFIG_KASAN_VMALLOC.
@@ -37,12 +38,6 @@ struct notifier_block;		/* in notifier.h */
  * determine which allocations need the module shadow freed.
  */
 
-/*
- * Memory with VM_FLUSH_RESET_PERMS cannot be freed in an interrupt or with
- * vfree_atomic().
- */
-#define VM_FLUSH_RESET_PERMS	0x00000100      /* Reset direct map and flush TLB on unmap */
-
 /* bits [20..32] reserved for arch specific ioremap internals */
 
 /*
-- 
2.20.1

