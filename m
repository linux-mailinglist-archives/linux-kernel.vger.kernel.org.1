Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B7E72B7F01
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Nov 2020 15:07:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbgKROEb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Nov 2020 09:04:31 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:57358 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726544AbgKROE2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Nov 2020 09:04:28 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AIE0p3R027548;
        Wed, 18 Nov 2020 06:03:48 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=YeTdZFFc+jHIMZV0VWlLPUetVn3VbdrzqvGoeYcWbkg=;
 b=Nb9wC6kke39P68wSLaWa5rLGzfomzuv61/O0QahfduvF1xDSn3m6eHu1NfKGb/OYRrqJ
 +shYX6GmhzmkViJW0I7a6E88bHI3OzeI1jxj5PyBGVBfSQ4eKRVRoVNJIP7fMKwPnUUm
 gKp3rCVtIuRlPfAan5HOwUDBcgTefC8VYcTVxiIqztLpLofH7xBtrUIvWVJsks1IqKix
 yhBOlKWQR+O0Rb80hOG19OPwM8l1JosTZqTVrXCtH5+IPAnrWob/Go3R/iy68nt7p/yk
 aF7KTnILZfJQAKkn+yEp83EuQWQcRW1dLonwYjTa1HUnB5Jqk6oBG7L0QDj4Cd9qNbSf HQ== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by mx0b-0014ca01.pphosted.com with ESMTP id 34tbq2yv9h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Nov 2020 06:03:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KOwsgKhjLGB8ARpYocOh2usxBWBZZRQZfI1OOEOdZRFIOmQxStp7tC8qfOOh1y6JIcEGloyUpbjY2VQC82FPiy60G6dop37OYU3fJXqtlebSvXxL9J3p3oSu2P3L74GQgfhp0+hSTktJjz+EfXLCjeHM6B8qjywVJbMZE7xiiDLYRnpA4sQD2Bj+BTPteQo2+op0vbbtgmuE8aXkEfY7TywB0YMIpUrgglYmyuYwFBGzm2GEHLu4qvjYaCjWVIAP6aPo5XwD4CXm1PmyvWbwu/rmFr1hlyxqdqKX68mVwf+SyJCOU+ojV4TFvdeysCRBk6D6eTJkbECq9f/XZ78U1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YeTdZFFc+jHIMZV0VWlLPUetVn3VbdrzqvGoeYcWbkg=;
 b=TBH8Sg2Xb2VvQUNikBIHsBw6sjWFlO/Yq+vCIw+6P2+lpJaGeZkuuzi0MwUq7rQFAyW6hfArqHFDehiBn85YKzWsfjKbhfb/xYQuFBElk/WeV64gUMbcj4CR4w1r+zUfS9PUBE30VCnx9k4NvBBV22TO1aO/szBhGiMHnjCC5whXldCYXK/umlR6PkzRvc04zEyD9BhTeC+bjcW5/Lj61x1CAryyVJe+XXekOmdxYrJ2abBSI3rD5gJ84qhHcp/JCm/SnAWmKGdkzhsPkRdQmTHsXF8WxlL7JpQ3S1JPcLPhgaEMvZ8XV9mq8Z6+ljNVtxC0F+mDAJGJBPokcjtNEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=ffwll.ch smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YeTdZFFc+jHIMZV0VWlLPUetVn3VbdrzqvGoeYcWbkg=;
 b=O6JUGSXo+qag3H8SNZeJ0b37zZacz8SErMTJqyWay9f3Pgzqtqb9NBjy4VpurrWKT/sdWHG5UZBqrAmpzJ/bAbV5OeO5DvTDSC3j48fFjcvf/E2msSH7CFW8QcbqBLkLvNjvkf+if5y8ZbF+JaMVjIA0/z9vLr/xWh4RQYWJYpM=
