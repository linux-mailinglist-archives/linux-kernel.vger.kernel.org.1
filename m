Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 917E626D523
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 09:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbgIQHuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 03:50:21 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:19744 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726216AbgIQHuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 03:50:05 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08H7SkYl008576;
        Thu, 17 Sep 2020 00:30:52 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=S+nv8CUA4MfzBw5q7d6AoAv7l6NVCCpFdXJep3CSSlg=;
 b=Yd7vImX+x1CgWvgojivxaIDq0dY/bQ5q3kkkBw862qwQuUhSt0xLakM4bspawKyGDtae
 pWyTaVuwvHUI5c2xKpPq3opBdmIzlk8at73Aa1hsylzRbdRWYc+MXrQBkyd/xxMINO/h
 qp8kwxt4Hv96D6t8jqc9i4wEbRpAbGEM0q1qsK5Iyt6OKJoocvKmp6zbPKVsDgtJz0fv
 K3yojQwaxEXNZnkCAN2DAgepY+6SZskcVE+IkV4AVrWUo42G52yuyH1gMg9d8VIXZhcB
 YgQqPQNy1cZ9Dm2W+hbA940CLw52c2VmZGWUCqE8BFCGh0GQejFuk4d5J2ePEOL6CQpM 7w== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2108.outbound.protection.outlook.com [104.47.58.108])
        by mx0b-0014ca01.pphosted.com with ESMTP id 33k5njxkpn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Sep 2020 00:30:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lg8yMR2LA6G5w4MDXVMckSBPVvi1FYDQ7C0ETZNYoIKEINpNcnA1OSzjFKSWLXDQR+1a2kp1OvXNSonyBwLavocwGfq3siOm9/hHt5heG4lj7+cs90QFTYphCqvxR4caQTTY688FB7okfSHlLef4WyuK6/IuVa5Cpnx4SE3x+Na0s3pPEdHSnTu8mt7Ylhv5eVlh4+DbyVBuFDipUhEF2oUPG9IqbWNZF6cHTvJbieA0BNQMy1p6Mh0QhdMux8R3iqBWYEaZu4dZxK6KZ0whroLAoBr9UPPDDu0sA1hxe/AMG8Ior2vJFuCrEaKdr0nXAML7PDBhVdZJb82WB9mz3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S+nv8CUA4MfzBw5q7d6AoAv7l6NVCCpFdXJep3CSSlg=;
 b=VPy1Hj5ygbYH+HC4J06W5D0EZdd/MRBPcvDhg1Gc9p6UH1jX+lag1/rHzkShSqZuL8kZvOFVLq/0GqphETF+RYBd7sJWXIez4vdw5x7Lw5uAzWpJNiiJQvF4tPsn/+S5LM7gkcWOvD/fmUK6222PN69SD7ule2Pg1TjW2ujzZ/AiEWV8vnQoYeeNOFARpoaUE18zExH1UjpiIithb2YPZmITjD9OaMUVWnRhI+k68Vqmd3Q0bqc4f5qxXbv6f8D0HHWbQN3LFp1go8phhY3BtNPO5jMFC1gKCXSzgieRINy7MEl/DA6kYxJNL38WYPN8IX237LRomSXcP0sc4lSpdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S+nv8CUA4MfzBw5q7d6AoAv7l6NVCCpFdXJep3CSSlg=;
 b=c2A9HmdSazoHkVT1VNo4j0FnfbM0CXggGXJP9qEn5ACCHfdlYAVmpyGP2/gDwvmA/YRa5q25yWTi1wNdJoAibQIgGfMqcx+Y2lnuZhlhDGbOvut+uEJVkiD6u2rIfFr9BAK1bSEu6cxUExaPWt2sfqM0JMsVX3xoTiHtYvHIhuE=
