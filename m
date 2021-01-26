Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47BD9304DA5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jan 2021 01:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387470AbhAZXM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 18:12:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729324AbhAZEzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 23:55:09 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69813C061786
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 20:54:29 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id 31so9136507plb.10
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 20:54:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zWzZEjtMI7dPvku+j5LOMBapAYYLqsSnngDI0xcSPtU=;
        b=mdZXnij8j2OhoSuz0AxfBhIxqiB+8yZ9jo3y8Eyh3ODyLDaCAyDWBPMrglhVBGkODv
         Crv1+LoHFbqcgWZZnnx6/1VH42DX6IXP0AbtgUKK9Hwhj8tjohWGrg0iNVALj8E40VLK
         z6I8tpUKtdoi+7EbBR7z/JUJLBMD3LUmZCurMjMSOZR8P46fh+ToDppHamydxYc8CWVv
         qQQ1O7kYy1617y4/KRAXlD3Dehj3QYGfjPvkDOZ6Slt4w9wxY1jLKpBsZbzzv/Ypq2Hv
         oIZDmQy5/Ze9lBQxTJ5oVqFmvxbJD35P165x33/BDl34KS+z/TIglWhWZ3uMMtmNbIwl
         XY8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zWzZEjtMI7dPvku+j5LOMBapAYYLqsSnngDI0xcSPtU=;
        b=kGwd1Go4dzANe7VNl7WAmSDKab/t5AuHAVPTG8/ZoiD/HmcXxFDZoDlCBsXzF4Gdga
         6Sg6MpbmLGJbcss3HAKjeOc/rt7xJfBlsn3xjfq4YnzQxeQnsxg0t8W9YPmv/hXFfaHI
         TJH+VQ5viLFXrCTVwLtCoaA5pTrRwPdRB8wFQ4B3vlJGXHfWC+mIe6kST+/GhCB+BmPZ
         9MsuvWQUlb36dx1TsEH4wBjBaIcD2PuLdkpljPL3psuRxQgmdzFrjmd5lUJbdkmcD6m6
         StJM3ZQX5C9DZheNQ7qS0DdUwUet6HCdNUZVCEhwRlTZxaDIDnVHILY23JO+Az012j/R
         i7Sw==
X-Gm-Message-State: AOAM533za/GJnLS4m/vWvLBJjHSmJFgCi5CoKReQzV85S59TnvaXoDVI
        CXuaP1KJ4yDulhSyS7MKnIc=
X-Google-Smtp-Source: ABdhPJywTkPitOcbrsL64q10OuxjK3xV19FLJoWY/kuHyIiloXjVdY125pYsW/JbsEdfQlC4T2Htig==
X-Received: by 2002:a17:90a:4209:: with SMTP id o9mr4130449pjg.75.1611636869086;
        Mon, 25 Jan 2021 20:54:29 -0800 (PST)
Received: from bobo.ozlabs.ibm.com (192.156.221.203.dial.dynamic.acc50-nort-cbr.comindico.com.au. [203.221.156.192])
        by smtp.gmail.com with ESMTPSA id w184sm18803382pgb.71.2021.01.25.20.54.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 20:54:28 -0800 (PST)
From:   Nicholas Piggin <npiggin@gmail.com>
To:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>
Cc:     Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH 5/5] mm/vmalloc: improve allocation failure error messages
Date:   Tue, 26 Jan 2021 14:54:04 +1000
Message-Id: <20210126045404.2492588-6-npiggin@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20210126045404.2492588-1-npiggin@gmail.com>
References: <20210126045404.2492588-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are several reasons why a vmalloc can fail, virtual space
exhausted, page array allocation failure, page allocation failure,
and kernel page table allocation failure.

Add distinct warning messages for the main causes of failure, with
some added information like page order or allocation size where
applicable.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 mm/vmalloc.c | 40 ++++++++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 5ff190590fe4..4facf582a3be 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2790,6 +2790,10 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 
 	if (!pages) {
 		free_vm_area(area);
+		warn_alloc(gfp_mask, NULL,
+			   "vmalloc size %lu allocation failure: "
+			   "page array size %lu allocation failed",
+			   area->nr_pages * PAGE_SIZE, array_size);
 		return NULL;
 	}
 
@@ -2813,6 +2817,10 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 			/* Successfully allocated i pages, free them in __vfree() */
 			area->nr_pages = i;
 			atomic_long_add(area->nr_pages, &nr_vmalloc_pages);
+			warn_alloc(gfp_mask, NULL,
+				   "vmalloc size %lu allocation failure: "
+				   "page order %u allocation failed",
+				   area->nr_pages * PAGE_SIZE, page_order);
 			goto fail;
 		}
 
@@ -2824,15 +2832,17 @@ static void *__vmalloc_area_node(struct vm_struct *area, gfp_t gfp_mask,
 	}
 	atomic_long_add(area->nr_pages, &nr_vmalloc_pages);
 
-	if (vmap_pages_range(addr, addr + size, prot, pages, page_shift) < 0)
+	if (vmap_pages_range(addr, addr + size, prot, pages, page_shift) < 0) {
+		warn_alloc(gfp_mask, NULL,
+			   "vmalloc size %lu allocation failure: "
+			   "failed to map pages",
+			   area->nr_pages * PAGE_SIZE);
 		goto fail;
+	}
 
 	return area->addr;
 
 fail:
-	warn_alloc(gfp_mask, NULL,
-			  "vmalloc: allocation failure, allocated %ld of %ld bytes",
-			  (area->nr_pages*PAGE_SIZE), size);
 	__vfree(area->addr);
 	return NULL;
 }
@@ -2866,8 +2876,15 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
 	unsigned long real_align = align;
 	unsigned int shift = PAGE_SHIFT;
 
-	if (!size || (size >> PAGE_SHIFT) > totalram_pages())
-		goto fail;
+	if (WARN_ON_ONCE(!size))
+		return NULL;
+
+	if ((size >> PAGE_SHIFT) > totalram_pages()) {
+		warn_alloc(gfp_mask, NULL,
+			   "vmalloc size %lu allocation failure: "
+			   "exceeds total pages", real_size);
+		return NULL;
+	}
 
 	if (vmap_allow_huge && !(vm_flags & VM_NO_HUGE_VMAP) &&
 			arch_vmap_pmd_supported(prot)) {
@@ -2894,8 +2911,12 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
 	size = PAGE_ALIGN(size);
 	area = __get_vm_area_node(size, align, VM_ALLOC | VM_UNINITIALIZED |
 				vm_flags, start, end, node, gfp_mask, caller);
-	if (!area)
+	if (!area) {
+		warn_alloc(gfp_mask, NULL,
+			   "vmalloc size %lu allocation failure: "
+			   "vm_struct allocation failed", real_size);
 		goto fail;
+	}
 
 	addr = __vmalloc_area_node(area, gfp_mask, prot, shift, node);
 	if (!addr)
@@ -2920,11 +2941,6 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
 		goto again;
 	}
 
-	if (!area) {
-		/* Warn for area allocation, page allocations already warn */
-		warn_alloc(gfp_mask, NULL,
-			  "vmalloc: allocation failure: %lu bytes", real_size);
-	}
 	return NULL;
 }
 
-- 
2.23.0

