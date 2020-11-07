Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C39B52AA1A9
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Nov 2020 01:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727626AbgKGALD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 19:11:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726987AbgKGALD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 19:11:03 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377DDC0613CF
        for <linux-kernel@vger.kernel.org>; Fri,  6 Nov 2020 16:11:03 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id i184so1054200ybg.7
        for <linux-kernel@vger.kernel.org>; Fri, 06 Nov 2020 16:11:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:cc;
        bh=O4plfZhOm2PQ9/g1Q0it71FaybRhA0glqyeHSYfkzIQ=;
        b=TMsiT5Ay1V3dbf+nFkbbcDLN1xapnKgpZ344psPH1ixrSUzAmJCRVw0WgfgYoC7caw
         krLP9bU1zMwgEG2YrsLCGCMToBIbhLsR6LJw+JM4I2fhBOdxbFRwCjGuyamYFZuy8jlh
         yqimFzPyiVY1OnDjq3isval31Mt4NuJVIEdD6DcZqMCntMRQYsY+RXS9wBDTPQblWB0e
         pK5MauLz1aSoqy/1j6bJHShTPR7ZUfPsVuI/H1LOktZvnafH2NBpU+twmohQqqJ3xS7n
         idOdHl2wVWVOv0hXkFss1/tVWXQSzAdQZ/0hzea5+tOq1kLf3fldXc/+shSvDC/sFr0K
         Uyew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:cc;
        bh=O4plfZhOm2PQ9/g1Q0it71FaybRhA0glqyeHSYfkzIQ=;
        b=cQUfoeaBlVzd1pRB+HK6TB5yYk4moucjksev1s46GltoLZ0LlltYy09qRR+V/SmUrR
         QbfsaoHtDuaHByocB2cg4yV6q4+b6K9MJPR3kCoOxL34pT6mu36IQ+jKxZJ+PS8NV//B
         c6U/ZAWBNwgCOKFSO48thmsfN1tMXoqXetmoMSUfGpxysAtPg+6PUcaKgJ7iqHeon9bM
         FxfdajJW4DMkNLjN6FyOC5WycF2lzHMz0g8DbCpWbAMIi7UxbzGnpQOr4LmGpPPJnxHD
         jb88TKVJEyvfZdOsAjlMgDK7k0VCzHwO/fhad7+zmnhAibowYoxiY4F5P/2JFuZ96Ob8
         3LQA==
X-Gm-Message-State: AOAM530o0aOSGpLfqqIp6GyV4o8zLMwJc5OD6un6ENaSo0DNhoeT8d6c
        tIcTUGjtLDmc/nRvYO9ebThJlrELT7W0
X-Google-Smtp-Source: ABdhPJzTi6zme0srE5l3z9hQP083UDg0ykTg549x56pJYEeOYDD+AbqY7f2YUtpifBhf+she1+MqtfwM0kEg
Sender: "jiancai via sendgmr" <jiancai@jiancai.svl.corp.google.com>
X-Received: from jiancai.svl.corp.google.com ([2620:15c:2ce:0:f693:9fff:fef4:238b])
 (user=jiancai job=sendgmr) by 2002:a25:e6d0:: with SMTP id
 d199mr7019427ybh.398.1604707862263; Fri, 06 Nov 2020 16:11:02 -0800 (PST)
Date:   Fri,  6 Nov 2020 16:10:53 -0800
In-Reply-To: <20200409232728.231527-1-caij2003@gmail.com>
Message-Id: <20201107001056.225807-1-jiancai@google.com>
Mime-Version: 1.0
References: <20200409232728.231527-1-caij2003@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
Subject: [PATCH v2] Make iwmmxt.S support Clang's integrated assembler
From:   Jian Cai <jiancai@google.com>
Cc:     ndesaulniers@google.com, manojgupta@google.com, llozano@google.com,
        clang-built-linux@googlegroups.com, Jian Cai <jiancai@google.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Nathan Chancellor <natechancellor@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch replaces 6 IWMMXT instructions Clang's integrated assembler
does not support in iwmmxt.S using macros, while making sure GNU
assembler still emit the same instructions. This should be easier than
providing full IWMMXT support in Clang.

"Intel Wireless MMX Technology - Developer Guide - August, 2002" should
be referenced for the encoding schemes of these extensions.

Link: https://github.com/ClangBuiltLinux/linux/issues/975

