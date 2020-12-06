Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC6282D0512
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Dec 2020 14:15:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbgLFNOE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Dec 2020 08:14:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727395AbgLFNOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Dec 2020 08:14:03 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00573C0613D2
        for <linux-kernel@vger.kernel.org>; Sun,  6 Dec 2020 05:13:22 -0800 (PST)
Date:   Sun, 06 Dec 2020 13:11:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607260401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=u5Oo/kK0IyWyYjoglRbKsfyGxS1ioUZteJdos5CdTyw=;
        b=3eISxZglPROvyq9IIw6ij+HLX+8h8mEr/hDSr6fG/E/xKR7yPTTJWffMb1+wlGxe3YCFbF
        QiPp5poRzC72Q5foI08DPcTJlDJZ+XYhLZGR87S59eIbFDGU38/+TvMgKGRL8YrP4IM74R
        JotIeIMqq7mrpbQCNn7wmbJu42qnvHUGnTYz6w8wxG8INXuau0bgDoQv7CyqY2mbB81L6G
        O9xit4vssCEShGi/wtvgIfZF1boy1tRuu6MKQ4TDcrALol6Mlys7e8EG0YJ77aK3hkY49l
        OYvj574rv+AytMUKef26m50EltftI1bQNmTpVc1yeGMhxjBUK6KXPRM6UNWzeg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607260401;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:  references:references;
        bh=u5Oo/kK0IyWyYjoglRbKsfyGxS1ioUZteJdos5CdTyw=;
        b=LtxzVSwjCryCRu5SwNSRqEfsFw034vE4hOYQ8bY6tZfsXCwGLEyWXbyG2aV20Q/Zm4v7Bx
        qgN1p5aTErrcluCg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org
Subject: [GIT pull] x86/urgent for v5.10-rc7
References: <160726029814.10836.11636935433736940390.tglx@nanos>
Message-ID: <160726030175.10836.15260456457411664701.tglx@nanos>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull the latest x86/urgent branch from:

   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86-urgent-2020-12-06

up to:  84da009f06e6: x86/sev-es: Use new for_each_insn_prefix() macro to loop over prefixes bytes

A set of fixes for x86:

 - Make the AMD L3 QoS code and data priorization enable/disable mechanism
   work correctly. The control bit was only set/cleared on one of the CPUs
   in a L3 domain, but it has to be modified on all CPUs in the domain. The
   initial documentation was not clear about this, but the updated one from
   Oct 2020 spells it out.

 - Fix an off by one in the UV platform detection code which causes the UV
   hubs to be identified wrongly. The chip revisions start at 1 not at 0.

 - Fix a long standing bug in the evaluation of prefixes in the uprobes
   code which fails to handle repeated prefixes properly. The aggregate
   size of the prefixes can be larger than the bytes array but the code
   blindly iterated over the aggregate size beyond the array boundary.
   Add a macro to handle this case properly and use it at the affected
   places.


Thanks,

	tglx

------------------>
Babu Moger (1):
      x86/resctrl: Fix AMD L3 QOS CDP enable/disable

Masami Hiramatsu (3):
      x86/uprobes: Do not use prefixes.nbytes when looping over prefixes.bytes
      x86/insn-eval: Use new for_each_insn_prefix() macro to loop over prefixes bytes
      x86/sev-es: Use new for_each_insn_prefix() macro to loop over prefixes bytes

Mike Travis (1):
      x86/platform/uv: Fix UV4 hub revision adjustment


 arch/x86/boot/compressed/sev-es.c      |  5 ++---
 arch/x86/include/asm/insn.h            | 15 +++++++++++++++
 arch/x86/kernel/apic/x2apic_uv_x.c     |  2 +-
 arch/x86/kernel/cpu/resctrl/core.c     |  4 ++++
 arch/x86/kernel/cpu/resctrl/internal.h |  3 +++
 arch/x86/kernel/cpu/resctrl/rdtgroup.c |  9 +++++++--
 arch/x86/kernel/uprobes.c              | 10 ++++++----
 arch/x86/lib/insn-eval.c               | 10 +++++-----
 tools/arch/x86/include/asm/insn.h      | 15 +++++++++++++++
 9 files changed, 58 insertions(+), 15 deletions(-)

