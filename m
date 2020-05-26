Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1286F1AAB24
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Apr 2020 17:01:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392543AbgDOO5W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Apr 2020 10:57:22 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:18464 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388729AbgDOO5N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 10:57:13 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 492QS52Fp0z9v13s;
        Wed, 15 Apr 2020 16:57:09 +0200 (CEST)
Authentication-Results: localhost; dkim=pass
        reason="1024-bit key; insecure key"
        header.d=c-s.fr header.i=@c-s.fr header.b=iShV9VSE; dkim-adsp=pass;
        dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id livymf_PZKTn; Wed, 15 Apr 2020 16:57:09 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 492QS50kNVz9v13r;
        Wed, 15 Apr 2020 16:57:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
        t=1586962629; bh=Tl45npFIhgl2M3utaD4p/4LKgIxW3bUawXCwDvGqrhE=;
        h=From:Subject:To:Cc:Date:From;
        b=iShV9VSEXj+o1B1LCu9Hpf75EcpSRUIDb/OcKzpKe5pV9jsItspKh938gZHNZgmOE
         5aKOL+WX6f0pNUaXWDTSitnQHaxHYS6tCjQTbl9xSOXUdncoP7kHf3RJau/M5Mjmus
         bjte4PCCsjrvf/lBbaUmdnBPr0XOHco7r4qJFTkw=
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A4B6D8BB09;
        Wed, 15 Apr 2020 16:57:10 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 1PxG32O8DJ-I; Wed, 15 Apr 2020 16:57:10 +0200 (CEST)
Received: from pc16570vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 415048B931;
        Wed, 15 Apr 2020 16:57:10 +0200 (CEST)
Received: by pc16570vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id EC0C96578F; Wed, 15 Apr 2020 14:57:09 +0000 (UTC)
Message-Id: <154a99399317b096ac1f04827b9f8d7a9179ddc1.1586962586.git.christophe.leroy@c-s.fr>
From:   Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH] powerpc/uaccess: Don't set KUAP by default on book3s/32
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 15 Apr 2020 14:57:09 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On book3s/32, KUAP is an heavy process as it requires to
determine which segments are impacted and unlock/lock
each of them.

And since the implementation of user_access_begin/end, it
is even worth for the time being because unlike __get_user(),
user_access_begin doesn't make difference between read and write
and unlocks access also for read allthought that's unneeded
on book3s/32.

As shown by the size of a kernel built with KUAP and one without,
the overhead is 64k bytes of code. As a comparison a similar
build on an 8xx has an overhead of only 8k bytes of code.

   text	   data	    bss	    dec	    hex	filename
7230416	1425868	 837376	9493660	 90dc9c	vmlinux.kuap6xx
7165012	1425548	 837376	9427936	 8fdbe0	vmlinux.nokuap6xx
6519796	1960028	 477464	8957288	 88ad68	vmlinux.kuap8xx
6511664	1959864	 477464	8948992	 888d00	vmlinux.nokuap8xx

Until a more optimised KUAP is implemented on book3s/32,
don't select it by default.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/platforms/Kconfig.cputype | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 0c3c1902135c..0c7151c98b56 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -389,7 +389,7 @@ config PPC_HAVE_KUAP
 config PPC_KUAP
 	bool "Kernel Userspace Access Protection"
 	depends on PPC_HAVE_KUAP
-	default y
+	default y if !PPC_BOOK3S_32
 	help
 	  Enable support for Kernel Userspace Access Protection (KUAP)
 
-- 
2.25.0

