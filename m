Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CE492A2251
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Nov 2020 00:18:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727397AbgKAXSu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Nov 2020 18:18:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727071AbgKAXSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Nov 2020 18:18:49 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3E9EC0617A6;
        Sun,  1 Nov 2020 15:18:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=sTRhwwuh1Zi6sB1NgYlq0oaV8WSpgNbpK9CTGiqites=; b=bShCDDRMagDMtiIg9n2RukkblC
        lMZwCm7Mph2tFZz5AON9zyvYnvxJt07OJfqLx9W8yqV/BX5lRi7xmWlxYe+8wRYCr4g86r6ZPnXKP
        riAqMdmZYZ+ye/OiJ7f2RIyvDPtx962AhjPb54Kn0NGYVBHkHvFhFuzdj0bikzeVoR8GbM1/RufRU
        tBLryRAaatuMVO11GkVJ1SgK4iaQ3YefrUiv7FGN8v3EfxBwAub8t0iEsl7bRNnh6wCHs6ySqyBnz
        PVZMsCaSB9ocOByF8DQcYrwzMtT8PRgPq1Z0okNQNyWJt7AH1rHUyBxh7VaG2kMLvyZALk97lC/F5
        bT6E50HQ==;
Received: from [2601:1c0:6280:3f0::60d5] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kZMcT-000296-CB; Sun, 01 Nov 2020 23:18:42 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        David Howells <dhowells@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH v2] asm-generic: barrier.h: fix ALPHA builds when SMP is not enabled
Date:   Sun,  1 Nov 2020 15:18:35 -0800
Message-Id: <20201101231835.4589-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

<asm-generic/barrier.h> uses barrier() but needs to #include
<linux/compiler.h> to get a generic definition of it to fix
build errors in arch/alpha/ builds when CONFIG_SMP is not enabled.

Fixes build errors like this (there are several like this):
[49 in the kernel config that was supplied by the 0day bot]

In file included from ../arch/alpha/include/asm/barrier.h:21,
                 from ../arch/alpha/include/asm/atomic.h:6,
                 from ../include/linux/atomic.h:7,
                 from ../include/linux/dcache.h:5,
                 from ../fs/proc/util.c:1:
../arch/alpha/include/asm/atomic.h: In function 'atomic_add_return_relaxed':
../include/asm-generic/barrier.h:78:18: error: implicit declaration of function 'barrier' [-Werror=implicit-function-declaration]
   78 | #define smp_mb() barrier()
      |                  ^~~~~~~

Fixes: 885df91ca357 ("Create asm-generic/barrier.h")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: David Howells <dhowells@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Richard Henderson <rth@twiddle.net>
Cc: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: Matt Turner <mattst88@gmail.com>
Cc: linux-alpha@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
---
v2: also send to Andrew and Stephen.

 include/asm-generic/barrier.h |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20201030.orig/include/asm-generic/barrier.h
+++ linux-next-20201030/include/asm-generic/barrier.h
@@ -13,6 +13,7 @@
 
 #ifndef __ASSEMBLY__
 
+#include <linux/compiler.h>
 #include <asm/rwonce.h>
 
 #ifndef nop
