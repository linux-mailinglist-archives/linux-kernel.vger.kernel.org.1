Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 376A32C7983
	for <lists+linux-kernel@lfdr.de>; Sun, 29 Nov 2020 15:24:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727058AbgK2OUu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 Nov 2020 09:20:50 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:47980 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725830AbgK2OUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Nov 2020 09:20:49 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0ATEC0Yg032206;
        Sun, 29 Nov 2020 06:19:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=D4WAOcTSVRhiqpgt6+RIqt44afIu9qf6wZsAkL4JI6E=;
 b=pXhYFeff3SlnS6ZwrFCrd3TIzFWDSOdy4rAzPX0JNW7oFjh/av7oGvMbnu5HdhtvSsM+
 F9HN31LeSrqOE0E1vnJ6hA0/1ABQfVJw/zswoiVlm0Lq8UI9a/XT7kFMjmxGuPaZ9nMM
 A3Z8CMvQYdXVMn7w0H73bApV4gmti0ld5VasmfTkhMyOoH1volq0lfGpeZAkYDCcFBfo
 sS0bERSKRjY7EcAClCr1WbrBmZPHYOhZlne+sIPxzF8YN4uJNEXIGovE8gjVGDSPiVkT
 9QOJEk/MmYue1ryk5/jHyBwOYizrMXbrergjHN2v8SGq6N8xq/u+CKKv/9C/lfLZeBZJ sA== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2105.outbound.protection.outlook.com [104.47.58.105])
        by mx0a-0014ca01.pphosted.com with ESMTP id 353m02tf1d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 29 Nov 2020 06:19:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TRWUH1Na2fVDtAp0schzmdyXGwJ4I3Rm+/mcGMLlU6J4RMF6fuUOf27XQEjsk/0gLJhqr7kkSsPcqYDd49ZXo/VYym+I8WOAdMLMWYEkyLUxqaCm7p6wRPOWoPN1KTKXu3Q9/suhdkPrGr+FIiXiwfosopl64n6lkCHd07P2/BgcCqRHn3o5L8SNmEf9K6nM9TrUDcFTYrkg1p9K8qj0HfC3dTrUbTkhCS1afSKIK2Oc31EcqOEMIGTbZLL1ecLlABx11tEq9daSKzHbF5N2mflK+1cWcgV6F4t/8kLNdZfb2Dwfhc2zztEeH390pm3LOoS9+iiqnhLsn7MhQMJEgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4WAOcTSVRhiqpgt6+RIqt44afIu9qf6wZsAkL4JI6E=;
 b=jgJSK4UjiygcM3B5el3qw5bEecWrbMBCDy078qgHXUcF7/zhwN73bhqyLCE1697K99AJiQ6KdHAeXN2IesJ9r5CUYmxwIne92zZLILrP5ZkqsKdB5sGMMWQ49Cuw55nBVuU5NjqiN2ndf1TyDWn5OrKsMoRaiX38v2lHkafDHrvi1go73kO/g0pB5cCtisWgcDA/vYtIiE73aHMNkLWEEfQ/Lhxa0cc//sKgTdMe7+SqHCzaQ1T6O8g6s4ZTNZCuXvOA7I24j7msYrH2uVk7iR01+Ka1LuWEZ2pYXGPVZ1fbDjAUBHnVixR/0pgFsgBK35bcsU86ih6/LlpmF56kTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=synopsys.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4WAOcTSVRhiqpgt6+RIqt44afIu9qf6wZsAkL4JI6E=;
 b=Y+oihuY6nDAfXcJEwMtr7I9Gf90dbGJ3YR4AgKeise6bJeW6sxQStzmKkqw4/8h41P9CTswP6BUpGws1PdyOwywP8dFXiXHMJoQJkFHO+9Wd8RTwMxeLCXVBZsV3a0lI1cKIjhtcnb5pju7s+4v2Se+emPjyyr8TR6lSh7Sf60Y=
