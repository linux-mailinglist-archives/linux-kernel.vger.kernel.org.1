Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE3482B037A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 12:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728105AbgKLLG6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 06:06:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727973AbgKLK7m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 05:59:42 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85094C0613D1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Nov 2020 02:59:37 -0800 (PST)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605178772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=ZJnfN4cEcmAybNcReCL20ykTWT83n5GELAdx9PmafPs=;
        b=rnSUJLuoocKyE3IDBUNRdgzKwaVLju/BGPUrfVUlfIbvGPmteIVN5IEnlidHYPxKXUUD0k
        ONjJyYQOkU2u/zgp7VXQ+wyXOcSzx25hy2j5+lCoVHit4068+msluljQu3b6n7sFHEiHZg
        Wn2jhZv+QKX+NHCP3YF2WNRpRZYmKDUrhaPjHpEO4rL9LxGE+jwM/fIOsG0nv2LsRUcqq+
        TIa61czX8+eWglWPpf7mnnhGWC5pwl+Gn5X7rP8OYHT0UJmNjL9WtRdMwvftw6xRz6CUiD
        yhqD/Yaf0x520k5WccmvSlO6Uu5hEtIZrdiutzjVKj1wcEQWcP0/K2z0/A7v8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605178772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=ZJnfN4cEcmAybNcReCL20ykTWT83n5GELAdx9PmafPs=;
        b=K9BJVwmATy5vvdIAs0scj4+Fy0vmxBSLcSu8W3avSFTXYvMna4xCpd/OUiNC3f+eWZQKf9
        Vq7hMMe9o+BSQ9Dw==
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     vtolkm@googlemail.com, Andrew Morton <akpm@linux-foundation.org>,
        linux-mm@kvack.org,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH] mm/highmem: Take kmap_high_get() properly into account
Date:   Thu, 12 Nov 2020 11:59:32 +0100
Message-ID: <87y2j6n8mj.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kunmap_local() warns when the virtual address to unmap is below
PAGE_OFFSET. This is correct except for the case that the mapping was
obtained via kmap_high_get() because the PKMAP addresses are right below
PAGE_OFFSET.

Cure it by skipping the WARN_ON() when the unmap was handled by
kunmap_high().

Fixes: 298fa1ad5571 ("highmem: Provide generic variant of kmap_atomic*")
Reported-by: vtolkm@googlemail.com
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 mm/highmem.c |   19 +++++++++++++------
 1 file changed, 13 insertions(+), 6 deletions(-)

--- a/mm/highmem.c
+++ b/mm/highmem.c
@@ -426,12 +426,15 @@ static inline void *arch_kmap_local_high
 #endif
 
 /* Unmap a local mapping which was obtained by kmap_high_get() */
-static inline void kmap_high_unmap_local(unsigned long vaddr)
+static inline bool kmap_high_unmap_local(unsigned long vaddr)
 {
 #ifdef ARCH_NEEDS_KMAP_HIGH_GET
-	if (vaddr >= PKMAP_ADDR(0) && vaddr < PKMAP_ADDR(LAST_PKMAP))
+	if (vaddr >= PKMAP_ADDR(0) && vaddr < PKMAP_ADDR(LAST_PKMAP)) {
 		kunmap_high(pte_page(pkmap_page_table[PKMAP_NR(vaddr)]));
+		return true;
+	}
 #endif
+	return false;
 }
 
 static inline int kmap_local_calc_idx(int idx)
@@ -491,10 +494,14 @@ void kunmap_local_indexed(void *vaddr)
 
 	if (addr < __fix_to_virt(FIX_KMAP_END) ||
 	    addr > __fix_to_virt(FIX_KMAP_BEGIN)) {
-		WARN_ON_ONCE(addr < PAGE_OFFSET);
-
-		/* Handle mappings which were obtained by kmap_high_get() */
-		kmap_high_unmap_local(addr);
+		/*
+		 * Handle mappings which were obtained by kmap_high_get()
+		 * first as the virtual address of such mappings is below
+		 * PAGE_OFFSET. Warn for all other addresses which are in
+		 * the user space part of the virtual address space.
+		 */
+		if (!kmap_high_unmap_local(addr))
+			WARN_ON_ONCE(addr < PAGE_OFFSET);
 		return;
 	}
 
