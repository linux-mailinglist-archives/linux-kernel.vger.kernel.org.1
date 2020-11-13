Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E318C2B1F42
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Nov 2020 16:53:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgKMPxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Nov 2020 10:53:52 -0500
Received: from foss.arm.com ([217.140.110.172]:40614 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726336AbgKMPxv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Nov 2020 10:53:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 12CE41042;
        Fri, 13 Nov 2020 07:53:51 -0800 (PST)
Received: from e108754-lin.cambridge.arm.com (unknown [10.1.198.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E3A483F718;
        Fri, 13 Nov 2020 07:53:49 -0800 (PST)
From:   Ionela Voinescu <ionela.voinescu@arm.com>
To:     catalin.marinas@arm.com, mark.rutland@arm.com,
        sudeep.holla@arm.com, will@kernel.org
Cc:     morten.rasmussen@arm.com, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, ionela.voinescu@arm.com
Subject: [PATCH] arm64: abort counter_read_on_cpu() when irqs_disabled()
Date:   Fri, 13 Nov 2020 15:53:28 +0000
Message-Id: <20201113155328.4194-1-ionela.voinescu@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201106125334.21570-1-ionela.voinescu@arm.com>
References: <20201106125334.21570-1-ionela.voinescu@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Given that smp_call_function_single() can deadlock when interrupts are
disabled, abort the SMP call if irqs_disabled(). This scenario is
currently not possible given the function's uses, but safeguard this for
potential future uses.

Signed-off-by: Ionela Voinescu <ionela.voinescu@arm.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/kernel/topology.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/topology.c b/arch/arm64/kernel/topology.c
index 3a083a9a8ef2..e387188741f2 100644
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -343,7 +343,11 @@ static void cpu_read_constcnt(void *val)
 static inline
 int counters_read_on_cpu(int cpu, smp_call_func_t func, u64 *val)
 {
-	if (!cpu_has_amu_feat(cpu))
+	/*
+	 * Abort call on counterless CPU or when interrupts are
+	 * disabled - can lead to deadlock in smp sync call.
+	 */
+	if (!cpu_has_amu_feat(cpu) || unlikely(irqs_disabled()))
 		return -EOPNOTSUPP;
 
 	smp_call_function_single(cpu, func, val, 1);
-- 
2.17.1

