Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D00E224A01F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Aug 2020 15:35:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728679AbgHSNff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Aug 2020 09:35:35 -0400
Received: from foss.arm.com ([217.140.110.172]:36876 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728499AbgHSNdb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 09:33:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9224A1063;
        Wed, 19 Aug 2020 06:33:30 -0700 (PDT)
Received: from monolith.localdoman (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6D3FA3F71F;
        Wed, 19 Aug 2020 06:33:28 -0700 (PDT)
From:   Alexandru Elisei <alexandru.elisei@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, maz@kernel.org, will@kernel.org,
        catalin.marinas@arm.com, swboyd@chromium.org,
        sumit.garg@linaro.org,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Julien Thierry <julien.thierry@arm.com>
Subject: [PATCH v6 1/7] arm64: perf: Add missing ISB in armv8pmu_enable_event()
Date:   Wed, 19 Aug 2020 14:34:13 +0100
Message-Id: <20200819133419.526889-2-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200819133419.526889-1-alexandru.elisei@arm.com>
References: <20200819133419.526889-1-alexandru.elisei@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
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
Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 arch/arm64/kernel/perf_event.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 462f9a9cc44b..878e7087be02 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -632,8 +632,10 @@ static void armv8pmu_enable_event(struct perf_event *event)
 	armv8pmu_enable_event_irq(event);
 
 	/*
-	 * Enable counter
+	 * Enable counter. Make sure event configuration register writes are
+	 * visible before we enable the counter.
 	 */
+	isb();
 	armv8pmu_enable_event_counter(event);
 
 	raw_spin_unlock_irqrestore(&events->pmu_lock, flags);
-- 
2.28.0

