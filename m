Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE18281FF7
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Oct 2020 03:16:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725821AbgJCBP7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Oct 2020 21:15:59 -0400
Received: from mga11.intel.com ([192.55.52.93]:53475 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725550AbgJCBPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Oct 2020 21:15:49 -0400
IronPort-SDR: 6R/8SmycwubMsc0vu6LLgxOQWhQSezSVJjvVwcXSIaO+DfB6XSZ7T3pLEqDr81KIB2fQ37Xuxg
 IShjDYCV5vGQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9762"; a="160436329"
X-IronPort-AV: E=Sophos;i="5.77,329,1596524400"; 
   d="scan'208";a="160436329"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2020 18:15:48 -0700
IronPort-SDR: OgSlaYaUfjMtCNeloWh2eEicy15R5Q8SwXSYtgZImuj4ES3+8GNdKHWZHXpLNpYJ4OEMkAAuD6
 B0s0OfwdFWmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,329,1596524400"; 
   d="scan'208";a="325996791"
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
        Dave Hansen <dave.hansen@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: [PATCH 3/4] x86/cpu/intel: Add function to get name of hybrid CPU types
Date:   Fri,  2 Oct 2020 18:17:44 -0700
Message-Id: <20201003011745.7768-4-ricardo.neri-calderon@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201003011745.7768-1-ricardo.neri-calderon@linux.intel.com>
References: <20201003011745.7768-1-ricardo.neri-calderon@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provided a human-friendly string name for each type of CPU micro-
architecture in Intel hybrid parts. This string is to be used in the
CPU type sysfs interface.

In order to uniquely identify CPUs of the same type, compose the name
string as <cpu_type_name>_<native_model_id_nr>.

Cc: Andi Kleen <ak@linux.intel.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Len Brown <len.brown@intel.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-kernel@vger.kernel.org
Reviewed-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
---
 arch/x86/include/asm/intel-family.h |  4 ++++
 arch/x86/kernel/cpu/cpu.h           |  3 +++
 arch/x86/kernel/cpu/intel.c         | 23 +++++++++++++++++++++++
 3 files changed, 30 insertions(+)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 5e658ba2654a..4ec2272e0049 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -133,4 +133,8 @@
 /* Family 5 */
 #define INTEL_FAM5_QUARK_X1000		0x09 /* Quark X1000 SoC */
 
+/* Types of CPUs in hybrid parts. */
+#define INTEL_HYBRID_TYPE_ATOM		0x20
+#define INTEL_HYBRID_TYPE_CORE		0x40
+
 #endif /* _ASM_X86_INTEL_FAMILY_H */
diff --git a/arch/x86/kernel/cpu/cpu.h b/arch/x86/kernel/cpu/cpu.h
index 9d033693519a..b4474238e1f3 100644
--- a/arch/x86/kernel/cpu/cpu.h
+++ b/arch/x86/kernel/cpu/cpu.h
@@ -56,8 +56,11 @@ extern __ro_after_init enum tsx_ctrl_states tsx_ctrl_state;
 extern void __init tsx_init(void);
 extern void tsx_enable(void);
 extern void tsx_disable(void);
+extern const char *intel_get_hybrid_cpu_type_name(u32 cpu_type);
 #else
 static inline void tsx_init(void) { }
+static inline const char *intel_get_hybrid_cpu_type_name(u32 cpu_type)
+{ return NULL; }
 #endif /* CONFIG_CPU_SUP_INTEL */
 
 extern void get_cpu_cap(struct cpuinfo_x86 *c);
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 59a1e3ce3f14..e1dee382cf98 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -1191,3 +1191,26 @@ void __init cpu_set_core_cap_bits(struct cpuinfo_x86 *c)
 	cpu_model_supports_sld = true;
 	split_lock_setup();
 }
+
+static char hybrid_name[64];
+
+const char *intel_get_hybrid_cpu_type_name(u32 cpu_type)
+{
+	u32 native_model_id = cpu_type & X86_HYBRID_CPU_NATIVE_MODEL_ID_MASK;
+	u8 type = cpu_type >> X86_HYBRID_CPU_TYPE_ID_SHIFT;
+
+	switch (type) {
+	case INTEL_HYBRID_TYPE_ATOM:
+		snprintf(hybrid_name, sizeof(hybrid_name), "intel_atom_%u",
+			 native_model_id);
+		break;
+	case INTEL_HYBRID_TYPE_CORE:
+		snprintf(hybrid_name, sizeof(hybrid_name), "intel_core_%u",
+			 native_model_id);
+		break;
+	default:
+		return NULL;
+	}
+
+	return hybrid_name;
+}
-- 
2.17.1

