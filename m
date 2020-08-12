Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE15242B4A
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Aug 2020 16:20:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgHLOUc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Aug 2020 10:20:32 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:21862 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726898AbgHLOUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 10:20:15 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07CECIKJ020926;
        Wed, 12 Aug 2020 10:20:03 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 32sry4drtq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Aug 2020 10:20:02 -0400
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 07CEK1TI003676
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Wed, 12 Aug 2020 10:20:01 -0400
Received: from SCSQCASHYB7.ad.analog.com (10.77.17.133) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 12 Aug 2020 07:19:59 -0700
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQCASHYB7.ad.analog.com (10.77.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 12 Aug 2020 07:19:59 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Wed, 12 Aug 2020 07:19:59 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 07CEJoT0020255;
        Wed, 12 Aug 2020 10:19:57 -0400
From:   <alexandru.tachici@analog.com>
To:     <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <linux@roeck-us.net>,
        Alexandru Tachici <alexandru.tachici@analog.com>
Subject: [PATCH v8 5/6] hwmon: pmbus: adm1266: read blackbox
Date:   Wed, 12 Aug 2020 17:20:54 +0300
Message-ID: <20200812142055.9213-6-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200812142055.9213-1-alexandru.tachici@analog.com>
References: <20200812142055.9213-1-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-12_06:2020-08-11,2020-08-12 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 phishscore=0 suspectscore=0 impostorscore=0 malwarescore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008120101
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandru Tachici <alexandru.tachici@analog.com>

Use the nvmem kernel api to expose the black box
chip functionality to userspace.

Using this feature, the device is capable of recording
to nonvolatile flash memory the vital data about the
system status that caused the system to perform a
black box write.

A blackbox is 64 bytes of data containing all the
status registers, last two states of the sequencer,
timestamp and counters. The mapping of this data is
described in the adm1266 datasheet.

On power-up the driver sets the unix time to
the adm1266 using the SET_RTC command. This value
is incremented by an internal clock and it is used
as timestamp for the black box feature.

Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
---
 drivers/hwmon/pmbus/adm1266.c | 127 ++++++++++++++++++++++++++++++++++
 1 file changed, 127 insertions(+)

diff --git a/drivers/hwmon/pmbus/adm1266.c b/drivers/hwmon/pmbus/adm1266.c
index df7954e2ce9f..1d83c4f42eaf 100644
--- a/drivers/hwmon/pmbus/adm1266.c
+++ b/drivers/hwmon/pmbus/adm1266.c
@@ -15,12 +15,19 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/nvmem-consumer.h>
+#include <linux/nvmem-provider.h>
 #include "pmbus.h"
 #include <linux/slab.h>
+#include <linux/timekeeping.h>
 
+#define ADM1266_BLACKBOX_CONFIG	0xD3
 #define ADM1266_PDIO_CONFIG	0xD4
 #define ADM1266_READ_STATE	0xD9
+#define ADM1266_READ_BLACKBOX	0xDE
+#define ADM1266_SET_RTC		0xDF
 #define ADM1266_GPIO_CONFIG	0xE1
+#define ADM1266_BLACKBOX_INFO	0xE6
 #define ADM1266_PDIO_STATUS	0xE9
 #define ADM1266_GPIO_STATUS	0xEA
 
@@ -37,6 +44,9 @@
 #define ADM1266_PDIO_GLITCH_FILT(x)	FIELD_GET(GENMASK(12, 9), x)
 #define ADM1266_PDIO_OUT_CFG(x)		FIELD_GET(GENMASK(2, 0), x)
 
+#define ADM1266_BLACKBOX_OFFSET		0
+#define ADM1266_BLACKBOX_SIZE		64
+
 #define ADM1266_PMBUS_BLOCK_MAX		255
 
 struct adm1266_data {
@@ -45,11 +55,22 @@ struct adm1266_data {
 	const char *gpio_names[ADM1266_GPIO_NR + ADM1266_PDIO_NR];
 	struct i2c_client *client;
 	struct dentry *debugfs_dir;
+	struct nvmem_config nvmem_config;
+	struct nvmem_device *nvmem;
+	u8 *dev_mem;
 	struct mutex buf_mutex;
 	u8 write_buf[ADM1266_PMBUS_BLOCK_MAX + 1] ____cacheline_aligned;
 	u8 read_buf[ADM1266_PMBUS_BLOCK_MAX + 1] ____cacheline_aligned;
 };
 
+static const struct nvmem_cell_info adm1266_nvmem_cells[] = {
+	{
+		.name           = "blackbox",
+		.offset         = ADM1266_BLACKBOX_OFFSET,
+		.bytes          = 2048,
+	},
+};
+
 DECLARE_CRC8_TABLE(pmbus_crc_table);
 
 /*
@@ -325,6 +346,104 @@ static void adm1266_init_debugfs(struct adm1266_data *data)
 				    adm1266_state_read);
 }
 
+static int adm1266_nvmem_read_blackbox(struct adm1266_data *data, u8 *read_buff)
+{
+	int record_count;
+	char index;
+	u8 buf[5];
+	int ret;
+
+	ret = i2c_smbus_read_block_data(data->client, ADM1266_BLACKBOX_INFO, buf);
+	if (ret < 0)
+		return ret;
+
+	if (ret != 4)
+		return -EIO;
+
+	record_count = buf[3];
+
+	for (index = 0; index < record_count; index++) {
+		ret = adm1266_pmbus_block_xfer(data, ADM1266_READ_BLACKBOX, 1, &index, read_buff);
+		if (ret < 0)
+			return ret;
+
+		if (ret != ADM1266_BLACKBOX_SIZE)
+			return -EIO;
+
+		read_buff += ADM1266_BLACKBOX_SIZE;
+	}
+
+	return 0;
+}
+
+static int adm1266_nvmem_read(void *priv, unsigned int offset, void *val, size_t bytes)
+{
+	struct adm1266_data *data = priv;
+	int ret;
+
+	if (offset + bytes > data->nvmem_config.size)
+		return -EINVAL;
+
+	if (offset == 0) {
+		memset(data->dev_mem, 0, data->nvmem_config.size);
+
+		ret = adm1266_nvmem_read_blackbox(data, data->dev_mem);
+		if (ret) {
+			dev_err(&data->client->dev, "Could not read blackbox!");
+			return ret;
+		}
+	}
+
+	memcpy(val, data->dev_mem + offset, bytes);
+
+	return 0;
+}
+
+static int adm1266_config_nvmem(struct adm1266_data *data)
+{
+	data->nvmem_config.name = dev_name(&data->client->dev);
+	data->nvmem_config.dev = &data->client->dev;
+	data->nvmem_config.root_only = true;
+	data->nvmem_config.read_only = true;
+	data->nvmem_config.owner = THIS_MODULE;
+	data->nvmem_config.reg_read = adm1266_nvmem_read;
+	data->nvmem_config.cells = adm1266_nvmem_cells;
+	data->nvmem_config.ncells = ARRAY_SIZE(adm1266_nvmem_cells);
+	data->nvmem_config.priv = data;
+	data->nvmem_config.stride = 1;
+	data->nvmem_config.word_size = 1;
+	data->nvmem_config.size = adm1266_nvmem_cells[0].bytes;
+
+	data->dev_mem = devm_kzalloc(&data->client->dev, data->nvmem_config.size, GFP_KERNEL);
+	if (!data->dev_mem)
+		return -ENOMEM;
+
+	data->nvmem = devm_nvmem_register(&data->client->dev, &data->nvmem_config);
+	if (IS_ERR(data->nvmem)) {
+		dev_err(&data->client->dev, "Could not register nvmem!");
+		return PTR_ERR(data->nvmem);
+	}
+
+	return 0;
+}
+
+static int adm1266_set_rtc(struct adm1266_data *data)
+{
+	time64_t kt;
+	char write_buf[6];
+	int i;
+
+	kt = ktime_get_seconds();
+
+	memset(write_buf, 0, sizeof(write_buf));
+
+	for (i = 0; i < 4; i++)
+		write_buf[2 + i] = (kt >> (i * 8)) & 0xFF;
+
+	return i2c_smbus_write_block_data(data->client, ADM1266_SET_RTC, sizeof(write_buf),
+					  write_buf);
+}
+
 static int adm1266_probe(struct i2c_client *client, const struct i2c_device_id *id)
 {
 	struct adm1266_data *data;
@@ -348,6 +467,14 @@ static int adm1266_probe(struct i2c_client *client, const struct i2c_device_id *
 	if (ret < 0)
 		return ret;
 
+	ret = adm1266_set_rtc(data);
+	if (ret < 0)
+		return ret;
+
+	ret = adm1266_config_nvmem(data);
+	if (ret < 0)
+		return ret;
+
 	ret = pmbus_do_probe(client, id, &data->info);
 	if (ret)
 		return ret;
-- 
2.20.1

