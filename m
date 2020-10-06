Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75C2B2853A6
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 23:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbgJFVJT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 17:09:19 -0400
Received: from mga11.intel.com ([192.55.52.93]:44603 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727166AbgJFVJT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 17:09:19 -0400
IronPort-SDR: KkO63g9ZSzXAW1KgotzoNR5FhfSpgkb68FqI2MW/HllTNpLp/Mw4bOWZg1oJJGdCvQa81ZSwVr
 eto8cF7dgzZg==
X-IronPort-AV: E=McAfee;i="6000,8403,9766"; a="161302106"
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; 
   d="scan'208";a="161302106"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 14:09:18 -0700
IronPort-SDR: LtW0IjYAXWpOS74KJSkfheBX4pTwzAy0SBiy/edfYu2M5XfhonlxIcI00QzdiWvR3wk2qBgLuO
 ZJmKKQhrFGbA==
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; 
   d="scan'208";a="527590590"
Received: from agluck-desk2.sc.intel.com ([10.3.52.68])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 14:09:18 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>,
        Youquan Song <youquan.song@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/6] x86/mce: Provide method to find out the type of exception handle
Date:   Tue,  6 Oct 2020 14:09:06 -0700
Message-Id: <20201006210910.21062-3-tony.luck@intel.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20201006210910.21062-1-tony.luck@intel.com>
References: <20201005163130.GD21151@zn.tnic>
 <20201006210910.21062-1-tony.luck@intel.com>
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
index d8c2198d543b..1f0cbc52937c 100644
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
+extern enum handler_type ex_get_fault_handler_type(unsigned long ip);
 extern void early_fixup_exception(struct pt_regs *regs, int trapnr);
 
 #endif
diff --git a/arch/x86/kernel/cpu/mce/severity.c b/arch/x86/kernel/cpu/mce/severity.c
index 0b072dc231ad..c6494e6579c1 100644
--- a/arch/x86/kernel/cpu/mce/severity.c
+++ b/arch/x86/kernel/cpu/mce/severity.c
@@ -225,10 +225,13 @@ static struct severity {
  */
 static int error_context(struct mce *m, struct pt_regs *regs)
 {
+	enum handler_type t;
+
 	if ((m->cs & 3) == 3)
 		return IN_USER;
 
-	if (mc_recoverable(m->mcgstatus) && ex_has_fault_handler(m->ip)) {
+	t = ex_get_fault_handler_type(m->ip);
+	if (mc_recoverable(m->mcgstatus) && t == EX_HANDLER_FAULT) {
 		m->kflags |= MCE_IN_KERNEL_RECOV;
 		return IN_KERNEL_RECOV;
 	}
diff --git a/arch/x86/mm/extable.c b/arch/x86/mm/extable.c
index 1d6cb07f4f86..de43525df69b 100644
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -125,17 +125,21 @@ __visible bool ex_handler_clear_fs(const struct exception_table_entry *fixup,
 }
 EXPORT_SYMBOL(ex_handler_clear_fs);
 
-__visible bool ex_has_fault_handler(unsigned long ip)
+enum handler_type ex_get_fault_handler_type(unsigned long ip)
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

