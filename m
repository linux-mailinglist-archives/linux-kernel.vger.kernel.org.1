Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48B4C2F414D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 02:42:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbhAMBmf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 20:42:35 -0500
Received: from foss.arm.com ([217.140.110.172]:56528 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbhAMBme (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 20:42:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C914106F;
        Tue, 12 Jan 2021 17:41:48 -0800 (PST)
Received: from entos-ampere-02.shanghai.arm.com (entos-ampere-02.shanghai.arm.com [10.169.214.110])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 857DD3F70D;
        Tue, 12 Jan 2021 17:41:42 -0800 (PST)
From:   Jia He <justin.he@arm.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Jia He <justin.he@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Richard Henderson <richard.henderson@linaro.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Steven Price <steven.price@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Mike Rapoport <rppt@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>,
        Gavin Shan <gshan@redhat.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Mark Brown <broonie@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>
Subject: [RFC PATCH 2/2] arm64: kpti: Update arm64_use_ng_mappings before pagetable mapping
Date:   Wed, 13 Jan 2021 09:40:47 +0800
Message-Id: <20210113014047.14371-3-justin.he@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210113014047.14371-1-justin.he@arm.com>
References: <20210113014047.14371-1-justin.he@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a 10s stall in idmap_kpti_install_ng_mappings when kernel boots
on a Ampere EMAG server.

Commit f992b4dfd58b ("arm64: kpti: Add ->enable callback to remap
swapper using nG mappings") updates the nG bit runtime if kpti is required.
But things get worse if rodata=full in map_mem(). NO_BLOCK_MAPPINGS |
NO_CONT_MAPPINGS is required when creating pagetable mapping. Hence all
ptes are fully mapped in this case. On a Ampere EMAG server with 256G
memory(pagesize=4k), it causes the 10s stall.

After previous commit moving init_cpu_features(), we can use
cpu_have_const_cap earlier than before. Hence we can avoid this stall
by updating arm64_use_ng_mappings.

Signed-off-by: Jia He <justin.he@arm.com>
---
 arch/arm64/kernel/setup.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
index e078ab068f3b..51098ceb7159 100644
--- a/arch/arm64/kernel/setup.c
+++ b/arch/arm64/kernel/setup.c
@@ -306,6 +306,10 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
 	/* Init the cpu feature codes for boot cpu */
 	cpuinfo_store_boot_cpu();
 
+	/* ARM64_UNMAP_KERNEL_AT_EL0 cap can be updated in cpuinfo_store_boot_cpu() */
+	if (!arm64_use_ng_mappings)
+		arm64_use_ng_mappings = cpus_have_const_cap(ARM64_UNMAP_KERNEL_AT_EL0);
+
 	early_fixmap_init();
 	early_ioremap_init();
 
-- 
2.17.1

