Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 503DB2C9123
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 23:33:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730687AbgK3Wbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 17:31:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728255AbgK3Wbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 17:31:52 -0500
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 976FCC0613CF
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 14:31:06 -0800 (PST)
Received: by mail-qk1-x743.google.com with SMTP id h20so12554483qkk.4
        for <linux-kernel@vger.kernel.org>; Mon, 30 Nov 2020 14:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hAr6JwF6AekV3yhx2WDmthNLSoew16r1A09CfZoaUHI=;
        b=Pq+D6S0O+5mXy5MgzWCX9a0Ttm3FqSpFEG6IABqGgN12k1KYBq/QkcaliX3juqreMn
         yjZB99YdUtbILI8nzntGluOTOyHKNuqXTClOuErCKERBzmR15tdsgLPEF7IdLohJ+XhT
         Gvr4/LNGu91Pegu5UaLSMnYqBrs+0kYVRfelVlRuuHPFRGfESYVUChIz23H5GBOWTlo3
         xpqm+pZbEkGyACgqg8Hybuk3SV7q+E2zs3C2gG0es9f25/RfUSCOY6eke0bOPrWOI9Bk
         EZtQWOvG8p8SCCoBMjbtswoLZgPAL+1miTvi3ZgivXuRe5/rai7J6kAIrSfyFjxj0Bjj
         c/8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hAr6JwF6AekV3yhx2WDmthNLSoew16r1A09CfZoaUHI=;
        b=KCBELR7oCqFM4CHV+ZKoL++Y6+oS7n32t1adjwBQw/ltO8y7qgxWeHIobgH6UKLoo0
         LnznMjeJXE1LpRrquOcvVv/N3QQY8uZNgSSS5o95/1HG9eGZOUqWaXrlIjJpXSOmuPeY
         6XyFMAtC1pvEy5taq03IqOMlbvKGCgwSAPXsarDityPy6iBLGp9C3AMJreP2chubreox
         jr8wdQ/0ffxbeoti/tq4tdgdDxZIl5Uzth4040vd9MeDORhtMpezurOJKxR4rw4o16Yg
         5txR7JlxHsWoPggVzzx7iR32h74SKTwg2ecPINlhegwajcZyrn5GjteWTfOkHdb5EJF/
         bRrQ==
X-Gm-Message-State: AOAM531nWkTLD0IWLyga1M18mU4rDPPbkZO/uorm8ODmdP9cgwp7amVm
        pw9UcNjlTkwYwQoYgmVTM8jpc1aRZg==
X-Google-Smtp-Source: ABdhPJxOkeQW7xaACUz9QlFFUPHVDXMImeRroGy+mmmVcvciDQaTiQMGxrMkGucIIVrMHylrxo8jHQ==
X-Received: by 2002:a05:620a:5a6:: with SMTP id q6mr25657683qkq.80.1606775465664;
        Mon, 30 Nov 2020 14:31:05 -0800 (PST)
Received: from localhost.localdomain (174-084-153-250.res.spectrum.com. [174.84.153.250])
        by smtp.gmail.com with ESMTPSA id q123sm16859861qke.28.2020.11.30.14.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Nov 2020 14:31:05 -0800 (PST)
From:   Brian Gerst <brgerst@gmail.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>, Jan Kara <jack@suse.cz>,
        Brian Gerst <brgerst@gmail.com>,
        =?UTF-8?q?Pawe=C5=82=20Jasiak?= <pawel@jasiak.xyz>
Subject: [PATCH] fanotify: Fix sys_fanotify_mark() on native x86-32
Date:   Mon, 30 Nov 2020 17:30:59 -0500
Message-Id: <20201130223059.101286-1-brgerst@gmail.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 121b32a58a3a converted native x86-32 which take 64-bit arguments to
use the compat handlers to allow conversion to passing args via pt_regs.
sys_fanotify_mark() was however missed, as it has a general compat handler.
Add a config option that will use the syscall wrapper that takes the split
args for native 32-bit.

Reported-by: Paweł Jasiak <pawel@jasiak.xyz>
Fixes: 121b32a58a3a ("x86/entry/32: Use IA32-specific wrappers for syscalls taking 64-bit arguments")
Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 arch/Kconfig                       |  6 ++++++
 arch/x86/Kconfig                   |  1 +
 fs/notify/fanotify/fanotify_user.c | 17 +++++++----------
 include/linux/syscalls.h           | 24 ++++++++++++++++++++++++
 4 files changed, 38 insertions(+), 10 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 090ef3566c56..452cc127c285 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1045,6 +1045,12 @@ config HAVE_STATIC_CALL_INLINE
 	bool
 	depends on HAVE_STATIC_CALL
 
