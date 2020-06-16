Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBA6B1FB2EB
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jun 2020 15:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729014AbgFPNz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Jun 2020 09:55:58 -0400
Received: from ozlabs.org ([203.11.71.1]:37287 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728908AbgFPNzz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 09:55:55 -0400
Received: by ozlabs.org (Postfix, from userid 1034)
        id 49mV8l58Vcz9sT6; Tue, 16 Jun 2020 23:55:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
        s=201909; t=1592315751;
        bh=KyN/8xEV1ocUHJUV+svHFzygU+CKYg1ZOnKHC5triV4=;
        h=From:To:Cc:Subject:Date:From;
        b=E5AQZP5r9bIEHpD7dBNDSa1Gd4Pp4mQa23qIcRl+V41xprJ/mCcEl0ve5r7DhrqiW
         YpQes4BXZnfCAr/ZYh7mp8YD6L39BAGqbFnr5cbuAolScyOTMtYvkEvxXacK9a9DU6
         SGAuL/0Y3LeyPeVHxQDc7O5ET7tAavb8ss4IS5v1qeoRRUiQ/yJkfxJMq6jbr++jKZ
         A7FIgtw0Crbi5i/Nh/vSr2x0cTKqjsqUdgLpHDu7wnu8dmxbbcUyK8DI+f/ZXDlm/k
         bVXPj94vvbHhNHH7l5orReLRlv+ow0NEhvFeG2ourmrEUKL+iw1QrovJrPKeRzN0yO
         EdoMnVWmgk6GQ==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     linuxppc-dev@ozlabs.org
Cc:     arnd@arndb.de, linux-arch@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] powerpc/syscalls: Use the number when building SPU syscall table
Date:   Tue, 16 Jun 2020 23:56:16 +1000
Message-Id: <20200616135617.2937252-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the macro that inserts entries into the SPU syscall table
doesn't actually use the "nr" (syscall number) parameter.

This does work, but it relies on the exact right number of syscall
entries being emitted in order for the syscal numbers to line up with
the array entries. If for example we had two entries with the same
syscall number we wouldn't get an error, it would just cause all
subsequent syscalls to be off by one in the spu_syscall_table.

So instead change the macro to assign to the specific entry of the
array, meaning any numbering overlap will be caught by the compiler.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/r/20190116132714.20094-1-mpe@ellerman.id.au
---
 arch/powerpc/platforms/cell/spu_callbacks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/cell/spu_callbacks.c b/arch/powerpc/platforms/cell/spu_callbacks.c
index cbee3666da07..abdef9bcf432 100644
--- a/arch/powerpc/platforms/cell/spu_callbacks.c
+++ b/arch/powerpc/platforms/cell/spu_callbacks.c
@@ -35,7 +35,7 @@
  */
 
 static void *spu_syscall_table[] = {
-#define __SYSCALL(nr, entry)	entry,
+#define __SYSCALL(nr, entry) [nr] = entry,
 #include <asm/syscall_table_spu.h>
 #undef __SYSCALL
 };
-- 
2.25.1

