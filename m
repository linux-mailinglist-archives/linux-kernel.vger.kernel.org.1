Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01EEA1AEC0E
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Apr 2020 13:21:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725932AbgDRLUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Apr 2020 07:20:12 -0400
Received: from m176115.mail.qiye.163.com ([59.111.176.115]:59062 "EHLO
        m176115.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725857AbgDRLUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 07:20:10 -0400
X-Greylist: delayed 334 seconds by postgrey-1.27 at vger.kernel.org; Sat, 18 Apr 2020 07:20:09 EDT
Received: from wangqing-virtual-machine.localdomain (unknown [157.0.31.122])
        by m176115.mail.qiye.163.com (Hmail) with ESMTPA id BC58A66463C;
        Sat, 18 Apr 2020 19:14:33 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Enrico Weigelt <info@metux.net>,
        Allison Randal <allison@lohutok.net>,
        Wang Qing <wangqing@vivo.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com
Subject: [PATCH] arm: fixed backtrace when task running on another cpu
Date:   Sat, 18 Apr 2020 19:14:18 +0800
Message-Id: <1587208459-5470-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZSFVDT0NCQkJCTExKSkpDSVlXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PC46Cww4FTgzFg0xKgIQCR42
        H04wChJVSlVKTkNMSUtDT0xPS0pLVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZSk5M
        VUtVSEpVSklJWVdZCAFZQUlLTU03Bg++
X-HM-Tid: 0a718cff4d429373kuwsbc58a66463c
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We cannot get FP when the task is currently running on another CPU,
in this case, current stack is printed instead of the task.
Also, thread_saved_fp() is the last time the task was switched out,
we should not use too.

Signed-off-by: Wang Qing <wangqing@vivo.com>
---
 arch/arm/kernel/traps.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/kernel/traps.c b/arch/arm/kernel/traps.c
index 1e70e72..24e860a 100644
--- a/arch/arm/kernel/traps.c
+++ b/arch/arm/kernel/traps.c
@@ -222,6 +222,9 @@ static void dump_backtrace(struct pt_regs *regs, struct task_struct *tsk)
 	} else if (tsk != current) {
 		fp = thread_saved_fp(tsk);
 		mode = 0x10;
+	} else if (task_curr(tsk))
+		pr_info("tsk is running on another CPU, not trace!\n");
+		fp = 0;
 	} else {
 		asm("mov %0, fp" : "=r" (fp) : : "cc");
 		mode = 0x10;
-- 
2.7.4

