Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E425B242905
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Aug 2020 14:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727969AbgHLMGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Aug 2020 08:06:06 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:61958 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727890AbgHLMGA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 08:06:00 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BRT1c6Qb1zB09ZY;
        Wed, 12 Aug 2020 14:05:56 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id heUzEzYIYrOR; Wed, 12 Aug 2020 14:05:56 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BRT1c5dT5zB09ZQ;
        Wed, 12 Aug 2020 14:05:56 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 373D58B826;
        Wed, 12 Aug 2020 14:05:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 8SwpSyskm4Ce; Wed, 12 Aug 2020 14:05:58 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id CADF88B7FC;
        Wed, 12 Aug 2020 14:05:57 +0200 (CEST)
Received: by po17688vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id A51FB65C34; Wed, 12 Aug 2020 12:05:57 +0000 (UTC)
Message-Id: <09ebaef69b332f205fc7a71fead88aed7eac1f92.1597233555.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1597233555.git.christophe.leroy@csgroup.eu>
References: <cover.1597233555.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [RFC PATCH v1 06/19] powerpc/32s: Allow deselecting CONFIG_PPC_FPU on
 mpc832x
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>, ldv@altlinux.org,
        viro@zeniv.linux.org.uk
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Wed, 12 Aug 2020 12:05:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The e300c2 core which is embedded in mpc832x CPU doesn't have
an FPU.

Make it possible to not select CONFIG_PPC_FPU when building a
kernel dedicated to that target.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/platforms/Kconfig.cputype | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 40ffcdba42b8..d4fd109f177e 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -32,7 +32,7 @@ choice
 config PPC_BOOK3S_6xx
 	bool "512x/52xx/6xx/7xx/74xx/82xx/83xx/86xx except 601"
 	select PPC_BOOK3S_32
-	select PPC_FPU
+	imply PPC_FPU
 	select PPC_HAVE_PMU_SUPPORT
 	select PPC_HAVE_KUEP
 	select PPC_HAVE_KUAP
@@ -229,9 +229,16 @@ config PPC_FPU_REGS
 	bool
 
 config PPC_FPU
-	bool
+	bool "Support for Floating Point Unit (FPU)" if PPC_MPC832x
 	default y if PPC64
 	select PPC_FPU_REGS
+	help
+	  This must be enabled to support the Floating Point Unit
+	  Most 6xx have an FPU but e300c2 core (mpc832x) don't have
+	  an FPU, so when building an embedded kernel for that target
+	  you can disable FPU support.
+
+	  If unsure say Y.
 
 config FSL_EMB_PERFMON
 	bool "Freescale Embedded Perfmon"
-- 
2.25.0

