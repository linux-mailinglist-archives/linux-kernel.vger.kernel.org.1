Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 240612B944E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Nov 2020 15:16:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727825AbgKSOPJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Nov 2020 09:15:09 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:31558 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727678AbgKSOPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Nov 2020 09:15:07 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0AJE91hP001984;
        Thu, 19 Nov 2020 06:14:40 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=FiBIkpXX9B77Grj6EK90zxrdEx+VMwrtk3r3vTlnwFk=;
 b=X39ejmHJ9qlEWo6IH9p8qilWMgeVsjbcDGZpPZS47FsqsIg/y77fcXNpk+DMrDnSn4ro
 JUxImZO4/9EeIFErxh96e9Sphfo8cZP+wUuPMJE364Vpc5u1hRTUcuf5Nrkqr2Jz5NTQ
 q7D4IoOIZDflQ0AxksaY/Xp9esaNfe8S8ZKC2qCHh2CFE1oTnCcQ8KBVCD48Krpvknyr
 KMYMI6Z702Umtu3ZOGNURjlKO19FTA4EVxYNsxQJuSsOqbnpWsJ9e7lNBxn/4DSsp4pp
 /8jx/oyYyAzHYJpHlV14vB97Levsddt7iZX/hK0JU5TITWJ7OkEVdAYH/Qw9I7gp5Gzo dA== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2041.outbound.protection.outlook.com [104.47.66.41])
        by mx0b-0014ca01.pphosted.com with ESMTP id 34tbq34yt9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Nov 2020 06:14:40 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TVt2fNprRcxRLsSSNwX3N/+mmcSa48OqBaN1iRhsxH0E8UTBI/FEpr6Se7VIu11uxVuolJwPtgmrjg/WyENlckoQRQFkZmq6f3+Ze/XmnjosOpKZrpi0ZekRFFC07pbJDqHgZS8Y87XxXv0+YZGZYx3MW2ejUfm1Qmct2KNnIy6pCCbaDslLUpc1yAcQFxSl6ZtH4cfB7f6ap9p5p9r2/+Z5xoGCmHyVQQf2W9CC6lTHa6q4n7huWxq4znPZDLl+49FaUkxTpDLSD2d+8utWp6LY5iLqew9evNg6ZR+Bg1rh/fwmJsnZcPpv6ydJpSSyDwT/KCDtyRCyfMnnlFP8bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FiBIkpXX9B77Grj6EK90zxrdEx+VMwrtk3r3vTlnwFk=;
 b=O5qYpf9rwmvlZ6DQvkmvWeYITv++TexY1j38Zol5GDOuJALNgQHD6AzR294zxIF/JkWnSHf6QOzR9RNPK+Lk8xlwnuEcFEgJqNpmYj8nB086gppXbPcwHOPvX3ZSdr/oJETfztSypr9BTU0VP//xHO1QjH07H6CR/IvnMcC3TD+ZglfjwyWtzuW7AYLMDa0jIM5+zw5b1U8k+Q5tbS7c82B1b/Hx/l/3fxCzSx0/yl9Tf2rM1dUjwk1tQDJu9QsJVZ7rq0iA2fQ9IB7vRylyp0tjdjxYrbRpnwjCCJl0d0OZRg3ijNCZYgSNmFQSK3nT3R9NC2lRVJtEJnOapkiD3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FiBIkpXX9B77Grj6EK90zxrdEx+VMwrtk3r3vTlnwFk=;
 b=IdEF9qcLzCxP1UcVLqHUQUhCqmYEP24KUTRGbsBg4Fg6ORs+dHe0ljuqk/+lNLbfHc7uucbYBH8XXdWxQ3lZfKMHS56nwRCgr1JjrryKwgVK1nTREyxVfJZHQGPZHeVkm9Ul9fd2AejMhevtEH3rWX95tW0N8iafWZHP3UaNXpY=
