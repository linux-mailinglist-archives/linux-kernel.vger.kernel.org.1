Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD2327931F
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Sep 2020 23:18:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbgIYVSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Sep 2020 17:18:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:60788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726559AbgIYVSW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Sep 2020 17:18:22 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 858F021D42;
        Fri, 25 Sep 2020 21:18:21 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.94)
        (envelope-from <rostedt@goodmis.org>)
        id 1kLv6i-002CuF-5J; Fri, 25 Sep 2020 17:18:20 -0400
Message-ID: <20200925211820.050807067@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 25 Sep 2020 17:12:09 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Yafang Shao <laoar.shao@gmail.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michel Lespinasse <walken@google.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        Linux MM <linux-mm@kvack.org>, Ingo Molnar <mingo@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andi Kleen <ak@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 3/3 v2] x86: Use tracepoint_enabled() for msr tracepoints instead of open
 coding it
References: <20200925211206.423598568@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

7f47d8cc039f ("x86, tracing, perf: Add trace point for MSR accesses") added
tracing of msr read and write, but because of complexity in having
tracepoints in headers, and even more so for a core header like msr.h, not
to mention the bloat a tracepoint adds to inline functions, a helper
function is needed to be called from the header.

Use the new tracepoint_enabled() macro in tracepoint-defs.h to test if the
tracepoint is active before calling the helper function, instead of open
coding the same logic, which requires knowing the internals of a tracepoint.

Cc: Andi Kleen <ak@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
 arch/x86/include/asm/msr.h | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index 86f20d520a07..fd4a32f0947b 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -67,15 +67,13 @@ struct saved_msrs {
 #include <asm/atomic.h>
 #include <linux/tracepoint-defs.h>
 
-extern struct tracepoint __tracepoint_read_msr;
-extern struct tracepoint __tracepoint_write_msr;
-extern struct tracepoint __tracepoint_rdpmc;
-#define msr_tracepoint_active(t) static_key_false(&(t).key)
+DECLARE_TRACEPOINT(read_msr);
+DECLARE_TRACEPOINT(write_msr);
+DECLARE_TRACEPOINT(rdpmc);
 extern void do_trace_write_msr(unsigned int msr, u64 val, int failed);
 extern void do_trace_read_msr(unsigned int msr, u64 val, int failed);
 extern void do_trace_rdpmc(unsigned int msr, u64 val, int failed);
 #else
-#define msr_tracepoint_active(t) false
 static inline void do_trace_write_msr(unsigned int msr, u64 val, int failed) {}
 static inline void do_trace_read_msr(unsigned int msr, u64 val, int failed) {}
 static inline void do_trace_rdpmc(unsigned int msr, u64 val, int failed) {}
@@ -128,7 +126,7 @@ static inline unsigned long long native_read_msr(unsigned int msr)
 
 	val = __rdmsr(msr);
 
-	if (msr_tracepoint_active(__tracepoint_read_msr))
+	if (tracepoint_enabled(read_msr))
 		do_trace_read_msr(msr, val, 0);
 
 	return val;
@@ -150,7 +148,7 @@ static inline unsigned long long native_read_msr_safe(unsigned int msr,
 		     _ASM_EXTABLE(2b, 3b)
 		     : [err] "=r" (*err), EAX_EDX_RET(val, low, high)
 		     : "c" (msr), [fault] "i" (-EIO));
-	if (msr_tracepoint_active(__tracepoint_read_msr))
+	if (tracepoint_enabled(read_msr))
 		do_trace_read_msr(msr, EAX_EDX_VAL(val, low, high), *err);
 	return EAX_EDX_VAL(val, low, high);
 }
@@ -161,7 +159,7 @@ native_write_msr(unsigned int msr, u32 low, u32 high)
 {
 	__wrmsr(msr, low, high);
 
-	if (msr_tracepoint_active(__tracepoint_write_msr))
+	if (tracepoint_enabled(write_msr))
 		do_trace_write_msr(msr, ((u64)high << 32 | low), 0);
 }
 
@@ -181,7 +179,7 @@ native_write_msr_safe(unsigned int msr, u32 low, u32 high)
 		     : "c" (msr), "0" (low), "d" (high),
 		       [fault] "i" (-EIO)
 		     : "memory");
-	if (msr_tracepoint_active(__tracepoint_write_msr))
+	if (tracepoint_enabled(write_msr))
 		do_trace_write_msr(msr, ((u64)high << 32 | low), err);
 	return err;
 }
@@ -248,7 +246,7 @@ static inline unsigned long long native_read_pmc(int counter)
 	DECLARE_ARGS(val, low, high);
 
 	asm volatile("rdpmc" : EAX_EDX_RET(val, low, high) : "c" (counter));
-	if (msr_tracepoint_active(__tracepoint_rdpmc))
+	if (tracepoint_enabled(rdpmc))
 		do_trace_rdpmc(counter, EAX_EDX_VAL(val, low, high), 0);
 	return EAX_EDX_VAL(val, low, high);
 }
-- 
2.28.0


