Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECC8B2856CF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 04:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbgJGCyu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 22:54:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726627AbgJGCyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 22:54:49 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92AF2C061755
        for <linux-kernel@vger.kernel.org>; Tue,  6 Oct 2020 19:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=Kfn1EjIw61OOA6atfqtDsUyZD8OZlfnAF20PJC2dm14=; b=qehWR4LYimU3auLImYdY7dy5xT
        qJQ7N/N3RyKgXPBBGJYKenvFHzkRm0aP5DoMQ6DGuzp7kbj88LGDpZobZVYOq+KTpLb3Ws0H0gEJJ
        IrwCgHI6Lz1Iu127MZ7tZ9ovdDvIP4MEjIO206vqEC4Aa1haNrPBcr40VsRTJDbSdg0zvbQbXYIUk
        N9qUoTB3J73qcHt8uu/vJKNlQl8dXXsI5VB7doSJ8ZxVzCjsip4lJe9+mlP7fROSXTEZomxi5C4Ux
        SeYr8zbaP9gWNhZyg8dwsv7anSol1N7Ff9jeXVxsSjv5Bwex6spTxEHGQ2Am/A9i/FvSHfHCmpa1a
        WgQks5Rw==;
Received: from [2601:1c0:6280:3f0::2c9a]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kPzbI-0004UB-3H; Wed, 07 Oct 2020 02:54:44 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        "linux-snps-arc@lists.infradead.org" 
        <linux-snps-arc@lists.infradead.org>,
        Dan Williams <dan.j.williams@intel.com>
Cc:     kernel test robot <lkp@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] fs: dax: fix build error on ARC
Message-ID: <6b5c6090-331d-7485-da4a-45e9c7f13be1@infradead.org>
Date:   Tue, 6 Oct 2020 19:54:41 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

fs/dax.c uses copy_user_page() but ARC does not provide that interface,
resulting in a build error.

Provide copy_user_page() in <asm/page.h> (beside copy_page()) and
add <asm/page.h> to fs/dax.c to fix the build error.

../fs/dax.c: In function 'copy_cow_page_dax':
../fs/dax.c:702:2: error: implicit declaration of function 'copy_user_page'; did you mean 'copy_to_user_page'? [-Werror=implicit-function-declaration]

Fixes: cccbce671582 ("filesystem-dax: convert to dax_direct_access()")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Vineet Gupta <vgupta@synopsys.com>
Cc: linux-snps-arc@lists.infradead.org
Cc: Dan Williams <dan.j.williams@intel.com>
---
Vineet, This patch fixes the build error but is it correct for ARC?

 arch/arc/include/asm/page.h |    1 +
 fs/dax.c                    |    1 +
 2 files changed, 2 insertions(+)

--- lnx-59-rc7.orig/fs/dax.c
+++ lnx-59-rc7/fs/dax.c
@@ -25,6 +25,7 @@
 #include <linux/sizes.h>
 #include <linux/mmu_notifier.h>
 #include <linux/iomap.h>
+#include <asm/page.h>
 #include <asm/pgalloc.h>
 
 #define CREATE_TRACE_POINTS
--- lnx-59-rc7.orig/arch/arc/include/asm/page.h
+++ lnx-59-rc7/arch/arc/include/asm/page.h
@@ -10,6 +10,7 @@
 #ifndef __ASSEMBLY__
 
 #define clear_page(paddr)		memset((paddr), 0, PAGE_SIZE)
+#define copy_user_page(to, from, vaddr, pg)	copy_page(to, from)
 #define copy_page(to, from)		memcpy((to), (from), PAGE_SIZE)
 
 struct vm_area_struct;

