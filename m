Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11C8E2935F1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Oct 2020 09:40:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405316AbgJTHkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Oct 2020 03:40:19 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:27408 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728102AbgJTHkM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Oct 2020 03:40:12 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4CFls43Vd4z9tydK;
        Tue, 20 Oct 2020 09:40:08 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id HWMKYT5FxUBc; Tue, 20 Oct 2020 09:40:08 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4CFls40KhWz9tydG;
        Tue, 20 Oct 2020 09:40:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0FBE78B7CB;
        Tue, 20 Oct 2020 09:40:09 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id mQk_exHtjAxz; Tue, 20 Oct 2020 09:40:08 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9A7988B767;
        Tue, 20 Oct 2020 09:40:08 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 7F32F667B6; Tue, 20 Oct 2020 07:40:08 +0000 (UTC)
Message-Id: <3132ca9560e41676551491407b6be851045f69e3.1603179582.git.christophe.leroy@csgroup.eu>
In-Reply-To: <212d3bc4a52ca71523759517bb9c61f7e477c46a.1603179582.git.christophe.leroy@csgroup.eu>
References: <212d3bc4a52ca71523759517bb9c61f7e477c46a.1603179582.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 2/3] powerpc: Fix incorrect stw{, ux, u, x} instructions in
 __set_pte_at
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        mathieu.desnoyers@efficios.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 20 Oct 2020 07:40:08 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>

The placeholder for instruction selection should use the second
argument's operand, which is %1, not %0. This could generate incorrect
assembly code if the memory addressing of operand %0 is a different
form from that of operand %1.

Fixes: 9bf2b5cdc5fe ("powerpc: Fixes for CONFIG_PTE_64BIT for SMP support")
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Kumar Gala <galak@kernel.crashing.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.ozlabs.org
Cc: <stable@vger.kernel.org> # v2.6.28+
Acked-by: Segher Boessenkool <segher@kernel.crashing.org>
[chleroy: revised commit log iaw segher's comment]
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v2: Changed commit log.
---
 arch/powerpc/include/asm/book3s/32/pgtable.h | 2 +-
 arch/powerpc/include/asm/nohash/pgtable.h    | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
index 36443cda8dcf..34f5ca391f0c 100644
--- a/arch/powerpc/include/asm/book3s/32/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
@@ -524,7 +524,7 @@ static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
 	__asm__ __volatile__("\
 		stw%U0%X0 %2,%0\n\
 		eieio\n\
-		stw%U0%X0 %L2,%1"
+		stw%U1%X1 %L2,%1"
 	: "=m" (*ptep), "=m" (*((unsigned char *)ptep+4))
 	: "r" (pte) : "memory");
 
diff --git a/arch/powerpc/include/asm/nohash/pgtable.h b/arch/powerpc/include/asm/nohash/pgtable.h
index 4b7c3472eab1..a00e4c1746d6 100644
--- a/arch/powerpc/include/asm/nohash/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/pgtable.h
@@ -199,7 +199,7 @@ static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
 		__asm__ __volatile__("\
 			stw%U0%X0 %2,%0\n\
 			eieio\n\
-			stw%U0%X0 %L2,%1"
+			stw%U1%X1 %L2,%1"
 		: "=m" (*ptep), "=m" (*((unsigned char *)ptep+4))
 		: "r" (pte) : "memory");
 		return;
-- 
2.25.0

