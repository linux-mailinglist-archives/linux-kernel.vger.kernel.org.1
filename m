Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A39612C71A8
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Nov 2020 23:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390637AbgK1VvQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Nov 2020 16:51:16 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:64832 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730041AbgK1Sfi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Nov 2020 13:35:38 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0ASEcI7d013196;
        Sat, 28 Nov 2020 06:44:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=D4WAOcTSVRhiqpgt6+RIqt44afIu9qf6wZsAkL4JI6E=;
 b=p0PkOzG7ku7z48Czu4smYw3LkSdqi+D6pYW7pgwKxgdADFl3pqsfA9rKew8szT4DsYVI
 47DQ/4JrU2E/IzD45rPnWunDxnwDBm4yTPw8dg6fNzdmqFoGxlD9R4/JvwvTfRdgUC8m
 xmGkuuANjS/tK+kq+TQUzyEWT06XZnXtU2/DbhrMyuXVjvhkILRULr5UWz4rYSoJBSNc
 d9Q5bpXBYdGCFo0jiZc6OQe4XIX6Q3pl5GN3npgI6IOzr0tmPvIHra1bvhlmEp+MBtF8
 SxUKi5Cy08JJs9ZGMi0LSvrDM7kAj7YFOVS1kEUSfj/dE0LRnpFuvLITaciglaF/oD9R CQ== 
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2049.outbound.protection.outlook.com [104.47.74.49])
        by mx0a-0014ca01.pphosted.com with ESMTP id 353m02reyj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 28 Nov 2020 06:44:48 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e07rEShJ0bquyqCOYFNyPxMJVayZeviXrlbEJHh/D0RGbO3R8CeWJQcdBW5CXU87m6nkkutm8yGMtJnGyEnTZP5kILNITKJCswRpF2mrpJ3fIZoUQsZDmtxyA+OB32UHD9UbjbXNQnXclolwwNMStFAFeOWL58sTVW81r/SwbUgtXdsJhr+i1cLj6Gz3d6PxGgrlU0uWIitpL0kTVniHayWR7KlkpgUXfhJ+OaBYUPAKEaj+rQvqutQBzerWIVMdQmDgCSp9POeQSInuTo5qMBjhWJK/5DShuojSSKpOffDdpUI6B9gbN8gDCbnW46zYnZ6xMUpvb/nB34tRJ2sALA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4WAOcTSVRhiqpgt6+RIqt44afIu9qf6wZsAkL4JI6E=;
 b=H9cqSSQF3tnSxgC0shAlgiRxyGrnHFs3vkR4dIIcZF5mqgwiloI6E+UG9E2Iz8xqv2rT8+ruVfGiFsDA4mUUAGYXiwQk3uzYVhH/VWlM6VxeWbMftARWe1eOXMio3vuYyAZO2gW44riJVBLnyLaYK/Gijq/k0IxRNDZs55mrj/nZO8OPw17uqzG6Hs4nxTv4egMCtcHwPmqyn5exZe02pED358/YovMFlw1ipTDBgBhlICSnoALI7eTcPdDlP+5R10gyKT6/lllvJR1bscCWbaJYuXJtm2wB5C4R9NUgfrBDj7SN5XP50zg6av+VHHBDHNONGaDR6K4MqPqLTqXeMA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=synopsys.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D4WAOcTSVRhiqpgt6+RIqt44afIu9qf6wZsAkL4JI6E=;
 b=Sa5/Ps2pLYCAOGJWMr0cGJycYmWgZlZNFOduqT0fuJQVs+wgCq6hkorVVzbEo/ejg7SQCkA4hu8UfsT8+nq2BRWZHfAAW4GGO22YyqA1qgjyNgDWWkAOGy8ZvpKE96/v99QEF/q9jdKVvP6fHM9Upo51Wy6wfxG8KyAJl+wYFQY=
