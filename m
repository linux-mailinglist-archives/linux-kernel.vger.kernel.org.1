Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C8A02C66A6
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 14:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730411AbgK0NUb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 08:20:31 -0500
Received: from mail-eopbgr60088.outbound.protection.outlook.com ([40.107.6.88]:8125
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729402AbgK0NUa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 08:20:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=slIbyxS48hCYiEWuhWEE/Oa6nVJ/gAblbWHjFFkv6s8=;
 b=taFM8hUgOnIBKEaVp+Zor4s+41Ip+tHCUhiyztCmtIpD5YeVOJjq9A/pwCFBx0QQXUqMm9ia5ucqRPGYJJmGiEAhY7wxNUfx5mBWX01Uw46fd4KjdsU/OyX5YfYnbOfgdAQJAtQCHU7HeMY3DKk1sZkgabT53BGpQpYouBuYNI4=
Received: from DU2PR04CA0110.eurprd04.prod.outlook.com (2603:10a6:10:230::25)
 by AM4PR0802MB2193.eurprd08.prod.outlook.com (2603:10a6:200:5b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3589.22; Fri, 27 Nov
 2020 13:20:25 +0000
Received: from DB5EUR03FT007.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:10:230:cafe::9d) by DU2PR04CA0110.outlook.office365.com
 (2603:10a6:10:230::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend
 Transport; Fri, 27 Nov 2020 13:20:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT007.mail.protection.outlook.com (10.152.20.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.26 via Frontend Transport; Fri, 27 Nov 2020 13:20:25 +0000
Received: ("Tessian outbound 13ed5f5344c0:v71"); Fri, 27 Nov 2020 13:20:25 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: bfa20ae54c0ca7b5
X-CR-MTA-TID: 64aa7808
Received: from f4644680f99d.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id F327C572-4EB9-4F9D-8108-BC04F72577C4.1;
        Fri, 27 Nov 2020 13:20:17 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id f4644680f99d.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 27 Nov 2020 13:20:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uk5XPL8mkiafvct1eaKa4RBqBatDaQwqTzHoEy14pGTxqT7al/UhhKS6DHdkUPQhVebf42At1tIlRFh2Ug3mi5bXQEbq+xa+rn2lVVk5U8AtpbFWwn9zPMoYt2hiaHsship0Eb4OThqYQRZDHrOlWsioGNXXmrY5vJpI9CkAAlL1xiZti42O0reT91jngtyNWujUGrRMrUAGQhpNQ9pgKG+0JrlgWOIb+Dd0KJB+eFbD2Z/sxTPSoyfUmwlqAzf+r3YExhAWB5d8hmgXHudbjz7zIA0M3gJ3KrMkOviSfAwFkexDOBijlhXFizEtjBD/WTLJYHAhMQZnWLZZrA8mWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=slIbyxS48hCYiEWuhWEE/Oa6nVJ/gAblbWHjFFkv6s8=;
 b=jmLMu9SpaLUbY2sWMul9koJYiQdpwb719i2LbKrOWWk0UR6RgrfLj4diYVpolmSbPiWqkIOwBQSxAvu29+VDdC2Fl/tAOqV3CYYLLR+bQLxy6a4AivgJNIj3ElIs0YrWGncuJwDW+j+WGdbpjKzq16Jy6lnkUaUZL2zcHvX8ZYL3Fogdof8SDu10LTXD7RhSOdxviRcIMZo3gEuoKrK82ztauuzOONsAJXL6gQs9GmqJLBkBDaxCD7Rmr1eucOS3S09UF8OGUdSlt8kaYvrD4QyxZA6vlZTwpuMBh9cICnZmdN9e6wZ2oEMjc8JWWCAqjIYKkTZKtZyQGjIzNskgow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=slIbyxS48hCYiEWuhWEE/Oa6nVJ/gAblbWHjFFkv6s8=;
 b=taFM8hUgOnIBKEaVp+Zor4s+41Ip+tHCUhiyztCmtIpD5YeVOJjq9A/pwCFBx0QQXUqMm9ia5ucqRPGYJJmGiEAhY7wxNUfx5mBWX01Uw46fd4KjdsU/OyX5YfYnbOfgdAQJAtQCHU7HeMY3DKk1sZkgabT53BGpQpYouBuYNI4=
Authentication-Results-Original: sourceware.org; dkim=none (message not
 signed) header.d=none;sourceware.org; dmarc=none action=none
 header.from=arm.com;
Received: from PR3PR08MB5564.eurprd08.prod.outlook.com (2603:10a6:102:87::18)
 by PA4PR08MB5982.eurprd08.prod.outlook.com (2603:10a6:102:eb::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.23; Fri, 27 Nov
 2020 13:20:16 +0000
Received: from PR3PR08MB5564.eurprd08.prod.outlook.com
 ([fe80::ac13:db5:ef4:2dd2]) by PR3PR08MB5564.eurprd08.prod.outlook.com
 ([fe80::ac13:db5:ef4:2dd2%4]) with mapi id 15.20.3611.025; Fri, 27 Nov 2020
 13:20:16 +0000
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
Subject: [PATCH v2 2/6] elf: lose is closely tied to _dl_map_object_from_fd
Date:   Fri, 27 Nov 2020 13:20:10 +0000
Message-Id: <f6788964bf6412da6fcdd3be4f67eb0417e558a6.1606319495.git.szabolcs.nagy@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1606319495.git.szabolcs.nagy@arm.com>
References: <cover.1606319495.git.szabolcs.nagy@arm.com>
Content-Type: text/plain
X-Originating-IP: [217.140.106.54]
X-ClientProxiedBy: LO2P265CA0137.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9f::29) To PR3PR08MB5564.eurprd08.prod.outlook.com
 (2603:10a6:102:87::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (217.140.106.54) by LO2P265CA0137.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:9f::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend Transport; Fri, 27 Nov 2020 13:20:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 053b4a73-4f2a-4788-5da0-08d892d733a7
X-MS-TrafficTypeDiagnostic: PA4PR08MB5982:|AM4PR0802MB2193:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM4PR0802MB21930446FFC07AD5BCE68DA1EDF80@AM4PR0802MB2193.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 169udulgEyFULlkhHnw9txM9ywDvuQI1qogOg8kzYBLTuVIZMNwvjq/5jeZsWfHFgUmZVL+pujYlNsGm4Wwf7qZXYDBAv6bOjgLUYIru1o11Ac9qaGMGDmScQSkTfChPoN4d+sd/xZ5Qe1V9XYPlMdVNsyP25yICtJDuJbzUFRqjc+sUWP6KixQqs7cJVlJwBPUokMPZDtG2oE7OjL0iOQ71Hau7F0VMdZ6+98AqbgQtPpNM9Odf/paRcKEeeCJjwhpd5IA/q3VURKAvtF6P6qHDHVEXTUPkzMI7pDPH/rr1nk0q5TrXoitgHglPXiDuaqSnQBcbpvXAXmPwatEmmGLmsz5DOYLCl9FVbYw+rvmmpk2wkLaq0ZM8zitIFkmh
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR08MB5564.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(366004)(39860400002)(136003)(376002)(2906002)(6666004)(186003)(5660300002)(83380400001)(52116002)(69590400008)(956004)(2616005)(16526019)(6506007)(26005)(8936002)(6512007)(36756003)(44832011)(86362001)(4326008)(6916009)(6486002)(66946007)(316002)(8676002)(66556008)(66476007)(54906003)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?0fhxp9laLub2DCy5zx1lYWE1z6n0cGagE1A9atqcBUIigILKRbT+qcZ5yZbK?=
 =?us-ascii?Q?3u0kVwhpI6ywDbPLue19tomPJowHjJPfTpbQ6H4yIjQf0nyBqRudJr56DWoc?=
 =?us-ascii?Q?KSZ7Aw0xIPDEEzZlcUUU2x/FANgJevdCc3IWCQnkHPPAw1cEebcVLV5d7sut?=
 =?us-ascii?Q?QlJLO++nfvUd2aaaobNVkzERaDn/ckxzEIzRD+pPkg1JcQWZ9xwhsa2rNyNw?=
 =?us-ascii?Q?6iLmWCiQzp+KRB6Zt0QnnT22aPA3wYZn/GHKtbGhZNBsWL5UJgudUPGGHyev?=
 =?us-ascii?Q?47oej8moeU2k0FiZQPcqBU+YBxD05U3OxSNPvXAQqt4ZzTZwoHOeKSdZWIS3?=
 =?us-ascii?Q?+BMvMT54Y21vHibjhd1DXU9A50or8spsMPF/FLoeWe7pEkF9Vl/a7yFdqkAW?=
 =?us-ascii?Q?a/u2dcX6sXjRWyw1IejASGgBDVDj7e0QR2LpkyGEF2homKf61G7gXu0AWSsw?=
 =?us-ascii?Q?k81p/wlfKb7Ck04ZOonupU4f5/CtukVER2YFXkuttUiNdNCAOEcGrIrsojFs?=
 =?us-ascii?Q?rSPU67/04EhlYo4dXbO4cMUpheGZQeiGysRMsNahwHtUABYCP6DUBlVWAH1Y?=
 =?us-ascii?Q?50AtWUexZBUGfgfvs4jon8ubmdH716K8jX/PEDPDN8+ekhYroxM+VJYXpYfZ?=
 =?us-ascii?Q?2zKAaoC0nHR4Uypt8oeFrC+boi/bzPUgNguAzvxh4wonJX5GeThM7R9AiJRK?=
 =?us-ascii?Q?jpUtzKLfTpvvp9BMXN0CwSr/dAcw3DzYVRy276/UkJZ6IzfO0V1nwpcPg7u7?=
 =?us-ascii?Q?DeN3+fn8lqYsUCEfCxJRUfx6+xcD9BWbrPnyb/3nYbcpm9XlHUrcsQxEsgXC?=
 =?us-ascii?Q?ybRA2z1iozjQZYtBPXBgWhTRlexoAgjMFg9rORWAfIAuNuWw4i7+EgIhw4Ze?=
 =?us-ascii?Q?UJo9MAjnxlE3u0r6TpUDhNyUFeaDUjLDyp4NGW6LAef8NjYyWMwRQw1hAu5s?=
 =?us-ascii?Q?DjuAwsZTIientqHx+YegBgJ9q9P1i1pWrgT1maLhP/9Ed3BzrPjTIYZoHNM+?=
 =?us-ascii?Q?i8ZP?=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB5982
Original-Authentication-Results: sourceware.org; dkim=none (message not signed)
 header.d=none;sourceware.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT007.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 1cccce31-6dca-4b23-c130-08d892d72e0b
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HcC5jhQ7hc+dxdNyjUv9i0/bbX85/gGAl5adRlyfWLzoPvCKDLnk+pVrE8p3+1Wmj0p1dkbuqf0VhgIejlAjr4CDFdTWzyOAk5OVm98m/QrPWaZKhUobcFCef4gA6S4+pfDULeX2am7XqLa3+CfIJS2kmgjmCI0WHRbnCjlBpGPGo7nE+NMRaALkuTP8hCYPuqy58Z4Nuni7ue5CS5/uBxrs7VQvK+cSKymb7ZxLexrXDd4vR4TRBP1AcG+/mruba7boommB0cHBLiJacwKK4wKW1CeZypxWTvMu8QpIRiIym1JknPXgZTfpVAhwAy4OTN7z6UnA3tWcyTflrcSjtiKt3ibjyoNnjYuyl7+Ee1ACHFOb4ED5Nvw2MP25S+YWTvyGS+gKkKwX9+vC7Zc+/qbUniCIb9ugVmdLkMF9NDSakvBtwaPzWhgiUQCHCoQb
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(136003)(396003)(346002)(39860400002)(376002)(46966005)(69590400008)(6512007)(336012)(6486002)(2906002)(186003)(6506007)(8936002)(47076004)(81166007)(86362001)(26005)(16526019)(82310400003)(8676002)(82740400003)(5660300002)(2616005)(36756003)(44832011)(107886003)(6666004)(316002)(70586007)(356005)(34206002)(70206006)(478600001)(83380400001)(4326008)(956004)(54906003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2020 13:20:25.5075
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 053b4a73-4f2a-4788-5da0-08d892d733a7
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT007.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0802MB2193
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simple refactoring to keep failure handling next to
_dl_map_object_from_fd.
---
 elf/dl-load.c | 48 ++++++++++++++++++++++++------------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/elf/dl-load.c b/elf/dl-load.c
index f3201e7c14..21e55deb19 100644
--- a/elf/dl-load.c
+++ b/elf/dl-load.c
@@ -835,30 +835,6 @@ _dl_init_paths (const char *llp, const char *source)
 }
 
 
-static void
-__attribute__ ((noreturn, noinline))
-lose (int code, int fd, const char *name, char *realname, struct link_map *l,
-      const char *msg, struct r_debug *r, Lmid_t nsid)
-{
-  /* The file might already be closed.  */
-  if (fd != -1)
-    (void) __close_nocancel (fd);
-  if (l != NULL && l->l_origin != (char *) -1l)
-    free ((char *) l->l_origin);
-  free (l);
-  free (realname);
-
-  if (r != NULL)
-    {
-      r->r_state = RT_CONSISTENT;
-      _dl_debug_state ();
-      LIBC_PROBE (map_failed, 2, nsid, r);
-    }
-
-  _dl_signal_error (code, name, NULL, msg);
-}
-
-
 /* Process PT_GNU_PROPERTY program header PH in module L after
    PT_LOAD segments are mapped.  Only one NT_GNU_PROPERTY_TYPE_0
    note is handled which contains processor specific properties.  */
@@ -930,6 +906,30 @@ _dl_process_pt_gnu_property (struct link_map *l, const ElfW(Phdr) *ph)
 }
 
 
+static void
+__attribute__ ((noreturn, noinline))
+lose (int code, int fd, const char *name, char *realname, struct link_map *l,
+      const char *msg, struct r_debug *r, Lmid_t nsid)
+{
+  /* The file might already be closed.  */
+  if (fd != -1)
+    (void) __close_nocancel (fd);
+  if (l != NULL && l->l_origin != (char *) -1l)
+    free ((char *) l->l_origin);
+  free (l);
+  free (realname);
+
+  if (r != NULL)
+    {
+      r->r_state = RT_CONSISTENT;
+      _dl_debug_state ();
+      LIBC_PROBE (map_failed, 2, nsid, r);
+    }
+
+  _dl_signal_error (code, name, NULL, msg);
+}
+
+
 /* Map in the shared object NAME, actually located in REALNAME, and already
    opened on FD.  */
 
-- 
2.17.1

