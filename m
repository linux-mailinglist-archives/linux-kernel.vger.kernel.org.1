Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E34842C66A5
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 14:21:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730407AbgK0NUK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 08:20:10 -0500
Received: from mail-eopbgr60065.outbound.protection.outlook.com ([40.107.6.65]:15047
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729169AbgK0NUJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 08:20:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9A7jyF9nJCx5qjd6mb9MA3ZfKz/fr2f9ttL3ctZTfxQ=;
 b=lk8vgOFl6kVbdcta8kFUtSd1hJYDp9QCkl6batXCJkSbVOeryHM11FJ2iLumDR33dDjlg6GjArUcebLdZhB+6wBPqZjy5yHXyhNLeL8tO0vga3c/MGhLzcyQ9JUn9ZhATsfrIxPumljWkKnoB4KSiAgMp0VVTwKUTKRCQ8FD82Q=
Received: from DBBPR09CA0007.eurprd09.prod.outlook.com (2603:10a6:10:c0::19)
 by VI1PR0802MB2397.eurprd08.prod.outlook.com (2603:10a6:800:ba::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.24; Fri, 27 Nov
 2020 13:20:03 +0000
Received: from DB5EUR03FT026.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:c0:cafe::5a) by DBBPR09CA0007.outlook.office365.com
 (2603:10a6:10:c0::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend
 Transport; Fri, 27 Nov 2020 13:20:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT026.mail.protection.outlook.com (10.152.20.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.26 via Frontend Transport; Fri, 27 Nov 2020 13:20:03 +0000
Received: ("Tessian outbound 39167997cde8:v71"); Fri, 27 Nov 2020 13:20:03 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: ed2580a6f81f2e3b
X-CR-MTA-TID: 64aa7808
Received: from 101fef75b2b3.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 3020D548-B854-468E-AD38-42394A12F666.1;
        Fri, 27 Nov 2020 13:19:58 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 101fef75b2b3.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 27 Nov 2020 13:19:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SthThQMQPbTk/YiRyPCygY0nI/tM7T5S87cxpXX7GyX/UZQWuj28wYJ9QK/LyDVe7VoApn5QfnF8zIuZae/LQODqeAUcDq7D7LJHwmGhybgKvp6ziz757l35iGQ/Il04Eocw2G7+iImCzbna0BX7WvbaU2/afbJLuOLT3A3f1p5qaxbfa8DozM7hqqW7G1+4hKf+5QeCk1eW0L4KdnuJQGq8BmW5o/nI3lpFL5zNH/rPpYSkfHjBnvcpSSz6GGm5/ruYTe69c/MO+4fsD9Fi9k0pBhpOF1xvQpI2k3rQ6Wy84kG0ZUn/hLEOCsFCk6ij2Zsamg2/tPu+X5kcH0spxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9A7jyF9nJCx5qjd6mb9MA3ZfKz/fr2f9ttL3ctZTfxQ=;
 b=GpGiTrR6ZE0P7wuT59kguCB0pkOIA+UwvPRo1nrjo5+Cp6qr5Au6g31nzVZ6C9+vRwpf6yZj8slOcZdj7PZzEJsK2iglPx7jNfYbK4ZPTV8XPz/kT66duwaTDRdGQ/12aZyAsduvReAZXFtbVYPsqQryPJnLzP+/z3GVRB2UBJyGRj6j4ks9WWHWkVvz9dj+JO0gq71mH0MOrLtdeVHMb3/ByQaxdipTLl3v3CUmFJIe0ATq1hOu/omJMW3ealy+pjeIxclz/OxXhMOvoE5DE1/Dksnpn8BpahIXl9UuyPGXljbpBPTBNwiDf7b9Hj8eP5o53ijrIjmeWt3TGHlRig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9A7jyF9nJCx5qjd6mb9MA3ZfKz/fr2f9ttL3ctZTfxQ=;
 b=lk8vgOFl6kVbdcta8kFUtSd1hJYDp9QCkl6batXCJkSbVOeryHM11FJ2iLumDR33dDjlg6GjArUcebLdZhB+6wBPqZjy5yHXyhNLeL8tO0vga3c/MGhLzcyQ9JUn9ZhATsfrIxPumljWkKnoB4KSiAgMp0VVTwKUTKRCQ8FD82Q=
Authentication-Results-Original: sourceware.org; dkim=none (message not
 signed) header.d=none;sourceware.org; dmarc=none action=none
 header.from=arm.com;
Received: from PR3PR08MB5564.eurprd08.prod.outlook.com (2603:10a6:102:87::18)
 by PA4PR08MB6014.eurprd08.prod.outlook.com (2603:10a6:102:ee::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Fri, 27 Nov
 2020 13:19:57 +0000
Received: from PR3PR08MB5564.eurprd08.prod.outlook.com
 ([fe80::ac13:db5:ef4:2dd2]) by PR3PR08MB5564.eurprd08.prod.outlook.com
 ([fe80::ac13:db5:ef4:2dd2%4]) with mapi id 15.20.3611.025; Fri, 27 Nov 2020
 13:19:57 +0000
From:   Szabolcs Nagy <szabolcs.nagy@arm.com>
To:     libc-alpha@sourceware.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Jeremy Linton <jeremy.linton@arm.com>,
        Mark Brown <broonie@kernel.org>,
        kernel-hardening@lists.openwall.com,
        Topi Miettinen <toiwoton@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 1/6] aarch64: Fix missing BTI protection from dependencies [BZ #26926]
Date:   Fri, 27 Nov 2020 13:19:43 +0000
Message-Id: <8756cc1083eb4cd93d3766cd39b2f34b6623bbcb.1606319495.git.szabolcs.nagy@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1606319495.git.szabolcs.nagy@arm.com>
References: <cover.1606319495.git.szabolcs.nagy@arm.com>
Content-Type: text/plain
X-Originating-IP: [217.140.106.54]
X-ClientProxiedBy: DM6PR11CA0031.namprd11.prod.outlook.com
 (2603:10b6:5:190::44) To PR3PR08MB5564.eurprd08.prod.outlook.com
 (2603:10a6:102:87::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (217.140.106.54) by DM6PR11CA0031.namprd11.prod.outlook.com (2603:10b6:5:190::44) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend Transport; Fri, 27 Nov 2020 13:19:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 0a05e900-40fc-469d-2cc7-08d892d7269d
X-MS-TrafficTypeDiagnostic: PA4PR08MB6014:|VI1PR0802MB2397:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0802MB2397A235B4CAAF0AD0B43219EDF80@VI1PR0802MB2397.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:6790;OLM:6790;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: uSOwfWKWO7RxbVFSGdFP/D5GTUPDuWc6xJHr7c2rKOJx6XtCt45M03i7MD4PK3VtDRWG0coWsJjud9+eS9NV1vvzyY+na74m5ImrbrJJBkyUb3StlEcpihIkClCgAr7UEcRNF+apCI/27rWWsJOR6cYafjGzw1odfcoWw+aWv6MYNYh9bT0WAFqczem3BfDdQjLiOtt5tIC+VY2BID/p/gerYuv+UBUuuzPZRToaBaVIM8rO4iyhqSj87Ijy+2eV8YlyhohWNRObi/zNTYl/+gNCYbr7+IeBVNgKZILxTMq4jiu9RTrIM1eTTY47c4bIieKNBivTlRRoxeorr7Q8xZNHPDAJ8vMZ3WxmCaXMVxOKSlq2LhRwptAZOWVlNJhk
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR08MB5564.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(376002)(366004)(396003)(4326008)(54906003)(69590400008)(6916009)(6512007)(36756003)(6486002)(6666004)(316002)(478600001)(5660300002)(2616005)(86362001)(44832011)(2906002)(956004)(8936002)(16526019)(186003)(26005)(8676002)(66476007)(66946007)(6506007)(66556008)(52116002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?mE0W7bVcxrzcoVIn/VsONJxpsphrN/LkSiNomsqtOsOC3e0N1nrc341aqCU4?=
 =?us-ascii?Q?R2J+YZKxtOPrETF6gwx1S0FRj8qq7NB1X29cF5vsWJVHw5dv6/2D7bzmjzPh?=
 =?us-ascii?Q?m42EGMzdCEJz/1MKzqONSC/TtsD00YDY7Gx2semgeWEHgS1oWrmE6kBFo9J2?=
 =?us-ascii?Q?snqrjThRD346+X1Gadu0TuAdugaA0eVrdlkakrPdwqgWsh+CXn3PlHxoSApq?=
 =?us-ascii?Q?1NmR9dFHNIzqMJeH04rfZeo9mP3t5p2mm8K77dVyVJzGiKj1l/TMkadaatwf?=
 =?us-ascii?Q?VfQgCQiDC5Kk4AF2B8XMeVppDtG+LDXmbcnWRISGcOAN3hwEay0WZL4d+myf?=
 =?us-ascii?Q?OENIkyQ0clcbamNWybUU5kGCgeaMVBXqPQGVphwkveIuiRqgZRgUNPD6W5Z9?=
 =?us-ascii?Q?ZlJYB3OdOH4RouMLHK7JnaZd1IzupglxEv1AAGQ9FaHt01etzZhL/cGuATAn?=
 =?us-ascii?Q?gROoNINu53r4m9MA6aH/rNc3qTrA16cs7ukEem04sEk5/psQ0SNnJHbD9/iU?=
 =?us-ascii?Q?ZKioyxsHRSIPTiJo6E3b63jmfMsqxhKHTSZ2Uo3oXkboo87BERejQaGbjbc6?=
 =?us-ascii?Q?4P6gyno7uRytQ5rx4OwKOM9qHVED4U4An42sLpwcN1fCZMUe0GZXpOFpZ5Ug?=
 =?us-ascii?Q?KvTavmAKmqP5NLaqWg88ssisgj0c+3XK26Pn0ryxbJSQm9s7GQssys/QgRW+?=
 =?us-ascii?Q?i9Jo7+tcf2y0Bf/jiwdMBh9f2yJ7KIQpAaJrPS7LwfPCyip4wxx74XLdeJw1?=
 =?us-ascii?Q?tZLKaq5+VeAhEhtLQEbJS4+Vb0I2ytXihAWQs9rtzYzJl/+aJd50c0tM32Dl?=
 =?us-ascii?Q?lryjnKFdNEmIjiJ520/0h6diOFw+DXPLRCBDLcwinAvPxhyEOyoLlYGESM8z?=
 =?us-ascii?Q?EOs1mGWKN/FEjRJqSmjt0Pk5QX8eHJzRo9iPGLbd81273R06CyVXqFLxct2z?=
 =?us-ascii?Q?dQvUQ8vrw1Su9Jc33BuQHzLig4nRpzpPZWV3TW40Q+Pajmw4UkctetstoG3j?=
 =?us-ascii?Q?COzK?=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6014
Original-Authentication-Results: sourceware.org; dkim=none (message not signed)
 header.d=none;sourceware.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT026.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 452f73ad-b22f-4e13-96b2-08d892d722a2
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3W5x1ySuau6GWglP3QEJDKQMXZjrUfYTfQi+13vW+NS+3lMQ9o1dLUcYsE2nc1yL3NuA4+MuqY1wl5osoSV/WnSrME8z9mMGIw+CWH4XelA2q3/gvSYgkFbmnWOF5QMvcylKeA9D/BgErHdyfAo9fckHY4EPyullsTiyzspf10d9UkrdW/fa+tvk9ycsJOD7Ph0Z6vRCOHamv0WBwq4i5w7X+r11qhKd4sP7MQfnDX41mkPgtQV1HavAw/hgXQ/m2rSXxO/ijgKsHDb3EeHkKRyMdGCVCAYZXjBk8qh+4/D7o20t9lJgOxnAnznyGWBjrWjd9f5ymR+TAPmzDWkTwBA0KNE+Q0l+3/xauXPxi5fKDNp0O44fiNd+UtzpSFOzCFNJzQr88mNb/MvAYGhhjunQyvZ8miNQtW9g9jUpA4Wd/xmAGVQ2iFGx+9954vRI
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(376002)(39860400002)(396003)(136003)(346002)(46966005)(44832011)(336012)(86362001)(4326008)(478600001)(34206002)(54906003)(70206006)(16526019)(956004)(83380400001)(69590400008)(2616005)(186003)(6486002)(82310400003)(316002)(6512007)(356005)(70586007)(107886003)(5660300002)(82740400003)(36756003)(6666004)(6506007)(8676002)(47076004)(26005)(8936002)(2906002)(81166007);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2020 13:20:03.6313
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a05e900-40fc-469d-2cc7-08d892d7269d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT026.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0802MB2397
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The _dl_open_check and _rtld_main_check hooks are not called on the
dependencies of a loaded module, so BTI protection was missed on
every module other than the main executable and directly dlopened
libraries.

The fix just iterates over dependencies to enable BTI.

Fixes bug 26926.
---
 sysdeps/aarch64/dl-bti.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/sysdeps/aarch64/dl-bti.c b/sysdeps/aarch64/dl-bti.c
index 196e462520..8f4728adce 100644
--- a/sysdeps/aarch64/dl-bti.c
+++ b/sysdeps/aarch64/dl-bti.c
@@ -51,11 +51,24 @@ enable_bti (struct link_map *map, const char *program)
   return 0;
 }
 
-/* Enable BTI for L if required.  */
+/* Enable BTI for MAP and its dependencies.  */
 
 void
-_dl_bti_check (struct link_map *l, const char *program)
+_dl_bti_check (struct link_map *map, const char *program)
 {
-  if (GLRO(dl_aarch64_cpu_features).bti && l->l_mach.bti)
-    enable_bti (l, program);
+  if (!GLRO(dl_aarch64_cpu_features).bti)
+    return;
+
+  if (map->l_mach.bti)
+    enable_bti (map, program);
+
+  unsigned int i = map->l_searchlist.r_nlist;
+  while (i-- > 0)
+    {
+      struct link_map *l = map->l_initfini[i];
+      if (l->l_init_called)
+	continue;
+      if (l->l_mach.bti)
+	enable_bti (l, program);
+    }
 }
-- 
2.17.1

