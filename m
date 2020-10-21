Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 404BA29492A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 10:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2502140AbgJUIAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 04:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502071AbgJUIAy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 04:00:54 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08E86C0613CE;
        Wed, 21 Oct 2020 01:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=RKc0tWqjHW4FmcLbX+prIrPkn9Yq0Px6Q0/wfsxPvKM=; b=GFm3fqUl4cXtUGK7DSTjtm/+uN
        8arj6SiK14NiPw6vvlgNoe71H8NExRdEh/RMdR30xy4mqn9h0Io/+Qq1Q3bayFEct752rReIVs8Wa
        W/VdLkB6Aqlt3fQIwP09qbeFwqrYuC5AFro5d7eBmowUS7JRonOPA/rLOV0OAdZeVGBaEY/MK5r1P
        hsX+XtWoIPBB2K38y6DfpAZ7dbm02+KDlpEWm0gnb2ojQJimqgJ/tO7bKGNYLNjO7zs1mwRTpx3Pj
        f74rK4DpO0YdNE2G1r8p8v/ggsD8i+tIJvTz3ac0Jx5JN3Y0+39Dr6ISD6uZvcVpOXQQ3XZJSZUZm
        DVUTvD5g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kV92x-0003VL-Bd; Wed, 21 Oct 2020 08:00:35 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id B70D3302753;
        Wed, 21 Oct 2020 10:00:31 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 9544820187647; Wed, 21 Oct 2020 10:00:31 +0200 (CEST)
Date:   Wed, 21 Oct 2020 10:00:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     kernel test robot <lkp@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        lkp@lists.01.org, keescook@chromium.org, hjl.tools@gmail.com,
        linux@rasmusvillemoes.dk, linux-toolchains@vger.kernel.org
Subject: GCC section alignment, and GCC-4.9 being a weird one
Message-ID: <20201021080031.GY2628@hirez.programming.kicks-ass.net>
References: <20200629003127.GB5535@shao2-debian>
 <20200630124628.GV4817@hirez.programming.kicks-ass.net>
 <20200630144905.GX4817@hirez.programming.kicks-ass.net>
 <58ff47cc-dc55-e383-7a5b-37008d145aba@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58ff47cc-dc55-e383-7a5b-37008d145aba@gmail.com>
X-Bad-Reply: References and In-Reply-To but no 'Re:' in Subject.
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 20, 2020 at 04:39:38PM -0700, Florian Fainelli wrote:
> This patch causes all files under kernel/sched/* that include sched.h to
> be rebuilt whenever the value of CONFIG_BLK_DEV_INITRD. There are at
> least two build systems (buildroot and OpenWrt) that toggle this
> configuration value in order to produce a kernel image without an
> initramfs, and one with.
> 
> On ARM we get all of these to be needlessly rebuilt:

Is it really ARM specific? AFAICT this should happen on everything.

> Short of moving the STRUCT_ALIGNMENT to a separate header that would not
> be subject to any configuration key change, can you think of a good way
> to avoid these rebuilds, including for architectures like ARM that ship
> their own vmlinux.lds.h? I would not say this is a bug, but it is
> definitively an inconvenience.

Well, no :/ I barely made it work in the first place. This linker cruft
is not my forte. GCC-4.9 being 'special' here is just weird in any case.

We can ask our friends on linux-toolchains; maybe they'll have a clue.

Guys, the problem is the below commit which, for dubious raisins makes
kernel/sched/sched.h depend on asm-generic/vmlinux.lds.h and triggers
rebuilds whenever a CONFIG mentioned in asm-generic/vmlinux.lds.h
changes.

Is there an explanation for why GCC-4.9 is weird and is there a better
way to find the appropriate value?


---
commit 85c2ce9104eb93517db2037699471c517e81f9b4
Author: Peter Zijlstra <peterz@infradead.org>
Date:   Tue Jun 30 16:49:05 2020 +0200

    sched, vmlinux.lds: Increase STRUCT_ALIGNMENT to 64 bytes for GCC-4.9
    
    For some mysterious reason GCC-4.9 has a 64 byte section alignment for
    structures, all other GCC versions (and Clang) tested (including 4.8
    and 5.0) are fine with the 32 bytes alignment.
    
    Getting this right is important for the new SCHED_DATA macro that
    creates an explicitly ordered array of 'struct sched_class' in the
    linker script and expect pointer arithmetic to work.
    
    Fixes: c3a340f7e7ea ("sched: Have sched_class_highest define by vmlinux.lds.h")
    Reported-by: kernel test robot <lkp@intel.com>
    Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
    Link: https://lkml.kernel.org/r/20200630144905.GX4817@hirez.programming.kicks-ass.net

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 66fb84c3dc7e..3ceb4b7279ec 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -108,6 +108,17 @@
 #define SBSS_MAIN .sbss
 #endif
 
+/*
+ * GCC 4.5 and later have a 32 bytes section alignment for structures.
+ * Except GCC 4.9, that feels the need to align on 64 bytes.
+ */
+#if __GNUC__ == 4 && __GNUC_MINOR__ == 9
+#define STRUCT_ALIGNMENT 64
+#else
+#define STRUCT_ALIGNMENT 32
+#endif
+#define STRUCT_ALIGN() . = ALIGN(STRUCT_ALIGNMENT)
+
 /*
  * The order of the sched class addresses are important, as they are
  * used to determine the order of the priority of each sched class in
@@ -123,13 +134,6 @@
 	*(__stop_sched_class)			\
 	__end_sched_classes = .;
 
-/*
- * Align to a 32 byte boundary equal to the
- * alignment gcc 4.5 uses for a struct
- */
-#define STRUCT_ALIGNMENT 32
-#define STRUCT_ALIGN() . = ALIGN(STRUCT_ALIGNMENT)
-
 /* The actual configuration determine if the init/exit sections
  * are handled as text/data or they can be discarded (which
  * often happens at runtime)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 5aa6661ecaf1..9bef2dd01247 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -67,6 +67,7 @@
 #include <linux/tsacct_kern.h>
 
 #include <asm/tlb.h>
+#include <asm-generic/vmlinux.lds.h>
 
 #ifdef CONFIG_PARAVIRT
 # include <asm/paravirt.h>
@@ -1810,7 +1811,7 @@ struct sched_class {
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	void (*task_change_group)(struct task_struct *p, int type);
 #endif
-} __aligned(32); /* STRUCT_ALIGN(), vmlinux.lds.h */
+} __aligned(STRUCT_ALIGNMENT); /* STRUCT_ALIGN(), vmlinux.lds.h */
 
 static inline void put_prev_task(struct rq *rq, struct task_struct *prev)
 {


