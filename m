Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1503527C09A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Sep 2020 11:12:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728029AbgI2JMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Sep 2020 05:12:30 -0400
Received: from mail-eopbgr30088.outbound.protection.outlook.com ([40.107.3.88]:16131
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725306AbgI2JM3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Sep 2020 05:12:29 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UOKMEBhIrrTX7IJCwBCkGvXGsgLgRFbuNWRe+ARUn0R4G9zc98y3FHTc/BPUfRK/0PoOpkDx4O4pEqGHbLoB43l+747evZt/yjdqneop1b/zU9w8E0ItIR6Wr9Y1xsVG5zlGtfifqzeWwcoys7WtuwYXoGjAEibSmn9ig8QnOT3C4BkjJHYJTlsf/SIAoihEpXOHddbdigRcrcZQYbCb50/mnRlaEqMvCI1ZrOqM2Id9ivlpJu8rFwfV5BQ9Pd3pZrYyQubOEJE5yVYn8nZmm+sKGV6zvrNhOne7eW7dsrgmoRIT/HMF3iUFO0SROuQuEHgbudqiR5YqT8/mCOQiRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gE+XbXpV89SupHrHZiMQpHBZJfZvcdggzft9GUyC/v0=;
 b=MFaMQ0GGzYzVGWtqDZyVN7gcmAyBmTyyoapiuwHXBX95tVeZ0ay/S+9Ll/fSdDDtIYUA98JAANglPfhg1LwXzmpqZxsnJ3o5vGgy5RlINshlJGvqEvymE2xOEZvJDIr2JhNm74e7hr4WVm6tPSvWVjMUz2fHKR60X7Xtd3oWeU/6thHEJHemSFpkmki7uI80QwolvhJsdyuSYu3mJ7oBfxLERNzMDSZk/lVRjC76sCrOfvxpTEzhuTLvqcODkf5ognMgGWGKI/7Pj5A5r6oFrDT0US6vUjZNXelalT7R7UBdFbU2iU4VDNoJYLjtAZ2JGd7pxeDyAg0/yqfn7IeyIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gE+XbXpV89SupHrHZiMQpHBZJfZvcdggzft9GUyC/v0=;
 b=KOL8eNQBeZsCT633XHz01MZ5axCaSnLdYJrKFQUYUjX8G26NWNoTg+SCst/C3S3RUIdjNfk2y74uD2FfaUswgcuP+qRo/W7GmVK2JekhbIks+IsTniKAekTDgvohIVtSzweAxwhdmIx+DuGz/W5V7KJ3vCJ+eIFITJkESPzDvg8=
Authentication-Results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=nxp.com;
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com (2603:10a6:803:57::21)
 by VI1PR04MB4064.eurprd04.prod.outlook.com (2603:10a6:803:4c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.32; Tue, 29 Sep
 2020 09:12:26 +0000
Received: from VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6]) by VI1PR04MB4960.eurprd04.prod.outlook.com
 ([fe80::b178:a37b:1f9e:3a6%3]) with mapi id 15.20.3412.029; Tue, 29 Sep 2020
 09:12:26 +0000
From:   Sherry Sun <sherry.sun@nxp.com>
To:     sudeep.dutt@intel.com, ashutosh.dixit@intel.com, arnd@arndb.de,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org, linux-imx@nxp.com
Subject: [PATCH V2 2/4] misc: vop: build VOP based on CONFIG_VOP
Date:   Tue, 29 Sep 2020 17:11:04 +0800
Message-Id: <20200929091106.24624-3-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200929091106.24624-1-sherry.sun@nxp.com>
References: <20200929091106.24624-1-sherry.sun@nxp.com>
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:3:17::20) To VI1PR04MB4960.eurprd04.prod.outlook.com
 (2603:10a6:803:57::21)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from nxp.ap.freescale.net (119.31.174.71) by SG2PR02CA0008.apcprd02.prod.outlook.com (2603:1096:3:17::20) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3412.20 via Frontend Transport; Tue, 29 Sep 2020 09:12:23 +0000
