Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD3D9282860
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Oct 2020 05:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726665AbgJDD0Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Oct 2020 23:26:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726614AbgJDD0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Oct 2020 23:26:12 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15078C0613D0
        for <linux-kernel@vger.kernel.org>; Sat,  3 Oct 2020 20:26:12 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id D673929B00C
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     luto@kernel.org, tglx@linutronix.de
Cc:     hch@lst.de, hpa@zytor.com, bp@alien8.de, rric@kernel.org,
        peterz@infradead.org, mingo@redhat.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com,
        sean.j.christopherson@intel.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v3 07/10] elf: Expose ELF header on arch_setup_additional_pages
Date:   Sat,  3 Oct 2020 23:25:33 -0400
Message-Id: <20201004032536.1229030-8-krisman@collabora.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201004032536.1229030-1-krisman@collabora.com>
References: <20201004032536.1229030-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Like it is done for SET_PERSONALITY with ARM, which requires the ELF
header to select correct personality parameters, x86 requires the
headers when selecting which vdso to load, instead of relying on the
going-away TIF_IA32/X32 flags.  This patch adds an indirection macro to
arch_setup_additional_pages, that x86 can reimplement to receive the
extra parameter just for ELF files.  This requires no changes to other
architectures, who can continue to use the original
arch_setup_additional_pages for ELF and non-ELF binaries.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 fs/binfmt_elf.c        |  2 +-
 fs/compat_binfmt_elf.c | 11 ++++++++---
 include/linux/elf.h    |  5 +++++
 3 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 7fec77a38b8d..b41ed57271da 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -1218,7 +1218,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 	set_binfmt(&elf_format);
 
 #ifdef ARCH_HAS_SETUP_ADDITIONAL_PAGES
-	retval = arch_setup_additional_pages(bprm, !!interpreter);
+	retval = ARCH_SETUP_ADDITIONAL_PAGES(bprm, elf_ex, !!interpreter);
 	if (retval < 0)
 		goto out;
 #endif /* ARCH_HAS_SETUP_ADDITIONAL_PAGES */
diff --git a/fs/compat_binfmt_elf.c b/fs/compat_binfmt_elf.c
index 12b991368f0a..2c557229696a 100644
--- a/fs/compat_binfmt_elf.c
+++ b/fs/compat_binfmt_elf.c
@@ -115,11 +115,16 @@
 #define START_THREAD		COMPAT_START_THREAD
 #endif
 
-#ifdef	compat_arch_setup_additional_pages
+#ifdef compat_arch_setup_additional_pages
+#define COMPAT_ARCH_SETUP_ADDITIONAL_PAGES(bprm, ex, interpreter) \
+	compat_arch_setup_additional_pages(bprm, interpreter)
+#endif
+
+#ifdef	COMPAT_ARCH_SETUP_ADDITIONAL_PAGES
 #undef	ARCH_HAS_SETUP_ADDITIONAL_PAGES
 #define ARCH_HAS_SETUP_ADDITIONAL_PAGES 1
-#undef	arch_setup_additional_pages
-#define	arch_setup_additional_pages compat_arch_setup_additional_pages
+#undef	ARCH_SETUP_ADDITIONAL_PAGES
+#define	ARCH_SETUP_ADDITIONAL_PAGES COMPAT_ARCH_SETUP_ADDITIONAL_PAGES
 #endif
 
 #ifdef	compat_elf_read_implies_exec
diff --git a/include/linux/elf.h b/include/linux/elf.h
index 6dbcfe7a3fd7..c9a46c4e183b 100644
--- a/include/linux/elf.h
+++ b/include/linux/elf.h
@@ -27,6 +27,11 @@
 	start_thread(regs, elf_entry, start_stack)
 #endif
 
+#if defined(ARCH_HAS_SETUP_ADDITIONAL_PAGES) && !defined(ARCH_SETUP_ADDITIONAL_PAGES)
+#define ARCH_SETUP_ADDITIONAL_PAGES(bprm, ex, interpreter) \
+	arch_setup_additional_pages(bprm, interpreter)
+#endif
+
 #define ELF32_GNU_PROPERTY_ALIGN	4
 #define ELF64_GNU_PROPERTY_ALIGN	8
 
-- 
2.28.0

