Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 458F12C3171
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 20:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728844AbgKXTwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 14:52:02 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:12241 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728764AbgKXTwA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 14:52:00 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4CgZRJ6hJWz9v0DP;
        Tue, 24 Nov 2020 20:51:56 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id NXRSA4NxUpNN; Tue, 24 Nov 2020 20:51:56 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4CgZRJ5QHsz9v0DM;
        Tue, 24 Nov 2020 20:51:56 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B9BEC8B7B7;
        Tue, 24 Nov 2020 20:51:56 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 3xv1ibxVlHXJ; Tue, 24 Nov 2020 20:51:56 +0100 (CET)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7312C8B7AF;
        Tue, 24 Nov 2020 20:51:56 +0100 (CET)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 504726688D; Tue, 24 Nov 2020 19:51:56 +0000 (UTC)
Message-Id: <3907199974c89b85a3441cf3f528751173b7649c.1606247495.git.christophe.leroy@csgroup.eu>
In-Reply-To: <6470ab99e58c84a5445af43ce4d1d772b0dc3e93.1606247495.git.christophe.leroy@csgroup.eu>
References: <6470ab99e58c84a5445af43ce4d1d772b0dc3e93.1606247495.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 2/3] powerpc/32s: In add_hash_page(), calculate VSID later
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 24 Nov 2020 19:51:56 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VSID is only for create_hpte(). When _PAGE_HASHPTE is
already set, add_hash_page() bails out without calling
create_hpte() and doesn't need the value of VSID.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/mm/book3s32/hash_low.S | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/mm/book3s32/hash_low.S b/arch/powerpc/mm/book3s32/hash_low.S
index f964fd34dad9..1366e8e4fc05 100644
--- a/arch/powerpc/mm/book3s32/hash_low.S
+++ b/arch/powerpc/mm/book3s32/hash_low.S
@@ -188,12 +188,6 @@ _GLOBAL(add_hash_page)
 	mflr	r0
 	stw	r0,4(r1)
 
-	/* Convert context and va to VSID */
-	mulli	r3,r3,897*16		/* multiply context by context skew */
-	rlwinm	r0,r4,4,28,31		/* get ESID (top 4 bits of va) */
-	mulli	r0,r0,0x111		/* multiply by ESID skew */
-	add	r3,r3,r0		/* note create_hpte trims to 24 bits */
-
 #ifdef CONFIG_SMP
 	lwz	r8,TASK_CPU(r2)		/* to go in mmu_hash_lock */
 	oris	r8,r8,12
@@ -257,6 +251,12 @@ _GLOBAL(add_hash_page)
 	stwcx.	r5,0,r8
 	bne-	1b
 
+	/* Convert context and va to VSID */
+	mulli	r3,r3,897*16		/* multiply context by context skew */
+	rlwinm	r0,r4,4,28,31		/* get ESID (top 4 bits of va) */
+	mulli	r0,r0,0x111		/* multiply by ESID skew */
+	add	r3,r3,r0		/* note create_hpte trims to 24 bits */
+
 	bl	create_hpte
 
 9:
-- 
2.25.0

