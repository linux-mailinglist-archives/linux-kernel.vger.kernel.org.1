Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 917851AF634
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Apr 2020 03:58:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbgDSB6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Apr 2020 21:58:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:35188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726067AbgDSB6E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 21:58:04 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4385021D6C;
        Sun, 19 Apr 2020 01:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587261484;
        bh=ZISZO3v3AhBff22PqMDVPy3sI56gdxu348tYny317jk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vO04xpvD589wU5RKAbSud4WUn42oUxfTzgRyw0S6FrAQLG8fdzb66CNQkBBZzjHcH
         VYYUCemvGSeK+EaYb3zTmROkvCdsYlQRNl1ch8HoOL9uVdKEuNX5Xv7sDxwX4DB2Rz
         rSvFatQw0b5Hvfyd6KXjnXYmybiVfBQJEZj+r3IY=
From:   Sasha Levin <sashal@kernel.org>
To:     mingo@kernel.org, peterz@infradead.org
Cc:     linux-kernel@vger.kernel.org, tglx@linutronix.de, jolsa@redhat.com,
        alexey.budankov@linux.intel.com, songliubraving@fb.com,
        acme@redhat.com, allison@lohutok.net,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH v2 05/12] tools/lib/lockdep: add definition required for IRQ flag tracing
Date:   Sat, 18 Apr 2020 21:57:47 -0400
Message-Id: <20200419015754.24456-6-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200419015754.24456-1-sashal@kernel.org>
References: <20200419015754.24456-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We are going to start building with CONFIG_TRACE_IRQFLAGS defined, so
let's wire up a few dummy variables in our task_struct.

This isn't needed in userspace, but due to some refactoring in
kernel-side lockdep it's easier to just wire it up and enable
CONFIG_TRACE_IRQFLAGS.

Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/include/linux/lockdep.h | 8 ++++++++
 tools/lib/lockdep/lockdep.c   | 4 ++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/include/linux/lockdep.h b/tools/include/linux/lockdep.h
index e56997288f2b0..3a9924d6d3ae8 100644
--- a/tools/include/linux/lockdep.h
+++ b/tools/include/linux/lockdep.h
@@ -23,6 +23,8 @@
 
 #include "../../../include/linux/lockdep.h"
 
+static bool early_boot_irqs_disabled;
+
 struct task_struct {
 	u64 curr_chain_key;
 	int lockdep_depth;
@@ -31,6 +33,12 @@ struct task_struct {
 	gfp_t lockdep_reclaim_gfp;
 	int pid;
 	int state;
+	int softirqs_enabled, hardirqs_enabled, softirqs_disabled, hardirqs_disabled, irq_events;
+	unsigned long softirq_disable_ip, softirq_enable_ip;
+	unsigned int softirq_disable_event, softirq_enable_event;
+	unsigned long hardirq_disable_ip, hardirq_enable_ip;
+	unsigned int hardirq_disable_event, hardirq_enable_event;
+	int softirq_context, hardirq_context;
 	char comm[17];
 };
 
diff --git a/tools/lib/lockdep/lockdep.c b/tools/lib/lockdep/lockdep.c
index 348a9d0fb766a..9be12d233477a 100644
--- a/tools/lib/lockdep/lockdep.c
+++ b/tools/lib/lockdep/lockdep.c
@@ -15,10 +15,10 @@ u32 prandom_u32(void)
 	abort();
 }
 
-void print_irqtrace_events(struct task_struct *curr)
+/*void print_irqtrace_events(struct task_struct *curr)
 {
 	abort();
-}
+}*/
 
 static struct new_utsname *init_utsname(void)
 {
-- 
2.20.1

