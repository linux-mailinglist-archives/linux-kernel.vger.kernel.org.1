Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D69AE2D0E4B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Dec 2020 11:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbgLGKmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Dec 2020 05:42:12 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:62554 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725794AbgLGKmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Dec 2020 05:42:10 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 0B7AbJxp007280;
        Mon, 7 Dec 2020 02:41:08 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=tg944ps/D8C40bDmjRj+9ncqwV3GhxVVe8KoYOQN3eQ=;
 b=iG2KCOwF6t5XZhomJBtU7pkwS71TuVESnK5w6s8eUCYVukHDTof71rTusGr46CeM9i/R
 faXDkj74DNZCaL5LGAegZVzK97mFz9YISFbsH/lguZI3VrRz/x6V4zdfQJsLUCAwDQ4g
 SBO8wMHXdBKDlXf7kKt8B1DBXPKNrkjb35gutpANnscIp+sq5cC9p8ZjCvQ6Jx62Ug4K
 +Omixhjh8mQLnpX4ILbd36zvQ9QYdQ3UPGoAaDKsEgPds4nMuz97GsB4d47JrxfnqXnw
 cgAPf8uZDtxViPhFs0mlVf8GJ+xlpM/FoyWsnTU6OKe32cngl3Cij8X5+eyUBR2OyePe Fw== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2175.outbound.protection.outlook.com [104.47.58.175])
        by mx0a-0014ca01.pphosted.com with ESMTP id 3587n2m7yv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Dec 2020 02:41:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P7WjVaHl6Z1Q3AQ7bhblXQi2sKo0ZchJbY6NshvJwJ68cVJF0+Ol8Z9/cDK9Fb6IK+IKajT0Mw2gK4SpAEHnPnffM9W2IcodGEdq2uUxLUsSmQsJxw8sP0PL19b0LL6S2ls92zEjSIjeq5TdHIBBXtqpD95LgYGSYhAJJL1FLVwqkV3wc/BNcupk3wQG85ztHwZHcIVI6qJ6eBAFrgmb38qakUFt0WakT70Pvp0V0VGeX/bD+oJo/1oNKIAI1TxcMSgQGdb8HPE8O88yVd0WuMU9U+QIAsGhLRoK+5hxz9TONxYtbi3zQhdoZcAQK5afDpdLejNhSbzDfqin0dXJXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tg944ps/D8C40bDmjRj+9ncqwV3GhxVVe8KoYOQN3eQ=;
 b=QfHkcoafv+MlhKYp9iv63vNaOQGTmC0HDQJ0Ee0cjU3GipmXuXAaOlagz2AYlCtz0ZiG9y81St/Djbw4PHWICPsRPWyIQjriW2NUsIVcn+mRAiXvoxKzldrI6twT/X0diYio1alKxYQToo1BBfadz7CyqMbytpNAA5uBfKMvQ52WNXBrnb7Il2bPsWznvNAhflUDpB1ZLIys6eIsC84atsEVXmKwfnxgHzpUAlJcc5PtGAG8WAlC2b48snnRSelSyZfJJfyqOY+tXoXcLS7x3RQJHyMRoAVThU6Safxzwlgx9Z1fIlWKTjsb8W9o/FtDGl0gEBxs2TaR+5ONGzTREQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.148) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tg944ps/D8C40bDmjRj+9ncqwV3GhxVVe8KoYOQN3eQ=;
 b=0dnHHNqQOLu/MhCWSxpdKWfmQhcMrhSIT5wriXxgiDN56jSSBNiCIsaiOSqikLhvnoegb33nuPkZSZtDtLYoq9PKtX/DD75SGZuZas6B9Gz3PCZTByvuJvF8uWlsvYgbeeO4lo7XpQWBjmoEeuMm/RyletqDt5qAMngic7ZIfzU=
