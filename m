Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9EBE2CB7DE
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Dec 2020 09:58:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387797AbgLBI4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Dec 2020 03:56:37 -0500
Received: from mail-eopbgr00069.outbound.protection.outlook.com ([40.107.0.69]:65211
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725962AbgLBI4g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Dec 2020 03:56:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NXffKCVdJsUjKE9yUrpY+buHuATx7T0FPdE9nZs50nw=;
 b=vSMTNbXrQU5lwa5eZUsj8zsbVBkCsrSg4o9mnBiB0hyEeAZRDUWimd+2CenBqpwq8XpmL6f0wvcRKveRBBVEEMFoFue4/XI73ekbfeyZwMCHC0w5JAbEBwED8WTrkLeuqLJVnL70cs/vzESWQ2H9ZjUxfKqJSXcV6xfMvyu5+GU=
Received: from AM6P194CA0061.EURP194.PROD.OUTLOOK.COM (2603:10a6:209:84::38)
 by DB8PR08MB4571.eurprd08.prod.outlook.com (2603:10a6:10:ac::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Wed, 2 Dec
 2020 08:55:46 +0000
Received: from AM5EUR03FT035.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:84:cafe::7) by AM6P194CA0061.outlook.office365.com
 (2603:10a6:209:84::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.18 via Frontend
 Transport; Wed, 2 Dec 2020 08:55:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=timeout (key query timeout)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=bestguesspass
 action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT035.mail.protection.outlook.com (10.152.16.119) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3632.17 via Frontend Transport; Wed, 2 Dec 2020 08:55:44 +0000
Received: ("Tessian outbound 665ba7fbdfd9:v71"); Wed, 02 Dec 2020 08:55:44 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: cc6684c77939eb35
X-CR-MTA-TID: 64aa7808
Received: from 18861434d5cb.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 82D6A3AF-2B19-4BE3-829F-D7F3941207C0.1;
        Wed, 02 Dec 2020 08:55:29 +0000
Received: from FRA01-PR2-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 18861434d5cb.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 02 Dec 2020 08:55:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=E12fujD0czzKZF+/mnx/FUkpEgw6pnYl4yx77VuCXJQIWv/0hD1JLGepDHBN6iRd13QSPrCiv+rjt92W6xR0ruKqmlWvLBNKnQ1j+3t5d30B3lxLVnrzG0aYqGBsE3cWwX2A9DVIliVwfsykyVg6M58IQf6Zxt90g2Hg5kKadYtEx9GCv3DXfIg+uwHx8Dhmmt2PDnEaiV6c/4Bo3AoHtI51+86RXPh7XfjAr8vCkb/3mxR0gb7Ki1OA3zB5JV5xWx7QuZ3aE/boknhPOT1MKj0OcwFZtAsAhBlNOEpokc9N15I733Kzv9LNAX39m40wE6PinyZhaHa+ZZnFxoUGjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NXffKCVdJsUjKE9yUrpY+buHuATx7T0FPdE9nZs50nw=;
 b=Z4eSfQchURAByrWGoERGguHqXjUcbJV/AVExA+U3XTWM+86JEWE8osrzxHezhvL5EWdvYVqTSYzHBjvbiCFzPXCI/6kNQgij3krKVSfB/zjgwo8y8zxFaBHf8WSto7rCyEy7Oh3SjyyfdYpu2OSjdnBQf+hEVjkIhDHLNEudvEX0a0n3h2QqCN/EnxOngHbJEMwkpiyOEOVUOmNJ6uBDeh78pDbVuCfhnrAiTYqWrS0vPZgQ+AgzvM1oyKCJzlV5YF/ApGHWEap5Z6lcisO+0XIRqjq+dz8qFMddI8tcTnLWRBsvfoPuKWFz/jj5yefvOzP5CFUI7TivJRpPw1c8Sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NXffKCVdJsUjKE9yUrpY+buHuATx7T0FPdE9nZs50nw=;
 b=vSMTNbXrQU5lwa5eZUsj8zsbVBkCsrSg4o9mnBiB0hyEeAZRDUWimd+2CenBqpwq8XpmL6f0wvcRKveRBBVEEMFoFue4/XI73ekbfeyZwMCHC0w5JAbEBwED8WTrkLeuqLJVnL70cs/vzESWQ2H9ZjUxfKqJSXcV6xfMvyu5+GU=
Authentication-Results-Original: sourceware.org; dkim=none (message not
 signed) header.d=none;sourceware.org; dmarc=none action=none
 header.from=arm.com;
Received: from PR3PR08MB5564.eurprd08.prod.outlook.com (2603:10a6:102:87::18)
 by PR2PR08MB5225.eurprd08.prod.outlook.com (2603:10a6:101:1c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.31; Wed, 2 Dec
 2020 08:55:28 +0000
Received: from PR3PR08MB5564.eurprd08.prod.outlook.com
 ([fe80::ac13:db5:ef4:2dd2]) by PR3PR08MB5564.eurprd08.prod.outlook.com
 ([fe80::ac13:db5:ef4:2dd2%4]) with mapi id 15.20.3611.025; Wed, 2 Dec 2020
 08:55:27 +0000
From:   Szabolcs Nagy <szabolcs.nagy@arm.com>
To:     libc-alpha@sourceware.org
Cc:     Mark Rutland <mark.rutland@arm.com>,
        kernel-hardening@lists.openwall.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org,
        Jeremy Linton <jeremy.linton@arm.com>,
        Mark Brown <broonie@kernel.org>,
        Topi Miettinen <toiwoton@gmail.com>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 1/2] aarch64: align address for BTI protection [BZ #26988]
Date:   Wed,  2 Dec 2020 08:55:14 +0000
Message-Id: <d460a4f7aa4d70cc205f08896ed50b31fcd992df.1606898457.git.szabolcs.nagy@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <ebce134991eae4261bbb32572a2062d3ca56e674.1606319495.git.szabolcs.nagy@arm.com>
References: <ebce134991eae4261bbb32572a2062d3ca56e674.1606319495.git.szabolcs.nagy@arm.com>
Content-Type: text/plain
X-Originating-IP: [217.140.106.54]
X-ClientProxiedBy: SA9PR13CA0048.namprd13.prod.outlook.com
 (2603:10b6:806:22::23) To PR3PR08MB5564.eurprd08.prod.outlook.com
 (2603:10a6:102:87::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (217.140.106.54) by SA9PR13CA0048.namprd13.prod.outlook.com (2603:10b6:806:22::23) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3654.5 via Frontend Transport; Wed, 2 Dec 2020 08:55:24 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 50854f6e-7555-4faa-e26c-08d896a00e39
X-MS-TrafficTypeDiagnostic: PR2PR08MB5225:|DB8PR08MB4571:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DB8PR08MB45714548BDCEF75FACB9499FEDF30@DB8PR08MB4571.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:2958;OLM:2958;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: XQm/MD2nC9jVAqH51R5remRXNMVEC+ZEC8vuP0FPtPiCjKDYxT4QJtW9W6xRWtUGwXiSBCjFPVgKw3kjSwHWeLeMVieRew979/C4K4+VzaDKfxN7rGstWPMzrUR95VP9qlVztwGR9E7+d9HNirN1YuXK1UmcR4WCRfGs2VtgiP2csdDOmNJ3wngbHEWDqogmIjAqLr+9zFALTCjVdYcLX7Cz4IkYjTOh0S0XkperrBQWCQe+ftzD2Q9zPe8azjoP5OwGyh4upVI7Bc6pBYxX45DSe+GyXPk7hUU8squfCQiUpKEUn8TIGMkyDFKrKPB4wQF5jEA9415q8fTA6jXhJPX2nE87pWMwJsJZz7Qtjb2ORxc3Q9p1jb5Grom5vzdn
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR08MB5564.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(366004)(39850400004)(396003)(6506007)(6512007)(2616005)(6916009)(2906002)(4326008)(86362001)(36756003)(44832011)(5660300002)(16526019)(316002)(956004)(83380400001)(26005)(52116002)(6666004)(8936002)(186003)(66476007)(478600001)(66946007)(69590400008)(66556008)(6486002)(8676002)(54906003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?tf69SYnzRWkaNKv0ag04kv0/kv4K4DyvGgFFBvFHiU9lZ1p4dDN7IbD+YVxl?=
 =?us-ascii?Q?o1MoQfpB+MXuZJg5TkzM8ZaUUkWJrU6aMP21Msq7Sgf7dzi+lrQK9SSHY9H7?=
 =?us-ascii?Q?G8R3vQyFDXLCu9tZnsu+yR/BBIxjACQjDqprwu5PLf6Mg2YEZqE6FNf5Izas?=
 =?us-ascii?Q?PQpEKSdv759zyHFHJA/2e6Eq2j4wXcOcOPfImaH0V7/RT6ZhHkHTWkjjno25?=
 =?us-ascii?Q?SDbf2mPctb2PCC59uYaPL6UUrPdPKh+agt6r21+nt0zvOzR8qCevcY9L6S37?=
 =?us-ascii?Q?EwoeDXIJ/44A/zrAo521hfTZUK2DUoqZdImSU1Yvomj4/T3mOqaLNexGNiIi?=
 =?us-ascii?Q?CFJ/sqd/W6JNFvS1hH8RjxuzP1IbuTM89u+5E38I+L/JNNvBWcBUr8C6w9Rp?=
 =?us-ascii?Q?CSwLwisSke501wtPeN6X+jUhNMA4d+6mlfQVl4losBUKgsC/myANIZms1y4v?=
 =?us-ascii?Q?6iU/9Ma46PO6IlYFBOmxmScLy4nTOfIlvNcgVtSA/1v5/WVzW8ne/QH+kg6X?=
 =?us-ascii?Q?BTwVfZytHer0oBmYaGrxrBwFZYaWDb0lOtpbA59X6b1QFUq3nILm+yX+ayxo?=
 =?us-ascii?Q?YZZnCsF+PvjQ1MqAY+Qyt/7gnmYvjTBvVdbuFO+SLxPYQL28VMbdlMSD4wyu?=
 =?us-ascii?Q?VCXy5YuPYBdMKikmz8G5+9ckp9OT/GAD4xIoG2EcibtRjPNIlGWHmRnKbwJr?=
 =?us-ascii?Q?T9jrMEj8Wi6leg3lGnwqcMHbxrxpI+MTwAt7p+OA72VYyCgtgKjX23GlyvMT?=
 =?us-ascii?Q?HwSWXaEzzv+q77uVFRqlx/zsesjtSMFwLgshg6ai4+EijvRDIuGdvYpG0oB0?=
 =?us-ascii?Q?CtGPfpUrPnjYNhuihPz1C5Rp2B/Yf6KO9p5QZcxfx0p+lIEPIS3IAlabOuzq?=
 =?us-ascii?Q?eGcaQQe5AOJfmmdXLIfC8nQBdxYJ4C3PhQOAR6GFP3l4CAU8wcIa7iDw31lI?=
 =?us-ascii?Q?jW3bVEQerYkqISI3mqWq+iq8Wt5BkmqfcjJoLKaCSlctbPmUDxgCZ5Jt4n4t?=
 =?us-ascii?Q?tnYO?=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR2PR08MB5225
Original-Authentication-Results: sourceware.org; dkim=none (message not signed)
 header.d=none;sourceware.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT035.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: a1bf3ed6-a11e-46b9-875a-08d896a003ba
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dxNDiIL+Oejvw2x79KmtUlk4DI9kRNgpkA2twwV0iknG03tZGsr0Ri0yhEnxZ9BP50XWLVP+uXEXKqhgSw3juM4L7vwViTHt56ZLCSidnIFuxFTJeemVHHbNwmHTjzNIgd3bCRuwELXcZvJ9ARg037qC2tA0AGXdBrR7Hvg14Za/1tWlyK/2jhT+6cgxkkwwpH5asznDKIC0c5pC2N/VjV3eM25udjOQoFhE12tLyPKuSe0xDqaXGT70ALrmwqaRvyn5AxliCxzLceXG6LuGazfa46m7HgOUpiIeXBOtVvTqX2A63cvBcAquUeTUYLrBagg7oW7g9oV4ShcPE1h9A/iS4AIyI4jqqZweFjtsmAug0O0J0GK99cDkXM9MoqTYlOBKaRCxdkdUTTfOS5GwThOkV67WTQwnrgBAEB6g+p2hIXpmHL5VOtNwBP+K8aHD
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ErrorRetry;CAT:NONE;SFS:(4636009)(346002)(376002)(39860400002)(396003)(136003)(46966005)(2616005)(336012)(478600001)(6506007)(81166007)(86362001)(5660300002)(47076004)(83380400001)(70586007)(956004)(82740400003)(70206006)(44832011)(6666004)(316002)(54906003)(107886003)(356005)(6486002)(8676002)(186003)(2906002)(82310400003)(16526019)(6512007)(8936002)(4326008)(69590400008)(34206002)(36906005)(36756003)(26005);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2020 08:55:44.9813
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 50854f6e-7555-4faa-e26c-08d896a00e39
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT035.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR08MB4571
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Handle unaligned executable load segments (the bfd linker is not
expected to produce such binaries, but other linkers may).

Computing the mapping bounds follows _dl_map_object_from_fd more
closely now.

Fixes bug 26988.
---
v3:
- split the last patch in two so this bug is fixed separately.
- pushed to nsz/btifix-v3 branch.

 sysdeps/aarch64/dl-bti.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/sysdeps/aarch64/dl-bti.c b/sysdeps/aarch64/dl-bti.c
index 8f4728adce..67d63c8a73 100644
--- a/sysdeps/aarch64/dl-bti.c
+++ b/sysdeps/aarch64/dl-bti.c
@@ -20,19 +20,22 @@
 #include <libintl.h>
 #include <ldsodefs.h>
 
-static int
+static void
 enable_bti (struct link_map *map, const char *program)
 {
+  const size_t pagesz = GLRO(dl_pagesize);
   const ElfW(Phdr) *phdr;
-  unsigned prot;
 
   for (phdr = map->l_phdr; phdr < &map->l_phdr[map->l_phnum]; ++phdr)
     if (phdr->p_type == PT_LOAD && (phdr->p_flags & PF_X))
       {
-	void *start = (void *) (phdr->p_vaddr + map->l_addr);
-	size_t len = phdr->p_memsz;
+	size_t vstart = ALIGN_DOWN (phdr->p_vaddr, pagesz);
+	size_t vend = ALIGN_UP (phdr->p_vaddr + phdr->p_filesz, pagesz);
+	off_t off = ALIGN_DOWN (phdr->p_offset, pagesz);
+	void *start = (void *) (vstart + map->l_addr);
+	size_t len = vend - vstart;
 
-	prot = PROT_EXEC | PROT_BTI;
+	unsigned prot = PROT_EXEC | PROT_BTI;
 	if (phdr->p_flags & PF_R)
 	  prot |= PROT_READ;
 	if (phdr->p_flags & PF_W)
@@ -48,7 +51,6 @@ enable_bti (struct link_map *map, const char *program)
 				N_("mprotect failed to turn on BTI"));
 	  }
       }
-  return 0;
 }
 
 /* Enable BTI for MAP and its dependencies.  */
-- 
2.17.1

