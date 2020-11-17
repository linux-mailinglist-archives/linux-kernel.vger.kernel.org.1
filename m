Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4472B6EA9
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Nov 2020 20:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbgKQTbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Nov 2020 14:31:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725613AbgKQTbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Nov 2020 14:31:00 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA59C0613CF
        for <linux-kernel@vger.kernel.org>; Tue, 17 Nov 2020 11:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=0w7Ozk28Ycs+oUmhikFWAD+C3GsZMaJDoL2VuQ4QW/c=; b=LAH0bwixan6uK8YQ8JD4EflJE3
        siRCA/CVKgxv1pPzkVhV3r53qtSX0jAGKOmXRhI+LU2Y3fPWsGmHslJwRKOucTjTb/qbojQ0PrxUz
        8t5ifqatu4bANn5H4jxLXkvf9D4z0cV/ZYow0UETIVvvk3P3QQVtJzbSb+stcLranSMEhiPXO/Vf9
        AgVOmgh1dhBpF3pbnpnGz2yH1P/ZJl+0D//6o+OUQQuv3LAnGfBIHsdb12H3iCqv39MMxoeJRgkka
        XYD5nhx2qd+nwf0aM/7woXZdL1rQFsv2trE/B8bTzBDcvU0fZ2Z6MAyUlCJTwJiu/8QmrZpKdsakY
        uBxyGYyg==;
Received: from [2601:1c0:6280:3f0::bcc4] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kf6gr-0005l4-Gg; Tue, 17 Nov 2020 19:30:57 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Andreas Schwab <schwab@linux-m68k.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        linux-riscv@lists.infradead.org,
        clang-built-linux@googlegroups.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Subject: [PATCH v2] RISC-V: fix barrier() use in <vdso/processor.h>
Date:   Tue, 17 Nov 2020 11:30:53 -0800
Message-Id: <20201117193053.18990-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

riscv's <vdso/processor.h> uses barrier() so it should
#include <asm/barrier.h> to prevent build errors.

Fixes this build error:
  CC [M]  drivers/net/ethernet/emulex/benet/be_main.o
In file included from ./include/vdso/processor.h:10,
                 from ./arch/riscv/include/asm/processor.h:11,
                 from ./include/linux/prefetch.h:15,
                 from drivers/net/ethernet/emulex/benet/be_main.c:14:
./arch/riscv/include/asm/vdso/processor.h: In function 'cpu_relax':
./arch/riscv/include/asm/vdso/processor.h:14:2: error: implicit declaration of function 'barrier' [-Werror=implicit-function-declaration]
   14 |  barrier();

This happens with a total of 5 networking drivers -- they all use
<linux/prefetch.h>.

rv64 and rv32 allmodconfig now build cleanly after this patch.

Fixes: 3347acc6fcd4 ("compiler.h: fix barrier_data() on clang")
Fixes: ad5d1122b82f ("riscv: use vDSO common flow to reduce the latency of the time-related functions")
Reported-by: Andreas Schwab <schwab@linux-m68k.org>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Arvind Sankar <nivedita@alum.mit.edu>
Cc: linux-riscv@lists.infradead.org
Cc: clang-built-linux@googlegroups.com
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Nathan Chancellor <natechancellor@gmail.com>
Cc: Paul Walmsley <paul.walmsley@sifive.com>
Cc: Palmer Dabbelt <palmer@dabbelt.com>
Cc: Albert Ou <aou@eecs.berkeley.edu>
---
v2: update Fixes: tags (Nick);
    also built allmodconfig cleanly on rv32;

 arch/riscv/include/asm/vdso/processor.h |    2 ++
 1 file changed, 2 insertions(+)

--- lnx-510-rc4.orig/arch/riscv/include/asm/vdso/processor.h
+++ lnx-510-rc4/arch/riscv/include/asm/vdso/processor.h
@@ -4,6 +4,8 @@
 
 #ifndef __ASSEMBLY__
 
+#include <asm/barrier.h>
+
 static inline void cpu_relax(void)
 {
 #ifdef __riscv_muldiv