Received: from DM3PR03CA0006.namprd03.prod.outlook.com (2603:10b6:0:50::16) by
 SN6PR07MB4238.namprd07.prod.outlook.com (2603:10b6:805:60::23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.17; Mon, 7 Dec 2020 10:41:05 +0000
Received: from DM6NAM12FT016.eop-nam12.prod.protection.outlook.com
 (2603:10b6:0:50:cafe::a4) by DM3PR03CA0006.outlook.office365.com
 (2603:10b6:0:50::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17 via Frontend
 Transport; Mon, 7 Dec 2020 10:41:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.148)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.148 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.148; helo=sjmaillnx2.cadence.com;
Received: from sjmaillnx2.cadence.com (158.140.1.148) by
 DM6NAM12FT016.mail.protection.outlook.com (10.13.178.217) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3654.10 via Frontend Transport; Mon, 7 Dec 2020 10:41:05 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx2.cadence.com (8.14.4/8.14.4) with ESMTP id 0B7AeuTB007278
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Mon, 7 Dec 2020 02:41:04 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 7 Dec 2020 11:40:57 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 7 Dec 2020 11:40:57 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 0B7Aevij006460;
        Mon, 7 Dec 2020 11:40:57 +0100
Received: (from pawell@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 0B7AevYo006459;
        Mon, 7 Dec 2020 11:40:57 +0100
From:   Pawel Laszczak <pawell@cadence.com>
To:     <peter.chen@nxp.com>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <balbi@kernel.org>,
        <colin.king@canonical.com>, <rogerq@ti.com>, <kurahul@cadence.com>,
        <nsekhar@ti.com>, <a-govindraju@ti.com>,
        Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH v5 10/10] MAINTAINERS: add Cadence USBSSP DRD IP driver entry
Date:   Mon, 7 Dec 2020 11:32:27 +0100
Message-ID: <20201207103227.606-11-pawell@cadence.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201207103227.606-1-pawell@cadence.com>
References: <20201207103227.606-1-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3a8a694a-ce1c-4e81-f7ae-08d89a9c9969
X-MS-TrafficTypeDiagnostic: SN6PR07MB4238:
X-Microsoft-Antispam-PRVS: <SN6PR07MB42386357A443160157896A4CDDCE0@SN6PR07MB4238.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:386;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QKqDIEFhuqUy6j4+XQsMkEd5t34lwreTVd3sZQqhc55ZaU94j3CNj8eMk8wfh1T2UUnB2zokGoeJNVZKis48CKNeLks4PhFLitoOTfPpJ3f10ZTUbn1Nx3NcLPEqlCrW88gJF8taP93YJ5hvmZSAXLwPq76YKMobCsFPyf13kzLHM+xZ+SoDJ3inz+gxvUL0I9FcwCKCoIf2QfnxwJv6sTurVLpdu7WT6Gjs6+dbQZvcmBsoAQdZq38fBpxQwGblygfnQVmQqVTm3Roy5d5JQLJETbocxs4oTfi8On+8HlrAVRTSLluvF9dgwPOjynAB8NXPXOcQcgci/ZQhmvxNI6AaU96bsG78+ktpfiPLIuE42JXj/gusW85woxC5KW2xAPXczdG0SCPc4YFKB1c1RHESMOYemk9pkNpGeoIuluQjYT5RhbfP3MyA410QQSZryme0jzetdRpziPxorux73Q==
X-Forefront-Antispam-Report: CIP:158.140.1.148;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx2.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(346002)(396003)(136003)(39860400002)(376002)(36092001)(46966005)(54906003)(34020700004)(8936002)(82310400003)(2616005)(7636003)(336012)(8676002)(42186006)(316002)(36906005)(426003)(26005)(478600001)(186003)(47076004)(82740400003)(1076003)(4744005)(356005)(6916009)(5660300002)(2906002)(70206006)(107886003)(86362001)(36756003)(6666004)(70586007)(4326008);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Dec 2020 10:41:05.1360
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a8a694a-ce1c-4e81-f7ae-08d89a9c9969
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.148];Helo=[sjmaillnx2.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT016.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR07MB4238
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-07_09:2020-12-04,2020-12-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 clxscore=1015 phishscore=0 mlxlogscore=567 priorityscore=1501
 suspectscore=1 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2012070068
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

