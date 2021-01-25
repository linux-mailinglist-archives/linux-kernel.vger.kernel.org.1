Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8D40303D2A
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 13:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403892AbhAZKOW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 05:14:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731296AbhAYTV0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 14:21:26 -0500
Received: from mail-qt1-x835.google.com (mail-qt1-x835.google.com [IPv6:2607:f8b0:4864:20::835])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27560C061794
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 11:19:40 -0800 (PST)
Received: by mail-qt1-x835.google.com with SMTP id t14so6905921qto.8
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jan 2021 11:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=soleen.com; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=zFOq/S9iOYCDWpf61SwLzKvAyTai8NEIz55jjvM4EVM=;
        b=ckXcD39ZeMZdTbgyZrKYzdjdsYWAcQx3VmO7mRxHypwrmjO4e8B0MSbG5sIlFuDpa7
         W3rCPkP3Lgu5Lzz/yrTN4X+QZex8zNY8KP5B82WyOu1kph3LCamxEBXe58RAj4qI1vFl
         niZ2GvFNe2pz6XjLG5sXaa5Q9jjgPm4je/lUH3YbWKZmkGCn8Bh4Yn7/P+MYmvbJ4ox8
         ldCHR7bGVIxMH69hJwYJjb377KZXnzdMapSbUePN+4ASS1+puTtcdF7qmAlfiIhpsqXC
         upgE85LngJaiKuGgdKWtSgT3qxYdiRFPh4vC1yi7clw7nnSYUT2JEVyJExz/S4Qk0CcJ
         0Bug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zFOq/S9iOYCDWpf61SwLzKvAyTai8NEIz55jjvM4EVM=;
        b=KXaOlO6FQNSlAV1Cu4smEzLgLF/p1Lh4xvUFVd4xLvY6fmosXPyxfNrVT4Dw8ls3oA
         87azpvyZpL8FOxrXnDttt0/DvbvEMwN43ecnOMzIyrQipS6H0G07OQI3pfjWJeDLw0mi
         teD3B9bP/lSLqgE3BoQ4+6isRGrLmZEpuAOwsnMji95/Zzxya1rshbnZJF6W+iG7eMbG
         REx+4xW4DHac9ZmGGoZcSgaYszrb6oW/bgloK+D8Ng68SscwE6IGegP8+PZRmjKHP0xC
         1b5lR4e2VsQ5wnxPFHXPEto+wegszUrN/QMxegt4tb5O2dwtlQaeeggBPcyKiMM++Azu
         oExw==
X-Gm-Message-State: AOAM531lUiPIr5keavYgT8Tv9y7e2wf9I5Bn0/Fu+9wD/fphMFS/peEx
        +JWRX+V0LfOGVXF1mfLi/XyKMw==
X-Google-Smtp-Source: ABdhPJzOtp3LRX+RA164VIS3opw37sa157PwXQZoQIDOfXAj8170m0WLiADo7/egWOhgpbrd6Sy/vg==
X-Received: by 2002:ac8:57c1:: with SMTP id w1mr1954928qta.313.1611602379388;
        Mon, 25 Jan 2021 11:19:39 -0800 (PST)
Received: from localhost.localdomain (c-73-69-118-222.hsd1.nh.comcast.net. [73.69.118.222])
        by smtp.gmail.com with ESMTPSA id s6sm9047638qtx.63.2021.01.25.11.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 11:19:38 -0800 (PST)
From:   Pavel Tatashin <pasha.tatashin@soleen.com>
To:     pasha.tatashin@soleen.com, jmorris@namei.org, sashal@kernel.org,
        ebiederm@xmission.com, kexec@lists.infradead.org,
        linux-kernel@vger.kernel.org, corbet@lwn.net,
        catalin.marinas@arm.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org, maz@kernel.org,
        james.morse@arm.com, vladimir.murzin@arm.com,
        matthias.bgg@gmail.com, linux-mm@kvack.org, mark.rutland@arm.com,
        steve.capper@arm.com, rfontana@redhat.com, tglx@linutronix.de,
        selindag@gmail.com, tyhicks@linux.microsoft.com
Subject: [PATCH v10 09/18] arm64: kexec: move relocation function setup
Date:   Mon, 25 Jan 2021 14:19:14 -0500
Message-Id: <20210125191923.1060122-10-pasha.tatashin@soleen.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210125191923.1060122-1-pasha.tatashin@soleen.com>
References: <20210125191923.1060122-1-pasha.tatashin@soleen.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, kernel relocation function is configured in machine_kexec()
at the time of kexec reboot by using control_code_page.

This operation, however, is more logical to be done during kexec_load,
and thus remove from reboot time. Move, setup of this function to
newly added machine_kexec_post_load().

Because once MMU is enabled, kexec control page will contain more than
relocation kernel, but also vector table, add pointer to the actual
function within this page arch.kern_reloc. Currently, it equals to the
beginning of page, we will add offsets later, when vector table is
added.

Signed-off-by: Pavel Tatashin <pasha.tatashin@soleen.com>
Reviewed-by: James Morse <james.morse@arm.com>
---
 arch/arm64/include/asm/kexec.h    |  1 +
 arch/arm64/kernel/machine_kexec.c | 46 +++++++++++++------------------
 2 files changed, 20 insertions(+), 27 deletions(-)