X-Mailer: git-send-email 2.17.1
X-Originating-IP: [119.31.174.71]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 907b4946-e614-4282-d270-08d86457c846
X-MS-TrafficTypeDiagnostic: VI1PR04MB4064:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR04MB40643FEE99D08D721EFF6C0392320@VI1PR04MB4064.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:330;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eO8dc7w7GP7S31x2o/ZBJNJ2elLmQ5TvY3Fd0EarRZHMLTCZ0Cf7//77ETzTwEPmP1cHG6svBtraVZcNR7u9WJmY4QWFsqfASVEERKo8xCmVaCKrq2WL9cqSxuIZmPVtaUuIsHX+Vu0SG7i3NbnImJ+AC85VDJYh0UyEmMBp/ZTj6MgBLn1n2UkR265z7/ZsSvSMrFOgdYJKI9Dv1oVAOM94HFDXPM2Z+nIM76teDMf/AMCyLRr8mS0IDVtgym8To/aZHVPs7PoXF/+MDDA5lTpUidmheCWjXtp2IDaTc61QOxcEz0epcdZWN06TCc82O242tSbu8c2TXK+yt+GPoQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR04MB4960.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(396003)(136003)(376002)(366004)(8936002)(4326008)(52116002)(6506007)(83380400001)(5660300002)(6666004)(1076003)(478600001)(66556008)(8676002)(86362001)(956004)(2616005)(2906002)(66946007)(4744005)(36756003)(66476007)(6486002)(16526019)(6512007)(186003)(44832011)(316002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: B4Vu4WO7YOp0xwtCHWXmCRtgVTSFex8zsLkKZeIr36TS0KxW6gCMceFxm/tX7gQJGFBykP/ZE9sbDaDKXiVvTLxuiETQ4po/Ll+dkolbbZWVVfdrNwzhWdM0N+rB1AiKa8r8878d1tStx1r8ujuUya8xc8uBOhac4cUEI04g9e1AI0PEReipv6cZKzKm8+OcdN1Bdw3ICF6K1QVkO9OV8BqsN2LTveyZd4X1P353YR6QB311DVgogHudOyT+SinY/qX2aSPYuyD1svyryXrDe9pfA3K2vchxDS/aJPIww27I68CmWSK13Ll2rKqe03sm/3+0bjBt6ag/+oqWfYQ+oKzg5ao3OwaBlsb/HWMm3V16qZRcmA5kzOupBisr20vQx3h/xfOC4o+DthRHT/RVchD1BTscZpneMwx5yTEXVRnM9JJZxYE4AQDNRvN06Y2YREk+IcitNjf677tZwC0hnjZmRYW2H5+NSW2ozy3EwZ2LausDZ4etV+fDjDfC2+WNaz1ZiDuhUhOW/Au+bI8+JY83S5sNV0irCdA3W0N+Tsx1NBconZDOmACzondi2m4/sXSSuVL9/G4sqlVMChGH7kMULaPrDJtfou/7y3KscBR6nrjC9SqG47dSJLXSQJOk8fvB7OR73VbcHwpf9LD1hg==
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 907b4946-e614-4282-d270-08d86457c846
X-MS-Exchange-CrossTenant-AuthSource: VI1PR04MB4960.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2020 09:12:26.1560
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N3HBl2+tuF2roH5MTsZ/5OqaVT5rPkSccdr8RjrK5/sqDBQg9ZK5P2RO0aL6tHMgdIKyqa1w8wDWh5GgVyH/+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB4064
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Build module or builtin VOP based on CONFIG_VOP macro.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/misc/mic/vop/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/mic/vop/Makefile b/drivers/misc/mic/vop/Makefile
index 579da3868c8e..51b9b0022786 100644
--- a/drivers/misc/mic/vop/Makefile
+++ b/drivers/misc/mic/vop/Makefile
@@ -3,7 +3,7 @@
 # Makefile - Intel MIC Linux driver.
 # Copyright(c) 2016, Intel Corporation.
 #
-obj-m := vop.o
+obj-$(CONFIG_VOP) := vop.o
 
 vop-objs += vop_main.o
 vop-objs += vop_debugfs.o
-- 
2.17.1

