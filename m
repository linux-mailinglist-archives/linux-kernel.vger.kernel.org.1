Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8362E1A95
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 10:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbgLWJjc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 04:39:32 -0500
Received: from pegase1.c-s.fr ([93.17.236.30]:18611 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727332AbgLWJjb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 04:39:31 -0500
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4D17SR5lPbz9v1yW;
        Wed, 23 Dec 2020 10:38:47 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id OC_puzyC6wkF; Wed, 23 Dec 2020 10:38:47 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4D17SR4yK4z9v1yS;
        Wed, 23 Dec 2020 10:38:47 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CBFCB8B81D;
        Wed, 23 Dec 2020 10:38:48 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 9vIGHNpHhzSF; Wed, 23 Dec 2020 10:38:48 +0100 (CET)
Received: from localhost.localdomain (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 89C468B75F;
        Wed, 23 Dec 2020 10:38:48 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
        id 654A26696F; Wed, 23 Dec 2020 09:38:48 +0000 (UTC)
Message-Id: <b0607f1113d1558e73476bb06db0ee16d31a6e5b.1608716197.git.christophe.leroy@csgroup.eu>
In-Reply-To: <e4471bf81089252470efb3eed735d71a5b32adbd.1608716197.git.christophe.leroy@csgroup.eu>
References: <e4471bf81089252470efb3eed735d71a5b32adbd.1608716197.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH] powerpc/xmon: Enable breakpoints on 8xx
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 23 Dec 2020 09:38:48 +0000 (UTC)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 4ad8622dc548 ("powerpc/8xx: Implement hw_breakpoint"),
8xx has breakpoints so there is no reason to opt breakpoint logic
out of xmon for the 8xx.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Fixes: 4ad8622dc548 ("powerpc/8xx: Implement hw_breakpoint")
---
 arch/powerpc/xmon/xmon.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index dcd817ca2edf..cec432eb9189 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -1383,7 +1383,6 @@ static long check_bp_loc(unsigned long addr)
 	return 1;
 }
 
-#ifndef CONFIG_PPC_8xx
 static int find_free_data_bpt(void)
 {
 	int i;
@@ -1395,7 +1394,6 @@ static int find_free_data_bpt(void)
 	printf("Couldn't find free breakpoint register\n");
 	return -1;
 }
-#endif
 
 static void print_data_bpts(void)
 {
@@ -1435,7 +1433,6 @@ bpt_cmds(void)
 	cmd = inchar();
 
 	switch (cmd) {
-#ifndef CONFIG_PPC_8xx
 	static const char badaddr[] = "Only kernel addresses are permitted for breakpoints\n";
 	int mode;
 	case 'd':	/* bd - hardware data breakpoint */
@@ -1497,7 +1494,6 @@ bpt_cmds(void)
 			force_enable_xmon();
 		}
 		break;
-#endif
 
 	case 'c':
 		if (!scanhex(&a)) {
-- 
2.25.0

