Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAF6E2848F2
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 11:05:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbgJFJFe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 05:05:34 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:23981 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725891AbgJFJFd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 05:05:33 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4C5BQ06pGGz9tyfM;
        Tue,  6 Oct 2020 11:05:28 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id y2ldzfHjWUF4; Tue,  6 Oct 2020 11:05:28 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4C5BQ05l2rz9tyfQ;
        Tue,  6 Oct 2020 11:05:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id ECA1D8B7C7;
        Tue,  6 Oct 2020 11:05:27 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 4yQoLA5Np6I4; Tue,  6 Oct 2020 11:05:27 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4AE288B7C3;
        Tue,  6 Oct 2020 11:05:26 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 1AB5B65DE8; Tue,  6 Oct 2020 09:05:26 +0000 (UTC)
Message-Id: <319d379f696412681c66a987cc75e6abf8f958d2.1601975100.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH 1/2] powerpc/32s: Rename head_32.S to head_book3s_32.S
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue,  6 Oct 2020 09:05:26 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unlike PPC64 which had a single head_64.S, PPC32 are multiple ones.
There is the head_32.S, selected by default based on the value of BITS
and overridden based on some CONFIG_ values. This leads to thinking
that it may be selected by different types of PPC32 platform but
indeed it ends up being selected by book3s/32 only.

Make that explicit by:
- Not doing any default selection based on BITS.
- Renaming head_32.S to head_book3s_32.S.
- Get head_book3s_32.S selected only by CONFIG_PPC_BOOK3S_32.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/Makefile                        | 3 ++-
 arch/powerpc/kernel/{head_32.S => head_book3s_32.S} | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)
 rename arch/powerpc/kernel/{head_32.S => head_book3s_32.S} (99%)

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index a5550c2b24c4..bf0bf1b900d2 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -95,7 +95,8 @@ obj-$(CONFIG_PPC_FSL_BOOK3E)	+= cpu_setup_fsl_booke.o
 obj-$(CONFIG_PPC_DOORBELL)	+= dbell.o
 obj-$(CONFIG_JUMP_LABEL)	+= jump_label.o
 
-extra-y				:= head_$(BITS).o
+extra-$(CONFIG_PPC64)		:= head_64.o
+extra-$(CONFIG_PPC_BOOK3S_32)	:= head_book3s_32.o
 extra-$(CONFIG_40x)		:= head_40x.o
 extra-$(CONFIG_44x)		:= head_44x.o
 extra-$(CONFIG_FSL_BOOKE)	:= head_fsl_booke.o
diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_book3s_32.S
similarity index 99%
rename from arch/powerpc/kernel/head_32.S
rename to arch/powerpc/kernel/head_book3s_32.S
index 35627693c2a4..e07a2c07ffe4 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_book3s_32.S
@@ -61,7 +61,7 @@
 
 	__HEAD
 	.stabs	"arch/powerpc/kernel/",N_SO,0,0,0f
-	.stabs	"head_32.S",N_SO,0,0,0f
+	.stabs	"head_book3s_32.S",N_SO,0,0,0f
 0:
 _ENTRY(_stext);
 
-- 
2.25.0

