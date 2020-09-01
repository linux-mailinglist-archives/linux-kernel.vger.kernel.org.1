Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D22C125876B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Sep 2020 07:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726307AbgIAF3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Sep 2020 01:29:01 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:59600 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725930AbgIAF3A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 01:29:00 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4BgbGK13yGzB09ZZ;
        Tue,  1 Sep 2020 07:28:57 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id oJibAOt59Dwt; Tue,  1 Sep 2020 07:28:57 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4BgbGK07dZz9v1Ys;
        Tue,  1 Sep 2020 07:28:57 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id C88728B774;
        Tue,  1 Sep 2020 07:28:57 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id CCBIwrdl3TPB; Tue,  1 Sep 2020 07:28:57 +0200 (CEST)
Received: from localhost.localdomain (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 963138B75E;
        Tue,  1 Sep 2020 07:28:57 +0200 (CEST)
Received: by localhost.localdomain (Postfix, from userid 0)
        id 6F31465D49; Tue,  1 Sep 2020 05:28:57 +0000 (UTC)
Message-Id: <7b3e35bdf93b93f3f1f0dcb4e1f373ce3b8a0035.1598938114.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v11] Fixup for "powerpc/vdso: Provide
 __kernel_clock_gettime64() on vdso32"
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date:   Tue,  1 Sep 2020 05:28:57 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/vdso/gettimeofday.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/include/asm/vdso/gettimeofday.h b/arch/powerpc/include/asm/vdso/gettimeofday.h
index 59a609a48b63..8da84722729b 100644
--- a/arch/powerpc/include/asm/vdso/gettimeofday.h
+++ b/arch/powerpc/include/asm/vdso/gettimeofday.h
@@ -186,6 +186,8 @@ int __c_kernel_clock_getres(clockid_t clock_id, struct __kernel_timespec *res,
 #else
 int __c_kernel_clock_gettime(clockid_t clock, struct old_timespec32 *ts,
 			     const struct vdso_data *vd);
+int __c_kernel_clock_gettime64(clockid_t clock, struct __kernel_timespec *ts,
+			       const struct vdso_data *vd);
 int __c_kernel_clock_getres(clockid_t clock_id, struct old_timespec32 *res,
 			    const struct vdso_data *vd);
 #endif
-- 
2.25.0

