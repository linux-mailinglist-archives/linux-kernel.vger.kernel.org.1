Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EABE32AECB4
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Nov 2020 10:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbgKKJIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Nov 2020 04:08:39 -0500
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:9616 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726300AbgKKJIZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Nov 2020 04:08:25 -0500
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AB97fWt014144;
        Wed, 11 Nov 2020 04:08:08 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 34nsc94j4p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 Nov 2020 04:08:08 -0500
Received: from ASHBMBX9.ad.analog.com (ashbmbx9.ad.analog.com [10.64.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 0AB987Bc040535
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 11 Nov 2020 04:08:07 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Wed, 11 Nov
 2020 04:08:06 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Wed, 11 Nov 2020 04:08:06 -0500
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 0AB981gF023509;
        Wed, 11 Nov 2020 04:08:03 -0500
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-hwmon@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <linux@roeck-us.net>, <jdelvare@suse.com>,
        <mark.thoren@analog.com>, <ardeleanalex@gmail.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH v2 1/4] hwmon: (ltc2945): wrap regmap into an ltc2945_state struct
Date:   Wed, 11 Nov 2020 11:12:56 +0200
Message-ID: <20201111091259.46773-2-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201111091259.46773-1-alexandru.ardelean@analog.com>
References: <20201111091259.46773-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-11_02:2020-11-10,2020-11-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 adultscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011110050
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The intent is to add pass the value of the sense resistor in the driver.
This change wraps a 'struct ltc2945_state', and moves the regmap reference
on that object.

Then we can add the value of the sense resistor, or other information that
would be useful for the driver.

Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---
 drivers/hwmon/ltc2945.c | 30 +++++++++++++++++++++++++-----
 1 file changed, 25 insertions(+), 5 deletions(-)

diff --git a/drivers/hwmon/ltc2945.c b/drivers/hwmon/ltc2945.c
index ba9c868a8641..1cea710df668 100644
--- a/drivers/hwmon/ltc2945.c
+++ b/drivers/hwmon/ltc2945.c
@@ -58,6 +58,14 @@
 #define CONTROL_MULT_SELECT	(1 << 0)
 #define CONTROL_TEST_MODE	(1 << 4)
 
+/**
+ * struct ltc2945_state - driver instance specific data
+ * @regmap		regmap object to access device registers
+ */
+struct ltc2945_state {
+	struct regmap		*regmap;
+};
+
 static inline bool is_power_reg(u8 reg)
 {
 	return reg < LTC2945_SENSE_H;
@@ -66,7 +74,8 @@ static inline bool is_power_reg(u8 reg)
 /* Return the value from the given register in uW, mV, or mA */
 static long long ltc2945_reg_to_val(struct device *dev, u8 reg)
 {
-	struct regmap *regmap = dev_get_drvdata(dev);
+	struct ltc2945_state *st = dev_get_drvdata(dev);
+	struct regmap *regmap = st->regmap;
 	unsigned int control;
 	u8 buf[3];
 	long long val;
@@ -148,7 +157,8 @@ static long long ltc2945_reg_to_val(struct device *dev, u8 reg)
 static int ltc2945_val_to_reg(struct device *dev, u8 reg,
 			      unsigned long val)
 {
-	struct regmap *regmap = dev_get_drvdata(dev);
+	struct ltc2945_state *st = dev_get_drvdata(dev);
+	struct regmap *regmap = st->regmap;
 	unsigned int control;
 	int ret;
 
@@ -234,7 +244,8 @@ static ssize_t ltc2945_value_store(struct device *dev,
 				   const char *buf, size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
-	struct regmap *regmap = dev_get_drvdata(dev);
+	struct ltc2945_state *st = dev_get_drvdata(dev);
+	struct regmap *regmap = st->regmap;
 	u8 reg = attr->index;
 	unsigned long val;
 	u8 regbuf[3];
@@ -269,7 +280,8 @@ static ssize_t ltc2945_history_store(struct device *dev,
 				     const char *buf, size_t count)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
-	struct regmap *regmap = dev_get_drvdata(dev);
+	struct ltc2945_state *st = dev_get_drvdata(dev);
+	struct regmap *regmap = st->regmap;
 	u8 reg = attr->index;
 	int num_regs = is_power_reg(reg) ? 3 : 2;
 	u8 buf_min[3] = { 0xff, 0xff, 0xff };
@@ -321,7 +333,8 @@ static ssize_t ltc2945_bool_show(struct device *dev,
 				 struct device_attribute *da, char *buf)
 {
 	struct sensor_device_attribute *attr = to_sensor_dev_attr(da);
-	struct regmap *regmap = dev_get_drvdata(dev);
+	struct ltc2945_state *st = dev_get_drvdata(dev);
+	struct regmap *regmap = st->regmap;
 	unsigned int fault;
 	int ret;
 
@@ -448,15 +461,22 @@ static const struct regmap_config ltc2945_regmap_config = {
 static int ltc2945_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
+	struct ltc2945_state *st;
 	struct device *hwmon_dev;
 	struct regmap *regmap;
 
+	st = devm_kzalloc(dev, sizeof(*st), GFP_KERNEL);
+	if (!st)
+		return -ENOMEM;
+
 	regmap = devm_regmap_init_i2c(client, &ltc2945_regmap_config);
 	if (IS_ERR(regmap)) {
 		dev_err(dev, "failed to allocate register map\n");
 		return PTR_ERR(regmap);
 	}
 
+	st->regmap = regmap;
+
 	/* Clear faults */
 	regmap_write(regmap, LTC2945_FAULT, 0x00);
 
-- 
2.17.1

