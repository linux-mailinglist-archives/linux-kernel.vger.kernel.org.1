Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 346D62D99F1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Dec 2020 15:29:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727777AbgLNO1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Dec 2020 09:27:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2408237AbgLNO1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Dec 2020 09:27:17 -0500
X-Greylist: delayed 463 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 14 Dec 2020 06:26:36 PST
Received: from mx-rz-2.rrze.uni-erlangen.de (mx-rz-2.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7538EC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 14 Dec 2020 06:26:36 -0800 (PST)
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-2.rrze.uni-erlangen.de (Postfix) with ESMTPS id 4Cvk5m05g9zPkgs;
        Mon, 14 Dec 2020 15:18:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2013;
        t=1607955532; bh=vLO5fXeRxKsAS5KJjQ3cfc+9RBxQWtygoZ46KEfGDC0=;
        h=From:To:Cc:Subject:Date:From:To:CC:Subject;
        b=USLKXoH1RyaMC/6Xtw5z7ObGPrka/K6d80pRsVyY5/z3R4XhIsxwwgmClgkbq9g0d
         rmgcYBX6HBBkjf6vJxzi0i/QQrCavGAODMS+8SY8zETmvus/Ig6Jhl5S69Vy9Y4bSM
         Lpsv6thnwqimVFeSpD1VbMM+mB3VZxM524SJU4Caachpl0BZQrFAcCJvUXnMYR2n1f
         ZEW8/ctw39Au45msuRVO+y4JL217g8MzI6z+uGzjli/5RQpnx0jws7WR5xRWm4r/mt
         iKkpYQcNajN39FgWHWYxZTW96C77MGmttjPlJcLGQrBT7yTBibKrZ7kGlKSaMZbz8I
         0aDpiPlfkTpiQ==
X-Virus-Scanned: amavisd-new at boeck1.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 2001:638:a000:4130:131:188:30:84
Received: from cip1e4.informatik.uni-erlangen.de (cip1e4.cip.cs.fau.de [IPv6:2001:638:a000:4130:131:188:30:84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX1/0nW3u0adL3Xc+/bNl9f6AmCPKBELKVrs=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 4Cvk5h3MjtzPlS7;
        Mon, 14 Dec 2020 15:18:48 +0100 (CET)
From:   Stefan Saecherl <stefan.saecherl@fau.de>
To:     x86@kernel.org
Cc:     linux-kernel@i4.cs.fau.de,
        Stefan Saecherl <stefan.saecherl@fau.de>,
        Lorena Kretzschmar <qy15sije@cip.cs.fau.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        Ira Weiny <ira.weiny@intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] x86/kgdb: Allow removal of early BPs
Date:   Mon, 14 Dec 2020 15:13:12 +0100
Message-Id: <20201214141314.5717-1-stefan.saecherl@fau.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The problem is that breakpoints that are set early (e.g. via kgdbwait)
cannot be deleted after boot completed (to be precise after mark_rodata_ro
ran).

When setting a breakpoint early there are executable pages that are
writable so the copy_to_kernel_nofault call in kgdb_arch_set_breakpoint
succeeds and the breakpoint is saved as type BP_BREAKPOINT.

Later in the boot write access to these pages is restricted. So when
removing the breakpoint the copy_to_kernel_nofault call in
kgdb_arch_remove_breakpoint is destined to fail and the breakpoint removal
fails. So after copy_to_kernel_nofault failed try to text_poke_kgdb which
can work around nonwriteability.

One thing to consider when doing this is that code can go away during boot
(e.g. .init.text). Previously kgdb_arch_remove_breakpoint handled this case
gracefully by just having copy_to_kernel_nofault fail but if one then calls
text_poke_kgdb the system dies due to the BUG_ON we moved out of
__text_poke.  To avoid this __text_poke now returns an error in case of a
nonpresent code page and the error is handled at call site.

Checkpatch complains about two uses of BUG_ON but the new code should not
trigger BUG_ON in cases where the old didn't.

Co-developed-by: Lorena Kretzschmar <qy15sije@cip.cs.fau.de>
Signed-off-by: Lorena Kretzschmar <qy15sije@cip.cs.fau.de>
Signed-off-by: Stefan Saecherl <stefan.saecherl@fau.de>
---
 arch/x86/kernel/alternative.c | 16 +++++++----
 arch/x86/kernel/kgdb.c        | 54 ++++++++++++++++++++++++-----------
 2 files changed, 48 insertions(+), 22 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index 2400ad62f330..0f145d837885 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -878,11 +878,9 @@ static void *__text_poke(void *addr, const void *opcode, size_t len)
 		if (cross_page_boundary)
 			pages[1] = virt_to_page(addr + PAGE_SIZE);
 	}
-	/*
-	 * If something went wrong, crash and burn since recovery paths are not
-	 * implemented.
-	 */
-	BUG_ON(!pages[0] || (cross_page_boundary && !pages[1]));
+
+	if (!pages[0] || (cross_page_boundary && !pages[1]))
+		return ERR_PTR(-EFAULT);
 
 	/*
 	 * Map the page without the global bit, as TLB flushing is done with
@@ -976,7 +974,13 @@ void *text_poke(void *addr, const void *opcode, size_t len)
 {
 	lockdep_assert_held(&text_mutex);
 
-	return __text_poke(addr, opcode, len);
+	addr = __text_poke(addr, opcode, len);
+	/*
+	 * If something went wrong, crash and burn since recovery paths are not
+	 * implemented.
+	 */
+	BUG_ON(IS_ERR(addr));
+	return addr;
 }
 
 /**
diff --git a/arch/x86/kernel/kgdb.c b/arch/x86/kernel/kgdb.c
index ff7878df96b4..e98c9c43db7c 100644
--- a/arch/x86/kernel/kgdb.c
+++ b/arch/x86/kernel/kgdb.c
@@ -731,6 +731,7 @@ void kgdb_arch_set_pc(struct pt_regs *regs, unsigned long ip)
 int kgdb_arch_set_breakpoint(struct kgdb_bkpt *bpt)
 {
 	int err;
+	void *addr;
 
 	bpt->type = BP_BREAKPOINT;
 	err = copy_from_kernel_nofault(bpt->saved_instr, (char *)bpt->bpt_addr,
@@ -747,8 +748,14 @@ int kgdb_arch_set_breakpoint(struct kgdb_bkpt *bpt)
 	 */
 	if (mutex_is_locked(&text_mutex))
 		return -EBUSY;
