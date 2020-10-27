Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 564E329A662
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Oct 2020 09:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2894558AbgJ0IT2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Oct 2020 04:19:28 -0400
Received: from leibniz.telenet-ops.be ([195.130.137.77]:35634 "EHLO
        leibniz.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2894546AbgJ0IT1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Oct 2020 04:19:27 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by leibniz.telenet-ops.be (Postfix) with ESMTPS id 4CL4P904skzMqfXj
        for <linux-kernel@vger.kernel.org>; Tue, 27 Oct 2020 09:19:25 +0100 (CET)
Received: from ramsan.of.borg ([84.195.186.194])
        by baptiste.telenet-ops.be with bizsmtp
        id kwKP2300X4C55Sk01wKPk0; Tue, 27 Oct 2020 09:19:24 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kXKCR-000WG8-8w; Tue, 27 Oct 2020 09:19:23 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kXKCQ-00GpRT-Nb; Tue, 27 Oct 2020 09:19:22 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Nicholas Piggin <npiggin@gmail.com>, Arnd Bergmann <arnd@arndb.de>
Cc:     linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        noreply@ellerman.id.au
Subject: [PATCH -next] m68k: mmu_context: Fix Sun-3 build
Date:   Tue, 27 Oct 2020 09:19:19 +0100
Message-Id: <20201027081919.4010948-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building for Sun-3 (e.g. sun3_defconfig):

    In file included from ./arch/m68k/include/asm/mmu_context.h:312,
		     from arch/m68k/sun3/mmu_emu.c:28:
    ./include/asm-generic/mmu_context.h:46:20: error: redefinition of ‘destroy_context’
       46 | static inline void destroy_context(struct mm_struct *mm)
	  |                    ^~~~~~~~~~~~~~~
    In file included from arch/m68k/sun3/mmu_emu.c:28:
    ./arch/m68k/include/asm/mmu_context.h:192:20: note: previous definition of ‘destroy_context’ was here
      192 | static inline void destroy_context(struct mm_struct *mm)
	  |                    ^~~~~~~~~~~~~~~

Fix this by marking destroy_context implemented by arch-specific code.

Reported-by: noreply@ellerman.id.au
Fixes: cb41155766b05935 ("m68k: use asm-generic/mmu_context.h for no-op implementations")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/m68k/include/asm/mmu_context.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/m68k/include/asm/mmu_context.h b/arch/m68k/include/asm/mmu_context.h
index d12d8a9032f67bdd..a5d358855878490f 100644
--- a/arch/m68k/include/asm/mmu_context.h
+++ b/arch/m68k/include/asm/mmu_context.h
@@ -189,6 +189,7 @@ static inline void get_mmu_context(struct mm_struct *mm)
 }
 
 /* flush context if allocated... */
+#define destroy_context destroy_context
 static inline void destroy_context(struct mm_struct *mm)
 {
 	if (mm->context != SUN3_INVALID_CONTEXT)
-- 
2.25.1

