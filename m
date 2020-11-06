Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7E982A95B0
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Nov 2020 12:47:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727321AbgKFLqZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Nov 2020 06:46:25 -0500
Received: from mx0b-0014ca01.pphosted.com ([208.86.201.193]:47144 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727053AbgKFLow (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Nov 2020 06:44:52 -0500
Received: from pps.filterd (m0042333.ppops.net [127.0.0.1])
        by mx0b-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0A6BfbD1006090;
        Fri, 6 Nov 2020 03:44:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=EEnK5WJq+qT5SmVg13mxwJocF+dPjqTQMb+6OeqknGk=;
 b=j1AliIwW8bB1J87PrXMy9y7Ck/owDTPhXJKWRedFzkmwFL2TZXZEfGtQd0aTwbVbOAVE
 dxn9erpWRUeFgJOW85a2riSLJmno396qOKRz/jjNZFOdJn44vuOtC1H2tG01JkO1Qs+6
 9wW4F2sBqu7lHjzUSyKG5ugNfvm6OC1BrZT4PoUdzUBCb0WDZQbz/MorOK+xB6X6wng9
 5cJIdS6sP0EuHsx7Uo4w2M8IPEvA7xWpWm3NSPZwtTdOMJLOO5UUhAn3KcshP9AcJesh
 IowGACT+FSiTomRr5HXQyJj2b/sil2H0XKmkvGsGT0Ix6/c6BU5cVaYaM9Az1HmOWGR4 PA== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by mx0b-0014ca01.pphosted.com with ESMTP id 34h3gxac91-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 06 Nov 2020 03:44:26 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lamNdC1G/4/At1AISHFM4gK5BoIHdRkfQeuIqnFinbp6nlG4kl6oaaNPCWDcNq4cMLV5MXd0ARpjweuyqNiqMZmim9I8TXQ3153KVLedqS0FQ+54ko67+81POlrSy4MvCVzt9+gqdRK+qDrIFzkNct7c5JaAefhbq2+R1PQvOeBZPzjx0/CxOMaIvWtLT8NLJxPNRfvE9rqXuN1iF75V5FJ8KBOlrWB1rO06f1rq00x6p2grnOwvWMndYMNjj/QJNt4oItTfSkqlXtLiycs/jtadqmMLumRSTufhdVEstSCF073N6mNEXERQsF0bMFxdRdV3lrx6TyLD7b/LQzv0xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EEnK5WJq+qT5SmVg13mxwJocF+dPjqTQMb+6OeqknGk=;
 b=dUJbYo9xcUiDW5iPtCSZECH1y0QPzqozxdmpVBHFaT4hzq+CVcpTR+HAOktkpzazh3ADhx5r61eMVw/P5hJI/NaTEuzbBQYtkw8/Z+aHW4UK1or0hppwsb0hZGh6tVs49StIP7D15hrqL4b2roh+eydGMCdAcQAKrjiZIAdePNxEO3BU3Q6dbECnoOUdDubdm5OfPSzUJ+EingajGRK/1/Qxpz1c+dmPnUU1M9K1LlpnQwFQHhk0ULv2Zusn7kW2D7Ljb+TebJxc6M/P5PilQCyzLJUVQhMvCpHwRb+j+C9Kq5m25ly57OXhTjFPPBfMKYKyYCyM7Pe3ixwuNU/W0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 64.207.220.244) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EEnK5WJq+qT5SmVg13mxwJocF+dPjqTQMb+6OeqknGk=;
 b=Fa6362ELadNRbBIrz+h19CEToDJ+ptI6O16rtoCV6P7fv32jwq6d6tiezOZKbOxdGWt3O4ngpZz8MXyYAj350PzsAZ3KpFpX9MYy+8rKRpJlt14vut1nzzbACwQYFTBlpXdGJlECsPxmFAkgu7ZIYjWGDLAnz8TNMC876zy32ow=
Received: from MWHPR22CA0058.namprd22.prod.outlook.com (2603:10b6:300:12a::20)
 by DM6PR07MB5881.namprd07.prod.outlook.com (2603:10b6:5:18b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18; Fri, 6 Nov
 2020 11:44:24 +0000
Received: from MW2NAM12FT056.eop-nam12.prod.protection.outlook.com
 (2603:10b6:300:12a:cafe::e2) by MWHPR22CA0058.outlook.office365.com
 (2603:10b6:300:12a::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.18 via Frontend
 Transport; Fri, 6 Nov 2020 11:44:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 64.207.220.244)
 smtp.mailfrom=cadence.com; vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=pass action=none
 header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 64.207.220.244 as permitted sender) receiver=protection.outlook.com;
 client-ip=64.207.220.244; helo=wcmailrelayl01.cadence.com;
Received: from wcmailrelayl01.cadence.com (64.207.220.244) by
 MW2NAM12FT056.mail.protection.outlook.com (10.13.181.132) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3541.7 via Frontend Transport; Fri, 6 Nov 2020 11:44:23 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by wcmailrelayl01.cadence.com (8.14.7/8.14.4) with ESMTP id 0A6BiFAu094912
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=OK);
        Fri, 6 Nov 2020 03:44:22 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Fri, 6 Nov 2020 12:44:15 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Fri, 6 Nov 2020 12:44:15 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 0A6BiFjN001611;
        Fri, 6 Nov 2020 12:44:15 +0100
