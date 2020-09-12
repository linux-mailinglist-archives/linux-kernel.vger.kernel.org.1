Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA62267875
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Sep 2020 09:06:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725909AbgILHGQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Sep 2020 03:06:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725885AbgILHGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Sep 2020 03:06:14 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87FD0C061757
        for <linux-kernel@vger.kernel.org>; Sat, 12 Sep 2020 00:06:12 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 3ECD629C42E
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     luto@kernel.org, tglx@linutronix.de
Cc:     hpa@zytor.com, bp@alien8.de, rric@kernel.org, peterz@infradead.org,
        mingo@redhat.com, x86@kernel.org, linux-kernel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH 3/6] x86: oprofile: Avoid TIF_IA32 when checking 64bit mode
Date:   Sat, 12 Sep 2020 03:05:50 -0400
Message-Id: <20200912070553.330622-4-krisman@collabora.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200912070553.330622-1-krisman@collabora.com>
References: <20200912070553.330622-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
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

