Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03E6327D17A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 16:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731472AbgI2Ok1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 10:40:27 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:9810 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729146AbgI2OkX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 10:40:23 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08TEdJjl008158;
        Tue, 29 Sep 2020 10:40:21 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 33syg63kky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 29 Sep 2020 10:40:21 -0400
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 08TEeJZ6041975
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 29 Sep 2020 10:40:20 -0400
Received: from SCSQCASHYB7.ad.analog.com (10.77.17.133) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 29 Sep 2020 07:40:12 -0700
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQCASHYB7.ad.analog.com (10.77.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 29 Sep 2020 07:40:11 -0700
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 29 Sep 2020 07:40:11 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 08TEdkc4028450;
        Tue, 29 Sep 2020 10:40:14 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-clk@vger.kernel.org>, <linux-fpga@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <mturquette@baylibre.com>, <sboyd@kernel.org>, <mdf@kernel.org>,
        <ardeleanalex@gmail.com>, Dragos Bogdan <dragos.bogdan@analog.com>,
        "Alexandru Ardelean" <alexandru.ardelean@analog.com>
Subject: [PATCH v4 3/7] clk: axi-clkgen: add support for ZynqMP (UltraScale)
Date:   Tue, 29 Sep 2020 17:44:13 +0300
Message-ID: <20200929144417.89816-12-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929144417.89816-1-alexandru.ardelean@analog.com>
References: <20200929144417.89816-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-29_07:2020-09-29,2020-09-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 lowpriorityscore=0
 spamscore=0 bulkscore=0 mlxscore=0 clxscore=1015 mlxlogscore=599
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009290130
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dragos Bogdan <dragos.bogdan@analog.com>

This IP core also works and is supported on the Xilinx ZynqMP (UltraScale)
FPGA boards.
This patch enables the driver to be available on these platforms as well.

Signed-off-by: Dragos Bogdan <dragos.bogdan@analog.com>
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/clk/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index b41aaed9bd51..6d76591c0bc4 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -239,7 +239,7 @@ config CLK_TWL6040
 
 config COMMON_CLK_AXI_CLKGEN
 	tristate "AXI clkgen driver"
-	depends on ARCH_ZYNQ || MICROBLAZE || COMPILE_TEST
+	depends on ARCH_ZYNQ || ARCH_ZYNQMP || MICROBLAZE || COMPILE_TEST
 	help
 	  Support for the Analog Devices axi-clkgen pcore clock generator for Xilinx
 	  FPGAs. It is commonly used in Analog Devices' reference designs.
-- 
2.17.1

