Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7C81290C8E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Oct 2020 22:04:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393336AbgJPUEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Oct 2020 16:04:14 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:38873 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393309AbgJPUEJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Oct 2020 16:04:09 -0400
Received: by mail-io1-f67.google.com with SMTP id y20so5417574iod.5
        for <linux-kernel@vger.kernel.org>; Fri, 16 Oct 2020 13:04:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IFyprBaUQqBK4R965npVtxWLqshR2DfPktcZIu4coHE=;
        b=YVVViI//fskkAlf0SvW9JKf4kBtY6SFmiFJD4hEaA4Snk5gydi5x4mXrv8cHLV6He1
         pJLasUBsxMsMBLUXgyyskLTHCDFbvc85HaGwYuOnJRwyM2OIvVJZeRA/+WeRWXr+gxCP
         FhPaoY5+OD0ZKC3jBK2GjRBAnWxIOh7Gq+z6NsrE7ripygYWGm4ZfONtNRf5xpqdL7PI
         cQ1541LMTRd2Yf3q8EQLtC8uj3WG1N7PXz3sLUJbWTn01KQgIXpkBZAKpuU+XqX1TAiG
         pQ0KpV+lyCbsBs4IfkYuu6sThoIt50iZBy3rM+g6qNUuZcFMfXbUXpa8cX+YGgtO8suU
         l2sg==
X-Gm-Message-State: AOAM532xrdRmoQ84AJK+d90rg1YhI0A2QyWWI8x6Enwfc+zu1moouNxA
        fs+u/bduMNd7jLPAe17+R/k=
X-Google-Smtp-Source: ABdhPJx8p8Q0bNQW9URb48nNsNWyk3rrPLfFgdn1ukuJ/2SJldA8bl9UJ5WRVj/9da8cOBE8ytph0Q==
X-Received: by 2002:a6b:651a:: with SMTP id z26mr3820886iob.186.1602878648257;
        Fri, 16 Oct 2020 13:04:08 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id r2sm2886961ile.1.2020.10.16.13.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 13:04:07 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     Borislav Petkov <bp@alien8.de>
Cc:     x86@kernel.org, Joerg Roedel <jroedel@suse.de>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] x86/boot: Split out command-line related declarations
Date:   Fri, 16 Oct 2020 16:04:03 -0400
Message-Id: <20201016200404.1615994-3-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201016200404.1615994-1-nivedita@alum.mit.edu>
References: <20201016173232.GI8483@zn.tnic>
 <20201016200404.1615994-1-nivedita@alum.mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move prototypes for command-line related functions into a new header
file to split it out from misc.h.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/boot/compressed/acpi.c                 |  1 +
 arch/x86/boot/compressed/cmdline.c              |  1 +
 arch/x86/boot/compressed/cmdline.h              | 13 +++++++++++++
 arch/x86/boot/compressed/early_serial_console.c |  1 +
 arch/x86/boot/compressed/ident_map_64.c         |  7 +------
 arch/x86/boot/compressed/kaslr.c                |  7 +------
 arch/x86/boot/compressed/misc.h                 |  4 ----
 arch/x86/boot/compressed/pgtable_64.c           |  2 +-
 8 files changed, 19 insertions(+), 17 deletions(-)
 create mode 100644 arch/x86/boot/compressed/cmdline.h

diff --git a/arch/x86/boot/compressed/acpi.c b/arch/x86/boot/compressed/acpi.c
index 8bcbcee54aa1..9097108c37e1 100644
--- a/arch/x86/boot/compressed/acpi.c
+++ b/arch/x86/boot/compressed/acpi.c
@@ -3,6 +3,7 @@
 #include "misc.h"
 #include "error.h"
 #include "../string.h"
+#include "cmdline.h"
 
 #include <linux/numa.h>
 #include <linux/efi.h>
diff --git a/arch/x86/boot/compressed/cmdline.c b/arch/x86/boot/compressed/cmdline.c
index f1add5d85da9..20f2e6d8b891 100644
--- a/arch/x86/boot/compressed/cmdline.c
+++ b/arch/x86/boot/compressed/cmdline.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include "misc.h"
+#include "cmdline.h"
 
 static unsigned long fs;
 static inline void set_fs(unsigned long seg)
