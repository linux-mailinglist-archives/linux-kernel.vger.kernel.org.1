Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F26152ADAFA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 16:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731134AbgKJP4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 10:56:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730988AbgKJP4E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 10:56:04 -0500
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6664EC0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Nov 2020 07:56:03 -0800 (PST)
Received: from ramsan.of.borg ([84.195.186.194])
        by laurent.telenet-ops.be with bizsmtp
        id qfw12300a4C55Sk01fw1vn; Tue, 10 Nov 2020 16:56:02 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kcW01-001DVY-Kp; Tue, 10 Nov 2020 16:56:01 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kcW01-00Dn4J-84; Tue, 10 Nov 2020 16:56:01 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>
Cc:     linux-c6x-dev@linux-c6x.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH resend] c6x: Remove unused <asm/procinfo.h>
Date:   Tue, 10 Nov 2020 16:56:00 +0100
Message-Id: <20201110155600.3286840-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

C6X never used <asm/procinfo.h>, which was presumably opied from ARM.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/c6x/include/asm/procinfo.h | 24 ------------------------
 arch/c6x/kernel/asm-offsets.c   |  1 -
 2 files changed, 25 deletions(-)
 delete mode 100644 arch/c6x/include/asm/procinfo.h

diff --git a/arch/c6x/include/asm/procinfo.h b/arch/c6x/include/asm/procinfo.h
deleted file mode 100644
index aaa3cb902c43fdb9..0000000000000000
--- a/arch/c6x/include/asm/procinfo.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- *  Copyright (C) 2010 Texas Instruments Incorporated
- *  Author: Mark Salter (msalter@redhat.com)
- */
-#ifndef _ASM_C6X_PROCINFO_H
-#define _ASM_C6X_PROCINFO_H
-
-#ifdef __KERNEL__
-
-struct proc_info_list {
-	unsigned int		cpu_val;
-	unsigned int		cpu_mask;
-	const char		*arch_name;
-	const char		*elf_name;
-	unsigned int		elf_hwcap;
-};
-
-#else	/* __KERNEL__ */
-#include <asm/elf.h>
-#warning "Please include asm/elf.h instead"
-#endif	/* __KERNEL__ */
-
-#endif	/* _ASM_C6X_PROCINFO_H */
diff --git a/arch/c6x/kernel/asm-offsets.c b/arch/c6x/kernel/asm-offsets.c
index 4a264ef87dcb8bb3..e690a5a75e0e5821 100644
--- a/arch/c6x/kernel/asm-offsets.c
+++ b/arch/c6x/kernel/asm-offsets.c
@@ -7,7 +7,6 @@
 
 #include <linux/sched.h>
 #include <linux/thread_info.h>
-#include <asm/procinfo.h>
 #include <linux/kbuild.h>
 #include <linux/unistd.h>
 
-- 
2.25.1

