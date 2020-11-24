Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB712C2B2F
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Nov 2020 16:25:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388509AbgKXPY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Nov 2020 10:24:57 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:55241 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730546AbgKXPY4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Nov 2020 10:24:56 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4CgSW93hp1z9v0d8;
        Tue, 24 Nov 2020 16:24:53 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id xRZ94Le8KDIF; Tue, 24 Nov 2020 16:24:53 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4CgSW92pXqz9v0d5;
        Tue, 24 Nov 2020 16:24:53 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id EA2998B7B3;
        Tue, 24 Nov 2020 16:24:54 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 3EGNtlK8EZU6; Tue, 24 Nov 2020 16:24:54 +0100 (CET)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id AC1B18B7AF;
        Tue, 24 Nov 2020 16:24:54 +0100 (CET)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 446EF668E2; Tue, 24 Nov 2020 15:24:54 +0000 (UTC)
Message-Id: <e796c5fcb5898de827c803cf1ab8ba1d7a5d4b76.1606231483.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 1/6] powerpc/8xx: DEBUG_PAGEALLOC doesn't require an ITLB
 miss exception handler
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue, 24 Nov 2020 15:24:54 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit e611939fc8ec ("powerpc/mm: Ensure change_page_attr()
doesn't invalidate pinned TLBs"), pinned TLBs are not anymore
invalidated by __kernel_map_pages() when CONFIG_DEBUG_PAGEALLOC is
selected.

Remove the dependency on CONFIG_DEBUG_PAGEALLOC.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/head_8xx.S | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/head_8xx.S b/arch/powerpc/kernel/head_8xx.S
index ee0bfebc375f..66ee62f30d36 100644
--- a/arch/powerpc/kernel/head_8xx.S
+++ b/arch/powerpc/kernel/head_8xx.S
@@ -47,8 +47,7 @@
  * - Either we have modules
  * - Or we have not pinned the first 8M
  */
-#if defined(CONFIG_MODULES) || !defined(CONFIG_PIN_TLB_TEXT) || \
-    defined(CONFIG_DEBUG_PAGEALLOC)
+#if defined(CONFIG_MODULES) || !defined(CONFIG_PIN_TLB_TEXT)
 #define ITLB_MISS_KERNEL	1
 #endif
 
-- 
2.25.0

