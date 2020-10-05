Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D16DA28352E
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Oct 2020 13:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbgJELvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Oct 2020 07:51:11 -0400
Received: from mx0a-00128a01.pphosted.com ([148.163.135.77]:46214 "EHLO
        mx0a-00128a01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725914AbgJELvL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Oct 2020 07:51:11 -0400
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
        by mx0a-00128a01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 095Bo2fS004073;
        Mon, 5 Oct 2020 07:50:51 -0400
Received: from nwd2mta4.analog.com ([137.71.173.58])
        by mx0a-00128a01.pphosted.com with ESMTP id 33xk56c667-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 05 Oct 2020 07:50:51 -0400
Received: from SCSQMBX10.ad.analog.com (scsqmbx10.ad.analog.com [10.77.17.5])
        by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 095BonVN020574
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Mon, 5 Oct 2020 07:50:50 -0400
Received: from SCSQMBX11.ad.analog.com (10.77.17.10) by
 SCSQMBX10.ad.analog.com (10.77.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 5 Oct 2020 04:50:35 -0700
Received: from zeus.spd.analog.com (10.66.68.11) by SCSQMBX11.ad.analog.com
 (10.77.17.10) with Microsoft SMTP Server id 15.1.1779.2 via Frontend
 Transport; Mon, 5 Oct 2020 04:50:35 -0700
Received: from saturn.ad.analog.com ([10.48.65.110])
        by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 095BojTk004220;
        Mon, 5 Oct 2020 07:50:45 -0400
From:   Alexandru Ardelean <alexandru.ardelean@analog.com>
To:     <linux-hwmon@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <linux@roeck-us.net>, <jdelvare@suse.com>, <foremans@google.com>,
        Alexandru Ardelean <alexandru.ardelean@analog.com>
Subject: [PATCH] hwmon: (pmbus/max34440) Fix/add missing break statements
Date:   Mon, 5 Oct 2020 14:50:41 +0300
Message-ID: <20201005115041.1750626-1-alexandru.ardelean@analog.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-ADIRoutedOnPrem: True
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-05_06:2020-10-02,2020-10-05 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 clxscore=1011 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 impostorscore=0 mlxlogscore=999 spamscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010050090
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This one was caught by the compiler.
Adds missing break statements, which look omitted by accident.

Fixes: 599a5ac5f96c ("hwmon: (pmbus/max34440) Fix/add missing break statements")
Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
---

Maybe the lkp bot also reported this [by now].
I just bumped into this now, trying to work on another driver.
Now whether this gets applied, or a V2 is created, is not important from my
side.

This is a heads-up [from my side].

 drivers/hwmon/pmbus/max34440.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hwmon/pmbus/max34440.c b/drivers/hwmon/pmbus/max34440.c
index bdea52996580..f4cb196aaaf3 100644
--- a/drivers/hwmon/pmbus/max34440.c
+++ b/drivers/hwmon/pmbus/max34440.c
@@ -61,9 +61,11 @@ static int max34440_read_word_data(struct i2c_client *client, int page,
 	case PMBUS_IOUT_OC_FAULT_LIMIT:
 		ret = pmbus_read_word_data(client, page, phase,
 					   MAX34440_IOUT_OC_FAULT_LIMIT);
+		break;
 	case PMBUS_IOUT_OC_WARN_LIMIT:
 		ret = pmbus_read_word_data(client, page, phase,
 					   MAX34440_IOUT_OC_WARN_LIMIT);
+		break;
 	case PMBUS_VIRT_READ_VOUT_MIN:
 		ret = pmbus_read_word_data(client, page, phase,
 					   MAX34440_MFR_VOUT_MIN);
@@ -133,9 +135,11 @@ static int max34440_write_word_data(struct i2c_client *client, int page,
 	case PMBUS_IOUT_OC_FAULT_LIMIT:
 		ret = pmbus_write_word_data(client, page, MAX34440_IOUT_OC_FAULT_LIMIT,
 					    word);
+		break;
 	case PMBUS_IOUT_OC_WARN_LIMIT:
 		ret = pmbus_write_word_data(client, page, MAX34440_IOUT_OC_WARN_LIMIT,
 					    word);
+		break;
 	case PMBUS_VIRT_RESET_POUT_HISTORY:
 		ret = pmbus_write_word_data(client, page,
 					    MAX34446_MFR_POUT_PEAK, 0);
-- 
2.25.1

