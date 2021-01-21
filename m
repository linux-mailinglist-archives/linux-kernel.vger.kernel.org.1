Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30FA32FF2C8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jan 2021 19:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731872AbhAUSDr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jan 2021 13:03:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730887AbhAUNVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jan 2021 08:21:22 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63753C061575
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jan 2021 05:20:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=63CLHf7zjvPRV1A3pYRsrLhDaACd8lpm/i6WY+5CgAk=; b=wVxb+uHqg27IQFOxXd2/qL+lRL
        vrrzxnk//dCzxGYMHb9nsLxsE8JSRqiIYje7uvBHmLVX3SWqZPJXughCuXIuOUfMcTqr/XURvpnQ+
        rAgnmI+H0mxx8MJECTsHng1BctQsop1yNph0NiK/0mIIY70FAHWvv8bU2tGD9wVF29Nfym9RFNkZv
        ihyr00In6p2TvQKEqCtmDlUx1d1G+pARpKPTUZPTtDp3nSo0j3x8kCG8k/gI8WaVEsEeFA1XXZ2Vh
        t2G9J0//LsOAB+pESddolU1cb6SUzje4XaReU5mul96Zxu4P6J9vhh+p0pPhkfVC438qOxf7Rqxxo
        CK4uAVPQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1l2Zs4-00H5CZ-Nf; Thu, 21 Jan 2021 13:19:47 +0000
Date:   Thu, 21 Jan 2021 13:19:32 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     akpm@linux-foundation.org, hch@lst.de, dja@axtens.net,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/vmalloc: Separate put pages and flush VM flags
Message-ID: <20210121131932.GO2260413@casper.infradead.org>
References: <20210121014118.31922-1-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210121014118.31922-1-rick.p.edgecombe@intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 20, 2021 at 05:41:18PM -0800, Rick Edgecombe wrote:
> When VM_MAP_PUT_PAGES was added, it was defined with the same value as
> VM_FLUSH_RESET_PERMS. This doesn't seem like it will cause any big
> functional problems other than some excess flushing for VM_MAP_PUT_PAGES
> allocations.
> 
> Redefine VM_MAP_PUT_PAGES to have its own value. Also, move the comment
> and remove whitespace for VM_KASAN such that the flags lower down are less
> likely to be missed in the future.

Er ... I think the problem was that VM_FLUSH_RESET_PERMS was put away from
all the other flags!

Why not this?

diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
index 938eaf9517e26..458c41b99215e 100644
--- a/include/linux/vmalloc.h
+++ b/include/linux/vmalloc.h
@@ -24,7 +24,8 @@ struct notifier_block;		/* in notifier.h */
 #define VM_UNINITIALIZED	0x00000020	/* vm_struct is not fully initialized */
 #define VM_NO_GUARD		0x00000040      /* don't add guard page */
 #define VM_KASAN		0x00000080      /* has allocated kasan shadow memory */
-#define VM_MAP_PUT_PAGES	0x00000100	/* put pages and free array in vfree */
+#define VM_FLUSH_RESET_PERMS	0x00000100      /* Reset direct map and flush TLB on unmap. cannot be freed in atomic context */
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

