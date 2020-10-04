Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6838E28285E
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Oct 2020 05:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726615AbgJDD0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 23:26:06 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:35082 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbgJDD0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 23:26:04 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 602EC29B004
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     luto@kernel.org, tglx@linutronix.de
Cc:     hch@lst.de, hpa@zytor.com, bp@alien8.de, rric@kernel.org,
        peterz@infradead.org, mingo@redhat.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com,
        sean.j.christopherson@intel.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v3 05/10] elf: Expose ELF header in compat_start_thread
Date:   Sat,  3 Oct 2020 23:25:31 -0400
Message-Id: <20201004032536.1229030-6-krisman@collabora.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201004032536.1229030-1-krisman@collabora.com>
References: <20201004032536.1229030-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like it is done for SET_PERSONALITY with x86, which requires the ELF
header to select correct personality parameters, x86 requires the
headers on compat_start_thread to choose starting CS for ELF32 binaries,
instead of relying on the going-away TIF_IA32/X32 flags.

This patch adds an indirection macro to ELF invocations of START_THREAD,
that x86 can reimplement to receive the extra parameter just for ELF
files.  This requires no changes to other architectures who don't need
the header information, they can continue to use the original
start_thread for ELF and non-ELF binaries, and it prevents affecting
non-ELF code paths for x86.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 fs/binfmt_elf.c        | 2 +-
 fs/compat_binfmt_elf.c | 9 +++++++--
 include/linux/elf.h    | 5 +++++
 3 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 13d053982dd7..7fec77a38b8d 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1279,7 +1279,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 #endif
 
 	finalize_exec(bprm);
-	start_thread(regs, elf_entry, bprm->p);
+	START_THREAD(elf_ex, regs, elf_entry, bprm->p);
 	retval = 0;
 out:
 	return retval;
diff --git a/fs/compat_binfmt_elf.c b/fs/compat_binfmt_elf.c
index 2d24c765cbd7..12b991368f0a 100644
--- a/fs/compat_binfmt_elf.c
+++ b/fs/compat_binfmt_elf.c
@@ -106,8 +106,13 @@
 #endif
 
 #ifdef	compat_start_thread
-#undef	start_thread
-#define	start_thread		compat_start_thread
+#define COMPAT_START_THREAD(ex, regs, new_ip, new_sp)	\
+	compat_start_thread(regs, new_ip, new_sp)
+#endif
+
+#ifdef	COMPAT_START_THREAD
+#undef	START_THREAD
+#define START_THREAD		COMPAT_START_THREAD
 #endif
 
 #ifdef	compat_arch_setup_additional_pages
diff --git a/include/linux/elf.h b/include/linux/elf.h
index 5d5b0321da0b..6dbcfe7a3fd7 100644
--- a/include/linux/elf.h
+++ b/include/linux/elf.h
@@ -22,6 +22,11 @@
 	SET_PERSONALITY(ex)
 #endif
 
+#ifndef START_THREAD
+#define START_THREAD(elf_ex, regs, elf_entry, start_stack)	\
+	start_thread(regs, elf_entry, start_stack)
+#endif
+
 #define ELF32_GNU_PROPERTY_ALIGN	4
 #define ELF64_GNU_PROPERTY_ALIGN	8
 
-- 
2.28.0

