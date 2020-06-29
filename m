Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3847F20D2A4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jun 2020 20:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729581AbgF2SvV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jun 2020 14:51:21 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:63463 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726805AbgF2Su7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 14:50:59 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 49wPzQ5P3yz9tyrH;
        Mon, 29 Jun 2020 13:15:14 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id a4pkWXwXL7jI; Mon, 29 Jun 2020 13:15:14 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 49wPzQ4Jfvz9tyqw;
        Mon, 29 Jun 2020 13:15:14 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 12D4D8B79E;
        Mon, 29 Jun 2020 13:15:21 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 1YMB4MjTxiJ1; Mon, 29 Jun 2020 13:15:21 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr [172.25.230.105])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E0F4E8B799;
        Mon, 29 Jun 2020 13:15:20 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id D4CCC65B29; Mon, 29 Jun 2020 11:15:20 +0000 (UTC)
Message-Id: <7d884db0e5a6f521331639d8c0f13e520d5a4fef.1593428200.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1593428200.git.christophe.leroy@csgroup.eu>
References: <cover.1593428200.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 1/6] powerpc/lib: Prepare code-patching for modules
 allocated outside vmalloc space
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Mon, 29 Jun 2020 11:15:20 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use is_vmalloc_or_module_addr() instead of is_vmalloc_addr()

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/lib/code-patching.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
index 0a051dfeb177..8c3934ea6220 100644
--- a/arch/powerpc/lib/code-patching.c
+++ b/arch/powerpc/lib/code-patching.c
@@ -93,7 +93,7 @@ static int map_patch_area(void *addr, unsigned long text_poke_addr)
 	unsigned long pfn;
 	int err;
 
-	if (is_vmalloc_addr(addr))
+	if (is_vmalloc_or_module_addr(addr))
 		pfn = vmalloc_to_pfn(addr);
 	else
 		pfn = __pa_symbol(addr) >> PAGE_SHIFT;
-- 
2.25.0

