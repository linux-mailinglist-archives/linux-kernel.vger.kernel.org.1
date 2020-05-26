Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7C991E1BEA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 May 2020 09:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731357AbgEZHGx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 May 2020 03:06:53 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:49329 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726990AbgEZHGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 03:06:53 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04427;MF=wetp.zy@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0TzhXv2Y_1590476801;
Received: from localhost(mailfrom:wetp.zy@linux.alibaba.com fp:SMTPD_---0TzhXv2Y_1590476801)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 26 May 2020 15:06:50 +0800
From:   Wetp Zhang <wetp.zy@linux.alibaba.com>
To:     n-horiguchi@ah.jp.nec.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mm, memory_failure: only send BUS_MCEERR_AO to early-kill process
Date:   Tue, 26 May 2020 15:06:41 +0800
Message-Id: <1590476801-19882-1-git-send-email-wetp.zy@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zhang Yi <wetpzy@gmail.com>

If a process don't need early-kill, it may not care the BUS_MCEERR_AO.
Let the process to be killed when it really access the corrupted memory.

Signed-off-by: Zhang Yi <wetpzy@gmail.com>
---
 mm/memory-failure.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index a96364be8ab4..2db13d48865c 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -210,7 +210,7 @@ static int kill_proc(struct to_kill *tk, unsigned long pfn, int flags)
 {
 	struct task_struct *t = tk->tsk;
 	short addr_lsb = tk->size_shift;
-	int ret;
+	int ret = 0;
 
 	pr_err("Memory failure: %#lx: Sending SIGBUS to %s:%d due to hardware memory corruption\n",
 		pfn, t->comm, t->pid);
@@ -225,8 +225,9 @@ static int kill_proc(struct to_kill *tk, unsigned long pfn, int flags)
 		 * This could cause a loop when the user sets SIGBUS
 		 * to SIG_IGN, but hopefully no one will do that?
 		 */
-		ret = send_sig_mceerr(BUS_MCEERR_AO, (void __user *)tk->addr,
-				      addr_lsb, t);  /* synchronous? */
+		if ((t->flags & PF_MCE_PROCESS) && (t->flags & PF_MCE_EARLY))
+			ret = send_sig_mceerr(BUS_MCEERR_AO,
+				(void __user *)tk->addr, addr_lsb, t);
 	}
 	if (ret < 0)
 		pr_info("Memory failure: Error sending signal to %s:%d: %d\n",
-- 
2.14.3 (Apple Git-98)