diff --git a/arch/x86/boot/compressed/cmdline.h b/arch/x86/boot/compressed/cmdline.h
new file mode 100644
index 000000000000..72800770bd60
--- /dev/null
+++ b/arch/x86/boot/compressed/cmdline.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef BOOT_COMPRESSED_CMDLINE_H
+#define BOOT_COMPRESSED_CMDLINE_H
+
+#define _SETUP
+#include <asm/setup.h>	/* For COMMAND_LINE_SIZE */
+#undef _SETUP
+
+unsigned long get_cmd_line_ptr(void);
+int cmdline_find_option(const char *option, char *buffer, int bufsize);
+int cmdline_find_option_bool(const char *option);
+
+#endif /* BOOT_COMPRESSED_CMDLINE_H */
diff --git a/arch/x86/boot/compressed/early_serial_console.c b/arch/x86/boot/compressed/early_serial_console.c
index 261e81fb9582..64a1f557e122 100644
--- a/arch/x86/boot/compressed/early_serial_console.c
+++ b/arch/x86/boot/compressed/early_serial_console.c
@@ -1,4 +1,5 @@
 #include "misc.h"
+#include "cmdline.h"
 
 int early_serial_base;
 
diff --git a/arch/x86/boot/compressed/ident_map_64.c b/arch/x86/boot/compressed/ident_map_64.c
index b679908c120e..06ebe5e3e489 100644
--- a/arch/x86/boot/compressed/ident_map_64.c
+++ b/arch/x86/boot/compressed/ident_map_64.c
@@ -21,6 +21,7 @@
 
 #include "error.h"
 #include "misc.h"
+#include "cmdline.h"
 
 /* These actually do the work of building the kernel identity maps. */
 #include <linux/pgtable.h>
@@ -33,12 +34,6 @@
 #define __PAGE_OFFSET __PAGE_OFFSET_BASE
 #include "../../mm/ident_map.c"
 
-#define _SETUP
-#include <asm/setup.h>	/* For COMMAND_LINE_SIZE */
-#undef _SETUP
-
-extern unsigned long get_cmd_line_ptr(void);
-
 /* Used by PAGE_KERN* macros: */
 pteval_t __default_kernel_pte_mask __read_mostly = ~0;
 
diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index b92fffbe761f..9eabd8bc7673 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -22,6 +22,7 @@
 #include "misc.h"
 #include "error.h"
 #include "../string.h"
+#include "cmdline.h"
 
 #include <generated/compile.h>
 #include <linux/module.h>
@@ -36,12 +37,6 @@
 #define STATIC
 #include <linux/decompress/mm.h>
 
-#define _SETUP
-#include <asm/setup.h>	/* For COMMAND_LINE_SIZE */
-#undef _SETUP
-
-extern unsigned long get_cmd_line_ptr(void);
-
 /* Simplified build-specific string for starting entropy. */
 static const char build_str[] = UTS_RELEASE " (" LINUX_COMPILE_BY "@"
 		LINUX_COMPILE_HOST ") (" LINUX_COMPILER ") " UTS_VERSION;
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 6d31f1b4c4d1..e3e2f312c025 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -69,10 +69,6 @@ static inline void debug_puthex(unsigned long value)
 
 #endif
 
-/* cmdline.c */
-int cmdline_find_option(const char *option, char *buffer, int bufsize);
-int cmdline_find_option_bool(const char *option);
-
 struct mem_vector {
 	u64 start;
 	u64 size;
diff --git a/arch/x86/boot/compressed/pgtable_64.c b/arch/x86/boot/compressed/pgtable_64.c
index 25add5510edc..0976c2d2ab2f 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -4,6 +4,7 @@
 #include <asm/efi.h>
 #include "pgtable.h"
 #include "../string.h"
+#include "cmdline.h"
 
 #define BIOS_START_MIN		0x20000U	/* 128K, less than this is insane */
 #define BIOS_START_MAX		0x9f000U	/* 640K, absolute maximum */
@@ -33,7 +34,6 @@ static char trampoline_save[TRAMPOLINE_32BIT_SIZE];
 unsigned long *trampoline_32bit __section(.data);
 
 extern struct boot_params *boot_params;
-int cmdline_find_option_bool(const char *option);
 
 static unsigned long find_trampoline_placement(void)
 {
-- 
2.26.2

