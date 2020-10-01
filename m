Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BED662808EA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 23:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733010AbgJAU7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 16:59:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbgJAU7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 16:59:32 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 404D3C0613D0
        for <linux-kernel@vger.kernel.org>; Thu,  1 Oct 2020 13:59:32 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id F18F829D106
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     luto@kernel.org, tglx@linutronix.de
Cc:     hch@lst.de, hpa@zytor.com, bp@alien8.de, rric@kernel.org,
        peterz@infradead.org, mingo@redhat.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v2 2/9] x86: Simplify compat syscall userspace allocation
Date:   Thu,  1 Oct 2020 16:58:12 -0400
Message-Id: <20201001205819.27879-3-krisman@collabora.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201001205819.27879-1-krisman@collabora.com>
References: <20201001205819.27879-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When allocating user memory space for a compat system call, don't
consider whether the originating code is IA32 or X32, just allocate from
a safe region for both, beyond the redzone.  This should be safe for
IA32, and has the benefit of avoiding TIF_IA32, which we want to drop.

Suggested-by: Andy Lutomirski <luto@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 arch/x86/include/asm/compat.h | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/compat.h b/arch/x86/include/asm/compat.h
index d4edf281fff4..a4b5126dff4e 100644
--- a/arch/x86/include/asm/compat.h
+++ b/arch/x86/include/asm/compat.h
@@ -179,14 +179,13 @@ typedef struct user_regs_struct compat_elf_gregset_t;
 
 static inline void __user *arch_compat_alloc_user_space(long len)
 {
-	compat_uptr_t sp;
-
-	if (test_thread_flag(TIF_IA32)) {
-		sp = task_pt_regs(current)->sp;
-	} else {
-		/* -128 for the x32 ABI redzone */
-		sp = task_pt_regs(current)->sp - 128;
-	}
+	compat_uptr_t sp = task_pt_regs(current)->sp;
+
+	/*
+	 * -128 for the x32 ABI redzone.  For IA32, it is not strictly
+	 * necessary, but not harmful.
+	 */
+	sp -= 128;
 
 	return (void __user *)round_down(sp - len, 16);
 }
-- 
2.28.0

