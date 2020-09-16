Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B20AD26C816
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Sep 2020 20:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728086AbgIPSkm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Sep 2020 14:40:42 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:37542 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728046AbgIPS2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Sep 2020 14:28:53 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08GIOo6R012348;
        Wed, 16 Sep 2020 11:28:39 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=AgvOC4JqjdS5Lr402eP8vW3LQESI2uqBAFxY6J6j+e8=;
 b=Yw6HBDkTaGGzYuPNejblDd54fMRW4Ecxgdk9JbIYJUXRf5S9fhiIgPvlIK3uk1Pxnj/q
 YmwVo0kKCMkwBJfrCbb6etbdMtgggEocrDaJWp+qJ1+13GUWZvPsFgPFrk2tvSTgFZ76
 M4qaq8lP1frRVgz8EJXXu4Wq4Mq033wmzJhl2U8meMdDRIokVEtPfEYWuhlZlBN9TqdB
 +O+1ohLUZtXeJVHnE7JB+H9kwGO3sLW2FiX4kiWOsBn8EYzrDzYEDjDMfLnQwIWlxv9A
 QON5ScCCy2mvL74Y9XgMWviEU6mx1ZbbsUm9W9Dij6QDm6xWJTA7PetpGMPHiN/YjyGc 5A== 
Received: from nam04-sn1-obe.outbound.protection.outlook.com (mail-sn1nam04lp2051.outbound.protection.outlook.com [104.47.44.51])
        by mx0b-0014ca01.pphosted.com with ESMTP id 33k5njvbhb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Sep 2020 11:28:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VShTJb9XV46b9QD1G3/pj6xJzFEOYipOZ1j3Y/PpOESI4BKaNKA+aANAZLcFJm/kV3gG25APKk5Wxb9E/hKk89s2jY5mKEpFNz6VarjS8ov09sRx6XQt0U+T4e3AYwTst6as5x8atGf2a3h3uRShLIrWzxpdJ6kAbDYpq1IVsW3BOvM5WEHjFjbgCCtWPet/VyZjMY104WIr4nEomsYslFma9bcdazpM6rtX5WBDBDsy0F9kTDgiJy86yom/d+pniMppi/z2Kye2cBd9E1BsD1AMMW9ZvcWuVFK5kgZ4ajzeTiGyUuyiX302HrzdNbIwOnAgiJHv1gkATpdG3vJaYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AgvOC4JqjdS5Lr402eP8vW3LQESI2uqBAFxY6J6j+e8=;
 b=IWrLIIxhJgy0ZEwFaQFHfGc81cp8eKiVt7uqCreURbIMD6ONX9C47lypXkzlyjRV3GQdW6/A4B09+8sBq+FQaFE9l8CUAGzLRyWTPVX6LhqrrVqoIt/f0ADNaa9pLKaKTGmwLJLcZWJXKkbOZTitJt8Rc/vmCLTjvMtHxR3hr7lxpiS9XWCpz+Nr8IyfI0m62hqAk4TaVjQu0pYONkDSotwFLPwo1MBdHwyaSfKNclyG6+Src71Hfo59LTOBE8fGIlJmWow5E1Hx5rceo07V7RpmpqrRTwDmI775W66AqaFZm8BMGsjzo3686Te35kJ+e1yTpiU3bNTlCrA5D+Bh2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AgvOC4JqjdS5Lr402eP8vW3LQESI2uqBAFxY6J6j+e8=;
 b=jpyRt3UFdZhsELitvdhxNZvp16wFtjiSsS0aQ5+0ofCgzIhFQs0gtHNE1JW8WKll5VSqBt3lllAE6+Va+aGa3Zc1xxyorushRu0IVMvqY8Xi5J5XywevaX2xRhyn219r7SYAQUBxdldGFb7UONbjL3YBjKypKCxCueLARadXfmA=
