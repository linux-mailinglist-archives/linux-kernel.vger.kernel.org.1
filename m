Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAB9D281FF5
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 03:15:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725804AbgJCBPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 21:15:50 -0400
Received: from mga11.intel.com ([192.55.52.93]:53472 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725794AbgJCBPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 21:15:49 -0400
IronPort-SDR: KhrSy4ag+cNVC3uJUxUCGHJQEJJ2zl5bsi28fTrXB5XAG6PLkvQLPsTlyeVDd1b/z1cxxNoQFz
 jkmhsTBrVL8Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9762"; a="160436328"
X-IronPort-AV: E=Sophos;i="5.77,329,1596524400"; 
   d="scan'208";a="160436328"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2020 18:15:47 -0700
IronPort-SDR: stAAaDiDDRSCHXsGIkmVKRtWMx8jcVFUaSBcIkuxJDmg4abVCyf+UCEz3uX9XLqUa2ErDKKWY8
 Ax68OiB3LK/w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,329,1596524400"; 
   d="scan'208";a="325996785"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga002.jf.intel.com with ESMTP; 02 Oct 2020 18:15:47 -0700
From:   Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>, x86@kernel.org,
        Borislav Petkov <bp@suse.de>, Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc:     Tony Luck <tony.luck@intel.com>, Len Brown <len.brown@intel.com>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        linux-kernel@vger.kernel.org,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 2/4] x86/cpu: Describe hybrid CPUs in cpuinfo_x86
Date:   Fri,  2 Oct 2020 18:17:43 -0700
Message-Id: <20201003011745.7768-3-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201003011745.7768-1-ricardo.neri-calderon@linux.intel.com>
References: <20201003011745.7768-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When Linux runs on Intel hybrid parts (i.e., having more than one type of
CPU in the same package), subsystems that deal with specific CPU features
may need to know the type of CPU in which they run. Instead of having each
subsystem to inspect CPUID leaves on its own, add a new member to
cpuinfo_x86 that can be queried to know the type of CPU.

Also, hybrid parts have a native model ID to uniquely identify the
micro-architecture of each CPU. Please note that the native model ID is not
related with the existing x86_model_id read from CPUID leaf 0x1.

In order to uniquely identify a CPU by type and micro-architecture, combine
the aforementioned identifiers into a single new member, x86_cpu_type.

The Intel manual (SDM) defines the CPU type and the CPU native model ID as
8-bit and 24-bit identifiers, respectively; they are packed in %eax when
read from CPUID.

Define also masks that subsystems can use to obtain the CPU type or the
native model separately. The native model ID only requires only a bit mask
as it uses the 24 least significant bits of %eax. The CPU type identifier
requires only a shift value as it uses the 8 most significant bytes of
%eax.

Cc: Andi Kleen <ak@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Len Brown <len.brown@intel.com>
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: Sean Christopherson <sean.j.christopherson@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-kernel@vger.kernel.org
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
I pulled this patch from a separate series[1] as per request from Boris.

Changes wrt to such series:
 * Use cpuid_eax() instead of cpuid_count() to read %eax result from
   CPUID. (Boris)

[1]. https://lkml.org/lkml/2020/10/2/1013
---
 arch/x86/include/asm/processor.h | 13 +++++++++++++
 arch/x86/kernel/cpu/common.c     |  3 +++
 2 files changed, 16 insertions(+)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index f88c74d7dbd4..d86cdf2b1562 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -141,6 +141,16 @@ struct cpuinfo_x86 {
 	u32			microcode;
 	/* Address space bits used by the cache internally */
 	u8			x86_cache_bits;
+	/*
+	 * In hybrid parts, there is a CPU type and a native model ID. The
+	 * CPU type (x86_cpu_type[31:24]) describes the type of micro-
+	 * architecture families. The native model ID (x86_cpu_type[23:0])
+	 * describes a specific microarchitecture version. Combining both
+	 * allows to uniquely identify a CPU.
+	 *
+	 * Please note that the native model ID is not related to x86_model.
+	 */
+	u32			x86_cpu_type;
 	unsigned		initialized : 1;
 } __randomize_layout;
 
@@ -168,6 +178,9 @@ enum cpuid_regs_idx {
 
 #define X86_VENDOR_UNKNOWN	0xff
 
+#define X86_HYBRID_CPU_TYPE_ID_SHIFT		24
+#define X86_HYBRID_CPU_NATIVE_MODEL_ID_MASK	0xffffff
+
 /*
  * capabilities of CPUs
  */
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 35ad8480c464..a66c1fdc0e27 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -932,6 +932,9 @@ void get_cpu_cap(struct cpuinfo_x86 *c)
 		c->x86_capability[CPUID_D_1_EAX] = eax;
 	}
 
+	if (cpu_has(c, X86_FEATURE_HYBRID_CPU))
+		c->x86_cpu_type = cpuid_eax(0x0000001a);
+
 	/* AMD-defined flags: level 0x80000001 */
 	eax = cpuid_eax(0x80000000);
 	c->extended_cpuid_level = eax;
-- 
2.17.1

