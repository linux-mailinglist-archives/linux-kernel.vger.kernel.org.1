Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F1E9294DCF
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Oct 2020 15:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2443015AbgJUNpB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Oct 2020 09:45:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2441900AbgJUNpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Oct 2020 09:45:00 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 525D4C0613CE;
        Wed, 21 Oct 2020 06:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=yK+fM6isty0e35DbkYYZGcCALNUkFD6rIoRdPtbIVag=; b=lIK6zp+90j0Kw7dPFwVi+C7i+u
        obRKhmoAofqkTHpbzZwoGPw1FpVmyJIzXqPOXUiGslp79qinCp89OeHLEVFbGavUPu/MtPoBkFZ2i
        hgrWq9HjlRfVrF0Fgg0bA6y3AkTizowqnKBTkDdBXPSbQj7otU1ef9U3Osub1hAaqnedr+PEBlSnH
        CNuWBPpiU+07h847UPOYmjYSuA0++RkPKEQhSMGBYaJaaOBr7kcqT6rMsFWkVBO5BVcvKu21IvthR
        0ihoYreQJPAiLEDrhQkcbUqDFq0+PFsUHL0SfZ+78u9YddbL8kyD10Pj46aBg39DN/lUAjkIO/SHp
        5yOzIIMg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kVEPu-0000Dd-Mm; Wed, 21 Oct 2020 13:44:38 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A7952304BAE;
        Wed, 21 Oct 2020 15:44:36 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 97D05203CC4BC; Wed, 21 Oct 2020 15:44:36 +0200 (CEST)
Date:   Wed, 21 Oct 2020 15:44:36 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Jakub Jelinek <jakub@redhat.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        kernel test robot <lkp@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
        lkp@lists.01.org, keescook@chromium.org, hjl.tools@gmail.com,
        linux@rasmusvillemoes.dk, linux-toolchains@vger.kernel.org
Subject: Re: GCC section alignment, and GCC-4.9 being a weird one
Message-ID: <20201021134436.GJ2628@hirez.programming.kicks-ass.net>
References: <20200629003127.GB5535@shao2-debian>
 <20200630124628.GV4817@hirez.programming.kicks-ass.net>
 <20200630144905.GX4817@hirez.programming.kicks-ass.net>
 <58ff47cc-dc55-e383-7a5b-37008d145aba@gmail.com>
 <20201021080031.GY2628@hirez.programming.kicks-ass.net>
 <20201021131806.GA2176@tucnak>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201021131806.GA2176@tucnak>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 21, 2020 at 03:18:06PM +0200, Jakub Jelinek wrote:

> As the aligned attribute is just on the type and not on the actual
> variables, I don't consider it a bug, GCC only guarantees it when
> the variable itself has user specified alignment.
> Otherwise the compiler can choose to align variables more if they
> are large for performance reasons (to help vectorization e.g. when
> the variable is copied around).  Plus the ABI sometimes requires
> bigger alignment too (e.g. on x86_64 the psABI
> says that array variables larger than 15 bytes must have alignment at least
> 16 bytes).
> 
> So, if you tweak the above testcase to have either
> struct sched_class a __attribute__((aligned(32)));
> or even remove it also from the sched_class struct, you should get
> the behavior you want even from GCC 4.9 and other GCC versions.
> 
> And, if e.g. 32-byte alignment is not what you really need, but e.g.
> natural alignment of the struct sched_class would be sufficient, you could
> use __attribute__((aligned (alignof (struct sched_class)))) on the variables
> instead (perhaps wrapped in some macro).
> 
> BTW, the 32 vs. 64 vs. whatever else byte alignment is heavily architecture
> and GCC version dependent, it is not that on all arches larger structures
> will be always 32 byte aligned no matter what.


Ah, thanks!

In that case something like the below ought to make it good.

I'll go feed it to the robots, see if anything falls over.

