Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4D7A2C7E15
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Nov 2020 07:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgK3GRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Nov 2020 01:17:49 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:7548 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725860AbgK3GRt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Nov 2020 01:17:49 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0AU684hb014074;
        Sun, 29 Nov 2020 22:16:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=mCAQLHWOrs1dH1GZeiTwr/Xps97gDnT+aFrWmpEJy1E=;
 b=dZqWih467QZheN+jIHVkhGNFfbrez+dnhJCt6J3uyuykNvtXxTOvycGl/sOCX0m4fwLT
 ABDG0iPPFJJ08Zru01uGL2j+wbOlccviHE1pBkZexPE+nS13pQo5Undihp6+UWADQyoL
 Lwd164E83dLwTmoTR0kmiXQa6dlrAE3h10dxyLgCks7ufv4CWRpLtQhdKGaR7/blaep5
 w0yrNPu9GeDW11Hg17VRXun550ILrI5oaiD3nqciFtWbqvmPBg50a/hYY42gLAoF1iBH
 GHH0IIa8MH+E6xHbXMitroGlUjkTpijXTaNYJGX8zEyakcybbqCquhwbszmndAJm4zOo sQ== 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2045.outbound.protection.outlook.com [104.47.73.45])
        by mx0a-0014ca01.pphosted.com with ESMTP id 353m02v1sp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 29 Nov 2020 22:16:35 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kl+T8XESsaE7zn7AxFIJtgABdDJy1Tsu85YGcQekEdqjNAi83yon0m/vlP7Odv2I13gCODgzKFxLk4/yLhphkHKD8JGWgWdKDJiFyL1iptRgKUQS79ZIwGaNM2Xz8G7cSPf9lT5lusmiTFqrBj8LflV+zoNGMQ4ATE46o08pEUPQbP2MO7siIEGD19QWy3Z40so6sqfNZJ9eCmgImXAOWS1wwddeaIqkl0/ruP96wx2PS68MIGX4IdsXsuHNyj1qN1g9IE0rNJFDasKWOSJ+hRd1GgKnxoILfgsGRy/V/LUfz7y6MwRGKNvHrjQAuqgSSMcW3aeQMx5TxMyZ+qn21A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mCAQLHWOrs1dH1GZeiTwr/Xps97gDnT+aFrWmpEJy1E=;
 b=X8pmNGYdpWbc486SoRj8S6hg5NdLMwERtk+WoZFilFwjsH6bvpV+noifobmWd0/ajcM3ZmiBsWfSGMmgOCC1tJwDnpcVGnnSdMapDd1IfRAF6n1Sr1SF+L75PH3gZ4/5P+jHiPtvzRotOBmCImZQsO3W08r+6JBl4wz/XV99Zq7lYL3RpEkg3WPfhXgbEolf4StW33ltgqEAiY+uyActf0cYB365XsOzz4fyjHP/CfICwBmKMlm77U5jHauIZyP5rc+fcgQqUIJzNUR7Cj3fOlnMGMFb7zrQ080hYeYe4sMF2fPj3+9a6VSghzXfC2mwTS9DMJqlL0qJInj/WOcTtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=synopsys.com smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mCAQLHWOrs1dH1GZeiTwr/Xps97gDnT+aFrWmpEJy1E=;
 b=5Wnw3ZPNxFHQAocgkBpdOlXbFYwW0idH9JwU2pSqNmxlV8nOiy32SYOvuhGC8bvipsOwkgPVFfoB71P/acDqq+Lxq1VOkAor3HskL12MaNSfcYVsI9sXZ0inje8dtr13WleBHmMkkcyaBYahBSrPe/jdhf4LJySwsDo3vz+CCiQ=
