Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F15AE2853A4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 23:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727454AbgJFVJW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 17:09:22 -0400
Received: from mga11.intel.com ([192.55.52.93]:44609 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727435AbgJFVJU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 17:09:20 -0400
IronPort-SDR: eC/Uswa6QABvi9xrmLCVZIBPT71I4C8R3kNDrw9IsIkOfNWmEIz2rbALQuI1A3L3dZ+dA1kbJ9
 fGIJl6wucjNg==
X-IronPort-AV: E=McAfee;i="6000,8403,9766"; a="161302109"
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; 
   d="scan'208";a="161302109"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 14:09:19 -0700
IronPort-SDR: Y8+OwdmrJK46BEplzKwsgvcLC/6V9CkNpF1p58aJoFNgP6RKpxSItd5wUA+1TEzu7KuQPgIjbd
 S1ApDfJ8d1dQ==
X-IronPort-AV: E=Sophos;i="5.77,343,1596524400"; 
   d="scan'208";a="527590599"
Received: from agluck-desk2.sc.intel.com ([10.3.52.68])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2020 14:09:18 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Tony Luck <tony.luck@intel.com>,
        Youquan Song <youquan.song@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/6] x86/mce: Avoid tail copy when machine check terminated a copy from user
Date:   Tue,  6 Oct 2020 14:09:08 -0700
Message-Id: <20201006210910.21062-5-tony.luck@intel.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20201006210910.21062-1-tony.luck@intel.com>
References: <20201005163130.GD21151@zn.tnic>
 <20201006210910.21062-1-tony.luck@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the page fault case it is ok to see if a few more unaligned bytes
can be copied from the source address. Worst case is that the page fault
will be triggered again.

Machine checks are more serious. Just give up at the point where the
main copy loop triggered the #MC and return from the copy code as if
the copy succeeded. The machine check handler will use task_work_add() to
make sure that the task is sent a SIGBUS.

Signed-off-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/lib/copy_user_64.S | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/x86/lib/copy_user_64.S b/arch/x86/lib/copy_user_64.S
index 5b68e945bf65..77b9b2a3b5c8 100644
--- a/arch/x86/lib/copy_user_64.S
+++ b/arch/x86/lib/copy_user_64.S
@@ -15,6 +15,7 @@
 #include <asm/asm.h>
 #include <asm/smap.h>
 #include <asm/export.h>
+#include <asm/trapnr.h>
 
 .macro ALIGN_DESTINATION
 	/* check for bad alignment of destination */
@@ -221,6 +222,7 @@ EXPORT_SYMBOL(copy_user_enhanced_fast_string)
  * Try to copy last bytes and clear the rest if needed.
  * Since protection fault in copy_from/to_user is not a normal situation,
  * it is not necessary to optimize tail handling.
+ * Don't try to copy the tail if machine check happened
  *
  * Input:
  * rdi destination
@@ -232,11 +234,24 @@ EXPORT_SYMBOL(copy_user_enhanced_fast_string)
  */
 SYM_CODE_START_LOCAL(.Lcopy_user_handle_tail)
 	movl %edx,%ecx
+	cmp $X86_TRAP_MC,%eax		/* check if X86_TRAP_MC */
+	je 3f
 1:	rep movsb
 2:	mov %ecx,%eax
 	ASM_CLAC
 	ret
 
+	/*
+	 * Return zero to pretend that this copy succeeded. This
+	 * is counter-intuitive, but needed to prevent the code
+	 * in lib/iov_iter.c from retrying and running back into
+	 * the poison cache line again. The machine check handler
+	 * will ensure that a SIGBUS is sent to the task.
+	 */
+3:	xorl %eax,%eax
+	ASM_CLAC
+	ret
+
 	_ASM_EXTABLE_CPY(1b, 2b)
 SYM_CODE_END(.Lcopy_user_handle_tail)
 
-- 
2.21.1

