Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50EEB2C3F43
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 12:45:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728338AbgKYLov (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 06:44:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727378AbgKYLov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 06:44:51 -0500
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD05C0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 03:44:51 -0800 (PST)
Received: by mail-ej1-x643.google.com with SMTP id lv15so2529024ejb.12
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 03:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nq1Er3msl49mJFdzRnxuARFtox4IjOQ0vErNwAGxOjk=;
        b=hP2iLgGgS45K/IP5xASWgc1NdJJYB0XPFcZtFzu3sTYVEROy58bqiz+mtAgTqC9Q6I
         p3qjnEGeZdCxPpNditaI4MCcexzixwxyCDm7qDpYCgAu7eHKxvbqmtptb0cruqyBDfLQ
         ZqW+046t1ht9rdjaEv0xBGUYFDymC42O+1d5TPkq4CGjUvKD7/vCMtgS8VPitQc8UGwk
         pa71gt8LV6oJ9KboMRmOSsKS6DDExxOlDJUjgLhRbZZNMwHapucJlgZumNMgnNL17vZS
         Di5lHougAoPUSEgfKbkKwjHKcacUGbvpAftSJ+CIqOU2GI9/Pbzu7lu/y774yrrtWOtc
         Im4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=nq1Er3msl49mJFdzRnxuARFtox4IjOQ0vErNwAGxOjk=;
        b=H9st9Ccb040d7FQTMiSSHQoU/iMBnxdBzzOCLyppGhLM7urYiF2GwZ8SN97P9SAFlc
         4Bd6juyT+G6ylgmZVNabxDRi4tmq5VjZuy24D8u00uDrp82IR/+5nwwhn0B3Ly3mXi0L
         lZfSLG/BbzEU7Li9ti+jTuDXgvyVa00t2rFvDuyv9hcdXy2vh/qwnAKujoJrkI/kxV0l
         NVdQ7Ev7tNTNN3BaPAPbBth65M3IsrhrVA8eGR+FO2UeJTBld6fzMUGpE5WPkYdsd+H+
         68aQdV+WAKnFxTk8iUD0LqQcgh6tfePmNdUjEKQCQnFxTzYr3uuU+syqwdkF1W7D56Bw
         ZJew==
X-Gm-Message-State: AOAM532f5U05n9hQrLGXc6VvoIsDSGLlSSAu3ET8vDwLjciwBVF+w3fH
        4I50eJ6FpjT99imrE2kSVYNmkW/5B1FGFh/U
X-Google-Smtp-Source: ABdhPJxz22M7+IqxvDFZpFTEAJC5z8E4FRO2wwZ2dwELY3J0ia4ULfC7jSzhJEbo9NfAS6wewgqIKA==
X-Received: by 2002:a17:906:ae88:: with SMTP id md8mr2812176ejb.323.1606304689537;
        Wed, 25 Nov 2020 03:44:49 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id nd5sm1093940ejb.37.2020.11.25.03.44.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Nov 2020 03:44:48 -0800 (PST)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ira Weiny <ira.weiny@intel.com>,
        Mike Rapoport <rppt@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Stefan Asserhall <stefan.asserhall@xilinx.com>
Subject: [PATCH] microblaze: Swap location of bss and INIT_RAM_FS
Date:   Wed, 25 Nov 2020 12:44:47 +0100
Message-Id: <60bfb194e0b9c2f80b21cf5e4b9548039c0c6eec.1606304684.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Microblaze is doing early mapping with two TLBs with 16MB each. It means
machine_early_init() with MMU ON can work just with 32MB memory max. If
kernel includes initramfs which increase kernel footprint above 32MB bss
section can't be clear and HW exception happens because memory is not
mapped.
Swapping bss section with INIT_RAM_FS ensures that bss section stays in
mapped region and bss can be cleared by machine_early_init() code.

The patch is causing hole in binary and extend binary with bss size but it
is better to apply this patch and support bigger initramfs size then 32MB
in total with kernel.

Also there is need to allocate initramfs because origin mapping is done
only to the _end symbol which stayed at the same location. The follow up
patch will explain reasons behind it.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/microblaze/include/asm/sections.h |  2 ++
 arch/microblaze/kernel/vmlinux.lds.S   | 11 +++++------
 arch/microblaze/mm/init.c              |  7 ++++++-
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/arch/microblaze/include/asm/sections.h b/arch/microblaze/include/asm/sections.h
index a9311ad84a67..b5bef96cdcd5 100644
--- a/arch/microblaze/include/asm/sections.h
+++ b/arch/microblaze/include/asm/sections.h
@@ -14,6 +14,8 @@
 extern char _ssbss[], _esbss[];
 extern unsigned long __ivt_start[], __ivt_end[];
 
+extern char __initramfs_end[];
+
 extern u32 _fdt_start[], _fdt_end[];
 
 # endif /* !__ASSEMBLY__ */
diff --git a/arch/microblaze/kernel/vmlinux.lds.S b/arch/microblaze/kernel/vmlinux.lds.S
index df07b3d06cd6..77a5e71af22f 100644
--- a/arch/microblaze/kernel/vmlinux.lds.S
+++ b/arch/microblaze/kernel/vmlinux.lds.S
@@ -120,12 +120,6 @@ SECTIONS {
 		CON_INITCALL
 	}
 
-	__init_end_before_initramfs = .;
-
-	.init.ramfs : AT(ADDR(.init.ramfs) - LOAD_OFFSET) {
-		INIT_RAM_FS
-	}
-
 	__init_end = .;
 
 	.bss ALIGN (PAGE_SIZE) : AT(ADDR(.bss) - LOAD_OFFSET) {
@@ -139,5 +133,10 @@ SECTIONS {
 	. = ALIGN(PAGE_SIZE);
 	_end = .;
 
+	.init.ramfs : AT(ADDR(.init.ramfs) - LOAD_OFFSET) {
+		INIT_RAM_FS
+	}
+	__initramfs_end = . ;
+
 	DISCARDS
 }
diff --git a/arch/microblaze/mm/init.c b/arch/microblaze/mm/init.c
index 7129a20881ea..85daa77ff061 100644
--- a/arch/microblaze/mm/init.c
+++ b/arch/microblaze/mm/init.c
@@ -197,6 +197,7 @@ static void __init mmu_init_hw(void)
 asmlinkage void __init mmu_init(void)
 {
 	unsigned int kstart, ksize;
+	phys_addr_t __maybe_unused size;
 
 	if (!memblock.reserved.cnt) {
 		pr_emerg("Error memory count\n");
@@ -238,10 +239,14 @@ asmlinkage void __init mmu_init(void)
 #if defined(CONFIG_BLK_DEV_INITRD)
 	/* Remove the init RAM disk from the available memory. */
 	if (initrd_start) {
-		unsigned long size;
 		size = initrd_end - initrd_start;
 		memblock_reserve(__virt_to_phys(initrd_start), size);
 	}
+
+	size = __initramfs_end - __initramfs_start;
+	if (size)
+		memblock_reserve((phys_addr_t)__virt_to_phys(__initramfs_start),
+				 size);
 #endif /* CONFIG_BLK_DEV_INITRD */
 
 	/* Initialize the MMU hardware */
-- 
2.29.2

