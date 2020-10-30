Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DF1F2A0387
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Oct 2020 11:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgJ3K7c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Oct 2020 06:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgJ3K7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Oct 2020 06:59:32 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E97FC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Oct 2020 03:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Re5NgACoN7F2zaJeTTiiLGYlcMbHRPmiWlgvTkVmQtY=; b=Ga2AgZUtOvzvEfvyctNCZksdJP
        0hLDlm74u6/UuKu/Ie2Nv6PBU5dxU+HEpwfz8FkH4ulSdcrv/hGcCzS4Q82k2eomPaFifdOP1cWD3
        44rwwoloaTE8Pocs6Lo+iKFkJe4twmvF6ZW5m73zgjedZiZxSATyoF4Jwxeb2ESuiBw7GY0W4F75P
        3VX1CMnG8thuHh2KUNXacxFJ2C3nSnC7kS2/WUv93/WXDxizEt0tqSCmExDXzWrguyxOGPS7x/TWc
        zhrENj7GJ6f9Yjc65eE4n78FRYYKu0ypED5E2czVUnUutg7KlIDIJJRTqcn39TnNKEZ1o/9WcQKIY
        ChYNyX1A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kYS7s-0003BK-LD; Fri, 30 Oct 2020 10:59:20 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 161373012C3;
        Fri, 30 Oct 2020 11:59:18 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id EFF97203F0EC3; Fri, 30 Oct 2020 11:59:17 +0100 (CET)
Date:   Fri, 30 Oct 2020 11:59:17 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>, kan.liang@linux.intel.com,
        like.xu@linux.intel.com, Andy Lutomirski <luto@amacapital.net>
Subject: [PATCH] perf/arch: Remove perf_sample_data::regs_user_copy
Message-ID: <20201030105917.GI2611@hirez.programming.kicks-ass.net>
References: <20201030002722.766a22df@oasis.local.home>
 <20201030090037.GZ2628@hirez.programming.kicks-ass.net>
 <877dr8nh6u.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877dr8nh6u.fsf@nanos.tec.linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 30, 2020 at 11:26:01AM +0100, Thomas Gleixner wrote:
> What's worse is perf_sample_data which is 384 bytes and is 64 bytes aligned.

Here; this shrinks it to 192 bytes. Combined with the static dummy this
should reduce stack usage by 360 bytes.

---
Subject: perf/arch: Remove perf_sample_data::regs_user_copy

struct perf_sample_data lives on-stack, we should be careful about it's
size. Furthermore, the pt_regs copy in there is only because x86_64 is a
trainwreck, solve it differently.

Halves sizeof(perf_sample_data).

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/arm/kernel/perf_regs.c   |  3 +--
 arch/arm64/kernel/perf_regs.c |  3 +--
 arch/csky/kernel/perf_regs.c  |  3 +--
 arch/powerpc/perf/perf_regs.c |  3 +--
 arch/riscv/kernel/perf_regs.c |  3 +--
 arch/s390/kernel/perf_regs.c  |  3 +--
 arch/x86/kernel/perf_regs.c   | 15 +++++++++++----
 include/linux/perf_event.h    |  6 ------
 include/linux/perf_regs.h     |  6 ++----
 kernel/events/core.c          |  8 +++-----
 10 files changed, 22 insertions(+), 31 deletions(-)

