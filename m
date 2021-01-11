Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22F3F2F128B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 13:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbhAKMqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 07:46:44 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:7973 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727113AbhAKMqn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 07:46:43 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DDtjY61Tyz9v02P;
        Mon, 11 Jan 2021 13:45:53 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id flsZkM5S4mty; Mon, 11 Jan 2021 13:45:53 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DDtjY57wJz9v02R;
        Mon, 11 Jan 2021 13:45:53 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2B76D8B791;
        Mon, 11 Jan 2021 13:45:59 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id WTqNKj9scYew; Mon, 11 Jan 2021 13:45:59 +0100 (CET)
Received: from localhost.localdomain (po15451.idsi0.si.c-s.fr [172.25.230.103])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EE6728B78E;
        Mon, 11 Jan 2021 13:45:58 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id C32B166978; Mon, 11 Jan 2021 12:45:58 +0000 (UTC)
Message-Id: <8c74fc9ce8131cabb10b3e95dc0e430f396ee83e.1610369143.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH 1/3] powerpc: get rid of small constant size cases in
 raw_copy_{to,from}_user()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, cmr@codefail.de
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 11 Jan 2021 12:45:58 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Copied from commit 4b842e4e25b1 ("x86: get rid of small
constant size cases in raw_copy_{to,from}_user()")

Very few call sites where that would be triggered remain, and none
of those is anywhere near hot enough to bother.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/uaccess.h | 45 ------------------------------
 1 file changed, 45 deletions(-)

diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index 501c9a79038c..6e97616e03e8 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -407,30 +407,6 @@ static inline unsigned long raw_copy_from_user(void *to,
 		const void __user *from, unsigned long n)
 {
 	unsigned long ret;
-	if (__builtin_constant_p(n) && (n <= 8)) {
-		ret = 1;
-
-		switch (n) {
-		case 1:
-			barrier_nospec();
-			__get_user_size(*(u8 *)to, from, 1, ret);
-			break;
-		case 2:
-			barrier_nospec();
-			__get_user_size(*(u16 *)to, from, 2, ret);
-			break;
-		case 4:
-			barrier_nospec();
-			__get_user_size(*(u32 *)to, from, 4, ret);
-			break;
-		case 8:
-			barrier_nospec();
-			__get_user_size(*(u64 *)to, from, 8, ret);
-			break;
-		}
-		if (ret == 0)
-			return 0;
-	}
 
 	barrier_nospec();
 	allow_read_from_user(from, n);
@@ -442,27 +418,6 @@ static inline unsigned long raw_copy_from_user(void *to,
 static inline unsigned long
 raw_copy_to_user_allowed(void __user *to, const void *from, unsigned long n)
 {
-	if (__builtin_constant_p(n) && (n <= 8)) {
-		unsigned long ret = 1;
-
-		switch (n) {
-		case 1:
-			__put_user_size_allowed(*(u8 *)from, (u8 __user *)to, 1, ret);
-			break;
-		case 2:
-			__put_user_size_allowed(*(u16 *)from, (u16 __user *)to, 2, ret);
-			break;
-		case 4:
-			__put_user_size_allowed(*(u32 *)from, (u32 __user *)to, 4, ret);
-			break;
-		case 8:
-			__put_user_size_allowed(*(u64 *)from, (u64 __user *)to, 8, ret);
-			break;
-		}
-		if (ret == 0)
-			return 0;
-	}
-
 	return __copy_tofrom_user(to, (__force const void __user *)from, n);
 }
 
-- 
2.25.0

