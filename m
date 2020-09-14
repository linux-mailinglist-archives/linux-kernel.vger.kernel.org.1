Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33ECD269453
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Sep 2020 20:04:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbgINSEs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Sep 2020 14:04:48 -0400
Received: from mail-bn7nam10on2093.outbound.protection.outlook.com ([40.107.92.93]:44683
        "EHLO NAM10-BN7-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725997AbgINSEf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Sep 2020 14:04:35 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a0Lbz96zVKXa4tJGSU2pfOPP/eX2pUhlyN/IFvvGgm+cCySLRomPGgJ81IgLaD0FsHQQjZidkjDyS6C5HucIElDKn6uHhR0R66A8der97MX8ToC24y2YXiCCTUUnHmoTfOnFgL4rolPI2xXI2BHCjU7vXsE9E6TaR+CvbuIKZo+4Mt8OoCTS4rFAr1cL93L/6D1oBTTU3EwQMuVsS3dneESGtiNz1SpBwkYgjx8V9ZK4jgzA/bqzbYFcsqAvuT2ob3/ItsL+1hBbhIPhpiSmHV1UDguOi9YEDxAu/tZCPLDfkn/poPsgcXgubsY/tAUSiYyGpx0APSOm7qcZltTPdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NGenN352XrouZSYw6eUjoUbZMYlUWuf+HXv+3/OREkc=;
 b=k+9SvDO7UbPLliF+1wgxsiTIb18Fg+hOdtuQMJWR7FQBORvm/RIVfIFKT0xJ0DNDkE0YgO1nEWd9/UlZ5hHgO5nekDqtlv0HJ9AxiBfC/BtNxBNVLEIVGel1KXGua6vv1SVrkxQclcFX3995cNRLRVAgY5d715VBssT1kq2lOPX4NENuD1kmNZMCBWexG02VRHTxBTtUVYCDVMLR84AtYd0dK0F8mRsqq5d5ZhSedl6gpKJsHtu5+gH//KJV5x7OkhUErjhxI7EJM0VZZJ33xMG7tUlDAvWW4emOhPxcR4L7/m0Gll10yWqzVL3RHwve0XijMBfr/TmjyhRY+wq1tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NGenN352XrouZSYw6eUjoUbZMYlUWuf+HXv+3/OREkc=;
 b=m2D3E5srGAX9QkNon64BD/BBh1jFWFEV1kfu+SulintL8gwsNw8KJqrXJ6xt0Ptq8SD92jaBHJwNUckPRDtDlr5sao2KFGXydf/AGbdBxyH1wNqS4fqjsPMjKHDjVEKRhIwzG57Q0Tx4ZERzl+Y5ZcyOTXl3DQXMNei7P3MyAQk=
Authentication-Results: arm.com; dkim=none (message not signed)
 header.d=none;arm.com; dmarc=none action=none
 header.from=os.amperecomputing.com;
Received: from BYAPR01MB4598.prod.exchangelabs.com (2603:10b6:a03:8a::18) by
 BYAPR01MB5574.prod.exchangelabs.com (2603:10b6:a03:11d::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3348.19; Mon, 14 Sep 2020 18:04:25 +0000
Received: from BYAPR01MB4598.prod.exchangelabs.com
 ([fe80::419e:edaf:d4b1:3b29]) by BYAPR01MB4598.prod.exchangelabs.com
 ([fe80::419e:edaf:d4b1:3b29%4]) with mapi id 15.20.3370.019; Mon, 14 Sep 2020
 18:04:25 +0000
From:   Tuan Phan <tuanphan@os.amperecomputing.com>
Cc:     suzuki.poulose@arm.com, patches@amperecomputing.com,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6] perf: arm_dsu: Support DSU ACPI devices
Date:   Mon, 14 Sep 2020 11:04:16 -0700
Message-Id: <1600106656-9542-1-git-send-email-tuanphan@os.amperecomputing.com>
X-Mailer: git-send-email 2.7.4
Content-Type: text/plain
X-ClientProxiedBy: BY5PR13CA0029.namprd13.prod.outlook.com
 (2603:10b6:a03:180::42) To BYAPR01MB4598.prod.exchangelabs.com
 (2603:10b6:a03:8a::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from aptiov-dev-Latitude-E7470.amperecomputing.com (4.28.12.214) by BY5PR13CA0029.namprd13.prod.outlook.com (2603:10b6:a03:180::42) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.20.3391.5 via Frontend Transport; Mon, 14 Sep 2020 18:04:24 +0000
X-Mailer: git-send-email 2.7.4
X-Originating-IP: [4.28.12.214]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 95a9a198-26be-4f4a-a554-08d858d89d2c
X-MS-TrafficTypeDiagnostic: BYAPR01MB5574:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR01MB55741F06E7B38C79BF1BDE41E0230@BYAPR01MB5574.prod.exchangelabs.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1923;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t6+12FMBcgSQDPIuS4WXouCsy32c0QGmOBK1w45p7oUDwGkefouMrbLrCtNOikgyBSPFIsxFHkWLviqjOTYPJ16FyIKpAxvBZ2MbH2ExqacdywtSJxqIRgtQ9P3hEBxAB+EKbtefSFoA8Fy+tyWrAXw9fjATNjP+omwqF9e84w0Xqp14I+ESsbbuspCumMQfaRndfxCZ6fxnztTeJnmnKNKUU6NiDjlPbhgKO4JbOgg+TBrBoH06xJmdi4iLBzBPTUeZOCtsbxm5+qD1wVB1srhFBsb1hbB4SdQlQMMfcX4IdCbsihtUNkjY7no+lYrgy20RXAJ+QFVEGntbl6oP/RvMgUc7Znxz/gR8dVzjnk7U+edD1mPxCC1ZqTuA3p7exYRQ0Y/l55Yarqbi36nc2LfRKL2TDxM70na/77I94s9DLDBSyVZQ97PP9rFi3qfGSmrn1jqZ53KbGZ5+EDK0rA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR01MB4598.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(136003)(376002)(396003)(39840400004)(4326008)(6666004)(66556008)(2616005)(5660300002)(26005)(83380400001)(8676002)(6506007)(52116002)(8936002)(956004)(54906003)(66476007)(316002)(186003)(16526019)(109986005)(66946007)(478600001)(6512007)(6486002)(2906002)(966005)(86362001)(266003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: BUfC197NV1wn+KO8yKcCZsVIM3HpzZUHEpUXGXidcpB2YOc1W+Cl8XTSEkA966Dr8od8biAMQgMYOo5iNezvcS8PpSOvuzVsMUv6h7de6bj5j6jk+a+4wtv9T3JplBY0SRs1B0Zb91aIeXNsLrFCbGkvZ/zK9Cejj0c1dfLGYDuizoxT1dmYQ78tOv+P7r3E4lbXcsXicsEshy2wpxMq/uCW9xAGkzw/IC1zl7lSWIyRDfaH1qBz0OM9H714xMw+fx1oTXPqCUmJ42vvgzaUHHsvmwRXqPvTOJSz31oY9mgjGv0CoCY3rcaRaRUrJKjXvhiZMpzYSiCYp4ClrAdfoQS3kEyCy7jwsblbi4BOzbGGAi8KOZ71vPYsIXgrXvZx1wN//F8t+OvrmAJKj565XxVTDoTsILRHU0eoAMPQggm0mZoBtBuOA30VRASC0WVCRGTRCOnDNvIougyikip4aEOzaQ30zrMFH1rYq+iwA3ajid0pN+AgYd1K1VFHvGKGl58D92h0VEHOsL9CCNlun21x+XA52ycTOCnWdnB/+f/SVd8GX6Khc+li97rYkXOWHx1g9UD4VxoNK9XmhvvKAiquDJVhIa1zLnP63Xz+u1nK1ngKXSTLhnBSUoFawGQNsytkFDg2Sd/4EQMmsMs9BQ==
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 95a9a198-26be-4f4a-a554-08d858d89d2c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR01MB4598.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2020 18:04:24.9772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LikD5BUEI7lQ2+kXbk5Io8hkEqPmF8RPntRtIxp0OOeeyvDX7Y8/JcEBuBKVSpS4Kuxoxf5AU5A0X9sMqVcNZ9hpM4Gn7QtnRJtJqN058FOEgdOTsqqxPwxakV9simsj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR01MB5574
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for probing device from ACPI node.
Each DSU ACPI node and its associated cpus are inside a cluster node.

Signed-off-by: Tuan Phan <tuanphan@os.amperecomputing.com>
---
Changes in v6:
- Fixed warning with no CONFIG_ACPI.

Changes in v5:
- Used CONFIG_ACPI to fix compiling issue.

Changes in v4:
- Addressed Will's comments.

Changes in v3:
- Based on the latest ARM ACPI binding at: https://developer.arm.com/documentation/den0093/c/

Changes in v2:
- Removed IRQF_SHARED.
- Fixed ACPI runtime detection.

 drivers/perf/arm_dsu_pmu.c | 63 +++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 57 insertions(+), 6 deletions(-)

diff --git a/drivers/perf/arm_dsu_pmu.c b/drivers/perf/arm_dsu_pmu.c
index 96ed93c..98e68ed 100644
--- a/drivers/perf/arm_dsu_pmu.c
+++ b/drivers/perf/arm_dsu_pmu.c
@@ -11,6 +11,7 @@
 #define DRVNAME		PMUNAME "_pmu"
 #define pr_fmt(fmt)	DRVNAME ": " fmt
 
+#include <linux/acpi.h>
 #include <linux/bitmap.h>
 #include <linux/bitops.h>
 #include <linux/bug.h>
@@ -603,18 +604,19 @@ static struct dsu_pmu *dsu_pmu_alloc(struct platform_device *pdev)
 }
 
 /**
- * dsu_pmu_dt_get_cpus: Get the list of CPUs in the cluster.
+ * dsu_pmu_dt_get_cpus: Get the list of CPUs in the cluster
+ * from device tree.
  */
-static int dsu_pmu_dt_get_cpus(struct device_node *dev, cpumask_t *mask)
+static int dsu_pmu_dt_get_cpus(struct device *dev, cpumask_t *mask)
 {
 	int i = 0, n, cpu;
 	struct device_node *cpu_node;
 
-	n = of_count_phandle_with_args(dev, "cpus", NULL);
+	n = of_count_phandle_with_args(dev->of_node, "cpus", NULL);
 	if (n <= 0)
 		return -ENODEV;
 	for (; i < n; i++) {
-		cpu_node = of_parse_phandle(dev, "cpus", i);
+		cpu_node = of_parse_phandle(dev->of_node, "cpus", i);
 		if (!cpu_node)
 			break;
 		cpu = of_cpu_node_to_id(cpu_node);
@@ -631,6 +633,36 @@ static int dsu_pmu_dt_get_cpus(struct device_node *dev, cpumask_t *mask)
 	return 0;
 }
 
+/**
+ * dsu_pmu_acpi_get_cpus: Get the list of CPUs in the cluster
+ * from ACPI.
+ */
+static int dsu_pmu_acpi_get_cpus(struct device *dev, cpumask_t *mask)
+{
+#ifdef CONFIG_ACPI
+	int cpu;
+
+	/*
+	 * A dsu pmu node is inside a cluster parent node along with cpu nodes.
+	 * We need to find out all cpus that have the same parent with this pmu.
+	 */
+	for_each_possible_cpu(cpu) {
+		struct acpi_device *acpi_dev;
+		struct device *cpu_dev = get_cpu_device(cpu);
+
+		if (!cpu_dev)
+			continue;
+
+		acpi_dev = ACPI_COMPANION(cpu_dev);
+		if (acpi_dev &&
+			acpi_dev->parent == ACPI_COMPANION(dev)->parent)
+			cpumask_set_cpu(cpu, mask);
+	}
+#endif
+
+	return 0;
+}
+
 /*
  * dsu_pmu_probe_pmu: Probe the PMU details on a CPU in the cluster.
  */
@@ -676,6 +708,7 @@ static int dsu_pmu_device_probe(struct platform_device *pdev)
 {
 	int irq, rc;
 	struct dsu_pmu *dsu_pmu;
+	struct fwnode_handle *fwnode = dev_fwnode(&pdev->dev);
 	char *name;
 	static atomic_t pmu_idx = ATOMIC_INIT(-1);
 
@@ -683,7 +716,16 @@ static int dsu_pmu_device_probe(struct platform_device *pdev)
 	if (IS_ERR(dsu_pmu))
 		return PTR_ERR(dsu_pmu);
 
-	rc = dsu_pmu_dt_get_cpus(pdev->dev.of_node, &dsu_pmu->associated_cpus);
+	if (IS_ERR_OR_NULL(fwnode))
+		return -ENOENT;
+
+	if (is_of_node(fwnode))
+		rc = dsu_pmu_dt_get_cpus(&pdev->dev, &dsu_pmu->associated_cpus);
+	else if (is_acpi_device_node(fwnode))
+		rc = dsu_pmu_acpi_get_cpus(&pdev->dev, &dsu_pmu->associated_cpus);
+	else
+		return -ENOENT;
+
 	if (rc) {
 		dev_warn(&pdev->dev, "Failed to parse the CPUs\n");
 		return rc;
@@ -752,11 +794,21 @@ static const struct of_device_id dsu_pmu_of_match[] = {
 	{ .compatible = "arm,dsu-pmu", },
 	{},
 };
+MODULE_DEVICE_TABLE(of, dsu_pmu_of_match);
+
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id dsu_pmu_acpi_match[] = {
+	{ "ARMHD500", 0},
+	{},
+};
+MODULE_DEVICE_TABLE(acpi, dsu_pmu_acpi_match);
+#endif
 
 static struct platform_driver dsu_pmu_driver = {
 	.driver = {
 		.name	= DRVNAME,
 		.of_match_table = of_match_ptr(dsu_pmu_of_match),
+		.acpi_match_table = ACPI_PTR(dsu_pmu_acpi_match),
 		.suppress_bind_attrs = true,
 	},
 	.probe = dsu_pmu_device_probe,
@@ -826,7 +878,6 @@ static void __exit dsu_pmu_exit(void)
 module_init(dsu_pmu_init);
 module_exit(dsu_pmu_exit);
 
-MODULE_DEVICE_TABLE(of, dsu_pmu_of_match);
 MODULE_DESCRIPTION("Perf driver for ARM DynamIQ Shared Unit");
 MODULE_AUTHOR("Suzuki K Poulose <suzuki.poulose@arm.com>");
 MODULE_LICENSE("GPL v2");
-- 
2.7.4

