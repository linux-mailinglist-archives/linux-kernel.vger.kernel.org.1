Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CECD62D3A79
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Dec 2020 06:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727485AbgLIFaK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Dec 2020 00:30:10 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:7051 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727257AbgLIFaJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Dec 2020 00:30:09 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4CrQb56gkLz9txjw;
        Wed,  9 Dec 2020 06:29:21 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id pIs6LjS5FxyQ; Wed,  9 Dec 2020 06:29:21 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4CrQb555KJz9txjs;
        Wed,  9 Dec 2020 06:29:21 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 799E98B77C;
        Wed,  9 Dec 2020 06:29:22 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id bt0ga6pAplvd; Wed,  9 Dec 2020 06:29:22 +0100 (CET)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3E5638B768;
        Wed,  9 Dec 2020 06:29:22 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
        id 21B31668FD; Wed,  9 Dec 2020 05:29:22 +0000 (UTC)
Message-Id: <6afaac2495248d68f94c438c5ec36b6010931de5.1607491748.git.christophe.leroy@csgroup.eu>
In-Reply-To: <0d37490a067840f53fc5b118869917c0aec9ab87.1607491747.git.christophe.leroy@csgroup.eu>
References: <0d37490a067840f53fc5b118869917c0aec9ab87.1607491747.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v4 3/6] powerpc/fault: Unnest definition of
 page_fault_is_write() and page_fault_is_bad()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, npiggin@gmail.com,
        aneesh.kumar@linux.ibm.com
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed,  9 Dec 2020 05:29:22 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To make it more readable, separate page_fault_is_write() and page_fault_is_bad()
to avoir several levels of #ifdefs

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/mm/fault.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
index f6ae56a0d7a3..3fcd34c28e10 100644
--- a/arch/powerpc/mm/fault.c
+++ b/arch/powerpc/mm/fault.c
@@ -363,17 +363,19 @@ static void sanity_check_fault(bool is_write, bool is_user,
  */
 #if (defined(CONFIG_4xx) || defined(CONFIG_BOOKE))
 #define page_fault_is_write(__err)	((__err) & ESR_DST)
-#define page_fault_is_bad(__err)	(0)
 #else
 #define page_fault_is_write(__err)	((__err) & DSISR_ISSTORE)
-#if defined(CONFIG_PPC_8xx)
+#endif
+
+#if defined(CONFIG_4xx) || defined(CONFIG_BOOKE)
+#define page_fault_is_bad(__err)	(0)
+#elif defined(CONFIG_PPC_8xx)
 #define page_fault_is_bad(__err)	((__err) & DSISR_NOEXEC_OR_G)
 #elif defined(CONFIG_PPC64)
 #define page_fault_is_bad(__err)	((__err) & DSISR_BAD_FAULT_64S)
 #else
 #define page_fault_is_bad(__err)	((__err) & DSISR_BAD_FAULT_32S)
 #endif
-#endif
 
 /*
  * For 600- and 800-family processors, the error_code parameter is DSISR
-- 
2.25.0

