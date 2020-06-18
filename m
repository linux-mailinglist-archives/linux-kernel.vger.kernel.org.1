Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F01B1FF918
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jun 2020 18:20:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731945AbgFRQUC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Jun 2020 12:20:02 -0400
Received: from conuserg-10.nifty.com ([210.131.2.77]:34974 "EHLO
        conuserg-10.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731272AbgFRQUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 12:20:01 -0400
Received: from oscar.flets-west.jp (softbank126090202047.bbtec.net [126.90.202.47]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 05IGHqZA027327;
        Fri, 19 Jun 2020 01:17:52 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 05IGHqZA027327
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1592497073;
        bh=IF3xULoeXnGB+k9UcqNfKU1f01wqRcEAsOsoDhwit7M=;
        h=From:To:Cc:Subject:Date:From;
        b=u7H0Rjqeox7aSFatubRj542v2dGdwC8zsdX52NoFG26Ekm7qILBuiBylr78ybJOy1
         5FlpCumLB2EybelhJq+6cTwMIjMkewqxpe0/GtHeU/oIxOAbM/mOPJGuFgEOD7LJIh
         PmAUKBQVsVe7Kq5/9nZlrNQvmaDz4Zv/M+HyJcTkJC0MEr7NTPCgwSecK+GLz4WN2T
         nKBYWhKKuHqfVTjfRdb52SWlM4rFV15H00sB2UBnN/xVHZ8oEvTQvy4R+Ft7j0V4t+
         BAiasmo5xbJUrFoBTa/0/d4Z14vudQwjsXnwGoI+qQDusVKwzFoAJf2MdBmbz2+qDg
         v/L+hXxg+3rHg==
X-Nifty-SrcIP: [126.90.202.47]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Masahiro Yamada <masahiroy@kernel.org>,
        Ben Segall <bsegall@google.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] sched: fix thread_union::task visibility
Date:   Fri, 19 Jun 2020 01:17:49 +0900
Message-Id: <20200618161750.178659-1-masahiroy@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When CONFIG_ARCH_TASK_STRUCT_ON_STACK=y (i.e. ARCH=ia64), task_struct
and the thread stack are shared.

The ifdef condition of CONFIG_ARCH_TASK_STRUCT_ON_STACK is opposite.

Now that the init thread stack is constructed by the linker script,
this is not a practical problem, but let's fix the code just in case.

Fixes: 0500871f21b2 ("Construct init thread stack in the linker script rather than by union")
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 include/linux/sched.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index b62e6aaf28f0..6d6c4d38c063 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1674,7 +1674,7 @@ extern void ia64_set_curr_task(int cpu, struct task_struct *p);
 void yield(void);
 
 union thread_union {
-#ifndef CONFIG_ARCH_TASK_STRUCT_ON_STACK
+#ifdef CONFIG_ARCH_TASK_STRUCT_ON_STACK
 	struct task_struct task;
 #endif
 #ifndef CONFIG_THREAD_INFO_IN_TASK
-- 
2.25.1

