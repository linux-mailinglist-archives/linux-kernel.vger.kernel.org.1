Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD7382A099A
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 16:21:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727094AbgJ3PVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 11:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726674AbgJ3PVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 11:21:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD690C0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 08:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=CRw6w4veM1X9Ep5BMbCHybw29MJr1QwWDKX1hJOZy3c=; b=EZnQAva8wHPOtQW6NlmsWUlaYN
        oOR1mD7azg4xiDhi8TNy9WAYWO1Q4dfVcGXdar4Rt4TevYnVPuCW6OsnRaSOM7oRCJUFvlckAHOnh
        gphkPwwWas2wf/C/qrJgIreRo2aKFmHLc+BDzoNVZcawLSEtl6EK+t3MoqLfRASb8xUBe7Mxm89r0
        0+coqQaVWqucFFo+INK2tVSBuPy0bKPG+t2hyxbenGWhh7wCJxCfyZVJF4Ehm5oZhbFfIg3NGBdp1
        AF/bW1fh1MbTXkExW6aUhktEDDtzIyu/QcVGkz9rSwwGhgmkQsPzKq/WIxyuSxxRDUQuBhQbFo1vT
        hbuFUWMw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kYWDJ-0002kW-NB; Fri, 30 Oct 2020 15:21:14 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 82261307943;
        Fri, 30 Oct 2020 16:21:12 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 001292B708597; Fri, 30 Oct 2020 16:21:11 +0100 (CET)
Message-ID: <20201030151955.258178461@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 30 Oct 2020 16:13:50 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     mingo@kernel.org, tglx@linutronix.de, rostedt@goodmis.org
Cc:     linux-kernel@vger.kernel.org, kan.liang@linux.intel.com,
        acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org, ak@linux.intel.com, eranian@google.com,
        peterz@infradead.org
Subject: [PATCH 5/6] perf/arch: Remove perf_sample_data::regs_user_copy
References: <20201030151345.540479897@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

struct perf_sample_data lives on-stack, we should be careful about it's
size. Furthermore, the pt_regs copy in there is only because x86_64 is a
trainwreck, solve it differently.

Reported-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Steven Rostedt <rostedt@goodmis.org>
---
 arch/arm/kernel/perf_regs.c   |    3 +--
 arch/arm64/kernel/perf_regs.c |    3 +--
 arch/csky/kernel/perf_regs.c  |    3 +--
 arch/powerpc/perf/perf_regs.c |    3 +--
 arch/riscv/kernel/perf_regs.c |    3 +--
 arch/s390/kernel/perf_regs.c  |    3 +--
 arch/x86/kernel/perf_regs.c   |   15 +++++++++++----
 include/linux/perf_event.h    |    6 ------
 include/linux/perf_regs.h     |    6 ++----
 kernel/events/core.c          |    8 +++-----
 10 files changed, 22 insertions(+), 31 deletions(-)

