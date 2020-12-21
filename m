Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 840912DFE10
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Dec 2020 17:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725865AbgLUQb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Dec 2020 11:31:59 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:9042 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725777AbgLUQb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Dec 2020 11:31:58 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0BLG4agd088398;
        Mon, 21 Dec 2020 11:31:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=NX0g1SGFomsCYppTcceBifT8HmdE0xlo7Roihq1sSwE=;
 b=EgO8hV1gV/Qz6VBrMyt8w5TbJ3whlHvORxRYf4mBtI2CRPQWINmwBYHbUQLIAnsCme13
 C3o/3nPRhvAeyrCM/nb6y+kuzSiCcGPYj+j8fUR8BW39YlnYxlNkTAHDqxaE5Rt6UV2i
 TVF+DIOsxaBzAdYaA2mqhkMHl/t0sMKckox5TizOov1cL+x9Wzm4+E3SZ9SjXjUv/9QZ
 GqpcjqPw1KRXBjPe5Kseq6YzsJRxz3PcvAAe2vDwo8Ib0eJbQUHpWMtAFT2vXy7QUl+d
 MYx97aH8nmdQAsIS5U7VPETFo+VFF6sWDcBUy/vjd/qaz/TMuOXuQqvS68Yo5i/XZ19j hQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 35jxkxscnm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Dec 2020 11:31:02 -0500
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0BLG4XCx088311;
        Mon, 21 Dec 2020 11:31:02 -0500
Received: from ppma01dal.us.ibm.com (83.d6.3fa9.ip4.static.sl-reverse.com [169.63.214.131])
        by mx0b-001b2d01.pphosted.com with ESMTP id 35jxkxscnc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Dec 2020 11:31:02 -0500
Received: from pps.filterd (ppma01dal.us.ibm.com [127.0.0.1])
        by ppma01dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0BLGMf6q005011;
        Mon, 21 Dec 2020 16:31:01 GMT
Received: from b03cxnp08027.gho.boulder.ibm.com (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
        by ppma01dal.us.ibm.com with ESMTP id 35h9594pxb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 21 Dec 2020 16:31:01 +0000
Received: from b03ledav004.gho.boulder.ibm.com (b03ledav004.gho.boulder.ibm.com [9.17.130.235])
        by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0BLGV0eT11076290
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Dec 2020 16:31:00 GMT
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 84D9F78064;
        Mon, 21 Dec 2020 16:31:00 +0000 (GMT)
Received: from b03ledav004.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2AFF67805E;
        Mon, 21 Dec 2020 16:31:00 +0000 (GMT)
Received: from v0005c16.aus.stglabs.ibm.com (unknown [9.211.87.162])
        by b03ledav004.gho.boulder.ibm.com (Postfix) with ESMTP;
        Mon, 21 Dec 2020 16:31:00 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jdelvare@suse.com,
        linux@roeck-us.net, eajames@linux.ibm.com, bjwyman@gmail.com
Subject: [PATCH 2/2] hwmon: (pmbus/ibm-cffps) Set the PMBUS_NO_PEC flag
Date:   Mon, 21 Dec 2020 10:30:58 -0600
Message-Id: <20201221163058.33257-3-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201221163058.33257-1-eajames@linux.ibm.com>
References: <20201221163058.33257-1-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-21_09:2020-12-21,2020-12-21 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 clxscore=1015 suspectscore=0 phishscore=0 impostorscore=0 malwarescore=0
 priorityscore=1501 mlxscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012210111
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several power supplies supported by the IBM CFFPS driver don't
report valid data in the CAPABILITY register, or support PEC only
for certain PMBus registers. Since the automatic version detection
of the driver might fail on some supplies with PEC enabled, just
disable PEC entirely for this driver.

Signed-off-by: Eddie James <eajames@linux.ibm.com>
---
 drivers/hwmon/pmbus/ibm-cffps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/pmbus/ibm-cffps.c b/drivers/hwmon/pmbus/ibm-cffps.c
index d6bbbb223871..f8e3ae989e99 100644
--- a/drivers/hwmon/pmbus/ibm-cffps.c
+++ b/drivers/hwmon/pmbus/ibm-cffps.c
@@ -472,7 +472,7 @@ static struct pmbus_driver_info ibm_cffps_info[] = {
 };
 
 static struct pmbus_platform_data ibm_cffps_pdata = {
-	.flags = PMBUS_SKIP_STATUS_CHECK,
+	.flags = PMBUS_SKIP_STATUS_CHECK | PMBUS_NO_PEC,
 };
 
 static int ibm_cffps_probe(struct i2c_client *client)
-- 
2.27.0