diff --git a/arch/arm64/include/asm/kexec.h b/arch/arm64/include/asm/kexec.h
index 61530ec3a9b1..9befcd87e9a8 100644
--- a/arch/arm64/include/asm/kexec.h
+++ b/arch/arm64/include/asm/kexec.h
@@ -95,6 +95,7 @@ static inline void crash_post_resume(void) {}
 struct kimage_arch {
 	void *dtb;
 	phys_addr_t dtb_mem;
+	phys_addr_t kern_reloc;
 	/* Core ELF header buffer */
 	void *elf_headers;
 	unsigned long elf_headers_mem;
diff --git a/arch/arm64/kernel/machine_kexec.c b/arch/arm64/kernel/machine_kexec.c
index 8096a6aa1d49..a8aaa6562429 100644
--- a/arch/arm64/kernel/machine_kexec.c
+++ b/arch/arm64/kernel/machine_kexec.c
@@ -42,6 +42,7 @@ static void _kexec_image_info(const char *func, int line,
 	pr_debug("    start:       %lx\n", kimage->start);
 	pr_debug("    head:        %lx\n", kimage->head);
 	pr_debug("    nr_segments: %lu\n", kimage->nr_segments);
+	pr_debug("    kern_reloc: %pa\n", &kimage->arch.kern_reloc);
 
 	for (i = 0; i < kimage->nr_segments; i++) {
 		pr_debug("      segment[%lu]: %016lx - %016lx, 0x%lx bytes, %lu pages\n",
@@ -58,6 +59,22 @@ void machine_kexec_cleanup(struct kimage *kimage)
 	/* Empty routine needed to avoid build errors. */
 }
 
+int machine_kexec_post_load(struct kimage *kimage)
+{
+	void *reloc_code = page_to_virt(kimage->control_code_page);
+
+	memcpy(reloc_code, arm64_relocate_new_kernel,
+	       arm64_relocate_new_kernel_size);
+	kimage->arch.kern_reloc = __pa(reloc_code);
+
+	/* Flush the reloc_code in preparation for its execution. */
+	__flush_dcache_area(reloc_code, arm64_relocate_new_kernel_size);
+	flush_icache_range((uintptr_t)reloc_code, (uintptr_t)reloc_code +
+			   arm64_relocate_new_kernel_size);
+
+	return 0;
+}
+
 /**
  * machine_kexec_prepare - Prepare for a kexec reboot.
  *
@@ -143,8 +160,6 @@ static void kexec_segment_flush(const struct kimage *kimage)
  */
 void machine_kexec(struct kimage *kimage)
 {
-	phys_addr_t reboot_code_buffer_phys;
-	void *reboot_code_buffer;
 	bool in_kexec_crash = (kimage == kexec_crash_image);
 	bool stuck_cpus = cpus_are_stuck_in_kernel();
 
@@ -155,31 +170,8 @@ void machine_kexec(struct kimage *kimage)
 	WARN(in_kexec_crash && (stuck_cpus || smp_crash_stop_failed()),
 		"Some CPUs may be stale, kdump will be unreliable.\n");
 
-	reboot_code_buffer_phys = page_to_phys(kimage->control_code_page);
-	reboot_code_buffer = phys_to_virt(reboot_code_buffer_phys);
-
 	kexec_image_info(kimage);
 
-	/*
-	 * Copy arm64_relocate_new_kernel to the reboot_code_buffer for use
-	 * after the kernel is shut down.
-	 */
-	memcpy(reboot_code_buffer, arm64_relocate_new_kernel,
-		arm64_relocate_new_kernel_size);
-
-	/* Flush the reboot_code_buffer in preparation for its execution. */
-	__flush_dcache_area(reboot_code_buffer, arm64_relocate_new_kernel_size);
-
-	/*
-	 * Although we've killed off the secondary CPUs, we don't update
-	 * the online mask if we're handling a crash kernel and consequently
-	 * need to avoid flush_icache_range(), which will attempt to IPI
-	 * the offline CPUs. Therefore, we must use the __* variant here.
-	 */
-	__flush_icache_range((uintptr_t)reboot_code_buffer,
-			     (uintptr_t)reboot_code_buffer +
-			     arm64_relocate_new_kernel_size);
-
 	/* Flush the kimage list and its buffers. */
 	kexec_list_flush(kimage);
 
@@ -193,7 +185,7 @@ void machine_kexec(struct kimage *kimage)
 
 	/*
 	 * cpu_soft_restart will shutdown the MMU, disable data caches, then
-	 * transfer control to the reboot_code_buffer which contains a copy of
+	 * transfer control to the kern_reloc which contains a copy of
 	 * the arm64_relocate_new_kernel routine.  arm64_relocate_new_kernel
 	 * uses physical addressing to relocate the new image to its final
 	 * position and transfers control to the image entry point when the
@@ -203,7 +195,7 @@ void machine_kexec(struct kimage *kimage)
 	 * userspace (kexec-tools).
 	 * In kexec_file case, the kernel starts directly without purgatory.
 	 */
-	cpu_soft_restart(reboot_code_buffer_phys, kimage->head, kimage->start,
+	cpu_soft_restart(kimage->arch.kern_reloc, kimage->head, kimage->start,
 			 kimage->arch.dtb_mem);
 
 	BUG(); /* Should never get here. */
-- 
2.25.1

