Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 349A726D69E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Sep 2020 10:30:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgIQIaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Sep 2020 04:30:09 -0400
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:25314 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726333AbgIQIaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Sep 2020 04:30:01 -0400
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 08H7Mfv0004038;
        Thu, 17 Sep 2020 00:30:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=proofpoint;
 bh=1Kgj7Pzlp8BbbX9rCNXXFcHIU3lHVjyRKEYMIK0MvXQ=;
 b=FlyfW8DwnaCqCJLrQ85Z7JESClIB726satSZLLrvI/v/kSA/t0X2b4dtDVY/VFWahvg6
 9piWwiBUplRBoKTM2bTiFhxqFSevXk+H0PACrwNBWYtDc6iXIXfsB60Audf0pZytJKMX
 gmCftkp/rUSb0h95ekhH70/E6EDB6oai3aVnSvE8qBuoSsoSBqJDnYbCGNKpKuLac/fZ
 PSntGFZpvz8HitQoaS3wpsh4JItzjk/rcBw81q5D7S8CdfDuwJOXXnB09ehkdRe9H8LH
 HFNIfmQQ3n++AJPwNDduBxCkLnOlU+tKZfTCzckGxrZJXZlxXdqmAXdZyWc23MoyjBY8 VQ== 
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by mx0a-0014ca01.pphosted.com with ESMTP id 33k5mmpfjs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Sep 2020 00:30:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KWnb/GMZDgVNxa6hKmmrmUHmHizF43gAIZLB5PC2UYK6/gmEKBfMP+M6vA1RuIyUWYqMj/7qLVUfQSOPpxBweu70Rh1it42OS3D74Q6IMqdUXE3029bf9j90tnRkFpnBeDOzzTXmoGi65AKJusUBJJfgDbU2MRuXW4/n72gdg6/FABMFreCFWbW+qZGTyaxNWTVe74tdU77FsQkgNaqeNLwBpNz0skt4an4KQRYiPYQhFsNjkvRvsEPodgyMyVO/hXjmsAsjhHVUjUHjN+wjROHD2wr+bM0RW/5KDvwxkZLYkvZzkCg7/0cIvnbHP3ErwoJJ/C01y1374un+37+fnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Kgj7Pzlp8BbbX9rCNXXFcHIU3lHVjyRKEYMIK0MvXQ=;
 b=M+mkDZSZelOaJAtQX8AJcRCPo5fvIN8yGPyMW09jBKgg9EjvhehhK4f1wrvYqWkNdRMt6Lg1ePIPgzsjwOR6qwzDwU8FLn5/HvgkZku+oy4E/QHEP4r5jE9NxJBZC/8StRJ6C9d7B+dzZuIHNyDHVxmCzt+s1jA3zpsRw96Q3jaxZKiaFZGwb188FH51oq4rDNXzakqqlWPxxtCNFxwSqFXpmQSuCtYGLVpFQf0KaJykRit88fXhx+mDJpHz/UKlX4tMxYTvC/V0o0SRe063nMENybnGQGm+95WYIHAQu+XwzO+QLe73Jqhq3x76Dd1du5BVPWYyg9W2+6LH+/ZLuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 199.43.4.23) smtp.rcpttodomain=kernel.org smtp.mailfrom=cadence.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=cadence.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Kgj7Pzlp8BbbX9rCNXXFcHIU3lHVjyRKEYMIK0MvXQ=;
 b=H4NibhJr3aoZS2ArggEWY0sS5cHsgmze7xauD0ZTrnLid6K3pYNv1ij+C/I8ycDkBWuIhHJyylStJmPXglbgBJNqKCxjWCK53Npwnn1JskauajyLfHA4KVSmb9/9S1FDn7B99hNZeyNbry3hca1Q0RjbiHEg8JvC71bjAXbHyjs=
Received: from DM6PR02CA0039.namprd02.prod.outlook.com (2603:10b6:5:177::16)
 by DM6PR07MB7083.namprd07.prod.outlook.com (2603:10b6:5:1f1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11; Thu, 17 Sep
 2020 07:30:51 +0000
Received: from DM6NAM12FT063.eop-nam12.prod.protection.outlook.com
 (2603:10b6:5:177:cafe::37) by DM6PR02CA0039.outlook.office365.com
 (2603:10b6:5:177::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.11 via Frontend
 Transport; Thu, 17 Sep 2020 07:30:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 199.43.4.23)
 smtp.mailfrom=cadence.com; kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 199.43.4.23 as permitted sender) receiver=protection.outlook.com;
 client-ip=199.43.4.23; helo=rmmaillnx1.cadence.com;
