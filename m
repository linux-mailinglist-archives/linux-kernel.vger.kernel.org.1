Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BDE22B861B
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 22:00:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726725AbgKRU6f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 15:58:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726198AbgKRU6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 15:58:34 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 580BEC0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Nov 2020 12:58:34 -0800 (PST)
Message-Id: <20201118204006.869487226@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605733112;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=nCDGwh3SdMGSRFUr2TixpTbJs+qPfQ4mGy29He36FSU=;
        b=4HJFTSRrzyezlZsPToBtWv8leQtJ0MTHzKFJq9o42DBJgVcKgw+i/EzkU/Xu3X6MUOqgip
        kF+/QL8GARivdO4Vb7/vfEuBq0g4hbpTH6QlEtQlwamJ36b3KVMTjnsHteA7vXYZ4RLJ/a
        b3YrhuVTye5vTdl48rwxMdjfd3z9xDYCvmX0lajTAbqDUHSB7y+GTypDnX7rbC0ZHy48E/
        F9xp/SQzShTSvEauNvYjsfheAOsTV5QAGv3H6B5MdRlTDHURo6/CV4UNlSfiVzG+r/lmET
        QJxbafIWg1X6GLNk4k96skCri49uU0DWrzbJCuzSAJIexDhJNLzLwqFgMxWEPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605733112;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=nCDGwh3SdMGSRFUr2TixpTbJs+qPfQ4mGy29He36FSU=;
        b=UXbqqWzHxG8zdORi+anHS8vxHmSweUHPHldVZ8d7X+2hHEpvRgT6noPAN8OMPWrU0JIEOA
        ctDx7Fudx8RFo2Ag==
Date:   Wed, 18 Nov 2020 20:48:39 +0100
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
Subject: [patch V4 1/8] mm/highmem: Provide and use CONFIG_DEBUG_KMAP_LOCAL
References: <20201118194838.753436396@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-transfer-encoding: 8-bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

CONFIG_KMAP_LOCAL can be enabled by x86/32bit even if CONFIG_HIGHMEM is not
enabled for temporary MMIO space mappings.

Provide it as a seperate config option which depends on CONFIG_KMAP_LOCAL
and let CONFIG_DEBUG_HIGHMEM select it.

This won't increase the debug coverage of this significantly but it paves
the way to do so.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
V4: New patch
---
 include/asm-generic/kmap_size.h |    2 +-
 lib/Kconfig.debug               |    8 ++++++++
 mm/highmem.c                    |    4 ++--
 3 files changed, 11 insertions(+), 3 deletions(-)

--- a/include/asm-generic/kmap_size.h
+++ b/include/asm-generic/kmap_size.h
@@ -3,7 +3,7 @@
 #define _ASM_GENERIC_KMAP_SIZE_H
 
 /* For debug this provides guard pages between the maps */
-#ifdef CONFIG_DEBUG_HIGHMEM
+#ifdef CONFIG_DEBUG_KMAP_LOCAL
 # define KM_MAX_IDX	33
 #else
 # define KM_MAX_IDX	16
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -849,9 +849,17 @@ config DEBUG_PER_CPU_MAPS
 
 	  Say N if unsure.
 
+config DEBUG_KMAP_LOCAL
+	bool "Debug kmap_local temporary mappings"
+	depends on DEBUG_KERNEL && KMAP_LOCAL
+	help
+	  This option enables additional error checking for the kmap_local
+	  infrastructure.  Disable for production use.
+
 config DEBUG_HIGHMEM
 	bool "Highmem debugging"
 	depends on DEBUG_KERNEL && HIGHMEM
+	select DEBUG_KMAP_LOCAL
 	help
 	  This option enables additional error checking for high memory
 	  systems.  Disable for production systems.
--- a/mm/highmem.c
+++ b/mm/highmem.c
@@ -368,10 +368,10 @@ EXPORT_SYMBOL(kunmap_high);
 static DEFINE_PER_CPU(int, __kmap_local_idx);
 
 /*
- * With DEBUG_HIGHMEM the stack depth is doubled and every second
+ * With DEBUG_KMAP_LOCAL the stack depth is doubled and every second
  * slot is unused which acts as a guard page
  */
-#ifdef CONFIG_DEBUG_HIGHMEM
+#ifdef CONFIG_DEBUG_KMAP_LOCAL
 # define KM_INCR	2
 #else
 # define KM_INCR	1

