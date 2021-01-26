Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76D36304625
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jan 2021 19:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394582AbhAZSSa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jan 2021 13:18:30 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:46780 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404049AbhAZSGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jan 2021 13:06:00 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10QHxpJ1020892;
        Tue, 26 Jan 2021 18:05:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id : content-type : mime-version; s=corp-2020-01-29;
 bh=GA6nysgvovUu22LhIw7IqdzMmGdKQn64Tc960zSqDx8=;
 b=DJo8T+ccV5f6uLwlt5cvvbpXL37qaNW8IwaLZhmT/y7aEX7KasPgDQsrR9afLFvJvHWi
 4I7BX6xEmAgvDD2gfcXZPryP01hTVkZadQ/FUBZ1OiSjg5W/zk4FFyUkd2tcBSCHmuKx
 WqwP50i2kcYIeS91sp/RGNILr6TgS44oHwjgH4RYhGNQAmNNMNtBKleATx8yoqcDeQ/H
 fIF5CuN5PqxFjl76IQao3y4AeKEpYEHhmeW8Fv8c5wR+s43yjcbqFrLN7wg+xrLj4azC
 mLe9ZjXzSEYaNT/ZvB10ID2I0SF9iK5iqUgZr1Yuukm6sdO6YGQZaJelrv9WRyAVvkAl kg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 368b7qucgy-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jan 2021 18:05:13 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 10QI07nA113326;
        Tue, 26 Jan 2021 18:03:12 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
        by userp3030.oracle.com with ESMTP id 368wqwrfe8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 26 Jan 2021 18:03:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WBi/NJLM1C+PUHXW2nTsSV3h+WnbvFVW8zVynO4eOAcwH+NQ4n5klGamHNRtnzFXLW45pi121q1y816VqwUten8rVrfmex+SwgMWhLc0pR2O93bUB6dBbo+lEotx2VG7vGcfHVGDKq3P0uWnhrQx+DPuqYjkGI8XweyqYl+LOUwAusWWObv87JslJPR2h6eKMuc1hk6iaQ1P/ptnOMSWZupxNySz1hQez9bUvo7XlOb7PJ9S8acr9g2T8Mr1koYQEIYI4WTwHr8DK395CqRC464ty0T5e3PTKKzbSrGR/sPH3k+ymBmhK89o1F8clVTuSmUj6tmgkjAMYkwZFstpLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GA6nysgvovUu22LhIw7IqdzMmGdKQn64Tc960zSqDx8=;
 b=bKEgOSr1KK+pTsS8M4nhu1XDzFfPUrOLlnWaXYqnrKFxC/zw6DlkQMO128RlDqWAyGnd273W3Wq8Mo/SYN+UBLo7nc/bodYCsqObNrUCcxlSxNnuaifjGNNQTz/iRjqhx5YfotJZ7jyvGPwhT4iRv2gERlt1dMBZ5APa0VqCr71qAqpR/jtHonf5Iv/FIADgBf8yIF1ugi79CKG1Y7VoekAr/vyNk4s5oI4SKYs5dkLegjdvnbeMyO68OtodBjVA84qScXomOQLjjH/0vui2GcOXNh0cZXRGjDSpYDgcltsgrJTu2gPidT2vK8SSKnD7gSVWQAFZ+9LUbvmIGM6V4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GA6nysgvovUu22LhIw7IqdzMmGdKQn64Tc960zSqDx8=;
 b=msxya0Nk2mQx5qRPY7YuKZL1U/mM2yyOlQuWmulBPr/OxdVWA1lvy3BNryDeZMV06MqSb/AY0NQysvuPVRpCO1CgxeJuxso+b1k3SxZNtCKmlclDC3bQvhe1HuH5YvzETlw4l7gDNMBEyVNHihq9r/pUC5isX2mkDHYaLUMAhS8=
