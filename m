Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30CF02AD0C4
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 09:03:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726849AbgKJIC5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 03:02:57 -0500
Received: from mail-m1271.qiye.163.com ([115.236.127.1]:35367 "EHLO
        mail-m1271.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726467AbgKJIC4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 03:02:56 -0500
Received: from vivo-HP-ProDesk-680-G4-PCI-MT.vivo.xyz (unknown [58.251.74.231])
        by mail-m1271.qiye.163.com (Hmail) with ESMTPA id 0E6B758309A;
        Tue, 10 Nov 2020 16:02:53 +0800 (CST)
From:   Wang Qing <wangqing@vivo.com>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Jordan Niethe <jniethe5@gmail.com>,
        Alistair Popple <alistair@popple.id.au>,
        Michael Neuling <mikey@neuling.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     tglx@linutronix.de, Wang Qing <wangqing@vivo.com>
Subject: [PATCH V2] sched/rt, powerpc: Prepare for PREEMPT_RT
Date:   Tue, 10 Nov 2020 16:02:47 +0800
Message-Id: <1604995368-29649-1-git-send-email-wangqing@vivo.com>
X-Mailer: git-send-email 2.7.4
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZS1VLWVdZKFlBSE83V1ktWUFJV1kPCR
        oVCBIfWUFZHh4fSU4eQh5CHhpCVkpNS09CQk5ITEhMS05VEwETFhoSFyQUDg9ZV1kWGg8SFR0UWU
        FZT0tIVUpKS0hKQ1VLWQY+
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PRw6Mio5FT8uGREdHiEuGhUx
        GQsaFDlVSlVKTUtPQkJOSExPSkxOVTMWGhIXVQwaFRwKEhUcOw0SDRRVGBQWRVlXWRILWUFZTkNV
        SU5KVUxPVUlISllXWQgBWUFJQ0lKNwY+
X-HM-Tid: 0a75b12dda1498b6kuuu0e6b758309a
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PREEMPT_RT is a separate preemption model, CONFIG_PRTTMPT will
 be disabled when CONFIG_PREEMPT_RT is enabled,  so you need
to add CONFIG_PREEMPT_RT judgments to __die().

Signed-off-by: Wang Qing <wangqing@vivo.com>

Changes in v2:
 - Modify as Christophe suggested.
---
 arch/powerpc/kernel/traps.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 5006dcb..dec7b81
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -262,10 +262,11 @@ static int __die(const char *str, struct pt_regs *regs, long err)
 {
 	printk("Oops: %s, sig: %ld [#%d]\n", str, err, ++die_counter);
 
-	printk("%s PAGE_SIZE=%luK%s%s%s%s%s%s %s\n",
+	printk("%s PAGE_SIZE=%luK%s%s%s%s%s%s%s %s\n",
 	       IS_ENABLED(CONFIG_CPU_LITTLE_ENDIAN) ? "LE" : "BE",
 	       PAGE_SIZE / 1024, get_mmu_str(),
 	       IS_ENABLED(CONFIG_PREEMPT) ? " PREEMPT" : "",
+	       IS_ENABLED(CONFIG_PREEMPT_RT) ? " PREEMPT_RT" : "",
 	       IS_ENABLED(CONFIG_SMP) ? " SMP" : "",
 	       IS_ENABLED(CONFIG_SMP) ? (" NR_CPUS=" __stringify(NR_CPUS)) : "",
 	       debug_pagealloc_enabled() ? " DEBUG_PAGEALLOC" : "",
-- 
2.7.4

