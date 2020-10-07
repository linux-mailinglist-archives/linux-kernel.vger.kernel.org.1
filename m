Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84EB5285720
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 05:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbgJGDhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Oct 2020 23:37:20 -0400
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:11688 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725981AbgJGDhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Oct 2020 23:37:20 -0400
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0973PO8B008596;
        Tue, 6 Oct 2020 20:37:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=1ITdd9asQb8TjqHkOHTAFsIRRiv1VFYllpn6d4xD5Bg=;
 b=smYPOubLMDkA8LXF51XtUmK2XDeKYd+4V21/1zu9VYzd5SkQ8AVnaqa/lbPmKJ2osTET
 PSfFvGGK2lK5jWN838XUtQu2VQwvPrrLCEDgrJT3lBCLZ/6x1Dp7jEcSobdPmWpQaN+J
 6XJqzGck+DuqyNBkHYQlnciuJKucRoBlNSjjM4T3j2nskP2VWoWPr4IpVexaj1FFOgTm
 R42P2XIxWLcf3ce+Qh1LHEqqbMOMF2YNrX84YNGRL8Pda2awybbCuIUdIkcSfFlojj90
 i7sXtTP0Ddpl8rulAlVVD5so6S1eO9q35k31UINETlF90DZsJXznK601Y8xPalYnDhRF cA== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2103.outbound.protection.outlook.com [104.47.58.103])
        by mx0b-0014ca01.pphosted.com with ESMTP id 33xmvyc3gp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Oct 2020 20:37:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ENak/iNpHmstVxGy6zVJT4IgfFOv83vH6KqqUXskU71pCBUHCbZgaLu9iMkygD5o/MtYU1WUTolRbz+8YJ6P9pN93/ne5D/7LnQT/lEuaGJhWxcq7hEKB8C1/8ds6d9fCLx5dhnmQaUJ6pziA8WusX5u7kVzhwFaYc54WwC4t1Ty6uFtYPjd5hMDAnPL2xg+bZenw4cvhD3Wzm+Dea45vLZ638lAeKlQY3U3w9x2Xr2MNH9pDai0O9iao/+n2ydz6HCwnk5kCTmcXHHTFUD3Jw20+ok1/3G4dE2DEvewlcPkxNo7v2R6+b+AXKNA3V8Moc7DRMe/V17U1U2po4ylaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ITdd9asQb8TjqHkOHTAFsIRRiv1VFYllpn6d4xD5Bg=;
 b=cJoeI9M8vigtNxBS+pSMW/xNMv0nm4pY3jB81nTEVgx534Q+jRCD6pjXzVxOTseXyiQNVhqajKq2Ke9iDQQ+t8IUx14LqHYChurNA2b376FFojApyWEH6x7bdcvm9FhxNW/6KZgq5wyGqNvAMGynEzsjGLyWxLnCgFz1R8s3VXkdT87iVXVwYDYwPlzYRQ3VoWOCSm2kLZRgwlPTjJJyOlJ0DmkwbzQ1lMp6djZ5qoaQo2NlJIjjLNFvfC02l0GXmQ3he35KgsbEOYVskKT2sgrHeRS+U1P5hQyPFK0Z4VgFKSh4KQO8+72SGH/msn6AwxHRf+ckrxOHlQBE85IjkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=cadence.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ITdd9asQb8TjqHkOHTAFsIRRiv1VFYllpn6d4xD5Bg=;
 b=y1lGj4bsRUWdf3CKkfeI/SF2GQBLx15jgXBwNBPd6iyfPC/tGzDrxd0dxZjnZC2mtx3Hdx3Dpm8KVSMOcI7wtTVW6VbrC6fr2XKGyCUWtBVuV1tHY5yJf/R122XKfKNJBt0CVaFzxT2qAF+PAl3GwMATQ3VrySxDO2M/gmzUwVE=
