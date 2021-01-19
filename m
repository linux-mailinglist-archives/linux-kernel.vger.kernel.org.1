Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A50D2FBE32
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jan 2021 18:48:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390486AbhASRrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jan 2021 12:47:45 -0500
Received: from foss.arm.com ([217.140.110.172]:34334 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732521AbhASOsP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jan 2021 09:48:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 13BADD6E;
        Tue, 19 Jan 2021 06:47:27 -0800 (PST)
Received: from e121896.arm.com (unknown [10.57.56.227])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id A5BFF3F66E;
        Tue, 19 Jan 2021 06:47:22 -0800 (PST)
From:   James Clark <james.clark@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>, James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Al Grant <al.grant@arm.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Wei Li <liwei391@huawei.com>,
        Tan Xiaojun <tanxiaojun@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>
Subject: [PATCH 4/8] perf arm-spe: Fill address info for samples
Date:   Tue, 19 Jan 2021 16:46:54 +0200
Message-Id: <20210119144658.793-4-james.clark@arm.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210119144658.793-1-james.clark@arm.com>
References: <20210119144658.793-1-james.clark@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Leo Yan <leo.yan@linaro.org>

To properly handle memory and branch samples, this patch divides into
two functions for generating samples: arm_spe__synth_mem_sample() is for
synthesizing memory and TLB samples; arm_spe__synth_branch_sample() is
to synthesize branch samples.

Arm SPE backend decoder has passed virtual and physical address through
packets, the address info is stored into the synthesize samples in the
function arm_spe__synth_mem_sample().

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Signed-off-by: James Clark <james.clark@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: John Garry <john.garry@huawei.com>
Cc: Will Deacon <will@kernel.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Al Grant <al.grant@arm.com>
Cc: Andre Przywara <andre.przywara@arm.com>
Cc: Wei Li <liwei391@huawei.com>
Cc: Tan Xiaojun <tanxiaojun@huawei.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
---
 tools/perf/util/arm-spe.c | 52 +++++++++++++++++++++++----------------
 1 file changed, 31 insertions(+), 21 deletions(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index b134516e890b..578725344603 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -235,7 +235,6 @@ static void arm_spe_prep_sample(struct arm_spe *spe,
 	sample->cpumode = arm_spe_cpumode(spe, sample->ip);
 	sample->pid = speq->pid;
 	sample->tid = speq->tid;
-	sample->addr = record->to_ip;
 	sample->period = 1;
 	sample->cpu = speq->cpu;
 
@@ -259,18 +258,37 @@ arm_spe_deliver_synth_event(struct arm_spe *spe,
 	return ret;
 }
 
-static int
-arm_spe_synth_spe_events_sample(struct arm_spe_queue *speq,
-				u64 spe_events_id)
+static int arm_spe__synth_mem_sample(struct arm_spe_queue *speq,
+				     u64 spe_events_id)
 {
 	struct arm_spe *spe = speq->spe;
+	struct arm_spe_record *record = &speq->decoder->record;
+	union perf_event *event = speq->event_buf;
+	struct perf_sample sample = { 0 };
+
+	arm_spe_prep_sample(spe, speq, event, &sample);
+
+	sample.id = spe_events_id;
+	sample.stream_id = spe_events_id;
+	sample.addr = record->virt_addr;
+	sample.phys_addr = record->phys_addr;
+
+	return arm_spe_deliver_synth_event(spe, speq, event, &sample);
+}
+
+static int arm_spe__synth_branch_sample(struct arm_spe_queue *speq,
+					u64 spe_events_id)
+{
+	struct arm_spe *spe = speq->spe;
+	struct arm_spe_record *record = &speq->decoder->record;
 	union perf_event *event = speq->event_buf;
-	struct perf_sample sample = { .ip = 0, };
+	struct perf_sample sample = { 0 };
 
 	arm_spe_prep_sample(spe, speq, event, &sample);
 
 	sample.id = spe_events_id;
 	sample.stream_id = spe_events_id;
+	sample.addr = record->to_ip;
 
 	return arm_spe_deliver_synth_event(spe, speq, event, &sample);
 }
@@ -283,15 +301,13 @@ static int arm_spe_sample(struct arm_spe_queue *speq)
 
 	if (spe->sample_flc) {
 		if (record->type & ARM_SPE_L1D_MISS) {
-			err = arm_spe_synth_spe_events_sample(
-					speq, spe->l1d_miss_id);
+			err = arm_spe__synth_mem_sample(speq, spe->l1d_miss_id);
 			if (err)
 				return err;
 		}
 
 		if (record->type & ARM_SPE_L1D_ACCESS) {
-			err = arm_spe_synth_spe_events_sample(
-					speq, spe->l1d_access_id);
+			err = arm_spe__synth_mem_sample(speq, spe->l1d_access_id);
 			if (err)
 				return err;
 		}
@@ -299,15 +315,13 @@ static int arm_spe_sample(struct arm_spe_queue *speq)
 
 	if (spe->sample_llc) {
 		if (record->type & ARM_SPE_LLC_MISS) {
-			err = arm_spe_synth_spe_events_sample(
-					speq, spe->llc_miss_id);
+			err = arm_spe__synth_mem_sample(speq, spe->llc_miss_id);
 			if (err)
 				return err;
 		}
 
 		if (record->type & ARM_SPE_LLC_ACCESS) {
-			err = arm_spe_synth_spe_events_sample(
-					speq, spe->llc_access_id);
+			err = arm_spe__synth_mem_sample(speq, spe->llc_access_id);
 			if (err)
 				return err;
 		}
@@ -315,31 +329,27 @@ static int arm_spe_sample(struct arm_spe_queue *speq)
 
 	if (spe->sample_tlb) {
 		if (record->type & ARM_SPE_TLB_MISS) {
-			err = arm_spe_synth_spe_events_sample(
-					speq, spe->tlb_miss_id);
+			err = arm_spe__synth_mem_sample(speq, spe->tlb_miss_id);
 			if (err)
 				return err;
 		}
 
 		if (record->type & ARM_SPE_TLB_ACCESS) {
-			err = arm_spe_synth_spe_events_sample(
-					speq, spe->tlb_access_id);
+			err = arm_spe__synth_mem_sample(speq, spe->tlb_access_id);
 			if (err)
 				return err;
 		}
 	}
 
 	if (spe->sample_branch && (record->type & ARM_SPE_BRANCH_MISS)) {
-		err = arm_spe_synth_spe_events_sample(speq,
-						      spe->branch_miss_id);
+		err = arm_spe__synth_branch_sample(speq, spe->branch_miss_id);
 		if (err)
 			return err;
 	}
 
 	if (spe->sample_remote_access &&
 	    (record->type & ARM_SPE_REMOTE_ACCESS)) {
-		err = arm_spe_synth_spe_events_sample(speq,
-						      spe->remote_access_id);
+		err = arm_spe__synth_mem_sample(speq, spe->remote_access_id);
 		if (err)
 			return err;
 	}
-- 
2.28.0

