Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FFAE27FBFC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Oct 2020 10:55:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731638AbgJAIzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Oct 2020 04:55:42 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:7854 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725921AbgJAIzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Oct 2020 04:55:42 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0918s3Yb021078;
        Thu, 1 Oct 2020 04:55:29 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 33t2j4t9hp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Oct 2020 04:55:29 -0400
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 0918tSWu050730
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Thu, 1 Oct 2020 04:55:28 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Thu, 1 Oct 2020
 04:55:19 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Thu, 1 Oct 2020 04:55:19 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 0918tM1o016001;
        Thu, 1 Oct 2020 04:55:24 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <lars@metafoo.de>, <sboyd@kernel.org>, <mturquette@baylibre.com>,
        <mdf@kernel.org>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 2/2] clk: axi-clkgen: Set power bits for fractional mode
Date:   Thu, 1 Oct 2020 11:59:48 +0300
Message-ID: <20201001085948.21412-2-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201001085948.21412-1-alexandru.ardelean@analog.com>
References: <20201001085948.21412-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-01_02:2020-10-01,2020-10-01 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0
 bulkscore=0 clxscore=1015 mlxlogscore=999 mlxscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010010078
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lars-Peter Clausen <lars@metafoo.de>

Using the fractional dividers requires some additional power bits to be
set.

The fractional power bits are not documented and the current heuristic
for setting them seems be insufficient for some cases. Just always set all
the fractional power bits when in fractional mode.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/clk/clk-axi-clkgen.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/clk/clk-axi-clkgen.c b/drivers/clk/clk-axi-clkgen.c
index 1df03cc6d089..14d803e6af62 100644
--- a/drivers/clk/clk-axi-clkgen.c
+++ b/drivers/clk/clk-axi-clkgen.c
@@ -37,6 +37,7 @@
 #define MMCM_REG_LOCK1		0x18
 #define MMCM_REG_LOCK2		0x19
 #define MMCM_REG_LOCK3		0x1a
+#define MMCM_REG_POWER		0x28
 #define MMCM_REG_FILTER1	0x4e
 #define MMCM_REG_FILTER2	0x4f
 
@@ -320,6 +321,7 @@ static int axi_clkgen_set_rate(struct clk_hw *clk_hw,
 	struct axi_clkgen *axi_clkgen = clk_hw_to_axi_clkgen(clk_hw);
 	unsigned int d, m, dout;
 	struct axi_clkgen_div_params params;
+	uint32_t power = 0;
 	uint32_t filter;
 	uint32_t lock;
 
@@ -331,6 +333,11 @@ static int axi_clkgen_set_rate(struct clk_hw *clk_hw,
 	if (d == 0 || dout == 0 || m == 0)
 		return -EINVAL;
 
+	if ((dout & 0x7) != 0 || (m & 0x7) != 0)
+		power |= 0x9800;
+
+	axi_clkgen_mmcm_write(axi_clkgen, MMCM_REG_POWER, power, 0x9800);
+
 	filter = axi_clkgen_lookup_filter(m - 1);
 	lock = axi_clkgen_lookup_lock(m - 1);
 
-- 
2.17.1

