Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DF382DE783
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Dec 2020 17:36:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730323AbgLRQgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Dec 2020 11:36:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:44942 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725803AbgLRQgj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Dec 2020 11:36:39 -0500
From:   Mike Rapoport <rppt@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ia64: fix build failure caused by memory model changes
Date:   Fri, 18 Dec 2020 18:35:50 +0200
Message-Id: <20201218163550.8838-1-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

The change of ia64's default memory model to SPARSEMEM causes defconfig
build to fail:

  CC      kernel/async.o
In file included from include/linux/numa.h:25,
                 from include/linux/async.h:13,
                 from kernel/async.c:47:
arch/ia64/include/asm/sparsemem.h:14:40: warning: "PAGE_SHIFT" is not defined, evaluates to 0 [-Wundef]
   14 | #if ((CONFIG_FORCE_MAX_ZONEORDER - 1 + PAGE_SHIFT) > SECTION_SIZE_BITS)
      |                                        ^~~~~~~~~~
In file included from include/linux/gfp.h:6,
                 from include/linux/xarray.h:14,
                 from include/linux/radix-tree.h:19,
                 from include/linux/idr.h:15,
                 from include/linux/kernfs.h:13,
                 from include/linux/sysfs.h:16,
                 from include/linux/kobject.h:20,
                 from include/linux/energy_model.h:7,
                 from include/linux/device.h:16,
                 from include/linux/async.h:14,
                 from kernel/async.c:47:
include/linux/mmzone.h:1156:2: error: #error Allocator MAX_ORDER exceeds SECTION_SIZE
 1156 | #error Allocator MAX_ORDER exceeds SECTION_SIZE
      |  ^~~~~

The error cause is the missing definition of PAGE_SHIFT in the calculation
of SECTION_SIZE_BITS.

Add include of <asm/page.h> to arch/ia64/include/asm/sparsemem.h to solve
the problem.

Fixes: 214496cb1870 ("ia64: make SPARSEMEM default and disable DISCONTIGMEM")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---

Surprisingly, only Guenter's bot caught this.

@Andrew, if you prefer I can take this via memblock tree.

 arch/ia64/include/asm/sparsemem.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/ia64/include/asm/sparsemem.h b/arch/ia64/include/asm/sparsemem.h
index dd8c166ffd7b..42ed5248fae9 100644
--- a/arch/ia64/include/asm/sparsemem.h
+++ b/arch/ia64/include/asm/sparsemem.h
@@ -3,6 +3,7 @@
 #define _ASM_IA64_SPARSEMEM_H
 
 #ifdef CONFIG_SPARSEMEM
+#include <asm/page.h>
 /*
  * SECTION_SIZE_BITS            2^N: how big each section will be
  * MAX_PHYSMEM_BITS             2^N: how much memory we can have in that space
-- 
2.28.0

