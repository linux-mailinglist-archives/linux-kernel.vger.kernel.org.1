Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B82828394F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 17:15:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726763AbgJEPPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 11:15:42 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33284 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725970AbgJEPPl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 11:15:41 -0400
Received: by mail-qt1-f193.google.com with SMTP id c23so2719842qtp.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Oct 2020 08:15:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TEPykH1vMpAjLJBZEhq5AaDaD1N8oKtcYYmi8SUqWQ4=;
        b=T/JHRWyy5ZLOyG/4ZArFNyeOh3Pej3fAt0AWLCRmiYN9wActLiJWOqZBoTx2h9bqsT
         QVRJgWsYC8gTOsyXR7q2GeZFhMI5MwSopAIJSbWEQRLyNo3YF/ki6zjSSL40x+EvFKyq
         UUNIyCa4iYgsNMS13MnsGlK9T8vXDGq2D5Fou3nnBjyVwDG1eVA3IFLGCMXmxyjyzzh9
         738b15Tp606JFw6BSGQLaNJS6W5upmW96nc6uqchniPuq13P4WuAwk/qL2ZPn5uUxOeD
         OZNEqRsnclgUFPC5Ggt1lnm5rHorzY6uChe7brUuhuyQZjXjHywWWWicCSTgMK3a0uoY
         BteQ==
X-Gm-Message-State: AOAM5328QQSf1yDmceNH3pMM7kLdwgHMb6Vj6yFzu3fMbbkvsyApV0nu
        zYJZHd5qHgIaEInxC9yRH1E=
X-Google-Smtp-Source: ABdhPJy2iEwsTm3+YHQAkeHnGCj6vw6EDd/e0x0xwcWyO74xaV/JoIoraR3qRoZefrmiTF7CwNtqBg==
X-Received: by 2002:ac8:6f50:: with SMTP id n16mr341659qtv.190.1601910940640;
        Mon, 05 Oct 2020 08:15:40 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id e23sm17430qtp.61.2020.10.05.08.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Oct 2020 08:15:40 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
To:     x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] x86/build: Fix vmlinux size check on 64-bit
Date:   Mon,  5 Oct 2020 11:15:39 -0400
Message-Id: <20201005151539.2214095-1-nivedita@alum.mit.edu>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit b4e0409a36f4 ("x86: check vmlinux limits, 64-bit") added a check
that the size of the 64-bit kernel is less than KERNEL_IMAGE_SIZE.

The check uses (_end - _text), but this is not enough. The initial PMD
used in startup_64() (level2_kernel_pgt) can only map upto
KERNEL_IMAGE_SIZE from __START_KERNEL_map, not from _text.

The correct check is the same as for 32-bit, since LOAD_OFFSET is
defined appropriately for the two architectures. Just check
(_end - LOAD_OFFSET) against KERNEL_IMAGE_SIZE unconditionally.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
---
 arch/x86/kernel/vmlinux.lds.S | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
index bf9e0adb5b7e..b38832821b98 100644
--- a/arch/x86/kernel/vmlinux.lds.S
+++ b/arch/x86/kernel/vmlinux.lds.S
@@ -454,13 +454,12 @@ SECTIONS
 	ASSERT(SIZEOF(.rela.dyn) == 0, "Unexpected run-time relocations (.rela) detected!")
 }
 
-#ifdef CONFIG_X86_32
 /*
  * The ASSERT() sink to . is intentional, for binutils 2.14 compatibility:
  */
 . = ASSERT((_end - LOAD_OFFSET <= KERNEL_IMAGE_SIZE),
 	   "kernel image bigger than KERNEL_IMAGE_SIZE");
-#else
+#ifdef CONFIG_X86_64
 /*
  * Per-cpu symbols which need to be offset from __per_cpu_load
  * for the boot processor.
@@ -470,18 +469,12 @@ INIT_PER_CPU(gdt_page);
 INIT_PER_CPU(fixed_percpu_data);
 INIT_PER_CPU(irq_stack_backing_store);
 
-/*
- * Build-time check on the image size:
- */
-. = ASSERT((_end - _text <= KERNEL_IMAGE_SIZE),
-	   "kernel image bigger than KERNEL_IMAGE_SIZE");
-
 #ifdef CONFIG_SMP
 . = ASSERT((fixed_percpu_data == 0),
            "fixed_percpu_data is not at start of per-cpu area");
 #endif
 
-#endif /* CONFIG_X86_32 */
+#endif /* CONFIG_X86_64 */
 
 #ifdef CONFIG_KEXEC_CORE
 #include <asm/kexec.h>
-- 
2.26.2

