Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE0E7287C4E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 21:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729829AbgJHTQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 15:16:32 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37657 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729783AbgJHTQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 15:16:28 -0400
Received: by mail-qt1-f193.google.com with SMTP id s47so6070503qth.4
        for <linux-kernel@vger.kernel.org>; Thu, 08 Oct 2020 12:16:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tPUlXaemfFQZxdNtJjVKojJMHjYSg70DaRLU1Lc5Ye8=;
        b=EKBeoPyQ3QskTCgpokj3uVEQ3cYKkKp77AgZBWl+WNHjsNbxSDKeIaDUs+Pn0HqMjb
         Km9wVoCEzVsITJXovnBwMYGYdQkbqvQGCxE5GD0JiCaPJEcDmfnvbSIgG2G/PdE3U2hc
         TSQPIq6QXZex8bapURXm8TaWk9dSOcvrA7JZtUsKtlqIVCWz1b5Us6b4fEnSJRRQ1j2l
         3Xg34iNIWgpMjlOOiHQelHeuOBPAvdKuSMuhOoBCbD9BYeMTSFeplQ1XKK763HMOc8M8
         4scn6zXz77PZQc8QcSYOCLlKt2ORafVU6x47AkmRgFXguQkzpJreLdSb0hv7pMnNn/D2
         txsw==
X-Gm-Message-State: AOAM531tjQbXR6F1hnyo1UDyJW9qQhdV9y8eD5nnBf+4xPmq99Du8YfA
        UI1pMX2T0IIOGkBUbylkc3s=
X-Google-Smtp-Source: ABdhPJw294UjSDbdE3dja3Zi+wrlzbIcmrWLLNO1D2ojMx9ku+hpZ35G5jSns7B6v84YhpQtq0jsRA==
X-Received: by 2002:ac8:1289:: with SMTP id y9mr7989547qti.330.1602184587132;
        Thu, 08 Oct 2020 12:16:27 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id z37sm4726759qtz.67.2020.10.08.12.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2020 12:16:26 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     x86@kernel.org, Joerg Roedel <jroedel@suse.de>,
        Borislav Petkov <bp@alien8.de>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] x86/boot: Split out command-line related declarations
Date:   Thu,  8 Oct 2020 15:16:20 -0400
Message-Id: <20201008191623.2881677-3-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201008191623.2881677-1-nivedita@alum.mit.edu>
References: <20201008191623.2881677-1-nivedita@alum.mit.edu>
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
 arch/x86/boot/compressed/kaslr.c                |  7 +------
 arch/x86/boot/compressed/misc.h                 |  4 ----
 arch/x86/boot/compressed/pgtable_64.c           |  2 +-
 7 files changed, 18 insertions(+), 11 deletions(-)
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
 
diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index b59547ce5b19..489fabc051d7 100644
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
index 0fb948c0c8b4..46d761f7faa6 100644
--- a/arch/x86/boot/compressed/pgtable_64.c
+++ b/arch/x86/boot/compressed/pgtable_64.c
@@ -4,6 +4,7 @@
 #include <asm/efi.h>
 #include "pgtable.h"
 #include "../string.h"
+#include "cmdline.h"
 
 #define BIOS_START_MIN		0x20000U	/* 128K, less than this is insane */
 #define BIOS_START_MAX		0x9f000U	/* 640K, absolute maximum */
@@ -26,7 +27,6 @@ static char trampoline_save[TRAMPOLINE_32BIT_SIZE];
 unsigned long *trampoline_32bit __section(.data);
 
 extern struct boot_params *boot_params;
-int cmdline_find_option_bool(const char *option);
 
 static unsigned long find_trampoline_placement(void)
 {
-- 
2.26.2