Received: (from pawell@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 0A6BiFs9001610;
        Fri, 6 Nov 2020 12:44:15 +0100
From:   Pawel Laszczak <pawell@cadence.com>
To:     <peter.chen@nxp.com>
CC:     <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <balbi@kernel.org>,
        <colin.king@canonical.com>, <rogerq@ti.com>, <kurahul@cadence.com>,
        <nsekhar@ti.com>, Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH v2 10/10] MAINTAINERS: add Cadence USBSSP DRD IP driver entry
Date:   Fri, 6 Nov 2020 12:43:00 +0100
Message-ID: <20201106114300.1245-11-pawell@cadence.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20201106114300.1245-1-pawell@cadence.com>
References: <20201106114300.1245-1-pawell@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cbd3cd84-0b59-4394-b6ce-08d882494e9a
X-MS-TrafficTypeDiagnostic: DM6PR07MB5881:
X-Microsoft-Antispam-PRVS: <DM6PR07MB588105FA6FECF3FB9352E609DDED0@DM6PR07MB5881.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:386;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WEE7Te18HTYXqbJnhFLfMG3xkHTybK1liSyIUO2vGIPZSzVw7xKIyiYfpP61cnC+FSyjWhL3eSVSTPa140uxf3auWO+Jjhqpw+/Dd29925DDGimpxodgblC/4PtGTJWsB0lYQTj5qAjnU/cElvSfpla2oYiZniEkAe4Cc/HQPQrLEm/47sU1C2rUZWblDXGCxRN8FSHlHz7LKOIXKqoajhk1MGXazw1h798NeENRhvOjkhyODs/x9okyWzJ6zofKr3QacqIqSHovuUbBZPKscdYVYD8tsylSLsJLb6+tvOyov0184XCczJpRCJ1tduuF2+febfCBn1Wi3+UCpOEilBK7UmsyCl0QxBQsp6xiwDoJrIm+eTQiE23cwJg4ZC+zcaE3LsCvfnIaXuIjR2EbaGeBqLYDnP39SHj3br4959g=
X-Forefront-Antispam-Report: CIP:64.207.220.244;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:wcmailrelayl01.cadence.com;PTR:ErrorRetry;CAT:NONE;SFS:(4636009)(39860400002)(376002)(136003)(396003)(346002)(36092001)(46966005)(4744005)(426003)(1076003)(82310400003)(478600001)(2616005)(356005)(6666004)(4326008)(2906002)(5660300002)(86362001)(36756003)(6916009)(82740400003)(70586007)(70206006)(8936002)(336012)(47076004)(26005)(81166007)(186003)(107886003)(42186006)(54906003)(8676002)(316002)(36906005);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2020 11:44:23.5361
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cbd3cd84-0b59-4394-b6ce-08d882494e9a
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[64.207.220.244];Helo=[wcmailrelayl01.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: MW2NAM12FT056.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB5881
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-06_04:2020-11-05,2020-11-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0
 priorityscore=1501 malwarescore=0 impostorscore=0 lowpriorityscore=0
 adultscore=0 suspectscore=1 mlxlogscore=560 spamscore=0 bulkscore=0
 mlxscore=0 phishscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2011060086
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch adds entry for USBSSP (CDNSP) driver into MAINTARNERS file.

Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f41d0e29b331..731150530d10 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3866,7 +3866,14 @@ L:	linux-usb@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/peter.chen/usb.git
 F:	Documentation/devicetree/bindings/usb/cdns-usb3.txt
+X:	drivers/usb/cdns3/cdnsp*
+
+CADENCE USBSSP DRD IP DRIVER
+M:	Pawel Laszczak <pawell@cadence.com>
+L:	linux-usb@vger.kernel.org
+S:	Maintained
 F:	drivers/usb/cdns3/
+X:	drivers/usb/cdns3/cdns3*
 
 CADET FM/AM RADIO RECEIVER DRIVER
 M:	Hans Verkuil <hverkuil@xs4all.nl>
-- 
2.17.1