Received: from DM6PR10MB3851.namprd10.prod.outlook.com (2603:10b6:5:1fb::17)
 by DS7PR10MB5341.namprd10.prod.outlook.com (2603:10b6:5:38d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Tue, 26 Jan
 2021 18:03:10 +0000
Received: from DM6PR10MB3851.namprd10.prod.outlook.com
 ([fe80::4d1e:6f06:cff0:364f]) by DM6PR10MB3851.namprd10.prod.outlook.com
 ([fe80::4d1e:6f06:cff0:364f%6]) with mapi id 15.20.3784.019; Tue, 26 Jan 2021
 18:03:10 +0000
From:   George Kennedy <george.kennedy@oracle.com>
To:     george.kennedy@oracle.com, pjones@redhat.com, konrad@kernel.org,
        linux-kernel@vger.kernel.org, konrad.wilk@oracle.com
Subject: [PATCH 1/1] iscsi_ibft: KASAN false positive failure occurs in ibft_init()
Date:   Tue, 26 Jan 2021 13:03:21 -0500
Message-Id: <1611684201-16262-1-git-send-email-george.kennedy@oracle.com>
X-Mailer: git-send-email 1.8.3.1
Content-Type: text/plain
X-Originating-IP: [209.17.40.45]
X-ClientProxiedBy: BYAPR06CA0030.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::43) To DM6PR10MB3851.namprd10.prod.outlook.com
 (2603:10b6:5:1fb::17)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from dhcp-10-152-35-102.usdhcp.oraclecorp.com.com (209.17.40.45) by BYAPR06CA0030.namprd06.prod.outlook.com (2603:10b6:a03:d4::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.12 via Frontend Transport; Tue, 26 Jan 2021 18:03:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 221bc758-2f55-403b-87ef-08d8c224a446
X-MS-TrafficTypeDiagnostic: DS7PR10MB5341:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DS7PR10MB5341A797E98C0F8B0DEA1C7BE6BC9@DS7PR10MB5341.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IsKHTfPlGfeRtbM+seqRYPGk0VhKIjM8Yb3a/p2Wi4pd6rdagMF/RYKUf+Q7TNiri3s8g+LW61nJLXZ8xa8k97bRncVHLTBNZ0OLT+oP67OpKXusvX/d+XL0wMhVDkaF1iIGeNEUBt6xYbiMtoyfNsHpCZuQO29s65NfsiziuiL6u0WAXftjUrUKTeSCC7XBRXT0VfGglTsEG7gn+7mhi0U1BYuZ/K6gw7nOdNVy8vaB4Hh9h3SCz3DW7VwpNfXeCDxrhxWV8Q/u0dlC3PKgHbMsjp4Q+gcnfRpnn+iMtfX2HR10oKhc5Rp1HtEfjj8dw/bAfFtiiQru/pePE4pWcAYqSK9zvNMEGVTDC4PM68rMkf4V3fZSrj4AOhwPBjJGAIqLzfJfbhfdemm70kDchw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3851.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(376002)(136003)(366004)(396003)(186003)(36756003)(478600001)(66946007)(66476007)(66556008)(2906002)(16526019)(52116002)(8936002)(956004)(6666004)(2616005)(6506007)(5660300002)(6512007)(83380400001)(6636002)(316002)(26005)(86362001)(44832011)(8676002)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?y/yqQ+7oQgvJ1v2yze/8Jxqt5vmF+w2Wr3eRdUXeS0AevCCj0tNaGue7EVCE?=
 =?us-ascii?Q?lxXhXBvBE+FdJn9dqAWHNiNk8XJw7UKtiWcZuHSJERQ3oFjCifWRyx36Ynuq?=
 =?us-ascii?Q?z7wuUvx7TuwuAPpo4XlIepbqPoLXDKukDVYtqlzPTuAgeu0oEt08CtW0Hhdz?=
 =?us-ascii?Q?sgmuT09htidtLEERS7NPrTeZxdiVQ09C32PD0UyxlCB53uqtC1wkJ1IFlGiy?=
 =?us-ascii?Q?c2igVyFIpD0xHLS+6a2bcjs7V+JmS2nmmh8SGQCEhZBsXSpv+qkVh5Y6DDPk?=
 =?us-ascii?Q?o6uQ4J9e1/81Xl6OkmWhpf2GhbABeUHwFtibYwOOhFxfg+brGXs8DVzp8Mo9?=
 =?us-ascii?Q?gNAqI7Z0189nMps6GNAFgIQ2PjA58RRDJYthzkyFrY9M6YDN8qg5uUx+2bOR?=
 =?us-ascii?Q?c6+qhDl5jt21kzyQhmxg/B1Ke2kxSJJnfTI8OM3dDQEeOKeaNim/at9hsyqB?=
 =?us-ascii?Q?gyN2He22wbc4/BA774hVNL/IVLs9l8Zl9uV+UsJN8fJZeGuD2LTQvI4GcEP3?=
 =?us-ascii?Q?m7uiIHac1Jmu0FoB6gxmCpT5vYwpNnuDgEdpILB1hf1djafLvq3s4YW3Ttdl?=
 =?us-ascii?Q?P1j2f4kRfoflPK5o4a1x07i2Nh7CKrRPhVEAy8W8qg0TdH0HUxmjWfxdrMgE?=
 =?us-ascii?Q?/7HdF7eIyfWRqwHJHARZBaqJIGzFV3lVmTJ8SR6uzTsYJxiY2YQsdtBAvRdM?=
 =?us-ascii?Q?q3IYkRPAR0HadCxoBT+BV1sBRPgCqNepN9XfquueGc6ZC5dG3zPWG90Qs+jX?=
 =?us-ascii?Q?SR0erfNO1y3pXV4x9UlxipqxAWGCBcl8pQJ/YkfDVldabP7SSLQW2cTuPDSk?=
 =?us-ascii?Q?6EsfHNw5eK8HHgPAWR9B+gLpzz8LM85O/b73baixVFdm5AxYJQ8Wf41wA3Dy?=
 =?us-ascii?Q?CzIcKA8qBtlxlBaMd6REkxC352Vo6Pk3gwR4snqyxQaZdz5rgXaB+XScM7nN?=
 =?us-ascii?Q?N9PeLFvObQAicVkZf1nFyJNEazn87gq1lj4Lxryv1JabQbI/rRZ/i3RzpGad?=
 =?us-ascii?Q?/d4Y5ezLrnjHUprmgmemjRsL2JPVWODcEaeEiiXYvMv29dN6CzfD+fb1S/zq?=
 =?us-ascii?Q?d7s7aiNS?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 221bc758-2f55-403b-87ef-08d8c224a446
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3851.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2021 18:03:10.5251
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OfPZsszBPFeVvO1E8nIOSmPIZKvS1ho/A5qlftbWTkip5bxRZtpzwcCGhiOkUsUOw035l+rJki6JOYc3LwoTPp8XVenZhcZqJX0MjWYNEZY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5341
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9876 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 phishscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101260094
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9876 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 phishscore=0
 adultscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 clxscore=1011 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101260094
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During boot of kernel with CONFIG_KASAN the following KASAN false
positive failure will occur when ibft_init() reads the
ACPI iBFT table: BUG: KASAN: use-after-free in ibft_init

The ACPI iBFT table is not allocated, and the iscsi driver uses
a pointer to it to calculate checksum, etc. KASAN complains
about this pointer with use-after-free, which this is not.

Signed-off-by: George Kennedy <george.kennedy@oracle.com>
---
 drivers/firmware/Makefile | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
index 5e013b6..30ddab5 100644
--- a/drivers/firmware/Makefile
+++ b/drivers/firmware/Makefile
@@ -14,6 +14,9 @@ obj-$(CONFIG_INTEL_STRATIX10_SERVICE) += stratix10-svc.o
 obj-$(CONFIG_INTEL_STRATIX10_RSU)     += stratix10-rsu.o
 obj-$(CONFIG_ISCSI_IBFT_FIND)	+= iscsi_ibft_find.o
 obj-$(CONFIG_ISCSI_IBFT)	+= iscsi_ibft.o
+KASAN_SANITIZE_iscsi_ibft.o := n
+KCOV_INSTRUMENT_iscsi_ibft.o := n
+
 obj-$(CONFIG_FIRMWARE_MEMMAP)	+= memmap.o
 obj-$(CONFIG_RASPBERRYPI_FIRMWARE) += raspberrypi.o
 obj-$(CONFIG_FW_CFG_SYSFS)	+= qemu_fw_cfg.o
-- 
1.8.3.1

