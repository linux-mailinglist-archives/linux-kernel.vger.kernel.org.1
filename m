Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3FE1A31EA
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Apr 2020 11:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbgDIJin (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Apr 2020 05:38:43 -0400
Received: from m17617.mail.qiye.163.com ([59.111.176.17]:60715 "EHLO
        m17617.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgDIJin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 05:38:43 -0400
Received: from wangqing-virtual-machine.localdomain (unknown [157.0.31.122])
        by m17617.mail.qiye.163.com (Hmail) with ESMTPA id D770B26289F;
        Thu,  9 Apr 2020 17:38:36 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        James Morse <james.morse@arm.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wang Qing <wangqing@vivo.com>,
        jinho lim <jordan.lim@samsung.com>,
        Dave Martin <Dave.Martin@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com
Subject: [PATCH] ARM64: fixed dump_backtrace() when task running on another cpu
Date:   Thu,  9 Apr 2020 17:38:16 +0800
Message-Id: <1586425106-7369-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZT1VJS05CQkJDTkpJSU1DSllXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OTI6ASo4MTg#GhYIPh5JThoQ
        CBIaCVFVSlVKTkNNT0lOSkpMSkxJVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZSk5M
        VUtVSEpVSklJWVdZCAFZQUlITk03Bg++
X-HM-Tid: 0a715e4e399d9375kuwsd770b26289f
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We cannot get FP and PC when the task is running on another CPU,
task->thread.cpu_context is the last time the task was switched out,
it's better to give a reminder than to provide wrong information.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 arch/arm64/kernel/traps.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index cf402be..c04e3e8 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -106,6 +106,14 @@ void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
 		start_backtrace(&frame,
 				(unsigned long)__builtin_frame_address(0),
 				(unsigned long)dump_backtrace);
+	} else if (tsk->on_cpu) {
+		/*
+		 * The task is running in another cpu, so the call stack
+		 * is changing and we cannot get it.
+		 */
+		pr_warn("tsk: %s is running in CPU%d, Don't call trace!\n",
+			tsk->comm, tsk->cpu);
+		return;
 	} else {
 		/*
 		 * task blocked in __switch_to
-- 
2.7.4

