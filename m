Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 545DD2F36A0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 18:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392395AbhALRFz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 12:05:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391806AbhALRFy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 12:05:54 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55229C0617A2;
        Tue, 12 Jan 2021 09:04:54 -0800 (PST)
Message-Id: <20210112170411.281464308@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610471092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=lCQcsUW6BG2TViN9PATPu0nvlehpGiocV+x+/eINNhI=;
        b=iOrQ2yzL7qHCBZMxPC7End9fO2OxSIYpXRwgowQ+kbHLNZtaezvOR94fNwfVroCra3r4Ew
        BP1Ix24/uzar89ES2eJRfzvUGDOwogScWlMzV76pJo8FD6DZNSP85cyJJUT5Z/SvHDfVxQ
        d76g/BhCGzVnTM+e8iRAh+j1uaqXXRNdD/M6HzdNWRAf2nn3Ax/9PBrMTnOwDKJrIpAZif
        inUKRshmheImrOw6IypO8IVb813XGgw6SFS/SebA5YIKRivqRd8RvMNd/pr9H2NbPUqT8r
        GASetIkWO4dF+yELYnO3NATQJmWYI5uCS07afeSQj/9MjvMUb41Lwa0JFXCYMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610471092;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=lCQcsUW6BG2TViN9PATPu0nvlehpGiocV+x+/eINNhI=;
        b=CxIH9jkBW11gEiftSavoeDam6PfkbYmCUt93JwwJEGwDeGCrbr+M/BpvsPEseuYsWR26v1
        MLveZEz3EE/eCIDQ==
Date:   Tue, 12 Jan 2021 18:01:40 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Peter Zijlstra <peterz@infradead.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org,
        Andreas Larsson <andreas@gaisler.com>,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Paul Cercueil <paul@crapouillou.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: [patch 4/4] powerpc/mm/highmem: Use __set_pte_at() for kmap_local()
References: <20210112170136.078559026@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The original PowerPC highmem mapping function used __set_pte_at() to denote
that the mapping is per CPU. This got lost with the conversion to the
generic implementation.

Override the default map function.

Fixes: 47da42b27a56 ("powerpc/mm/highmem: Switch to generic kmap atomic")
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/include/asm/highmem.h |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/powerpc/include/asm/highmem.h
+++ b/arch/powerpc/include/asm/highmem.h
@@ -58,6 +58,8 @@ extern pte_t *pkmap_page_table;
 
 #define flush_cache_kmaps()	flush_cache_all()
 
+#define arch_kmap_local_set_pte(mm, vaddr, ptep, ptev)	\
+	__set_pte_at(mm, vaddr, ptep, ptev, 1)
 #define arch_kmap_local_post_map(vaddr, pteval)	\
 	local_flush_tlb_page(NULL, vaddr)
 #define arch_kmap_local_post_unmap(vaddr)	\

