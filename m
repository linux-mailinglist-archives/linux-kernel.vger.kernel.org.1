Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 366D9300710
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jan 2021 16:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbhAVPWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jan 2021 10:22:02 -0500
Received: from foss.arm.com ([217.140.110.172]:52824 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728818AbhAVPTn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jan 2021 10:19:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1753811D4;
        Fri, 22 Jan 2021 07:18:41 -0800 (PST)
Received: from ewhatever.cambridge.arm.com (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2DE803F66E;
        Fri, 22 Jan 2021 07:18:39 -0800 (PST)
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        Ingo Molnar <mingo@redhat.com>, will@kernel.org,
        mark.rutland@arm.com, mike.leach@linaro.org, al.grant@arm.com,
        anshuman.khandual@arm.com, mathieu.poirier@linaro.org,
        linux-arm-kernel@lists.infradead.org, jolsa@redhat.com,
        acme@kernel.org, Suzuki K Poulose <suzuki.poulose@arm.com>
Subject: [RFC PATCH 0/1] perf: Handle multiple formatted AUX records
Date:   Fri, 22 Jan 2021 15:18:28 +0000
Message-Id: <20210122151829.2890484-1-suzuki.poulose@arm.com>
X-Mailer: git-send-email 2.24.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an RFC patch to explore the solution to a problem we have
in the CoreSight ETM/ETE PMU.

CoreSight ETM trace allows instruction level tracing of Arm CPUs.
The ETM generates the CPU excecution trace and pumps it into CoreSight
AMBA Trace Bus and is collected by a different CoreSight component
(traditionally CoreSight TMC-ETR /ETB/ETF), called "sink".
Important to note that there is no guarantee that every CPU has
a dedicated sink.  Thus multiple ETMs could pump the trace data
into the same "sink" and thus they apply additional formatting
of the trace data for the user to decode it properly and attribute
the trace data to the corresponding ETM.

However, with the introduction of Arm Trace buffer Extensions (TRBE),
we now have a dedicated per-CPU architected sink for collecting the
trace. Since the TRBE is always per-CPU, it doesn't apply any formatting
of the trace. The support for this driver is under review [1].

Now a system could have a per-cpu TRBE and one or more shared
TMC-ETRs on the system. A user could choose a "specific" sink
for a perf session (e.g, a TMC-ETR) or the driver could automatically
select the nearest sink for a given ETM. It is possible that
some ETMs could end up using TMC-ETR (e.g, if the TRBE is not
usable on the CPU) while the others using TRBE in a single
perf session. Thus we now have "formatted" trace collected
from TMC-ETR and "unformatted" trace collected from TRBE.
However, we don't get into a situation where a single event
could end up using TMC-ETR & TRBE. i.e, any AUX buffer is
guaranteed to be either RAW or FORMATTED, but not a mix
of both.

As for perf decoding, we need to know the type of the data
in the individual AUX buffers, so that it can set up the
"OpenCSD" (library for decoding CoreSight trace) decoder
instance appropriately. Thus the perf.data file must conatin
the hints for the tool to decode the data correctly.

Since this is a runtime variable, and perf tool doesn't have
a control on what sink gets used (in case of automatic sink
selection), we need this information made available from
the PMU driver for each AUX record.

This patch is an attempt to solve the problem by, adding an
AUX flag for each AUX record to indicate the type of the
trace in them. It can be defined as a PMU specific flag,
which each PMU could interpret in its on way (e.g,
PERF_AUX_FLAG_PMU_FLAG_1 or could be a dedicated
flag for the CoreSight in a "generic" form
PERF_AUX_FLAG_ALT_FMT (Thanks Mike Leach for the name).

We are looking for suggestions on how best to solve this
problem and happy to explore other options if there is
a preferred way of solving this.

[1] https://lkml.kernel.org/r/1610511498-4058-1-git-send-email-anshuman.khandual@arm.com

Suzuki K Poulose (1):
  perf: Handle multiple formatted AUX records

 drivers/hwtracing/coresight/coresight-etm-perf.c | 2 ++
 include/linux/coresight.h                        | 1 +
 include/uapi/linux/perf_event.h                  | 1 +
 3 files changed, 4 insertions(+)

-- 
2.24.1

