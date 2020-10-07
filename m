Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62E53285BE1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 11:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbgJGJ3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 05:29:31 -0400
Received: from mail-vi1eur05on2049.outbound.protection.outlook.com ([40.107.21.49]:26337
        "EHLO EUR05-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727235AbgJGJ33 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 05:29:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R00XaKjOx6J7VJMIqA4g4DHMkbkr2seX56le7soOHtU=;
 b=qKBsRmzS4jxaLaLwahPHigeYMM+mBRfa92X7WvkZXCadPAPvEx/p3amfwc+Ln4Ngo0yds/A8hdaw9+WhHx7SGQ7QfeBTm/oCaZZ+IJtI62uc7aSEJZnDJRsHy15nOcjrUZ6x2Gj3xCmLSzReX7kAdnWdhohZKBgoT6T/IMtVSj8=
Received: from DB6P195CA0015.EURP195.PROD.OUTLOOK.COM (2603:10a6:4:cb::25) by
 AM6PR08MB3334.eurprd08.prod.outlook.com (2603:10a6:209:48::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.34; Wed, 7 Oct 2020 09:29:23 +0000
Received: from DB5EUR03FT051.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:4:cb:cafe::6b) by DB6P195CA0015.outlook.office365.com
 (2603:10a6:4:cb::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21 via Frontend
 Transport; Wed, 7 Oct 2020 09:29:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT051.mail.protection.outlook.com (10.152.21.19) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3433.34 via Frontend Transport; Wed, 7 Oct 2020 09:29:23 +0000
Received: ("Tessian outbound 7a6fb63c1e64:v64"); Wed, 07 Oct 2020 09:29:23 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 76c30c310ff8075a
X-CR-MTA-TID: 64aa7808
Received: from b5430a81eed6.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 7010D20C-012B-4EA8-B8CD-FDA3EA3C6C3F.1;
        Wed, 07 Oct 2020 09:28:45 +0000
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id b5430a81eed6.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 07 Oct 2020 09:28:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EO9aWdyVObllua9u1GapOGn1cmZGESoPHMMgokug7C+N70CCFWSD033EeY6/OahJGCGszn0Cpcm5CoJCQ8aAaEyffaSQphscDrPZyEJ8W7pwi9nQB9LM8OvKUCOQmcXyCkGrtPJ0mHIvmVoGeY6bf86Mnq5SmgtctTNjZrBNRRThKBbifPcgnAYTIT5+qnwFyP/RBi8eU9xw9o+aaUpvycEQCuD8qRumVhfRVcsNWr1Dii76bFAJHfpUcVB8xFJldsavlSAPNtgODn7JTFZopR6OhP3062jF+f1K0iXv5WCTM7tfJdhbNG3BDLcu8l545P8p43sOI7+BT91TKPMBiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R00XaKjOx6J7VJMIqA4g4DHMkbkr2seX56le7soOHtU=;
 b=hPtjX5CXXGobPC4ixDFNOclzryb3onOm+6hLX3dKZwet9MiIzqoOIZ+C6H4lDCFqm6CPHEnzLswaMBg+nrLgfF9QJWVuB/VtZq+ikg1kUhYmSSMnNIyXNiQz3EYPiASp7AbyODPaG00tkSuhsZzVfblGNg/pslDOkMlp2dXxvuMO9EJC7A0k6ztiOEbUrwt9IO+T89OrvlWnaNnmDlgtT55PtrGcYNA1oWcjahoWWYEeCcBsuXfHrMOna9UY9geivyFGrW3uo+lnJCStXGBI1D2gc1g1x1EU9AWH9uY1yVSHEzKl6OJC50JSXgsGkGMXyjdH3sJFKZdEeBX/8dc2iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R00XaKjOx6J7VJMIqA4g4DHMkbkr2seX56le7soOHtU=;
 b=qKBsRmzS4jxaLaLwahPHigeYMM+mBRfa92X7WvkZXCadPAPvEx/p3amfwc+Ln4Ngo0yds/A8hdaw9+WhHx7SGQ7QfeBTm/oCaZZ+IJtI62uc7aSEJZnDJRsHy15nOcjrUZ6x2Gj3xCmLSzReX7kAdnWdhohZKBgoT6T/IMtVSj8=
Authentication-Results-Original: lists.freedesktop.org; dkim=none (message not
 signed) header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=arm.com;
Received: from AM6PR08MB3653.eurprd08.prod.outlook.com (2603:10a6:20b:4c::22)
 by AS8PR08MB5976.eurprd08.prod.outlook.com (2603:10a6:20b:299::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22; Wed, 7 Oct
 2020 09:28:42 +0000
Received: from AM6PR08MB3653.eurprd08.prod.outlook.com
 ([fe80::d0be:76bf:3d2f:8c56]) by AM6PR08MB3653.eurprd08.prod.outlook.com
 ([fe80::d0be:76bf:3d2f:8c56%6]) with mapi id 15.20.3433.044; Wed, 7 Oct 2020
 09:28:42 +0000
From:   Matteo Franchin <matteo.franchin@arm.com>
To:     dri-devel@lists.freedesktop.org
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        brian.starkey@arm.com, liviu.dudau@arm.com,
        linux-kernel@vger.kernel.org, nd@arm.com,
        Matteo Franchin <matteo.franchin@arm.com>
Subject: [PATCH] drm/fourcc: Add AXBXGXRX106106106106 format
Date:   Wed,  7 Oct 2020 10:27:25 +0100
Message-Id: <20201007092725.13300-1-matteo.franchin@arm.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [217.140.106.53]
X-ClientProxiedBy: CWLP265CA0308.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:401:5d::32) To AM6PR08MB3653.eurprd08.prod.outlook.com
 (2603:10a6:20b:4c::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lagrange.cambridge.arm.com (217.140.106.53) by CWLP265CA0308.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:5d::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22 via Frontend Transport; Wed, 7 Oct 2020 09:28:42 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 839f5fdf-268d-40ba-8b65-08d86aa37a38
X-MS-TrafficTypeDiagnostic: AS8PR08MB5976:|AM6PR08MB3334:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM6PR08MB333432D62FC32703A2B317A6F40A0@AM6PR08MB3334.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:222;OLM:222;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: qd7YLiJ3ZtXNlJK7L2AJ0e5A6N+5sf8YAfS07NNIxWW9riNGHqujjERvk1KWloUogr0M8xuHJb1AVjr0u67assSyNSh1NffCujb72jmsuRxyLgknHa4PhFbVi7ChtNXSBfOgQyrcJEEnyLfipVhsuq3pDYLy6Bop8Yb9/U51puAdCPsPTisYLSmqD7qdwOkc73WMtcS2gYMkWTFpjcNL/pOy07xBgqIsyaKeP4qVutAWCt/YUR9Eos4SVjLn+Z3a2yJ2UW14qt8SiE3Hkkr4zSh6zFNhnPMm2M1tfR5HgHiptdPIx+w1yA5z4OnCbhbtZaQNBkEC850rzJRHlnd/Zw==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB3653.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(39850400004)(346002)(396003)(376002)(136003)(316002)(86362001)(52116002)(6666004)(4326008)(7696005)(2906002)(6916009)(44832011)(66946007)(66556008)(66476007)(26005)(1076003)(2616005)(478600001)(6486002)(956004)(5660300002)(16526019)(8936002)(186003)(36756003)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: lI+550swCjMQs3FjydSx9HcJZpWcPE6/fY+05oh/9iwq61U//OB0NJR8TJ+rjH0FmjoAF+/SEk8WnbhckqB7WTsMVZ25RsQhw2Czdj4+zC1jFqn7gjKtkg1rdZF6KJ4nilUDCpHkHE+GBTqZLsYSmquUvAp/3dcRNip96FDCOIAuiceQ6eDLKkWpp4OWpo/PCbDLsVyj+BrE6vLeftFhYRfP5A1VlDfA7tx5DjeFmttYYnt+D1D8CcYca7JfHMxdAx+Ju1n7HkqpsF4VWCkHIx4GbOXb9sU/ijy6dpcTv21dXyeY7I3G4YBmAUqhNjTcC12XTeNkgRC3r5gAzppLATWjjUxdoD+IR5KAZDO1Sz1oqtqm0j524vBTHcC8ZQDamNjp2MSrG9pfmNbhaHdPNv1DLV5rEhDLV1QRufF2i1Xrpgqs4fhxFC5tm8TJEABj7Q31gSNrs1TOxDnIEkXaoK7vkHYLoNGCtL2gI7HKn6XxJjOlReuF0LO7KBiv2oBDlJumimEQTeZsldf/ZHS/qYs45oud/EWDfeouqwtXk2NnVwR0/RWL/ApQf7/80p0fDzx8QijL3MloXOERx4ZUu2F8+B78HHQUFnOuHYuWkIPWRaJ9uV1gOqpI7/T7okTZrW2H69ouWeVTRXBQHiJChQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB5976
Original-Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT051.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 0937e431-e14c-433c-efcd-08d86aa361b4
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e2jnpD/0BEizZCrCTW7vDJplBDl1ErYD6TbQTEm2etZjGpXvSnEyPd4JpBrt0c1Z80GwFyCnSOU+lkiyezYBKIyEiY3n3hpsjoR2aGzCdbuUXb4Sx2bqeEerXvSOQ2O90LFOr/VUvN4jrY+I7A+W9MAvIhzToq+hv7c7Ik30CR85fxC95krmRBBxABUro9PkoKNQCi4sngMfqO9tpxzTV9ZeUT/zUIrDX1poH8G9Z+j2xRbiMNAgl/+cDMVXWJUTvb+qZKNXTpnNmVic8a2ahddzDzNcehpIBcNM/7kUOBi/1BiTZNfDkhW4jUNj5hQBNf0kfbw35ZPPOvca3Ibi35/2b1TkmAgb7D2NcwbU1IulB5L4dGtmWBP5Nr7U4nHzU6ZbwFxlLHGRgOIKLne/nw==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(39850400004)(396003)(346002)(376002)(136003)(46966005)(70206006)(36756003)(6666004)(16526019)(316002)(86362001)(2616005)(186003)(6486002)(336012)(44832011)(7696005)(26005)(956004)(82740400003)(70586007)(34206002)(81166007)(356005)(47076004)(8676002)(478600001)(2906002)(8936002)(5660300002)(1076003)(4326008)(82310400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2020 09:29:23.5599
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 839f5fdf-268d-40ba-8b65-08d86aa37a38
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT051.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB3334
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ABGR format with 10-bit components packed in 64-bit per pixel.
This format can be used to handle
VK_FORMAT_R10X6G10X6B10X6A10X6_UNORM_4PACK16 on little-endian
architectures.

Signed-off-by: Matteo Franchin <matteo.franchin@arm.com>
---
 drivers/gpu/drm/drm_fourcc.c  | 1 +
 include/uapi/drm/drm_fourcc.h | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
index 722c7ebe4e88..bba03fcb016d 100644
--- a/drivers/gpu/drm/drm_fourcc.c
+++ b/drivers/gpu/drm/drm_fourcc.c
@@ -202,6 +202,7 @@ const struct drm_format_info *__drm_format_info(u32 format)
 		{ .format = DRM_FORMAT_XBGR16161616F,	.depth = 0,  .num_planes = 1, .cpp = { 8, 0, 0 }, .hsub = 1, .vsub = 1 },
 		{ .format = DRM_FORMAT_ARGB16161616F,	.depth = 0,  .num_planes = 1, .cpp = { 8, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
 		{ .format = DRM_FORMAT_ABGR16161616F,	.depth = 0,  .num_planes = 1, .cpp = { 8, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
+		{ .format = DRM_FORMAT_AXBXGXRX106106106106,	.depth = 0,  .num_planes = 1, .cpp = { 8, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
 		{ .format = DRM_FORMAT_RGB888_A8,	.depth = 32, .num_planes = 2, .cpp = { 3, 1, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
 		{ .format = DRM_FORMAT_BGR888_A8,	.depth = 32, .num_planes = 2, .cpp = { 3, 1, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
 		{ .format = DRM_FORMAT_XRGB8888_A8,	.depth = 32, .num_planes = 2, .cpp = { 4, 1, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index 82f327801267..76eedba52b77 100644
--- a/include/uapi/drm/drm_fourcc.h
+++ b/include/uapi/drm/drm_fourcc.h
@@ -155,6 +155,13 @@ extern "C" {
 #define DRM_FORMAT_ARGB16161616F fourcc_code('A', 'R', '4', 'H') /* [63:0] A:R:G:B 16:16:16:16 little endian */
 #define DRM_FORMAT_ABGR16161616F fourcc_code('A', 'B', '4', 'H') /* [63:0] A:B:G:R 16:16:16:16 little endian */
 
+/*
+ * RGBA format with 10-bit components packed in 64-bit per pixel, with 6 bits
+ * of unused padding per component:
+ * [63:0] A:x:B:x:G:x:R:x 10:6:10:6:10:6:10:6 little endian
+ */
+#define DRM_FORMAT_AXBXGXRX106106106106 fourcc_code('A', 'B', '1', '0')
+
 /* packed YCbCr */
 #define DRM_FORMAT_YUYV		fourcc_code('Y', 'U', 'Y', 'V') /* [31:0] Cr0:Y1:Cb0:Y0 8:8:8:8 little endian */
 #define DRM_FORMAT_YVYU		fourcc_code('Y', 'V', 'Y', 'U') /* [31:0] Cb0:Y1:Cr0:Y0 8:8:8:8 little endian */
-- 
2.17.1

