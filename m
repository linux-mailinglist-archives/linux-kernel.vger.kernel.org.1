Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B879F2EF210
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jan 2021 13:12:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbhAHMMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jan 2021 07:12:14 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:15811 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726844AbhAHMMN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jan 2021 07:12:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1610107932; x=1641643932;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=QQTM6sQEOgh6Wti8VCQ99Arusb4QiOzUNHP+GP2lJZ4=;
  b=ORIjbzO3JhLo48zNuFwririjkQnA2NWlwnVBvSSAsIW2S1TzEzfz60eQ
   xQxy/1PHq2TooQjXlybv6IVnNTVH9Dj5vOJeD6Mfh0XiNjw2LD8EszU9L
   Z5fgqVE5siTZzzk523uLUrpDbGWloulbgkgupjxhpD5FPVkD+guIq/1eR
   0=;
X-IronPort-AV: E=Sophos;i="5.79,330,1602547200"; 
   d="scan'208";a="110540361"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 08 Jan 2021 12:11:11 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com (Postfix) with ESMTPS id 43990A23BF;
        Fri,  8 Jan 2021 12:11:07 +0000 (UTC)
Received: from EX13D01UWA001.ant.amazon.com (10.43.160.60) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 8 Jan 2021 12:11:07 +0000
Received: from EX13MTAUWA001.ant.amazon.com (10.43.160.58) by
 EX13d01UWA001.ant.amazon.com (10.43.160.60) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 8 Jan 2021 12:11:07 +0000
Received: from localhost (10.85.0.12) by mail-relay.amazon.com (10.43.160.118)
 with Microsoft SMTP Server id 15.0.1497.2 via Frontend Transport; Fri, 8 Jan
 2021 12:11:06 +0000
From:   Balbir Singh <sblbir@amazon.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>
CC:     <peterz@infradead.org>, <linux-kernel@vger.kernel.org>,
        <keescook@chromium.org>, <jpoimboe@redhat.com>,
        <tony.luck@intel.com>, <benh@kernel.crashing.org>,
        <x86@kernel.org>, <dave.hansen@intel.com>,
        <thomas.lendacky@amd.com>, <torvalds@linux-foundation.org>,
        Balbir Singh <sblbir@amazon.com>
Subject: [PATCH v4 1/5] x86/smp: Add a per-cpu view of SMT state
Date:   Fri, 8 Jan 2021 23:10:52 +1100
Message-ID: <20210108121056.21940-2-sblbir@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210108121056.21940-1-sblbir@amazon.com>
References: <20210108121056.21940-1-sblbir@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A new field smt_active in cpuinfo_x86 identifies if the current core/cpu
is in SMT mode or not. This can be very helpful if the system has some
of its cores with threads offlined and can be used for cases where
action is taken based on the state of SMT. The follow up patches use
this feature.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Balbir Singh <sblbir@amazon.com>
---
 arch/x86/include/asm/processor.h |  2 ++
 arch/x86/kernel/smpboot.c        | 10 +++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index c20a52b5534b..a411466a6e74 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -136,6 +136,8 @@ struct cpuinfo_x86 {
 	u16			logical_die_id;
 	/* Index into per_cpu list: */
 	u16			cpu_index;
+	/*  Is SMT active on this core? */
+	bool			smt_active;
 	u32			microcode;
 	/* Address space bits used by the cache internally */
 	u8			x86_cache_bits;
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 8ca66af96a54..5f6df298d785 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -640,6 +640,9 @@ void set_cpu_sibling_map(int cpu)
 	threads = cpumask_weight(topology_sibling_cpumask(cpu));
 	if (threads > __max_smt_threads)
 		__max_smt_threads = threads;
+
+	for_each_cpu(i, topology_sibling_cpumask(cpu))
+		cpu_data(i).smt_active = threads > 1;
 }
 
 /* maps the cpu to the sched domain representing multi-core */
@@ -1551,8 +1554,13 @@ static void remove_siblinginfo(int cpu)
 
 	for_each_cpu(sibling, topology_die_cpumask(cpu))
 		cpumask_clear_cpu(cpu, topology_die_cpumask(sibling));
-	for_each_cpu(sibling, topology_sibling_cpumask(cpu))
+
+	for_each_cpu(sibling, topology_sibling_cpumask(cpu)) {
 		cpumask_clear_cpu(cpu, topology_sibling_cpumask(sibling));
+		if (cpumask_weight(topology_sibling_cpumask(sibling)) == 1)
+			cpu_data(sibling).smt_active = false;
+	}
+
 	for_each_cpu(sibling, cpu_llc_shared_mask(cpu))
 		cpumask_clear_cpu(cpu, cpu_llc_shared_mask(sibling));
 	cpumask_clear(cpu_llc_shared_mask(cpu));
-- 
2.17.1

