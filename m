Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 943FD2C7E26
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 07:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727258AbgK3GVK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 01:21:10 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:56892 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725965AbgK3GVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 01:21:09 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0AU68bUK014443;
        Sun, 29 Nov 2020 22:20:11 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=6HLJSNbqupKDA6NkIIamnWz2e6tRBqh6fhldFQb6nC8=;
 b=DwCaWpGPjnTqi0xheNv9eDcrBKdA65fAPckXHfOaaiLF2yGxkvwMC5iPPgXne4ufVNF2
 FxDALQI4L3piNU2EpflkLk4zLMxINWvpJxPIyjZfbaokUSf+ammNX24WI+di0AwxGT3M
 vpzMh0C/ZZGFh+Jk907GBSGB74RAB36wGYmBQmXQZZl3tYKceJzd9Kb3pBqpm6Wm5kHw
 HmTYR/k3RMczMwrsAslsEfg/yvJP59YEbk5n6R51iMKKb85ObcTBM4v0T7wr7kiTkdqd
 nnRzrvUxrvQfzGpaVSFJSICrdvnsIIIrM3Gx3G+jnuAnqWUxjuI9r/9WWb4tH8AjYzDM 7w== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by mx0a-0014ca01.pphosted.com with ESMTP id 353m02v211-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 29 Nov 2020 22:20:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D8Gmb9W7sRYS0O2oJ4a0hqWxIkr1bgezliuF3DT97SXyrkXZoHH3E8oqHP68WuA3zCkrHNRUAJcNylehKTz8cVzEZ+o9Z0lVZ3cfZx1T5DHFMU0DigFdCU5Dqsu+L3+Vb/GTVl3kSGCg5FKL0PwGPGB1o0ThYUarJaKFEQP+ZZ9pH5yvHM3sgOVSkW8ykR9S6SssRTdFvb7aH9pYUtILEHkNIPTzU+ZZOXpYKnnWiYy9UGi8SA2A5PDmyNkpG6lz9fxSK3Nbd/miZ/zLqRamidWl/3/SHB3yo6/H3gtU6PHrKMprWxbw2wtDjUOme/ibxN4xah5EBW+s01j/bHZL6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6HLJSNbqupKDA6NkIIamnWz2e6tRBqh6fhldFQb6nC8=;
 b=NoS1MdoBfX2uX8g5E8hzqgSu5A3auRGH8tT6AlS3lLS7c3vnlfxZpJErFt99AoMIRtbViLPeP4i0vpTy2XalOPizwSOGikrx6RkOo9qQZEHZKCSFJrWrZka2hGcW5RNLJmwvD4/c99G4c6/RnTH97CZMDVXpWudsGbxEJCgLLY4vRE00V/yqRZTHBTkRKlOHHnI8jGc0CocZtLtNrP2raJ2yozas+wOGXEzup4pkF6xCD/QLmTQmRgdFrsW7QHhO3p8XNT3/UK8PvIIXARAO55IyRezRkyobU4cTA+WllM1L20ZBWXh3aIctGW/TOPhxqYb+zNodNDFIaMOUBVHSqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=synopsys.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6HLJSNbqupKDA6NkIIamnWz2e6tRBqh6fhldFQb6nC8=;
 b=jV7SY4MtN2qgnVxJAlPgYU6mf4+rGjePeL6FtyeqLpDvWm1ykmAESZw1P07V4hrK+CardTavbTrWn+NNNX85xxyXXKgolbDbU6+/lKCD5I+ODGSzlARhTBYzEW/fY2YEREU3+f+RZjWU3R0z8/l22VF6tIMhzAr0+fmqXJlQKnI=
Received: from CO2PR04CA0135.namprd04.prod.outlook.com (2603:10b6:104::13) by
 DM6PR07MB4330.namprd07.prod.outlook.com (2603:10b6:5:be::32) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.25; Mon, 30 Nov 2020 06:20:08 +0000
