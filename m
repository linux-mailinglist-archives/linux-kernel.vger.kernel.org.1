Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 676F32E0CBB
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 16:28:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbgLVP1o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 10:27:44 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:22250 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727876AbgLVP1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 10:27:40 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0BMF2Aj4190946;
        Tue, 22 Dec 2020 10:26:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=ZjlMWBoKWuRCcbaJVdHCjGg+tOmpGuqezCrn14nJmP4=;
 b=ipErLFMq49k0uBP7HsFy2TJoBIy/fPE0nrBgHfuNm11NejURAdAtaoOMlUZgokOx1Val
 spCI2xitpOue/H/GC1caRBKbjqJzPjBha8RzwdrlnVfTmkyIYODjLqD4city/NU+p1oH
 mkx2befVE7r7If8yIJX/85o73of6EYnbaMpETXlvPqCoKo/qrMtRb2lukD6piMN6rETL
 WPFEOws5hj123nOybPghTHWpwgOmtnHmfs+qBfjhlqt8DwJyxI92i+wvq6myl9z70RNm
 8GWmcE+6MQpI2tqucbPEW7sBI6XEZwZNRyMBsGcifxnnSQVqoyovlJzezUVadW+FParJ +w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 35kjc2sy8b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Dec 2020 10:26:43 -0500
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0BMF2ViN192275;
        Tue, 22 Dec 2020 10:26:43 -0500
Received: from ppma02dal.us.ibm.com (a.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.10])
        by mx0b-001b2d01.pphosted.com with ESMTP id 35kjc2sy83-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Dec 2020 10:26:43 -0500
Received: from pps.filterd (ppma02dal.us.ibm.com [127.0.0.1])
        by ppma02dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0BMFHAj0009277;
        Tue, 22 Dec 2020 15:26:42 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma02dal.us.ibm.com with ESMTP id 35kj7qrj4p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Dec 2020 15:26:42 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0BMFQft325821488
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Dec 2020 15:26:41 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 41DC1BE051;
        Tue, 22 Dec 2020 15:26:41 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E1BA7BE04F;
        Tue, 22 Dec 2020 15:26:40 +0000 (GMT)
Received: from v0005c16.aus.stglabs.ibm.com (unknown [9.211.57.15])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 22 Dec 2020 15:26:40 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jdelvare@suse.com,
        linux@roeck-us.net, eajames@linux.ibm.com, bjwyman@gmail.com
Subject: [PATCH v2 1/2] hwmon: (pmbus) Add a PMBUS_NO_CAPABILITY platform data flag
Date:   Tue, 22 Dec 2020 09:26:39 -0600
Message-Id: <20201222152640.27749-2-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201222152640.27749-1-eajames@linux.ibm.com>
References: <20201222152640.27749-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-22_07:2020-12-21,2020-12-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=999 impostorscore=0
 mlxscore=0 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012220107
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some PMBus chips don't respond with valid data when reading the
CAPABILITY register. Add a flag that device drivers can set so
that the PMBus core driver doesn't use CAPABILITY to determine it's
behavior.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/hwmon/pmbus/pmbus_core.c | 8 +++++---
 include/linux/pmbus.h            | 9 +++++++++
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 192442b3b7a2..906c9fec9cce 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -2204,9 +2204,11 @@ static int pmbus_init_common(struct i2c_client *client, struct pmbus_data *data,
 	}
 
 	/* Enable PEC if the controller supports it */
-	ret = i2c_smbus_read_byte_data(client, PMBUS_CAPABILITY);
-	if (ret >= 0 && (ret & PB_CAPABILITY_ERROR_CHECK))
-		client->flags |= I2C_CLIENT_PEC;
+	if (!(data->flags & PMBUS_NO_CAPABILITY)) {
+		ret = i2c_smbus_read_byte_data(client, PMBUS_CAPABILITY);
+		if (ret >= 0 && (ret & PB_CAPABILITY_ERROR_CHECK))
+			client->flags |= I2C_CLIENT_PEC;
+	}
 
 	/*
 	 * Check if the chip is write protected. If it is, we can not clear
diff --git a/include/linux/pmbus.h b/include/linux/pmbus.h
index 1ea5bae708a1..12cbbf305969 100644
--- a/include/linux/pmbus.h
+++ b/include/linux/pmbus.h
@@ -34,6 +34,15 @@
  */
 #define PMBUS_WRITE_PROTECTED	BIT(1)
 
+/*
+ * PMBUS_NO_CAPABILITY
+ *
+ * Some PMBus chips don't respond with valid data when reading the CAPABILITY
+ * register. For such chips, this flag should be set so that the PMBus core
+ * driver doesn't use CAPABILITY to determine it's behavior.
+ */
+#define PMBUS_NO_CAPABILITY			BIT(2)
+
 struct pmbus_platform_data {
 	u32 flags;		/* Device specific flags */
 
-- 
2.27.0

