Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1CC52E0CB7
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Dec 2020 16:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbgLVP1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Dec 2020 10:27:39 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:15490 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727019AbgLVP1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Dec 2020 10:27:38 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0BMF2B6Q191006;
        Tue, 22 Dec 2020 10:26:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=GSUOkVavLqmMr4kIEXjy9VN3CQpH+tPgx6drE9F5Gz0=;
 b=QesyxSOFRZT0cZmU4qznjrqsRpu4n1/2RkKDpw64ggACZ9WpWvpA7hnTHMl4XZSpQIYw
 eQN25TVkYGx1blFUupG9xOU8Z8BUN4VpmcU1YG3kOOEVOK9cXmx3XNghT8HcHO1jxYyX
 xOB4Uztcd2zPL5SG4vHIsBADnEoutw5XVCAQCv4hOxF/w289VaeoqKBKGW3V3VOJNUVP
 Dgm4+NnOmoXv5M9LSEASHlFDJimABSihylkuySR3UbKS8OrXdj4IZqU8QSHe0wGfbY0d
 kt91bnX8ClfMo8qPtsdIJ0wi77XHJvKFB6WJF8w0CGnwUEFfb49aWw5369UFZBGNhTMN Yg== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 35kjc2sy85-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Dec 2020 10:26:43 -0500
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0BMFQC6Z096081;
        Tue, 22 Dec 2020 10:26:42 -0500
Received: from ppma03dal.us.ibm.com (b.bd.3ea9.ip4.static.sl-reverse.com [169.62.189.11])
        by mx0b-001b2d01.pphosted.com with ESMTP id 35kjc2sy7v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Dec 2020 10:26:42 -0500
Received: from pps.filterd (ppma03dal.us.ibm.com [127.0.0.1])
        by ppma03dal.us.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0BMFHAm0018453;
        Tue, 22 Dec 2020 15:26:42 GMT
Received: from b03cxnp08028.gho.boulder.ibm.com (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
        by ppma03dal.us.ibm.com with ESMTP id 35k02erdpx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Dec 2020 15:26:42 +0000
Received: from b03ledav005.gho.boulder.ibm.com (b03ledav005.gho.boulder.ibm.com [9.17.130.236])
        by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0BMFQeHA20840888
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Dec 2020 15:26:40 GMT
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C6100BE053;
        Tue, 22 Dec 2020 15:26:40 +0000 (GMT)
Received: from b03ledav005.gho.boulder.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6D9DBBE04F;
        Tue, 22 Dec 2020 15:26:40 +0000 (GMT)
Received: from v0005c16.aus.stglabs.ibm.com (unknown [9.211.57.15])
        by b03ledav005.gho.boulder.ibm.com (Postfix) with ESMTP;
        Tue, 22 Dec 2020 15:26:40 +0000 (GMT)
From:   Eddie James <eajames@linux.ibm.com>
To:     linux-hwmon@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jdelvare@suse.com,
        linux@roeck-us.net, eajames@linux.ibm.com, bjwyman@gmail.com
Subject: [PATCH v2 0/2] hwmon: (pmbus) Add the PMBUS_NO_CAPABILITY flag
Date:   Tue, 22 Dec 2020 09:26:38 -0600
Message-Id: <20201222152640.27749-1-eajames@linux.ibm.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-22_07:2020-12-21,2020-12-22 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 mlxlogscore=843 impostorscore=0
 mlxscore=0 spamscore=0 bulkscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012220107
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some PMBus chips, like some power supplies supported by the cffps driver,
don't respond with valid data when reading the CAPABILITY register. Add a
platform data flag that device drivers can set to tell the PMBus core
driver that it shouldn't use the CAPABILITY register. The second patch
sets this flag for the cffps driver.

Changes since v1:
 - Rename the flag to PMBUS_NO_CAPABILITY and adjust the associated
   comment accordingly.

Eddie James (2):
  hwmon: (pmbus) Add a PMBUS_NO_CAPABILITY platform data flag
  hwmon: (pmbus/ibm-cffps) Set the PMBUS_NO_CAPABILITY flag

 drivers/hwmon/pmbus/ibm-cffps.c  | 2 +-
 drivers/hwmon/pmbus/pmbus_core.c | 8 +++++---
 include/linux/pmbus.h            | 9 +++++++++
 3 files changed, 15 insertions(+), 4 deletions(-)

-- 
2.27.0