Received: from MW2NAM12FT056.eop-nam12.prod.protection.outlook.com
 (2603:10b6:104:0:cafe::d1) by CO2PR04CA0135.outlook.office365.com
 (2603:10b6:104::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.22 via Frontend
 Transport; Mon, 30 Nov 2020 06:20:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; synopsys.com; dkim=none (message not signed)
 header.d=none;synopsys.com; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 MW2NAM12FT056.mail.protection.outlook.com (10.13.181.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.11 via Frontend Transport; Mon, 30 Nov 2020 06:20:07 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 0AU6K5Q7006704
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Sun, 29 Nov 2020 22:20:06 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 30 Nov 2020 07:20:04 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 30 Nov 2020 07:20:04 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 0AU6K4Zt004243;
        Mon, 30 Nov 2020 07:20:04 +0100
Received: (from pthombar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 0AU6K4TE004242;
        Mon, 30 Nov 2020 07:20:04 +0100
From:   Parshuram Thombare <pthombar@cadence.com>
To:     <alexandre.belloni@bootlin.com>, <slongerbeam@gmail.com>,
        <vitor.soares@synopsys.com>
CC:     <linux-i3c@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <mparab@cadence.com>, <praneeth@ti.com>,
        Parshuram Thombare <pthombar@cadence.com>
Subject: [PATCH v10 6/7] i3c: master: sysfs key for acquire bus
Date:   Mon, 30 Nov 2020 07:20:02 +0100
Message-ID: <1606717202-4206-1-git-send-email-pthombar@cadence.com>
X-Mailer: git-send-email 2.2.2
In-Reply-To: <1606716983-3645-1-git-send-email-pthombar@cadence.com>
References: <1606716983-3645-1-git-send-email-pthombar@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 86f731b8-6595-4db2-d39c-08d894f7fbee
X-MS-TrafficTypeDiagnostic: DM6PR07MB4330:
X-Microsoft-Antispam-PRVS: <DM6PR07MB4330DA03706C1C13D8AA680BC1F50@DM6PR07MB4330.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:510;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: r03Rn3t/hhqEvbcQahm2lIsPu4VtcGXZpUdtdc0BOa6vRqbRGoLYOQGITUADAjEE7TQTi2BQetPLd9Tj+CgPK4Tnsl6IM2nehZre9UuLlSY+Hl7siCRAspszU6DXn3Kq3LCbdAcKkNp/AGclp3iPKaJcdYaW+kaeoEa0pjuVjlAyYNXvee8o4feZmS3RG9K/NZolh+dbzMBAqGPKIItsQ9BzEUD5jqWudCM1CEHAu/m96X5h8QyS6kHUDWIXgb5VwvdI/5uoS4Vq3yE62rRJfNkXxtPpSmv8PAPHmcARIj2ghuy46i2V6jHJZTOZjr4HJ8h4yNUHgfpG5wZTMxJT2IxOtxa1A/UhbA9K3KkPhVdoVnzqu9bG+4k34+UJoXVeSj/5O+xEO2msvN3PzxroJSysO+hW186rQ5G6yjYUKHc=
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(39860400002)(376002)(346002)(396003)(136003)(36092001)(46966005)(336012)(82310400003)(426003)(356005)(186003)(70206006)(70586007)(82740400003)(7636003)(47076004)(83380400001)(478600001)(5660300002)(8676002)(8936002)(86362001)(26005)(2906002)(54906003)(42186006)(110136005)(36906005)(316002)(4326008)(107886003)(2616005)(36756003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2020 06:20:07.6941
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86f731b8-6595-4db2-d39c-08d894f7fbee
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT056.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB4330
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-30_01:2020-11-26,2020-11-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 adultscore=0 spamscore=0 suspectscore=0 mlxlogscore=944
 lowpriorityscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011300041
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added support to acquire I3C bus through sysfs interface.

Signed-off-by: Parshuram Thombare <pthombar@cadence.com>
---
 drivers/i3c/master.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+), 0 deletions(-)

diff --git a/drivers/i3c/master.c b/drivers/i3c/master.c
index c01ba00..beb7495 100644
--- a/drivers/i3c/master.c
+++ b/drivers/i3c/master.c
@@ -581,6 +581,23 @@ static ssize_t i2c_scl_frequency_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(i2c_scl_frequency);
 
+static ssize_t i3c_acquire_bus_store(struct device *dev,
+				     struct device_attribute *attr,
+				     const char *buf, size_t count)
+{
+	struct i3c_master_controller *master = dev_to_i3cmaster(dev);
+	int ret;
+
+	i3c_bus_normaluse_lock(&master->bus);
+	ret = i3c_master_acquire_bus(master);
+	i3c_bus_normaluse_unlock(&master->bus);
+	if (!ret)
+		i3c_master_enable_mr_events(master);
+
+	return ret ?: count;
+}
+static DEVICE_ATTR_WO(i3c_acquire_bus);
+
 static struct attribute *i3c_masterdev_attrs[] = {
 	&dev_attr_mode.attr,
 	&dev_attr_current_master.attr,
@@ -591,6 +608,7 @@ static ssize_t i2c_scl_frequency_show(struct device *dev,
 	&dev_attr_pid.attr,
 	&dev_attr_dynamic_address.attr,
 	&dev_attr_hdrcap.attr,
+	&dev_attr_i3c_acquire_bus.attr,
 	NULL,
 };
 ATTRIBUTE_GROUPS(i3c_masterdev);
-- 
1.7.1

