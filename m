Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5312043D3
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 00:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731364AbgFVWnX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Jun 2020 18:43:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:59820 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731293AbgFVWnJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 18:43:09 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C26DB207F5;
        Mon, 22 Jun 2020 22:43:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592865788;
        bh=tRYFaJHLbrWHuzhI/M9Ok8ONo7BPRx1puliRQGyQrBY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zJ+2VlIHwmfY9u1go9/HUOOA9OPk+yl6m7kcxovEPjd0MdAOc3gqOSJPVmeIq0CXF
         VrbCKUPL1hkO2f6VMkz4FRifQ6X3/eNF6DOiAFy83v3g47JaN7EQMsS9EIt53oUGR2
         5pk7bj4IF2+jOi/VhZlneBCob16YfOGqtBvI8P3E=
From:   Sasha Levin <sashal@kernel.org>
To:     peterz@infradead.org
Cc:     mingo@kernel.org, linux-kernel@vger.kernel.org, tglx@linutronix.de,
        jolsa@redhat.com, alexey.budankov@linux.intel.com,
        songliubraving@fb.com, acme@redhat.com, allison@lohutok.net,
        sashal@kernel.org
Subject: [PATCH v3 05/14] tools/lib/lockdep: add definition required for IRQ flag tracing
Date:   Mon, 22 Jun 2020 18:42:49 -0400
Message-Id: <20200622224258.1208588-6-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200622224258.1208588-1-sashal@kernel.org>
References: <20200622224258.1208588-1-sashal@kernel.org>
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
2.25.1