-	text_poke_kgdb((void *)bpt->bpt_addr, arch_kgdb_ops.gdb_bpt_instr,
-		       BREAK_INSTR_SIZE);
+
+	addr = text_poke_kgdb((void *)bpt->bpt_addr, arch_kgdb_ops.gdb_bpt_instr,
+				BREAK_INSTR_SIZE);
+	/* This should never trigger because the above call to copy_from_kernel_nofault
+	 * already succeeded.
+	 */
+	BUG_ON(IS_ERR(addr));
+
 	bpt->type = BP_POKE_BREAKPOINT;
 
 	return 0;
@@ -756,21 +763,36 @@ int kgdb_arch_set_breakpoint(struct kgdb_bkpt *bpt)
 
 int kgdb_arch_remove_breakpoint(struct kgdb_bkpt *bpt)
 {
-	if (bpt->type != BP_POKE_BREAKPOINT)
-		goto knl_write;
-	/*
-	 * It is safe to call text_poke_kgdb() because normal kernel execution
-	 * is stopped on all cores, so long as the text_mutex is not locked.
-	 */
-	if (mutex_is_locked(&text_mutex))
-		goto knl_write;
-	text_poke_kgdb((void *)bpt->bpt_addr, bpt->saved_instr,
-		       BREAK_INSTR_SIZE);
-	return 0;
+	void *addr;
+	int err;
 
-knl_write:
-	return copy_to_kernel_nofault((char *)bpt->bpt_addr,
-				  (char *)bpt->saved_instr, BREAK_INSTR_SIZE);
+	if (bpt->type == BP_POKE_BREAKPOINT) {
+		if (mutex_is_locked(&text_mutex)) {
+			err = copy_to_kernel_nofault((char *)bpt->bpt_addr,
+							(char *)bpt->saved_instr,
+							BREAK_INSTR_SIZE);
+		} else {
+			/*
+			 * It is safe to call text_poke_kgdb() because normal kernel execution
+			 * is stopped on all cores, so long as the text_mutex is not locked.
+			 */
+			addr = text_poke_kgdb((void *)bpt->bpt_addr,
+							bpt->saved_instr,
+							BREAK_INSTR_SIZE);
+			err = PTR_ERR_OR_ZERO(addr);
+		}
+	} else {
+		err = copy_to_kernel_nofault((char *)bpt->bpt_addr,
+						(char *)bpt->saved_instr,
+						BREAK_INSTR_SIZE);
+		if (err == -EFAULT && !mutex_is_locked(&text_mutex)) {
+			addr = text_poke_kgdb((void *)bpt->bpt_addr,
+						bpt->saved_instr,
+						BREAK_INSTR_SIZE);
+			err = PTR_ERR_OR_ZERO(addr);
+		}
+	}
+	return err;
 }
 
 const struct kgdb_arch arch_kgdb_ops = {
-- 
2.20.1

