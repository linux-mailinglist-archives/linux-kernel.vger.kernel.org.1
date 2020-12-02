Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33E842CBE4A
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 14:30:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730131AbgLBN2A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 08:28:00 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:49312 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727050AbgLBN1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 08:27:22 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0B2DObdQ002317;
        Wed, 2 Dec 2020 05:26:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=tg944ps/D8C40bDmjRj+9ncqwV3GhxVVe8KoYOQN3eQ=;
 b=e+5UwbYZDvI559nAyKdtjfVAcxOvi1YwJ5Lm6FtNntwvx+L9pHFRP6QucELTOS6pJQSq
 8Y5yQPaPRHTluKtqnyeN/Deg8YWrFc1nOc98LE2691DQuc+m7xx3MgL46lduhlU5/sE4
 hT+OLW71crKwyJmGwVOo4vffuv7If/nTULEexPhKG2QZBeMNL8EHDioejoOd4zRgGalS
 z5/r2sP6mU48tqGCmj7STuC7BIk8t5QdbluG19LeX3Dmc5ZgTnYsnpKCFhxubcOOoHFN
 Ul0ZZOd/C1F5ufxSRrdolVdmoRB5nn32IrjyiDT8oUy9CgJLBhpQKuCQ73qOKYLG/Wqg 2A== 
Received: from nam02-cy1-obe.outbound.protection.outlook.com (mail-cys01nam02lp2057.outbound.protection.outlook.com [104.47.37.57])
        by mx0b-0014ca01.pphosted.com with ESMTP id 355vn6aph1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 02 Dec 2020 05:26:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iqGlLV1e/xbiNJZEATXd+SHhiq08iL6GrPN7XlI3q8S8CQozHU+GsYXDD3kZs77I9VCHK7QQhbMyE6Dt1qOIFTvbzDLLBk8mR0AwD3axAeEdRUiAIKw6fDUM/ctwreRYRT/O6fc9NUaaCRRCjuPGsFxqp6RpLqg15OqXu7uMkya0eogWuIQ88GYD6C3Xq/0ZDzSJEWY8NjXl9a/smPL0OojI1DghplTZldXqW/dum932F/V3u/5HwJtW4jK4b2iB/jeF1IQD66HvoicTLzg6OtU7AxMZYbtZNEP8vp7oOePefec1E76SzxvjPAK0zeCdbJmgyncY+vMJ27fbb122Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tg944ps/D8C40bDmjRj+9ncqwV3GhxVVe8KoYOQN3eQ=;
 b=ljKsZFXitnGsc8JWdWuapACV0d0/YUGQNlcdY0DgQ3+G7Zn3friQzxTa6auaZ/aTK69rUFO/s0AgWc+0tFSUJ2dO3007Mfth1/Yn8i21SanrQ/PK3r82gzKm0An5rRKFRCzhuF0LUSRDmAoD0OCkoysCM60c1GmUYSeTiJKceTJK6ntV4L7kbc7QzXI3gUiK5mAkAheDrnqWWZE/fF71EVL7cTPHFmseJxDPzm5Tcc7TgeDgiMKlEsFPDEeYu2rEq9L3yNwMNCUhLOvSxVL02Zy0LvPVqpxH6IWRK7s40iiJkFXUSL3mMXCbEKfpjNcw5Vs40NVQS8N9xwAuljL8aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tg944ps/D8C40bDmjRj+9ncqwV3GhxVVe8KoYOQN3eQ=;
 b=OelIvqI1PhC7nRpal6E70SKQc1kaDwwI/p9YWdghjdYoMPETQRlOnc8a1Z9CaVHv1i1t4w1GJ8epTDwd7VxcWxCND6U4Lh4RaG/czXZnM6eczPCXGc+quJyj6aLmFjFXHbkLSjHFyPv2Hu99aGH1Q9jaWksYKbc60PWmazkioQc=
