Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC28B288BB7
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Oct 2020 16:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388962AbgJIOmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Oct 2020 10:42:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:46028 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387662AbgJIOmb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Oct 2020 10:42:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1602254550;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Mf9G95BFIif8P4JOo8vFEGHaFCuDzB5d2ITiJa6fvhQ=;
        b=hWIW3UxjjlHedkBjscX2/oMZBiqp8cMgbM5bV0NCuQYPfsNOtHucN61nhTHeTWM/sa/i8N
        bFbDMkKpRE+iGrAeCuYdUClZo3vcbJlPsqnB+JDYS54Jzgb0ekl4iudUBLU/kUI503bLol
        WkWWXUua7KDrPPiTrIomxXNLksFUXZo=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id E8F0CAE2C;
        Fri,  9 Oct 2020 14:42:29 +0000 (UTC)
From:   Juergen Gross <jgross@suse.com>
To:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Juergen Gross <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>
Subject: [PATCH] x86/alternative: don't call text_poke() in lazy TLB mode
Date:   Fri,  9 Oct 2020 16:42:25 +0200
Message-Id: <20201009144225.12019-1-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When running in lazy TLB mode the currently active page tables might
be the ones of a previous process, e.g. when running a kernel thread.

This can be problematic in case kernel code is being modified via
text_poke() in a kernel thread, and on another processor exit_mmap()
is active for the process which was running on the first cpu before
the kernel thread.

As text_poke() is using a temporary address space and the former
address space (obtained via cpu_tlbstate.loaded_mm) is restored
afterwards, there is a race possible in case the cpu on which
exit_mmap() is running wants to make sure there are no stale
references to that address space on any cpu active (this e.g. is
required when running as a Xen PV guest, where this problem has been
observed and analyzed).

In order to avoid that, drop off TLB lazy mode before switching to the
temporary address space.

Fixes: cefa929c034eb5d ("x86/mm: Introduce temporary mm structs")
Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/kernel/alternative.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index cdaab30880b9..cd6be6f143e8 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -807,6 +807,15 @@ static inline temp_mm_state_t use_temporary_mm(struct mm_struct *mm)
 	temp_mm_state_t temp_state;
 
 	lockdep_assert_irqs_disabled();
+
+	/*
+	 * Make sure not to be in TLB lazy mode, as otherwise we'll end up
+	 * with a stale address space WITHOUT being in lazy mode after
+	 * restoring the previous mm.
+	 */
+	if (this_cpu_read(cpu_tlbstate.is_lazy))
+		leave_mm(smp_processor_id());
+
 	temp_state.mm = this_cpu_read(cpu_tlbstate.loaded_mm);
 	switch_mm_irqs_off(NULL, mm, current);
 
-- 
2.26.2

