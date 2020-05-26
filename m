Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 232CF1AFB74
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Apr 2020 16:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbgDSOlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Apr 2020 10:41:04 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:34139 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725793AbgDSOlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 10:41:02 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04357;MF=laijs@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0Tw-JNwa_1587307259;
Received: from localhost(mailfrom:laijs@linux.alibaba.com fp:SMTPD_---0Tw-JNwa_1587307259)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 19 Apr 2020 22:40:59 +0800
From:   Lai Jiangshan <laijs@linux.alibaba.com>
To:     linux-kernel@vger.kernel.org
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 3/3] x86/entry: remove an unused label
Date:   Sun, 19 Apr 2020 14:40:49 +0000
Message-Id: <20200419144049.1906-4-laijs@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200419144049.1906-1-laijs@linux.alibaba.com>
References: <20200419144049.1906-1-laijs@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The label .Lcommon_\sym was introduced by 39e9543344fa.
(x86-64: Reduce amount of redundant code generated for invalidate_interruptNN)
And all the other relevant information was removed by 52aec3308db8
(x86/tlb: replace INVALIDATE_TLB_VECTOR by CALL_FUNCTION_VECTOR)

Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
---
 arch/x86/entry/entry_64.S | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index b789835afbab..7d40d1034358 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -798,7 +798,6 @@ _ASM_NOKPROBE(common_interrupt)
 SYM_CODE_START(\sym)
 	UNWIND_HINT_IRET_REGS
 	pushq	$~(\num)
-.Lcommon_\sym:
 	call	interrupt_entry
 	UNWIND_HINT_REGS indirect=1
 	call	\do_sym	/* rdi points to pt_regs */
-- 
2.20.1

