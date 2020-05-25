Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09CFD1E1052
	for <lists+linux-kernel@lfdr.de>; Mon, 25 May 2020 16:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390984AbgEYOSi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 May 2020 10:18:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:59264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388714AbgEYOSh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 10:18:37 -0400
Received: from localhost.localdomain (unknown [42.120.72.90])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A1A2B208A7;
        Mon, 25 May 2020 14:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590416317;
        bh=boEYvuFZgzF1dk665cIlE8LztYbfHpvHAl5Gif5KGSo=;
        h=From:To:Cc:Subject:Date:From;
        b=ZHENXbnG2hbFsP3eU5DBavKi06wsIU3kamBYuvdPB1hknyqZr08kLrGHRWfnzmJ44
         QRW5TIbyDVQGJjj3o19wCxeijWwgSHTAH7VR5tMAh21HUQMpJ7Jb8csW17v2WmxZV3
         hjAWLGkVy1honrNkHtkrCDqSDQmdm4f9KDoZTBKU=
From:   guoren@kernel.org
To:     tycho@tycho.ws, keescook@chromium.org, palmerdabbelt@google.com,
        paul.walmsley@sifive.com, anup@brainfault.org
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Guo Ren <guoren@linux.alibaba.com>
Subject: [PATCH] riscv: Remove unnecessary path for syscall_trace
Date:   Mon, 25 May 2020 14:18:26 +0000
Message-Id: <1590416306-66453-1-git-send-email-guoren@kernel.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

Obviously, there is no need to recover a0-a7 in reject path.

Previous modification is from commit af33d243 by Tycho, to
fixup seccomp reject syscall code path.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Cc: Tycho Andersen <tycho@tycho.ws>
Cc: Kees Cook <keescook@chromium.org>
Cc: Palmer Dabbelt <palmerdabbelt@google.com>
---
 arch/riscv/kernel/entry.S | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/riscv/kernel/entry.S b/arch/riscv/kernel/entry.S
index 56d071b..ea3444d 100644
--- a/arch/riscv/kernel/entry.S
+++ b/arch/riscv/kernel/entry.S
@@ -306,7 +306,7 @@ work_resched:
 handle_syscall_trace_enter:
 	move a0, sp
 	call do_syscall_trace_enter
-	move t0, a0
+	bnez a0, ret_from_syscall_rejected
 	REG_L a0, PT_A0(sp)
 	REG_L a1, PT_A1(sp)
 	REG_L a2, PT_A2(sp)
@@ -315,7 +315,6 @@ handle_syscall_trace_enter:
 	REG_L a5, PT_A5(sp)
 	REG_L a6, PT_A6(sp)
 	REG_L a7, PT_A7(sp)
-	bnez t0, ret_from_syscall_rejected
 	j check_syscall_nr
 handle_syscall_trace_exit:
 	move a0, sp
-- 
2.7.4

