Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1C9C28AF92
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 10:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728856AbgJLICd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 04:02:33 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:28260 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726492AbgJLICc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 04:02:32 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4C8rkT4dbwz9typT;
        Mon, 12 Oct 2020 10:02:25 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 9HWd4hggHV4o; Mon, 12 Oct 2020 10:02:25 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4C8rkT3cpKz9typR;
        Mon, 12 Oct 2020 10:02:25 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8C2408B789;
        Mon, 12 Oct 2020 10:02:30 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id n-ogDPEvuRDP; Mon, 12 Oct 2020 10:02:30 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.100])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 217898B788;
        Mon, 12 Oct 2020 10:02:30 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 123EC66441; Mon, 12 Oct 2020 08:02:30 +0000 (UTC)
Message-Id: <e26ddc1d6f6aca739dd8d2b7c67351ead559b084.1602489664.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] powerpc/mm: Remove useless #ifndef CPU_FTR_COHERENT_ICACHE in
 mem.c
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 12 Oct 2020 08:02:30 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 10b35d9978ac ("[PATCH] powerpc: merged asm/cputable.h"),
CPU_FTR_COHERENT_ICACHE has always been defined.

Remove the #ifndef CPU_FTR_COHERENT_ICACHE block.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/mm/mem.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index b7586d8c835b..2708d40c38e4 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -53,11 +53,6 @@
 
 #include <mm/mmu_decl.h>
 
-#ifndef CPU_FTR_COHERENT_ICACHE
-#define CPU_FTR_COHERENT_ICACHE	0	/* XXX for now */
-#define CPU_FTR_NOEXECUTE	0
-#endif
-
 unsigned long long memory_limit;
 bool init_mem_is_free;
 
-- 
2.25.0

