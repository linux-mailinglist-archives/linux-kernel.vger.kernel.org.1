Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 626A32B10EC
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Nov 2020 23:04:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbgKLWDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Nov 2020 17:03:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:51968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727801AbgKLWDg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Nov 2020 17:03:36 -0500
Received: from suppilovahvero.lan (83-245-197-237.elisa-laajakaista.fi [83.245.197.237])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1A9EF21D7F;
        Thu, 12 Nov 2020 22:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1605218615;
        bh=uqpHLcPZino2yEMltWpyaGARZTu7pMUqeIRcIUZbI4g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XBMixRKEVvcAe38v2xjKbIKwiYwdg0GtIBO5EnjWnvneSiqzwnobg0cCYlG/NdkzU
         sig5MFWbokoL4ro2mGeqz/l8QZG3wgyTq4O5kCg4NYI4K1k806LX33bB4FBo0DlGmK
         QAvke+LEVTgaTwQ8PPTOQnPHQlBQeazwoCkKpUXM=
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     x86@kernel.org, linux-sgx@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jethro Beekman <jethro@fortanix.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, akpm@linux-foundation.org,
        andriy.shevchenko@linux.intel.com, asapek@google.com, bp@alien8.de,
        cedric.xing@intel.com, chenalexchen@google.com,
        conradparker@google.com, cyhanish@google.com,
        dave.hansen@intel.com, haitao.huang@intel.com, kai.huang@intel.com,
        kai.svahn@intel.com, kmoy@google.com, ludloff@google.com,
        luto@kernel.org, nhorman@redhat.com, npmccallum@redhat.com,
        puiterwijk@redhat.com, rientjes@google.com, tglx@linutronix.de,
        yaozhangx@google.com, mikko.ylinen@intel.com
Subject: [PATCH v41 17/24] x86/fault: Add helper function to sanitize error code
Date:   Fri, 13 Nov 2020 00:01:28 +0200
Message-Id: <20201112220135.165028-18-jarkko@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201112220135.165028-1-jarkko@kernel.org>
References: <20201112220135.165028-1-jarkko@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Christopherson <sean.j.christopherson@intel.com>

vDSO exception fixup is a replacement for signals in limited situations.
Signals and vDSO exception fixup need to provide similar information to
userspace, including the hardware error code.

That hardware error code needs to be sanitized.  For instance, if userspace
accesses a kernel address, the error code could indicate to userspace
whether the address had a Present=1 PTE.  That can leak information about
the kernel layout to userspace, which is bad.

The existing signal code does this sanitization, but fairly late in the
signal process.  The vDSO exception code runs before the sanitization
happens.

Move error code sanitization out of the signal code and into a helper.
Call the helper in the signal code.

Acked-by: Jethro Beekman <jethro@fortanix.com> # v40
# Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
---
Changes from v39:
* Add the missing change to the set_signal_archinfo() that removes the
  snippet contained in sanitize_error_code().

 arch/x86/mm/fault.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 9339fee83784..0161d4acf3ad 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -602,11 +602,9 @@ pgtable_bad(struct pt_regs *regs, unsigned long error_code,
 	oops_end(flags, regs, sig);
 }
 
-static void set_signal_archinfo(unsigned long address,
-				unsigned long error_code)
+static void sanitize_error_code(unsigned long address,
+				unsigned long *error_code)
 {
-	struct task_struct *tsk = current;
-
 	/*
 	 * To avoid leaking information about the kernel page
 	 * table layout, pretend that user-mode accesses to
@@ -617,7 +615,13 @@ static void set_signal_archinfo(unsigned long address,
 	 * information and does not appear to cause any problems.
 	 */
 	if (address >= TASK_SIZE_MAX)
-		error_code |= X86_PF_PROT;
+		*error_code |= X86_PF_PROT;
+}
+
+static void set_signal_archinfo(unsigned long address,
+				unsigned long error_code)
+{
+	struct task_struct *tsk = current;
 
 	tsk->thread.trap_nr = X86_TRAP_PF;
 	tsk->thread.error_code = error_code | X86_PF_USER;
@@ -658,6 +662,8 @@ no_context(struct pt_regs *regs, unsigned long error_code,
 		 * faulting through the emulate_vsyscall() logic.
 		 */
 		if (current->thread.sig_on_uaccess_err && signal) {
+			sanitize_error_code(address, &error_code);
+
 			set_signal_archinfo(address, error_code);
 
 			/* XXX: hwpoison faults will set the wrong code. */
@@ -806,13 +812,7 @@ __bad_area_nosemaphore(struct pt_regs *regs, unsigned long error_code,
 		if (is_errata100(regs, address))
 			return;
 
-		/*
-		 * To avoid leaking information about the kernel page table
-		 * layout, pretend that user-mode accesses to kernel addresses
-		 * are always protection faults.
-		 */
-		if (address >= TASK_SIZE_MAX)
-			error_code |= X86_PF_PROT;
+		sanitize_error_code(address, &error_code);
 
 		if (likely(show_unhandled_signals))
 			show_signal_msg(regs, error_code, address, tsk);
@@ -931,6 +931,8 @@ do_sigbus(struct pt_regs *regs, unsigned long error_code, unsigned long address,
 	if (is_prefetch(regs, error_code, address))
 		return;
 
+	sanitize_error_code(address, &error_code);
+
 	set_signal_archinfo(address, error_code);
 
 #ifdef CONFIG_MEMORY_FAILURE
-- 
2.27.0