Suggested-by: Nick Desaulniers <ndesaulniers@google.com>
Suggested-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Jian Cai <jiancai@google.com>
---
 arch/arm/kernel/iwmmxt.S | 89 ++++++++++++++++++++--------------------
 arch/arm/kernel/iwmmxt.h | 47 +++++++++++++++++++++
 2 files changed, 92 insertions(+), 44 deletions(-)
 create mode 100644 arch/arm/kernel/iwmmxt.h

diff --git a/arch/arm/kernel/iwmmxt.S b/arch/arm/kernel/iwmmxt.S
index 0dcae787b004..d2b4ac06e4ed 100644
--- a/arch/arm/kernel/iwmmxt.S
+++ b/arch/arm/kernel/iwmmxt.S
@@ -16,6 +16,7 @@
 #include <asm/thread_info.h>
 #include <asm/asm-offsets.h>
 #include <asm/assembler.h>
+#include "iwmmxt.h"
 
 #if defined(CONFIG_CPU_PJ4) || defined(CONFIG_CPU_PJ4B)
 #define PJ4(code...)		code
@@ -113,33 +114,33 @@ concan_save:
 
 concan_dump:
 
-	wstrw	wCSSF, [r1, #MMX_WCSSF]
-	wstrw	wCASF, [r1, #MMX_WCASF]
-	wstrw	wCGR0, [r1, #MMX_WCGR0]
-	wstrw	wCGR1, [r1, #MMX_WCGR1]
-	wstrw	wCGR2, [r1, #MMX_WCGR2]
-	wstrw	wCGR3, [r1, #MMX_WCGR3]
+	wstrw	wCSSF, r1, MMX_WCSSF
+	wstrw	wCASF, r1, MMX_WCASF
+	wstrw	wCGR0, r1, MMX_WCGR0
+	wstrw	wCGR1, r1, MMX_WCGR1
+	wstrw	wCGR2, r1, MMX_WCGR2
+	wstrw	wCGR3, r1, MMX_WCGR3
 
 1:	@ MUP? wRn
 	tst	r2, #0x2
 	beq	2f
 
-	wstrd	wR0,  [r1, #MMX_WR0]
-	wstrd	wR1,  [r1, #MMX_WR1]
-	wstrd	wR2,  [r1, #MMX_WR2]
-	wstrd	wR3,  [r1, #MMX_WR3]
-	wstrd	wR4,  [r1, #MMX_WR4]
-	wstrd	wR5,  [r1, #MMX_WR5]
-	wstrd	wR6,  [r1, #MMX_WR6]
-	wstrd	wR7,  [r1, #MMX_WR7]
-	wstrd	wR8,  [r1, #MMX_WR8]
-	wstrd	wR9,  [r1, #MMX_WR9]
-	wstrd	wR10, [r1, #MMX_WR10]
-	wstrd	wR11, [r1, #MMX_WR11]
-	wstrd	wR12, [r1, #MMX_WR12]
-	wstrd	wR13, [r1, #MMX_WR13]
-	wstrd	wR14, [r1, #MMX_WR14]
-	wstrd	wR15, [r1, #MMX_WR15]
+	wstrd	wR0,  r1, MMX_WR0
+	wstrd	wR1,  r1, MMX_WR1
+	wstrd	wR2,  r1, MMX_WR2
+	wstrd	wR3,  r1, MMX_WR3
+	wstrd	wR4,  r1, MMX_WR4
+	wstrd	wR5,  r1, MMX_WR5
+	wstrd	wR6,  r1, MMX_WR6
+	wstrd	wR7,  r1, MMX_WR7
+	wstrd	wR8,  r1, MMX_WR8
+	wstrd	wR9,  r1, MMX_WR9
+	wstrd	wR10, r1, MMX_WR10
+	wstrd	wR11, r1, MMX_WR11
+	wstrd	wR12, r1, MMX_WR12
+	wstrd	wR13, r1, MMX_WR13
+	wstrd	wR14, r1, MMX_WR14
+	wstrd	wR15, r1, MMX_WR15
 
 2:	teq	r0, #0				@ anything to load?
 	reteq	lr				@ if not, return
@@ -147,30 +148,30 @@ concan_dump:
 concan_load:
 
 	@ Load wRn
-	wldrd	wR0,  [r0, #MMX_WR0]
-	wldrd	wR1,  [r0, #MMX_WR1]
-	wldrd	wR2,  [r0, #MMX_WR2]
-	wldrd	wR3,  [r0, #MMX_WR3]
-	wldrd	wR4,  [r0, #MMX_WR4]
-	wldrd	wR5,  [r0, #MMX_WR5]
-	wldrd	wR6,  [r0, #MMX_WR6]
-	wldrd	wR7,  [r0, #MMX_WR7]
-	wldrd	wR8,  [r0, #MMX_WR8]
-	wldrd	wR9,  [r0, #MMX_WR9]
-	wldrd	wR10, [r0, #MMX_WR10]
-	wldrd	wR11, [r0, #MMX_WR11]
-	wldrd	wR12, [r0, #MMX_WR12]
-	wldrd	wR13, [r0, #MMX_WR13]
-	wldrd	wR14, [r0, #MMX_WR14]
-	wldrd	wR15, [r0, #MMX_WR15]
+	wldrd	wR0,  r0, MMX_WR0
+	wldrd	wR1,  r0, MMX_WR1
+	wldrd	wR2,  r0, MMX_WR2
+	wldrd	wR3,  r0, MMX_WR3
+	wldrd	wR4,  r0, MMX_WR4
+	wldrd	wR5,  r0, MMX_WR5
+	wldrd	wR6,  r0, MMX_WR6
+	wldrd	wR7,  r0, MMX_WR7
+	wldrd	wR8,  r0, MMX_WR8
+	wldrd	wR9,  r0, MMX_WR9
+	wldrd	wR10, r0, MMX_WR10
+	wldrd	wR11, r0, MMX_WR11
+	wldrd	wR12, r0, MMX_WR12
+	wldrd	wR13, r0, MMX_WR13
+	wldrd	wR14, r0, MMX_WR14
+	wldrd	wR15, r0, MMX_WR15
 
 	@ Load wCx
-	wldrw	wCSSF, [r0, #MMX_WCSSF]
-	wldrw	wCASF, [r0, #MMX_WCASF]
-	wldrw	wCGR0, [r0, #MMX_WCGR0]
-	wldrw	wCGR1, [r0, #MMX_WCGR1]
-	wldrw	wCGR2, [r0, #MMX_WCGR2]
-	wldrw	wCGR3, [r0, #MMX_WCGR3]
+	wldrw	wCSSF, r0, MMX_WCSSF
+	wldrw	wCASF, r0, MMX_WCASF
+	wldrw	wCGR0, r0, MMX_WCGR0
+	wldrw	wCGR1, r0, MMX_WCGR1
+	wldrw	wCGR2, r0, MMX_WCGR2
+	wldrw	wCGR3, r0, MMX_WCGR3
 
 	@ clear CUP/MUP (only if r1 != 0)
 	teq	r1, #0
diff --git a/arch/arm/kernel/iwmmxt.h b/arch/arm/kernel/iwmmxt.h
new file mode 100644
index 000000000000..fb627286f5bb
--- /dev/null
+++ b/arch/arm/kernel/iwmmxt.h
@@ -0,0 +1,47 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __IWMMXT_H__
+#define __IWMMXT_H__
+
+.irp b, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15
+.set .LwR\b, \b
+.set .Lr\b, \b
+.endr
+
+.set .LwCSSF, 0x2
+.set .LwCASF, 0x3
+.set .LwCGR0, 0x8
+.set .LwCGR1, 0x9
+.set .LwCGR2, 0xa
+.set .LwCGR3, 0xb
+
+.macro wldrd, reg:req, base:req, offset:req
+.inst 0xedd00100 | (.L\reg << 12) | (.L\base << 16) | (\offset >> 2)
+.endm
+
+.macro wldrw, reg:req, base:req, offset:req
+.inst 0xfd900100 | (.L\reg << 12) | (.L\base << 16) | (\offset >> 2)
+.endm
+
+.macro wstrd, reg:req, base:req, offset:req
+.inst 0xedc00100 | (.L\reg << 12) | (.L\base << 16) | (\offset >> 2)
+.endm
+
+.macro wstrw, reg:req, base:req, offset:req
+.inst 0xfd800100 | (.L\reg << 12) | (.L\base << 16) | (\offset >> 2)
+.endm
+
+#ifdef __clang__
+
+#define wCon c1
+
+.macro tmrc, dest:req, control:req
+mrc p1, 0, \dest, \control, c0, 0
+.endm
+
+.macro tmcr, control:req, src:req
+mcr p1, 0, \src, \control, c0, 0
+.endm
+#endif
+
+#endif
-- 
2.29.1.341.ge80a0c044ae-goog

