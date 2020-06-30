Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA1A120F6AB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jun 2020 16:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388543AbgF3OCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Jun 2020 10:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727796AbgF3OCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 10:02:48 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B29C061755
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jun 2020 07:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=jGbDx0iht4VbXUm5qyIJkbSPl9JgtYBM8SkXbZAhpsE=; b=DIhlUCsvuGrpKc7Rrm2FXX77cG
        1C4PAjF9kvzJuzySUE32J3ycmGzAaYiFU935f2IFUPOYVFq5bnLgaAJ1Lkul1mhOyayoK2VAgXfGt
        u0zH5V9WwKYKBkHvrRYancJClUKQGo7DV/D+/AoaAbeJackg+fjjP42/xL3Kv5r/paQewkS19Mbs8
        FsNBxm3LJYKKmjKeTaX0xsFW+ZILenbjLQ3aVCyhIbSeToS4OV4us+gp3aKbMqT9i706e6l7AwKz2
        nc1u+3CM0QyFWO84/wJK1JG1QW6NEbh9YS2VGILoW+NTFz5kOn54e8Tq2f/DsRd51ZvqSBgbsiQUD
        at7Chw0w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jqGqG-0001LJ-SJ; Tue, 30 Jun 2020 14:02:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 4BC283013E5;
        Tue, 30 Jun 2020 16:02:31 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 386032122FE61; Tue, 30 Jun 2020 16:02:31 +0200 (CEST)
Date:   Tue, 30 Jun 2020 16:02:31 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     kernel test robot <lkp@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        lkp@lists.01.org, keescook@chromium.org, hjl.tools@gmail.com
Subject: Re: [sched] c3a340f7e7: invalid_opcode:#[##]
Message-ID: <20200630140231.GW4817@hirez.programming.kicks-ass.net>
References: <20200629003127.GB5535@shao2-debian>
 <20200630124628.GV4817@hirez.programming.kicks-ass.net>
 <5b7286c9-ef4f-c1d0-fae3-ebb198aa0742@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5b7286c9-ef4f-c1d0-fae3-ebb198aa0742@rasmusvillemoes.dk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 30, 2020 at 03:55:05PM +0200, Rasmus Villemoes wrote:

> > Consistently so with GCC-4.9. Any other GCC I tried does the sane thing.
> 
> Does that include gcc 4.8, or is it only "anything newer than 4.9"?

It includes 4.8 :-)

> so the section it was put in has an alignment of 64. The generated
> assembly is indeed
> 
>         .globl  fair_sched_class
>         .section        __fair_sched_class,"a",@progbits
>         .align 64
> 
> /me goes brew coffee

Right.. so I now have the below patch, and with that I get:

62931: c1e62c20     0 NOTYPE  GLOBAL DEFAULT    2 __begin_sched_classes
65736: c1e62e40   128 OBJECT  GLOBAL DEFAULT    2 stop_sched_class
71813: c1e62cc0   128 OBJECT  GLOBAL DEFAULT    2 fair_sched_class
78689: c1e62c40   128 OBJECT  GLOBAL DEFAULT    2 idle_sched_class
78953: c1e62ec0     0 NOTYPE  GLOBAL DEFAULT    2 __end_sched_classes
79090: c1e62d40   128 OBJECT  GLOBAL DEFAULT    2 rt_sched_class
79431: c1e62dc0   128 OBJECT  GLOBAL DEFAULT    2 dl_sched_class


Which has me stumped on __begin_sched_classes being on a 32byte edge
(and crashes differently due to that).

Argh!!



diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 66fb84c3dc7ee..b4704fb12b2dd 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -108,6 +108,17 @@
 #define SBSS_MAIN .sbss
 #endif
 
+/*
+ * Align to a 32 byte boundary equal to the
+ * alignment gcc 4.5 uses for a struct
+ */
+#if GCC_VERSION >= 40900 && GCC_VERSION < 50000
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
index 4165c06d1d7bd..33251d0ab62e7 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -67,6 +67,7 @@
 #include <linux/tsacct_kern.h>
 
 #include <asm/tlb.h>
+#include <asm-generic/vmlinux.lds.h>
 
 #ifdef CONFIG_PARAVIRT
 # include <asm/paravirt.h>
@@ -1811,7 +1812,7 @@ struct sched_class {
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	void (*task_change_group)(struct task_struct *p, int type);
 #endif
-} __aligned(32); /* STRUCT_ALIGN(), vmlinux.lds.h */
+} __aligned(STRUCT_ALIGNMENT); /* STRUCT_ALIGN(), vmlinux.lds.h */
 
 static inline void put_prev_task(struct rq *rq, struct task_struct *prev)
 {
