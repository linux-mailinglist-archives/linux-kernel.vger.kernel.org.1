Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B470276F4A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 13:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727407AbgIXLGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 07:06:13 -0400
Received: from foss.arm.com ([217.140.110.172]:42190 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbgIXLGM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 07:06:12 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D16C01396;
        Thu, 24 Sep 2020 04:06:11 -0700 (PDT)
Received: from monolith.localdoman (unknown [10.37.8.98])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3B97B3F73B;
        Thu, 24 Sep 2020 04:06:09 -0700 (PDT)
From:   Alexandru Elisei <alexandru.elisei@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, sumit.garg@linaro.org, maz@kernel.org,
        swboyd@chromium.org, catalin.marinas@arm.com, will@kernel.org,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Julien Thierry <julien.thierry@arm.com>
Subject: [PATCH v7 1/7] arm64: perf: Add missing ISB in armv8pmu_enable_counter()
Date:   Thu, 24 Sep 2020 12:07:00 +0100
Message-Id: <20200924110706.254996-2-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200924110706.254996-1-alexandru.elisei@arm.com>
References: <20200924110706.254996-1-alexandru.elisei@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Writes to the PMXEVTYPER_EL0 register are not self-synchronising. In
armv8pmu_enable_event(), the PE can reorder configuring the event type
after we have enabled the counter and the interrupt. This can lead to an
interrupt being asserted because of the previous event type that we were
counting using the same counter, not the one that we've just configured.

The same rationale applies to writes to the PMINTENSET_EL1 register. The PE
can reorder enabling the interrupt at any point in the future after we have
enabled the event.

Prevent both situations from happening by adding an ISB just before we
enable the event counter.

Cc: Julien Thierry <julien.thierry.kdev@gmail.com>
Cc: Will Deacon <will.deacon@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Fixes: 030896885ade ("arm64: Performance counters support")
Reported-by: Julien Thierry <julien.thierry@arm.com>
Tested-by: Sumit Garg <sumit.garg@linaro.org> (Developerbox)
Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 arch/arm64/kernel/perf_event.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 462f9a9cc44b..481d48e3872b 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -532,6 +532,11 @@ static u32 armv8pmu_event_cnten_mask(struct perf_event *event)
 
 static inline void armv8pmu_enable_counter(u32 mask)
 {
+	/*
+	 * Make sure event configuration register writes are visible before we
+	 * enable the counter.
+	 * */
+	isb();
 	write_sysreg(mask, pmcntenset_el0);
 }
 
-- 
2.28.0

