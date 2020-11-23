Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 264222C0F2C
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Nov 2020 16:47:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387628AbgKWPmB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Nov 2020 10:42:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:39560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727444AbgKWPmA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Nov 2020 10:42:00 -0500
Received: from localhost.localdomain (unknown [42.120.72.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D9F472080A;
        Mon, 23 Nov 2020 15:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1606146120;
        bh=OkJ2G8OhwKYgiWV+wVeIHk5f00NcDCpYKGYROpWFFj8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BBzoE8caN1W5rpt/49LeI61b+JMMUEYmqcfkKzb6pQje5cJixZm7fpK7/c5xsYqrB
         s17eWacNj1VxpG3oYW8dukePKbcubXUXDjZ7a0PNm3u1ywUpMORABnl1EhQC0lFeLN
         o0lFPm1/He8laSaKCDBp2mkloa37H4isO4U1ZPp0=
From:   guoren@kernel.org
To:     palmerdabbelt@google.com, paul.walmsley@sifive.com,
        anup@brainfault.org, greentime.hu@sifive.com, zong.li@sifive.com,
        atish.patra@wdc.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        guoren@kernel.org, Guo Ren <guoren@linux.alibaba.com>,
        Palmer Dabbelt <palmer@sifive.com>,
        Vincent Chen <vincent.chen@sifive.com>
Subject: [PATCH 2/2] riscv: Fixup trace_hardirqs_on in entry.S
Date:   Mon, 23 Nov 2020 15:39:40 +0000
Message-Id: <1606145980-5153-2-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1606145980-5153-1-git-send-email-guoren@kernel.org>
References: <1606145980-5153-1-git-send-email-guoren@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Move trace_hardirqs_on to correct place. If SR_PIE isn't set, the
trace_hardirqs_on will cause wrong record.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Palmer Dabbelt <palmer@sifive.com>
Cc: Vincent Chen <vincent.chen@sifive.com>
---
 arch/riscv/kernel/entry.S | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 7a1a6bb..c1b38e2 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -124,17 +124,17 @@ skip_context_tracking:
 	REG_L a1, (a1)
 	jr a1
 1:
-#ifdef CONFIG_TRACE_IRQFLAGS
-	call trace_hardirqs_on
-
-	REG_L s1, PT_STATUS(sp)
-#endif
 	/*
 	 * Exceptions run with interrupts enabled or disabled depending on the
 	 * state of SR_PIE in m/sstatus.
 	 */
 	andi t0, s1, SR_PIE
 	beqz t0, 1f
+#ifdef CONFIG_TRACE_IRQFLAGS
+	call trace_hardirqs_on
+
+	REG_L s1, PT_STATUS(sp)
+#endif
 	csrs CSR_STATUS, SR_IE
 
 1:
-- 
2.7.4

