Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E56A2058B6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 19:35:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733085AbgFWRfO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 13:35:14 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:11850 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732408AbgFWRfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 13:35:14 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05NHOqaD009632;
        Tue, 23 Jun 2020 13:35:12 -0400
Received: from nwd2mta3.analog.com ([137.71.173.56])
        by mx0a-00128a01.pphosted.com with ESMTP id 31uk23gr7q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Jun 2020 13:35:12 -0400
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 05NHZABW002025
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 23 Jun 2020 13:35:11 -0400
Received: from SCSQMBX10.ad.analog.com (10.77.17.5) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1779.2; Tue, 23 Jun
 2020 10:35:09 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX10.ad.analog.com
 (10.77.17.5) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 23 Jun 2020 10:35:09 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 05NHYxMV017521;
        Tue, 23 Jun 2020 13:35:07 -0400
From:   <alexandru.tachici@analog.com>
To:     <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <linux@roeck-us.net>,
        Alexandru Tachici <alexandru.tachici@analog.com>
Subject: [PATCH v4 6/7] hwmon: pmbus: adm1266: debugfs for blackbox info
Date:   Tue, 23 Jun 2020 20:36:58 +0300
Message-ID: <20200623173659.41358-7-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200623173659.41358-1-alexandru.tachici@analog.com>
References: <20200623173659.41358-1-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-23_11:2020-06-23,2020-06-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 adultscore=0 mlxlogscore=999 phishscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006120000 definitions=main-2006230123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandru Tachici <alexandru.tachici@analog.com>

Add a debugfs file to print information in the
BLACKBOX_INFORMATION register. Contains information
about the number of stored records, logic index and id
of the latest record.

Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
---
 drivers/hwmon/pmbus/adm1266.c | 56 ++++++++++++++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/adm1266.c b/drivers/hwmon/pmbus/adm1266.c
index b9e92ab1e39a..ea2dc481094b 100644
--- a/drivers/hwmon/pmbus/adm1266.c
+++ b/drivers/hwmon/pmbus/adm1266.c
@@ -60,6 +60,7 @@ struct adm1266_data {
 	const char *gpio_names[ADM1266_GPIO_NR + ADM1266_PDIO_NR];
 	struct i2c_client *client;
 	struct mutex ioctl_mutex; /* lock ioctl access */
+	struct dentry *debugfs_dir;
 	struct nvmem_config nvmem_config;
 	struct nvmem_device *nvmem;
 	u8 *dev_mem;
@@ -406,6 +407,28 @@ static const struct proc_ops adm1266_proc_ops = {
 	.proc_ioctl	= adm1266_ioctl,
 };
 
+static int adm1266_blackbox_information_read(struct seq_file *s, void *pdata)
+{
+	struct device *dev = s->private;
+	struct i2c_client *client = to_i2c_client(dev);
+	u8 read_buf[5];
+	unsigned int latest_id;
+	int ret;
+
+	ret = i2c_smbus_read_block_data(client, ADM1266_BLACKBOX_INFO,
+					read_buf);
+	if (ret < 0)
+		return ret;
+
+	seq_puts(s, "BLACKBOX_INFORMATION:\n");
+	latest_id = read_buf[0] + (read_buf[1] << 8);
+	seq_printf(s, "Black box ID: %u\n", latest_id);
+	seq_printf(s, "Logic index: %u\n", read_buf[2]);
+	seq_printf(s, "Record count: %u\n", read_buf[3]);
+
+	return 0;
+}
+
 static int adm1266_init_procfs(struct adm1266_data *data)
 {
 	struct proc_dir_entry *proc_dir;
@@ -423,6 +446,29 @@ static int adm1266_init_procfs(struct adm1266_data *data)
 	return 0;
 }
 
+static int adm1266_init_debugfs(struct adm1266_data *data)
+{
+	struct dentry *entry;
+	struct dentry *root;
+
+	root = pmbus_get_debugfs_dir(data->client);
+	if (!root)
+		return -ENOENT;
+
+	data->debugfs_dir = debugfs_create_dir(data->client->name, root);
+	if (!data->debugfs_dir)
+		return -ENOENT;
+
+	entry = debugfs_create_devm_seqfile(&data->client->dev,
+					    "blackbox_information",
+					    data->debugfs_dir,
+					    adm1266_blackbox_information_read);
+	if (!entry)
+		return -ENOENT;
+
+	return 0;
+}
+
 static int adm1266_nvmem_read_blackbox(struct adm1266_data *data, u8 *buf)
 {
 	u8 read_buf[5];
@@ -571,7 +617,15 @@ static int adm1266_probe(struct i2c_client *client,
 	for (i = 0; i < info->pages; i++)
 		info->func[i] = funcs;
 
-	return pmbus_do_probe(client, id, info);
+	ret = pmbus_do_probe(client, id, info);
+	if (ret)
+		return ret;
+
+	ret = adm1266_init_debugfs(data);
+	if (ret)
+		dev_warn(&client->dev, "Failed to register debugfs: %d\n", ret);
+
+	return 0;
 }
 
 static const struct of_device_id adm1266_of_match[] = {
-- 
2.20.1

