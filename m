Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B16825D6C6
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Sep 2020 12:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729957AbgIDKrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Sep 2020 06:47:40 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:47658 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726811AbgIDKqy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 06:46:54 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BjZ9g0N8jzB09bN;
        Fri,  4 Sep 2020 12:46:47 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id F4FlIkCuojZq; Fri,  4 Sep 2020 12:46:46 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BjZ9f5q30zB09bD;
        Fri,  4 Sep 2020 12:46:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 26D5F8B81B;
        Fri,  4 Sep 2020 12:46:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id TdVkn9hP2ZBb; Fri,  4 Sep 2020 12:46:48 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [10.25.210.31])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 037788B76A;
        Fri,  4 Sep 2020 12:46:48 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id DC97D653FF; Fri,  4 Sep 2020 10:46:47 +0000 (UTC)
Message-Id: <346f65d677adb11865f7762c25a1ca3c64404ba5.1599216023.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] powerpc/uaccess: Add pre-update addressing to
 __put_user_asm_goto()
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Fri,  4 Sep 2020 10:46:47 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable pre-update addressing mode in __put_user_asm_goto()

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/uaccess.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index 7c2427f237e1..a5cfe867fbdc 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -254,7 +254,7 @@ do {								\
 		"1:	" op "%U1%X1 %0,%1	# put_user\n"	\
 		EX_TABLE(1b, %l2)				\
 		:						\
-		: "r" (x), "m" (*addr)				\
+		: "r" (x), "m<>" (*addr)				\
 		:						\
 		: label)
 
-- 
2.25.0