Received: from DM6PR13CA0031.namprd13.prod.outlook.com (2603:10b6:5:bc::44) by
 BN7PR07MB4497.namprd07.prod.outlook.com (2603:10b6:406:b6::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3370.18; Wed, 16 Sep 2020 18:28:36 +0000
Received: from DM6NAM12FT032.eop-nam12.prod.protection.outlook.com
 (2603:10b6:5:bc:cafe::12) by DM6PR13CA0031.outlook.office365.com
 (2603:10b6:5:bc::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.4 via Frontend
 Transport; Wed, 16 Sep 2020 18:28:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 DM6NAM12FT032.mail.protection.outlook.com (10.13.178.209) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3391.14 via Frontend Transport; Wed, 16 Sep 2020 18:28:36 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 08GISXhQ016248
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 16 Sep 2020 11:28:35 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 16 Sep 2020 20:28:32 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 16 Sep 2020 20:28:32 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 08GISW4e009266;
        Wed, 16 Sep 2020 20:28:32 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 08GISWLA009265;
        Wed, 16 Sep 2020 20:28:32 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>, <tomi.valkeinen@ti.com>, <jsarha@ti.com>,
        <nsekhar@ti.com>
Subject: [PATCH v3 3/7] phy: cadence-torrent: Enable support for multiple subnodes
Date:   Wed, 16 Sep 2020 20:28:27 +0200
Message-ID: <1600280911-9214-4-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1600280911-9214-1-git-send-email-sjakhade@cadence.com>
References: <1600280911-9214-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 50cdd408-280d-4f25-dc02-08d85a6e5390
X-MS-TrafficTypeDiagnostic: BN7PR07MB4497:
X-Microsoft-Antispam-PRVS: <BN7PR07MB44976503D3F6F60665084A4BC5210@BN7PR07MB4497.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:131;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: z0W5pM0mOzjXNlj4RtGfbu1/r/uAAU34bVepC5LjJ4izQLLYCgT/VAfELUiHBGOUcb/xt5WHN0yCx3ieUdoj/l3ytuqPeocfHzUiUDWVQjwt76VWVWLoFVVRgrqvWU0IBXF8FqexzTPfvajrgnE309RY9kHMU3El1CGJU36768GxUHAErAu7PeI/jRtYYBZqQpBA4TTCKskIvvUlmJyPS6NkAdL3vcTu7hw4A0Q1U98aXGs5crtZGW7A1JmsCewIZEPnWfmHdUOGkPvsyear5CzEzBGIIrpqBN7vr/LxWSgiHTKHWk1c5XLn63Fr9b1aZ/F7Wgg/RtXTAwgaPh71G4LwpFrRnCLJ9so9gVMlfYDetmfCan/n/MbqUsJXPkMN8xLaFVPOibFRtuYzOGE7XPG85R6i64u881kqw2ROnSnTfz+xfX1rg/3yOC+RnXbL5hsyp7pKlm953QwO2kN78toZkt85lsLZ4ZzEI5HIYHg=
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(376002)(346002)(396003)(136003)(39860400002)(36092001)(46966005)(54906003)(8936002)(42186006)(8676002)(82310400003)(426003)(2616005)(336012)(110136005)(186003)(316002)(4326008)(36906005)(36756003)(86362001)(26005)(2906002)(478600001)(6666004)(70586007)(356005)(83380400001)(82740400003)(5660300002)(7636003)(47076004)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2020 18:28:36.6750
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50cdd408-280d-4f25-dc02-08d85a6e5390
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT032.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR07MB4497
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-16_11:2020-09-16,2020-09-16 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 malwarescore=0
 bulkscore=0 spamscore=0 mlxlogscore=856 phishscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 suspectscore=0 adultscore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009160130
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable support for multiple subnodes in torrent PHY to
include multi-link combinations.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
---
 drivers/phy/cadence/phy-cadence-torrent.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-torrent.c b/drivers/phy/cadence/phy-cadence-torrent.c
index bd8656dfc919..966aeec8ec06 100644
--- a/drivers/phy/cadence/phy-cadence-torrent.c
+++ b/drivers/phy/cadence/phy-cadence-torrent.c
@@ -1746,9 +1746,6 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 	if (subnodes == 0) {
 		dev_err(dev, "No available link subnodes found\n");
 		return -EINVAL;
-	} else if (subnodes != 1) {
-		dev_err(dev, "Driver supports only one link subnode.\n");
-		return -EINVAL;
 	}
 
 	for_each_available_child_of_node(dev->of_node, child) {
@@ -1771,14 +1768,6 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 			goto put_child;
 		}
 
-		if (cdns_phy->phys[node].mlane != 0) {
-			dev_err(dev,
-				"%s: Driver supports only lane-0 as master lane.\n",
-				child->full_name);
-			ret = -EINVAL;
-			goto put_child;
-		}
-
 		if (of_property_read_u32(child, "cdns,phy-type",
 					 &cdns_phy->phys[node].phy_type)) {
 			dev_err(dev, "%s: No \"cdns,phy-type\"-property.\n",
@@ -1849,10 +1838,6 @@ static int cdns_torrent_phy_probe(struct platform_device *pdev)
 			gphy->attrs.bus_width = cdns_phy->phys[node].num_lanes;
 			gphy->attrs.max_link_rate = cdns_phy->max_bit_rate;
 			gphy->attrs.mode = PHY_MODE_DP;
-		} else {
-			dev_err(dev, "Driver supports only PHY_TYPE_DP\n");
-			ret = -ENOTSUPP;
-			goto put_child;
 		}
 		cdns_phy->phys[node].phy = gphy;
 		phy_set_drvdata(gphy, &cdns_phy->phys[node]);
-- 
2.26.1

