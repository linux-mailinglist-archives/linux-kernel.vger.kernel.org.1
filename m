Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C538C1CB15D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 May 2020 16:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727822AbgEHOHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 May 2020 10:07:55 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:4306 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726736AbgEHOHy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 10:07:54 -0400
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id A85A628D4C6CB04BA175;
        Fri,  8 May 2020 22:07:48 +0800 (CST)
Received: from localhost (10.166.215.154) by DGGEMS405-HUB.china.huawei.com
 (10.3.19.205) with Microsoft SMTP Server id 14.3.487.0; Fri, 8 May 2020
 22:07:39 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <rostedt@goodmis.org>, <mingo@redhat.com>,
        <heiko.carstens@de.ibm.com>, <gor@linux.ibm.com>,
        <borntraeger@de.ibm.com>, <svens@linux.ibm.com>
CC:     <linux-s390@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] s390: Remove two unused inline functions
Date:   Fri, 8 May 2020 22:07:24 +0800
Message-ID: <20200508140724.11324-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.166.215.154]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit 657480d9c015 ("s390: support KPROBES_ON_FTRACE")
left behind this, remove it.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 arch/s390/kernel/ftrace.c | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/arch/s390/kernel/ftrace.c b/arch/s390/kernel/ftrace.c
index 4cd9b1ada834..44e01dd1e624 100644
--- a/arch/s390/kernel/ftrace.c
+++ b/arch/s390/kernel/ftrace.c
@@ -72,22 +72,6 @@ static inline void ftrace_generate_orig_insn(struct ftrace_insn *insn)
 #endif
 }
 
-static inline void ftrace_generate_kprobe_nop_insn(struct ftrace_insn *insn)
-{
-#ifdef CONFIG_KPROBES
-	insn->opc = BREAKPOINT_INSTRUCTION;
-	insn->disp = KPROBE_ON_FTRACE_NOP;
-#endif
-}
-
-static inline void ftrace_generate_kprobe_call_insn(struct ftrace_insn *insn)
-{
-#ifdef CONFIG_KPROBES
-	insn->opc = BREAKPOINT_INSTRUCTION;
-	insn->disp = KPROBE_ON_FTRACE_CALL;
-#endif
-}
-
 int ftrace_modify_call(struct dyn_ftrace *rec, unsigned long old_addr,
 		       unsigned long addr)
 {
-- 
2.17.1


