Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B732B2406D9
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Aug 2020 15:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727050AbgHJNmk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Aug 2020 09:42:40 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:65408 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726978AbgHJNmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 09:42:05 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07ADdwKt004706;
        Mon, 10 Aug 2020 09:42:01 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 32snw56v3c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 10 Aug 2020 09:42:00 -0400
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 07ADfxqH061551
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 10 Aug 2020 09:41:59 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Mon, 10 Aug
 2020 09:41:58 -0400
Received: from zeus.spd.analog.com (10.64.82.11) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 10 Aug 2020 09:41:58 -0400
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 07ADfY3n030109;
        Mon, 10 Aug 2020 09:41:56 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-clk@vger.kernel.org>, <linux-fpga@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <mturquette@baylibre.com>, <sboyd@kernel.org>, <mdf@kernel.org>,
        <ardeleanalex@gmail.com>, Mathias Tausen <mta@gomspace.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 4/6] clk: axi-clkgen: Respect ZYNQMP PFD/VCO frequency limits
Date:   Mon, 10 Aug 2020 16:42:50 +0300
Message-ID: <20200810134252.68614-12-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200810134252.68614-1-alexandru.ardelean@analog.com>
References: <20200810134252.68614-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-10_09:2020-08-06,2020-08-10 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 clxscore=1015 impostorscore=0 mlxscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 lowpriorityscore=0 mlxlogscore=680 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008100102
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mathias Tausen <mta@gomspace.com>

Since axi-clkgen is now supported on ZYNQMP, make sure the max/min
frequencies of the PFD and VCO are respected.

Signed-off-by: Mathias Tausen <mta@gomspace.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/clk/clk-axi-clkgen.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/clk/clk-axi-clkgen.c b/drivers/clk/clk-axi-clkgen.c
index 14d803e6af62..6ffc19e9d850 100644
--- a/drivers/clk/clk-axi-clkgen.c
+++ b/drivers/clk/clk-axi-clkgen.c
@@ -100,10 +100,17 @@ static uint32_t axi_clkgen_lookup_lock(unsigned int m)
 	return 0x1f1f00fa;
 }
 
+#ifdef ARCH_ZYNQMP
+static const unsigned int fpfd_min = 10000;
+static const unsigned int fpfd_max = 450000;
+static const unsigned int fvco_min = 800000;
+static const unsigned int fvco_max = 1600000;
+#else
 static const unsigned int fpfd_min = 10000;
 static const unsigned int fpfd_max = 300000;
 static const unsigned int fvco_min = 600000;
 static const unsigned int fvco_max = 1200000;
+#endif
 
 static void axi_clkgen_calc_params(unsigned long fin, unsigned long fout,
 	unsigned int *best_d, unsigned int *best_m, unsigned int *best_dout)
-- 
2.17.1

