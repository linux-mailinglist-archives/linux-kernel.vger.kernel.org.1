Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34F622B861D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 22:00:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbgKRU6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 15:58:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726739AbgKRU6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 15:58:36 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72132C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 12:58:36 -0800 (PST)
Message-Id: <20201118204007.169209557@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605733115;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=I1RJ03FxdbQBuix0AFMPFpavs40u1cT6LSvrn3QgZ7A=;
        b=XQy8/p7GlgJ3dHq0xhwK0Hv31vgwkoS0c6MrnN94LckVmlEpXKxZ1+y+uCAt7d7q9wLtO/
        /5bVHjJ/tqymFfxnrvv03YCLbeKSBLcB5a/+yhmyPd6PdDzzP97bccvBGHrlXkBVIHRcuM
        AMfaHJ6fh9JKoEuPmNoUVRJqaxCGwsHeba/87BOKpei72PIomBEhZcOz3c/QmTQaAq59A1
        URFZDUA20v39aciJkfHBAOMNNXYKKZxv4sVVODrqWVrique+0E8vjQT1gq1p9qnMXm1RUO
        IfqmUddzEmQCGlQoZJDFH76oi5/BPvyp862dx6CyDclqfPaJu4WzaQy6wW6A2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605733115;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=I1RJ03FxdbQBuix0AFMPFpavs40u1cT6LSvrn3QgZ7A=;
        b=4by1Q+ZoAv1joVlLAjkmqwqynxa5rMU8TsHMLVejW5JQDqM2F19I0JMoSsby1aIMdNJDGy
        LbJcaMeAs1OuT1BQ==
Date:   Wed, 18 Nov 2020 20:48:41 +0100
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
Subject: [patch V4 3/8] x86: Support kmap_local() forced debugging
References: <20201118194838.753436396@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kmap_local() and related interfaces are NOOPs on 64bit and only create
temporary fixmaps for highmem pages on 32bit. That means the test coverage
for this code is pretty small.

CONFIG_KMAP_LOCAL can be enabled independent from CONFIG_HIGHMEM, which
allows to provide support for enforced kmap_local() debugging even on
64bit.

For 32bit the support is unconditional, for 64bit it's only supported when
CONFIG_NR_CPUS <= 4096 as supporting it for 8192 CPUs would require to set
up yet another fixmap PGT.

If CONFIG_KMAP_LOCAL_FORCE_DEBUG is enabled then kmap_local()/kmap_atomic()
will use the temporary fixmap mapping path.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V4: New patch
---
 arch/x86/Kconfig                        |    1 +
 arch/x86/include/asm/fixmap.h           |   12 +++++++++---
 arch/x86/include/asm/pgtable_64_types.h |    6 +++++-
 3 files changed, 15 insertions(+), 4 deletions(-)

--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -93,6 +93,7 @@ config X86
 	select ARCH_SUPPORTS_ACPI
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_SUPPORTS_NUMA_BALANCING	if X86_64
+	select ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP	if NR_CPUS <= 4096
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_QUEUED_RWLOCKS
 	select ARCH_USE_QUEUED_SPINLOCKS
--- a/arch/x86/include/asm/fixmap.h
+++ b/arch/x86/include/asm/fixmap.h
@@ -14,13 +14,20 @@
 #ifndef _ASM_X86_FIXMAP_H
 #define _ASM_X86_FIXMAP_H
 
+#include <asm/kmap_size.h>
+
 /*
  * Exposed to assembly code for setting up initial page tables. Cannot be
  * calculated in assembly code (fixmap entries are an enum), but is sanity
  * checked in the actual fixmap C code to make sure that the fixmap is
  * covered fully.
  */
-#define FIXMAP_PMD_NUM	2
+#ifndef CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP
+# define FIXMAP_PMD_NUM	2
+#else
+# define KM_PMDS	(KM_MAX_IDX * ((CONFIG_NR_CPUS + 511) / 512))
+# define FIXMAP_PMD_NUM (KM_PMDS + 2)
+#endif
 /* fixmap starts downwards from the 507th entry in level2_fixmap_pgt */
 #define FIXMAP_PMD_TOP	507
 
@@ -31,7 +38,6 @@
 #include <asm/pgtable_types.h>
 #ifdef CONFIG_X86_32
 #include <linux/threads.h>
-#include <asm/kmap_size.h>
 #else
 #include <uapi/asm/vsyscall.h>
 #endif
@@ -92,7 +98,7 @@ enum fixed_addresses {
 	FIX_IO_APIC_BASE_0,
 	FIX_IO_APIC_BASE_END = FIX_IO_APIC_BASE_0 + MAX_IO_APICS - 1,
 #endif
-#ifdef CONFIG_X86_32
+#ifdef CONFIG_KMAP_LOCAL
 	FIX_KMAP_BEGIN,	/* reserved pte's for temporary kernel mappings */
 	FIX_KMAP_END = FIX_KMAP_BEGIN + (KM_MAX_IDX * NR_CPUS) - 1,
 #ifdef CONFIG_PCI_MMCONFIG
--- a/arch/x86/include/asm/pgtable_64_types.h
+++ b/arch/x86/include/asm/pgtable_64_types.h
@@ -143,7 +143,11 @@ extern unsigned int ptrs_per_p4d;
 
 #define MODULES_VADDR		(__START_KERNEL_map + KERNEL_IMAGE_SIZE)
 /* The module sections ends with the start of the fixmap */
-#define MODULES_END		_AC(0xffffffffff000000, UL)
+#ifndef CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP
+# define MODULES_END		_AC(0xffffffffff000000, UL)
+#else
+# define MODULES_END		_AC(0xfffffffffe000000, UL)
+#endif
 #define MODULES_LEN		(MODULES_END - MODULES_VADDR)
 
 #define ESPFIX_PGD_ENTRY	_AC(-2, UL)