diff --git a/arch/arm/kernel/perf_regs.c b/arch/arm/kernel/perf_regs.c
index 05fe92aa7d98..0529f90395c9 100644
--- a/arch/arm/kernel/perf_regs.c
+++ b/arch/arm/kernel/perf_regs.c
@@ -32,8 +32,7 @@ u64 perf_reg_abi(struct task_struct *task)
 }
 
 void perf_get_regs_user(struct perf_regs *regs_user,
-			struct pt_regs *regs,
-			struct pt_regs *regs_user_copy)
+			struct pt_regs *regs)
 {
 	regs_user->regs = task_pt_regs(current);
 	regs_user->abi = perf_reg_abi(current);
diff --git a/arch/arm64/kernel/perf_regs.c b/arch/arm64/kernel/perf_regs.c
index 94e8718e7229..f6f58e6265df 100644
--- a/arch/arm64/kernel/perf_regs.c
+++ b/arch/arm64/kernel/perf_regs.c
@@ -73,8 +73,7 @@ u64 perf_reg_abi(struct task_struct *task)
 }
 
 void perf_get_regs_user(struct perf_regs *regs_user,
-			struct pt_regs *regs,
-			struct pt_regs *regs_user_copy)
+			struct pt_regs *regs)
 {
 	regs_user->regs = task_pt_regs(current);
 	regs_user->abi = perf_reg_abi(current);
diff --git a/arch/csky/kernel/perf_regs.c b/arch/csky/kernel/perf_regs.c
index eb32838b8210..09b7f88a2d6a 100644
--- a/arch/csky/kernel/perf_regs.c
+++ b/arch/csky/kernel/perf_regs.c
@@ -32,8 +32,7 @@ u64 perf_reg_abi(struct task_struct *task)
 }
 
 void perf_get_regs_user(struct perf_regs *regs_user,
-			struct pt_regs *regs,
-			struct pt_regs *regs_user_copy)
+			struct pt_regs *regs)
 {
 	regs_user->regs = task_pt_regs(current);
 	regs_user->abi = perf_reg_abi(current);
diff --git a/arch/powerpc/perf/perf_regs.c b/arch/powerpc/perf/perf_regs.c
index 8e53f2fc3fe0..6f681b105eec 100644
--- a/arch/powerpc/perf/perf_regs.c
+++ b/arch/powerpc/perf/perf_regs.c
@@ -144,8 +144,7 @@ u64 perf_reg_abi(struct task_struct *task)
 }
 
 void perf_get_regs_user(struct perf_regs *regs_user,
-			struct pt_regs *regs,
-			struct pt_regs *regs_user_copy)
+			struct pt_regs *regs)
 {
 	regs_user->regs = task_pt_regs(current);
 	regs_user->abi = (regs_user->regs) ? perf_reg_abi(current) :
diff --git a/arch/riscv/kernel/perf_regs.c b/arch/riscv/kernel/perf_regs.c
index 04a38fbeb9c7..fd304a248de6 100644
--- a/arch/riscv/kernel/perf_regs.c
+++ b/arch/riscv/kernel/perf_regs.c
@@ -36,8 +36,7 @@ u64 perf_reg_abi(struct task_struct *task)
 }
 
 void perf_get_regs_user(struct perf_regs *regs_user,
-			struct pt_regs *regs,
-			struct pt_regs *regs_user_copy)
+			struct pt_regs *regs)
 {
 	regs_user->regs = task_pt_regs(current);
 	regs_user->abi = perf_reg_abi(current);
diff --git a/arch/s390/kernel/perf_regs.c b/arch/s390/kernel/perf_regs.c
index 4352a504f235..6e9e5d5e927e 100644
--- a/arch/s390/kernel/perf_regs.c
+++ b/arch/s390/kernel/perf_regs.c
@@ -53,8 +53,7 @@ u64 perf_reg_abi(struct task_struct *task)
 }
 
 void perf_get_regs_user(struct perf_regs *regs_user,
-			struct pt_regs *regs,
-			struct pt_regs *regs_user_copy)
+			struct pt_regs *regs)
 {
 	/*
 	 * Use the regs from the first interruption and let
diff --git a/arch/x86/kernel/perf_regs.c b/arch/x86/kernel/perf_regs.c
index bb7e1132290b..750129bf539c 100644
--- a/arch/x86/kernel/perf_regs.c
+++ b/arch/x86/kernel/perf_regs.c
@@ -101,8 +101,7 @@ u64 perf_reg_abi(struct task_struct *task)
 }
 
 void perf_get_regs_user(struct perf_regs *regs_user,
-			struct pt_regs *regs,
-			struct pt_regs *regs_user_copy)
+			struct pt_regs *regs)
 {
 	regs_user->regs = task_pt_regs(current);
 	regs_user->abi = perf_reg_abi(current);
@@ -129,12 +128,20 @@ u64 perf_reg_abi(struct task_struct *task)
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
+		regs_user->regs = task_pt_regs(current);
+		regs_user->abi = perf_reg_abi(current);
+		return;
+	}
+
 	/*
 	 * If we're in an NMI that interrupted task_pt_regs setup, then
 	 * we can't sample user regs at all.  This check isn't really
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 0c19d279b97f..e58f4e6b6e1c 100644
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
 
diff --git a/include/linux/perf_regs.h b/include/linux/perf_regs.h
index 2d12e97d5e7b..5efcdb768c75 100644
--- a/include/linux/perf_regs.h
+++ b/include/linux/perf_regs.h
@@ -20,8 +20,7 @@ u64 perf_reg_value(struct pt_regs *regs, int idx);
 int perf_reg_validate(u64 mask);
 u64 perf_reg_abi(struct task_struct *task);
 void perf_get_regs_user(struct perf_regs *regs_user,
-			struct pt_regs *regs,
-			struct pt_regs *regs_user_copy);
+			struct pt_regs *regs);
 #else
 
 #define PERF_REG_EXTENDED_MASK	0
@@ -42,8 +41,7 @@ static inline u64 perf_reg_abi(struct task_struct *task)
 }
 
 static inline void perf_get_regs_user(struct perf_regs *regs_user,
-				      struct pt_regs *regs,
-				      struct pt_regs *regs_user_copy)
+				      struct pt_regs *regs);
 {
 	regs_user->regs = task_pt_regs(current);
 	regs_user->abi = perf_reg_abi(current);
diff --git a/kernel/events/core.c b/kernel/events/core.c
index da467e1dd49a..14709182d94e 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6374,14 +6374,13 @@ perf_output_sample_regs(struct perf_output_handle *handle,
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
@@ -7083,8 +7082,7 @@ void perf_prepare_sample(struct perf_event_header *header,
 	}
 
 	if (sample_type & (PERF_SAMPLE_REGS_USER | PERF_SAMPLE_STACK_USER))
-		perf_sample_regs_user(&data->regs_user, regs,
-				      &data->regs_user_copy);
+		perf_sample_regs_user(&data->regs_user, regs);
 
 	if (sample_type & PERF_SAMPLE_REGS_USER) {
 		/* regs dump ABI info */
