Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 165E02F128D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 13:47:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbhAKMqr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 07:46:47 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:17427 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727194AbhAKMqn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 07:46:43 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DDtjb44Q9z9v02S;
        Mon, 11 Jan 2021 13:45:55 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id iHXubzjdrXRk; Mon, 11 Jan 2021 13:45:55 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DDtjb2969z9v02Q;
        Mon, 11 Jan 2021 13:45:55 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 32CCC8B793;
        Mon, 11 Jan 2021 13:46:00 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id egCJXb3j-2lo; Mon, 11 Jan 2021 13:46:00 +0100 (CET)
Received: from localhost.localdomain (po15451.idsi0.si.c-s.fr [172.25.230.103])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D91938B78E;
        Mon, 11 Jan 2021 13:45:59 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id D013066978; Mon, 11 Jan 2021 12:45:59 +0000 (UTC)
Message-Id: <674c9799fffa2022c1a8671898d958e81f19422a.1610369143.git.christophe.leroy@csgroup.eu>
In-Reply-To: <8c74fc9ce8131cabb10b3e95dc0e430f396ee83e.1610369143.git.christophe.leroy@csgroup.eu>
References: <8c74fc9ce8131cabb10b3e95dc0e430f396ee83e.1610369143.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH 2/3] powerpc: Merge __put_user_size_allowed() into
 __put_user_size()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, cmr@codefail.de
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 11 Jan 2021 12:45:59 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__put_user_size_allowed() is only called from __put_user_size() now.

Merge them together.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/uaccess.h | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index 6e97616e03e8..f1df444bfb04 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -110,22 +110,18 @@ static inline bool __access_ok(unsigned long addr, unsigned long size)
 
 extern long __put_user_bad(void);
 
-#define __put_user_size_allowed(x, ptr, size, retval)		\
+#define __put_user_size(x, ptr, size, retval)			\
 do {								\
 	__label__ __pu_failed;					\
 								\
 	retval = 0;						\
+	allow_write_to_user(ptr, size);				\
 	__put_user_size_goto(x, ptr, size, __pu_failed);	\
+	prevent_write_to_user(ptr, size);			\
 	break;							\
 								\
 __pu_failed:							\
 	retval = -EFAULT;					\
-} while (0)
-
-#define __put_user_size(x, ptr, size, retval)			\
-do {								\
-	allow_write_to_user(ptr, size);				\
-	__put_user_size_allowed(x, ptr, size, retval);		\
 	prevent_write_to_user(ptr, size);			\
 } while (0)
 
-- 
2.25.0

