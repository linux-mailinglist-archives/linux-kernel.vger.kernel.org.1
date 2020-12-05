Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 343502CFE04
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Dec 2020 20:12:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgLES5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Dec 2020 13:57:43 -0500
Received: from m12-17.163.com ([220.181.12.17]:59280 "EHLO m12-17.163.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726522AbgLES5m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Dec 2020 13:57:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=Date:From:Subject:Message-ID:MIME-Version; bh=ZuoMT
        JZtBJVvcaRJIo5Pg8LUfX2zkCHNi7YfP7UItu4=; b=IUg1XJl+Rfny9HFUeC1Hd
        8PLsMYmd+9TzToF9l5CvsJk320ebi/vMoa0R8c/9gcad7bP4Ee9A81pqrFbzVLzR
        U5wzISSaB4KsrBv67WaeOTetC8UAxb2WrHuWKUEEIf83PRyqDmNVo3WbvU3zKfpq
        3IRrcNwHbSz6uPcsOpTVrg=
Received: from localhost (unknown [101.86.215.73])
        by smtp13 (Coremail) with SMTP id EcCowADn97O_wctfBivoXw--.5924S2;
        Sun, 06 Dec 2020 01:22:07 +0800 (CST)
Date:   Sun, 6 Dec 2020 01:22:07 +0800
From:   Hui Su <sh_def@163.com>
To:     glider@google.com, elver@google.com, dvyukov@google.com,
        catalin.marinas@arm.com, will@kernel.org,
        kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     sh_def@163.com, sfr@canb.auug.org.au
Subject: [PATCH][next] arm64: fix the mm build error in mm/kfence/core.c
Message-ID: <20201205172207.GA4097@rlk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: EcCowADn97O_wctfBivoXw--.5924S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JFyrXw4DAr18JrW5uw48JFb_yoWkWFcEy3
        Wftw4vgw1rArn2qry3tan3Xr1I9340yrWDXr1Sqrn0ya9xur18W34kCryxC3W7Gan0grZ3
        ZFZayw15Jr17KjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
        9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IU1F4i5UUUUU==
X-Originating-IP: [101.86.215.73]
X-CM-SenderInfo: xvkbvvri6rljoofrz/1tbitx-xX1aEGrG2MQAAs4
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I build kernel with ARCH=arm64, the building errors came out like
this:
  CC      mm/kfence/core.o
In file included from ../mm/kfence/core.c:21:
../arch/arm64/include/asm/kfence.h: In function ‘kfence_protect_page’:
../arch/arm64/include/asm/kfence.h:12:2: error: implicit declaration of
function ‘set_memory_valid’ [-Werror=implicit-function-declaration]
   12 |  set_memory_valid(addr, 1, !protect);
      |  ^~~~~~~~~~~~~~~~
cc1: some warnings being treated as errors

which introduced by commit d54febeba2ff ("kfence: use pt_regs to
generate stack trace on faults").

Signed-off-by: Hui Su <sh_def@163.com>
---
 arch/arm64/include/asm/kfence.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/include/asm/kfence.h b/arch/arm64/include/asm/kfence.h
index 6c0afeeab635..4d73e34da59d 100644
--- a/arch/arm64/include/asm/kfence.h
+++ b/arch/arm64/include/asm/kfence.h
@@ -4,6 +4,7 @@
 #define __ASM_KFENCE_H
 
 #include <asm/cacheflush.h>
+#include <linux/set_memory.h>
 
 static inline bool arch_kfence_init_pool(void) { return true; }
 
-- 
2.25.1


