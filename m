Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD1E2F369E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 18:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392344AbhALRFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 12:05:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392242AbhALRFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 12:05:31 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8E6C061794;
        Tue, 12 Jan 2021 09:04:50 -0800 (PST)
Message-Id: <20210112170410.905976187@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610471089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=BjHyx3TQA52ByPsCeTq6N8/6SlSmPZzIU106dD0/fYw=;
        b=ORqdfppD06eQ0ZtlbH7MYyPKjna93z9ENP0IyxUC4Iw+h8mTmFOQEoeWffNqPwJ05tpoTf
        BxSBtF0qLne6qr+iL9EF/A2QjbTRAvrPrA803FWgEdZ3cx74FSjnNeeCHqsml+N5I0eSlK
        Y1m+lZE8U9RRJxBqUeoPi8PANlp2ZUfN3FoMXFuwzT0271iX6iIIePHqCZ5FT4LdgqabFo
        boArQRMp3xXzOvXBeXDsoKUvbI8AjYR2vOvjCyJWmgTpopFj+73MUQj/VKElVv7DgMIiIu
        HVXrTc2BdN9e0ttqxo1T9zkDesqgXxOvpuA9ceXRlD5ek2kdBO8rK4uq5D5NEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610471089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=BjHyx3TQA52ByPsCeTq6N8/6SlSmPZzIU106dD0/fYw=;
        b=J0FN5ZDzaq16C8M0zmNKp9Th8jxUyTdPHrkY+b/W+4Hf8ZWFnW/gJMBR3JEy3Xo18wKTAQ
        Rcs6OW9e4Kkiz/Dw==
Date:   Tue, 12 Jan 2021 18:01:37 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Peter Zijlstra <peterz@infradead.org>,
        Andreas Larsson <andreas@gaisler.com>,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org
Subject: [patch 1/4] sparc/mm/highmem: Flush cache and TLB
References: <20210112170136.078559026@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The recent conversion to the generic kmap_local infrastructure failed to
assign the proper pre/post map/unmap flush operations for sparc.

Sparc requires cache flush before map/unmap and tlb flush afterwards.

Fixes: 3293efa97807 ("sparc/mm/highmem: Switch to generic kmap atomic")
Reported-by: Andreas Larsson <andreas@gaisler.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
---
 arch/sparc/include/asm/highmem.h |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

--- a/arch/sparc/include/asm/highmem.h
+++ b/arch/sparc/include/asm/highmem.h
@@ -50,10 +50,11 @@ extern pte_t *pkmap_page_table;
 
 #define flush_cache_kmaps()	flush_cache_all()
 
-/* FIXME: Use __flush_tlb_one(vaddr) instead of flush_cache_all() -- Anton */
-#define arch_kmap_local_post_map(vaddr, pteval)	flush_cache_all()
-#define arch_kmap_local_post_unmap(vaddr)	flush_cache_all()
-
+/* FIXME: Use __flush_*_one(vaddr) instead of flush_*_all() -- Anton */
+#define arch_kmap_local_pre_map(vaddr, pteval)	flush_cache_all()
+#define arch_kmap_local_pre_unmap(vaddr)	flush_cache_all()
+#define arch_kmap_local_post_map(vaddr, pteval)	flush_tlb_all()
+#define arch_kmap_local_post_unmap(vaddr)	flush_tlb_all()
 
 #endif /* __KERNEL__ */
 

