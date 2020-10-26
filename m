Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55338299723
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 20:38:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1786028AbgJZTiP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 15:38:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:40884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1785727AbgJZTiO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 15:38:14 -0400
Received: from localhost.localdomain (unknown [192.30.34.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 163D720760;
        Mon, 26 Oct 2020 19:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603741093;
        bh=CVVfhj02cmHbdP0P+NzKNKUmqyFb56ji/LkfMW9dIKY=;
        h=From:To:Cc:Subject:Date:From;
        b=EXymziehrOzSmP9nWeYagSisgRzY54TjSUcEnigl3Ijoj0FpJVGxil+IJvqm4ZzcK
         dkFPKPWUMcfISevnIdZ8oYl02wDkYshfV5DnyGhBnw4K6dXJBnd5cSTobZ9HPnb9ww
         qG4dycoN8pU7UvbcqcxZUvEM5q+s75cfK5umk+sM=
From:   Arnd Bergmann <arnd@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Will Deacon <will.deacon@arm.com>,
        James Morse <james.morse@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] arm64: avoid -Woverride-init warning
Date:   Mon, 26 Oct 2020 20:37:46 +0100
Message-Id: <20201026193807.3816388-1-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The icache_policy_str[] definition causes a warning when extra
warning flags are enabled:

arch/arm64/kernel/cpuinfo.c:38:26: warning: initialized field overwritten [-Woverride-init]
   38 |  [ICACHE_POLICY_VIPT]  = "VIPT",
      |                          ^~~~~~
arch/arm64/kernel/cpuinfo.c:38:26: note: (near initialization for 'icache_policy_str[2]')
arch/arm64/kernel/cpuinfo.c:39:26: warning: initialized field overwritten [-Woverride-init]
   39 |  [ICACHE_POLICY_PIPT]  = "PIPT",
      |                          ^~~~~~
arch/arm64/kernel/cpuinfo.c:39:26: note: (near initialization for 'icache_policy_str[3]')
arch/arm64/kernel/cpuinfo.c:40:27: warning: initialized field overwritten [-Woverride-init]
   40 |  [ICACHE_POLICY_VPIPT]  = "VPIPT",
      |                           ^~~~~~~
arch/arm64/kernel/cpuinfo.c:40:27: note: (near initialization for 'icache_policy_str[0]')

There is no real need for the default initializer here, as printing a
NULL string is harmless. Rewrite the logic to have an explicit
reserved value for the only one that uses the default value.

This partially reverts the commit that removed ICACHE_POLICY_AIVIVT.

Fixes: 155433cb365e ("arm64: cache: Remove support for ASID-tagged VIVT I-caches")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm64/include/asm/cache.h | 1 +
 arch/arm64/kernel/cpuinfo.c    | 7 ++++---
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/include/asm/cache.h b/arch/arm64/include/asm/cache.h
index a4d1b5f771f6..16e1e16e7e61 100644
--- a/arch/arm64/include/asm/cache.h
+++ b/arch/arm64/include/asm/cache.h
@@ -24,6 +24,7 @@
 #define CTR_L1IP(ctr)		(((ctr) >> CTR_L1IP_SHIFT) & CTR_L1IP_MASK)
 
 #define ICACHE_POLICY_VPIPT	0
+#define ICACHE_POLICY_RESERVED	1
 #define ICACHE_POLICY_VIPT	2
 #define ICACHE_POLICY_PIPT	3
 
diff --git a/arch/arm64/kernel/cpuinfo.c b/arch/arm64/kernel/cpuinfo.c
index 6a7bb3729d60..77605aec25fe 100644
--- a/arch/arm64/kernel/cpuinfo.c
+++ b/arch/arm64/kernel/cpuinfo.c
@@ -34,10 +34,10 @@ DEFINE_PER_CPU(struct cpuinfo_arm64, cpu_data);
 static struct cpuinfo_arm64 boot_cpu_data;
 
 static const char *icache_policy_str[] = {
-	[0 ... ICACHE_POLICY_PIPT]	= "RESERVED/UNKNOWN",
+	[ICACHE_POLICY_VPIPT]		= "VPIPT",
+	[ICACHE_POLICY_RESERVED]	= "RESERVED/UNKNOWN",
 	[ICACHE_POLICY_VIPT]		= "VIPT",
 	[ICACHE_POLICY_PIPT]		= "PIPT",
-	[ICACHE_POLICY_VPIPT]		= "VPIPT",
 };
 
 unsigned long __icache_flags;
@@ -334,10 +334,11 @@ static void cpuinfo_detect_icache_policy(struct cpuinfo_arm64 *info)
 	case ICACHE_POLICY_VPIPT:
 		set_bit(ICACHEF_VPIPT, &__icache_flags);
 		break;
-	default:
+	case ICACHE_POLICY_RESERVED:
 	case ICACHE_POLICY_VIPT:
 		/* Assume aliasing */
 		set_bit(ICACHEF_ALIASING, &__icache_flags);
+		break;
 	}
 
 	pr_info("Detected %s I-cache on CPU%d\n", icache_policy_str[l1ip], cpu);
-- 
2.27.0

