Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 211BB2DFE14
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 17:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbgLUQcA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 11:32:00 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:48952 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725780AbgLUQb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 11:31:58 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0BLGQLW5142260;
        Mon, 21 Dec 2020 11:31:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=uNU5i80H9uJb9/zaYggjiz1xp2kSwmeANyTXODqHyHg=;
 b=qF5qOsYySRn5L1VZC/67jZbjlTAZsjxADpyKOOQZSGaa6ZtylcRdRQGDBK3gelBEjV7F
 lnbUtmYO7OipjOH3nPR7yoERd+0Z914r3T8Ug9vCoYHId77NU1gkay/LYwn3is9S5GXy
 vSN4MsMhMyIdtBAkWRA3zrLRhzVbC8hdVRhw8PoprlCL/z+6hLLdGjDnLHIBzCOXBJ1T
 8MnlbXR7LDG7fMecLGMRsVaQcB5X3NMQpNKNh9ycH562cbGE/F0S7a5uKijPpkUwbNU4
 yLONdSYp1ZH2PV9tkYi1efuRcp0wbUNCdQX8rNBOGamHqQ/9jXUE9zCV16pyUWf/QgXc zA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35jy7j02xx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Dec 2020 11:31:02 -0500
Received: from m0098404.ppops.net (m0098404.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0BLGQqsA145394;
        Mon, 21 Dec 2020 11:31:02 -0500
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0a-001b2d01.pphosted.com with ESMTP id 35jy7j02xm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Dec 2020 11:31:02 -0500
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0BLGLWxf014019;
        Mon, 21 Dec 2020 16:31:01 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma04dal.us.ibm.com with ESMTP id 35h9594q2t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Dec 2020 16:31:01 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0BLGV0X013632222
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Dec 2020 16:31:00 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 18B9D78060;
        Mon, 21 Dec 2020 16:31:00 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C3A307805E;
        Mon, 21 Dec 2020 16:30:59 +0000 (GMT)
Received: from v0005c16.aus.stglabs.ibm.com (unknown [9.211.87.162])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 21 Dec 2020 16:30:59 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jdelvare@suse.com,
        linux@roeck-us.net, eajames@linux.ibm.com, bjwyman@gmail.com
Subject: [PATCH 1/2] hwmon: (pmbus) Add a NO_PEC flag to probe chips with faulty CAPABILITY
Date:   Mon, 21 Dec 2020 10:30:57 -0600
Message-Id: <20201221163058.33257-2-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201221163058.33257-1-eajames@linux.ibm.com>
References: <20201221163058.33257-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-21_09:2020-12-21,2020-12-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 malwarescore=0 phishscore=0 mlxscore=0 clxscore=1015 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012210114
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some PMBus chips don't respond with valid data when reading the
CAPABILITY register. For instance the register may report that the
chip supports PEC when in reality it does not. For such chips, PEC
must not be enabled while probing the chip, so add a flag so that
device drivers can force PEC off.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/hwmon/pmbus/pmbus_core.c |  8 +++++---
 include/linux/pmbus.h            | 10 ++++++++++
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/pmbus/pmbus_core.c b/drivers/hwmon/pmbus/pmbus_core.c
index 192442b3b7a2..3de1657dde35 100644
--- a/drivers/hwmon/pmbus/pmbus_core.c
+++ b/drivers/hwmon/pmbus/pmbus_core.c
@@ -2204,9 +2204,11 @@ static int pmbus_init_common(struct i2c_client *client, struct pmbus_data *data,
 	}
 
 	/* Enable PEC if the controller supports it */
-	ret = i2c_smbus_read_byte_data(client, PMBUS_CAPABILITY);
-	if (ret >= 0 && (ret & PB_CAPABILITY_ERROR_CHECK))
-		client->flags |= I2C_CLIENT_PEC;
+	if (!(data->flags & PMBUS_NO_PEC)) {
+		ret = i2c_smbus_read_byte_data(client, PMBUS_CAPABILITY);
+		if (ret >= 0 && (ret & PB_CAPABILITY_ERROR_CHECK))
+			client->flags |= I2C_CLIENT_PEC;
+	}
 
 	/*
 	 * Check if the chip is write protected. If it is, we can not clear
diff --git a/include/linux/pmbus.h b/include/linux/pmbus.h
index 1ea5bae708a1..9bdc8a581b03 100644
--- a/include/linux/pmbus.h
+++ b/include/linux/pmbus.h
@@ -34,6 +34,16 @@
  */
 #define PMBUS_WRITE_PROTECTED	BIT(1)
 
+/*
+ * PMBUS_NO_PEC
+ *
+ * Some PMBus chips don't respond with valid data when reading the CAPABILITY
+ * register. In this case, the register may report that the chip supports PEC
+ * with bit 7 (PB_CAPABILITY_ERROR_CHECK) when in reality it's not supported.
+ * For such chips, PEC must not be enabled before probing the chip.
+ */
+#define PMBUS_NO_PEC			BIT(2)
+
 struct pmbus_platform_data {
 	u32 flags;		/* Device specific flags */
 
-- 
2.27.0

