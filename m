Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FEED3026A4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jan 2021 16:03:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729839AbhAYO4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jan 2021 09:56:14 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:59781 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729804AbhAYOvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 09:51:11 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4DPXmM1S0cz9v0H2;
        Mon, 25 Jan 2021 15:48:19 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id wKoxq-m24lo1; Mon, 25 Jan 2021 15:48:18 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4DPXmL62tpz9v0Gh;
        Mon, 25 Jan 2021 15:48:18 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5DD098B79E;
        Mon, 25 Jan 2021 15:48:24 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id DZyPrzK22Omg; Mon, 25 Jan 2021 15:48:24 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.103])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3834C8B79B;
        Mon, 25 Jan 2021 15:48:24 +0100 (CET)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 2D49766AD8; Mon, 25 Jan 2021 14:48:24 +0000 (UTC)
Message-Id: <ff9dd4accdc897013594768833d54444e4823bf9.1611585031.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1611585031.git.christophe.leroy@csgroup.eu>
References: <cover.1611585031.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v4 11/23] powerpc/syscall: Rename syscall_64.c into syscall.c
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        msuchanek@suse.de
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 25 Jan 2021 14:48:24 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syscall_64.c will be reused almost as is for PPC32.

Rename it syscall.c

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/Makefile                    | 2 +-
 arch/powerpc/kernel/{syscall_64.c => syscall.c} | 0
 2 files changed, 1 insertion(+), 1 deletion(-)
 rename arch/powerpc/kernel/{syscall_64.c => syscall.c} (100%)

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index fe2ef598e2ea..1cbc51fc82fd 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -49,7 +49,7 @@ obj-y				:= cputable.o syscalls.o \
 				   hw_breakpoint_constraints.o
 obj-y				+= ptrace/
 obj-$(CONFIG_PPC64)		+= setup_64.o \
-				   paca.o nvram_64.o note.o syscall_64.o
+				   paca.o nvram_64.o note.o syscall.o
 obj-$(CONFIG_COMPAT)		+= sys_ppc32.o signal_32.o
 obj-$(CONFIG_VDSO32)		+= vdso32/
 obj-$(CONFIG_PPC_WATCHDOG)	+= watchdog.o
diff --git a/arch/powerpc/kernel/syscall_64.c b/arch/powerpc/kernel/syscall.c
similarity index 100%
rename from arch/powerpc/kernel/syscall_64.c
rename to arch/powerpc/kernel/syscall.c
-- 
2.25.0

