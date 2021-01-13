Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60FFF2F42FF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jan 2021 05:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbhAMETK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jan 2021 23:19:10 -0500
Received: from foss.arm.com ([217.140.110.172]:57868 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725877AbhAMETJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jan 2021 23:19:09 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E53241063;
        Tue, 12 Jan 2021 20:18:23 -0800 (PST)
Received: from p8cg001049571a15.blr.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 39A7C3F719;
        Tue, 12 Jan 2021 20:18:20 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        mike.leach@linaro.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Linu Cherian <lcherian@marvell.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 01/11] coresight: etm-perf: Allow an event to use different sinks
Date:   Wed, 13 Jan 2021 09:48:08 +0530
Message-Id: <1610511498-4058-2-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1610511498-4058-1-git-send-email-anshuman.khandual@arm.com>
References: <1610511498-4058-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

When there are multiple sinks on the system, in the absence
of a specified sink, it is quite possible that a default sink
for an ETM could be different from that of another ETM. However
we do not support having multiple sinks for an event yet. This
patch allows the event to use the default sinks on the ETMs
where they are scheduled as long as the sinks are of the same
type.

e.g, if we have 1x1 topology with per-CPU ETRs, the event can
use the per-CPU ETR for the session. However, if the sinks
are of different type, e.g TMC-ETR on one and a custom sink
on another, the event will only trace on the first detected
sink.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Tested-by: Linu Cherian <lcherian@marvell.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c | 48 +++++++++++++++++++-----
 1 file changed, 38 insertions(+), 10 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index bdc34ca..eb9e7e9 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -204,6 +204,13 @@ static void etm_free_aux(void *data)
 	schedule_work(&event_data->work);
 }
 
+static bool sinks_match(struct coresight_device *a, struct coresight_device *b)
+{
+	if (!a || !b)
+		return false;
+	return (sink_ops(a) == sink_ops(b));
+}
+
 static void *etm_setup_aux(struct perf_event *event, void **pages,
 			   int nr_pages, bool overwrite)
 {
@@ -212,6 +219,7 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
 	cpumask_t *mask;
 	struct coresight_device *sink = NULL;
 	struct etm_event_data *event_data = NULL;
+	bool sink_forced = false;
 
 	event_data = alloc_event_data(cpu);
 	if (!event_data)
@@ -222,6 +230,7 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
 	if (event->attr.config2) {
 		id = (u32)event->attr.config2;
 		sink = coresight_get_sink_by_id(id);
+		sink_forced = true;
 	}
 
 	mask = &event_data->mask;
@@ -235,7 +244,7 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
 	 */
 	for_each_cpu(cpu, mask) {
 		struct list_head *path;
-		struct coresight_device *csdev;
+		struct coresight_device *csdev, *new_sink;
 
 		csdev = per_cpu(csdev_src, cpu);
 		/*
@@ -249,21 +258,35 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
 		}
 
 		/*
-		 * No sink provided - look for a default sink for one of the
-		 * devices. At present we only support topology where all CPUs
-		 * use the same sink [N:1], so only need to find one sink. The
-		 * coresight_build_path later will remove any CPU that does not
-		 * attach to the sink, or if we have not found a sink.
+		 * No sink provided - look for a default sink for all the devices.
+		 * We only support multiple sinks, only if all the default sinks
+		 * are of the same type, so that the sink buffer can be shared
+		 * as the event moves around. We don't trace on a CPU if it can't
+		 *
 		 */
-		if (!sink)
-			sink = coresight_find_default_sink(csdev);
+		if (!sink_forced) {
+			new_sink = coresight_find_default_sink(csdev);
+			if (!new_sink) {
+				cpumask_clear_cpu(cpu, mask);
+				continue;
+			}
+			/* Skip checks for the first sink */
+			if (!sink) {
+			       sink = new_sink;
+			} else if (!sinks_match(new_sink, sink)) {
+				cpumask_clear_cpu(cpu, mask);
+				continue;
+			}
+		} else {
+			new_sink = sink;
+		}
 
 		/*
 		 * Building a path doesn't enable it, it simply builds a
 		 * list of devices from source to sink that can be
 		 * referenced later when the path is actually needed.
 		 */
-		path = coresight_build_path(csdev, sink);
+		path = coresight_build_path(csdev, new_sink);
 		if (IS_ERR(path)) {
 			cpumask_clear_cpu(cpu, mask);
 			continue;
@@ -284,7 +307,12 @@ static void *etm_setup_aux(struct perf_event *event, void **pages,
 	if (!sink_ops(sink)->alloc_buffer || !sink_ops(sink)->free_buffer)
 		goto err;
 
-	/* Allocate the sink buffer for this session */
+	/*
+	 * Allocate the sink buffer for this session. All the sinks
+	 * where this event can be scheduled are ensured to be of the
+	 * same type. Thus the same sink configuration is used by the
+	 * sinks.
+	 */
 	event_data->snk_config =
 			sink_ops(sink)->alloc_buffer(sink, event, pages,
 						     nr_pages, overwrite);
-- 
2.7.4

