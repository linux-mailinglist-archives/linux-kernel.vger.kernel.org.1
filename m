Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC9411A6626
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Apr 2020 14:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729393AbgDMMFJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Apr 2020 08:05:09 -0400
Received: from m17617.mail.qiye.163.com ([59.111.176.17]:44314 "EHLO
        m17617.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729365AbgDMMFF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Apr 2020 08:05:05 -0400
Received: from wangqing-virtual-machine.localdomain (unknown [157.0.31.122])
        by m17617.mail.qiye.163.com (Hmail) with ESMTPA id 00A902624A4;
        Mon, 13 Apr 2020 20:05:00 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        James Morse <james.morse@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        jinho lim <jordan.lim@samsung.com>,
        Wang Qing <wangqing@vivo.com>,
        Dave Martin <Dave.Martin@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com
Subject: [PATCH 2/2] [V2 2/2]ARM64:fixed dump_backtrace() when task running on another cpu
Date:   Mon, 13 Apr 2020 20:04:24 +0800
Message-Id: <1586779466-4439-3-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1586779466-4439-1-git-send-email-wangqing@vivo.com>
References: <1586779466-4439-1-git-send-email-wangqing@vivo.com>
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZSVVPQkxCQkJCS01OSEJCSVlXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6NzI6Ohw4Hjg3AgtLCk4JPzFP
        CTUwCkxVSlVKTkNNTExCTktKSENKVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZSk5M
        VUtVSEpVSklJWVdZCAFZQUhJS083Bg++
X-HM-Tid: 0a71736db2e99375kuws00a902624a4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We cannot get FP and PC when the task is running on another CPU,
task->thread.cpu_context is the last time the task was switched out,
it's better to give a reminder than to provide wrong information.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 arch/arm64/kernel/traps.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index cf402be..831b8fd 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -106,6 +106,13 @@ void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
 		start_backtrace(&frame,
 				(unsigned long)__builtin_frame_address(0),
 				(unsigned long)dump_backtrace);
+	} else if (task_running_oncpu(tsk)) {
+		/*
+		 * The task is running in another cpu, we cannot get it.
+		 */
+		pr_warn("tsk: %s is running in CPU%d, Don't call trace!\n",
+			tsk->comm, task_cpu(tsk));
+		return;
 	} else {
 		/*
 		 * task blocked in __switch_to
-- 
2.7.4

