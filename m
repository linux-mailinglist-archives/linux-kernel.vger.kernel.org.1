Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BD191CBBC5
	for <lists+linux-kernel@lfdr.de>; Sat,  9 May 2020 02:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728388AbgEIAZh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 May 2020 20:25:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:57908 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727959AbgEIAZh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 May 2020 20:25:37 -0400
Received: from localhost (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F137B21582;
        Sat,  9 May 2020 00:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588983937;
        bh=Ei2JHTi4sdU47AkE85V7sekI2RjA21qxjX5dG12CqXg=;
        h=From:To:Cc:Subject:Date:From;
        b=0MgInU9qDOkt3AK2ILhu+1PvhrX4LhiF2GDYvxjwCeYjLPfIJUZS83dQ6c0P0M+fi
         JxSqkeB1dc9IeRSKUSX+cLDYxYrD/+74ifmZwa0ePXvfIcETou1kdgBiZ0dJPpLqws
         trmdf+PlmMKacFPp8eFQBB378BeUaAaY5dvT/QEU=
From:   Andy Lutomirski <luto@kernel.org>
To:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thorsten Glaser <t.glaser@tarent.de>, stable@kernel.org
Subject: [PATCH] Revert "x86/syscalls: Make __X32_SYSCALL_BIT be unsigned long"
Date:   Fri,  8 May 2020 17:25:32 -0700
Message-Id: <92e55442b744a5951fdc9cfee10badd0a5f7f828.1588983892.git.luto@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 45e29d119e9923ff14dfb840e3482bef1667bbfb and
adds a comment to discourage someone else from making the same
mistake again.

It turns out that some user code fails to compile if
__X32_SYSCALL_BIT is unsigned long.  See, for example:

https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=954294

Reported-by: Thorsten Glaser <t.glaser@tarent.de>
Fixes: 45e29d119e99 ("x86/syscalls: Make __X32_SYSCALL_BIT be unsigned long")
Cc: stable@kernel.org
Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 arch/x86/include/uapi/asm/unistd.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/uapi/asm/unistd.h b/arch/x86/include/uapi/asm/unistd.h
index 196fdd02b8b1..be5e2e747f50 100644
--- a/arch/x86/include/uapi/asm/unistd.h
+++ b/arch/x86/include/uapi/asm/unistd.h
@@ -2,8 +2,15 @@
 #ifndef _UAPI_ASM_X86_UNISTD_H
 #define _UAPI_ASM_X86_UNISTD_H
 
-/* x32 syscall flag bit */
-#define __X32_SYSCALL_BIT	0x40000000UL
+/*
+ * x32 syscall flag bit.  Some user programs expect syscall NR macros
+ * and __X32_SYSCALL_BIT to have type int, even though syscall numbers
+ * are, for practical purposes, unsigned long.
+ *
+ * Fortunately, expressions like (nr & ~__X32_SYSCALL_BIT) do the right
+ * thing regardless.
+ */
+#define __X32_SYSCALL_BIT	0x40000000
 
 #ifndef __KERNEL__
 # ifdef __i386__
-- 
2.25.4

