Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22F8A2BFFB0
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 06:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727855AbgKWFh6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 00:37:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgKWFh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 00:37:58 -0500
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 553B9C0613CF
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 21:37:58 -0800 (PST)
Received: by mail-pg1-x542.google.com with SMTP id s63so3323261pgc.8
        for <linux-kernel@vger.kernel.org>; Sun, 22 Nov 2020 21:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=UGBhOw/fRgUFpvRhV+fdWmv9QNQTBHvPX/g8g6YWFD0=;
        b=BWbZn7FYTpTmB6K5e5yo6bj8Y5+Gs2djnmet9/UNvkvs3x5jvydaorHRslrIdZAwZN
         k5LxJWu/BfzgNE/ppJCWkzmdJ4sdtGB1ErsyLDNKhFLD7pKzLgpcx2ohwJ0GZoDQ7Vb5
         H9qOmA7dFSxTs05oBv7t9dA6XxkmwGnuDn4GkKtQ4WdftFB35BeNhCInQfPqH1rjznke
         9KlJsEEIf4IeR+REMJN4ZfFtucFj0u5QWq3mC/t1XlJXSXZAkfpvdq6DM3nfQ8WM2vTs
         qez8kCsCKYZDVeMvYL2aH60ynGIlJ/eoSXwPfJ/Y+ZQYn4zzdjmLsOow+2iStmoxNGmF
         xL/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=UGBhOw/fRgUFpvRhV+fdWmv9QNQTBHvPX/g8g6YWFD0=;
        b=YS9qOyF8whOBpI0t3saG7dGdjfJ5KiZde6fnEWJ55D6zTrsxH8dHlHGIeLinQSkrfF
         Z9KvQNpUVQ39/xSP8RAfg8ivb8BGgW7TveEVapouBamXr35BuzmJIz90Smb+NRpeVQNl
         Dyyuu++IT/jbtuRjr0Fro5BjZ8k1eKVgFeAkQgnS0b6eIqtU7DgmISqKOR/ubHG8ngtT
         LM2R6gy5pkTZIQxjrweUs6kbU5igcE4n5x4zdOwgGEYTTBBrdocoYkvBDZo0rDAFJfXJ
         IwKz7rBB9zR8dDg2zJwNJO9JxF3DxRlBHCKdM58cB+ScD/GJbFzNj+tngldjualI5Ok/
         qF/Q==
X-Gm-Message-State: AOAM533/Tx9bZO9jI7ORwH8XPyVBJhtrLM5x8ozaeTCeJy/WPAJUB8MJ
        rSiuyQlYyv6ErEFk9b3K3Q==
X-Google-Smtp-Source: ABdhPJxDD5nKBKk89eGtnhrItdP40TkqZ87ONAi9MmHxqLZPuOlnPYur0HL0Eo0hj7DbLtE+aceeXg==
X-Received: by 2002:a63:a1d:: with SMTP id 29mr25891087pgk.162.1606109877897;
        Sun, 22 Nov 2020 21:37:57 -0800 (PST)
Received: from mylaptop.redhat.com ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id h18sm5827825pfk.17.2020.11.22.21.37.52
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 22 Nov 2020 21:37:57 -0800 (PST)
From:   Pingfan Liu <kernelfans@gmail.com>
To:     x86@kernel.org
Cc:     Pingfan Liu <kernelfans@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Omar Sandoval <osandov@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] x86/machine_kexec: disable PMU before jumping to new kernel
Date:   Mon, 23 Nov 2020 13:37:26 +0800
Message-Id: <1606109846-13688-2-git-send-email-kernelfans@gmail.com>
X-Mailer: git-send-email 2.7.5
In-Reply-To: <1606109846-13688-1-git-send-email-kernelfans@gmail.com>
References: <1606109846-13688-1-git-send-email-kernelfans@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During jumping to the new kernel, on the crashed cpu, the memory mapping
switches from an old one to an identity one. It had better disable PMU to
suppress NMI, which can be delivered using the old mapping.

Also on x86_64, idt_invalidate() to clear idt as on 32 bits.

Signed-off-by: Pingfan Liu <kernelfans@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Omar Sandoval <osandov@fb.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@kernel.org>
To: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
 arch/x86/kernel/machine_kexec_32.c | 1 +
 arch/x86/kernel/machine_kexec_64.c | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/arch/x86/kernel/machine_kexec_32.c b/arch/x86/kernel/machine_kexec_32.c
index 64b00b0..72c6100 100644
--- a/arch/x86/kernel/machine_kexec_32.c
+++ b/arch/x86/kernel/machine_kexec_32.c
@@ -191,6 +191,7 @@ void machine_kexec(struct kimage *image)
 	/* Interrupts aren't acceptable while we reboot */
 	local_irq_disable();
 	hw_breakpoint_disable();
+	perf_pmu_disable_all();
 
 	if (image->preserve_context) {
 #ifdef CONFIG_X86_IO_APIC
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index a29a44a..238893e 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -17,6 +17,7 @@
 #include <linux/suspend.h>
 #include <linux/vmalloc.h>
 #include <linux/efi.h>
+#include <linux/perf_event.h>
 
 #include <asm/init.h>
 #include <asm/tlbflush.h>
@@ -338,6 +339,8 @@ void machine_kexec(struct kimage *image)
 	/* Interrupts aren't acceptable while we reboot */
 	local_irq_disable();
 	hw_breakpoint_disable();
+	perf_pmu_disable_all();
+	idt_invalidate(phys_to_virt(0));
 
 	if (image->preserve_context) {
 #ifdef CONFIG_X86_IO_APIC
-- 
2.7.5

