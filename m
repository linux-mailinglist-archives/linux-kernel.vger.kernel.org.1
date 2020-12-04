Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAAC2CEC91
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 11:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387790AbgLDK4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 05:56:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:51294 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727365AbgLDK4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 05:56:06 -0500
From:   Masami Hiramatsu <mhiramat@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Joerg Roedel <jroedel@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        Jann Horn <jannh@google.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/3] x86/uprobes: Fix not using prefixes.nbytes for loop over prefixes.bytes
Date:   Fri,  4 Dec 2020 19:55:20 +0900
Message-Id: <160707931985.3296595.4852247459424743502.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <160707930875.3296595.12884856538916078988.stgit@devnote2>
References: <160707930875.3296595.12884856538916078988.stgit@devnote2>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since the insn.prefixes.nbytes can be bigger than the size of
insn.prefixes.bytes[] when a same prefix is repeated, we have to
check whether the insn.prefixes.bytes[i] != 0 and i < 4(*) instead
of insn.prefixes.nbytes.
(*) 4 is the number of maximum legacy prefix groups on one instruction.
This introduces for_each_insn_prefix() macro for this purpose.

Fixes: 2b1444983508 ("uprobes, mm, x86: Add the ability to install and remove uprobes breakpoints")
Reported-by: syzbot+9b64b619f10f19d19a7c@syzkaller.appspotmail.com
Debugged-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
Cc: stable@vger.kernel.org
---
 Changes in v3:
  - Add NUM_INSN_FIELD_BYTES and MAX_LEGACY_PREFIX_GROUPS macros
    and comments on it.
 Changes in v2:
  - Add for_each_insn_prefix() macro and fix to check index first.
---
 arch/x86/include/asm/insn.h       |   49 ++++++++++++++++++++++++++++++++++++-
 arch/x86/kernel/uprobes.c         |   10 +++++---
 arch/x86/lib/insn.c               |    2 +-
 tools/arch/x86/include/asm/insn.h |   49 ++++++++++++++++++++++++++++++++++++-
 tools/arch/x86/lib/insn.c         |    2 +-
 5 files changed, 104 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/insn.h b/arch/x86/include/asm/insn.h
index 5c1ae3eff9d4..516d9d03027c 100644
--- a/arch/x86/include/asm/insn.h
+++ b/arch/x86/include/asm/insn.h
@@ -10,10 +10,13 @@
 /* insn_attr_t is defined in inat.h */
 #include <asm/inat.h>
 
