Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75D6927D9BD
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 23:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729392AbgI2VE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 17:04:58 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:32857 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgI2VE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 17:04:58 -0400
Received: by mail-qt1-f194.google.com with SMTP id a4so4862801qth.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Sep 2020 14:04:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=MXHCjm2f4B3C88ZBMrTBGAoyRnpIg67/FPZnMRlWhj8=;
        b=WidYGR55xyS8OOEXMowb96/LuIE1QRhyf3UP+fFmBzfEClfdPjg1XOzoko3g04U66O
         KV9YwtiLaXC+RijZ95iZP5yJEOJIPAbhFq0wX6a+J+p4M2HT3I5nXJAG0tlDBxtPMOTG
         tZhi8lprXUud5ow5UdtE/Rhor7AEXyn+L8K2vMsufqkjS84Ff8pZwlbgmrPqi7JaEgkV
         6FALRIDKDpUHmSHUMadb2r9g6NjVcCChy6yyZbl7EWQ9bh+Ll63owxkRxJvBAFyN5mwM
         wPWEhjgMdDdtIoWnG9/siSSejar5cNxzM7/dvvJH18bScVk4TqrKjTUdCtr6Gq9XmbZo
         YEUA==
X-Gm-Message-State: AOAM530WhlVhqcIUDQDPPvpzzzy9yfbgQDlFMUXDLRaPIEzJvxb3tXPe
        SB1KioJayVDheLF+szhrghXqPjbFii3PlA==
X-Google-Smtp-Source: ABdhPJxwDwQj7/PD82n4z/8SUv6nOfQkmljWpHQbVLg5n8K95n7c/vD6QscKFc44OOUSRU4OhZ3YGw==
X-Received: by 2002:ac8:1387:: with SMTP id h7mr5495384qtj.386.1601413496799;
        Tue, 29 Sep 2020 14:04:56 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id s20sm6049524qkg.65.2020.09.29.14.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2020 14:04:56 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Ross Philipson <ross.philipson@oracle.com>
Subject: [PATCH] x86/boot: Place kernel_info at a fixed offset
Date:   Tue, 29 Sep 2020 17:04:55 -0400
Message-Id: <20200929210455.2718827-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are use cases for storing the offset of a symbol in kernel_info.
For example, the trenchboot series [0] needs to store the offset of the
Measured Launch Environment header in kernel_info.

Since commit (note: commit ID from tip/master)

  527afc212231 ("x86/boot: Check that there are no run-time relocations")

run-time relocations are not allowed in the compressed kernel, so simply
using the symbol in kernel_info, as

	.long	symbol

will cause a linker error because this is not position-independent.

With kernel_info being a separate object file and in a different section
from startup_32, there is no way to calculate the offset of a symbol
from the start of the image in a position-independent way.

To enable such use cases, put kernel_info into its own section which is
placed at a predetermined offset (KERNEL_INFO_OFFSET) via the linker
script. This will allow calculating the symbol offset in a
position-independent way, by adding the offset from the start of
kernel_info to KERNEL_INFO_OFFSET.

Ensure that kernel_info is aligned, and use the SYM_DATA.* macros
instead of bare labels. This stores the size of the kernel_info
structure in the ELF symbol table.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Cc: Ross Philipson <ross.philipson@oracle.com>
[0] https://lore.kernel.org/lkml/1600959521-24158-8-git-send-email-ross.philipson@oracle.com/
---
 arch/x86/boot/compressed/kernel_info.S | 19 +++++++++++++++----
 arch/x86/boot/compressed/kernel_info.h | 12 ++++++++++++
 arch/x86/boot/compressed/vmlinux.lds.S |  6 ++++++
 3 files changed, 33 insertions(+), 4 deletions(-)
 create mode 100644 arch/x86/boot/compressed/kernel_info.h

diff --git a/arch/x86/boot/compressed/kernel_info.S b/arch/x86/boot/compressed/kernel_info.S
index f818ee8fba38..c18f07181dd5 100644
--- a/arch/x86/boot/compressed/kernel_info.S
+++ b/arch/x86/boot/compressed/kernel_info.S
@@ -1,12 +1,23 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
+#include <linux/linkage.h>
 #include <asm/bootparam.h>
+#include "kernel_info.h"
 
-	.section ".rodata.kernel_info", "a"
+/*
+ * If a field needs to hold the offset of a symbol from the start
+ * of the image, use the macro below, eg
+ *	.long	rva(symbol)
+ * This will avoid creating run-time relocations, which are not
+ * allowed in the compressed kernel.
+ */
+
+#define rva(X) (((X) - kernel_info) + KERNEL_INFO_OFFSET)
 
-	.global kernel_info
+	.section ".rodata.kernel_info", "a"
 
-kernel_info:
+	.balign	16
+SYM_DATA_START(kernel_info)
 	/* Header, Linux top (structure). */
 	.ascii	"LToP"
 	/* Size. */
@@ -19,4 +30,4 @@ kernel_info:
 
 kernel_info_var_len_data:
 	/* Empty for time being... */
-kernel_info_end:
+SYM_DATA_END_LABEL(kernel_info, SYM_L_LOCAL, kernel_info_end)
diff --git a/arch/x86/boot/compressed/kernel_info.h b/arch/x86/boot/compressed/kernel_info.h
new file mode 100644
index 000000000000..c127f84aec63
--- /dev/null
+++ b/arch/x86/boot/compressed/kernel_info.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef BOOT_COMPRESSED_KERNEL_INFO_H
+#define BOOT_COMPRESSED_KERNEL_INFO_H
+
+#ifdef CONFIG_X86_64
+#define KERNEL_INFO_OFFSET 0x500
+#else /* 32-bit */
+#define KERNEL_INFO_OFFSET 0x100
+#endif
+
+#endif /* BOOT_COMPRESSED_KERNEL_INFO_H */
diff --git a/arch/x86/boot/compressed/vmlinux.lds.S b/arch/x86/boot/compressed/vmlinux.lds.S
index 112b2375d021..84c7b4de489e 100644
--- a/arch/x86/boot/compressed/vmlinux.lds.S
+++ b/arch/x86/boot/compressed/vmlinux.lds.S
@@ -7,6 +7,7 @@ OUTPUT_FORMAT(CONFIG_OUTPUT_FORMAT)
 
 #include <asm/cache.h>
 #include <asm/page_types.h>
+#include "kernel_info.h"
 
 #ifdef CONFIG_X86_64
 OUTPUT_ARCH(i386:x86-64)
@@ -27,6 +28,11 @@ SECTIONS
 		HEAD_TEXT
 		_ehead = . ;
 	}
+	.rodata.kernel_info KERNEL_INFO_OFFSET : {
+		*(.rodata.kernel_info)
+	}
+	ASSERT(ABSOLUTE(kernel_info) == KERNEL_INFO_OFFSET, "kernel_info at bad address!")
+
 	.rodata..compressed : {
 		*(.rodata..compressed)
 	}
-- 
2.26.2

