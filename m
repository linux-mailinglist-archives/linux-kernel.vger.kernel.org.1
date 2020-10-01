Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CC1B2808EB
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 23:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733050AbgJAU7g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 16:59:36 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:41212 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726515AbgJAU7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 16:59:35 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 4D5D229D10A
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     luto@kernel.org, tglx@linutronix.de
Cc:     hch@lst.de, hpa@zytor.com, bp@alien8.de, rric@kernel.org,
        peterz@infradead.org, mingo@redhat.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, dave.hansen@linux.intel.com,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v2 3/9] x86: oprofile: Avoid TIF_IA32 when checking 64bit mode
Date:   Thu,  1 Oct 2020 16:58:13 -0400
Message-Id: <20201001205819.27879-4-krisman@collabora.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201001205819.27879-1-krisman@collabora.com>
References: <20201001205819.27879-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to remove TIF_IA32, stop using it in oprofile code.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 arch/x86/oprofile/backtrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/oprofile/backtrace.c b/arch/x86/oprofile/backtrace.c
index a2488b6e27d6..1d8391fcca68 100644
--- a/arch/x86/oprofile/backtrace.c
+++ b/arch/x86/oprofile/backtrace.c
@@ -49,7 +49,7 @@ x86_backtrace_32(struct pt_regs * const regs, unsigned int depth)
 	struct stack_frame_ia32 *head;
 
 	/* User process is IA32 */
-	if (!current || !test_thread_flag(TIF_IA32))
+	if (!current || user_64bit_mode(regs))
 		return 0;
 
 	head = (struct stack_frame_ia32 *) regs->bp;
-- 
2.28.0

