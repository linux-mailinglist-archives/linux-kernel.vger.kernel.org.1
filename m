Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63FD52AD6B5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Nov 2020 13:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732454AbgKJMqd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Nov 2020 07:46:33 -0500
Received: from foss.arm.com ([217.140.110.172]:55180 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732205AbgKJMqW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Nov 2020 07:46:22 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 759CE12FC;
        Tue, 10 Nov 2020 04:46:21 -0800 (PST)
Received: from p8cg001049571a15.blr.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 320383F6CF;
        Tue, 10 Nov 2020 04:46:18 -0800 (PST)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-arm-kernel@lists.infradead.org, coresight@lists.linaro.org
Cc:     linux-kernel@vger.kernel.org, suzuki.poulose@arm.com,
        mathieu.poirier@linaro.org, mike.leach@linaro.org,
        Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [RFC 10/11] coresgith: etm-perf: Connect TRBE sink with ETE source
Date:   Tue, 10 Nov 2020 18:15:08 +0530
Message-Id: <1605012309-24812-11-git-send-email-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1605012309-24812-1-git-send-email-anshuman.khandual@arm.com>
References: <1605012309-24812-1-git-send-email-anshuman.khandual@arm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unlike traditional sink devices, individual TRBE instances are not detected
via DT or ACPI nodes. Instead TRBE instances are detected during CPU online
process. Hence a path connecting ETE and TRBE on a given CPU would not have
been established until then. This adds two coresight helpers that will help
modify outward connections from a source device to establish and terminate
path to a given sink device. But this method might not be optimal and would
be reworked later.

Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 drivers/hwtracing/coresight/coresight-etm-perf.c | 30 ++++++++++++++++++++++++
 drivers/hwtracing/coresight/coresight-etm-perf.h |  4 ++++
 drivers/hwtracing/coresight/coresight-platform.c |  3 ++-
 drivers/hwtracing/coresight/coresight-trbe.c     |  2 ++
 include/linux/coresight.h                        |  2 ++
 5 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
index 1a37991..b4ab1d4 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.c
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
@@ -664,3 +664,33 @@ void __exit etm_perf_exit(void)
 {
 	perf_pmu_unregister(&etm_pmu);
 }
+
+#ifdef CONFIG_CORESIGHT_TRBE
+void coresight_trbe_connect_ete(struct coresight_device *csdev_trbe, int cpu)
+{
+	struct coresight_device *csdev_ete = per_cpu(csdev_src, cpu);
+
+	if (!csdev_ete) {
+		pr_err("Corresponding ETE device not present on cpu %d\n", cpu);
+		return;
+	}
+	csdev_ete->def_sink = csdev_trbe;
+	csdev_ete->pdata->nr_outport++;
+	if (!csdev_ete->pdata->conns)
+		coresight_alloc_conns(&csdev_ete->dev, csdev_ete->pdata);
+	csdev_ete->pdata->conns[csdev_ete->pdata->nr_outport - 1].child_dev = csdev_trbe;
+}
+
+void coresight_trbe_remove_ete(struct coresight_device *csdev_trbe, int cpu)
+{
+	struct coresight_device *csdev_ete = per_cpu(csdev_src, cpu);
+
+	if (!csdev_ete) {
+		pr_err("Corresponding ETE device not present on cpu %d\n", cpu);
+		return;
+	}
+	csdev_ete->pdata->conns[csdev_ete->pdata->nr_outport - 1].child_dev = NULL;
+	csdev_ete->def_sink = NULL;
+	csdev_ete->pdata->nr_outport--;
+}
+#endif
diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.h b/drivers/hwtracing/coresight/coresight-etm-perf.h
index 3e4f2ad..20386cf 100644
--- a/drivers/hwtracing/coresight/coresight-etm-perf.h
+++ b/drivers/hwtracing/coresight/coresight-etm-perf.h
@@ -85,4 +85,8 @@ static inline void *etm_perf_sink_config(struct perf_output_handle *handle)
 int __init etm_perf_init(void);
 void __exit etm_perf_exit(void);
 
+#ifdef CONFIG_CORESIGHT_TRBE
+void coresight_trbe_connect_ete(struct coresight_device *csdev, int cpu);
+void coresight_trbe_remove_ete(struct coresight_device *csdev, int cpu);
+#endif
 #endif
diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
index c594f45..8fa7406 100644
--- a/drivers/hwtracing/coresight/coresight-platform.c
+++ b/drivers/hwtracing/coresight/coresight-platform.c
@@ -23,7 +23,7 @@
  * coresight_alloc_conns: Allocate connections record for each output
  * port from the device.
  */
-static int coresight_alloc_conns(struct device *dev,
+int coresight_alloc_conns(struct device *dev,
 				 struct coresight_platform_data *pdata)
 {
 	if (pdata->nr_outport) {
@@ -35,6 +35,7 @@ static int coresight_alloc_conns(struct device *dev,
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(coresight_alloc_conns);
 
 static struct device *
 coresight_find_device_by_fwnode(struct fwnode_handle *fwnode)
diff --git a/drivers/hwtracing/coresight/coresight-trbe.c b/drivers/hwtracing/coresight/coresight-trbe.c
index 48a8ec3..afd1a1c 100644
--- a/drivers/hwtracing/coresight/coresight-trbe.c
+++ b/drivers/hwtracing/coresight/coresight-trbe.c
@@ -507,6 +507,7 @@ static void arm_trbe_probe_coresight_cpu(void *info)
 	if (IS_ERR(cpudata->csdev))
 		goto cpu_clear;
 
+	coresight_trbe_connect_ete(cpudata->csdev, cpudata->cpu);
 	dev_set_drvdata(&cpudata->csdev->dev, cpudata);
 	cpudata->trbe_dbm = get_trbe_flag_update();
 	cpudata->trbe_align = 1ULL << get_trbe_address_align();
@@ -586,6 +587,7 @@ static int arm_trbe_cpu_teardown(unsigned int cpu, struct hlist_node *node)
 
 	if (cpumask_test_cpu(cpu, &drvdata->supported_cpus)) {
 		cpudata = per_cpu_ptr(drvdata->cpudata, cpu);
+		coresight_trbe_remove_ete(cpudata->csdev, cpu);
 		if (cpudata->csdev) {
 			coresight_unregister(cpudata->csdev);
 			cpudata->drvdata = NULL;
diff --git a/include/linux/coresight.h b/include/linux/coresight.h
index c2d0a2a..c657813 100644
--- a/include/linux/coresight.h
+++ b/include/linux/coresight.h
@@ -496,6 +496,8 @@ void coresight_relaxed_write64(struct coresight_device *csdev,
 			       u64 val, u32 offset);
 void coresight_write64(struct coresight_device *csdev, u64 val, u32 offset);
 
+int coresight_alloc_conns(struct device *dev,
+			  struct coresight_platform_data *pdata);
 
 #else
 static inline struct coresight_device *
-- 
2.7.4

