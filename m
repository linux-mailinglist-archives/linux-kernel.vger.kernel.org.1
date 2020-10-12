Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E542128AC4C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 04:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726917AbgJLCvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Oct 2020 22:51:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:53408 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbgJLCvY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Oct 2020 22:51:24 -0400
Received: from localhost (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9E1FD2076C;
        Mon, 12 Oct 2020 02:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1602471083;
        bh=kA0MEIENIiRQUQu1eR85Jqj0jeU2eLwYDp8Phxlfv1E=;
        h=From:To:Cc:Subject:Date:From;
        b=TkftCbfUz4oKI1HBJTzqdffRR4H20+Ngki5OfYeD4Zdhxxl06s1QoJ9G358NL2lIH
         n1ybQDETtf6gdz9gIMm+1aryG3bD+WBAaHl88mJ6BshpTskp68Y7hD2nkHMI+xElLL
         TJfCB8xvc3ddxNsJ8RlNIIinNqPg1MzIur1U+yTc=
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Jessica Clarke <jrtc27@jrtc27.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH] x86/syscalls: Document the fact that syscalls 512-547 are a legacy mistake
Date:   Sun, 11 Oct 2020 19:51:21 -0700
Message-Id: <6c56fb4ddd18fc60a238eb4d867e4b3d97c6351e.1602471055.git.luto@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 6365b842aae4 ("x86/syscalls: Split the x32 syscalls
into their own table"), there is no need for special x32-specific
syscall numbers.  I forgot to update the comments in syscall_64.tbl.
Add comments to make it clear to future contributors that this range
is a legacy wart.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/entry/syscalls/syscall_64.tbl | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index f30d6ae9a688..4adb5d2a3319 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -363,10 +363,10 @@
 439	common	faccessat2		sys_faccessat2
 
 #
-# x32-specific system call numbers start at 512 to avoid cache impact
-# for native 64-bit operation. The __x32_compat_sys stubs are created
-# on-the-fly for compat_sys_*() compatibility system calls if X86_X32
-# is defined.
+# Due to a historical design error, certain syscalls are numbered differently
+# in x32 as compared to native x86_64.  These syscalls have numbers 512-547.
+# Do not add new syscalls to this range.  Numbers 548 and above are available
+# for non-x32 use.
 #
 512	x32	rt_sigaction		compat_sys_rt_sigaction
 513	x32	rt_sigreturn		compat_sys_x32_rt_sigreturn
@@ -404,3 +404,5 @@
 545	x32	execveat		compat_sys_execveat
 546	x32	preadv2			compat_sys_preadv64v2
 547	x32	pwritev2		compat_sys_pwritev64v2
+# This is the end of the legacy x32 range.  Numbers 548 and above are
+# not special and are not to be used for x32-specific syscalls.
-- 
2.26.2

