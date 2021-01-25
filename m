Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3261D30363B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 07:06:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbhAZGFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 01:05:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:40138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728410AbhAYMvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jan 2021 07:51:11 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D288122242;
        Mon, 25 Jan 2021 12:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611579030;
        bh=Mxhwg+UDKM8wuGIvGKD1s6VRf2UKfTSt1jkq1w6O030=;
        h=From:To:Cc:Subject:Date:From;
        b=H8ciKPeeEysLON81tT/e2uHWJvzVCLpZuUpTJbOFjQ/tokbNe45yK1zo/oD6z4NO/
         0pU82f2OSww8AjuQ/kQ6UAtSVO+A+21Ty1FGgZyH5nhZIzDuZ2V0WksokAjMDPhqFc
         32XX7awtIvVZu2bLEBZekD4A00/zxpG2tu5ECi3StnfA+zaLdgv7rDDGt8HTcj4xVw
         SRnpZmheAnDIqdVmdIS97COHcEDe5Byj5A3nSr48wUQtjqHNmW5sfYzD0jWZNHpoBq
         5oD1rvLbHLnwYGhnp9rye5y+H+tjWq2p9gfzslQ6RorM9gwQhLlzmd1XigRBbuB2D/
         BqQK1XC6x7REg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Mike Rapoport <rppt@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dmitry Vyukov <dvyukov@google.com>,
        Jann Horn <jannh@google.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, kasan-dev@googlegroups.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: kfence: fix header inclusion
Date:   Mon, 25 Jan 2021 13:50:20 +0100
Message-Id: <20210125125025.102381-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Randconfig builds started warning about a missing function declaration
after set_memory_valid() is moved to a new file:

In file included from mm/kfence/core.c:26:
arch/arm64/include/asm/kfence.h:17:2: error: implicit declaration of function 'set_memory_valid' [-Werror,-Wimplicit-function-declaration]

Include the correct header again.

Fixes: 9e18ec3cfabd ("set_memory: allow querying whether set_direct_map_*() is actually enabled")
Fixes: 204555ff8bd6 ("arm64, kfence: enable KFENCE for ARM64")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/include/asm/kfence.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/include/asm/kfence.h b/arch/arm64/include/asm/kfence.h
index d061176d57ea..aa855c6a0ae6 100644
--- a/arch/arm64/include/asm/kfence.h
+++ b/arch/arm64/include/asm/kfence.h
@@ -8,7 +8,7 @@
 #ifndef __ASM_KFENCE_H
 #define __ASM_KFENCE_H
 
-#include <asm/cacheflush.h>
+#include <asm/set_memory.h>
 
 static inline bool arch_kfence_init_pool(void) { return true; }
 
-- 
2.29.2

