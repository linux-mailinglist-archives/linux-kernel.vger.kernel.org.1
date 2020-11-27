Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31A7D2C6041
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 08:01:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392672AbgK0HAA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 02:00:00 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:16344 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389454AbgK0HAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 02:00:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1606460400; x=1637996400;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=57Ghmx2IG0+gTtbHk8E7EBkjzBlUVnTyoH+tNzOl2Lo=;
  b=cyihaZBlgn1HPGDXNhEMU8wa9Ilxv0ZVfb6oYfnO20+K34isFKyA8DZJ
   064w1w4Q9zifTxxKDPel+DoUtYFruTuzlRmYeenw+xTGA1uRS1RxZ5JyO
   G65Jbe+kbiztOz/TNs972wxerqUlJot+v1CSukBEqdxFo1/W1DXJi8lPr
   o=;
X-IronPort-AV: E=Sophos;i="5.78,373,1599523200"; 
   d="scan'208";a="99623880"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2a-6e2fc477.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 27 Nov 2020 06:59:53 +0000
Received: from EX13MTAUWA001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-2a-6e2fc477.us-west-2.amazon.com (Postfix) with ESMTPS id 8583DA20A2;
        Fri, 27 Nov 2020 06:59:51 +0000 (UTC)
Received: from EX13D01UWA004.ant.amazon.com (10.43.160.99) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 27 Nov 2020 06:59:51 +0000
Received: from EX13MTAUEA001.ant.amazon.com (10.43.61.82) by
 EX13d01UWA004.ant.amazon.com (10.43.160.99) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Fri, 27 Nov 2020 06:59:50 +0000
Received: from localhost (10.85.0.203) by mail-relay.amazon.com (10.43.61.243)
 with Microsoft SMTP Server id 15.0.1497.2 via Frontend Transport; Fri, 27 Nov
 2020 06:59:49 +0000
From:   Balbir Singh <sblbir@amazon.com>
To:     <tglx@linutronix.de>, <mingo@redhat.com>
CC:     <peterz@infradead.org>, <linux-kernel@vger.kernel.org>,
        <keescook@chromium.org>, <jpoimboe@redhat.com>,
        <tony.luck@intel.com>, <benh@kernel.crashing.org>,
        <x86@kernel.org>, <dave.hansen@intel.com>,
        <thomas.lendacky@amd.com>, <torvalds@linux-foundation.org>,
        Balbir Singh <sblbir@amazon.com>
Subject: [PATCH v3 1/5] x86/mm: change l1d flush runtime prctl behaviour
Date:   Fri, 27 Nov 2020 17:59:34 +1100
Message-ID: <20201127065938.8200-2-sblbir@amazon.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201127065938.8200-1-sblbir@amazon.com>
References: <20201127065938.8200-1-sblbir@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Detection of task affinities at API opt-in time is not the best
approach, the approach is to kill the task if it runs on a
SMT enable core. This is better than not flushing the L1D cache
when the task switches from a non-SMT core to an SMT enabled core.

Signed-off-by: Balbir Singh <sblbir@amazon.com>
---
 arch/x86/include/asm/processor.h |  2 ++
 arch/x86/kernel/smpboot.c        | 11 ++++++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 82a08b585818..60dbcdcb833f 100644
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
index de776b2e6046..9a94934fae5f 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -635,6 +635,9 @@ void set_cpu_sibling_map(int cpu)
 	threads = cpumask_weight(topology_sibling_cpumask(cpu));
 	if (threads > __max_smt_threads)
 		__max_smt_threads = threads;
+
+	for_each_cpu(i, topology_sibling_cpumask(cpu))
+		cpu_data(i).smt_active = threads > 1;
 }
 
 /* maps the cpu to the sched domain representing multi-core */
@@ -1548,10 +1551,16 @@ static void remove_siblinginfo(int cpu)
 
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
+
 	cpumask_clear(cpu_llc_shared_mask(cpu));
 	cpumask_clear(topology_sibling_cpumask(cpu));
 	cpumask_clear(topology_core_cpumask(cpu));
-- 
2.17.1

