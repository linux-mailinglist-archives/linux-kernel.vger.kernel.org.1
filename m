Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32DA8292645
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Oct 2020 13:14:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727811AbgJSLOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Oct 2020 07:14:45 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:47948 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726634AbgJSLOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Oct 2020 07:14:41 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 09JB0I1C019889;
        Mon, 19 Oct 2020 07:14:27 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 347tf662u3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 19 Oct 2020 07:14:27 -0400
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 09JBEQrn032806
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 19 Oct 2020 07:14:26 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Mon, 19 Oct
 2020 07:14:25 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 19 Oct 2020 07:14:25 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 09JBELeU005943;
        Mon, 19 Oct 2020 07:14:23 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <mturquette@baylibre.com>, <sboyd@kernel.org>, <lars@metafoo.de>,
        <mdf@kernel.org>, <ardeleanalex@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 2/2] clk: axi-clkgen: move the OF table at the bottom of the file
Date:   Mon, 19 Oct 2020 14:18:09 +0300
Message-ID: <20201019111809.56374-2-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201019111809.56374-1-alexandru.ardelean@analog.com>
References: <20201019111809.56374-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-19_02:2020-10-16,2020-10-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 bulkscore=0 phishscore=0 adultscore=0 clxscore=1015
 impostorscore=0 mlxlogscore=968 lowpriorityscore=0 malwarescore=0
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010190082
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The change is mostly cosmetic. No functional changes.
Since the driver now uses device_get_match_data() to obtain the driver
specific info, there is no need to define the OF table before the probe
function.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/clk/clk-axi-clkgen.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/clk/clk-axi-clkgen.c b/drivers/clk/clk-axi-clkgen.c
index 963a62e9c728..ad86e031ba3e 100644
--- a/drivers/clk/clk-axi-clkgen.c
+++ b/drivers/clk/clk-axi-clkgen.c
@@ -496,15 +496,6 @@ static const struct clk_ops axi_clkgen_ops = {
 	.get_parent = axi_clkgen_get_parent,
 };
 
-static const struct of_device_id axi_clkgen_ids[] = {
-	{
-		.compatible = "adi,axi-clkgen-2.00.a",
-		.data = &axi_clkgen_zynq_default_limits,
-	},
-	{ },
-};
-MODULE_DEVICE_TABLE(of, axi_clkgen_ids);
-
 static int axi_clkgen_probe(struct platform_device *pdev)
 {
 	const struct axi_clkgen_limits *dflt_limits;
@@ -568,6 +559,15 @@ static int axi_clkgen_remove(struct platform_device *pdev)
 	return 0;
 }
 
+static const struct of_device_id axi_clkgen_ids[] = {
+	{
+		.compatible = "adi,axi-clkgen-2.00.a",
+		.data = &axi_clkgen_zynq_default_limits,
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, axi_clkgen_ids);
+
 static struct platform_driver axi_clkgen_driver = {
 	.driver = {
 		.name = "adi-axi-clkgen",
-- 
2.17.1

