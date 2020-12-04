Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F39582CF282
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Dec 2020 18:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731050AbgLDRAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Dec 2020 12:00:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:59702 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726808AbgLDRAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Dec 2020 12:00:14 -0500
From:   Arnd Bergmann <arnd@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     Russell King <linux@armlinux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ira Weiny <ira.weiny@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: highmem: fix cache_is_vivt() reference
Date:   Fri,  4 Dec 2020 17:59:22 +0100
Message-Id: <20201204165930.3877571-1-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The reference to cache_is_vivt() was moved into a header file,
which now causes a build failure in rare randconfig builds:

arch/arm/include/asm/highmem.h:52:43: error: implicit declaration of function 'cache_is_vivt' [-Werror,-Wimplicit-function-declaration]

Add an explicit include to make it build reliably.

Fixes: 2a15ba82fa6c ("ARM: highmem: Switch to generic kmap atomic")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/include/asm/highmem.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/include/asm/highmem.h b/arch/arm/include/asm/highmem.h
index a41de523d053..b4b66220952d 100644
--- a/arch/arm/include/asm/highmem.h
+++ b/arch/arm/include/asm/highmem.h
@@ -2,6 +2,7 @@
 #ifndef _ASM_HIGHMEM_H
 #define _ASM_HIGHMEM_H
 
+#include <asm/cachetype.h>
 #include <asm/fixmap.h>
 
 #define PKMAP_BASE		(PAGE_OFFSET - PMD_SIZE)
-- 
2.27.0