+config ARCH_SPLIT_ARG64
+	bool
+	help
+	   If a 32-bit architecture requires 64-bit arguments to be split into
+	   pairs of 32-bit arguemtns, select this option.
+
 source "kernel/gcov/Kconfig"
 
 source "scripts/gcc-plugins/Kconfig"
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index e4499b01ae9a..41189d3de9fb 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -19,6 +19,7 @@ config X86_32
 	select KMAP_LOCAL
 	select MODULES_USE_ELF_REL
 	select OLD_SIGACTION
+	select ARCH_SPLIT_ARG64
 
 config X86_64
 	def_bool y
diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index 3e01d8f2ab90..dcab112e1f00 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1285,26 +1285,23 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	return ret;
 }
 
+#ifndef CONFIG_ARCH_SPLIT_ARG64
 SYSCALL_DEFINE5(fanotify_mark, int, fanotify_fd, unsigned int, flags,
 			      __u64, mask, int, dfd,
 			      const char  __user *, pathname)
 {
 	return do_fanotify_mark(fanotify_fd, flags, mask, dfd, pathname);
 }
+#endif
 
-#ifdef CONFIG_COMPAT
-COMPAT_SYSCALL_DEFINE6(fanotify_mark,
+#if defined(CONFIG_ARCH_SPLIT_ARG64) || defined(CONFIG_COMPAT)
+SYSCALL32_DEFINE6(fanotify_mark,
 				int, fanotify_fd, unsigned int, flags,
-				__u32, mask0, __u32, mask1, int, dfd,
+				SC_ARG64(mask), int, dfd,
 				const char  __user *, pathname)
 {
-	return do_fanotify_mark(fanotify_fd, flags,
-#ifdef __BIG_ENDIAN
-				((__u64)mask0 << 32) | mask1,
-#else
-				((__u64)mask1 << 32) | mask0,
-#endif
-				 dfd, pathname);
+	return do_fanotify_mark(fanotify_fd, flags, SC_VAL64(__u64, mask),
+				dfd, pathname);
 }
 #endif
 
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 37bea07c12f2..aea0ce9f3b74 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -251,6 +251,30 @@ static inline int is_syscall_trace_event(struct trace_event_call *tp_event)
 	static inline long __do_sys##name(__MAP(x,__SC_DECL,__VA_ARGS__))
 #endif /* __SYSCALL_DEFINEx */
 
+/* For split 64-bit arguments on 32-bit architectures */
+#ifdef __LITTLE_ENDIAN
+#define SC_ARG64(name) u32, name##_lo, u32, name##_hi
+#else
+#define SC_ARG64(name) u32, name##_hi, u32, name##_lo
+#endif
+#define SC_VAL64(type, name) ((type) name##_hi << 32 | name##_lo)
+
+#ifdef CONFIG_COMPAT
+#define SYSCALL32_DEFINE1 COMPAT_SYSCALL_DEFINE1
+#define SYSCALL32_DEFINE2 COMPAT_SYSCALL_DEFINE2
+#define SYSCALL32_DEFINE3 COMPAT_SYSCALL_DEFINE3
+#define SYSCALL32_DEFINE4 COMPAT_SYSCALL_DEFINE4
+#define SYSCALL32_DEFINE5 COMPAT_SYSCALL_DEFINE5
+#define SYSCALL32_DEFINE6 COMPAT_SYSCALL_DEFINE6
+#else
+#define SYSCALL32_DEFINE1 SYSCALL_DEFINE1
+#define SYSCALL32_DEFINE2 SYSCALL_DEFINE2
+#define SYSCALL32_DEFINE3 SYSCALL_DEFINE3
+#define SYSCALL32_DEFINE4 SYSCALL_DEFINE4
+#define SYSCALL32_DEFINE5 SYSCALL_DEFINE5
+#define SYSCALL32_DEFINE6 SYSCALL_DEFINE6
+#endif
+
 /*
  * Called before coming back to user-mode. Returning to user-mode with an
  * address limit different than USER_DS can allow to overwrite kernel memory.
-- 
2.26.2