Received: from BN6PR14CA0047.namprd14.prod.outlook.com (2603:10b6:404:13f::33)
 by DM6PR07MB5292.namprd07.prod.outlook.com (2603:10b6:5:45::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3564.28; Thu, 19 Nov
 2020 14:14:36 +0000
Received: from BN8NAM12FT019.eop-nam12.prod.protection.outlook.com
 (2603:10b6:404:13f:cafe::f7) by BN6PR14CA0047.outlook.office365.com
 (2603:10b6:404:13f::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.20 via Frontend
 Transport; Thu, 19 Nov 2020 14:14:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 BN8NAM12FT019.mail.protection.outlook.com (10.13.183.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3589.11 via Frontend Transport; Thu, 19 Nov 2020 14:14:36 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 0AJEERJC022418
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 19 Nov 2020 06:14:35 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 19 Nov 2020 15:14:27 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 19 Nov 2020 15:14:27 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 0AJEERhX011800;
        Thu, 19 Nov 2020 15:14:27 +0100
Received: (from pawell@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 0AJEERSg011797;
        Thu, 19 Nov 2020 15:14:27 +0100
From:   Pawel Laszczak <pawell@cadence.com>
To:     <peter.chen@nxp.com>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <balbi@kernel.org>,
        <colin.king@canonical.com>, <rogerq@ti.com>, <kurahul@cadence.com>,
        <nsekhar@ti.com>, Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH v3 10/10] MAINTAINERS: add Cadence USBSSP DRD IP driver entry
Date:   Thu, 19 Nov 2020 15:13:07 +0100
Message-ID: <20201119141307.8342-11-pawell@cadence.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201119141307.8342-1-pawell@cadence.com>
References: <20201119141307.8342-1-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5ece1b76-5167-414f-7047-08d88c95721f
X-MS-TrafficTypeDiagnostic: DM6PR07MB5292:
X-Microsoft-Antispam-PRVS: <DM6PR07MB52928300CC3B19B64906CD40DDE00@DM6PR07MB5292.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:386;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: BGoI1oEWaIzaKVCD3DfS9um534IhumNmkuKdpqiEGolooOiRARtM0zXuL4rIF3JFWis4bhKSrPWEuZOGdcqcdzvVcBXotc0kvZrXOxZIr/fMhwnrCY4GKJoBH+25f5fM+y2aEEEi6fAJ/N/LDFXkK4WEyz1RxBg+drL7v3i7weZpbEGOSGHXRnp82Fp/xgvMty3ivhZ+BOqMg4uk/csu2g2IbSEmTTchHeH0ctIA6rKzfm6bKpKOaD1DCSbiTd4wPLj+PlBVHRTXLedSfIB+WAIfGsK7p6TRUuM2OgCLP6vcRwePJwC0etn7XT7wqI1h4xvrOGiV+9Blx+PBHYBDUCN2hjaUGYH4vOL6ETCYwVmFz/PByAs1C+9148mJfhB/PPHKucMV1b7xxGhfYivzkUPO4QG1E3gH0CsDwfQyv/I=
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(376002)(346002)(39860400002)(136003)(396003)(36092001)(46966005)(478600001)(6916009)(26005)(2906002)(70206006)(82740400003)(47076004)(7636003)(82310400003)(356005)(36756003)(426003)(186003)(5660300002)(42186006)(6666004)(316002)(336012)(4326008)(36906005)(8676002)(8936002)(86362001)(70586007)(54906003)(2616005)(107886003)(4744005)(1076003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2020 14:14:36.4164
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ece1b76-5167-414f-7047-08d88c95721f
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT019.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB5292
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-19_09:2020-11-19,2020-11-19 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 clxscore=1015 phishscore=0 mlxlogscore=575 spamscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 adultscore=0 malwarescore=0
 suspectscore=1 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011190107
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch adds entry for USBSSP (CDNSP) driver into MAINTARNERS file.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 842fef329119..70c31fd2cd61 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3867,6 +3867,14 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/peter.chen/usb.git
 F:	Documentation/devicetree/bindings/usb/cdns,usb3.yaml
 F:	drivers/usb/cdns3/
+X:	drivers/usb/cdns3/cdnsp*
+
+CADENCE USBSSP DRD IP DRIVER
+M:	Pawel Laszczak <pawell@cadence.com>
+L:	linux-usb@vger.kernel.org
+S:	Maintained
+F:	drivers/usb/cdns3/
+X:	drivers/usb/cdns3/cdns3*
 
 CADET FM/AM RADIO RECEIVER DRIVER
 M:	Hans Verkuil <hverkuil@xs4all.nl>
-- 
2.17.1