diff --git a/arch/x86/boot/compressed/sev-es.c b/arch/x86/boot/compressed/sev-es.c
index 954cb2702e23..27826c265aab 100644
--- a/arch/x86/boot/compressed/sev-es.c
+++ b/arch/x86/boot/compressed/sev-es.c
@@ -32,13 +32,12 @@ struct ghcb *boot_ghcb;
  */
 static bool insn_has_rep_prefix(struct insn *insn)
 {
+	insn_byte_t p;
 	int i;
 
 	insn_get_prefixes(insn);
 
-	for (i = 0; i < insn->prefixes.nbytes; i++) {
-		insn_byte_t p = insn->prefixes.bytes[i];
-
+	for_each_insn_prefix(insn, i, p) {
 		if (p == 0xf2 || p == 0xf3)
 			return true;
 	}
diff --git a/arch/x86/include/asm/insn.h b/arch/x86/include/asm/insn.h
index 5c1ae3eff9d4..a8c3d284fa46 100644
--- a/arch/x86/include/asm/insn.h
+++ b/arch/x86/include/asm/insn.h
@@ -201,6 +201,21 @@ static inline int insn_offset_immediate(struct insn *insn)
 	return insn_offset_displacement(insn) + insn->displacement.nbytes;
 }
 
+/**
+ * for_each_insn_prefix() -- Iterate prefixes in the instruction
+ * @insn: Pointer to struct insn.
+ * @idx:  Index storage.
+ * @prefix: Prefix byte.
+ *
+ * Iterate prefix bytes of given @insn. Each prefix byte is stored in @prefix
+ * and the index is stored in @idx (note that this @idx is just for a cursor,
+ * do not change it.)
+ * Since prefixes.nbytes can be bigger than 4 if some prefixes
+ * are repeated, it cannot be used for looping over the prefixes.
+ */
+#define for_each_insn_prefix(insn, idx, prefix)	\
+	for (idx = 0; idx < ARRAY_SIZE(insn->prefixes.bytes) && (prefix = insn->prefixes.bytes[idx]) != 0; idx++)
+
 #define POP_SS_OPCODE 0x1f
 #define MOV_SREG_OPCODE 0x8e
 
diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index 1b98f8c12b96..235f5cde06fc 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -161,7 +161,7 @@ static int __init early_set_hub_type(void)
 	/* UV4/4A only have a revision difference */
 	case UV4_HUB_PART_NUMBER:
 		uv_min_hub_revision_id = node_id.s.revision
-					 + UV4_HUB_REVISION_BASE;
+					 + UV4_HUB_REVISION_BASE - 1;
 		uv_hub_type_set(UV4);
 		if (uv_min_hub_revision_id == UV4A_HUB_REVISION_BASE)
 			uv_hub_type_set(UV4|UV4A);
diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index e5f4ee8f4c3b..e8b5f1cf1ae8 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -570,6 +570,8 @@ static void domain_add_cpu(int cpu, struct rdt_resource *r)
 
 	if (d) {
 		cpumask_set_cpu(cpu, &d->cpu_mask);
+		if (r->cache.arch_has_per_cpu_cfg)
+			rdt_domain_reconfigure_cdp(r);
 		return;
 	}
 
@@ -923,6 +925,7 @@ static __init void rdt_init_res_defs_intel(void)
 		    r->rid == RDT_RESOURCE_L2CODE) {
 			r->cache.arch_has_sparse_bitmaps = false;
 			r->cache.arch_has_empty_bitmaps = false;
+			r->cache.arch_has_per_cpu_cfg = false;
 		} else if (r->rid == RDT_RESOURCE_MBA) {
 			r->msr_base = MSR_IA32_MBA_THRTL_BASE;
 			r->msr_update = mba_wrmsr_intel;
@@ -943,6 +946,7 @@ static __init void rdt_init_res_defs_amd(void)
 		    r->rid == RDT_RESOURCE_L2CODE) {
 			r->cache.arch_has_sparse_bitmaps = true;
 			r->cache.arch_has_empty_bitmaps = true;
+			r->cache.arch_has_per_cpu_cfg = true;
 		} else if (r->rid == RDT_RESOURCE_MBA) {
 			r->msr_base = MSR_IA32_MBA_BW_BASE;
 			r->msr_update = mba_wrmsr_amd;
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 80fa997fae60..f65d3c0dbc41 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -360,6 +360,8 @@ struct msr_param {
  *			executing entities
  * @arch_has_sparse_bitmaps:	True if a bitmap like f00f is valid.
  * @arch_has_empty_bitmaps:	True if the '0' bitmap is valid.
+ * @arch_has_per_cpu_cfg:	True if QOS_CFG register for this cache
+ *				level has CPU scope.
  */
 struct rdt_cache {
 	unsigned int	cbm_len;
@@ -369,6 +371,7 @@ struct rdt_cache {
 	unsigned int	shareable_bits;
 	bool		arch_has_sparse_bitmaps;
 	bool		arch_has_empty_bitmaps;
+	bool		arch_has_per_cpu_cfg;
 };
 
 /**
diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index 6f4ca4bea625..f3418428682b 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -1909,8 +1909,13 @@ static int set_cache_qos_cfg(int level, bool enable)
 
 	r_l = &rdt_resources_all[level];
 	list_for_each_entry(d, &r_l->domains, list) {
-		/* Pick one CPU from each domain instance to update MSR */
-		cpumask_set_cpu(cpumask_any(&d->cpu_mask), cpu_mask);
+		if (r_l->cache.arch_has_per_cpu_cfg)
+			/* Pick all the CPUs in the domain instance */
+			for_each_cpu(cpu, &d->cpu_mask)
+				cpumask_set_cpu(cpu, cpu_mask);
+		else
+			/* Pick one CPU from each domain instance to update MSR */
+			cpumask_set_cpu(cpumask_any(&d->cpu_mask), cpu_mask);
 	}
 	cpu = get_cpu();
 	/* Update QOS_CFG MSR on this cpu if it's in cpu_mask. */
diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 3fdaa042823d..138bdb1fd136 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -255,12 +255,13 @@ static volatile u32 good_2byte_insns[256 / 32] = {
 
 static bool is_prefix_bad(struct insn *insn)
 {
+	insn_byte_t p;
 	int i;
 
-	for (i = 0; i < insn->prefixes.nbytes; i++) {
+	for_each_insn_prefix(insn, i, p) {
 		insn_attr_t attr;
 
-		attr = inat_get_opcode_attribute(insn->prefixes.bytes[i]);
+		attr = inat_get_opcode_attribute(p);
 		switch (attr) {
 		case INAT_MAKE_PREFIX(INAT_PFX_ES):
 		case INAT_MAKE_PREFIX(INAT_PFX_CS):
@@ -715,6 +716,7 @@ static const struct uprobe_xol_ops push_xol_ops = {
 static int branch_setup_xol_ops(struct arch_uprobe *auprobe, struct insn *insn)
 {
 	u8 opc1 = OPCODE1(insn);
+	insn_byte_t p;
 	int i;
 
 	switch (opc1) {
@@ -746,8 +748,8 @@ static int branch_setup_xol_ops(struct arch_uprobe *auprobe, struct insn *insn)
 	 * Intel and AMD behavior differ in 64-bit mode: Intel ignores 66 prefix.
 	 * No one uses these insns, reject any branch insns with such prefix.
 	 */
-	for (i = 0; i < insn->prefixes.nbytes; i++) {
-		if (insn->prefixes.bytes[i] == 0x66)
+	for_each_insn_prefix(insn, i, p) {
+		if (p == 0x66)
 			return -ENOTSUPP;
 	}
 
diff --git a/arch/x86/lib/insn-eval.c b/arch/x86/lib/insn-eval.c
index 58f7fb95c7f4..4229950a5d78 100644
--- a/arch/x86/lib/insn-eval.c
+++ b/arch/x86/lib/insn-eval.c
@@ -63,13 +63,12 @@ static bool is_string_insn(struct insn *insn)
  */
 bool insn_has_rep_prefix(struct insn *insn)
 {
+	insn_byte_t p;
 	int i;
 
 	insn_get_prefixes(insn);
 
-	for (i = 0; i < insn->prefixes.nbytes; i++) {
-		insn_byte_t p = insn->prefixes.bytes[i];
-
+	for_each_insn_prefix(insn, i, p) {
 		if (p == 0xf2 || p == 0xf3)
 			return true;
 	}
@@ -95,14 +94,15 @@ static int get_seg_reg_override_idx(struct insn *insn)
 {
 	int idx = INAT_SEG_REG_DEFAULT;
 	int num_overrides = 0, i;
+	insn_byte_t p;
 
 	insn_get_prefixes(insn);
 
 	/* Look for any segment override prefixes. */
-	for (i = 0; i < insn->prefixes.nbytes; i++) {
+	for_each_insn_prefix(insn, i, p) {
 		insn_attr_t attr;
 
-		attr = inat_get_opcode_attribute(insn->prefixes.bytes[i]);
+		attr = inat_get_opcode_attribute(p);
 		switch (attr) {
 		case INAT_MAKE_PREFIX(INAT_PFX_CS):
 			idx = INAT_SEG_REG_CS;
diff --git a/tools/arch/x86/include/asm/insn.h b/tools/arch/x86/include/asm/insn.h
index 568854b14d0a..52c6262e6bfd 100644
--- a/tools/arch/x86/include/asm/insn.h
+++ b/tools/arch/x86/include/asm/insn.h
@@ -201,6 +201,21 @@ static inline int insn_offset_immediate(struct insn *insn)
 	return insn_offset_displacement(insn) + insn->displacement.nbytes;
 }
 
+/**
+ * for_each_insn_prefix() -- Iterate prefixes in the instruction
+ * @insn: Pointer to struct insn.
+ * @idx:  Index storage.
+ * @prefix: Prefix byte.
+ *
+ * Iterate prefix bytes of given @insn. Each prefix byte is stored in @prefix
+ * and the index is stored in @idx (note that this @idx is just for a cursor,
+ * do not change it.)
+ * Since prefixes.nbytes can be bigger than 4 if some prefixes
+ * are repeated, it cannot be used for looping over the prefixes.
+ */
+#define for_each_insn_prefix(insn, idx, prefix)	\
+	for (idx = 0; idx < ARRAY_SIZE(insn->prefixes.bytes) && (prefix = insn->prefixes.bytes[idx]) != 0; idx++)
+
 #define POP_SS_OPCODE 0x1f
 #define MOV_SREG_OPCODE 0x8e
 

