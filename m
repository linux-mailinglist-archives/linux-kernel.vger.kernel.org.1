Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 381AC2C8BAE
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 18:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387684AbgK3Rtb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 12:49:31 -0500
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:56129 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729230AbgK3Rta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 12:49:30 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R341e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=rongwei.wang@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0UH3N1OB_1606758525;
Received: from localhost.localdomain(mailfrom:rongwei.wang@linux.alibaba.com fp:SMTPD_---0UH3N1OB_1606758525)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 01 Dec 2020 01:48:46 +0800
From:   Rongwei Wang <rongwei.wang@linux.alibaba.com>
To:     catalin.marinas@arm.com, will@kernel.org,
        bjorn.andersson@linaro.org, shawnguo@kernel.org
Cc:     vkoul@kernel.org, geert+renesas@glider.be, Anson.Huang@nxp.com,
        michael@walle.cc, krzk@kernel.org, olof@lixom.net,
        vincenzo.frascino@arm.com, ardb@kernel.org, masahiroy@kernel.org,
        gshan@redhat.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] arm64:insn: Export symbols for MSR ARM driver
Date:   Tue,  1 Dec 2020 01:48:31 +0800
Message-Id: <20201130174833.41315-2-rongwei.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201130174833.41315-1-rongwei.wang@linux.alibaba.com>
References: <20201130174833.41315-1-rongwei.wang@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to use the MSR-ARM driver in module and built-in ways, we need export
following symbols.

The MSR-ARM driver depends on function aarch64_insn_patch_text to modify the
text at runtime, and function aarch64_insn_read to read one instruction in the
specified address.

In addition, we need register_undef_hook and unregister_undef_hook to handle
the low probability undefined exception which triggered only by MSR-ARM driver.

Signed-off-by: Rongwei Wang <rongwei.wang@linux.alibaba.com>
---
 arch/arm64/kernel/insn.c  | 2 ++
 arch/arm64/kernel/traps.c | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm64/kernel/insn.c b/arch/arm64/kernel/insn.c
index 6c0de2f..67a1f78 100644
--- a/arch/arm64/kernel/insn.c
+++ b/arch/arm64/kernel/insn.c
@@ -135,6 +135,7 @@ int __kprobes aarch64_insn_read(void *addr, u32 *insnp)
 
 	return ret;
 }
+EXPORT_SYMBOL(aarch64_insn_read);
 
 static int __kprobes __aarch64_insn_write(void *addr, __le32 insn)
 {
@@ -247,6 +248,7 @@ int __kprobes aarch64_insn_patch_text(void *addrs[], u32 insns[], int cnt)
 	return stop_machine_cpuslocked(aarch64_insn_patch_text_cb, &patch,
 				       cpu_online_mask);
 }
+EXPORT_SYMBOL(aarch64_insn_patch_text);
 
 static int __kprobes aarch64_get_imm_shift_mask(enum aarch64_insn_imm_type type,
 						u32 *maskp, int *shiftp)
diff --git a/arch/arm64/kernel/traps.c b/arch/arm64/kernel/traps.c
index 8af4e0e..c76efa5 100644
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -292,6 +292,7 @@ void register_undef_hook(struct undef_hook *hook)
 	list_add(&hook->node, &undef_hook);
 	raw_spin_unlock_irqrestore(&undef_lock, flags);
 }
+EXPORT_SYMBOL(register_undef_hook);
 
 void unregister_undef_hook(struct undef_hook *hook)
 {
@@ -301,6 +302,7 @@ void unregister_undef_hook(struct undef_hook *hook)
 	list_del(&hook->node);
 	raw_spin_unlock_irqrestore(&undef_lock, flags);
 }
+EXPORT_SYMBOL(unregister_undef_hook);
 
 static int call_undef_hook(struct pt_regs *regs)
 {
-- 
1.8.3.1

