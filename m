Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78A652A93F2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 11:18:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726949AbgKFKSw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 05:18:52 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:47400 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726891AbgKFKSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 05:18:51 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A6AH4hJ028767;
        Fri, 6 Nov 2020 05:18:35 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 34j3bx27u9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Nov 2020 05:18:35 -0500
Received: from SCSQMBX10.ad.analog.com (SCSQMBX10.ad.analog.com [10.77.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 0A6AIY3P006274
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Fri, 6 Nov 2020 05:18:34 -0500
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 6 Nov 2020 02:18:32 -0800
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Fri, 6 Nov 2020 02:18:32 -0800
Received: from saturn.ad.analog.com ([10.48.65.107])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 0A6AISTP016474;
        Fri, 6 Nov 2020 05:18:30 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <linux@roeck-us.net>, <jdelvare@suse.com>,
        <ardeleanalex@gmail.com>, <Mark.Thoren@analog.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH 2/3] docs: hwmon: (ltc2945): change type of val to ULL in ltc2945_val_to_reg()
Date:   Fri, 6 Nov 2020 12:18:24 +0200
Message-ID: <20201106101825.30960-2-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201106101825.30960-1-alexandru.ardelean@analog.com>
References: <20201106101825.30960-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-06_03:2020-11-05,2020-11-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1015
 adultscore=0 spamscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 impostorscore=0 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011060073
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to account for any potential overflows that could occur.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/hwmon/ltc2945.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/hwmon/ltc2945.c b/drivers/hwmon/ltc2945.c
index 1cea710df668..75d997d31e01 100644
--- a/drivers/hwmon/ltc2945.c
+++ b/drivers/hwmon/ltc2945.c
@@ -155,7 +155,7 @@ static long long ltc2945_reg_to_val(struct device *dev, u8 reg)
 }
 
 static int ltc2945_val_to_reg(struct device *dev, u8 reg,
-			      unsigned long val)
+			      unsigned long long val)
 {
 	struct ltc2945_state *st = dev_get_drvdata(dev);
 	struct regmap *regmap = st->regmap;
@@ -181,14 +181,14 @@ static int ltc2945_val_to_reg(struct device *dev, u8 reg,
 			return ret;
 		if (control & CONTROL_MULT_SELECT) {
 			/* 25 mV * 25 uV = 0.625 uV resolution. */
-			val = DIV_ROUND_CLOSEST(val, 625);
+			val = DIV_ROUND_CLOSEST_ULL(val, 625);
 		} else {
 			/*
 			 * 0.5 mV * 25 uV = 0.0125 uV resolution.
 			 * Divide first to avoid overflow;
 			 * accept loss of accuracy.
 			 */
-			val = DIV_ROUND_CLOSEST(val, 25) * 2;
+			val = DIV_ROUND_CLOSEST_ULL(val, 25) * 2;
 		}
 		break;
 	case LTC2945_VIN_H:
@@ -197,7 +197,7 @@ static int ltc2945_val_to_reg(struct device *dev, u8 reg,
 	case LTC2945_MAX_VIN_THRES_H:
 	case LTC2945_MIN_VIN_THRES_H:
 		/* 25 mV resolution. */
-		val /= 25;
+		val = div_u64(val, 25);
 		break;
 	case LTC2945_ADIN_H:
 	case LTC2945_MAX_ADIN_H:
@@ -219,7 +219,7 @@ static int ltc2945_val_to_reg(struct device *dev, u8 reg,
 		 * dividing the reported current by the sense resistor value
 		 * in mOhm.
 		 */
-		val = DIV_ROUND_CLOSEST(val, 25);
+		val = DIV_ROUND_CLOSEST_ULL(val, 25);
 		break;
 	default:
 		return -EINVAL;
@@ -247,13 +247,13 @@ static ssize_t ltc2945_value_store(struct device *dev,
 	struct ltc2945_state *st = dev_get_drvdata(dev);
 	struct regmap *regmap = st->regmap;
 	u8 reg = attr->index;
-	unsigned long val;
+	unsigned long long val;
 	u8 regbuf[3];
 	int num_regs;
 	int regval;
 	int ret;
 
-	ret = kstrtoul(buf, 10, &val);
+	ret = kstrtoull(buf, 10, &val);
 	if (ret)
 		return ret;
 
-- 
2.27.0

