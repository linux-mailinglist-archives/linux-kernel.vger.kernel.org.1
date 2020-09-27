Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BFF40279FF8
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Sep 2020 11:17:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726729AbgI0JRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Sep 2020 05:17:05 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:59062 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726518AbgI0JQs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Sep 2020 05:16:48 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4Bzg550xz3z9vCyC;
        Sun, 27 Sep 2020 11:16:41 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id PX7HdEtbVgSS; Sun, 27 Sep 2020 11:16:41 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4Bzg5474Rcz9vCxw;
        Sun, 27 Sep 2020 11:16:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 7AB458B771;
        Sun, 27 Sep 2020 11:16:45 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id QBExOkgAR2On; Sun, 27 Sep 2020 11:16:45 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 24A138B75B;
        Sun, 27 Sep 2020 11:16:45 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 07E6C65DE8; Sun, 27 Sep 2020 09:16:45 +0000 (UTC)
Message-Id: <0e1e18c6329b848aa3edeeba76509b4d76182e7d.1601197618.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1601197618.git.christophe.leroy@csgroup.eu>
References: <cover.1601197618.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 27/30] powerpc/vdso: Remove vdso_ready
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Sun, 27 Sep 2020 09:16:45 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no way to get out of vdso_init() prematuraly anymore.

Remove vdso_ready as it will always be 1.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/vdso.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index 14fbcc76a629..e5a9b60274ba 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -47,8 +47,6 @@
 extern char vdso32_start, vdso32_end;
 extern char vdso64_start, vdso64_end;
 
-static int vdso_ready;
-
 /*
  * The vdso data page (aka. systemcfg for old ppc64 fans) is here.
  * Once the early boot kernel code no longer needs to muck around
@@ -171,9 +169,6 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 
 	mm->context.vdso = NULL;
 
-	if (!vdso_ready)
-		return 0;
-
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
 
@@ -312,7 +307,6 @@ static int __init vdso_init(void)
 		vdso64_spec.pages = vdso_setup_pages(&vdso64_start, &vdso64_end);
 
 	smp_wmb();
-	vdso_ready = 1;
 
 	return 0;
 }
-- 
2.25.0

