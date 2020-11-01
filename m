Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B66612A1BBA
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Nov 2020 04:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbgKADCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 23:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726195AbgKADCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 23:02:37 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB927C0617A6;
        Sat, 31 Oct 2020 20:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=epwr0xo7+qH8MVywg7EUJv5PcSM06it9MYSIBNMH0zQ=; b=EOYU5hvobvducAvPimZvxhAHwG
        3vVEggSCO0Lgj8ZcbZ9kvevg3a2xrwii/tXpcP6/RE6m0Z1I2PXzFBazCKuk51T8nTFGEPmE+YNCe
        lHv1Nvip+Fs7MkZ6P8vTqSJt0NVepf58eyFfJ2x3sFYSMV9BIeioqnjFvxWFi2r7rXYv9m702eUkH
        w6L8C+f4MRhSoK5ozExBfpp88Y/b1TA4MbCNL+Cfg/dlr9WSYkv3QCz84vFfo83Ch21HRzhtwjd3B
        cb/UWGiXJOCT9AEnTp0A/Y7tsSCxOvV/4iw+HtUBazCdv1dtcajkMEaWo7UskYjWQ4j8FNw2LMO1S
        MR1iL24A==;
Received: from [2601:1c0:6280:3f0::9850] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kZ3dO-0002eF-FZ; Sun, 01 Nov 2020 03:02:24 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>,
        David Howells <dhowells@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org
Subject: [PATCH] asm-generic: barrier.h: fix ALPHA builds when SMP is not enabled
Date:   Sat, 31 Oct 2020 20:01:59 -0700
Message-Id: <20201101030159.15858-1-rdunlap@infradead.org>
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
---
 include/asm-generic/barrier.h |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20201030.orig/include/asm-generic/barrier.h
+++ linux-next-20201030/include/asm-generic/barrier.h
@@ -13,6 +13,7 @@
 
 #ifndef __ASSEMBLY__
 
+#include <linux/compiler.h>
 #include <asm/rwonce.h>
 
 #ifndef nop
