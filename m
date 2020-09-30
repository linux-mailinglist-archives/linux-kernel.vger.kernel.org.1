Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F03A227F5F9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 01:27:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732223AbgI3X0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Sep 2020 19:26:20 -0400
Received: from mga04.intel.com ([192.55.52.120]:25937 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730415AbgI3X0U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Sep 2020 19:26:20 -0400
IronPort-SDR: u/2nSx/efRj5i0SgdfgnQe9PzxX0Pup+bAcKkOscaigL02bcxgG5Z7zrEE0htt3j6NsrwS+D2x
 FMwWSfIJcXTQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9760"; a="159975251"
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="159975251"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2020 16:26:18 -0700
IronPort-SDR: T/o6s8ghwWD6VmkuBDl2904tb1Ei8ntdniFeu+43tN3tw+DtJi1yqZ68tWSQF+QZ3lmxjoIPTF
 GYLya2oCRUOw==
X-IronPort-AV: E=Sophos;i="5.77,322,1596524400"; 
   d="scan'208";a="457857971"
Received: from agluck-desk2.sc.intel.com ([10.3.52.68])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Sep 2020 16:26:18 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>,
        Youquan Song <youquan.song@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/7] x86/mce: Provide method to find out the type of exception handle
Date:   Wed, 30 Sep 2020 16:26:06 -0700
Message-Id: <20200930232611.15355-3-tony.luck@intel.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200930232611.15355-1-tony.luck@intel.com>
References: <20200921113144.GD5901@zn.tnic>
 <20200930232611.15355-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Avoid a proliferation of ex_has_*_handler() functions by having just
one function that returns the type of the handler (if any).

Drop the __visible attribute for this function. It is not called
from assembler so the attribute is not necessary.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/include/asm/extable.h     |  9 ++++++++-
 arch/x86/kernel/cpu/mce/severity.c |  5 ++++-
 arch/x86/mm/extable.c              | 12 ++++++++----
 3 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/extable.h b/arch/x86/include/asm/extable.h
index d8c2198d543b..8847988c4a6d 100644
--- a/arch/x86/include/asm/extable.h
+++ b/arch/x86/include/asm/extable.h
@@ -29,10 +29,17 @@ struct pt_regs;
 		(b)->handler = (tmp).handler - (delta);		\
 	} while (0)
 
+enum handler_type {
+	EX_HANDLER_NONE,
+	EX_HANDLER_FAULT,
+	EX_HANDLER_UACCESS,
+	EX_HANDLER_OTHER
+};
+
 extern int fixup_exception(struct pt_regs *regs, int trapnr,
 			   unsigned long error_code, unsigned long fault_addr);
 extern int fixup_bug(struct pt_regs *regs, int trapnr);
-extern bool ex_has_fault_handler(unsigned long ip);
+extern enum handler_type ex_fault_handler_type(unsigned long ip);
 extern void early_fixup_exception(struct pt_regs *regs, int trapnr);
 
 #endif
diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index 1983ef93aa25..8517cbf7b184 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -211,10 +211,13 @@ static struct severity {
  */
 static int error_context(struct mce *m, struct pt_regs *regs)
 {
+	enum handler_type t;
+
 	if ((m->cs & 3) == 3)
 		return IN_USER;
 
-	if (mc_recoverable(m->mcgstatus) && ex_has_fault_handler(m->ip)) {
+	t = ex_fault_handler_type(m->ip);
+	if (mc_recoverable(m->mcgstatus) && t == EX_HANDLER_FAULT) {
 		m->kflags |= MCE_IN_KERNEL_RECOV;
 		return IN_KERNEL_RECOV;
 	}
diff --git a/arch/x86/mm/extable.c b/arch/x86/mm/extable.c
index 1d6cb07f4f86..de869665309e 100644
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -125,17 +125,21 @@ __visible bool ex_handler_clear_fs(const struct exception_table_entry *fixup,
 }
 EXPORT_SYMBOL(ex_handler_clear_fs);
 
-__visible bool ex_has_fault_handler(unsigned long ip)
+enum handler_type ex_fault_handler_type(unsigned long ip)
 {
 	const struct exception_table_entry *e;
 	ex_handler_t handler;
 
 	e = search_exception_tables(ip);
 	if (!e)
-		return false;
+		return EX_HANDLER_NONE;
 	handler = ex_fixup_handler(e);
-
-	return handler == ex_handler_fault;
+	if (handler == ex_handler_fault)
+		return EX_HANDLER_FAULT;
+	else if (handler == ex_handler_uaccess)
+		return EX_HANDLER_UACCESS;
+	else
+		return EX_HANDLER_OTHER;
 }
 
 int fixup_exception(struct pt_regs *regs, int trapnr, unsigned long error_code,
-- 
2.21.1

