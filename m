Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D52D2284E91
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Oct 2020 17:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgJFPEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 11:04:16 -0400
Received: from foss.arm.com ([217.140.110.172]:49796 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725902AbgJFPEQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 11:04:16 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5B7F3113E;
        Tue,  6 Oct 2020 08:04:15 -0700 (PDT)
Received: from monolith.localdoman (unknown [10.37.12.66])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A69653F71F;
        Tue,  6 Oct 2020 08:04:13 -0700 (PDT)
From:   Alexandru Elisei <alexandru.elisei@arm.com>
To:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org
Cc:     maz@kernel.org, james.morse@arm.com, julien.thierry.kdev@gmail.com,
        suzuki.poulose@arm.com, catalin.marinas@arm.com, will@kernel.org,
        mark.rutland@arm.com
Subject: [PATCH] perf: arm_spe: Use Inner Shareable DSB when draining the buffer
Date:   Tue,  6 Oct 2020 16:05:20 +0100
Message-Id: <20201006150520.161985-1-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From ARM DDI 0487F.b, page D9-2807:

"Although the Statistical Profiling Extension acts as another observer in
the system, for determining the Shareability domain of the DSB
instructions, the writes of sample records are treated as coming from the
PE that is being profiled."

Similarly, on page D9-2801:

"The memory type and attributes that are used for a write by the
Statistical Profiling Extension to the Profiling Buffer is taken from the
translation table entries for the virtual address being written to. That
is:
- The writes are treated as coming from an observer that is coherent with
  all observers in the Shareability domain that is defined by the
  translation tables."

All the PEs are in the Inner Shareable domain, use a DSB ISH to make sure
writes to the profiling buffer have completed.

Fixes: d5d9696b0380 ("drivers/perf: Add support for ARMv8.2 Statistical Profiling Extension")
Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
Found by code inspection.

All the places where the buffer was drained were found by using the command
"grep -r psb_csync".

 arch/arm64/kvm/hyp/nvhe/debug-sr.c | 2 +-
 drivers/perf/arm_spe_pmu.c         | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/kvm/hyp/nvhe/debug-sr.c b/arch/arm64/kvm/hyp/nvhe/debug-sr.c
index 91a711aa8382..e05a08c5ad1f 100644
--- a/arch/arm64/kvm/hyp/nvhe/debug-sr.c
+++ b/arch/arm64/kvm/hyp/nvhe/debug-sr.c
@@ -43,7 +43,7 @@ static void __debug_save_spe(u64 *pmscr_el1)
 
 	/* Now drain all buffered data to memory */
 	psb_csync();
-	dsb(nsh);
+	dsb(ish);
 }
 
 static void __debug_restore_spe(u64 pmscr_el1)
diff --git a/drivers/perf/arm_spe_pmu.c b/drivers/perf/arm_spe_pmu.c
index cc00915ad6d1..402892caef34 100644
--- a/drivers/perf/arm_spe_pmu.c
+++ b/drivers/perf/arm_spe_pmu.c
@@ -525,7 +525,7 @@ static void arm_spe_pmu_disable_and_drain_local(void)
 
 	/* Drain any buffered data */
 	psb_csync();
-	dsb(nsh);
+	dsb(ish);
 
 	/* Disable the profiling buffer */
 	write_sysreg_s(0, SYS_PMBLIMITR_EL1);
@@ -545,7 +545,7 @@ arm_spe_pmu_buf_get_fault_act(struct perf_output_handle *handle)
 	 * aborts have been resolved.
 	 */
 	psb_csync();
-	dsb(nsh);
+	dsb(ish);
 
 	/* Ensure hardware updates to PMBPTR_EL1 are visible */
 	isb();
-- 
2.28.0

