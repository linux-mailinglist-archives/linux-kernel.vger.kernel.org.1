Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9AED2B861C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 22:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726883AbgKRU6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 15:58:37 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:57608 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726638AbgKRU6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 15:58:35 -0500
Message-Id: <20201118204007.028261233@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605733113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=7rStCz/mQFScHxK69Y+EQ2P9i7Zl599sIUrIWDCDz3Y=;
        b=EeSRihQ0Sba8l2old4dtzqJTYc/sprNUmo+vpnwrLXWFt4uNoHTGtAlnxY9ZRZjBcR4ntZ
        lLOJReiKRK+AKPfirtELCu5M91totpbCYhp/1UJlfRTvjoNVHcKtvjXxxS4A0U9z4X13Bv
        I6WNVRQEUr+qzSt0Om/tFWCSUMgzLKU0Gv4LQ/Rx5SIY6bYBjOdD03Rje1j2ZBtN0x1V3A
        TBtwQcU0wZfb10lwg1UoA8XvXtGAzR+c9Dyatw2MyUvTO4AJuZkbPnMMB0th7Fc/wBQpxe
        PRQgR5fSjqMHjid0TtpsBxpqA98kWoa0cr7HcmlMF/2dKkwxW0GnT3q9xqOjJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605733113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=7rStCz/mQFScHxK69Y+EQ2P9i7Zl599sIUrIWDCDz3Y=;
        b=ylOSmMyfpk722YM3P/eT9vPJFIpXbquk8UhgYQ01gHXosiAAkOxmFtK8EgPdA/aoUpG5rk
        KijjZHafHfUrgBAA==
Date:   Wed, 18 Nov 2020 20:48:40 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linuxfoundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [patch V4 2/8] mm/highmem: Provide CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP
References: <20201118194838.753436396@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_DEBUG_KMAP_LOCAL, which is selected by CONFIG_DEBUG_HIGHMEM is only
providing guard pages, but does not provide a mechanism to enforce the
usage of the kmap_local() infrastructure.

Provide CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP which forces the temporary
mapping even for lowmem pages. This needs to be a seperate config switch
because this only works on architectures which do not have cache aliasing
problems.

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V4: New patch
---
 lib/Kconfig.debug |   14 ++++++++++++++
 mm/highmem.c      |   12 +++++++++++-
 2 files changed, 25 insertions(+), 1 deletion(-)

--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -856,9 +856,23 @@ config DEBUG_KMAP_LOCAL
 	  This option enables additional error checking for the kmap_local
 	  infrastructure.  Disable for production use.
 
+config ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP
+	bool
+
+config DEBUG_KMAP_LOCAL_FORCE_MAP
+	bool "Enforce kmap_local temporary mappings"
+	depends on DEBUG_KERNEL && ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP
+	select KMAP_LOCAL
+	select DEBUG_KMAP_LOCAL
+	help
+	  This option enforces temporary mappings through the kmap_local
+	  mechanism for non-highmem pages and on non-highmem systems.
+	  Disable this for production systems!
+
 config DEBUG_HIGHMEM
 	bool "Highmem debugging"
 	depends on DEBUG_KERNEL && HIGHMEM
+	select DEBUG_KMAP_LOCAL_FORCE_MAP if ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP
 	select DEBUG_KMAP_LOCAL
 	help
 	  This option enables additional error checking for high memory
--- a/mm/highmem.c
+++ b/mm/highmem.c
@@ -474,7 +474,12 @@ void *__kmap_local_page_prot(struct page
 {
 	void *kmap;
 
-	if (!PageHighMem(page))
+	/*
+	 * To broaden the usage of the actual kmap_local() machinery always map
+	 * pages when debugging is enabled and the architecture has no problems
+	 * with alias mappings.
+	 */
+	if (!IS_ENABLED(CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP) && !PageHighMem(page))
 		return page_address(page);
 
 	/* Try kmap_high_get() if architecture has it enabled */
@@ -494,6 +499,11 @@ void kunmap_local_indexed(void *vaddr)
 
 	if (addr < __fix_to_virt(FIX_KMAP_END) ||
 	    addr > __fix_to_virt(FIX_KMAP_BEGIN)) {
+		if (IS_ENABLED(CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP)) {
+			/* This _should_ never happen! See above. */
+			WARN_ON_ONCE(1);
+			return;
+		}
 		/*
 		 * Handle mappings which were obtained by kmap_high_get()
 		 * first as the virtual address of such mappings is below