Received: from rmmaillnx1.cadence.com (199.43.4.23) by
 DM6NAM12FT063.mail.protection.outlook.com (10.13.178.112) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3412.6 via Frontend Transport; Thu, 17 Sep 2020 07:30:51 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by rmmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 08H7UmHU011305
        (version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=OK);
        Thu, 17 Sep 2020 03:30:50 -0400
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Thu, 17 Sep 2020 09:30:48 +0200
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 17 Sep 2020 09:30:48 +0200
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 08H7Umcx009789;
        Thu, 17 Sep 2020 09:30:48 +0200
Received: (from sjakhade@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 08H7Um7O009788;
        Thu, 17 Sep 2020 09:30:48 +0200
From:   Swapnil Jakhade <sjakhade@cadence.com>
To:     <vkoul@kernel.org>, <kishon@ti.com>, <robh+dt@kernel.org>,
        <p.zabel@pengutronix.de>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC:     <mparab@cadence.com>, <sjakhade@cadence.com>,
        <yamonkar@cadence.com>, <tomi.valkeinen@ti.com>, <jsarha@ti.com>,
        <nsekhar@ti.com>
Subject: [PATCH v3 04/13] dt-bindings: phy: Add PHY_TYPE_QSGMII definition
Date:   Thu, 17 Sep 2020 09:30:37 +0200
Message-ID: <1600327846-9733-5-git-send-email-sjakhade@cadence.com>
X-Mailer: git-send-email 2.4.5
In-Reply-To: <1600327846-9733-1-git-send-email-sjakhade@cadence.com>
References: <1600327846-9733-1-git-send-email-sjakhade@cadence.com>
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6887c02c-893d-4caf-b842-08d85adb9abd
X-MS-TrafficTypeDiagnostic: DM6PR07MB7083:
X-Microsoft-Antispam-PRVS: <DM6PR07MB7083387D1E4AEFD29B4C3377C53E0@DM6PR07MB7083.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1079;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z2TEWbBVoEuehjdGSF0kQtdAE/jBngr1VyBCqCUtVpf8QgZD68gKtjQNaMnc5O22lh32XsKnjHHXQYgT+LF9aUHNmUrJ3J39a5oNdCBFhAw8KIv8Th8gbBppG+lr91qtb4YJ5LK8GjjCweRUNqBLDP1F7yGyc8s4OxXgmBxeX/GY3qUJoxrnpOaYh7TSDr1j1ooTO/niwV+CrKvoyPAeVdzkjrWhfgXw+XckByLNfz6CMtR/1YAG0BEblzVquKqvsPHbM+VdiQdjCai032f91r+St4O0HwsF7u/NGENfS8gYOiiuFEUrIpTMgWwrvFJIYFTxm5gu71ROPdxGetGNDoTSY+weIvgeOkFapu1WK9dsxZlBx5D9Ta3Fu9WrXtk4rlu7C6itD4JyOVVBcFBZ3CLh2C5+1xyjARXaGaTF6gia67UJ/njuDtorPt4SNJ9WyLrjXScTb9OyTRIlsN+4IC8PzzNr4TC3Y3FUuLYl7bc=
X-Forefront-Antispam-Report: CIP:199.43.4.23;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:rmmaillnx1.cadence.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(4636009)(39860400002)(396003)(376002)(346002)(136003)(36092001)(46966005)(4326008)(86362001)(82310400003)(8676002)(336012)(478600001)(186003)(8936002)(426003)(82740400003)(4744005)(26005)(2906002)(36756003)(47076004)(70586007)(70206006)(6666004)(110136005)(36906005)(42186006)(316002)(5660300002)(2616005)(54906003)(81166007)(356005);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2020 07:30:51.2528
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6887c02c-893d-4caf-b842-08d85adb9abd
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[199.43.4.23];Helo=[rmmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: DM6NAM12FT063.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR07MB7083
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-09-17_03:2020-09-16,2020-09-17 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 mlxscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 clxscore=1015
 mlxlogscore=882 phishscore=0 suspectscore=0 bulkscore=0 spamscore=0
 malwarescore=0 priorityscore=1501 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2006250000 definitions=main-2009170053
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add definition for QSGMII phy type.

Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>
Acked-by: Rob Herring <robh@kernel.org>
---
 include/dt-bindings/phy/phy.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/phy/phy.h b/include/dt-bindings/phy/phy.h
index 36e8c241cf48..887a31b250a8 100644
--- a/include/dt-bindings/phy/phy.h
+++ b/include/dt-bindings/phy/phy.h
@@ -19,5 +19,6 @@
 #define PHY_TYPE_DP		6
 #define PHY_TYPE_XPCS		7
 #define PHY_TYPE_SGMII		8
+#define PHY_TYPE_QSGMII		9
 
 #endif /* _DT_BINDINGS_PHY */
-- 
2.26.1

