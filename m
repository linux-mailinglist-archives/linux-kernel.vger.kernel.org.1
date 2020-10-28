Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0E829D70A
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Oct 2020 23:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732085AbgJ1WUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Oct 2020 18:20:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:60526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731752AbgJ1WRo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Oct 2020 18:17:44 -0400
Received: from localhost.localdomain (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4675C24761;
        Wed, 28 Oct 2020 14:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603895476;
        bh=d2CxJ7PcRRpd8Xa3MM77L35INeEdfCk/TJcuYyD6Q5I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J4oR8XGTJP+I4PAaflZiA5Qn56OKobbYs50RIbSuyEF4FqUyxr7KO0E8U/V30CDT6
         KyLlLFQ/1Fx6grWr10dloMvtyC3PZ6W7U6QPBEkv2TCGiz1NSwk6TUsRXGEuU54CLy
         zSCjHQXsIHmw7wsU0wQGKfPsjeVMhhXQBmAidoAc=
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>, tglx@linutronix.de,
        luto@kernel.org, me@kylehuey.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        rocallahan@gmail.com, alexandre.chartre@oracle.com,
        paulmck@kernel.org, frederic@kernel.org, pbonzini@redhat.com,
        sean.j.christopherson@intel.com, pmladek@suse.com,
        joel@joelfernandes.org, rostedt@goodmis.org,
        boris.ostrovsky@oracle.com, jgross@suse.com, brgerst@gmail.com,
        jpoimboe@redhat.com, daniel.thompson@linaro.org,
        julliard@winehq.org, pgofman@codeweavers.com
Subject: [PATCH] x86/kprobes: Restore BTF if the single-stepping is cancelled
Date:   Wed, 28 Oct 2020 23:31:10 +0900
Message-Id: <160389546985.106936.12727996109376240993.stgit@devnote2>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201028211109.a25f52fa6fb0412e3a65ea52@kernel.org>
References: <20201028211109.a25f52fa6fb0412e3a65ea52@kernel.org>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix to restore BTF if single-stepping causes a page fault and
it is cancelled.

Usually the BTF flag was restored when the single stepping is done
(in resume_execution()). However, if a page fault happens on the
single stepping instruction, the fault handler is invoked and
the single stepping is cancelled. Thus, the BTF flag is not
restored.

Fixes: 1ecc798c6764 ("x86: debugctlmsr kprobes")
Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
---
 arch/x86/kernel/kprobes/core.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 547c7abb39f5..39f7d8c3c064 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -937,6 +937,11 @@ int kprobe_fault_handler(struct pt_regs *regs, int trapnr)
 		 * So clear it by resetting the current kprobe:
 		 */
 		regs->flags &= ~X86_EFLAGS_TF;
+		/*
+		 * Since the single step (trap) has been cancelled,
+		 * we need to restore BTF here.
+		 */
+		restore_btf();
 
 		/*
 		 * If the TF flag was set before the kprobe hit,

