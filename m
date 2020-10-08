Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21A2728717C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 11:30:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729013AbgJHJaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 05:30:18 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:35144 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727709AbgJHJaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 05:30:17 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 45D49F56B5E2CD97C29D;
        Thu,  8 Oct 2020 17:30:14 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Thu, 8 Oct 2020 17:30:06 +0800
From:   John Garry <john.garry@huawei.com>
To:     <Frank.li@nxp.com>, <will@kernel.org>, <mark.rutland@arm.com>,
        <robh+dt@kernel.org>, <zhangshaokun@hisilicon.com>,
        <qiangqing.zhang@nxp.com>
CC:     <linuxarm@huawei.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <acme@kernel.org>,
        <jolsa@redhat.com>, <irogers@google.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v2 4/4] perf/smmuv3: Support sysfs identifier file
Date:   Thu, 8 Oct 2020 17:26:21 +0800
Message-ID: <1602149181-237415-5-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1602149181-237415-1-git-send-email-john.garry@huawei.com>
References: <1602149181-237415-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SMMU_PMCG_IIDR was added in the SMMUv3.3 spec.

For the perf tool to know the specific HW implementation, expose the
PMCG_IIDR contents only when set.

Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/perf/arm_smmuv3_pmu.c | 39 +++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/drivers/perf/arm_smmuv3_pmu.c b/drivers/perf/arm_smmuv3_pmu.c
index 5274f7fe359e..74474bb322c3 100644
--- a/drivers/perf/arm_smmuv3_pmu.c
+++ b/drivers/perf/arm_smmuv3_pmu.c
@@ -74,6 +74,7 @@
 #define SMMU_PMCG_CFGR_NCTR             GENMASK(5, 0)
 #define SMMU_PMCG_CR                    0xE04
 #define SMMU_PMCG_CR_ENABLE             BIT(0)
+#define SMMU_PMCG_IIDR                  0xE08
 #define SMMU_PMCG_CEID0                 0xE20
 #define SMMU_PMCG_CEID1                 0xE28
 #define SMMU_PMCG_IRQ_CTRL              0xE50
@@ -112,6 +113,7 @@ struct smmu_pmu {
 	void __iomem *reloc_base;
 	u64 counter_mask;
 	u32 options;
+	u32 iidr;
 	bool global_filter;
 };
 
@@ -552,6 +554,40 @@ static struct attribute_group smmu_pmu_events_group = {
 	.is_visible = smmu_pmu_event_is_visible,
 };
 
+static ssize_t smmu_pmu_identifier_attr_show(struct device *dev,
+					struct device_attribute *attr,
+					char *page)
+{
+	struct smmu_pmu *smmu_pmu = to_smmu_pmu(dev_get_drvdata(dev));
+
+	return snprintf(page, PAGE_SIZE, "0x%08x\n", smmu_pmu->iidr);
+}
+
+static umode_t smmu_pmu_identifier_attr_visible(struct kobject *kobj,
+						struct attribute *attr,
+						int n)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct smmu_pmu *smmu_pmu = to_smmu_pmu(dev_get_drvdata(dev));
+
+	if (!smmu_pmu->iidr)
+		return 0;
+	return attr->mode;
+}
+
+static struct device_attribute smmu_pmu_identifier_attr =
+	__ATTR(identifier, 0444, smmu_pmu_identifier_attr_show, NULL);
+
+static struct attribute *smmu_pmu_identifier_attrs[] = {
+	&smmu_pmu_identifier_attr.attr,
+	NULL
+};
+
+static struct attribute_group smmu_pmu_identifier_group = {
+	.attrs = smmu_pmu_identifier_attrs,
+	.is_visible = smmu_pmu_identifier_attr_visible,
+};
+
 /* Formats */
 PMU_FORMAT_ATTR(event,		   "config:0-15");
 PMU_FORMAT_ATTR(filter_stream_id,  "config1:0-31");
@@ -575,6 +611,7 @@ static const struct attribute_group *smmu_pmu_attr_grps[] = {
 	&smmu_pmu_cpumask_group,
 	&smmu_pmu_events_group,
 	&smmu_pmu_format_group,
+	&smmu_pmu_identifier_group,
 	NULL
 };
 
@@ -795,6 +832,8 @@ static int smmu_pmu_probe(struct platform_device *pdev)
 		return err;
 	}
 
+	smmu_pmu->iidr = readl_relaxed(smmu_pmu->reg_base + SMMU_PMCG_IIDR);
+
 	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "smmuv3_pmcg_%llx",
 			      (res_0->start) >> SMMU_PMCG_PA_SHIFT);
 	if (!name) {
-- 
2.26.2

