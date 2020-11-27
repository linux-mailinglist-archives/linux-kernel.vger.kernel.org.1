Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB832C66AC
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Nov 2020 14:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730414AbgK0NVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Nov 2020 08:21:15 -0500
Received: from mail-db8eur05on2062.outbound.protection.outlook.com ([40.107.20.62]:16924
        "EHLO EUR05-DB8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729402AbgK0NVO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Nov 2020 08:21:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q1jU0aMUj4QfK8EyRD8DvcTi5AwkXzK9UGUF9Nf79/g=;
 b=v2zbgEDQfnkZznT5ohEdE1fg1znGlFpYrUJMX6R5umj5T5vE1qTEZnPP+1Ki84gp4RFQ3XcppV0jtzfjnfegC4FpfiIUUlDnLB5FVCuYG0k41GFqPNpiC2D390y13h+gQQhLpR8f5/IpzzJQGI8R2ttVv6rmmJAYIcIDTc5eqRY=
Received: from AM6P194CA0019.EURP194.PROD.OUTLOOK.COM (2603:10a6:209:90::32)
 by AM4PR0802MB2195.eurprd08.prod.outlook.com (2603:10a6:200:5d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20; Fri, 27 Nov
 2020 13:21:09 +0000
Received: from AM5EUR03FT020.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:90:cafe::d9) by AM6P194CA0019.outlook.office365.com
 (2603:10a6:209:90::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.22 via Frontend
 Transport; Fri, 27 Nov 2020 13:21:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT020.mail.protection.outlook.com (10.152.16.116) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3611.26 via Frontend Transport; Fri, 27 Nov 2020 13:21:09 +0000
Received: ("Tessian outbound 797fb8e1da56:v71"); Fri, 27 Nov 2020 13:21:09 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: ae0120a5a66a482b
X-CR-MTA-TID: 64aa7808
Received: from 887aa895777a.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id FAD0C319-BE1F-407C-ACE8-AE6C84572118.1;
        Fri, 27 Nov 2020 13:21:03 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 887aa895777a.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Fri, 27 Nov 2020 13:21:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Epwm4JhQr0QvK1ShXqOrTtIVSSpyD2ikjdRanp1E5C5+eAAfvfgkmXxSD6I477wSRYryU153ejgUrAa0d42RJHH5A5wprF9wLpPAIAM43yfBQgC5Ezc3MpWMRjKhcM7iHm3ubcGymYbrLGZS7DnsoLmjl98MivistEqG+lzA2geX/V/QRxE3oSJpaZwqcNFU57Opa2wC2zNjeFOKVuaCiYzppFevFQaXLytzSc01wfmhPoLNlHpvGJiYHX3ZEJfe0f7TQIJA6eGtVnQNsuAi7u7AuQCeP2uUAeG/hu93vOQwFNMzrnG2tLRiaQypIBf82ogfUqFQlq/2ilFn9kcHFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q1jU0aMUj4QfK8EyRD8DvcTi5AwkXzK9UGUF9Nf79/g=;
 b=n+Vrzwe2Iu52oJVldbv0ZPmgzJwxVYSocxzTKXfhMsfnB3ypsGjsjirkLfNMCbNtWeQfxVddRk73vhKRzg7XIKmvk1XCVBiSR4SyqvyZ4JdBjZvEG3Mo+dU4wC1FZNG0q3VUMDIXqa0rRE+PJfpLcKFXbPTuccAyDzaJeuSlD+UKm0d7DN5pU5agtPaMDRNHtzQbX7f+/UCnUEI1hqp0drdDsNfEzC432teEpABXOdg6nMPNzP9TWC4zPpKD4Pg5eL7IcZhDH7rv97fUvL/CSlPl48CmWjbiDlQA/2u8zyoS1e58Yb649vXyezH5J+KrvJQCHKxO8rGd9P1QTV+M3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q1jU0aMUj4QfK8EyRD8DvcTi5AwkXzK9UGUF9Nf79/g=;
 b=v2zbgEDQfnkZznT5ohEdE1fg1znGlFpYrUJMX6R5umj5T5vE1qTEZnPP+1Ki84gp4RFQ3XcppV0jtzfjnfegC4FpfiIUUlDnLB5FVCuYG0k41GFqPNpiC2D390y13h+gQQhLpR8f5/IpzzJQGI8R2ttVv6rmmJAYIcIDTc5eqRY=
Authentication-Results-Original: sourceware.org; dkim=none (message not
 signed) header.d=none;sourceware.org; dmarc=none action=none
 header.from=arm.com;
Received: from PR3PR08MB5564.eurprd08.prod.outlook.com (2603:10a6:102:87::18)
 by PA4PR08MB6014.eurprd08.prod.outlook.com (2603:10a6:102:ee::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.25; Fri, 27 Nov
 2020 13:21:02 +0000
Received: from PR3PR08MB5564.eurprd08.prod.outlook.com
 ([fe80::ac13:db5:ef4:2dd2]) by PR3PR08MB5564.eurprd08.prod.outlook.com
 ([fe80::ac13:db5:ef4:2dd2%4]) with mapi id 15.20.3611.025; Fri, 27 Nov 2020
 13:21:02 +0000
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
Subject: [PATCH v2 4/6] elf: Move note processing after l_phdr is updated
Date:   Fri, 27 Nov 2020 13:20:56 +0000
Message-Id: <36d457074f389740b45afc4f9c6d124046f8352b.1606319495.git.szabolcs.nagy@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1606319495.git.szabolcs.nagy@arm.com>
References: <cover.1606319495.git.szabolcs.nagy@arm.com>
Content-Type: text/plain
X-Originating-IP: [217.140.106.54]
X-ClientProxiedBy: LO2P265CA0434.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::14) To PR3PR08MB5564.eurprd08.prod.outlook.com
 (2603:10a6:102:87::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost.localdomain (217.140.106.54) by LO2P265CA0434.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:e::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.20 via Frontend Transport; Fri, 27 Nov 2020 13:21:02 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: b81f8c2a-989a-482c-09a3-08d892d74df7
X-MS-TrafficTypeDiagnostic: PA4PR08MB6014:|AM4PR0802MB2195:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM4PR0802MB21955CC822CF784CF0AD33FCEDF80@AM4PR0802MB2195.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: 4qFAq0tSahHcXScZ4dLCssSeJ3HuLehp2jF9u+cjWLCThQAxXvzNPSngtA+/7v7a4a/J6BgRmdPM3NSIRb5AaxbmFaZ+1eovTNMriswmoCO4RqooiK9C8KhlFpK22eoeD9TtMiOig2/H8gYyxB0J5HKzLXUCctteSrX4agThhYQ8Qd6a9+veyqePM58aY8t0DJyIg4KYL60WPdlsEdZLL+pRCmNlgoIkau3Ob9I8OB2DMRNe0+SjDheqwnKDteeYICA6jCYrxxYc0Jz+BxV/c/Gefvs40l9gwEjyUZ9KmHjv2iTE4aaVF18qCouJOf5ChJaogi/AcTZ/r9AqK2wgCW/KZxUw8aYWnYk9Hd0yyNzE1TNJTVWqtPRkOSLM2nsu
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PR3PR08MB5564.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(39860400002)(346002)(376002)(366004)(396003)(4326008)(54906003)(69590400008)(6916009)(6512007)(36756003)(6486002)(6666004)(316002)(478600001)(5660300002)(2616005)(86362001)(44832011)(2906002)(956004)(8936002)(16526019)(186003)(26005)(8676002)(66476007)(66946007)(6506007)(66556008)(52116002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?us-ascii?Q?2sAd3LJe8SPRFyw/KkmDjGjzl+CVO6DqB15QnRoLKp+B8oLgCXE/y3WAWB2Q?=
 =?us-ascii?Q?PfOgm+O8O02cDjhpNAQWYjJfJYLOgNg5NqNGL3by1INuogOPF+r2UciVEa6q?=
 =?us-ascii?Q?bdWISfHx5++E6AzFrQSjJPnWKcwEvTiH5NKGwUqkAgkuI+bt7bsmR1DJbCoh?=
 =?us-ascii?Q?E1lwlEq1dKyT7sV7BqCDAvO7muFBK2YEo4OYc/NxMkYeCqhWqvG6ES3KHRRe?=
 =?us-ascii?Q?xShDqLitDJjYsaBlMXpWMnQ4DoB663yYfBl8XL5H6/jLEVCWDggl1h1bSzl3?=
 =?us-ascii?Q?D+S4rTl/P0PjE/tn0X2eONP0ZYzRCxuvHTeMGvxt02+m8xciaP2e+Ps/Oldl?=
 =?us-ascii?Q?EZrDy3bB6++vZH2IAG2en8FPOkuew0xitatSwyTswjb0BKgq5QE+ZE/ldzZi?=
 =?us-ascii?Q?nKWgVefliS6THEKvZgO4Pyr8+Odgiff+7LauNj3Nv/CmW8EmaCQuKMKDlSZt?=
 =?us-ascii?Q?GopT9cY0ij5KSHL1UWBPJ5lhez7nob93ekRg2/HZ1nUKcYCEbfCtS1SK0cS/?=
 =?us-ascii?Q?3WoL+q1aHcU3gZQYknNU+NJ/OPPooM/+V7poaZy+YKUmxnFICQ1AFOlvpSky?=
 =?us-ascii?Q?TNAI5vKO+iQPXbjczo9KcdkI5fMkrpkOC4tSufGBb+WHIEtLLz/a+Ilohz3w?=
 =?us-ascii?Q?iFo9nOX+3WheY6W49l3ULfVJTXH9wXBrbJE7s/Gj1HD/T+zqKlq1G/3lHevV?=
 =?us-ascii?Q?4iYmCmX3lRh8nIEBASmUcc1E3GzOLh9xEOHQF8Qj0rXqU/Y2cnXnfyPpw/sX?=
 =?us-ascii?Q?2pKkL8RCKxn/38qpy+cihaYE5aMrLqeycHy+pwI99h5B3vKo9Z5svCT4/2MI?=
 =?us-ascii?Q?9CCOyMtBowlwptQFlVNDXhECNk+LdlkMh9ykzuDbSPtAzY7IUFqWMLD/eSfi?=
 =?us-ascii?Q?Eg8RDjxlWvhuzP+hSTNLbJuwAtBWeV1CrLgowH7kwz0hd1Au0PnaqPc3XJNW?=
 =?us-ascii?Q?dxhpqzXd3mrb5/aWvJR1T0ePG+2hhCtNCvaFEqwtVyJFu6tW81jAXyIM2AfI?=
 =?us-ascii?Q?Im5q?=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR08MB6014
Original-Authentication-Results: sourceware.org; dkim=none (message not signed)
 header.d=none;sourceware.org; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT020.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: e10275c7-e43e-4b10-7585-08d892d749e5
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MVVCKBe0Z8VVpUOmbul/pGJbI02L/pyOnsAq6qI8f+Nq9IPwyIbmYXwcjuct+Jh0SOLYzIZkVspWXjdgrarTSofHNO45fdJpwrZLeBDyn5tXPlUZLwgFGb0zi4IUNdzljgmANRfO2g/JNBHTWoC2HG9aeSmEvhIhMSSiD5b5dNwBs7oh6IERF3tK70KKa/3wsdLUsrKXS+0DQyLAUuE/0ctOuSzSEWXY35726xZTBrk/lULF4Bof7zJlRA/vROjdN5ckEQ52MbMzGgKYlVkYbp5FuxzGKTXo0j67fe0Idrh8Fp9hQXMidqMXOGUn6YeMVTDwVY2+e/kMs04m0V2aK5lRzqnHAjKofkMDtRKlQmjDjKOd08KNVZi8Fm4n54Ww8WSYhl9hlyaOIAfXPwvjaUSPqSwXJZX1VVDOHPjkNmIqvP3thwEO64rbjmMEC2ix
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(346002)(136003)(376002)(39860400002)(396003)(46966005)(6506007)(83380400001)(6512007)(2906002)(336012)(26005)(69590400008)(186003)(82310400003)(16526019)(478600001)(6486002)(8936002)(5660300002)(316002)(4326008)(36906005)(44832011)(356005)(107886003)(956004)(8676002)(36756003)(70586007)(70206006)(2616005)(47076004)(6666004)(86362001)(34206002)(54906003)(81166007)(82740400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2020 13:21:09.5974
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b81f8c2a-989a-482c-09a3-08d892d74df7
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT020.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR0802MB2195
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Program headers are processed in two pass: after the first pass
load segments are mmapped so in the second pass target specific
note processing logic can access the notes.

The second pass is moved later so various link_map fields are
set up that may be useful for note processing such as l_phdr.
The second pass should be before the fd is closed so that is
available.
---
 elf/dl-load.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/elf/dl-load.c b/elf/dl-load.c
index 9c71b7562c..b0d65f32cc 100644
--- a/elf/dl-load.c
+++ b/elf/dl-load.c
@@ -1268,21 +1268,6 @@ _dl_map_object_from_fd (const char *name, const char *origname, int fd,
 	l->l_map_start = l->l_map_end = 0;
 	goto call_lose;
       }
-
-    /* Process program headers again after load segments are mapped in
-       case processing requires accessing those segments.  Scan program
-       headers backward so that PT_NOTE can be skipped if PT_GNU_PROPERTY
-       exits.  */
-    for (ph = &phdr[l->l_phnum]; ph != phdr; --ph)
-      switch (ph[-1].p_type)
-	{
-	case PT_NOTE:
-	  _dl_process_pt_note (l, &ph[-1]);
-	  break;
-	case PT_GNU_PROPERTY:
-	  _dl_process_pt_gnu_property (l, &ph[-1]);
-	  break;
-	}
   }
 
   if (l->l_ld == 0)
@@ -1386,6 +1371,21 @@ cannot enable executable stack as shared object requires");
   if (l->l_tls_initimage != NULL)
     l->l_tls_initimage = (char *) l->l_tls_initimage + l->l_addr;
 
+  /* Process program headers again after load segments are mapped in
+     case processing requires accessing those segments.  Scan program
+     headers backward so that PT_NOTE can be skipped if PT_GNU_PROPERTY
+     exits.  */
+  for (ph = &l->l_phdr[l->l_phnum]; ph != l->l_phdr; --ph)
+    switch (ph[-1].p_type)
+      {
+      case PT_NOTE:
+	_dl_process_pt_note (l, &ph[-1]);
+	break;
+      case PT_GNU_PROPERTY:
+	_dl_process_pt_gnu_property (l, &ph[-1]);
+	break;
+      }
+
   /* We are done mapping in the file.  We no longer need the descriptor.  */
   if (__glibc_unlikely (__close_nocancel (fd) != 0))
     {
-- 
2.17.1