Received: from DM6PR03CA0092.namprd03.prod.outlook.com (2603:10b6:5:333::25)
 by MN2PR07MB7102.namprd07.prod.outlook.com (2603:10b6:208:115::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.21; Mon, 30 Nov
 2020 06:16:32 +0000
Received: from DM6NAM12FT016.eop-nam12.prod.protection.outlook.com
 (2603:10b6:5:333:cafe::6) by DM6PR03CA0092.outlook.office365.com
 (2603:10b6:5:333::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend
 Transport; Mon, 30 Nov 2020 06:16:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; synopsys.com; dkim=none (message not signed)
 header.d=none;synopsys.com; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 DM6NAM12FT016.mail.protection.outlook.com (10.13.178.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.12 via Frontend Transport; Mon, 30 Nov 2020 06:16:32 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 0AU6GSGC032690
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 30 Nov 2020 01:16:30 -0500
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 30 Nov 2020 07:16:28 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 30 Nov 2020 07:16:28 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 0AU6GS6T003683;
        Mon, 30 Nov 2020 07:16:28 +0100
Received: (from pthombar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 0AU6GPuO003681;
        Mon, 30 Nov 2020 07:16:25 +0100
From:   Parshuram Thombare <pthombar@cadence.com>
To:     <alexandre.belloni@bootlin.com>, <slongerbeam@gmail.com>,
        <vitor.soares@synopsys.com>
CC:     <linux-i3c@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <mparab@cadence.com>, <praneeth@ti.com>,
        Parshuram Thombare <pthombar@cadence.com>
Subject: [PATCH v10 0/7] I3C mastership handover support
Date:   Mon, 30 Nov 2020 07:16:23 +0100
Message-ID: <1606716983-3645-1-git-send-email-pthombar@cadence.com>
X-Mailer: git-send-email 2.2.2
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 77331739-b1cf-4f99-5aaf-08d894f77b96
X-MS-TrafficTypeDiagnostic: MN2PR07MB7102:
X-Microsoft-Antispam-PRVS: <MN2PR07MB710291E3AB1EC9918F812FD7C1F50@MN2PR07MB7102.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YvXHM7HM1N6BrmLEuw9bD+IzLGZ5VXAXlHl8kIfzsIzdHpj0p/6KcTwvzoJJPnVMiKzKfGtEQ1+G/Li3CtHM/Zw3CfoNPkR8I2MnBfyTWgtC0n6TJ7rs+6WqycnyyBHPBZG8hKcpPwzxuhMyr4HKb/Gycb/q+ry9FEjcej1+yYAWrWAewAXAwFAfkuZK2N0qRcuSnyG6AN10L/3Kdjp4mQHeUcMBGQLIbXIgIP42Q9EqAJFN4ZQFrA96IK/GAWaclUtrttEMVf3FEd5TXKlm0AlTWz4k5qpxZtXlveOPSbDE9bNR3iEwlcMCMO9Uy9+0NKa55gKlNzvC8jnP+XVe++NPut5j5W0xUgXvfvQG2tPZazwrLsz5HtwNuR+bp8Qr/gWYn2DDrnaVe1VTlL4JsIdjD380C2Y3lFLpGDXzGho=
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(396003)(39860400002)(346002)(376002)(136003)(36092001)(46966005)(107886003)(83380400001)(426003)(70206006)(42186006)(478600001)(82310400003)(110136005)(336012)(4326008)(26005)(2906002)(70586007)(8936002)(36756003)(316002)(186003)(2616005)(356005)(36906005)(5660300002)(8676002)(47076004)(82740400003)(81166007)(54906003)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2020 06:16:32.3179
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 77331739-b1cf-4f99-5aaf-08d894f77b96
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT016.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR07MB7102
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-30_01:2020-11-26,2020-11-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 malwarescore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 impostorscore=0 adultscore=0 spamscore=0 suspectscore=2 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011300041
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Main changes between v9 and v10 are:
- Fix build failure reported by kernel test robot

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
 drivers/i3c/master/mipi-i3c-hci/core.c             |    4 +-
 include/linux/i3c/master.h                         |   23 +-
 7 files changed, 970 insertions(+), 75 deletions(-)
 create mode 100644 Documentation/driver-api/i3c/master-initialization-flow.rst

