Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FA1829F6DC
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Oct 2020 22:30:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgJ2VaO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Oct 2020 17:30:14 -0400
Received: from mail-bn8nam11on2138.outbound.protection.outlook.com ([40.107.236.138]:9568
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725961AbgJ2VaN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Oct 2020 17:30:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CYJXCXrt3JDkf9qGhrr2ADkZ9/Pc1++ijzrTwzjENRG5+jlDT1dSUCHKpezLPJYWPOm22evSOOgPyZdIUDK46nz6fHYylfd48gkoFiLFJHIQBLtO61oZuEqUvu1PKhjhyJ+4BeS7IAithhpM6CScMvEC9Yoozp9jwV7W2u5b6G6JxwYp9a8TtHDmjs4P0aBlmBoRtDMhLg2s48p8NUwzbbO168JTZKDaKtPejfZaPff+J0TmUEcVm/vF0f2/43yvH7xQYUnP1FV33hRHGOktD3/+zlbNquMZ14Xj7EyfDE6ECX0INTBOMowliowST1Em8YjTrnA7SY4lmtp3Q7gDJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3cSKrdHBsfInodgmo52YDrkDITrbpVDMJNfGfevBvg=;
 b=AAZ/1jm70098Z1ZXnNi7t+xpOoKQV62uqNuQODLxRclGAWLk3uRQncb8UbiQqgAotgD+umdmtqsBDdZyzKi3zD01VICkE+jlFjufDyrStPRagC+D0FiM028IVJ1gQaXphIm4Z9VPARx2WolbAdrBqo197ikvPSVmgZmz7TvD/ertVByeW6WL2JeyIN3yfxxX6qr7uwQzb6sJQXaxb6Hz3kkADtM4I+O09jh2SLFYTZEzhVX2+R+3Wq66FCvK1AbPiGpMOgbX98h58zCeVfo8Sh+gjc8Qe1XWgr8EiFOJPTBQMdSBbq61aEbda4rcJyYXAWe4/NuG70Xn+An615DX1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3cSKrdHBsfInodgmo52YDrkDITrbpVDMJNfGfevBvg=;
 b=ddkG24ANENWCrE6HZ7RZl4CeBzc2dLMSWGL1aX1ILNzbo+uxn3yYP8rKhTZw/7xQDSrhUNj4nt/QPZraiHxI/BsZJN9ytfFueKGYirmCnISOZIMfPdLsKZ5uaKgocJ+PXv6pig3XmdNQPjv/PUOxFu3izWSVTGCnCyxpytyfIQw=
Authentication-Results: amperecomputing.com; dkim=none (message not signed)
 header.d=none;amperecomputing.com; dmarc=none action=none
 header.from=os.amperecomputing.com;
Received: from BYAPR01MB4598.prod.exchangelabs.com (2603:10b6:a03:8a::18) by
 BYAPR01MB4231.prod.exchangelabs.com (2603:10b6:a03:55::25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3499.27; Thu, 29 Oct 2020 21:30:08 +0000
Received: from BYAPR01MB4598.prod.exchangelabs.com
 ([fe80::419e:edaf:d4b1:3b29]) by BYAPR01MB4598.prod.exchangelabs.com
 ([fe80::419e:edaf:d4b1:3b29%4]) with mapi id 15.20.3477.028; Thu, 29 Oct 2020
 21:30:07 +0000
From:   Tuan Phan <tuanphan@os.amperecomputing.com>
Cc:     patches@amperecomputing.com, robin.murphy@arm.com,
        mark.rutland@arm.com, Will Deacon <will@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5] driver/perf: Add PMU driver for the ARM DMC-620 memory controller
Date:   Thu, 29 Oct 2020 14:29:56 -0700
Message-Id: <1604006999-8321-1-git-send-email-tuanphan@os.amperecomputing.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-Originating-IP: [4.28.12.214]
X-ClientProxiedBy: SJ0PR13CA0194.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::19) To BYAPR01MB4598.prod.exchangelabs.com
 (2603:10b6:a03:8a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aptiov-dev-Latitude-E7470.amperecomputing.com (4.28.12.214) by SJ0PR13CA0194.namprd13.prod.outlook.com (2603:10b6:a03:2c3::19) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3499.18 via Frontend Transport; Thu, 29 Oct 2020 21:30:06 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5a76bfaa-87a3-4218-fd21-08d87c51cdf7
X-MS-TrafficTypeDiagnostic: BYAPR01MB4231:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR01MB42319A521706C496C4C9EBFFE0140@BYAPR01MB4231.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2887;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 50NaY0L3DO9Cr1Rk6NSuqD8EIZx8fJigT3Sx39ksrysHZ/ygFKmFulVBeLEDxCSKblMkHKoBwOODttwq32cmXzlv+89TyQC+DrpVuBDwuluA8sTNcBPlTHCZeDM3eazyu4udrGgc7vJxVNV1RUxj8HCik3i5CzmM1J3bG6XvGEg8IiQ8eoZw1hlv4kdQF5JtvNKFh/HnW9lGVfiCvOIKiL6W/G2ER25YlFZrKkz0HB9JhnthuP2LLuS43+DfouVCsTuk5dhDweLwCRhpY6k+6wlKyvl6lSPVjO+A5KZRWyT5p8kvn7hpsLpW7TdSGdGltcc44FfHMt9SvOGk8Ha95c+uZKeAl+C5fUUH6m744Xy092jZurBikVZ57sfktdG3ftiMplcHYio8s+Xpq2P8zUMSUrOvYucLWf3XRrr7dMo4MgkVlkO9SR+UNmAf9/mU
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR01MB4598.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(39840400004)(376002)(346002)(366004)(5660300002)(956004)(2616005)(316002)(6666004)(8676002)(6506007)(8936002)(52116002)(66946007)(66556008)(66476007)(16526019)(186003)(26005)(30864003)(966005)(86362001)(83380400001)(109986005)(2906002)(478600001)(6512007)(4326008)(6486002)(266003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: iiVE82+3s0R71OxNk2bEAmWXPffISeDBGPJJLioWq+6h39aIovH/wdi08U00RQBWkFDmEj2Jus+RBnAECUx2vsMcYhAtftJWKzjIgcSCgenMh2syD8sVdOrCP4QbtFhOG5fOsqV/QAsh655JobmifyIR4I9RVVwEkkkQCp/UHUQ3uX1M6EVs+daDKcfhYnclmDImhh63t96aTmQbh9WDDsp46k7xwG7uoWoIdqDmNaYPjFw+Eg+Y1HlknlWrU1tz2X6jMuJE3W8CdrXZgUevT5gnwN5kLaG3Ah56OztURPkRYPuiRz6T9pPsTdlZTT7dg6hOvu0FKCkJulE7eFMg/jAfrAUXidgQ8YxK4Eyzhda+G5kbCjp7Fg3qGzdn7oHLXl4X5qrhabmr1FRNMJfUPYxoG8TE8Hck6IjP6l0iN+6akQO1R0xuwHBRB4e41TFevMKmFRfbBkH0Bu7WSWNYEaMhO89zTewnogcHd1WCUTFSeD4EXSTPkZUvqmfy4mMG+gQzFNJVbzxrnK4Nhun4rcmUN7S7ldPeTjQp1IszJiwwVXqk3csZx+x57F7VqjuiKEFHU4wU7SJVWQ3S5pCz5kAhFFvb8QSMy/vVoy5XrcZAHiRYjEzNpQ0St5tFdz/dmFhvj5jYCHmAA1UkgdtmFQ==
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a76bfaa-87a3-4218-fd21-08d87c51cdf7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR01MB4598.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2020 21:30:07.4175
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XnQ9hg5q2bvXaH0NsK5Cfx6jC58TDkR6E/iGPonzM+5sp1ffmjDvRhDjJ8SpfI8evKJCr1/lcDZCQK1f/9CDIoeCCF9cuPH/sEWlXHkE5oe136vBpxLmT0+0UvhMctrq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR01MB4231
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DMC-620 PMU supports total 10 counters which each is
independently programmable to different events and can
be started and stopped individually.

Currently, it only supports ACPI. Other platforms feel free to test and add
support for device tree.

Usage example:
  #perf stat -e arm_dmc620_10008c000/clk_cycle_count/ -C 0
  Get perf event for clk_cycle_count counter.

  #perf stat -e arm_dmc620_10008c000/clkdiv2_allocate,mask=0x1f,match=0x2f,
  incr=2,invert=1/ -C 0
  The above example shows how to specify mask, match, incr,
  invert parameters for clkdiv2_allocate event.

Signed-off-by: Tuan Phan <tuanphan@os.amperecomputing.com>
---
Changes in v5:
- Fixed warning issue with robot test.
- Allow only 1 event at a same time due to HW limitation.

Changes in v4:
- Addressed Robin's comments.

Changes in v3:
- Removed "_OFFSET" suffix.
- Renamed "affinity" to "irq".
- Have a better definition of group register.

Changes in v2:
- Removed IRQF_SHARED flag and added support for multiple 
PMUs sharing the same interrupt.
- Fixed an interrupt handler race condition.

The ACPI binding spec for PMU DMC620 can be downloaded at:
https://developer.arm.com/documentation/den0093/c/

 drivers/perf/Kconfig          |   7 +
 drivers/perf/Makefile         |   1 +
 drivers/perf/arm_dmc620_pmu.c | 749 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 757 insertions(+)
 create mode 100644 drivers/perf/arm_dmc620_pmu.c

diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index 130327ff..3e3a44b 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -130,6 +130,13 @@ config ARM_SPE_PMU
 	  Extension, which provides periodic sampling of operations in
 	  the CPU pipeline and reports this via the perf AUX interface.
 
+config ARM_DMC620_PMU
+	tristate "Enable PMU support for the ARM DMC-620 memory controller"
+	depends on (ARM64 && ACPI) || (COMPILE_TEST && 64BIT)
+	help
+	  Support for PMU events monitoring on the ARM DMC-620 memory
+	  controller.
+
 source "drivers/perf/hisilicon/Kconfig"
 
 endmenu
diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
index 5365fd5..5260b11 100644
--- a/drivers/perf/Makefile
+++ b/drivers/perf/Makefile
@@ -13,3 +13,4 @@ obj-$(CONFIG_QCOM_L3_PMU) += qcom_l3_pmu.o
 obj-$(CONFIG_THUNDERX2_PMU) += thunderx2_pmu.o
 obj-$(CONFIG_XGENE_PMU) += xgene_pmu.o
 obj-$(CONFIG_ARM_SPE_PMU) += arm_spe_pmu.o
+obj-$(CONFIG_ARM_DMC620_PMU) += arm_dmc620_pmu.o
diff --git a/drivers/perf/arm_dmc620_pmu.c b/drivers/perf/arm_dmc620_pmu.c
new file mode 100644
index 0000000..40b583e
--- /dev/null
+++ b/drivers/perf/arm_dmc620_pmu.c
@@ -0,0 +1,749 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * ARM DMC-620 memory controller PMU driver
+ *
+ * Copyright (C) 2020 Ampere Computing LLC.
+ */
+
+#define DMC620_PMUNAME		"arm_dmc620"
+#define DMC620_DRVNAME		DMC620_PMUNAME "_pmu"
+#define pr_fmt(fmt)		DMC620_DRVNAME ": " fmt
+
+#include <linux/acpi.h>
+#include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/cpuhotplug.h>
+#include <linux/cpumask.h>
+#include <linux/device.h>
+#include <linux/errno.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/kernel.h>
+#include <linux/list.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/perf_event.h>
+#include <linux/perf/arm_pmu.h>
+#include <linux/platform_device.h>
+#include <linux/printk.h>
+#include <linux/rculist.h>
+#include <linux/refcount.h>
+
+#define DMC620_PA_SHIFT					12
+#define DMC620_CNT_INIT					0x80000000
+#define DMC620_CNT_MAX_PERIOD				0xffffffff
+#define DMC620_PMU_CLKDIV2_MAX_COUNTERS			8
+#define DMC620_PMU_CLK_MAX_COUNTERS			2
+#define DMC620_PMU_MAX_COUNTERS				\
+	(DMC620_PMU_CLKDIV2_MAX_COUNTERS + DMC620_PMU_CLK_MAX_COUNTERS)
+
+/*
+ * The PMU registers start at 0xA00 in the DMC-620 memory map, and these
+ * offsets are relative to that base.
+ *
+ * Each counter has a group of control/value registers, and the
+ * DMC620_PMU_COUNTERn offsets are within a counter group.
+ *
+ * The counter registers groups start at 0xA10.
+ */
+#define DMC620_PMU_OVERFLOW_STATUS_CLKDIV2		0x8
+#define  DMC620_PMU_OVERFLOW_STATUS_CLKDIV2_MASK	\
+		(DMC620_PMU_CLKDIV2_MAX_COUNTERS - 1)
+#define DMC620_PMU_OVERFLOW_STATUS_CLK			0xC
+#define  DMC620_PMU_OVERFLOW_STATUS_CLK_MASK		\
+		(DMC620_PMU_CLK_MAX_COUNTERS - 1)
+#define DMC620_PMU_COUNTERS_BASE			0x10
+#define DMC620_PMU_COUNTERn_MASK_31_00			0x0
+#define DMC620_PMU_COUNTERn_MASK_63_32			0x4
+#define DMC620_PMU_COUNTERn_MATCH_31_00			0x8
+#define DMC620_PMU_COUNTERn_MATCH_63_32			0xC
+#define DMC620_PMU_COUNTERn_CONTROL			0x10
+#define  DMC620_PMU_COUNTERn_CONTROL_ENABLE		BIT(0)
+#define  DMC620_PMU_COUNTERn_CONTROL_INVERT		BIT(1)
+#define  DMC620_PMU_COUNTERn_CONTROL_EVENT_MUX		GENMASK(6, 2)
+#define  DMC620_PMU_COUNTERn_CONTROL_INCR_MUX		GENMASK(8, 7)
+#define DMC620_PMU_COUNTERn_VALUE			0x20
+/* Offset of the registers for a given counter, relative to 0xA00 */
+#define DMC620_PMU_COUNTERn_OFFSET(n) \
+	(DMC620_PMU_COUNTERS_BASE + 0x28 * (n))
+
+static LIST_HEAD(dmc620_pmu_irqs);
+static DEFINE_MUTEX(dmc620_pmu_irqs_lock);
+
+struct dmc620_pmu_irq {
+	struct hlist_node node;
+	struct list_head pmus_node;
+	struct list_head irqs_node;
+	refcount_t refcount;
+	unsigned int irq_num;
+	unsigned int cpu;
+};
+
+struct dmc620_pmu {
+	struct pmu pmu;
+
+	void __iomem *base;
+	struct dmc620_pmu_irq *irq;
+	struct list_head pmus_node;
+
+	/*
+	 * We put all clkdiv2 and clk counters to a same array.
+	 * The first DMC620_PMU_CLKDIV2_MAX_COUNTERS bits belong to
+	 * clkdiv2 counters, the last DMC620_PMU_CLK_MAX_COUNTERS
+	 * belong to clk counters.
+	 */
+	DECLARE_BITMAP(used_mask, DMC620_PMU_MAX_COUNTERS);
+	struct perf_event *events[DMC620_PMU_MAX_COUNTERS];
+};
+
+#define to_dmc620_pmu(p) (container_of(p, struct dmc620_pmu, pmu))
+
+static int cpuhp_state_num;
+
+struct dmc620_pmu_event_attr {
+	struct device_attribute attr;
+	u8 clkdiv2;
+	u8 eventid;
+};
+
+static ssize_t
+dmc620_pmu_event_show(struct device *dev,
+			   struct device_attribute *attr, char *page)
+{
+	struct dmc620_pmu_event_attr *eattr;
+
+	eattr = container_of(attr, typeof(*eattr), attr);
+
+	return sprintf(page, "event=0x%x,clkdiv2=0x%x\n", eattr->eventid, eattr->clkdiv2);
+}
+
+#define DMC620_PMU_EVENT_ATTR(_name, _eventid, _clkdiv2)		\
+	(&((struct dmc620_pmu_event_attr[]) {{				\
+		.attr = __ATTR(_name, 0444, dmc620_pmu_event_show, NULL),	\
+		.clkdiv2 = _clkdiv2,						\
+		.eventid = _eventid,					\
+	}})[0].attr.attr)
+
+static struct attribute *dmc620_pmu_events_attrs[] = {
+	/* clkdiv2 events list */
+	DMC620_PMU_EVENT_ATTR(clkdiv2_cycle_count, 0x0, 1),
+	DMC620_PMU_EVENT_ATTR(clkdiv2_allocate, 0x1, 1),
+	DMC620_PMU_EVENT_ATTR(clkdiv2_queue_depth, 0x2, 1),
+	DMC620_PMU_EVENT_ATTR(clkdiv2_waiting_for_wr_data, 0x3, 1),
+	DMC620_PMU_EVENT_ATTR(clkdiv2_read_backlog, 0x4, 1),
+	DMC620_PMU_EVENT_ATTR(clkdiv2_waiting_for_mi, 0x5, 1),
+	DMC620_PMU_EVENT_ATTR(clkdiv2_hazard_resolution, 0x6, 1),
+	DMC620_PMU_EVENT_ATTR(clkdiv2_enqueue, 0x7, 1),
+	DMC620_PMU_EVENT_ATTR(clkdiv2_arbitrate, 0x8, 1),
+	DMC620_PMU_EVENT_ATTR(clkdiv2_lrank_turnaround_activate, 0x9, 1),
+	DMC620_PMU_EVENT_ATTR(clkdiv2_prank_turnaround_activate, 0xa, 1),
+	DMC620_PMU_EVENT_ATTR(clkdiv2_read_depth, 0xb, 1),
+	DMC620_PMU_EVENT_ATTR(clkdiv2_write_depth, 0xc, 1),
+	DMC620_PMU_EVENT_ATTR(clkdiv2_highigh_qos_depth, 0xd, 1),
+	DMC620_PMU_EVENT_ATTR(clkdiv2_high_qos_depth, 0xe, 1),
+	DMC620_PMU_EVENT_ATTR(clkdiv2_medium_qos_depth, 0xf, 1),
+	DMC620_PMU_EVENT_ATTR(clkdiv2_low_qos_depth, 0x10, 1),
+	DMC620_PMU_EVENT_ATTR(clkdiv2_activate, 0x11, 1),
+	DMC620_PMU_EVENT_ATTR(clkdiv2_rdwr, 0x12, 1),
+	DMC620_PMU_EVENT_ATTR(clkdiv2_refresh, 0x13, 1),
+	DMC620_PMU_EVENT_ATTR(clkdiv2_training_request, 0x14, 1),
+	DMC620_PMU_EVENT_ATTR(clkdiv2_t_mac_tracker, 0x15, 1),
+	DMC620_PMU_EVENT_ATTR(clkdiv2_bk_fsm_tracker, 0x16, 1),
+	DMC620_PMU_EVENT_ATTR(clkdiv2_bk_open_tracker, 0x17, 1),
+	DMC620_PMU_EVENT_ATTR(clkdiv2_ranks_in_pwr_down, 0x18, 1),
+	DMC620_PMU_EVENT_ATTR(clkdiv2_ranks_in_sref, 0x19, 1),
+
+	/* clk events list */
+	DMC620_PMU_EVENT_ATTR(clk_cycle_count, 0x0, 0),
+	DMC620_PMU_EVENT_ATTR(clk_request, 0x1, 0),
+	DMC620_PMU_EVENT_ATTR(clk_upload_stall, 0x2, 0),
+	NULL,
+};
+
+static struct attribute_group dmc620_pmu_events_attr_group = {
+	.name = "events",
+	.attrs = dmc620_pmu_events_attrs,
+};
+
+/* User ABI */
+#define ATTR_CFG_FLD_mask_CFG		config
+#define ATTR_CFG_FLD_mask_LO		0
+#define ATTR_CFG_FLD_mask_HI		44
+#define ATTR_CFG_FLD_match_CFG		config1
+#define ATTR_CFG_FLD_match_LO		0
+#define ATTR_CFG_FLD_match_HI		44
+#define ATTR_CFG_FLD_invert_CFG		config2
+#define ATTR_CFG_FLD_invert_LO		0
+#define ATTR_CFG_FLD_invert_HI		0
+#define ATTR_CFG_FLD_incr_CFG		config2
+#define ATTR_CFG_FLD_incr_LO		1
+#define ATTR_CFG_FLD_incr_HI		2
+#define ATTR_CFG_FLD_event_CFG		config2
+#define ATTR_CFG_FLD_event_LO		3
+#define ATTR_CFG_FLD_event_HI		8
+#define ATTR_CFG_FLD_clkdiv2_CFG	config2
+#define ATTR_CFG_FLD_clkdiv2_LO		9
+#define ATTR_CFG_FLD_clkdiv2_HI		9
+
+#define __GEN_PMU_FORMAT_ATTR(cfg, lo, hi)			\
+	(lo) == (hi) ? #cfg ":" #lo "\n" : #cfg ":" #lo "-" #hi
+
+#define _GEN_PMU_FORMAT_ATTR(cfg, lo, hi)			\
+	__GEN_PMU_FORMAT_ATTR(cfg, lo, hi)
+
+#define GEN_PMU_FORMAT_ATTR(name)				\
+	PMU_FORMAT_ATTR(name,					\
+	_GEN_PMU_FORMAT_ATTR(ATTR_CFG_FLD_##name##_CFG,		\
+			     ATTR_CFG_FLD_##name##_LO,		\
+			     ATTR_CFG_FLD_##name##_HI))
+
+#define _ATTR_CFG_GET_FLD(attr, cfg, lo, hi)			\
+	((((attr)->cfg) >> lo) & GENMASK_ULL(hi - lo, 0))
+
+#define ATTR_CFG_GET_FLD(attr, name)				\
+	_ATTR_CFG_GET_FLD(attr,					\
+			  ATTR_CFG_FLD_##name##_CFG,		\
+			  ATTR_CFG_FLD_##name##_LO,		\
+			  ATTR_CFG_FLD_##name##_HI)
+
+GEN_PMU_FORMAT_ATTR(mask);
+GEN_PMU_FORMAT_ATTR(match);
+GEN_PMU_FORMAT_ATTR(invert);
+GEN_PMU_FORMAT_ATTR(incr);
+GEN_PMU_FORMAT_ATTR(event);
+GEN_PMU_FORMAT_ATTR(clkdiv2);
+
+static struct attribute *dmc620_pmu_formats_attrs[] = {
+	&format_attr_mask.attr,
+	&format_attr_match.attr,
+	&format_attr_invert.attr,
+	&format_attr_incr.attr,
+	&format_attr_event.attr,
+	&format_attr_clkdiv2.attr,
+	NULL,
+};
+
+static struct attribute_group dmc620_pmu_format_attr_group = {
+	.name	= "format",
+	.attrs	= dmc620_pmu_formats_attrs,
+};
+
+static const struct attribute_group *dmc620_pmu_attr_groups[] = {
+	&dmc620_pmu_events_attr_group,
+	&dmc620_pmu_format_attr_group,
+	NULL,
+};
+
+static inline
+u32 dmc620_pmu_creg_read(struct dmc620_pmu *dmc620_pmu,
+			unsigned int idx, unsigned int reg)
+{
+	return readl(dmc620_pmu->base + DMC620_PMU_COUNTERn_OFFSET(idx) + reg);
+}
+
+static inline
+void dmc620_pmu_creg_write(struct dmc620_pmu *dmc620_pmu,
+			unsigned int idx, unsigned int reg, u32 val)
+{
+	writel(val, dmc620_pmu->base + DMC620_PMU_COUNTERn_OFFSET(idx) + reg);
+}
+
+static
+unsigned int dmc620_event_to_counter_control(struct perf_event *event)
+{
+	struct perf_event_attr *attr = &event->attr;
+	unsigned int reg = 0;
+
+	reg |= FIELD_PREP(DMC620_PMU_COUNTERn_CONTROL_INVERT,
+			ATTR_CFG_GET_FLD(attr, invert));
+	reg |= FIELD_PREP(DMC620_PMU_COUNTERn_CONTROL_EVENT_MUX,
+			ATTR_CFG_GET_FLD(attr, event));
+	reg |= FIELD_PREP(DMC620_PMU_COUNTERn_CONTROL_INCR_MUX,
+			ATTR_CFG_GET_FLD(attr, incr));
+
+	return reg;
+}
+
+static int dmc620_get_event_idx(struct perf_event *event)
+{
+	struct dmc620_pmu *dmc620_pmu = to_dmc620_pmu(event->pmu);
+	int idx, start_idx, end_idx;
+
+	if (ATTR_CFG_GET_FLD(&event->attr, clkdiv2)) {
+		start_idx = 0;
+		end_idx = DMC620_PMU_CLKDIV2_MAX_COUNTERS;
+	} else {
+		start_idx = DMC620_PMU_CLKDIV2_MAX_COUNTERS;
+		end_idx = DMC620_PMU_MAX_COUNTERS;
+	}
+
+	for (idx = start_idx; idx < end_idx; ++idx) {
+		if (!test_and_set_bit(idx, dmc620_pmu->used_mask))
+			return idx;
+	}
+
+	/* The counters are all in use. */
+	return -EAGAIN;
+}
+
+static inline
+u64 dmc620_pmu_read_counter(struct perf_event *event)
+{
+	struct dmc620_pmu *dmc620_pmu = to_dmc620_pmu(event->pmu);
+
+	return dmc620_pmu_creg_read(dmc620_pmu,
+				    event->hw.idx, DMC620_PMU_COUNTERn_VALUE);
+}
+
+static void dmc620_pmu_event_update(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	u64 delta, prev_count, new_count;
+
+	do {
+		/* We may also be called from the irq handler */
+		prev_count = local64_read(&hwc->prev_count);
+		new_count = dmc620_pmu_read_counter(event);
+	} while (local64_cmpxchg(&hwc->prev_count,
+			prev_count, new_count) != prev_count);
+	delta = (new_count - prev_count) & DMC620_CNT_MAX_PERIOD;
+	local64_add(delta, &event->count);
+}
+
+static void dmc620_pmu_event_set_period(struct perf_event *event)
+{
+	struct dmc620_pmu *dmc620_pmu = to_dmc620_pmu(event->pmu);
+
+	local64_set(&event->hw.prev_count, DMC620_CNT_INIT);
+	dmc620_pmu_creg_write(dmc620_pmu,
+			      event->hw.idx, DMC620_PMU_COUNTERn_VALUE, DMC620_CNT_INIT);
+}
+
+static void dmc620_pmu_enable_counter(struct perf_event *event)
+{
+	struct dmc620_pmu *dmc620_pmu = to_dmc620_pmu(event->pmu);
+	u32 reg;
+
+	reg = dmc620_event_to_counter_control(event) | DMC620_PMU_COUNTERn_CONTROL_ENABLE;
+	dmc620_pmu_creg_write(dmc620_pmu,
+			      event->hw.idx, DMC620_PMU_COUNTERn_CONTROL, reg);
+}
+
+static void dmc620_pmu_disable_counter(struct perf_event *event)
+{
+	struct dmc620_pmu *dmc620_pmu = to_dmc620_pmu(event->pmu);
+
+	dmc620_pmu_creg_write(dmc620_pmu,
+			      event->hw.idx, DMC620_PMU_COUNTERn_CONTROL, 0);
+}
+
+static irqreturn_t dmc620_pmu_handle_irq(int irq_num, void *data)
+{
+	struct dmc620_pmu_irq *irq = data;
+	struct dmc620_pmu *dmc620_pmu;
+	irqreturn_t ret = IRQ_NONE;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(dmc620_pmu, &irq->pmus_node, pmus_node) {
+		unsigned long status;
+		struct perf_event *event;
+		unsigned int idx;
+
+		/*
+		 * HW doesn't provide a control to atomically disable all counters.
+		 * To prevent race condition (overflow happens while clearing status register),
+		 * disable all events before continuing
+		 */
+		for (idx = 0; idx < DMC620_PMU_MAX_COUNTERS; idx++) {
+			event = dmc620_pmu->events[idx];
+			if (!event)
+				continue;
+			dmc620_pmu_disable_counter(event);
+		}
+
+		status = readl(dmc620_pmu->base + DMC620_PMU_OVERFLOW_STATUS_CLKDIV2);
+		status |= (readl(dmc620_pmu->base + DMC620_PMU_OVERFLOW_STATUS_CLK) <<
+				DMC620_PMU_CLKDIV2_MAX_COUNTERS);
+		if (status) {
+			for_each_set_bit(idx, &status,
+					DMC620_PMU_MAX_COUNTERS) {
+				event = dmc620_pmu->events[idx];
+				if (WARN_ON_ONCE(!event))
+					continue;
+				dmc620_pmu_event_update(event);
+				dmc620_pmu_event_set_period(event);
+			}
+
+			if (status & DMC620_PMU_OVERFLOW_STATUS_CLKDIV2_MASK)
+				writel(0, dmc620_pmu->base + DMC620_PMU_OVERFLOW_STATUS_CLKDIV2);
+
+			if ((status >> DMC620_PMU_CLKDIV2_MAX_COUNTERS) &
+				DMC620_PMU_OVERFLOW_STATUS_CLK_MASK)
+				writel(0, dmc620_pmu->base + DMC620_PMU_OVERFLOW_STATUS_CLK);
+		}
+
+		for (idx = 0; idx < DMC620_PMU_MAX_COUNTERS; idx++) {
+			event = dmc620_pmu->events[idx];
+			if (!event)
+				continue;
+			if (!(event->hw.state & PERF_HES_STOPPED))
+				dmc620_pmu_enable_counter(event);
+		}
+
+		ret = IRQ_HANDLED;
+	}
+	rcu_read_unlock();
+
+	return ret;
+}
+
+static struct dmc620_pmu_irq *__dmc620_pmu_get_irq(int irq_num)
+{
+	struct dmc620_pmu_irq *irq;
+	int ret;
+
+	list_for_each_entry(irq, &dmc620_pmu_irqs, irqs_node)
+		if (irq->irq_num == irq_num && refcount_inc_not_zero(&irq->refcount))
+			return irq;
+
+	irq = kzalloc(sizeof(*irq), GFP_KERNEL);
+	if (!irq)
+		return ERR_PTR(-ENOMEM);
+
+	INIT_LIST_HEAD(&irq->pmus_node);
+
+	/* Pick one CPU to be the preferred one to use */
+	irq->cpu = raw_smp_processor_id();
+	refcount_set(&irq->refcount, 1);
+
+	ret = request_irq(irq_num, dmc620_pmu_handle_irq,
+			  IRQF_NOBALANCING | IRQF_NO_THREAD,
+			  "dmc620-pmu", irq);
+	if (ret)
+		goto out_free_aff;
+
+	ret = irq_set_affinity_hint(irq_num, cpumask_of(irq->cpu));
+	if (ret)
+		goto out_free_irq;
+
+	ret = cpuhp_state_add_instance_nocalls(cpuhp_state_num, &irq->node);
+	if (ret)
+		goto out_free_irq;
+
+	irq->irq_num = irq_num;
+	list_add(&irq->irqs_node, &dmc620_pmu_irqs);
+
+	return irq;
+
+out_free_irq:
+	free_irq(irq_num, irq);
+out_free_aff:
+	kfree(irq);
+	return ERR_PTR(ret);
+}
+
+static int dmc620_pmu_get_irq(struct dmc620_pmu *dmc620_pmu, int irq_num)
+{
+	struct dmc620_pmu_irq *irq;
+
+	mutex_lock(&dmc620_pmu_irqs_lock);
+	irq = __dmc620_pmu_get_irq(irq_num);
+	mutex_unlock(&dmc620_pmu_irqs_lock);
+
+	if (IS_ERR(irq))
+		return PTR_ERR(irq);
+
+	dmc620_pmu->irq = irq;
+	mutex_lock(&dmc620_pmu_irqs_lock);
+	list_add_rcu(&dmc620_pmu->pmus_node, &irq->pmus_node);
+	mutex_unlock(&dmc620_pmu_irqs_lock);
+
+	return 0;
+}
+
+static void dmc620_pmu_put_irq(struct dmc620_pmu *dmc620_pmu)
+{
+	struct dmc620_pmu_irq *irq = dmc620_pmu->irq;
+
+	mutex_lock(&dmc620_pmu_irqs_lock);
+	list_del_rcu(&dmc620_pmu->pmus_node);
+
+	if (!refcount_dec_and_test(&irq->refcount)) {
+		mutex_unlock(&dmc620_pmu_irqs_lock);
+		return;
+	}
+
+	list_del(&irq->irqs_node);
+	mutex_unlock(&dmc620_pmu_irqs_lock);
+
+	WARN_ON(irq_set_affinity_hint(irq->irq_num, NULL));
+	free_irq(irq->irq_num, irq);
+	cpuhp_state_remove_instance_nocalls(cpuhp_state_num, &irq->node);
+	kfree(irq);
+}
+
+static int dmc620_pmu_event_init(struct perf_event *event)
+{
+	struct dmc620_pmu *dmc620_pmu = to_dmc620_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	struct perf_event *sibling;
+
+	if (event->attr.type != event->pmu->type)
+		return -ENOENT;
+
+	/*
+	 * DMC 620 PMUs are shared across all cpus and cannot
+	 * support task bound and sampling events.
+	 */
+	if (is_sampling_event(event) ||
+		event->attach_state & PERF_ATTACH_TASK) {
+		dev_dbg(dmc620_pmu->pmu.dev,
+			"Can't support per-task counters\n");
+		return -EOPNOTSUPP;
+	}
+
+	/*
+	 * Many perf core operations (eg. events rotation) operate on a
+	 * single CPU context. This is obvious for CPU PMUs, where one
+	 * expects the same sets of events being observed on all CPUs,
+	 * but can lead to issues for off-core PMUs, where each
+	 * event could be theoretically assigned to a different CPU. To
+	 * mitigate this, we enforce CPU assignment to one, selected
+	 * processor.
+	 */
+	event->cpu = dmc620_pmu->irq->cpu;
+	if (event->cpu < 0)
+		return -EINVAL;
+
+	/*
+	 * We can't atomically disable all HW counters so only one event allowed,
+	 * although software events are acceptable.
+	 */
+	if (event->group_leader != event &&
+			!is_software_event(event->group_leader))
+		return -EINVAL;
+
+	for_each_sibling_event(sibling, event->group_leader) {
+		if (sibling != event &&
+				!is_software_event(sibling))
+			return -EINVAL;
+	}
+
+	hwc->idx = -1;
+	return 0;
+}
+
+static void dmc620_pmu_read(struct perf_event *event)
+{
+	dmc620_pmu_event_update(event);
+}
+
+static void dmc620_pmu_start(struct perf_event *event, int flags)
+{
+	event->hw.state = 0;
+	dmc620_pmu_event_set_period(event);
+	dmc620_pmu_enable_counter(event);
+}
+
+static void dmc620_pmu_stop(struct perf_event *event, int flags)
+{
+	if (event->hw.state & PERF_HES_STOPPED)
+		return;
+
+	dmc620_pmu_disable_counter(event);
+	dmc620_pmu_event_update(event);
+	event->hw.state |= PERF_HES_STOPPED | PERF_HES_UPTODATE;
+}
+
+static int dmc620_pmu_add(struct perf_event *event, int flags)
+{
+	struct dmc620_pmu *dmc620_pmu = to_dmc620_pmu(event->pmu);
+	struct perf_event_attr *attr = &event->attr;
+	struct hw_perf_event *hwc = &event->hw;
+	int idx;
+	u64 reg;
+
+	idx = dmc620_get_event_idx(event);
+	if (idx < 0)
+		return idx;
+
+	hwc->idx = idx;
+	dmc620_pmu->events[idx] = event;
+	hwc->state = PERF_HES_STOPPED | PERF_HES_UPTODATE;
+
+	reg = ATTR_CFG_GET_FLD(attr, mask);
+	dmc620_pmu_creg_write(dmc620_pmu,
+			      idx, DMC620_PMU_COUNTERn_MASK_31_00, lower_32_bits(reg));
+	dmc620_pmu_creg_write(dmc620_pmu,
+			      idx, DMC620_PMU_COUNTERn_MASK_63_32, upper_32_bits(reg));
+
+	reg = ATTR_CFG_GET_FLD(attr, match);
+	dmc620_pmu_creg_write(dmc620_pmu,
+			      idx, DMC620_PMU_COUNTERn_MATCH_31_00, lower_32_bits(reg));
+	dmc620_pmu_creg_write(dmc620_pmu,
+			      idx, DMC620_PMU_COUNTERn_MATCH_63_32, upper_32_bits(reg));
+
+	if (flags & PERF_EF_START)
+		dmc620_pmu_start(event, PERF_EF_RELOAD);
+
+	perf_event_update_userpage(event);
+	return 0;
+}
+
+static void dmc620_pmu_del(struct perf_event *event, int flags)
+{
+	struct dmc620_pmu *dmc620_pmu = to_dmc620_pmu(event->pmu);
+	struct hw_perf_event *hwc = &event->hw;
+	int idx = hwc->idx;
+
+	dmc620_pmu_stop(event, PERF_EF_UPDATE);
+	dmc620_pmu->events[idx] = NULL;
+	clear_bit(idx, dmc620_pmu->used_mask);
+	perf_event_update_userpage(event);
+}
+
+static int dmc620_pmu_cpu_teardown(unsigned int cpu,
+				   struct hlist_node *node)
+{
+	struct dmc620_pmu_irq *irq;
+	struct dmc620_pmu *dmc620_pmu;
+	unsigned int target;
+
+	irq = hlist_entry_safe(node, struct dmc620_pmu_irq, node);
+	if (cpu != irq->cpu)
+		return 0;
+
+	target = cpumask_any_but(cpu_online_mask, cpu);
+	if (target >= nr_cpu_ids)
+		return 0;
+
+	/* We're only reading, but this isn't the place to be involving RCU */
+	mutex_lock(&dmc620_pmu_irqs_lock);
+	list_for_each_entry(dmc620_pmu, &irq->pmus_node, pmus_node)
+		perf_pmu_migrate_context(&dmc620_pmu->pmu, irq->cpu, target);
+	mutex_unlock(&dmc620_pmu_irqs_lock);
+
+	WARN_ON(irq_set_affinity_hint(irq->irq_num, cpumask_of(target)));
+	irq->cpu = target;
+
+	return 0;
+}
+
+static int dmc620_pmu_device_probe(struct platform_device *pdev)
+{
+	struct dmc620_pmu *dmc620_pmu;
+	struct resource *res;
+	char *name;
+	int irq_num;
+	int i, ret;
+
+	dmc620_pmu = devm_kzalloc(&pdev->dev,
+			sizeof(struct dmc620_pmu), GFP_KERNEL);
+	if (!dmc620_pmu)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, dmc620_pmu);
+
+	dmc620_pmu->pmu = (struct pmu) {
+		.module = THIS_MODULE,
+		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
+		.task_ctx_nr	= perf_invalid_context,
+		.event_init	= dmc620_pmu_event_init,
+		.add		= dmc620_pmu_add,
+		.del		= dmc620_pmu_del,
+		.start		= dmc620_pmu_start,
+		.stop		= dmc620_pmu_stop,
+		.read		= dmc620_pmu_read,
+		.attr_groups	= dmc620_pmu_attr_groups,
+	};
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	dmc620_pmu->base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(dmc620_pmu->base))
+		return PTR_ERR(dmc620_pmu->base);
+
+	/* Make sure device is reset before enabling interrupt */
+	for (i = 0; i < DMC620_PMU_MAX_COUNTERS; i++)
+		dmc620_pmu_creg_write(dmc620_pmu, i, DMC620_PMU_COUNTERn_CONTROL, 0);
+	writel(0, dmc620_pmu->base + DMC620_PMU_OVERFLOW_STATUS_CLKDIV2);
+	writel(0, dmc620_pmu->base + DMC620_PMU_OVERFLOW_STATUS_CLK);
+
+	irq_num = platform_get_irq(pdev, 0);
+	if (irq_num < 0)
+		return irq_num;
+
+	ret = dmc620_pmu_get_irq(dmc620_pmu, irq_num);
+	if (ret)
+		return ret;
+
+	name = devm_kasprintf(&pdev->dev, GFP_KERNEL,
+				  "%s_%llx", DMC620_PMUNAME,
+				  (u64)(res->start >> DMC620_PA_SHIFT));
+	if (!name) {
+		dev_err(&pdev->dev,
+			  "Create name failed, PMU @%pa\n", &res->start);
+		goto out_teardown_dev;
+	}
+
+	ret = perf_pmu_register(&dmc620_pmu->pmu, name, -1);
+	if (ret)
+		goto out_teardown_dev;
+
+	return 0;
+
+out_teardown_dev:
+	dmc620_pmu_put_irq(dmc620_pmu);
+	synchronize_rcu();
+	return ret;
+}
+
+static int dmc620_pmu_device_remove(struct platform_device *pdev)
+{
+	struct dmc620_pmu *dmc620_pmu = platform_get_drvdata(pdev);
+
+	dmc620_pmu_put_irq(dmc620_pmu);
+
+	/* perf will synchronise RCU before devres can free dmc620_pmu */
+	perf_pmu_unregister(&dmc620_pmu->pmu);
+
+	return 0;
+}
+
+static const struct acpi_device_id dmc620_acpi_match[] = {
+	{ "ARMHD620", 0},
+	{},
+};
+MODULE_DEVICE_TABLE(acpi, dmc620_acpi_match);
+static struct platform_driver dmc620_pmu_driver = {
+	.driver	= {
+		.name		= DMC620_DRVNAME,
+		.acpi_match_table = dmc620_acpi_match,
+	},
+	.probe	= dmc620_pmu_device_probe,
+	.remove	= dmc620_pmu_device_remove,
+};
+
+static int __init dmc620_pmu_init(void)
+{
+	cpuhp_state_num = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN,
+				      DMC620_DRVNAME,
+				      NULL,
+				      dmc620_pmu_cpu_teardown);
+	if (cpuhp_state_num < 0)
+		return cpuhp_state_num;
+
+	return platform_driver_register(&dmc620_pmu_driver);
+}
+
+static void __exit dmc620_pmu_exit(void)
+{
+	platform_driver_unregister(&dmc620_pmu_driver);
+	cpuhp_remove_multi_state(cpuhp_state_num);
+}
+
+module_init(dmc620_pmu_init);
+module_exit(dmc620_pmu_exit);
+
+MODULE_DESCRIPTION("Perf driver for the ARM DMC-620 memory controller");
+MODULE_AUTHOR("Tuan Phan <tuanphan@os.amperecomputing.com");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

