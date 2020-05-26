Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F9DA1C76F9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 May 2020 18:48:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730515AbgEFQsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 May 2020 12:48:37 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:56659 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730418AbgEFQsS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 12:48:18 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 49HMwb0z8Xz9v4kJ;
        Wed,  6 May 2020 18:48:15 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 0ripaQKRQceS; Wed,  6 May 2020 18:48:15 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 49HMwb0Cnhz9v4kF;
        Wed,  6 May 2020 18:48:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id D56F88B7C5;
        Wed,  6 May 2020 18:48:16 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id flrb3IfwgV-6; Wed,  6 May 2020 18:48:16 +0200 (CEST)
Received: from localhost.localdomain (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7FCA48B7C3;
        Wed,  6 May 2020 18:48:16 +0200 (CEST)
Received: by localhost.localdomain (Postfix, from userid 0)
        id 4FCD965911; Wed,  6 May 2020 16:48:16 +0000 (UTC)
Message-Id: <a2e03189c968f8eaa833dd96f04d572e0d6c8b1a.1588783498.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1588783498.git.christophe.leroy@csgroup.eu>
References: <cover.1588783498.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 11/45] powerpc/ptdump: Standardise display of BAT flags
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed,  6 May 2020 16:48:16 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Display BAT flags the same way as page flags: rwx and wimg

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/mm/ptdump/bats.c | 37 ++++++++++++++---------------------
 1 file changed, 15 insertions(+), 22 deletions(-)

diff --git a/arch/powerpc/mm/ptdump/bats.c b/arch/powerpc/mm/ptdump/bats.c
index d6c660f63d71..cebb58c7e289 100644
--- a/arch/powerpc/mm/ptdump/bats.c
+++ b/arch/powerpc/mm/ptdump/bats.c
@@ -15,12 +15,12 @@
 static char *pp_601(int k, int pp)
 {
 	if (pp == 0)
-		return k ? "NA" : "RWX";
+		return k ? "   " : "rwx";
 	if (pp == 1)
-		return k ? "ROX" : "RWX";
+		return k ? "r x" : "rwx";
 	if (pp == 2)
-		return k ? "RWX" : "RWX";
-	return k ? "ROX" : "ROX";
+		return "rwx";
+	return "r x";
 }
 
 static void bat_show_601(struct seq_file *m, int idx, u32 lower, u32 upper)
@@ -48,12 +48,9 @@ static void bat_show_601(struct seq_file *m, int idx, u32 lower, u32 upper)
 
 	seq_printf(m, "Kernel %s User %s", pp_601(k & 2, pp), pp_601(k & 1, pp));
 
-	if (lower & _PAGE_WRITETHRU)
-		seq_puts(m, "write through ");
-	if (lower & _PAGE_NO_CACHE)
-		seq_puts(m, "no cache ");
-	if (lower & _PAGE_COHERENT)
-		seq_puts(m, "coherent ");
+	seq_puts(m, lower & _PAGE_WRITETHRU ? "w " : "  ");
+	seq_puts(m, lower & _PAGE_NO_CACHE ? "i " : "  ");
+	seq_puts(m, lower & _PAGE_COHERENT ? "m " : "  ");
 	seq_puts(m, "\n");
 }
 
@@ -101,20 +98,16 @@ static void bat_show_603(struct seq_file *m, int idx, u32 lower, u32 upper, bool
 		seq_puts(m, "Kernel/User ");
 
 	if (lower & BPP_RX)
-		seq_puts(m, is_d ? "RO " : "EXEC ");
+		seq_puts(m, is_d ? "r   " : "  x ");
 	else if (lower & BPP_RW)
-		seq_puts(m, is_d ? "RW " : "EXEC ");
+		seq_puts(m, is_d ? "rw  " : "  x ");
 	else
-		seq_puts(m, is_d ? "NA " : "NX   ");
-
-	if (lower & _PAGE_WRITETHRU)
-		seq_puts(m, "write through ");
-	if (lower & _PAGE_NO_CACHE)
-		seq_puts(m, "no cache ");
-	if (lower & _PAGE_COHERENT)
-		seq_puts(m, "coherent ");
-	if (lower & _PAGE_GUARDED)
-		seq_puts(m, "guarded ");
+		seq_puts(m, is_d ? "    " : "    ");
+
+	seq_puts(m, lower & _PAGE_WRITETHRU ? "w " : "  ");
+	seq_puts(m, lower & _PAGE_NO_CACHE ? "i " : "  ");
+	seq_puts(m, lower & _PAGE_COHERENT ? "m " : "  ");
+	seq_puts(m, lower & _PAGE_GUARDED ? "g " : "  ");
 	seq_puts(m, "\n");
 }
 
-- 
2.25.0

