Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 743692A34A1
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 20:54:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbgKBTyd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Nov 2020 14:54:33 -0500
Received: from mail.kernel.org ([198.145.29.99]:39330 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727145AbgKBTyF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Nov 2020 14:54:05 -0500
Received: from localhost (c-67-180-165-146.hsd1.ca.comcast.net [67.180.165.146])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7A9052225E;
        Mon,  2 Nov 2020 19:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604346844;
        bh=XSKqsn3P2/pXv/MCbKfRw59VxuoIrUSEkA+QHvC1urI=;
        h=From:To:Cc:Subject:Date:From;
        b=C65vDUFHBMWfeWycrASThmwyc1A4ZuKeBz9o7K1SMK8F6XuZTnJKsdQWUBnmdEscZ
         Owae24HwhDTm8OvKN08Z+833e1Y+yWXQS6WkXj8PJ5tlPbrv+W6BmuE67o6QqWuS6c
         1OAO1fyJQwLeJcxMFr/6shNzfDPfnElEC/ij8E+o=
From:   Andy Lutomirski <luto@kernel.org>
To:     x86@kernel.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>
Subject: [PATCH] selftests/x86: Use __builtin_ia32_read/writeeflags
Date:   Mon,  2 Nov 2020 11:54:02 -0800
Message-Id: <aee4b1cdfc56083eb779ce927b7d3459aad2af76.1604346818.git.luto@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The asm to read and write EFLAGS from userspace is horrible.  The
compiler builtins are now available on all supported compilers, so
use them instead.

(The compiler builtins are also unnecessarily ugly, but that's a
 more manageable level of ugliness.)

Signed-off-by: Andy Lutomirski <luto@kernel.org>
---
 tools/testing/selftests/x86/helpers.h | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/x86/helpers.h b/tools/testing/selftests/x86/helpers.h
index f5ff2a2615df..4ef42c4559a9 100644
--- a/tools/testing/selftests/x86/helpers.h
+++ b/tools/testing/selftests/x86/helpers.h
@@ -6,36 +6,20 @@
 
 static inline unsigned long get_eflags(void)
 {
-	unsigned long eflags;
-
-	asm volatile (
 #ifdef __x86_64__
-		"subq $128, %%rsp\n\t"
-		"pushfq\n\t"
-		"popq %0\n\t"
-		"addq $128, %%rsp"
+	return __builtin_ia32_readeflags_u64();
 #else
-		"pushfl\n\t"
-		"popl %0"
+	return __builtin_ia32_readeflags_u32();
 #endif
-		: "=r" (eflags) :: "memory");
-
-	return eflags;
 }
 
 static inline void set_eflags(unsigned long eflags)
 {
-	asm volatile (
 #ifdef __x86_64__
-		"subq $128, %%rsp\n\t"
-		"pushq %0\n\t"
-		"popfq\n\t"
-		"addq $128, %%rsp"
+	__builtin_ia32_writeeflags_u64(eflags);
 #else
-		"pushl %0\n\t"
-		"popfl"
+	__builtin_ia32_writeeflags_u32(eflags);
 #endif
-		:: "r" (eflags) : "flags", "memory");
 }
 
 #endif /* __SELFTESTS_X86_HELPERS_H */
-- 
2.28.0

