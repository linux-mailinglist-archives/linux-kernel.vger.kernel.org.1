Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA1F62F1890
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jan 2021 15:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388602AbhAKOoU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jan 2021 09:44:20 -0500
Received: from mx0a-0014ca01.pphosted.com ([208.84.65.235]:3836 "EHLO
        mx0a-0014ca01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730653AbhAKOoT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jan 2021 09:44:19 -0500
Received: from pps.filterd (m0042385.ppops.net [127.0.0.1])
        by mx0a-0014ca01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10BEbJWR014249;
        Mon, 11 Jan 2021 06:43:03 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type; s=proofpoint;
 bh=iwKCSn6yQUV9nJ0HhBH1vjK/an+g9AnNAaxpBoHGWpg=;
 b=R3PAjCOKrQZfKTUeWZZ4zRXIw0r03bltRU2ZooXkO4qbnk+zPkoJW2vb4qJTTxqzDvr8
 FbAzZYo1eUerQMGahSJ8WcMZgLJ6jVzaKNKG5puBTE4hTxYOjxzmS+XNgbmbc3eJaXA5
 +SBGQwch8pkAZ7pHp2MaQiC75gKIvp77EWRnIEvgI3tcdItcbcFlF0QVVV0FLdJVAeOm
 /H7dr3ut8f8e/jgb9bYnJLJHWlzS8V7KC6kSVCCC3X/dltxJ4rEBeddFZrSAIuDGkNbx
 V7fWdBgOe7rN5K42L+ZO0sptNcGi1uhHvWjO5PFGICYmvKtFvXglS7N8kWrHlLigtlZW Kw== 
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
        by mx0a-0014ca01.pphosted.com with ESMTP id 35y9x0cyve-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 11 Jan 2021 06:43:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iIVlYJRokSy8oSOy/qpdH4hSuujF50BqllrTDzYG+RUU3ay5ZV3tr1SMzc+Cyqye6RY8OZE0Bw3MC3Z2xprmNxTRGvjWGd0TUSGY6QYPgx8Q/YHQgMTHzNwFHNVx6AyzqC2svdC9Ktp3MlPsqKp+QIWrPfuThbwsI2ALVupTwjT2wH5iQyxquw+3/+38f7DqZyCd5BC5pkfJjvgM2lONQ2ZcXbV3q10SYozktnUeGtK2UzCHGRO+efcUU3wgTymvU2kS2W8fVxGZTXJPm2xvtQnMPsCdW1NiKl3mssLYsyxqnvoYg0JeZdUTL9cVfYEJ+BvtIsU/neifSNYShB2BaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iwKCSn6yQUV9nJ0HhBH1vjK/an+g9AnNAaxpBoHGWpg=;
 b=KDxz139ezojXYCbB9rdcf9gpClCDE0+TSrF+9RL++upUVHRhl5YyE4v9wZmGwKfBiT4Hq0vQzZSxLbxiw0v5Dbd3IHS43597rYc0XyLFHrDW1yXkFk7R33WAIhDPaTlTGvsnZqILcG9VMMND0FgoZsMmqsJaHv4EuKfyx53DIcV0n0n8o2OUB0jtQEE03CpUkWAw28zks96VAIBqyPxNpjgaADyvQRophRjU230+dGHjdGWGYtYLf/gsNG6o2Ko0CiqN1CDaBbq0Ps+tQvXhOaDT4wjiPGQWo4qCsApUpfthRps1fnMHj4MztrCMipfU4OPMjpLkz9lZnUQUcag02A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 158.140.1.147) smtp.rcpttodomain=ti.com smtp.mailfrom=cadence.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=cadence.com; dkim=none
 (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cadence.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iwKCSn6yQUV9nJ0HhBH1vjK/an+g9AnNAaxpBoHGWpg=;
 b=dal/4kvlDkX/7exDcEnbI2xk/pF7qXezP2tegDqBUgmLsLwjd4Fl+ih6QutNq/nJmeeUsZksX5IVGAvrJbltbgqq5veR2nQ6cf6jQ030HzF4U1m7m1H7sANhDmVn6gffXSvQDW5sffXtUN+SJdA6WOkfdcvTzC9zcu+ilQoWmRM=
Received: from BN9PR03CA0611.namprd03.prod.outlook.com (2603:10b6:408:106::16)
 by MWHPR07MB3871.namprd07.prod.outlook.com (2603:10b6:300:de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6; Mon, 11 Jan
 2021 14:43:01 +0000
Received: from BN8NAM12FT052.eop-nam12.prod.protection.outlook.com
 (2603:10b6:408:106:cafe::cb) by BN9PR03CA0611.outlook.office365.com
 (2603:10b6:408:106::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend
 Transport; Mon, 11 Jan 2021 14:43:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 158.140.1.147)
 smtp.mailfrom=cadence.com; ti.com; dkim=none (message not signed)
 header.d=none;ti.com; dmarc=pass action=none header.from=cadence.com;
Received-SPF: Pass (protection.outlook.com: domain of cadence.com designates
 158.140.1.147 as permitted sender) receiver=protection.outlook.com;
 client-ip=158.140.1.147; helo=sjmaillnx1.cadence.com;
Received: from sjmaillnx1.cadence.com (158.140.1.147) by
 BN8NAM12FT052.mail.protection.outlook.com (10.13.182.236) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3763.2 via Frontend Transport; Mon, 11 Jan 2021 14:43:00 +0000
Received: from maileu3.global.cadence.com (maileu3.cadence.com [10.160.88.99])
        by sjmaillnx1.cadence.com (8.14.4/8.14.4) with ESMTP id 10BEgquY007926
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Jan 2021 06:42:53 -0800
X-CrossPremisesHeadersFilteredBySendConnector: maileu3.global.cadence.com
Received: from maileu3.global.cadence.com (10.160.88.99) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3; Mon, 11 Jan 2021 15:42:51 +0100
Received: from vleu-orange.cadence.com (10.160.88.83) by
 maileu3.global.cadence.com (10.160.88.99) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Mon, 11 Jan 2021 15:42:51 +0100
Received: from vleu-orange.cadence.com (localhost.localdomain [127.0.0.1])
        by vleu-orange.cadence.com (8.14.4/8.14.4) with ESMTP id 10BEgpCx016459;
        Mon, 11 Jan 2021 15:42:51 +0100
Received: (from pawell@localhost)
        by vleu-orange.cadence.com (8.14.4/8.14.4/Submit) id 10BEgmA1016458;
        Mon, 11 Jan 2021 15:42:48 +0100
From:   Pawel Laszczak <pawell@cadence.com>
To:     <peter.chen@nxp.com>
CC:     <rdunlap@infradead.org>, <a-govindraju@ti.com>,
        <gregkh@linuxfoundation.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kurahul@cadence.com>,
        Pawel Laszczak <pawell@cadence.com>
Subject: [PATCH] usb: cdnsp: fixes undefined reference to cdns_remove
Date:   Mon, 11 Jan 2021 15:42:26 +0100
Message-ID: <20210111144226.16372-1-pawell@cadence.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-OrganizationHeadersPreserved: maileu3.global.cadence.com
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: baed6300-9363-4d59-b633-08d8b63f31d9
X-MS-TrafficTypeDiagnostic: MWHPR07MB3871:
X-Microsoft-Antispam-PRVS: <MWHPR07MB387120D21B29327A917E628EDDAB0@MWHPR07MB3871.namprd07.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3968;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jlrAknV6azy+t9mPyukDRABScTg5rkm5dZ5ADXDfY+w1qLXNy/k6gyFQ+S5R9KSMZbzxQK3HRJudnx2OLHQeYqhZ5rNGVTof/0Ns48NQRCPtI7kJoHxtbcD+YJg1GKlogsEy1ospWgRjZ8Vxn+RFNP8Utw4vrQTSI27zCPVklp6SidstZ/CUpqbxPu5Z71Xgdl+AMilPCEpusmfYXugKADa3I00HXzBzvLm8qB0/I1v16inMr5vurqQ+Oks9zyUAkgsMuz6aGP8nyfnzTSZ1K1OLAgS58PZpuL00BkPFlGieLScgC58jYwwWAmXhwYK6FeX/P4u2i/IEqg2pZVkiTtdbPkT868GKujeKaSwijB9xJMduOhw41cFfsQHk+VwPtqTNcRSb0soa3uK+j/QC+KaSJfG2zDEQ1J2fnUZTd5iTTqBjvl0fnF2cosWSZzcA3tsaQAVaxTNZxhhpSGEivi30JLtw+SKV4UqtOaPjRuLR2iLEuaE/KGutYeXDqW2vuuIZa3m9UbkBGdJa+o1soQ==
X-Forefront-Antispam-Report: CIP:158.140.1.147;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:sjmaillnx1.cadence.com;PTR:unknown.Cadence.COM;CAT:NONE;SFS:(4636009)(376002)(136003)(396003)(346002)(39860400002)(36092001)(46966006)(426003)(2616005)(34020700004)(2906002)(36756003)(5660300002)(8676002)(8936002)(336012)(7636003)(478600001)(356005)(47076005)(186003)(82740400003)(82310400003)(26005)(86362001)(6666004)(1076003)(316002)(42186006)(6916009)(54906003)(36906005)(4326008)(70206006)(70586007)(107886003);DIR:OUT;SFP:1101;
X-OriginatorOrg: cadence.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2021 14:43:00.7162
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: baed6300-9363-4d59-b633-08d8b63f31d9
X-MS-Exchange-CrossTenant-Id: d36035c5-6ce6-4662-a3dc-e762e61ae4c9
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d36035c5-6ce6-4662-a3dc-e762e61ae4c9;Ip=[158.140.1.147];Helo=[sjmaillnx1.cadence.com]
X-MS-Exchange-CrossTenant-AuthSource: BN8NAM12FT052.eop-nam12.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR07MB3871
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-11_26:2021-01-11,2021-01-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_check_notspam policy=outbound_check score=0 adultscore=0
 mlxlogscore=687 priorityscore=1501 impostorscore=0 phishscore=0
 spamscore=0 mlxscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2101110090
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patch fixes the following errors:
ld: drivers/usb/cdns3/cdnsp-pci.o: in function `cdnsp_pci_remove':
cdnsp-pci.c:(.text+0x80): undefined reference to `cdns_remove'
ld: drivers/usb/cdns3/cdnsp-pci.o: in function `cdnsp_pci_probe':
cdnsp-pci.c:(.text+0x34c): undefined reference to `cdns_init'

Issue occurs for USB/CDNS3/CDNSP kernel configuration:
CONFIG_USB=m
CONFIG_USB_CDNS_SUPPORT=y
CONFIG_USB_CDNS3=m
CONFIG_USB_CDNS3_PCI_WRAP=m
CONFIG_USB_CDNSP_PCI=y

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Pawel Laszczak <pawell@cadence.com>
---
 drivers/usb/cdns3/Makefile | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/cdns3/Makefile b/drivers/usb/cdns3/Makefile
index 3f9b7fa8a594..be906910f98b 100644
--- a/drivers/usb/cdns3/Makefile
+++ b/drivers/usb/cdns3/Makefile
@@ -26,7 +26,11 @@ obj-$(CONFIG_USB_CDNS3_TI)			+= cdns3-ti.o
 obj-$(CONFIG_USB_CDNS3_IMX)			+= cdns3-imx.o
 
 cdnsp-udc-pci-y					:= cdnsp-pci.o
+ifeq ($(CONFIG_USB),m)
+obj-m						+= cdnsp-udc-pci.o
+else
 obj-$(CONFIG_USB_CDNSP_PCI) 			+= cdnsp-udc-pci.o
+endif
 cdnsp-udc-pci-$(CONFIG_USB_CDNSP_GADGET)	+= cdnsp-ring.o cdnsp-gadget.o \
 						   cdnsp-mem.o cdnsp-ep0.o
 
-- 
2.17.1

