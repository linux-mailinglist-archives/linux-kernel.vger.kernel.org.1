Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0A4C2059DF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jun 2020 19:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387990AbgFWRo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Jun 2020 13:44:28 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:32784 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733159AbgFWRf1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 13:35:27 -0400
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 05NHNbKa031532;
        Tue, 23 Jun 2020 13:35:10 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 31uk3grq2p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Jun 2020 13:35:10 -0400
Received: from SCSQMBX11.ad.analog.com (scsqmbx11.ad.analog.com [10.77.17.10])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 05NHZ8s8031585
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 23 Jun 2020 13:35:09 -0400
Received: from SCSQCASHYB7.ad.analog.com (10.77.17.133) by
 SCSQMBX11.ad.analog.com (10.77.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 23 Jun 2020 10:35:07 -0700
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQCASHYB7.ad.analog.com (10.77.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 23 Jun 2020 10:35:07 -0700
Received: from zeus.spd.analog.com (10.64.82.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Tue, 23 Jun 2020 10:35:07 -0700
Received: from localhost.localdomain ([10.48.65.12])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 05NHYxMT017521;
        Tue, 23 Jun 2020 13:35:05 -0400
From:   <alexandru.tachici@analog.com>
To:     <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <robh+dt@kernel.org>, <linux@roeck-us.net>,
        Alexandru Tachici <alexandru.tachici@analog.com>
Subject: [PATCH v4 4/7] hwmon: pmbus: adm1266: Add ioctl commands
Date:   Tue, 23 Jun 2020 20:36:56 +0300
Message-ID: <20200623173659.41358-5-alexandru.tachici@analog.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200623173659.41358-1-alexandru.tachici@analog.com>
References: <20200623173659.41358-1-alexandru.tachici@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.216,18.0.687
 definitions=2020-06-23_11:2020-06-23,2020-06-23 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 bulkscore=0 spamscore=0 mlxscore=0 phishscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006120000 definitions=main-2006230123
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandru Tachici <alexandru.tachici@analog.com>

Add two ioctl commands for reading the current state
of the adm1266 sequencer and sending commands.

Signed-off-by: Alexandru Tachici <alexandru.tachici@analog.com>
---
 Documentation/hwmon/adm1266.rst               | 15 +++
 .../userspace-api/ioctl/ioctl-number.rst      |  1 +
 drivers/hwmon/pmbus/adm1266.c                 | 97 +++++++++++++++++++
 include/uapi/linux/adm1266.h                  | 16 +++
 4 files changed, 129 insertions(+)
 create mode 100644 include/uapi/linux/adm1266.h

diff --git a/Documentation/hwmon/adm1266.rst b/Documentation/hwmon/adm1266.rst
index 65662115750c..5dc05808db60 100644
--- a/Documentation/hwmon/adm1266.rst
+++ b/Documentation/hwmon/adm1266.rst
@@ -33,3 +33,18 @@ inX_min			Minimum Voltage.
 inX_max			Maximum voltage.
 inX_min_alarm		Voltage low alarm.
 inX_max_alarm		Voltage high alarm.
+
+
+User API
+========
+
+ioctls
+------
+
+ADM1266_SET_GO_COMMAND:
+
+  Issue a GO_COMMAND to the device.
+
+ADM1266_GET_STATUS:
+
+  Returns state of the sequencer.
diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst b/Documentation/userspace-api/ioctl/ioctl-number.rst
index f759edafd938..db4d912e3d86 100644
--- a/Documentation/userspace-api/ioctl/ioctl-number.rst
+++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
@@ -345,6 +345,7 @@ Code  Seq#    Include File                                           Comments
 0xCC  00-0F  drivers/misc/ibmvmc.h                                   pseries VMC driver
 0xCD  01     linux/reiserfs_fs.h
 0xCF  02     fs/cifs/ioctl.c
+0xD1  00-0F  linux/adm1266.h
 0xDB  00-0F  drivers/char/mwave/mwavepub.h
 0xDD  00-3F                                                          ZFCP device driver see drivers/s390/scsi/
                                                                      <mailto:aherrman@de.ibm.com>
diff --git a/drivers/hwmon/pmbus/adm1266.c b/drivers/hwmon/pmbus/adm1266.c
index 76bf2c78e737..0960ead8d96a 100644
--- a/drivers/hwmon/pmbus/adm1266.c
+++ b/drivers/hwmon/pmbus/adm1266.c
@@ -15,11 +15,16 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
+#include <linux/proc_fs.h>
 #include <linux/slab.h>
+#include <linux/uaccess.h>
 
+#include <linux/adm1266.h>
 #include "pmbus.h"
 
 #define ADM1266_PDIO_CONFIG	0xD4
+#define ADM1266_GO_COMMAND	0xD8
+#define ADM1266_READ_STATE	0xD9
 #define ADM1266_GPIO_CONFIG	0xE1
 #define ADM1266_PDIO_STATUS	0xE9
 #define ADM1266_GPIO_STATUS	0xEA
@@ -46,6 +51,7 @@ struct adm1266_data {
 	struct gpio_chip gc;
 	const char *gpio_names[ADM1266_GPIO_NR + ADM1266_PDIO_NR];
 	struct i2c_client *client;
+	struct mutex ioctl_mutex; /* lock ioctl access */
 };
 
 /* Different from Block Read as it sends data and waits for the slave to
@@ -311,6 +317,93 @@ static int adm1266_config_gpio(struct adm1266_data *data)
 }
 #endif
 
+static int adm1266_set_go_command_op(struct adm1266_data *data, u8 val)
+{
+	val = FIELD_GET(GENMASK(4, 0), val);
+
+	return i2c_smbus_write_word_data(data->client, ADM1266_GO_COMMAND, val);
+}
+
+static int adm1266_ioctl_unlocked(struct file *fp, unsigned int cmd,
+				  unsigned long arg)
+{
+	int __user *argp = (int __user *)arg;
+	struct adm1266_data *data;
+	int val;
+	int ret;
+
+	data = fp->private_data;
+
+	if (!argp)
+		return -EINVAL;
+
+	switch (cmd) {
+	case ADM1266_SET_GO_COMMAND:
+		if (copy_from_user(&val, argp, sizeof(int)))
+			return -EFAULT;
+
+		return adm1266_set_go_command_op(data, val);
+	case ADM1266_GET_STATUS:
+		ret = i2c_smbus_read_word_data(data->client,
+					       ADM1266_READ_STATE);
+
+		if (ret < 0)
+			return ret;
+
+		if (copy_to_user(argp, &ret, sizeof(int)))
+			return -EFAULT;
+
+		break;
+	default:
+		return -ENOTTY;
+	}
+
+	return 0;
+}
+
+static long adm1266_ioctl(struct file *fp, unsigned int cmd, unsigned long arg)
+{
+	struct adm1266_data *data;
+	long ret;
+
+	data = fp->private_data;
+
+	mutex_lock(&data->ioctl_mutex);
+	ret = adm1266_ioctl_unlocked(fp, cmd, arg);
+	mutex_unlock(&data->ioctl_mutex);
+
+	return ret;
+}
+
+static int adm1266_open(struct inode *inode, struct file *filp)
+{
+	filp->private_data = PDE_DATA(inode);
+
+	return 0;
+}
+
+static const struct proc_ops adm1266_proc_ops = {
+	.proc_open	= adm1266_open,
+	.proc_ioctl	= adm1266_ioctl,
+};
+
+static int adm1266_init_procfs(struct adm1266_data *data)
+{
+	struct proc_dir_entry *proc_dir;
+	u8 proc_fs_name[32];
+
+	mutex_init(&data->ioctl_mutex);
+
+	snprintf(proc_fs_name, 32, "adm1266-%x", data->client->addr);
+	proc_dir = proc_create_data(proc_fs_name, 0, NULL, &adm1266_proc_ops,
+				    data);
+
+	if (!proc_dir)
+		return -EINVAL;
+
+	return 0;
+}
+
 static int adm1266_probe(struct i2c_client *client,
 			 const struct i2c_device_id *id)
 {
@@ -333,6 +426,10 @@ static int adm1266_probe(struct i2c_client *client,
 
 	crc8_populate_msb(pmbus_crc_table, 0x7);
 
+	ret = adm1266_init_procfs(data);
+	if (ret < 0)
+		return ret;
+
 	info = &data->info;
 	info->pages = 17;
 	info->format[PSC_VOLTAGE_OUT] = linear;
diff --git a/include/uapi/linux/adm1266.h b/include/uapi/linux/adm1266.h
new file mode 100644
index 000000000000..0db3c1129293
--- /dev/null
+++ b/include/uapi/linux/adm1266.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * ADM1266 - Cascadable Super Sequencer with Margin
+ * Control and Fault Recording
+ *
+ * Copyright 2020 Analog Devices Inc.
+ */
+
+#ifndef _LINUX_ADM1266_H
+#define _LINUX_ADM1266_H
+
+/* ADM1266 ioctl commands */
+#define ADM1266_SET_GO_COMMAND		_IOW(0xD1, 0x00, int)
+#define ADM1266_GET_STATUS		_IOR(0xD1, 0x01, int)
+
+#endif
-- 
2.20.1

