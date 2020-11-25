Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5D3B2C3F42
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Nov 2020 12:45:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729016AbgKYLnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Nov 2020 06:43:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727019AbgKYLnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Nov 2020 06:43:39 -0500
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EA9BC0613D4
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 03:43:39 -0800 (PST)
Received: by mail-ej1-x642.google.com with SMTP id a16so2576170ejj.5
        for <linux-kernel@vger.kernel.org>; Wed, 25 Nov 2020 03:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20150623.gappssmtp.com; s=20150623;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uYW3ZyaJyuAmKuXf5dlEGYJicsrMLw0K8nGNNOQ9xuA=;
        b=RhMw1e6bw5aXjInrXmMzy1SvrHNIAZmVJyKYltyb49y6t3syp0WXKC92YEJC3FMI0e
         jo9j8R7TdPmJulBBVXhFgPHvK3/mj89KZ9/WzMYS7Ax5RZQAIFmKCFokqDv6Zgy4f2eU
         iRf0akmv00Svesj0EwgCq6ySy6KsP5LkWTjT3fUr4J9rudfsmCAU+zPVlbAvsQWBz5+A
         Lujg8R46m3wkfH+IZ75aywdYZQ63Q9r1GqzpWDAWE1e1m8t+jn0lRTUCUE/J3GVUimvC
         mz+GYqSm5QYlchuZLxSq5AomEqaAZo90eI/bFRc9MgH1ifHajELGbXxnhhVv29JWETHC
         aOzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=uYW3ZyaJyuAmKuXf5dlEGYJicsrMLw0K8nGNNOQ9xuA=;
        b=IFYr52ZDvV/Pot04aErplNzCtMzZW33ehPa+0WZc+tOyu4Q0ni0u13+QxKHMBnHomk
         k5equwuabAD+Js5vniw91HsPXpwMQ6a1IATUlpt/j+z0iJ0ptzy0XR3JH+FEaxCApdT+
         n0QGeIEHBVTu1TkCPqbXZWHYhdnFR45juimTe1ASCVmNScB0xOH3XVV6lIV49Iso3I9/
         vlKGu5Flqii5xhx7yFyZsdjlF2Tvia26nPmFplQa1L+GMISjmFsOLM32EtMPCwrjGysy
         1c0W6aRDgeJ1C5dnskFLVebEmMiHgIYCCnW8ftTfZgIohzutRv7MVLAjyWTBpWn5RPxm
         KJYw==
X-Gm-Message-State: AOAM531cNNa04yRHzhQTLEWumDutKQjZjgT+D1LIxG5TTaKG1w8ZQviu
        EjDx+2eN0ZBVL4YMdRNYIge2RmmiB98OSHsQ
X-Google-Smtp-Source: ABdhPJzC8A6yN0rI4+FgU/srqVe/JRg/miHmwUKtEUaHwtmM5LT24danwHSxHE4gq1/yCPvqrqidZg==
X-Received: by 2002:a17:906:3bd6:: with SMTP id v22mr2788314ejf.160.1606304617511;
        Wed, 25 Nov 2020 03:43:37 -0800 (PST)
Received: from localhost (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id a12sm1081117edu.89.2020.11.25.03.43.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 25 Nov 2020 03:43:36 -0800 (PST)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Stefan Asserhall <stefan.asserhall@xilinx.com>
Subject: [PATCH] microblaze: Change TLB mapping and free space allocation
Date:   Wed, 25 Nov 2020 12:43:35 +0100
Message-Id: <af2fd524563dc374d3ecc7ac75af1b23f64cb739.1606304612.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Microblaze is doing initial TLB mapping (max 32MB) which has to include
BSS section but also some space for early page allocation which are used
for lowmem page mapping done by mapin_ram()->map_page()->early_get_page().
Max size is 768MB in current setup. For mapping this size there is a need
for 768M / 4K / 1024 = 192 PTE pages (size 0xc0000). There could be also
need for other pages to be mapped that's why 1MB space is added behind
_end. (Pad was 0xC0000 but it is not enough for big initramfs).

Linux kernel maps TLBs between _text and _end_tlb_mapping. And also reserve
memory between _text and _end for kernel itself. Initrd or initramfs is
mapped below. That's why there is all the time gap between _end and
__initramfs_start covered by TLB which can be used for early page
allocation.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

 arch/microblaze/include/asm/sections.h | 1 +
 arch/microblaze/kernel/head.S          | 3 +--
 arch/microblaze/kernel/vmlinux.lds.S   | 4 ++++
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/microblaze/include/asm/sections.h b/arch/microblaze/include/asm/sections.h
index b5bef96cdcd5..9da44d048522 100644
--- a/arch/microblaze/include/asm/sections.h
+++ b/arch/microblaze/include/asm/sections.h
@@ -15,6 +15,7 @@ extern char _ssbss[], _esbss[];
 extern unsigned long __ivt_start[], __ivt_end[];
 
 extern char __initramfs_end[];
+extern char _end_tlb_mapping[];
 
 extern u32 _fdt_start[], _fdt_end[];
 
diff --git a/arch/microblaze/kernel/head.S b/arch/microblaze/kernel/head.S
index ec2fcb545e64..a2502f78dceb 100644
--- a/arch/microblaze/kernel/head.S
+++ b/arch/microblaze/kernel/head.S
@@ -173,9 +173,8 @@ _invalidate:
 	tophys(r4,r3)			/* Load the kernel physical address */
 
 	/* start to do TLB calculation */
-	addik	r12, r0, _end
+	addik	r12, r0, _end_tlb_mapping
 	rsub	r12, r3, r12
-	addik	r12, r12, CONFIG_LOWMEM_SIZE >> PTE_SHIFT /* that's the pad */
 
 	or r9, r0, r0 /* TLB0 = 0 */
 	or r10, r0, r0 /* TLB1 = 0 */
diff --git a/arch/microblaze/kernel/vmlinux.lds.S b/arch/microblaze/kernel/vmlinux.lds.S
index 77a5e71af22f..8a446c257094 100644
--- a/arch/microblaze/kernel/vmlinux.lds.S
+++ b/arch/microblaze/kernel/vmlinux.lds.S
@@ -132,6 +132,10 @@ SECTIONS {
 	}
 	. = ALIGN(PAGE_SIZE);
 	_end = .;
+	/* Add space in TLB mapping for early free pages mapping */
+	. = . + 0x100000; /* CONFIG_LOWMEM_SIZE >> PTE_SHIFT + space */
+
+	_end_tlb_mapping = . ;
 
 	.init.ramfs : AT(ADDR(.init.ramfs) - LOAD_OFFSET) {
 		INIT_RAM_FS
-- 
2.29.2