+/* This must be sizeof(insn_value_t) / sizeof(insn_byte_t) */
+#define NUM_INSN_FIELD_BYTES	4
+
 struct insn_field {
 	union {
 		insn_value_t value;
-		insn_byte_t bytes[4];
+		insn_byte_t bytes[NUM_INSN_FIELD_BYTES];
 	};
 	/* !0 if we've run insn_get_xxx() for this field */
 	unsigned char got;
@@ -58,6 +61,32 @@ struct insn {
 };
 
 #define MAX_INSN_SIZE	15
+/*
+ * Intel SDM Vol.2 2.1.1 states,
+ * Instruction prefixes are divided into four groups, each with a set of
+ * allowable prefix codes. For each instruction, it only useful to include
+ * up to one prefix code from each of the four groups (Groups 1, 2, 3, 4).
+ *
+ * Also, AMD APM Vol.3 1.2.1 states,
+ * The legacy prefixes are organized into five groups, ... An instruction
+ * encoding may include a maximum of one prefix from each of the five groups.
+ *
+ * However, AMD APM classifies REP* and LOCK prefix in different groups,
+ * but those prefixes are supported by different instructions. Thus,
+ * there is no chance to co-exist them on the same instruction.
+ *
+ * So it can be expected that there is 4 groups of legacy prefixes in
+ * maximum on one instruction.
+ */
+#define MAX_LEGACY_PREFIX_GROUPS	4
+
+/*
+ * Make sure the number of max legacy prefix groups does not exceed the
+ * size of insn.prefixes.bytes[].
+ */
+#if MAX_LEGACY_PREFIX_GROUPS > NUM_INSN_FIELD_BYTES
+ #error "Error: Max number of prefix groups exceeds the prefix field size"
+#endif
 
 #define X86_MODRM_MOD(modrm) (((modrm) & 0xc0) >> 6)
 #define X86_MODRM_REG(modrm) (((modrm) & 0x38) >> 3)
@@ -201,6 +230,24 @@ static inline int insn_offset_immediate(struct insn *insn)
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
+ * Since prefixes.nbytes can be bigger than NUM_INSN_FIELD_BYTES when some
+ * prefixes are repeated, it can not be used for looping over the prefixes.
+ */
+#define for_each_insn_prefix(insn, idx, prefix)				\
+	for (idx = 0;							\
+	     idx < MAX_LEGACY_PREFIX_GROUPS &&				\
+	     (prefix = insn->prefixes.bytes[idx]) != 0;			\
+	     idx++)
+
 #define POP_SS_OPCODE 0x1f
 #define MOV_SREG_OPCODE 0x8e
 
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
 
diff --git a/arch/x86/lib/insn.c b/arch/x86/lib/insn.c
index 404279563891..c68c2a0c82d8 100644
--- a/arch/x86/lib/insn.c
+++ b/arch/x86/lib/insn.c
@@ -119,7 +119,7 @@ void insn_get_prefixes(struct insn *insn)
 		for (i = 0; i < nb; i++)
 			if (prefixes->bytes[i] == b)
 				goto found;
-		if (nb == 4)
+		if (nb == MAX_LEGACY_PREFIX_GROUPS)
 			/* Invalid instruction */
 			break;
 		prefixes->bytes[nb++] = b;
diff --git a/tools/arch/x86/include/asm/insn.h b/tools/arch/x86/include/asm/insn.h
index 568854b14d0a..c968c8f30915 100644
--- a/tools/arch/x86/include/asm/insn.h
+++ b/tools/arch/x86/include/asm/insn.h
@@ -10,10 +10,13 @@
 /* insn_attr_t is defined in inat.h */
 #include "inat.h"
 
+/* This must be sizeof(insn_value_t) / sizeof(insn_byte_t) */
+#define NUM_INSN_FIELD_BYTES	4
+
 struct insn_field {
 	union {
 		insn_value_t value;
-		insn_byte_t bytes[4];
+		insn_byte_t bytes[NUM_INSN_FIELD_BYTES];
 	};
 	/* !0 if we've run insn_get_xxx() for this field */
 	unsigned char got;
@@ -58,6 +61,32 @@ struct insn {
 };
 
 #define MAX_INSN_SIZE	15
+/*
+ * Intel SDM Vol.2 2.1.1 states,
+ * Instruction prefixes are divided into four groups, each with a set of
+ * allowable prefix codes. For each instruction, it only useful to include
+ * up to one prefix code from each of the four groups (Groups 1, 2, 3, 4).
+ *
+ * Also, AMD APM Vol.3 1.2.1 states,
+ * The legacy prefixes are organized into five groups, ... An instruction
+ * encoding may include a maximum of one prefix from each of the five groups.
+ *
+ * However, AMD APM classifies REP* and LOCK prefix in different groups,
+ * but those prefixes are supported by different instructions. Thus,
+ * there is no chance to co-exist them on the same instruction.
+ *
+ * So it can be expected that there is 4 groups of legacy prefixes in
+ * maximum on one instruction.
+ */
+#define MAX_LEGACY_PREFIX_GROUPS	4
+
+/*
+ * Make sure the number of max legacy prefix groups does not exceed the
+ * size of insn.prefixes.bytes[].
+ */
+#if MAX_LEGACY_PREFIX_GROUPS > NUM_INSN_FIELD_BYTES
+ #error "Error: Max number of prefix groups exceeds the prefix field size"
+#endif
 
 #define X86_MODRM_MOD(modrm) (((modrm) & 0xc0) >> 6)
 #define X86_MODRM_REG(modrm) (((modrm) & 0x38) >> 3)
@@ -201,6 +230,24 @@ static inline int insn_offset_immediate(struct insn *insn)
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
+ * Since prefixes.nbytes can be bigger than NUM_INSN_FIELD_BYTES when some
+ * prefixes are repeated, it can not be used for looping over the prefixes.
+ */
+#define for_each_insn_prefix(insn, idx, prefix)				\
+	for (idx = 0;							\
+	     idx < MAX_LEGACY_PREFIX_GROUPS &&				\
+	     (prefix = insn->prefixes.bytes[idx]) != 0;			\
+	     idx++)
+
 #define POP_SS_OPCODE 0x1f
 #define MOV_SREG_OPCODE 0x8e
 
diff --git a/tools/arch/x86/lib/insn.c b/tools/arch/x86/lib/insn.c
index 0151dfc6da61..2f2def4f2ee7 100644
--- a/tools/arch/x86/lib/insn.c
+++ b/tools/arch/x86/lib/insn.c
@@ -119,7 +119,7 @@ void insn_get_prefixes(struct insn *insn)
 		for (i = 0; i < nb; i++)
 			if (prefixes->bytes[i] == b)
 				goto found;
-		if (nb == 4)
+		if (nb == MAX_LEGACY_PREFIX_GROUPS)
 			/* Invalid instruction */
 			break;
 		prefixes->bytes[nb++] = b;

