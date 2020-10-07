Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E63752861D2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 17:09:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727765AbgJGPJ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 11:09:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:50606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727608AbgJGPJ1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 11:09:27 -0400
Received: from localhost.localdomain (89.208.247.74.16clouds.com [89.208.247.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12F0D20797;
        Wed,  7 Oct 2020 15:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602083366;
        bh=ue48qs9GmEev9xcyNZPMQmpU0ksnr3ttGA99FAlJ2uw=;
        h=From:To:Cc:Subject:Date:From;
        b=WSu15+dlN2JP7df3PziufzZRGpBKyUde1uJwJgq1GJJBU01R+cu7UGB7SH1+FzCOz
         l+dP9iQudbkVbaW0eji2GP08amEFv5yjWzj4cESavSeE7xuzGqbLsw3tC9V+KNDtF2
         qtXql4qvqqvER79nz12DWA7+UH62/8KAphJ0QS2g=
From:   guoren@kernel.org
To:     palmerdabbelt@google.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        atishp@atishpatra.org, schwab@linux-m68k.org, aurelien@aurel32.net,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH 1/2] Revert "riscv: Fixup static_obj() fail"
Date:   Wed,  7 Oct 2020 15:08:32 +0000
Message-Id: <1602083313-19239-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

This reverts commit 6184358da0004c8fd940afda6c0a0fa4027dc911.

It will cause bootup failure with HARDENED_USERCOPY.

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

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Reported-by: Aurelien Jarno <aurelien@aurel32.net>
Cc: Palmer Dabbelt <palmerdabbelt@google.com>
Cc: Atish Patra <atishp@atishpatra.org>
Cc: Andreas Schwab <schwab@linux-m68k.org>
---
 arch/riscv/kernel/vmlinux.lds.S | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/riscv/kernel/vmlinux.lds.S b/arch/riscv/kernel/vmlinux.lds.S
index f3586e3..e6f8016 100644
--- a/arch/riscv/kernel/vmlinux.lds.S
+++ b/arch/riscv/kernel/vmlinux.lds.S
@@ -22,7 +22,6 @@ SECTIONS
 	/* Beginning of code and text segment */
 	. = LOAD_OFFSET;
 	_start = .;
-	_stext = .;
 	HEAD_TEXT_SECTION
 	. = ALIGN(PAGE_SIZE);
 
@@ -55,6 +54,7 @@ SECTIONS
 	. = ALIGN(SECTION_ALIGN);
 	.text : {
 		_text = .;
+		_stext = .;
 		TEXT_TEXT
 		SCHED_TEXT
 		CPUIDLE_TEXT
-- 
2.7.4