Received: from MWHPR21CA0030.namprd21.prod.outlook.com (2603:10b6:300:129::16)
 by DM6PR07MB5307.namprd07.prod.outlook.com (2603:10b6:5:48::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Wed, 7 Oct
 2020 03:37:11 +0000
Received: from MW2NAM12FT039.eop-nam12.prod.protection.outlook.com
 (2603:10b6:300:129:cafe::23) by MWHPR21CA0030.outlook.office365.com
 (2603:10b6:300:129::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.6 via Frontend
 Transport; Wed, 7 Oct 2020 03:37:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.147)
 smtp.mailfrom=cadence.com; ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com;
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 MW2NAM12FT039.mail.protection.outlook.com (10.13.181.39) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.13 via Frontend Transport; Wed, 7 Oct 2020 03:37:10 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 0973bAEV031154
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Tue, 6 Oct 2020 20:37:12 -0700
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 7 Oct 2020 05:37:05 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 7 Oct 2020 05:37:05 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 0973b6AH022913;
        Wed, 7 Oct 2020 05:37:06 +0200
Received: (from pawell@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 0973b5cp022912;
        Wed, 7 Oct 2020 05:37:05 +0200
From:   Pawel Laszczak <pawell@cadence.com>
To:     <balbi@kernel.org>
CC:     <peter.chen@nxp.com>, <rogerq@ti.com>,
        <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kurahul@cadence.com>,
        Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH 1/2] usb: cdns3: Rids of duplicate error message
Date:   Wed, 7 Oct 2020 05:35:31 +0200
Message-ID: <20201007033531.22526-1-pawell@cadence.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5da315c6-d27d-42ff-f373-08d86a724600
X-MS-TrafficTypeDiagnostic: DM6PR07MB5307:
X-Microsoft-Antispam-PRVS: <DM6PR07MB53072732B8A85936E6903D11DD0A0@DM6PR07MB5307.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:972;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MVuyd5uEOZ8G41bs6mDNb3g5J4baIPPM91ZJy+A8ZJ3yIs6go42OhRCjZrO4Y/ME9yULg60dDT0Tv3H/s8+LMVpllEhkAaqueUFfqBidX30HCXuyYul2sbF6NVaFl6UcL1xFeawfaR5Zyv5jA3N42cfcyvhBPFDJyVpYzkEunMc+Fv5aBJmgwGKKyxJ0SoOZIrxrcf2zTDYyjRIQH1MyCUT4tdsGj8el0MQALdgnEA0OMRU42ozdYdjp4baEkI9NyLCLct2yolj6U40fitlWtr+mxaq4QeTsUM92Fw/GwBThONs1NqRPRv3pZrZ7Uisi+YUrWIhBPGX5ckfR1HUvHbq7DDQsByhjj4XbtvXG069if8FyTJfGSdHRkoU2JNQq7v9C9xg056oOaqz48IRlriVdTJvpnCL5146cv6/bMYY=
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(136003)(346002)(39860400002)(396003)(376002)(36092001)(46966005)(7636003)(2906002)(70206006)(107886003)(26005)(8676002)(83380400001)(36756003)(336012)(186003)(5660300002)(1076003)(6666004)(8936002)(47076004)(6916009)(86362001)(70586007)(316002)(36906005)(82740400003)(478600001)(42186006)(82310400003)(54906003)(426003)(15650500001)(2616005)(4326008)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2020 03:37:10.5439
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5da315c6-d27d-42ff-f373-08d86a724600
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT039.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB5307
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-10-07_03:2020-10-06,2020-10-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 impostorscore=0
 malwarescore=0 clxscore=1015 priorityscore=1501 phishscore=0 spamscore=0
 bulkscore=0 suspectscore=1 adultscore=0 mlxlogscore=700 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010070022
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On failure, the platform_get_irq_byname prints an error message
so, patch removes error message related to this function from
core.c file.

A change was suggested during reviewing CDNSP driver by Chunfeng Yun.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/cdns3/core.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/usb/cdns3/core.c b/drivers/usb/cdns3/core.c
index a0f73d4711ae..4fd3c742d9d5 100644
--- a/drivers/usb/cdns3/core.c
+++ b/drivers/usb/cdns3/core.c
@@ -469,9 +469,6 @@ static int cdns3_probe(struct platform_device *pdev)
 	if (cdns->dev_irq == -EPROBE_DEFER)
 		return cdns->dev_irq;
 
-	if (cdns->dev_irq < 0)
-		dev_err(dev, "couldn't get peripheral irq\n");
-
 	regs = devm_platform_ioremap_resource_byname(pdev, "dev");
 	if (IS_ERR(regs))
 		return PTR_ERR(regs);
@@ -481,10 +478,8 @@ static int cdns3_probe(struct platform_device *pdev)
 	if (cdns->otg_irq == -EPROBE_DEFER)
 		return cdns->otg_irq;
 
-	if (cdns->otg_irq < 0) {
-		dev_err(dev, "couldn't get otg irq\n");
+	if (cdns->otg_irq < 0)
 		return cdns->otg_irq;
-	}
 
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "otg");
 	if (!res) {
-- 
2.17.1

