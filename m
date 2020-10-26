Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6875F2991C2
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Oct 2020 17:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1784749AbgJZQEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Oct 2020 12:04:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:49726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1784726AbgJZQEL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Oct 2020 12:04:11 -0400
Received: from localhost.localdomain (unknown [192.30.34.233])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9C5DD22404;
        Mon, 26 Oct 2020 16:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603728251;
        bh=HlB1zaoFuRMGCdaDNNAZvzmGOoVHmTnVBcWp1V7NiQQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uf7jR+yFfikMs/73GGwsZJlpMz/OwaIUKlrvw5M0KFy+6NcKYoeWr6KDEvsXtAtBg
         QKEjMIuuRrIu4G3aBddBkMSqM1sddejT7P+K91o23SYaecfZDQ65rx8gY0+p5mHkR/
         Ch2LvANUf/p2ibniBqi4WULEetd+6bjNnHSD8AkI=
From:   Arnd Bergmann <arnd@kernel.org>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Mark Rutland <mark.rutland@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Steven Price <steven.price@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/4] arm64: avoid -Woverride-init warning
Date:   Mon, 26 Oct 2020 17:03:30 +0100
Message-Id: <20201026160342.3705327-3-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201026160342.3705327-1-arnd@kernel.org>
References: <20201026160342.3705327-1-arnd@kernel.org>
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
 arch/arm64/kernel/cpuinfo.c    | 5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

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
index 6a7bb3729d60..b63269c7fcdb 100644
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
@@ -335,6 +335,7 @@ static void cpuinfo_detect_icache_policy(struct cpuinfo_arm64 *info)
 		set_bit(ICACHEF_VPIPT, &__icache_flags);
 		break;
 	default:
+	case ICACHE_POLICY_RESERVED:
 	case ICACHE_POLICY_VIPT:
 		/* Assume aliasing */
 		set_bit(ICACHEF_ALIASING, &__icache_flags);
-- 
2.27.0