Received: from BN6PR19CA0090.namprd19.prod.outlook.com (2603:10b6:404:133::28)
 by CY4PR0701MB3729.namprd07.prod.outlook.com (2603:10b6:910:93::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Sun, 29 Nov
 2020 14:19:24 +0000
Received: from BN8NAM12FT036.eop-nam12.prod.protection.outlook.com
 (2603:10b6:404:133:cafe::3d) by BN6PR19CA0090.outlook.office365.com
 (2603:10b6:404:133::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend
 Transport; Sun, 29 Nov 2020 14:19:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; synopsys.com; dkim=none (message not signed)
 header.d=none;synopsys.com; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 BN8NAM12FT036.mail.protection.outlook.com (10.13.182.224) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.11 via Frontend Transport; Sun, 29 Nov 2020 14:19:22 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 0ATEJI3b220806
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Sun, 29 Nov 2020 06:19:19 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Sun, 29 Nov 2020 15:19:17 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Sun, 29 Nov 2020 15:19:17 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 0ATEJHQh019270;
        Sun, 29 Nov 2020 15:19:17 +0100
Received: (from pthombar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 0ATEJHe6019268;
        Sun, 29 Nov 2020 15:19:17 +0100
From:   Parshuram Thombare <pthombar@cadence.com>
To:     <alexandre.belloni@bootlin.com>, <slongerbeam@gmail.com>,
        <vitor.soares@synopsys.com>
CC:     <linux-i3c@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <mparab@cadence.com>, <praneeth@ti.com>,
        Parshuram Thombare <pthombar@cadence.com>
Subject: [RESEND PATCH v9 0/7] I3C mastership handover support
Date:   Sun, 29 Nov 2020 15:19:14 +0100
Message-ID: <1606659554-19229-1-git-send-email-pthombar@cadence.com>
X-Mailer: git-send-email 2.2.2
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8fc8c836-3912-4c84-e505-08d89471c483
X-MS-TrafficTypeDiagnostic: CY4PR0701MB3729:
X-Microsoft-Antispam-PRVS: <CY4PR0701MB3729E9970327DA7DAF3D0EEBC1F60@CY4PR0701MB3729.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IYvM+Y+jUSTNbGUqKSvBHLGjwMGWyGqKyxIoxUVZC+mnq2Ka4gOu+bjcBUlanTu5XOB3oRC768giOhWuha5bWHaEacREKRwunXSsCYFtR/Uwo2YC8qeC+fNlsh9pCh77XH2ZWAvHXPzmiI47BCQnStD54msDp+EXRSWL57bA2RtvqdrjL4WSFoNqBmFPwFxEerJq9AK1q84Ti1b0U6+NIGgChzlK6kYLEx9NAHeUUSPllhsvc+tOiymDnu772/vfBVpsdBfM0cNeLsMp4ts95lZA/3RgbDlGyZtRTrtwoE6yshlKrR4cO6en01BMhLVLTxpbWOI/cIhwbDV0M4bT3t6AOjDIvXzRFD/ZUsWMJZgtgAcD/kHKF+d0426rAeyCgUBJG5AQmkf4Da0DjKvWOfuoP/xWjGdtCfZFAe4vt9w=
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(4636009)(136003)(39860400002)(396003)(346002)(376002)(36092001)(46966005)(110136005)(42186006)(54906003)(316002)(6666004)(83380400001)(8676002)(8936002)(356005)(82740400003)(36756003)(478600001)(82310400003)(70206006)(70586007)(2616005)(186003)(107886003)(5660300002)(81166007)(47076004)(86362001)(26005)(4326008)(336012)(426003)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2020 14:19:22.0669
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fc8c836-3912-4c84-e505-08d89471c483
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT036.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR0701MB3729
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-29_07:2020-11-26,2020-11-29 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 adultscore=0 spamscore=0 suspectscore=2 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011290096
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Main changes between v8 and v9 are:
- Fix NULL dereference issue in current_master_show when
  cat'ing sysfs key current_master for secondary master
  before primary master gets initialized.

Main changes between v7 and v8 are:
- Document format changed from table to DOT diagram
- Appropriate names for few functions
- Moved mastership request process entirely to the driver
- Reuse of i3c_master_add_i3c_dev_locked in core defslvs
  processing

Main changes between v6 and v7 are:
- Added separate functions for main and secondary
  master initialization
- Secondary master initialization don't wait for
  DEFSLSVS.
- Change to use I2C device information from DTS,
  and corresponding changes in controller driver
  and I3C core DEFSLVS processing to ignore I2C
  devices received in DEFSLVS
- Reverted bus_init split
- Fixed formatting issues in document

Main changes between v5 and v6 are:
- Moved populate_bus() hook to master subsystem code.
- For secondary master initialization i3c_master_register
  spawan separate threads, as secondary master may have to
  wait for DEFSLVS and bus mastership.
- Populate bus info is based on DEFSLVS data and take care
  of hot plugged / unplugged I3C devices.
- Split bus_init into bus_init and master_set_info callbacks
- Moved mastership aquire and handover to separate state 
  machines.
- Added DEFSLVS processing code.
- Moved back all locks in side the subsystem code.
- Secondary mastership support to Cadence I3C master
  controller driver
- Sysfs key 'i3c_acquire_bus' to acauire bus.
- NULL check for pool pointer in i3c_generic_ibi_free_pool.

Main changes between v4 and v5 are:
- Add populate_bus() hook
- Split i3c_master_register into init and register pair
- Split device information retrieval, let add partialy discovered devices
- Make i3c_master_set_info private
- Add separate function to register secondary master
- Reworked secondary master register in CDNS driver
- Export i3c_bus_set_mode

Main changes between v3 and v4 are:
- Reworked acquire bus ownership
- Refactored the code

Main changes between v2 and v3 are:
- Added DEFSLVS devices are registered from master driver
- Reworked I2C registering on secondary master side
- Reworked Mastership event is enabled/disabled globally (for all devices)

Main changes between initial version and v2 are:
- Reworked devices registration on secondary master side
- Reworked mastership event disabling/enabling
- Reworked bus locking during mastership takeover process
- Added DEFSLVS devices registration during initialization
- Fixed style issues

Parshuram Thombare (7):
  i3c: master: master initialization flow document
  i3c: master: use i3c_master_register only for main master
  i3c: master: add i3c_secondary_master_register
  i3c: master: add mastership handover support
  i3c: master: add defslvs processing
  i3c: master: sysfs key for acquire bus
  i3c: master: mastership handover, defslvs processing in cdns
    controller driver

 Documentation/driver-api/i3c/index.rst             |    1 +
 .../driver-api/i3c/master-initialization-flow.rst  |  187 ++++++++
 drivers/i3c/master.c                               |  497 ++++++++++++++++++--
 drivers/i3c/master/dw-i3c-master.c                 |    4 +-
 drivers/i3c/master/i3c-master-cdns.c               |  329 ++++++++++++-
 include/linux/i3c/master.h                         |   23 +-
 6 files changed, 968 insertions(+), 73 deletions(-)
 create mode 100644 Documentation/driver-api/i3c/master-initialization-flow.rst

