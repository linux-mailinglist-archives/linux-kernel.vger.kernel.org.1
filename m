Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3A942AA9CD
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Nov 2020 07:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgKHGrV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Nov 2020 01:47:21 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:48547 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727667AbgKHGrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Nov 2020 01:47:21 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R761e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UEZYia4_1604818026;
Received: from aliy80.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0UEZYia4_1604818026)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 08 Nov 2020 14:47:07 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] x86/tlb: remove unused varible 'cpu'
Date:   Sun,  8 Nov 2020 14:47:04 +0800
Message-Id: <1604818024-3873-1-git-send-email-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's not used, we could remove it to avoid a W1 warning:
arch/x86/mm/tlb.c:318:6: warning: variable ‘cpu’ set but not used
[-Wunused-but-set-variable]

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com> 
Cc: Andy Lutomirski <luto@kernel.org> 
Cc: x86@kernel.org 
Cc: "H. Peter Anvin" <hpa@zytor.com> 
Cc: linux-kernel@vger.kernel.org 
---
 arch/x86/mm/tlb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 88e9ad5142e4..be2e9080ca79 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -315,7 +315,7 @@ void leave_mm(int cpu)
 
 int enable_l1d_flush_for_task(struct task_struct *tsk)
 {
-	int cpu, ret = 0, i;
+	int ret = 0, i;
 
 	/*
 	 * Do not enable L1D_FLUSH_OUT if
@@ -328,7 +328,7 @@ int enable_l1d_flush_for_task(struct task_struct *tsk)
 			!static_cpu_has(X86_FEATURE_FLUSH_L1D))
 		return -EINVAL;
 
-	cpu = get_cpu();
+	get_cpu();
 
 	for_each_cpu(i, &tsk->cpus_mask) {
 		if (cpu_data(i).smt_active == true) {
-- 
1.8.3.1