--- a/arch/arm/kernel/perf_regs.c
+++ b/arch/arm/kernel/perf_regs.c
@@ -32,8 +32,7 @@ u64 perf_reg_abi(struct task_struct *tas
 }
 
 void perf_get_regs_user(struct perf_regs *regs_user,
-			struct pt_regs *regs,
-			struct pt_regs *regs_user_copy)
+			struct pt_regs *regs)
 {
 	regs_user->regs = task_pt_regs(current);
 	regs_user->abi = perf_reg_abi(current);
--- a/arch/arm64/kernel/perf_regs.c
+++ b/arch/arm64/kernel/perf_regs.c
@@ -73,8 +73,7 @@ u64 perf_reg_abi(struct task_struct *tas
 }
 
 void perf_get_regs_user(struct perf_regs *regs_user,
-			struct pt_regs *regs,
-			struct pt_regs *regs_user_copy)
+			struct pt_regs *regs)
 {
 	regs_user->regs = task_pt_regs(current);
 	regs_user->abi = perf_reg_abi(current);
--- a/arch/csky/kernel/perf_regs.c
+++ b/arch/csky/kernel/perf_regs.c
@@ -32,8 +32,7 @@ u64 perf_reg_abi(struct task_struct *tas
 }
 
 void perf_get_regs_user(struct perf_regs *regs_user,
-			struct pt_regs *regs,
-			struct pt_regs *regs_user_copy)
+			struct pt_regs *regs)
 {
 	regs_user->regs = task_pt_regs(current);
 	regs_user->abi = perf_reg_abi(current);
--- a/arch/powerpc/perf/perf_regs.c
+++ b/arch/powerpc/perf/perf_regs.c
@@ -144,8 +144,7 @@ u64 perf_reg_abi(struct task_struct *tas
 }
 
 void perf_get_regs_user(struct perf_regs *regs_user,
-			struct pt_regs *regs,
-			struct pt_regs *regs_user_copy)
+			struct pt_regs *regs)
 {
 	regs_user->regs = task_pt_regs(current);
 	regs_user->abi = (regs_user->regs) ? perf_reg_abi(current) :
--- a/arch/riscv/kernel/perf_regs.c
+++ b/arch/riscv/kernel/perf_regs.c
@@ -36,8 +36,7 @@ u64 perf_reg_abi(struct task_struct *tas
 }
 
 void perf_get_regs_user(struct perf_regs *regs_user,
-			struct pt_regs *regs,
-			struct pt_regs *regs_user_copy)
+			struct pt_regs *regs)
 {
 	regs_user->regs = task_pt_regs(current);
 	regs_user->abi = perf_reg_abi(current);
--- a/arch/s390/kernel/perf_regs.c
+++ b/arch/s390/kernel/perf_regs.c
@@ -53,8 +53,7 @@ u64 perf_reg_abi(struct task_struct *tas
 }
 
 void perf_get_regs_user(struct perf_regs *regs_user,
-			struct pt_regs *regs,
-			struct pt_regs *regs_user_copy)
+			struct pt_regs *regs)
 {
 	/*
 	 * Use the regs from the first interruption and let
--- a/arch/x86/kernel/perf_regs.c
+++ b/arch/x86/kernel/perf_regs.c
@@ -101,8 +101,7 @@ u64 perf_reg_abi(struct task_struct *tas
 }
 
 void perf_get_regs_user(struct perf_regs *regs_user,
-			struct pt_regs *regs,
-			struct pt_regs *regs_user_copy)
+			struct pt_regs *regs)
 {
 	regs_user->regs = task_pt_regs(current);
 	regs_user->abi = perf_reg_abi(current);
@@ -129,12 +128,20 @@ u64 perf_reg_abi(struct task_struct *tas
 		return PERF_SAMPLE_REGS_ABI_64;
 }
 
+static DEFINE_PER_CPU(struct pt_regs, nmi_user_regs);
+
 void perf_get_regs_user(struct perf_regs *regs_user,
-			struct pt_regs *regs,
-			struct pt_regs *regs_user_copy)
+			struct pt_regs *regs)
 {
+	struct pt_regs *regs_user_copy = this_cpu_ptr(&nmi_user_regs);
 	struct pt_regs *user_regs = task_pt_regs(current);
 
+	if (!in_nmi()) {
+		regs_user->regs = user_regs;
+		regs_user->abi = perf_reg_abi(current);
+		return;
+	}
+
 	/*
 	 * If we're in an NMI that interrupted task_pt_regs setup, then
 	 * we can't sample user regs at all.  This check isn't really
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1022,13 +1022,7 @@ struct perf_sample_data {
 	struct perf_callchain_entry	*callchain;
 	u64				aux_size;
 
-	/*
-	 * regs_user may point to task_pt_regs or to regs_user_copy, depending
-	 * on arch details.
-	 */
 	struct perf_regs		regs_user;
-	struct pt_regs			regs_user_copy;
-
 	struct perf_regs		regs_intr;
 	u64				stack_user_size;
 
--- a/include/linux/perf_regs.h
+++ b/include/linux/perf_regs.h
@@ -20,8 +20,7 @@ u64 perf_reg_value(struct pt_regs *regs,
 int perf_reg_validate(u64 mask);
 u64 perf_reg_abi(struct task_struct *task);
 void perf_get_regs_user(struct perf_regs *regs_user,
-			struct pt_regs *regs,
-			struct pt_regs *regs_user_copy);
+			struct pt_regs *regs);
 #else
 
 #define PERF_REG_EXTENDED_MASK	0
@@ -42,8 +41,7 @@ static inline u64 perf_reg_abi(struct ta
 }
 
 static inline void perf_get_regs_user(struct perf_regs *regs_user,
-				      struct pt_regs *regs,
-				      struct pt_regs *regs_user_copy)
+				      struct pt_regs *regs);
 {
 	regs_user->regs = task_pt_regs(current);
 	regs_user->abi = perf_reg_abi(current);
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6374,14 +6374,13 @@ perf_output_sample_regs(struct perf_outp
 }
 
 static void perf_sample_regs_user(struct perf_regs *regs_user,
-				  struct pt_regs *regs,
-				  struct pt_regs *regs_user_copy)
+				  struct pt_regs *regs)
 {
 	if (user_mode(regs)) {
 		regs_user->abi = perf_reg_abi(current);
 		regs_user->regs = regs;
 	} else if (!(current->flags & PF_KTHREAD)) {
-		perf_get_regs_user(regs_user, regs, regs_user_copy);
+		perf_get_regs_user(regs_user, regs);
 	} else {
 		regs_user->abi = PERF_SAMPLE_REGS_ABI_NONE;
 		regs_user->regs = NULL;
@@ -7083,8 +7082,7 @@ void perf_prepare_sample(struct perf_eve
 	}
 
 	if (sample_type & (PERF_SAMPLE_REGS_USER | PERF_SAMPLE_STACK_USER))
-		perf_sample_regs_user(&data->regs_user, regs,
-				      &data->regs_user_copy);
+		perf_sample_regs_user(&data->regs_user, regs);
 
 	if (sample_type & PERF_SAMPLE_REGS_USER) {
 		/* regs dump ABI info */


