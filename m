Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D900E27F5F7
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 01:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732289AbgI3X0h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 19:26:37 -0400
Received: from mga04.intel.com ([192.55.52.120]:25942 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732256AbgI3X0Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 19:26:24 -0400
IronPort-SDR: 9ZRE2x5keZUMEJ1sS6sQuZbjhOm3e+n9q52qD529POx1HYreoVtr8FiRw58HjN+dg9KrZH7h92
 vkEix2oc6JjQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9760"; a="159975250"
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="159975250"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2020 16:26:18 -0700
IronPort-SDR: q3FdxtGUWQlF65cRrG9Dc0OLxNUwcWnfHLN69OATYG8jvXooyT3SuzTn4Y2iqfTG781h+UJ86v
 PuWXkc8/R50A==
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="457857968"
Received: from agluck-desk2.sc.intel.com ([10.3.52.68])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2020 16:26:18 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Youquan Song <youquan.song@intel.com>,
        Tony Luck <tony.luck@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/7] x86/mce: Pass pointer to saved pt_regs to severity calculation routines
Date:   Wed, 30 Sep 2020 16:26:05 -0700
Message-Id: <20200930232611.15355-2-tony.luck@intel.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200930232611.15355-1-tony.luck@intel.com>
References: <20200921113144.GD5901@zn.tnic>
 <20200930232611.15355-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Youquan Song <youquan.song@intel.com>

New recovery features require additional information about processor
state when a machine check occurred. Pass pt_regs down to the routines
that need it.

No functional change.

Signed-off-by: Youquan Song <youquan.song@intel.com>
Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/mce/core.c     | 14 +++++++-------
 arch/x86/kernel/cpu/mce/internal.h |  3 ++-
 arch/x86/kernel/cpu/mce/severity.c | 14 ++++++++------
 3 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 5b1d5f33d60b..a2bb4d4df8b7 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -793,7 +793,7 @@ bool machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
 			goto clear_it;
 
 		mce_read_aux(&m, i);
-		m.severity = mce_severity(&m, mca_cfg.tolerant, NULL, false);
+		m.severity = mce_severity(&m, NULL, mca_cfg.tolerant, NULL, false);
 		/*
 		 * Don't get the IP here because it's unlikely to
 		 * have anything to do with the actual error location.
@@ -842,7 +842,7 @@ static int mce_no_way_out(struct mce *m, char **msg, unsigned long *validp,
 			quirk_no_way_out(i, m, regs);
 
 		m->bank = i;
-		if (mce_severity(m, mca_cfg.tolerant, &tmp, true) >= MCE_PANIC_SEVERITY) {
+		if (mce_severity(m, regs, mca_cfg.tolerant, &tmp, true) >= MCE_PANIC_SEVERITY) {
 			mce_read_aux(m, i);
 			*msg = tmp;
 			return 1;
@@ -942,7 +942,7 @@ static void mce_reign(void)
 	 */
 	if (m && global_worst >= MCE_PANIC_SEVERITY && mca_cfg.tolerant < 3) {
 		/* call mce_severity() to get "msg" for panic */
-		mce_severity(m, mca_cfg.tolerant, &msg, true);
+		mce_severity(m, NULL, mca_cfg.tolerant, &msg, true);
 		mce_panic("Fatal machine check", m, msg);
 	}
 
@@ -1153,7 +1153,7 @@ static noinstr bool mce_check_crashing_cpu(void)
 	return false;
 }
 
