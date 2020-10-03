Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB612281FF8
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 03:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725829AbgJCBQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 21:16:00 -0400
Received: from mga11.intel.com ([192.55.52.93]:53472 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725795AbgJCBPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 21:15:49 -0400
IronPort-SDR: P5Sec4b6tpXvdfP4uVCDR/OxngOcqmC7uGDfGbuW6UAayz15pZ/HKpUgu4evionzUomIAktk/h
 M5HiQLXeSD/A==
X-IronPort-AV: E=McAfee;i="6000,8403,9762"; a="160436330"
X-IronPort-AV: E=Sophos;i="5.77,329,1596524400"; 
   d="scan'208";a="160436330"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2020 18:15:48 -0700
IronPort-SDR: lAxzQVGKuMxkID9g+fJASlns2DwBBYh6sTVMtg7mjJZD7y67rzpMUlLE33yKcDG08mtNcScJ2q
 V19o/bq9FttA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,329,1596524400"; 
   d="scan'208";a="325996798"
Received: from ranerica-svr.sc.intel.com ([172.25.110.23])
  by orsmga002.jf.intel.com with ESMTP; 02 Oct 2020 18:15:48 -0700
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
        Dave Hansen <dave.hansen@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 4/4] x86/cpu/topology: Implement the CPU type sysfs interface
Date:   Fri,  2 Oct 2020 18:17:45 -0700
Message-Id: <20201003011745.7768-5-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201003011745.7768-1-ricardo.neri-calderon@linux.intel.com>
References: <20201003011745.7768-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recent Intel processors combine CPUs with different types of micro-
architecture in the same package. There may be applications interested in
knowing the type topology of the system. For instance, it can be used to
to determine which subsets of CPUs share a common feature.

Implement cpu_type sysfs interfaces for Intel processors.

For example, in a system with four Intel Atom CPUs and one Intel Core CPU,
these entries look as below. In this example, the native model IDs for
both types of CPUs are 0:

user@host:~$: ls /sys/devices/system/cpu/types
intel_atom_0 intel_core_0

user@host:~$ ls /sys/devices/system/cpu/types/intel_atom_0
cpulist cpumap

user@host:~$ ls /sys/devices/system/cpu/types/intel_core_0
cpulist cpumap

user@host:~$ cat /sys/devices/system/cpu/types/intel_atom/cpumap
0f

user@host:~$ cat /sys/devices/system/cpu/types/intel_atom/cpulist
0-3

user@nost:~$ cat /sys/devices/system/cpu/types/intel_core/cpumap
10

user@host:~$ cat /sys/devices/system/cpu/types/intel_core/cpulist
4

Cc: Andi Kleen <ak@linux.intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-kernel@vger.kernel.org
Reviewed-by: Tony Luck <tony.luck@intel.com>
Suggested-by: Len Brown <len.brown@intel.com> # Necessity of the interface
Suggested-by: Dave Hansen <dave.hansen@intel.com> # Details of the interface
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
 arch/x86/include/asm/topology.h |  2 ++
 arch/x86/kernel/cpu/topology.c  | 23 +++++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/arch/x86/include/asm/topology.h b/arch/x86/include/asm/topology.h
index f4234575f3fd..d4a3e1ce8338 100644
--- a/arch/x86/include/asm/topology.h
+++ b/arch/x86/include/asm/topology.h
@@ -218,4 +218,6 @@ static inline void arch_set_max_freq_ratio(bool turbo_disabled)
 }
 #endif
 
+#define CPUTYPES_MAX_NR 2
+
 #endif /* _ASM_X86_TOPOLOGY_H */
diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index d3a0791bc052..709fc473f905 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -153,3 +153,26 @@ int detect_extended_topology(struct cpuinfo_x86 *c)
 #endif
 	return 0;
 }
+
+u32 arch_get_cpu_type(int cpu)
+{
+	struct cpuinfo_x86 *c = &cpu_data(cpu);
+
+	if (cpu < 0 || cpu >= nr_cpu_ids)
+		return 0;
+
+	return c->x86_cpu_type;
+}
+
+bool arch_has_cpu_type(void)
+{
+	return boot_cpu_has(X86_FEATURE_HYBRID_CPU);
+}
+
+const char *arch_get_cpu_type_name(u32 cpu_type)
+{
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
+		return intel_get_hybrid_cpu_type_name(cpu_type);
+
+	return NULL;
+}
-- 
2.17.1