Received: from BN9PR03CA0206.namprd03.prod.outlook.com (2603:10b6:408:f9::31)
 by BYAPR07MB6805.namprd07.prod.outlook.com (2603:10b6:a03:126::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Wed, 2 Dec
 2020 13:26:16 +0000
Received: from BN8NAM12FT037.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:f9:cafe::72) by BN9PR03CA0206.outlook.office365.com
 (2603:10b6:408:f9::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.18 via Frontend
 Transport; Wed, 2 Dec 2020 13:26:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 BN8NAM12FT037.mail.protection.outlook.com (10.13.182.128) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.11 via Frontend Transport; Wed, 2 Dec 2020 13:26:15 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 0B2DQ6oG007337
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Wed, 2 Dec 2020 05:26:14 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Wed, 2 Dec 2020 14:26:07 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Wed, 2 Dec 2020 14:26:07 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 0B2DQ7eK010827;
        Wed, 2 Dec 2020 14:26:07 +0100
Received: (from pawell@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 0B2DQ7t5010826;
        Wed, 2 Dec 2020 14:26:07 +0100
From:   Pawel Laszczak <pawell@cadence.com>
To:     <peter.chen@nxp.com>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <balbi@kernel.org>,
        <colin.king@canonical.com>, <rogerq@ti.com>, <kurahul@cadence.com>,
        <nsekhar@ti.com>, Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH v4 10/10] MAINTAINERS: add Cadence USBSSP DRD IP driver entry
Date:   Wed, 2 Dec 2020 14:25:48 +0100
Message-ID: <20201202132548.10736-11-pawell@cadence.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201202132548.10736-1-pawell@cadence.com>
References: <20201202132548.10736-1-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 592f2586-f6f6-47e9-727b-08d896c5d8a9
X-MS-TrafficTypeDiagnostic: BYAPR07MB6805:
X-Microsoft-Antispam-PRVS: <BYAPR07MB6805C75FF3F99DDB4A1C05E9DDF30@BYAPR07MB6805.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:386;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WvRAPpFrsYhmVrwNh7uFTO5SditQGdfgmcT0hMfc8ZHMjMH/0iPQrPyI+2v6IcTzLvbFJXO4w3Lvw0r9S3JwUEuWxDaN/85nDrTl+2M68KartflDgjmJ+xUQY/65nzmWC9moHsBWh3Qz7Kh5+EKdMBHHNBAHwbiHVtlKJ/0GISu1G4VwCPb9luWB6mfZD0xzt6meO0XhpbxmvGtYIIxHMLVW7hPjyMu1HQnblaTIgR7ND8gQdVMZT5zHqjVcpywXthFL1fyQVwt61HEKTen1p1szWwbsx8Gj/7Kt1F5nHnjxsqxleSDGIIZ2NSvtMCpAdgG0uJpoCScdtNCP0zvwt3NZOZTgVoEkq0kuCZHb0/y/AuoO5A5yDzB7ryN8C2l0Z6Ii30HnrUFsabAmfSnC8iQJG/FIgS0TmRaR8W91b5w=
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(396003)(346002)(39860400002)(376002)(136003)(36092001)(46966005)(4744005)(336012)(36906005)(42186006)(86362001)(26005)(2616005)(36756003)(6666004)(2906002)(426003)(316002)(5660300002)(186003)(82740400003)(1076003)(8676002)(7636003)(4326008)(8936002)(478600001)(6916009)(107886003)(47076004)(70586007)(82310400003)(54906003)(356005)(70206006);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2020 13:26:15.9323
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 592f2586-f6f6-47e9-727b-08d896c5d8a9
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT037.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR07MB6805
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-02_06:2020-11-30,2020-12-02 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxlogscore=619
 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0 mlxscore=0
 suspectscore=1 malwarescore=0 phishscore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012020081
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch adds entry for USBSSP (CDNSP) driver into MAINTARNERS file.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 213b92ffe891..255390789176 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3859,6 +3859,15 @@ S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/peter.chen/usb.git
 F:	Documentation/devicetree/bindings/usb/cdns,usb3.yaml
 F:	drivers/usb/cdns3/
+X:	drivers/usb/cdns3/cdnsp*
+
+CADENCE USBSSP DRD IP DRIVER
+M:	Pawel Laszczak <pawell@cadence.com>
+L:	linux-usb@vger.kernel.org
+S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/peter.chen/usb.git
+F:	drivers/usb/cdns3/
+X:	drivers/usb/cdns3/cdns3*
 
 CADET FM/AM RADIO RECEIVER DRIVER
 M:	Hans Verkuil <hverkuil@xs4all.nl>
-- 
2.17.1

