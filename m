Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2FDF327A87D
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Sep 2020 09:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726607AbgI1HXY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Sep 2020 03:23:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:47548 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726380AbgI1HXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Sep 2020 03:23:22 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601277800;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=havTeoYgtA9GOaGDzgKjIxi/dmZGW3kqKm8c6KarYTo=;
        b=ONoKqcfCVPWB2DzQiCrHuYXldj7uqgN/7g+ue7/BdCmWiEYtNyEeVpS0zFU6ER37FNun5b
        2sL9yXWxXiiqyPPFubYBMiNmCJ0s55nhnZozjKlBdyks3EIH5UMY6ebHUWiXC/+S2MOkCN
        qnUAdNxlG+QiYocrhQXloz5z3S2opaQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-74-4xxCT4aVNn6bNpBVcK882g-1; Mon, 28 Sep 2020 03:23:17 -0400
X-MC-Unique: 4xxCT4aVNn6bNpBVcK882g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 580551005504;
        Mon, 28 Sep 2020 07:23:16 +0000 (UTC)
Received: from gshan.redhat.com (vpn2-54-128.bne.redhat.com [10.64.54.128])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4738E7848B;
        Mon, 28 Sep 2020 07:23:14 +0000 (UTC)
From:   Gavin Shan <gshan@redhat.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, mark.rutland@arm.com,
        anshuman.khandual@arm.com, robin.murphy@arm.com,
        catalin.marinas@arm.com, will@kernel.org, shan.gavin@gmail.com
Subject: [PATCH v3 1/2] arm64/mm: Introduce zero PGD table
Date:   Mon, 28 Sep 2020 17:22:55 +1000
Message-Id: <20200928072256.13098-2-gshan@redhat.com>
In-Reply-To: <20200928072256.13098-1-gshan@redhat.com>
References: <20200928072256.13098-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The zero PGD table is used when TTBR_EL1 is changed. It's exactly
the zero page. As the zero page(s) will be allocated dynamically
when colored zero page feature is enabled in subsequent patch. the
zero page(s) aren't usable during early boot stage.

This introduces zero PGD table, which is decoupled from the zero
page(s).

Signed-off-by: Gavin Shan <gshan@redhat.com>
---
 arch/arm64/include/asm/mmu_context.h | 6 +++---
 arch/arm64/include/asm/pgtable.h     | 2 ++
 arch/arm64/kernel/setup.c            | 2 +-
 arch/arm64/kernel/vmlinux.lds.S      | 4 ++++
 arch/arm64/mm/proc.S                 | 2 +-
 5 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/mmu_context.h b/arch/arm64/include/asm/mmu_context.h
index f2d7537d6f83..6dbc5726fd56 100644
--- a/arch/arm64/include/asm/mmu_context.h
+++ b/arch/arm64/include/asm/mmu_context.h
@@ -36,11 +36,11 @@ static inline void contextidr_thread_switch(struct task_struct *next)
 }
 
 /*
- * Set TTBR0 to empty_zero_page. No translations will be possible via TTBR0.
+ * Set TTBR0 to zero_pg_dir. No translations will be possible via TTBR0.
  */
 static inline void cpu_set_reserved_ttbr0(void)
 {
-	unsigned long ttbr = phys_to_ttbr(__pa_symbol(empty_zero_page));
+	unsigned long ttbr = phys_to_ttbr(__pa_symbol(zero_pg_dir));
 
 	write_sysreg(ttbr, ttbr0_el1);
 	isb();
@@ -189,7 +189,7 @@ static inline void update_saved_ttbr0(struct task_struct *tsk,
 		return;
 
 	if (mm == &init_mm)
-		ttbr = __pa_symbol(empty_zero_page);
+		ttbr = __pa_symbol(zero_pg_dir);
 	else
 		ttbr = virt_to_phys(mm->pgd) | ASID(mm) << 48;
 
diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
index d5d3fbe73953..6953498f4d40 100644
--- a/arch/arm64/include/asm/pgtable.h
+++ b/arch/arm64/include/asm/pgtable.h
@@ -474,6 +474,8 @@ static inline bool pud_table(pud_t pud) { return true; }
 				 PUD_TYPE_TABLE)
 #endif
 
+extern pgd_t zero_pg_dir[PTRS_PER_PGD];
+extern pgd_t zero_pg_end[];
 extern pgd_t init_pg_dir[PTRS_PER_PGD];
 extern pgd_t init_pg_end[];
 extern pgd_t swapper_pg_dir[PTRS_PER_PGD];
diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index 53acbeca4f57..7e83eaed641e 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -366,7 +366,7 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
 	 * faults in case uaccess_enable() is inadvertently called by the init
 	 * thread.
 	 */
-	init_task.thread_info.ttbr0 = __pa_symbol(empty_zero_page);
+	init_task.thread_info.ttbr0 = __pa_symbol(zero_pg_dir);
 #endif
 
 	if (boot_args[1] || boot_args[2] || boot_args[3]) {
diff --git a/arch/arm64/kernel/vmlinux.lds.S b/arch/arm64/kernel/vmlinux.lds.S
index 7cba7623fcec..3d3c155d10a4 100644
--- a/arch/arm64/kernel/vmlinux.lds.S
+++ b/arch/arm64/kernel/vmlinux.lds.S
@@ -137,6 +137,10 @@ SECTIONS
 	/* everything from this point to __init_begin will be marked RO NX */
 	RO_DATA(PAGE_SIZE)
 
+	zero_pg_dir = .;
+	. += PAGE_SIZE;
+	zero_pg_end = .;
+
 	idmap_pg_dir = .;
 	. += IDMAP_DIR_SIZE;
 	idmap_pg_end = .;
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 796e47a571e6..90b135c366b3 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -163,7 +163,7 @@ SYM_FUNC_END(cpu_do_resume)
 	.pushsection ".idmap.text", "awx"
 
 .macro	__idmap_cpu_set_reserved_ttbr1, tmp1, tmp2
-	adrp	\tmp1, empty_zero_page
+	adrp	\tmp1, zero_pg_dir
 	phys_to_ttbr \tmp2, \tmp1
 	offset_ttbr1 \tmp2, \tmp1
 	msr	ttbr1_el1, \tmp2
-- 
2.23.0