Received: from MWHPR01CA0043.prod.exchangelabs.com (2603:10b6:300:101::29) by
 BLAPR07MB7508.namprd07.prod.outlook.com (2603:10b6:208:29a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.21; Wed, 18 Nov
 2020 14:03:45 +0000
Received: from MW2NAM12FT025.eop-nam12.prod.protection.outlook.com
 (2603:10b6:300:101:cafe::55) by MWHPR01CA0043.outlook.office365.com
 (2603:10b6:300:101::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend
 Transport; Wed, 18 Nov 2020 14:03:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.147)
 smtp.mailfrom=cadence.com; ffwll.ch; dkim=none (message not signed)
 header.d=none;ffwll.ch; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com;
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 MW2NAM12FT025.mail.protection.outlook.com (10.13.180.92) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.11 via Frontend Transport; Wed, 18 Nov 2020 14:03:44 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 0AIE3dUp007561
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 18 Nov 2020 06:03:40 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 18 Nov 2020 15:03:38 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 18 Nov 2020 15:03:38 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 0AIE3btS003739;
        Wed, 18 Nov 2020 15:03:37 +0100
Received: (from yamonkar@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 0AIE3S6W003729;
        Wed, 18 Nov 2020 15:03:28 +0100
From:   Yuti Amonkar <yamonkar@cadence.com>
To:     <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
        <maxime@cerno.tech>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <mark.rutland@arm.com>, <a.hajda@samsung.com>,
        <narmstrong@baylibre.com>, <Laurent.pinchart@ideasonboard.com>,
        <jonas@kwiboo.se>, <jernej.skrabec@siol.net>
CC:     <nsekhar@ti.com>, <jsarha@ti.com>, <tomi.valkeinen@ti.com>,
        <nikhil.nd@ti.com>, <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>
Subject: [PATCH v2 0/3]  Add bus format negotiation support for Cadence MHDP8546 driver
Date:   Wed, 18 Nov 2020 15:03:25 +0100
Message-ID: <1605708208-3692-1-git-send-email-yamonkar@cadence.com>
X-Mailer: git-send-email 2.4.5
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 91a5ee39-a37a-42c6-e2f2-08d88bcac31d
X-MS-TrafficTypeDiagnostic: BLAPR07MB7508:
X-Microsoft-Antispam-PRVS: <BLAPR07MB7508B92E55BE2A508DC2A495D2E10@BLAPR07MB7508.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /eWfURBRRvmVgVgVo44EAxue7kZdO2AU9eEXO0HXSlYEeLpUX/1unVHUAp0Pbuo0j0OUL38eIQVweymC5UDTt0IZMQPPZUq2jiIkbfaXs8xUb5xfiTthkm8eCVZcUryp7oY4sshNOhmuRCey51Vd7bUfXRVagZayLBUvFSuWqgJs1aMYx/71zAzczd1qzu546P4ZmLnU+x/L1BQLn/UQNM/tAyNx/jqFIrATGoHAvhNYOAZiZCB+VQSDjLKDFBNn9+q3BLd/lo70ZUg2MHTfCPIQ0Ep/41Z3Kx4i/kjdEWoKiusFWbstbBCb6dgMPpQBRliN6x9Ot4Qwg5ZULyVLBqZl4AjkYW1Ztsxm2TDzrmwQGTW/lrhBIgEXko3JjTz+zZERQ7gzWn4988E82X+UFPUe4Ri5B04cKS4wBkUF8Wa/pLu3EwTlAMRXhUhTxrGcNL2hi5gTThorbqDAWFYI0FV6aFtrf8mRpqwovSkWPjgp6+zQ56PXWe79S4u/GBN5ofZK+qR1x4jz8YjtV+zllp2aFdl4189W+IoteMGpLw1mE1NPglBUfs3galmZSuRo
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(136003)(346002)(376002)(396003)(39860400002)(36092001)(46966005)(4326008)(82310400003)(8676002)(7416002)(2616005)(426003)(36756003)(107886003)(336012)(316002)(42186006)(186003)(6666004)(921005)(478600001)(5660300002)(8936002)(36906005)(47076004)(86362001)(82740400003)(83380400001)(110136005)(54906003)(7636003)(356005)(70206006)(966005)(2906002)(26005)(70586007)(2101003)(83996005);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2020 14:03:44.5485
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 91a5ee39-a37a-42c6-e2f2-08d88bcac31d
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT025.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR07MB7508
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-18_04:2020-11-17,2020-11-18 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 clxscore=1015 phishscore=0 mlxlogscore=999 spamscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011180099
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series add bus format negotiation support for Cadence MHDP8546 bridge driver.

The patch series has four patches in the below sequence:
1. drm: bridge: cdns-mhdp8546: Modify atomic_get_input_bus_format bridge function.
   Return all the input formats supported.
2. drm: bridge: cdns-mhdp8546: Remove setting of bus format using connector info 
   Remove the bus format configuration using connector info structure.
3. drm: bridge: cdns-mhdp8546: Retrieve the pixel format and bpc based on bus format 
   Get the pixel format and bpc based on negotiated output bus format.

This patch series is dependent on tidss series [1] for the new connector model support.

[1]

https://patchwork.kernel.org/project/dri-devel/cover/20201109170601.21557-1-nikhil.nd@ti.com/

Version History:

v2:
 - Remove the Add output bus format negotiation patch from the series, 
   as we use ouput format as MEDIA_BUS_FMT_FIXED and that is  the 
   default value if atomic_get_output_bus_fmts function is not implemented.
 - Return NULL if output format is not MEDIA_BUS_FMT_FIXED.
 - Return the supported color formats based on the display info structure.


Yuti Amonkar (3):
  drm: bridge: cdns-mhdp8546: Modify atomic_get_input_bus_format bridge
    function
  drm: bridge: cdns-mhdp8546: Remove setting of bus format using
    connector info
  drm: bridge: cdns-mhdp8546: Retrieve the pixel format and bpc based on
    bus format

 .../drm/bridge/cadence/cdns-mhdp8546-core.c   | 133 +++++++++++++-----
 1 file changed, 99 insertions(+), 34 deletions(-)

-- 
2.17.1