Received: from DM5PR21CA0062.namprd21.prod.outlook.com (2603:10b6:3:129::24)
 by MN2PR07MB7167.namprd07.prod.outlook.com (2603:10b6:208:1a6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3370.16; Thu, 17 Sep
 2020 07:30:50 +0000
Received: from DM6NAM12FT011.eop-nam12.prod.protection.outlook.com
 (2603:10b6:3:129:cafe::40) by DM5PR21CA0062.outlook.office365.com
 (2603:10b6:3:129::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.0 via Frontend
 Transport; Thu, 17 Sep 2020 07:30:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 DM6NAM12FT011.mail.protection.outlook.com (10.13.179.171) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.6 via Frontend Transport; Thu, 17 Sep 2020 07:30:49 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 08H7UmHQ011305
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 17 Sep 2020 03:30:49 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 17 Sep 2020 09:30:47 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 17 Sep 2020 09:30:47 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 08H7UlmB009773;
        Thu, 17 Sep 2020 09:30:47 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 08H7UkLn009772;
        Thu, 17 Sep 2020 09:30:46 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>, <tomi.valkeinen@ti.com>, <jsarha@ti.com>,
        <nsekhar@ti.com>
Subject: [PATCH v3 00/13] PHY: Add support for multilink configurations in Cadence Torrent PHY driver
Date:   Thu, 17 Sep 2020 09:30:33 +0200
Message-ID: <1600327846-9733-1-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 736fa6ae-900e-4053-9624-08d85adb99ec
X-MS-TrafficTypeDiagnostic: MN2PR07MB7167:
X-Microsoft-Antispam-PRVS: <MN2PR07MB7167518951A8B907172390F9C53E0@MN2PR07MB7167.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6108;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: W3AgsgFTLxPf3oNPD6tnbp870qe273N2/0Qu0Y+KV1PJtsB4lLBJZSCkS8PVGjJBT4FQMsausPrBWG+pEDyoxWC4GucOQC88DyeLWHQyI14VsVZCKaG5D7+I9iCJdkixKv5WZEm9L8d+pJCSbod7295XoH4Axf055uvBE7/HyzqV6YpAsoZ2nk+uHvnS0xShrdnacnjHsR9f0gB/39FGkQ3M/RBw2S5U1mG9/vOQTfQvUlOuMHGXbV8QA9OP9yUFAyTuYexTgi/j3AdDtn+kdLgi2kxOb2JQBmUZHy30pkHlMuWXYuwP6YMBCTZuS3F+N+68dCdG7Dsm09SjXr1v9hAXqjAGsXz6kLJh35/w1bVHRmwguhJQIAhQRuTMeseZ1Xd+hWtmUAJ8jdINc6Dc3whbFFjjKEpyrR76W3g3+fNuC4evMyLJl5uwyOrwExiVNx4vlDoNED6mqHIQKhE74o1ui+l2RfoNv4QKUU4GeG/z819LX48pq+JYKk4B4hw0
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(39860400002)(396003)(36092001)(46966005)(4326008)(426003)(966005)(186003)(110136005)(82310400003)(36756003)(54906003)(26005)(316002)(336012)(2616005)(8676002)(42186006)(2906002)(82740400003)(83380400001)(36906005)(5660300002)(81166007)(356005)(8936002)(6666004)(47076004)(86362001)(478600001)(70206006)(70586007);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2020 07:30:49.8902
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 736fa6ae-900e-4053-9624-08d85adb99ec
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT011.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR07MB7167
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-17_03:2020-09-16,2020-09-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 malwarescore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 adultscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009170054
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cadence Torrent PHY is a multiprotocol PHY supporting different multilink
PHY configurations including DisplayPort, PCIe, USB, SGMII, QSGMII etc.
This patch series extends functionality of Torrent PHY driver to support
following configurations:
- Single link PCIe configuration
- PCIe + SGMII/QSGMII Unique SSC multilink configuration
- Single link SGMII/QSGMII configuration
- Single link USB configuration
- PCIe + USB Unique SSC multilink configuration
- USB + SGMII/QSGMII multilink configuration

The changes have been validated on TI J7200 platform.

This patch series is dependent on [1] and should be applied on
top of this.

[1] https://lkml.org/lkml/2020/9/16/668

Version History:

v3:
   - Rebased on latest PHY next and new PHY patch series [1]

v2:
   - Rebased on latest PHY next and new PHY patch series [1] and [2]

Swapnil Jakhade (13):
  phy: cadence-torrent: Add single link PCIe support
  phy: cadence-torrent: Check cmn_ready assertion during PHY power on
  phy: cadence-torrent: Add PHY APB reset support
  dt-bindings: phy: Add PHY_TYPE_QSGMII definition
  phy: cadence-torrent: Add support for PHY multilink configuration
  phy: cadence-torrent: Update PHY reset for multilink configuration
  phy: cadence-torrent: Add clk changes for multilink configuration
  phy: cadence-torrent: Add PHY link configuration sequences for single
    link
  phy: cadence-torrent: Configure PHY_PLL_CFG as part of link_cmn_vals
  phy: cadence-torrent: Add single link SGMII/QSGMII register sequences
  phy: cadence-torrent: Add single link USB register sequences
  phy: cadence-torrent: Add PCIe + USB multilink configuration
  phy: cadence-torrent: Add USB + SGMII/QSGMII multilink configuration

 drivers/phy/cadence/phy-cadence-torrent.c | 1975 ++++++++++++++++++++-
 include/dt-bindings/phy/phy.h             |    1 +
 2 files changed, 1934 insertions(+), 42 deletions(-)

-- 
2.26.1

