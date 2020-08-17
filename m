Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 56A57245C17
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Aug 2020 07:47:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgHQFqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Aug 2020 01:46:44 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:15037 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726314AbgHQFqn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 01:46:43 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BVNMc45Qvz9tydn;
        Mon, 17 Aug 2020 07:46:36 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 5TgBxdVF7ca0; Mon, 17 Aug 2020 07:46:36 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BVNMc37DLz9tytl;
        Mon, 17 Aug 2020 07:46:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5383F8B772;
        Mon, 17 Aug 2020 07:46:41 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id JHF2S-j_s4A9; Mon, 17 Aug 2020 07:46:41 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.104])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 176C18B75B;
        Mon, 17 Aug 2020 07:46:41 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 13D6F65CDD; Mon, 17 Aug 2020 05:46:41 +0000 (UTC)
Message-Id: <ac8da0e3baa91dda805e1e492fd65aecd90c1fb5.1597643156.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1] powerpc/process: Replace an #ifdef CONFIG_PPC_47x by
 IS_ENABLED()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 17 Aug 2020 05:46:41 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

isync() is always defined, no need for an #ifdef.

Replace it by IS_ENABLED(CONFIG_PPC_47x).

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/process.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index e86e28c28259..fd3e11663613 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -777,9 +777,8 @@ static void switch_hw_breakpoint(struct task_struct *new)
 static inline int __set_dabr(unsigned long dabr, unsigned long dabrx)
 {
 	mtspr(SPRN_DAC1, dabr);
-#ifdef CONFIG_PPC_47x
-	isync();
-#endif
+	if (IS_ENABLED(CONFIG_PPC_47x))
+		isync();
 	return 0;
 }
 #elif defined(CONFIG_PPC_BOOK3S)
-- 
2.25.0

