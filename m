Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6D2D2A14E8
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Oct 2020 10:44:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726625AbgJaJnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Oct 2020 05:43:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:46858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726451AbgJaJnw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Oct 2020 05:43:52 -0400
Received: from aquarius.haifa.ibm.com (nesher1.haifa.il.ibm.com [195.110.40.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 772EA2076D;
        Sat, 31 Oct 2020 09:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604137432;
        bh=VvBOXLme6FI5EZGrCkCjihO7J3QUI6NE5sFXDTpUC3o=;
        h=From:To:Cc:Subject:Date:From;
        b=n84ti3TOZIKzO0erhtdpxXSJDOhPJHvQ36pCBg85BhjJR1JcDj+PjWvqcz+dZjtY7
         IqeuwDi21FroqQ8rU2xVO/YIKB5aHdxcKl2sPSxkSVu/OESGH51S0VQflI/TOoxrBP
         HP+Zbr/m+KC8W7qkJjD2OheKd5ZjDzIK1Teyfn8g=
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, linux-xtensa@linux-xtensa.org
Cc:     Ard Biesheuvel <ardb@kernel.org>, Chris Zankel <chris@zankel.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] ARM, xtensa: highmem: avoid clobbering non-page aligned memory reservations
Date:   Sat, 31 Oct 2020 11:43:45 +0200
Message-Id: <20201031094345.6984-1-rppt@kernel.org>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ard Biesheuvel <ardb@kernel.org>

free_highpages() iterates over the free memblock regions in high
memory, and marks each page as available for the memory management
system.

Until commit cddb5ddf2b76 ("arm, xtensa: simplify initialization of
high memory pages") it rounded beginning of each region upwards and end of
each region downwards.

However, after that commit free_highmem() rounds the beginning and end of
each region downwards, and we may end up freeing a page that is
memblock_reserve()d, resulting in memory corruption.

Restore the original rounding of the region boundaries to avoid freeing
reserved pages.

Fixes: cddb5ddf2b76 ("arm, xtensa: simplify initialization of high memory pages")
Link: https://lore.kernel.org/r/20201029110334.4118-1-ardb@kernel.org/
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Co-developed-by:  Mike Rapoport <rppt@linux.ibm.com>
Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---

Max, Russell,

Please let me know how do you prefer to take it upstream.
If needed this can go via memblock tree.

v2: fix words order in the commit message

 arch/arm/mm/init.c    | 4 ++--
 arch/xtensa/mm/init.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index d57112a276f5..c23dbf8bebee 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -354,8 +354,8 @@ static void __init free_highpages(void)
 	/* set highmem page free */
 	for_each_free_mem_range(i, NUMA_NO_NODE, MEMBLOCK_NONE,
 				&range_start, &range_end, NULL) {
-		unsigned long start = PHYS_PFN(range_start);
-		unsigned long end = PHYS_PFN(range_end);
+		unsigned long start = PFN_UP(range_start);
+		unsigned long end = PFN_DOWN(range_end);
 
 		/* Ignore complete lowmem entries */
 		if (end <= max_low)
diff --git a/arch/xtensa/mm/init.c b/arch/xtensa/mm/init.c
index c6fc83efee0c..8731b7ad9308 100644
--- a/arch/xtensa/mm/init.c
+++ b/arch/xtensa/mm/init.c
@@ -89,8 +89,8 @@ static void __init free_highpages(void)
 	/* set highmem page free */
 	for_each_free_mem_range(i, NUMA_NO_NODE, MEMBLOCK_NONE,
 				&range_start, &range_end, NULL) {
-		unsigned long start = PHYS_PFN(range_start);
-		unsigned long end = PHYS_PFN(range_end);
+		unsigned long start = PFN_UP(range_start);
+		unsigned long end = PFN_DOWN(range_end);
 
 		/* Ignore complete lowmem entries */
 		if (end <= max_low)
-- 
2.28.0

