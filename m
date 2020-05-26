Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BCCC1CD118
	for <lists+linux-kernel@lfdr.de>; Mon, 11 May 2020 06:54:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728494AbgEKExi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 May 2020 00:53:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:37360 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728402AbgEKExe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 00:53:34 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97AFD208CA;
        Mon, 11 May 2020 04:53:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589172813;
        bh=3HxCBk+i1/xuyraquCNdCuSz2+rSr/9JEZRSASx8d8g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=HtzEeJ/sLW7i7ykoJ5YdZfZX6ZUKvdyUdqWrzAu+6aP/E3sX9iNpLwKK1USP7pmPZ
         ckEigyHhNLGGZ0NeWbigP07G1cOntkoOklzmgJatM9bB1p6IhF8avMAaPyKIAGF0KZ
         M8rOGIw05V65fD9JZ0Rt0SnQI01G+zj3l1NA5Ra0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, tglx@linutronix.de, bp@alien8.de,
        luto@kernel.org
Cc:     hpa@zytor.com, dave.hansen@intel.com, tony.luck@intel.com,
        ak@linux.intel.com, ravi.v.shankar@intel.com,
        chang.seok.bae@intel.com, Sasha Levin <sashal@kernel.org>,
        Vegard Nossum <vegard.nossum@oracle.com>
Subject: [PATCH v12 05/18] x86/entry/64: Switch CR3 before SWAPGS in paranoid entry
Date:   Mon, 11 May 2020 00:52:58 -0400
Message-Id: <20200511045311.4785-6-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200511045311.4785-1-sashal@kernel.org>
References: <20200511045311.4785-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Chang S. Bae" <chang.seok.bae@intel.com>

When FSGSBASE is enabled, the GS base handling in paranoid entry will need
to retrieve the kernel GS base which requires that the kernel page table is
active.

As the CR3 switch to the kernel page tables (PTI is active) does not depend
on kernel GS base, move the CR3 switch in front of the GS base handling.

Comment the EBX content while at it.

No functional change.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Tony Luck <tony.luck@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Vegard Nossum <vegard.nossum@oracle.com>
---
 arch/x86/entry/entry_64.S | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 0da56e6791b73..3ac1313724eaa 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1220,15 +1220,7 @@ SYM_CODE_START_LOCAL(paranoid_entry)
 	cld
 	PUSH_AND_CLEAR_REGS save_ret=1
 	ENCODE_FRAME_POINTER 8
-	movl	$1, %ebx
-	movl	$MSR_GS_BASE, %ecx
-	rdmsr
-	testl	%edx, %edx
-	js	1f				/* negative -> in kernel */
-	SWAPGS
-	xorl	%ebx, %ebx
 
-1:
 	/*
 	 * Always stash CR3 in %r14.  This value will be restored,
 	 * verbatim, at exit.  Needed if paranoid_entry interrupted
@@ -1238,16 +1230,31 @@ SYM_CODE_START_LOCAL(paranoid_entry)
 	 * This is also why CS (stashed in the "iret frame" by the
 	 * hardware at entry) can not be used: this may be a return
 	 * to kernel code, but with a user CR3 value.
+	 *
+	 * Switching CR3 does not depend on kernel GS base so it can
+	 * be done before switching to the kernel GS base. This is
+	 * required for FSGSBASE because the kernel GS base has to
+	 * be retrieved from a kernel internal table.
 	 */
 	SAVE_AND_SWITCH_TO_KERNEL_CR3 scratch_reg=%rax save_reg=%r14
 
+	/* EBX = 1 -> kernel GSBASE active, no restore required */
+	movl	$1, %ebx
 	/*
-	 * The above SAVE_AND_SWITCH_TO_KERNEL_CR3 macro doesn't do an
-	 * unconditional CR3 write, even in the PTI case.  So do an lfence
-	 * to prevent GS speculation, regardless of whether PTI is enabled.
+	 * The kernel-enforced convention is a negative GS base indicates
+	 * a kernel value. No SWAPGS needed on entry and exit.
 	 */
-	FENCE_SWAPGS_KERNEL_ENTRY
+	movl	$MSR_GS_BASE, %ecx
+	rdmsr
+	testl	%edx, %edx
+	jns	.Lparanoid_entry_swapgs
+	ret
 
+.Lparanoid_entry_swapgs:
+	SWAPGS
+	FENCE_SWAPGS_KERNEL_ENTRY
+	/* EBX = 0 -> SWAPGS required on exit */
+	xorl	%ebx, %ebx
 	ret
 SYM_CODE_END(paranoid_entry)
 
-- 
2.20.1