-static void __mc_scan_banks(struct mce *m, struct mce *final,
+static void __mc_scan_banks(struct mce *m, struct pt_regs *regs, struct mce *final,
 			    unsigned long *toclear, unsigned long *valid_banks,
 			    int no_way_out, int *worst)
 {
@@ -1188,7 +1188,7 @@ static void __mc_scan_banks(struct mce *m, struct mce *final,
 		/* Set taint even when machine check was not enabled. */
 		add_taint(TAINT_MACHINE_CHECK, LOCKDEP_NOW_UNRELIABLE);
 
-		severity = mce_severity(m, cfg->tolerant, NULL, true);
+		severity = mce_severity(m, regs, cfg->tolerant, NULL, true);
 
 		/*
 		 * When machine check was for corrected/deferred handler don't
@@ -1340,7 +1340,7 @@ noinstr void do_machine_check(struct pt_regs *regs)
 		order = mce_start(&no_way_out);
 	}
 
-	__mc_scan_banks(&m, final, toclear, valid_banks, no_way_out, &worst);
+	__mc_scan_banks(&m, regs, final, toclear, valid_banks, no_way_out, &worst);
 
 	if (!no_way_out)
 		mce_clear_state(toclear);
@@ -1362,7 +1362,7 @@ noinstr void do_machine_check(struct pt_regs *regs)
 		 * make sure we have the right "msg".
 		 */
 		if (worst >= MCE_PANIC_SEVERITY && mca_cfg.tolerant < 3) {
-			mce_severity(&m, cfg->tolerant, &msg, true);
+			mce_severity(&m, regs, cfg->tolerant, &msg, true);
 			mce_panic("Local fatal machine check!", &m, msg);
 		}
 	}
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
index b122610e9046..88dcc79cfb07 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -38,7 +38,8 @@ int mce_gen_pool_add(struct mce *mce);
 int mce_gen_pool_init(void);
 struct llist_node *mce_gen_pool_prepare_records(void);
 
-extern int (*mce_severity)(struct mce *a, int tolerant, char **msg, bool is_excp);
+extern int (*mce_severity)(struct mce *a, struct pt_regs *regs,
+			   int tolerant, char **msg, bool is_excp);
 struct dentry *mce_get_debugfs_dir(void);
 
 extern mce_banks_t mce_banks_ce_disabled;
diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index e1da619add19..1983ef93aa25 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -209,7 +209,7 @@ static struct severity {
  * distinguish an exception taken in user from from one
  * taken in the kernel.
  */
-static int error_context(struct mce *m)
+static int error_context(struct mce *m, struct pt_regs *regs)
 {
 	if ((m->cs & 3) == 3)
 		return IN_USER;
@@ -253,9 +253,10 @@ static int mce_severity_amd_smca(struct mce *m, enum context err_ctx)
  * See AMD Error Scope Hierarchy table in a newer BKDG. For example
  * 49125_15h_Models_30h-3Fh_BKDG.pdf, section "RAS Features"
  */
-static int mce_severity_amd(struct mce *m, int tolerant, char **msg, bool is_excp)
+static int mce_severity_amd(struct mce *m, struct pt_regs *regs, int tolerant,
+			    char **msg, bool is_excp)
 {
-	enum context ctx = error_context(m);
+	enum context ctx = error_context(m, regs);
 
 	/* Processor Context Corrupt, no need to fumble too much, die! */
 	if (m->status & MCI_STATUS_PCC)
@@ -305,10 +306,11 @@ static int mce_severity_amd(struct mce *m, int tolerant, char **msg, bool is_exc
 	return MCE_KEEP_SEVERITY;
 }
 
-static int mce_severity_intel(struct mce *m, int tolerant, char **msg, bool is_excp)
+static int mce_severity_intel(struct mce *m, struct pt_regs *regs,
+			      int tolerant, char **msg, bool is_excp)
 {
 	enum exception excp = (is_excp ? EXCP_CONTEXT : NO_EXCP);
-	enum context ctx = error_context(m);
+	enum context ctx = error_context(m, regs);
 	struct severity *s;
 
 	for (s = severities;; s++) {
@@ -336,7 +338,7 @@ static int mce_severity_intel(struct mce *m, int tolerant, char **msg, bool is_e
 }
 
 /* Default to mce_severity_intel */
-int (*mce_severity)(struct mce *m, int tolerant, char **msg, bool is_excp) =
+int (*mce_severity)(struct mce *m, struct pt_regs *regs, int tolerant, char **msg, bool is_excp) =
 		    mce_severity_intel;
 
 void __init mcheck_vendor_init_severity(void)
-- 
2.21.1

