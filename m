Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65427276F5A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Sep 2020 13:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727556AbgIXLGm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Sep 2020 07:06:42 -0400
Received: from foss.arm.com ([217.140.110.172]:42258 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727461AbgIXLGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Sep 2020 07:06:21 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A3D81529;
        Thu, 24 Sep 2020 04:06:20 -0700 (PDT)
Received: from monolith.localdoman (unknown [10.37.8.98])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B94283F73B;
        Thu, 24 Sep 2020 04:06:17 -0700 (PDT)
From:   Alexandru Elisei <alexandru.elisei@arm.com>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     mark.rutland@arm.com, sumit.garg@linaro.org, maz@kernel.org,
        swboyd@chromium.org, catalin.marinas@arm.com, will@kernel.org,
        Julien Thierry <julien.thierry@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Will Deacon <will.deacon@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>
Subject: [PATCH v7 4/7] arm64: perf: Defer irq_work to IPI_IRQ_WORK
Date:   Thu, 24 Sep 2020 12:07:03 +0100
Message-Id: <20200924110706.254996-5-alexandru.elisei@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200924110706.254996-1-alexandru.elisei@arm.com>
References: <20200924110706.254996-1-alexandru.elisei@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Julien Thierry <julien.thierry@arm.com>

When handling events, armv8pmu_handle_irq() calls perf_event_overflow(),
and subsequently calls irq_work_run() to handle any work queued by
perf_event_overflow(). As perf_event_overflow() raises IPI_IRQ_WORK when
queuing the work, this isn't strictly necessary and the work could be
handled as part of the IPI_IRQ_WORK handler.

In the common case the IPI handler will run immediately after the PMU IRQ
handler, and where the PE is heavily loaded with interrupts other handlers
may run first, widening the window where some counters are disabled.

In practice this window is unlikely to be a significant issue, and removing
the call to irq_work_run() would make the PMU IRQ handler NMI safe in
addition to making it simpler, so let's do that.

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
Signed-off-by: Julien Thierry <julien.thierry@arm.com>
[Alexandru E.: Reworded commit message]
Signed-off-by: Alexandru Elisei <alexandru.elisei@arm.com>
---
 arch/arm64/kernel/perf_event.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/arm64/kernel/perf_event.c b/arch/arm64/kernel/perf_event.c
index 610500166f90..ef206fb146b9 100644
--- a/arch/arm64/kernel/perf_event.c
+++ b/arch/arm64/kernel/perf_event.c
@@ -783,20 +783,16 @@ static irqreturn_t armv8pmu_handle_irq(struct arm_pmu *cpu_pmu)
 		if (!armpmu_event_set_period(event))
 			continue;
 
+		/*
+		 * Perf event overflow will queue the processing of the event as
+		 * an irq_work which will be taken care of in the handling of
+		 * IPI_IRQ_WORK.
+		 */
 		if (perf_event_overflow(event, &data, regs))
 			cpu_pmu->disable(event);
 	}
 	armv8pmu_start(cpu_pmu);
 
-	/*
-	 * Handle the pending perf events.
-	 *
-	 * Note: this call *must* be run with interrupts disabled. For
-	 * platforms that can have the PMU interrupts raised as an NMI, this
-	 * will not work.
-	 */
-	irq_work_run();
-
 	return IRQ_HANDLED;
 }
 
-- 
2.28.0

