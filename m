Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6004F2E1AB7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Dec 2020 11:05:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728457AbgLWKFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Dec 2020 05:05:16 -0500
Received: from foss.arm.com ([217.140.110.172]:48056 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728388AbgLWKFP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Dec 2020 05:05:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AB6B41478;
        Wed, 23 Dec 2020 02:04:07 -0800 (PST)
Received: from p8cg001049571a15.blr.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E85483F718;
        Wed, 23 Dec 2020 02:04:04 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
Cc:     linux-kernel@vger.kernel.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Linu Cherian <lcherian@marvell.com>
Subject: [PATCH 08/11] coresight: core: Add support for dedicated percpu sinks
Date:   Wed, 23 Dec 2020 15:33:40 +0530
Message-Id: <1608717823-18387-9-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1608717823-18387-1-git-send-email-anshuman.khandual@arm.com>
References: <1608717823-18387-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for dedicated sinks that are bound to individual CPUs. (e.g,
TRBE). To allow quicker access to the sink for a given CPU bound source,
keep a percpu array of the sink devices. Also, add support for building
a path to the CPU local sink from the ETM.

This adds a new percpu sink type CORESIGHT_DEV_SUBTYPE_SINK_PERCPU_SYSMEM.
This new sink type is exclusively available and can only work with percpu
source type device CORESIGHT_DEV_SUBTYPE_SOURCE_PERCPU_PROC.

This defines a percpu structure that accommodates a single coresight_device
which can be used to store an initialized instance from a sink driver. As
these sinks are exclusively linked and dependent on corresponding percpu
sources devices, they should also be the default sink device during a perf
session.

Outwards device connections are scanned while establishing paths between a
source and a sink device. But such connections are not present for certain
percpu source and sink devices which are exclusively linked and dependent.
Build the path directly and skip connection scanning for such devices.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Mike Leach <mike.leach@linaro.org>
Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
Changes in V1:

- Replaced post init ETE-TRBE link configuration with dynamic path creation

 drivers/hwtracing/coresight/coresight-core.c | 14 ++++++++++++++
 include/linux/coresight.h                    | 12 ++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
index 0062c89..b300606 100644
--- a/drivers/hwtracing/coresight/coresight-core.c
+++ b/drivers/hwtracing/coresight/coresight-core.c
@@ -23,6 +23,7 @@
 #include "coresight-priv.h"
 
 static DEFINE_MUTEX(coresight_mutex);
+DEFINE_PER_CPU(struct coresight_device *, csdev_sink);
 
 /**
  * struct coresight_node - elements of a path, from source to sink
@@ -784,6 +785,13 @@ static int _coresight_build_path(struct coresight_device *csdev,
 	if (csdev == sink)
 		goto out;
 
+	if (coresight_is_percpu_source(csdev) && coresight_is_percpu_sink(sink) &&
+	    sink == per_cpu(csdev_sink, source_ops(csdev)->cpu_id(csdev))) {
+		_coresight_build_path(sink, sink, path);
+		found = true;
+		goto out;
+	}
+
 	/* Not a sink - recursively explore each port found on this element */
 	for (i = 0; i < csdev->pdata->nr_outport; i++) {
 		struct coresight_device *child_dev;
@@ -998,6 +1006,12 @@ coresight_find_default_sink(struct coresight_device *csdev)
 {
 	int depth = 0;
 
+	if (coresight_is_percpu_source(csdev)) {
+		csdev->def_sink = per_cpu(csdev_sink, source_ops(csdev)->cpu_id(csdev));
+		if (csdev->def_sink)
+			return csdev->def_sink;
+	}
+
 	/* look for a default sink if we have not found for this device */
 	if (!csdev->def_sink)
 		csdev->def_sink = coresight_find_sink(csdev, &depth);
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index 951ba88..2aee12e 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -50,6 +50,7 @@ enum coresight_dev_subtype_sink {
 	CORESIGHT_DEV_SUBTYPE_SINK_PORT,
 	CORESIGHT_DEV_SUBTYPE_SINK_BUFFER,
 	CORESIGHT_DEV_SUBTYPE_SINK_SYSMEM,
+	CORESIGHT_DEV_SUBTYPE_SINK_PERCPU_SYSMEM,
 };
 
 enum coresight_dev_subtype_link {
@@ -432,6 +433,17 @@ static inline void csdev_access_write64(struct csdev_access *csa, u64 val, u32 o
 		csa->write(val, offset, false, true);
 }
 
+static inline bool coresight_is_percpu_source(struct coresight_device *csdev)
+{
+	return csdev && (csdev->type == CORESIGHT_DEV_TYPE_SOURCE) &&
+	       csdev->subtype.source_subtype == CORESIGHT_DEV_SUBTYPE_SOURCE_PROC;
+}
+
+static inline bool coresight_is_percpu_sink(struct coresight_device *csdev)
+{
+	return csdev && (csdev->type == CORESIGHT_DEV_TYPE_SINK) &&
+	       csdev->subtype.sink_subtype == CORESIGHT_DEV_SUBTYPE_SINK_PERCPU_SYSMEM;
+}
 #else	/* !CONFIG_64BIT */
 
 static inline u64 csdev_access_relaxed_read64(struct csdev_access *csa,
-- 
2.7.4