Received: from DM5PR07CA0120.namprd07.prod.outlook.com (2603:10b6:4:ae::49) by
 SJ0PR07MB7678.namprd07.prod.outlook.com (2603:10b6:a03:28e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.22; Sat, 28 Nov
 2020 14:44:46 +0000
Received: from DM6NAM12FT033.eop-nam12.prod.protection.outlook.com
 (2603:10b6:4:ae:cafe::9e) by DM5PR07CA0120.outlook.office365.com
 (2603:10b6:4:ae::49) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.23 via Frontend
 Transport; Sat, 28 Nov 2020 14:44:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; synopsys.com; dkim=none (message not signed)
 header.d=none;synopsys.com; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 DM6NAM12FT033.mail.protection.outlook.com (10.13.179.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.11 via Frontend Transport; Sat, 28 Nov 2020 14:44:43 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 0ASEie6E143829
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Sat, 28 Nov 2020 06:44:41 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Sat, 28 Nov 2020 15:44:39 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Sat, 28 Nov 2020 15:44:39 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 0ASEidER020859;
        Sat, 28 Nov 2020 15:44:39 +0100
Received: (from pthombar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 0ASEiahA020858;
        Sat, 28 Nov 2020 15:44:36 +0100
From:   Parshuram Thombare <pthombar@cadence.com>
To:     <alexandre.belloni@bootlin.com>, <slongerbeam@gmail.com>,
        <vitor.soares@synopsys.com>
CC:     <linux-i3c@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <mparab@cadence.com>, <praneeth@ti.com>,
        Parshuram Thombare <pthombar@cadence.com>
Subject: [PATCH v9 0/7] I3C mastership handover support
Date:   Sat, 28 Nov 2020 15:44:34 +0100
Message-ID: <1606574674-20821-1-git-send-email-pthombar@cadence.com>
X-Mailer: git-send-email 2.2.2
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2eb2463c-2f49-46bf-c97e-08d893ac251e
X-MS-TrafficTypeDiagnostic: SJ0PR07MB7678:
X-Microsoft-Antispam-PRVS: <SJ0PR07MB7678BC475B36262655CB07C8C1F70@SJ0PR07MB7678.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1reMZI5Rvu97gWaTSCUDePz8YKwA/CFgEk4aIdDx2upz/2Lci8nVlKSZ1S050b+VGUjyeDQ7R/iCYOwTfsZvmgW9xRZI1PXhMDsF1EcfLiWIC0E06xcf0C9lGL0gH7mCw3wWGPlVdZwgiJacqpkJt1UezY02/V9Z4bULj3GMc95y6sMIe/1RO4If+dStZyToEIMqFsondgTEpadyuvrvOEKQRuNfiKKlxowLgErQu1vYv1TWHqfcEo5UupQbVN7NylooiRVibjxSCMHxNg/bcIbvO5EVgyKPpfb/FewXFLVbuRk/U5yrCY76cJkyxyHOr2WrBDwlzxm4j/j1yMEtYRlFEz0WfwETzuU9s87Uizbdo8dZvqXylmXylLft3u5RD/LlCMVmcIckPMGDSWbrOvmSyhQXmP5mmX50nmDOG5E=
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(4636009)(346002)(39860400002)(376002)(396003)(136003)(36092001)(46966005)(42186006)(86362001)(356005)(4326008)(5660300002)(186003)(336012)(81166007)(107886003)(70586007)(8676002)(26005)(110136005)(70206006)(36756003)(82310400003)(54906003)(47076004)(316002)(8936002)(83380400001)(2906002)(426003)(478600001)(82740400003)(2616005);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2020 14:44:43.8138
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2eb2463c-2f49-46bf-c97e-08d893ac251e
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT033.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR07MB7678
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-28_09:2020-11-26,2020-11-28 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 clxscore=1011
 impostorscore=0 adultscore=0 spamscore=0 suspectscore=2 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011280089
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

