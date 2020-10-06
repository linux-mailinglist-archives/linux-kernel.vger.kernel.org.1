Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D261285029
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 18:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726002AbgJFQuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 12:50:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:33410 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725769AbgJFQuU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 12:50:20 -0400
Received: from localhost.localdomain (89.208.247.74.16clouds.com [89.208.247.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A67FB206DD;
        Tue,  6 Oct 2020 16:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602003019;
        bh=fUDOPjppDFzL87N9Dd1uJ0Zglfzl2ngSEmYFW2hqeck=;
        h=From:To:Cc:Subject:Date:From;
        b=UZAVeNEYd9XfC/QRn/EDII23lJPw4vwE3gtJnkVy9XlEDGbsQCGdwkdM6gexm1eY/
         XU1QQ6nBLRbOzCosJS6vhN67eVOrLdwi4+or/zvb4evQG0NjwaBayH5W/ARHW0KhUr
         RLII8DvytlrmPR6RSg0m2jfB9QkSICEWrpO9y3JI=
From:   guoren@kernel.org
To:     palmerdabbelt@google.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>,
        Atish Patra <atishp@atishpatra.org>,
        Andreas Schwab <schwab@linux-m68k.org>
Subject: [PATCH] riscv: Fixup bootup failure with HARDENED_USERCOPY
Date:   Tue,  6 Oct 2020 16:49:33 +0000
Message-Id: <1602002973-92934-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

As Aurelien has reported:

[    3.484586] AppArmor: AppArmor sha1 policy hashing enabled
[    4.749835] Freeing unused kernel memory: 492K
[    4.752017] Run /init as init process
[    4.753571] usercopy: Kernel memory overwrite attempt detected to kernel text (offset 507879, size 11)!
[    4.754838] ------------[ cut here ]------------
[    4.755651] kernel BUG at mm/usercopy.c:99!
[    4.756445] Kernel BUG [#1]
[    4.756815] Modules linked in:
[    4.757542] CPU: 1 PID: 1 Comm: swapper/0 Not tainted 5.8.0-1-riscv64 #1 Debian 5.8.7-1
[    4.758372] epc: ffffffe0003b5120 ra : ffffffe0003b5120 sp : ffffffe07f783ca0
[    4.758960]  gp : ffffffe000cc7230 tp : ffffffe07f77cec0 t0 : ffffffe000cdafc0
[    4.759772]  t1 : 0000000000000064 t2 : 0000000000000000 s0 : ffffffe07f783cf0
[    4.760534]  s1 : ffffffe00095d780 a0 : 000000000000005b a1 : 0000000000000020
[    4.761309]  a2 : 0000000000000005 a3 : 0000000000000000 a4 : ffffffe000c1f340
[    4.761848]  a5 : ffffffe000c1f340 a6 : 0000000000000000 a7 : 0000000000000087
[    4.762684]  s2 : ffffffe000941848 s3 : 000000000007bfe7 s4 : 000000000000000b
[    4.763500]  s5 : 0000000000000000 s6 : ffffffe00091cc00 s7 : fffffffffffff000
[    4.764376]  s8 : 0000003ffffff000 s9 : ffffffe0769f3200 s10: 000000000000000b
[    4.765208]  s11: ffffffe07d548c40 t3 : 0000000000000000 t4 : 000000000001dcd0
[    4.766059]  t5 : ffffffe000cc8510 t6 : ffffffe000cd64aa
[    4.766712] status: 0000000000000120 badaddr: 0000000000000000 cause: 0000000000000003
[    4.768308] ---[ end trace 1f8e733e834d4c3e ]---
[    4.769129] Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b
[    4.770070] SMP: stopping secondary CPUs
[    4.771110] ---[ end Kernel panic - not syncing: Attempted to kill init! exitcode=0x0000000b ]---

Above failure is relate to commit: a0fa4027dc911 (riscv: Fixup
static_obj() fail). When we expand static_obj include INIT_DATA,
we also include INIT_TEXT into usercopy check kernel text:

/* Is this address range in the kernel text area? */
static inline void check_kernel_text_object(const unsigned long ptr,
                                            unsigned long n, bool to_user)
{
        unsigned long textlow = (unsigned long)_stext;
        unsigned long texthigh = (unsigned long)_etext;
        unsigned long textlow_linear, texthigh_linear;

        if (overlaps(ptr, n, textlow, texthigh))
                usercopy_abort("kernel text", NULL, to_user, ptr - textlow, n);

When INIT_TEXT/DATA are freed, new allocation will reuse these
memory and overlaps check will be triggered.

The patch met static_obj and check_kernel_text_object requirements.

Link: https://lore.kernel.org/linux-riscv/1593266228-61125-1-git-send-email-guoren@kernel.org/T/#t
Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Reported-by: Aurelien Jarno <aurelien@aurel32.net>
Tested-by: Aurelien Jarno <aurelien@aurel32.net>
Cc: Palmer Dabbelt <palmerdabbelt@google.com>
Cc: Atish Patra <atishp@atishpatra.org>
Cc: Andreas Schwab <schwab@linux-m68k.org>
---
 arch/riscv/kernel/vmlinux.lds.S | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
index f3586e3..34d00d9 100644
--- a/arch/riscv/kernel/vmlinux.lds.S
+++ b/arch/riscv/kernel/vmlinux.lds.S
@@ -22,13 +22,11 @@ SECTIONS
 	/* Beginning of code and text segment */
 	. = LOAD_OFFSET;
 	_start = .;
-	_stext = .;
 	HEAD_TEXT_SECTION
 	. = ALIGN(PAGE_SIZE);
 
 	__init_begin = .;
 	INIT_TEXT_SECTION(PAGE_SIZE)
-	INIT_DATA_SECTION(16)
 	. = ALIGN(8);
 	__soc_early_init_table : {
 		__soc_early_init_table_start = .;
@@ -55,6 +53,7 @@ SECTIONS
 	. = ALIGN(SECTION_ALIGN);
 	.text : {
 		_text = .;
+		_stext = .;
 		TEXT_TEXT
 		SCHED_TEXT
 		CPUIDLE_TEXT
@@ -67,6 +66,8 @@ SECTIONS
 		_etext = .;
 	}
 
+	INIT_DATA_SECTION(16)
+
 	/* Start of data section */
 	_sdata = .;
 	RO_DATA(SECTION_ALIGN)
-- 
2.7.4

