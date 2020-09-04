Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18CFC25D6FC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 13:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730097AbgIDLEl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 07:04:41 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:62465 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729969AbgIDLBp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 07:01:45 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BjZVg41TDzB09bR;
        Fri,  4 Sep 2020 13:01:31 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 0YGbt2hKdpg2; Fri,  4 Sep 2020 13:01:31 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BjZVg2mZyzB09bP;
        Fri,  4 Sep 2020 13:01:31 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9D3E88B81C;
        Fri,  4 Sep 2020 13:01:32 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id WBmm3Nj24kyR; Fri,  4 Sep 2020 13:01:32 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [10.25.210.31])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6C9C28B81B;
        Fri,  4 Sep 2020 13:01:32 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id EECE4653FF; Fri,  4 Sep 2020 11:01:31 +0000 (UTC)
Message-Id: <b9745b122f4a9ae72cef445c61320022ab8b77b7.1599216721.git.christophe.leroy@csgroup.eu>
In-Reply-To: <94ba5a5138f99522e1562dbcdb38d31aa790dc89.1599216721.git.christophe.leroy@csgroup.eu>
References: <94ba5a5138f99522e1562dbcdb38d31aa790dc89.1599216721.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH 2/3] powerpc/uaccess: Switch __patch_instruction() to
 __put_user_asm_goto()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri,  4 Sep 2020 11:01:31 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

__patch_instruction() is the only user of __put_user_asm() outside
of asm/uaccess.h

Switch to the new __put_user_asm_goto() to enable retirement of
__put_user_asm() in a later patch.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/lib/code-patching.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
index 8c3934ea6220..2333625b5e31 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -21,21 +21,18 @@
 static int __patch_instruction(struct ppc_inst *exec_addr, struct ppc_inst instr,
 			       struct ppc_inst *patch_addr)
 {
-	int err = 0;
-
-	if (!ppc_inst_prefixed(instr)) {
-		__put_user_asm(ppc_inst_val(instr), patch_addr, err, "stw");
-	} else {
-		__put_user_asm(ppc_inst_as_u64(instr), patch_addr, err, "std");
-	}
-
-	if (err)
-		return err;
+	if (!ppc_inst_prefixed(instr))
+		__put_user_asm_goto(ppc_inst_val(instr), patch_addr, failed, "stw");
+	else
+		__put_user_asm_goto(ppc_inst_as_u64(instr), patch_addr, failed, "std");
 
 	asm ("dcbst 0, %0; sync; icbi 0,%1; sync; isync" :: "r" (patch_addr),
 							    "r" (exec_addr));
 
 	return 0;
+
+failed:
+	return -EFAULT;
 }
 
 int raw_patch_instruction(struct ppc_inst *addr, struct ppc_inst instr)
-- 
2.25.0

