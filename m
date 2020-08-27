Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9315C2549DD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Aug 2020 17:49:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727911AbgH0Ptx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Aug 2020 11:49:53 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:30682 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727124AbgH0Ptd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 11:49:33 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BcnGd6nZSz9v4bY;
        Thu, 27 Aug 2020 17:49:29 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id 5hMLyBVtIKvy; Thu, 27 Aug 2020 17:49:29 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BcnGd60X9z9v4bK;
        Thu, 27 Aug 2020 17:49:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2FE718B884;
        Thu, 27 Aug 2020 17:49:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id W3AYx5BInYwj; Thu, 27 Aug 2020 17:49:31 +0200 (CEST)
Received: from po17688vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3F8A48B888;
        Thu, 27 Aug 2020 17:49:29 +0200 (CEST)
Received: by localhost.localdomain (Postfix, from userid 0)
        id AEFB565D46; Thu, 27 Aug 2020 15:49:29 +0000 (UTC)
Message-Id: <0a0e09eb3fe183ab1f4f1a1d3f4e58ae5d9cd275.1598543237.git.christophe.leroy@csgroup.eu>
In-Reply-To: <e8d735102627299303acd8fbec8c7a706b1e7882.1598543237.git.christophe.leroy@csgroup.eu>
References: <e8d735102627299303acd8fbec8c7a706b1e7882.1598543237.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 6/6] powerpc/vdso: Declare vdso_patches[] as __initdata
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Thu, 27 Aug 2020 15:49:29 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

vdso_patches[] table is used only at init time.

Mark it __initdata.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/vdso.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index 600df1164a0b..efaaee94f273 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -76,7 +76,7 @@ struct vdso_patch_def
  * Currently, we only change sync_dicache to do nothing on processors
  * with a coherent icache
  */
-static struct vdso_patch_def vdso_patches[] = {
+static struct vdso_patch_def vdso_patches[] __initdata = {
 	{
 		CPU_FTR_COHERENT_ICACHE, CPU_FTR_COHERENT_ICACHE,
 		"__kernel_sync_dicache", "__kernel_sync_dicache_p5"
-- 
2.25.0

