Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB2126C801
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 20:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbgIPSim (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 14:38:42 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:50884 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727955AbgIPS24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 14:28:56 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08GIOjZW012142;
        Wed, 16 Sep 2020 11:28:37 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=oLek3JK8uCb6RlQ3BOjAFR+x+5arA65JRUlLHiUm2DY=;
 b=LnQ5FmkF4ccJhnt/U6qSW7EymsDNN2uDyndS4GLo1r3W6XjJdQ9z3x0ZaTM95e3f5VI+
 hdrplHw85Ale2E+myFypzfoTmkslUjyij/Cx1xATSwxt7P6uUGJY9/O8UFLirYx306Pm
 MbBLpMhq7IcGiiQUNzYYhm77kh8AYkuzg10VN8uQa9Qbuur4BQDXwt3fwlcDHAGlypPd
 GXWH38pFs65MalUruDMwurv4z4XoPSp0HP9kMIJfRsg/8isJRKrtTQukZ9/PMsgjAUPH
 P6g5AH0n8T5gYf8PW9FAVl71bMxGXxTtHqTGk+5IRTfrXnujA8r5N1cdtoFmUWPP+4v/ Hg== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by mx0b-0014ca01.pphosted.com with ESMTP id 33k5njvbh6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Sep 2020 11:28:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Qt2ThAjTz4U+7ybQl7+MKanDyk4QRrnHKeF5zbYluOpBdvgz5SpULGuEDWkfOgrm9oPYAlkhgoBcBGF4u2u1YS3PiR0ez1holoHMrskNOU4h+3/Y17GTDqcddT99dFr3vQuXdWalS5bA0NlPgj6jwXawEPSZTNNgW9/haxm4m13NCsx/QH6W5YlxdfNNS4zE1XWsBlccaiPHNqnd/g5vLKsnU6EKvId7bhQLfXIE9AMtuLQ7pIuJe1FIkI+jiD9GVc7y+N9E/h4zleiI97Us8s004y/irjo6DgGjaAC7/rc+egUref3mTitKyAOuzaG3FSSB1trfgB6obM9e9DQnnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oLek3JK8uCb6RlQ3BOjAFR+x+5arA65JRUlLHiUm2DY=;
 b=J3XeU66TR6Joc3lnqt8ywmRoJlh0VD/yWjX1g2mqu0TrniQWC9sn087Y30WsZsUvUsUdA7EhIT5VkVsfI/NNR6gB+kz3nbc3RYLtNW3VLxKN84WHDo9rPmEJEK6px0YnUuMIJSmDXFKcDexgGvnHKik5ujj5tDc8jdp9JyaaOs4IARqXluh9GRm2qilqI+1LEh4LIyZy8kR4fQQwo9H6LwBHHtRIGNx+LX47GHV/hsR+MR6yB+P/A6D1ebOgQQUbGTHigBnIiWZLEfvNCsFQIBFnr+7a5Sp3liIcA2TVZUhEK4inKS6lnkwwR+La2HEa/+e+Jjx6zDHqG0qawH0Xtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oLek3JK8uCb6RlQ3BOjAFR+x+5arA65JRUlLHiUm2DY=;
 b=4jKS0xsUCCKBh+QmGW+adaVRG+qd2guV0KJocBCqZ4+PBeDoxIB2Z7C2GbxfAnoOpvhQwuVSTOvvoqJGssUMwWbC0yHkejIlvtawTgN/hGdA4ZRf6ZjnVp9JdXIzuFWb2HxvVKZjL7/FtwaSqnQUiHfHssGIO2Rh6z7qeQp2akE=
Received: from DM5PR20CA0010.namprd20.prod.outlook.com (2603:10b6:3:93::20) by
 DM6PR07MB6505.namprd07.prod.outlook.com (2603:10b6:5:1cb::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.16; Wed, 16 Sep 2020 18:28:35 +0000
Received: from DM6NAM12FT043.eop-nam12.prod.protection.outlook.com
 (2603:10b6:3:93:cafe::9b) by DM5PR20CA0010.outlook.office365.com
 (2603:10b6:3:93::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11 via Frontend
 Transport; Wed, 16 Sep 2020 18:28:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 DM6NAM12FT043.mail.protection.outlook.com (10.13.179.162) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.14 via Frontend Transport; Wed, 16 Sep 2020 18:28:35 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 08GISXhO016248
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 16 Sep 2020 11:28:34 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 16 Sep 2020 20:28:32 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 16 Sep 2020 20:28:32 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 08GISWMr009253;
        Wed, 16 Sep 2020 20:28:32 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 08GISVTB009251;
        Wed, 16 Sep 2020 20:28:31 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>, <tomi.valkeinen@ti.com>, <jsarha@ti.com>,
        <nsekhar@ti.com>
Subject: [PATCH v3 0/7] PHY: Prepare Cadence Torrent PHY driver to support multilink configurations
Date:   Wed, 16 Sep 2020 20:28:24 +0200
Message-ID: <1600280911-9214-1-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2e53899f-b72a-4a73-e8a1-08d85a6e52bc
X-MS-TrafficTypeDiagnostic: DM6PR07MB6505:
X-Microsoft-Antispam-PRVS: <DM6PR07MB6505464CA9EE1150FBD7E431C5210@DM6PR07MB6505.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vrskN2ID+fMGglWKXetgYzgUdL4RX795fE95sV7+YoDsg2bPDezgEjU4RpYIHMCXR+e8TqC8rg/z0lGgJyX/vlWff5nrlNuR8IdaGVSIXtvcHke+gFXaBM8j8W8c3Ut6LA57UgrRBcfTv8UiSdOHrPf2sF1XhbBEPLJ9iN+E/i97cC3plU/fnJJjmm5YiA4B1QSowWmY4mJQPtE26Xw6BDj5Z6Oe47C9yGignqXiNRxstE/NnZw40Y9hc5Hu06BX9+cDun0K/CWWo1n+gYNjr7c+zcNiSLF4YUyFHblmx8g13+MUCYVfDdC/UMM4DU2mW4e7rdkh9HEQYGwQ4BUXAPvjDqDxiQjlodEgpz8OOgHRTCT/IhH1lsk23q+N1A29wXNJfR0VZyk52vOiz9LoEEChqpm3Q8Li7fi88ZVuaKM=
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(39860400002)(136003)(36092001)(46966005)(316002)(82740400003)(7636003)(356005)(426003)(86362001)(2616005)(36756003)(26005)(70586007)(6666004)(336012)(8936002)(5660300002)(47076004)(36906005)(70206006)(4326008)(8676002)(2906002)(110136005)(54906003)(83380400001)(186003)(478600001)(82310400003)(42186006);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2020 18:28:35.2820
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e53899f-b72a-4a73-e8a1-08d85a6e52bc
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT043.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB6505
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-16_11:2020-09-16,2020-09-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 malwarescore=0
 bulkscore=0 spamscore=0 mlxlogscore=610 phishscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 adultscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009160130
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cadence Torrent PHY is a multiprotocol PHY supporting different multilink
PHY configurations including DisplayPort, PCIe, USB, SGMII, QSGMII etc.
Existing Torrent PHY driver supports only DisplayPort. This patch series
prepares Torrent PHY driver so that different multilink configurations can
be supported. It also updates DT bindings accordingly. This doesn't affect
ABI as Torrent PHY driver has never been functional, and therefore do not
exist in any active use case.

Support for different multilink configurations with register sequences for
protocols above will be added in a separate patch series.

Version History:

v3:
   - Rebased on latest PHY next
   - Fixed v2 review comments for DT patch 7/7

v2:
   - Rebased on latest PHY next and new PHY attributes patch series [1]

Swapnil Jakhade (7):
  phy: cadence-torrent: Use of_device_get_match_data() to get driver
    data
  phy: cadence-torrent: Use devm_platform_ioremap_resource() to get reg
    addresses
  phy: cadence-torrent: Enable support for multiple subnodes
  phy: cadence-torrent: Add separate regmap functions for torrent and DP
  phy: cadence-torrent: Check total lane count for all subnodes is
    within limit
  dt-bindings: phy: cadence-torrent: Add binding to specify SSC mode
  dt-bindings: phy: cadence-torrent: Update Torrent PHY bindings for
    generic use

 .../bindings/phy/phy-cadence-torrent.yaml     |  86 +++++++++--
 drivers/phy/cadence/phy-cadence-torrent.c     | 146 ++++++++++--------
 include/dt-bindings/phy/phy-cadence-torrent.h |  13 ++
 3 files changed, 166 insertions(+), 79 deletions(-)
 create mode 100644 include/dt-bindings/phy/phy-cadence-torrent.h

-- 
2.26.1

