Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84F702F369B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jan 2021 18:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392327AbhALRFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 12:05:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392288AbhALRFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 12:05:33 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08F91C06179F;
        Tue, 12 Jan 2021 09:04:53 -0800 (PST)
Message-Id: <20210112170411.187513575@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610471091;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=pTk1FcH5+/wyB8HB1QRJBoXsx85zfAu4dJubIkq5SzI=;
        b=gXKVOF3fh+FZwnz+sbLIbpsIqGtmfmcazChwcDdjZCPkH513hGnuY50e8hxBerCj+Wozq6
        WjgYTVQGcNu19gSVoPSMUUdPEFQ6UewzPdWwBUpbQGo2dR9GuoXtYO5tLQghs+5Gjdhfvn
        apTCXHcWAlg1m4tdfKh2Fgae4QM+vz+2vlBm4AaiqkvBvmXsD/lmVr2DpvbTvOmvz+ugxx
        o++jLvhtnn57Ujm52fOxGmyjUtgnJ2JI/8kE5srw5yeujHTimsvfFlCi8JDN5enGNJgu8H
        gUy6dDFWPVPpAWxPgD0mWAXhgQoHM2Kh/3GuZjlZ99rD4A8Fm1EkjhsFkFaArQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610471091;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=pTk1FcH5+/wyB8HB1QRJBoXsx85zfAu4dJubIkq5SzI=;
        b=Q/AYXgDRbN6MB0ck3kKpvdlAZd4tF/RVCxjLqReI6YlcdY4xdER6sSEIJpfVazoon1EasT
        Z/sRhKeZnnCkqaCg==
Date:   Tue, 12 Jan 2021 18:01:39 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Peter Zijlstra <peterz@infradead.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Andreas Larsson <andreas@gaisler.com>,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org
Subject: [patch 3/4] mips/mm/highmem: Use set_pte() for kmap_local()
References: <20210112170136.078559026@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

set_pte_at() on MIPS invokes update_cache() which might recurse into
kmap_local(). Use set_pte() like the original MIPS highmem implementation
did.

Fixes: a4c33e83bca1 ("mips/mm/highmem: Switch to generic kmap atomic")
Reported-by: Paul Cercueil <paul@crapouillou.net>
Reported-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/mips/include/asm/highmem.h |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/mips/include/asm/highmem.h
+++ b/arch/mips/include/asm/highmem.h
@@ -51,6 +51,7 @@ extern void kmap_flush_tlb(unsigned long
 
 #define flush_cache_kmaps()	BUG_ON(cpu_has_dc_aliases)
 
+#define arch_kmap_local_set_pte(mm, vaddr, ptep, ptev)	set_pte(ptep, ptev)
 #define arch_kmap_local_post_map(vaddr, pteval)	local_flush_tlb_one(vaddr)
 #define arch_kmap_local_post_unmap(vaddr)	local_flush_tlb_one(vaddr)
 