---
 kernel/sched/deadline.c  | 4 +++-
 kernel/sched/fair.c      | 4 +++-
 kernel/sched/idle.c      | 4 +++-
 kernel/sched/rt.c        | 4 +++-
 kernel/sched/sched.h     | 3 +--
 kernel/sched/stop_task.c | 3 ++-
 6 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 6d93f4518734..f4855203143d 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2504,7 +2504,9 @@ static void prio_changed_dl(struct rq *rq, struct task_struct *p,
 }
 
 const struct sched_class dl_sched_class
-	__attribute__((section("__dl_sched_class"))) = {
+	__attribute__((section("__dl_sched_class")))
+	__attribute__((aligned(__alignof__(struct sched_class)))) = {
+
 	.enqueue_task		= enqueue_task_dl,
 	.dequeue_task		= dequeue_task_dl,
 	.yield_task		= yield_task_dl,
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index aa4c6227cd6d..9bfa9f545b9a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -11159,7 +11159,9 @@ static unsigned int get_rr_interval_fair(struct rq *rq, struct task_struct *task
  * All the scheduling class methods:
  */
 const struct sched_class fair_sched_class
-	__attribute__((section("__fair_sched_class"))) = {
+	__attribute__((section("__fair_sched_class")))
+	__attribute__((aligned(__alignof__(struct sched_class)))) = {
+
 	.enqueue_task		= enqueue_task_fair,
 	.dequeue_task		= dequeue_task_fair,
 	.yield_task		= yield_task_fair,
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index f324dc36fc43..c74ded2cabd2 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -458,7 +458,9 @@ static void update_curr_idle(struct rq *rq)
  * Simple, special scheduling class for the per-CPU idle tasks:
  */
 const struct sched_class idle_sched_class
-	__attribute__((section("__idle_sched_class"))) = {
+	__attribute__((section("__idle_sched_class")))
+	__attribute__((aligned(__alignof__(struct sched_class)))) = {
+
 	/* no enqueue/yield_task for idle tasks */
 
 	/* dequeue is not valid, we print a debug message there: */
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index f215eea6a966..002cdbfa5308 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2430,7 +2430,9 @@ static unsigned int get_rr_interval_rt(struct rq *rq, struct task_struct *task)
 }
 
 const struct sched_class rt_sched_class
-	__attribute__((section("__rt_sched_class"))) = {
+	__attribute__((section("__rt_sched_class")))
+	__attribute__((aligned(__alignof__(struct sched_class)))) = {
+
 	.enqueue_task		= enqueue_task_rt,
 	.dequeue_task		= dequeue_task_rt,
 	.yield_task		= yield_task_rt,
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 28709f6b0975..42cf1e0cbf16 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -67,7 +67,6 @@
 #include <linux/tsacct_kern.h>
 
 #include <asm/tlb.h>
-#include <asm-generic/vmlinux.lds.h>
 
 #ifdef CONFIG_PARAVIRT
 # include <asm/paravirt.h>
@@ -1826,7 +1825,7 @@ struct sched_class {
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	void (*task_change_group)(struct task_struct *p, int type);
 #endif
-} __aligned(STRUCT_ALIGNMENT); /* STRUCT_ALIGN(), vmlinux.lds.h */
+};
 
 static inline void put_prev_task(struct rq *rq, struct task_struct *prev)
 {
diff --git a/kernel/sched/stop_task.c b/kernel/sched/stop_task.c
index 394bc8126a1e..7bac6e0a9212 100644
--- a/kernel/sched/stop_task.c
+++ b/kernel/sched/stop_task.c
@@ -110,7 +110,8 @@ static void update_curr_stop(struct rq *rq)
  * Simple, special scheduling class for the per-CPU stop tasks:
  */
 const struct sched_class stop_sched_class
-	__attribute__((section("__stop_sched_class"))) = {
+	__attribute__((section("__stop_sched_class")))
+	__attribute__((aligned(__alignof__(struct sched_class)))) = {
 
 	.enqueue_task		= enqueue_task_stop,
 	.dequeue_task		= dequeue_task_stop,
