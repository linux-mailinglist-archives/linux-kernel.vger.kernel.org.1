Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 065C528717E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 11:30:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729054AbgJHJaT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 05:30:19 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:35156 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726273AbgJHJaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 05:30:17 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 4D36BE57EAAFBFC61C40;
        Thu,  8 Oct 2020 17:30:14 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS404-HUB.china.huawei.com (10.3.19.204) with Microsoft SMTP Server id
 14.3.487.0; Thu, 8 Oct 2020 17:30:05 +0800
From:   John Garry <john.garry@huawei.com>
To:     <Frank.li@nxp.com>, <will@kernel.org>, <mark.rutland@arm.com>,
        <robh+dt@kernel.org>, <zhangshaokun@hisilicon.com>,
        <qiangqing.zhang@nxp.com>
CC:     <linuxarm@huawei.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <acme@kernel.org>,
        <jolsa@redhat.com>, <irogers@google.com>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH v2 3/4] perf/imx_ddr: Add system PMU identifier for userspace
Date:   Thu, 8 Oct 2020 17:26:20 +0800
Message-ID: <1602149181-237415-4-git-send-email-john.garry@huawei.com>
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

From: Joakim Zhang <qiangqing.zhang@nxp.com>

The DDR Perf for i.MX8 is a system PMU whose AXI ID would different from
SoC to SoC. Need expose system PMU identifier for userspace which refer
to /sys/bus/event_source/devices/<PMU DEVICE>/identifier.

Reviewed-by: John Garry <john.garry@huawei.com>
Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 drivers/perf/fsl_imx8_ddr_perf.c | 45 +++++++++++++++++++++++++++++---
 1 file changed, 42 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/fsl_imx8_ddr_perf.c b/drivers/perf/fsl_imx8_ddr_perf.c
index 397540a4b799..c537cd9b8142 100644
--- a/drivers/perf/fsl_imx8_ddr_perf.c
+++ b/drivers/perf/fsl_imx8_ddr_perf.c
@@ -50,21 +50,38 @@ static DEFINE_IDA(ddr_ida);
 
 struct fsl_ddr_devtype_data {
 	unsigned int quirks;    /* quirks needed for different DDR Perf core */
+	const char *identifier;	/* system PMU identifier for userspace */
 };
 
-static const struct fsl_ddr_devtype_data imx8_devtype_data;
+static const struct fsl_ddr_devtype_data imx8_devtype_data = {
+	.identifier = "i.MX8",
+};
+
+static const struct fsl_ddr_devtype_data imx8mq_devtype_data = {
+	.quirks = DDR_CAP_AXI_ID_FILTER,
+	.identifier = "i.MX8MQ",
+};
+
+static const struct fsl_ddr_devtype_data imx8mm_devtype_data = {
+	.quirks = DDR_CAP_AXI_ID_FILTER,
+	.identifier = "i.MX8MM",
+};
 
-static const struct fsl_ddr_devtype_data imx8m_devtype_data = {
+static const struct fsl_ddr_devtype_data imx8mn_devtype_data = {
 	.quirks = DDR_CAP_AXI_ID_FILTER,
+	.identifier = "i.MX8MN",
 };
 
 static const struct fsl_ddr_devtype_data imx8mp_devtype_data = {
 	.quirks = DDR_CAP_AXI_ID_FILTER_ENHANCED,
+	.identifier = "i.MX8MP",
 };
 
 static const struct of_device_id imx_ddr_pmu_dt_ids[] = {
 	{ .compatible = "fsl,imx8-ddr-pmu", .data = &imx8_devtype_data},
-	{ .compatible = "fsl,imx8m-ddr-pmu", .data = &imx8m_devtype_data},
+	{ .compatible = "fsl,imx8mq-ddr-pmu", .data = &imx8mq_devtype_data},
+	{ .compatible = "fsl,imx8mm-ddr-pmu", .data = &imx8mm_devtype_data},
+	{ .compatible = "fsl,imx8mn-ddr-pmu", .data = &imx8mn_devtype_data},
 	{ .compatible = "fsl,imx8mp-ddr-pmu", .data = &imx8mp_devtype_data},
 	{ /* sentinel */ }
 };
@@ -84,6 +101,27 @@ struct ddr_pmu {
 	int id;
 };
 
+static ssize_t ddr_perf_identifier_show(struct device *dev,
+					struct device_attribute *attr,
+					char *page)
+{
+	struct ddr_pmu *pmu = dev_get_drvdata(dev);
+
+	return sprintf(page, "%s\n", pmu->devtype_data->identifier);
+}
+
+static struct device_attribute ddr_perf_identifier_attr =
+	__ATTR(identifier, 0444, ddr_perf_identifier_show, NULL);
+
+static struct attribute *ddr_perf_identifier_attrs[] = {
+	&ddr_perf_identifier_attr.attr,
+	NULL,
+};
+
+static struct attribute_group ddr_perf_identifier_attr_group = {
+	.attrs = ddr_perf_identifier_attrs,
+};
+
 enum ddr_perf_filter_capabilities {
 	PERF_CAP_AXI_ID_FILTER = 0,
 	PERF_CAP_AXI_ID_FILTER_ENHANCED,
@@ -237,6 +275,7 @@ static const struct attribute_group *attr_groups[] = {
 	&ddr_perf_format_attr_group,
 	&ddr_perf_cpumask_attr_group,
 	&ddr_perf_filter_cap_attr_group,
+	&ddr_perf_identifier_attr_group,
 	NULL,
 };
 
-- 
2.26.2

