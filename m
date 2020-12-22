Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18FC12E0CB8
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 16:28:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728066AbgLVP1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 10:27:40 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:30244 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727865AbgLVP1j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 10:27:39 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0BMF29xZ121520;
        Tue, 22 Dec 2020 10:26:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=mpcLLzEwIHPMG/n6dCKlLlMdgebP9ygnlEcCfBIdl1w=;
 b=gNqGFuoXLs4Rk6iYs/2iAe5uU12RclfdAWij5IeEz+mU+20fK31+UzeUwBuuMtXsZrFW
 s3FnZBjODXwe9Rrpc1LHLbwYKSlrevQSO9IycjHMp7qhg47JA6G7gJhTw9+rxJyrKmQi
 qHt2Z9cJ6lvEhMlHeCg65Ut7gts9gktoyZaUQ84QiobpqHNSEgNFQ9eOuIcPlu0aVmWg
 eCsgnVVIAu5N/rJqIXVGJSdROi7CEd0p+mWQ2ZZh5Ze2NjPA/LkO1jaISaMA/hF0eaxW
 2ZC+2/IAqF6faN8qI9a6PLPkQPobRl5DN3Atc+GOz0pg55SSchYcnhIZ9oU78piQXleO YA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 35kj85j7pw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Dec 2020 10:26:44 -0500
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0BMF3eON127544;
        Tue, 22 Dec 2020 10:26:43 -0500
Received: from ppma04dal.us.ibm.com (7a.29.35a9.ip4.static.sl-reverse.com [169.53.41.122])
        by mx0b-001b2d01.pphosted.com with ESMTP id 35kj85j7pk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Dec 2020 10:26:43 -0500
Received: from pps.filterd (ppma04dal.us.ibm.com [127.0.0.1])
        by ppma04dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0BMFHZZv006417;
        Tue, 22 Dec 2020 15:26:43 GMT
Received: from b03cxnp07028.gho.boulder.ibm.com (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
        by ppma04dal.us.ibm.com with ESMTP id 35kk8r82h7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Dec 2020 15:26:43 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0BMFQf3U25821494
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Dec 2020 15:26:41 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A7607BE05A;
        Tue, 22 Dec 2020 15:26:41 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 54B30BE054;
        Tue, 22 Dec 2020 15:26:41 +0000 (GMT)
Received: from v0005c16.aus.stglabs.ibm.com (unknown [9.211.57.15])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 22 Dec 2020 15:26:41 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jdelvare@suse.com,
        linux@roeck-us.net, eajames@linux.ibm.com, bjwyman@gmail.com
Subject: [PATCH v2 2/2] hwmon: (pmbus/ibm-cffps) Set the PMBUS_NO_CAPABILITY flag
Date:   Tue, 22 Dec 2020 09:26:40 -0600
Message-Id: <20201222152640.27749-3-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201222152640.27749-1-eajames@linux.ibm.com>
References: <20201222152640.27749-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-22_07:2020-12-21,2020-12-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 suspectscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 impostorscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012220107
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several power supplies supported by the IBM CFFPS driver don't
report valid data in the CAPABILITY register. This results in PEC
being enabled when it's not supported by the device, and since
the automatic version detection might fail, disable use of the
CAPABILITY register across the board for this driver.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/hwmon/pmbus/ibm-cffps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/ibm-cffps.c b/drivers/hwmon/pmbus/ibm-cffps.c
index d6bbbb223871..ffde5aaa5036 100644
--- a/drivers/hwmon/pmbus/ibm-cffps.c
+++ b/drivers/hwmon/pmbus/ibm-cffps.c
@@ -472,7 +472,7 @@ static struct pmbus_driver_info ibm_cffps_info[] = {
 };
 
 static struct pmbus_platform_data ibm_cffps_pdata = {
-	.flags = PMBUS_SKIP_STATUS_CHECK,
+	.flags = PMBUS_SKIP_STATUS_CHECK | PMBUS_NO_CAPABILITY,
 };
 
 static int ibm_cffps_probe(struct i2c_client *client)
-- 
2.27.0

