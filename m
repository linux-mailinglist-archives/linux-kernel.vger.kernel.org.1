Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5FFB287621
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Oct 2020 16:35:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730627AbgJHOfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Oct 2020 10:35:19 -0400
Received: from mail-eopbgr20046.outbound.protection.outlook.com ([40.107.2.46]:41102
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730597AbgJHOfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Oct 2020 10:35:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xMpgsdmTqN9mitbd2Ubb/XRaBKDp+WkwdOXR+nDYcTM=;
 b=S7wyu7wCbNJbQJ/yt6/92rwf/b3/44scq8rBZWVtCo1+/G5NpAIYT28e1N6wIYxIxNbTO8pItxLhfioZMLlIP2zuKkbTZ5sBhgJZyoJ5Pqbw8WfYJ4kK+YxqkLOA2lrAN3dYtKdPW3yg19Gsy91oPJr3ozngoMJS+3k9zQ0/DV4=
Received: from AM5PR04CA0035.eurprd04.prod.outlook.com (2603:10a6:206:1::48)
 by AM0PR08MB4228.eurprd08.prod.outlook.com (2603:10a6:208:138::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.24; Thu, 8 Oct
 2020 14:35:14 +0000
Received: from AM5EUR03FT017.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:206:1:cafe::33) by AM5PR04CA0035.outlook.office365.com
 (2603:10a6:206:1::48) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21 via Frontend
 Transport; Thu, 8 Oct 2020 14:35:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT017.mail.protection.outlook.com (10.152.16.89) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.23 via Frontend Transport; Thu, 8 Oct 2020 14:35:14 +0000
Received: ("Tessian outbound e8cdb8c6f386:v64"); Thu, 08 Oct 2020 14:35:13 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: b20b56bf983c3861
X-CR-MTA-TID: 64aa7808
Received: from 8597a126627f.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id C949737D-260F-4A86-8764-D92727962F99.1;
        Thu, 08 Oct 2020 14:34:56 +0000
Received: from EUR03-VE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 8597a126627f.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 08 Oct 2020 14:34:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eFpNwkeI7EL4zh7xlSj4lhIikDBradTbZI/NXDsnT9qRNHZPKmOUXzG2un34vEe3M8EjhctLs3wXdwxDUw7N0/dPUDl/vSfixhLJOxRm08XxvqpipvvTfKjOhH3AH/Ty7RQaEYGxkCwK8spEJ0foQidhr6u1zzPjYkdX9y2udfNv2JhaL2a2C7HXiltC+jZZAaB8aU5G3sqUYc5sJ+VOdPMmHicbOpWYRtJwt+ZPSKgw38EfmdiSbvg2gtlkbJbr5rjJ8skDmv5JFWLA5wE6u9A/CKFjaggP+TNZic9rTT+JURGv9yJ9XlrPDz2BTzkaFujecE7xrfqXIk6duTE7tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xMpgsdmTqN9mitbd2Ubb/XRaBKDp+WkwdOXR+nDYcTM=;
 b=L8zNTD1/EvSMapvnioDIaNbz/lQX07rc2j/SFq/6Z29rE03KTmuktcFM/6zy492izeqrI+yGEXiFMaOZxiowO/fROPzYXf4UIFfy5Sr9wyg7lJ/jW9UDBia/v5oS+npTZgmkaz+EeUf9KlRDSBw4ONb8YfNhSA/Mag1F2Y+l3FhXdzD+CJ2qE88cKW5yxnX+xqBtp4sZRaJwyPR2QqrBqz3dsFMwV9apUkzBbMNfXszGHrdQwhwQvVPDADsVjoUBTq5WGZt+OOsyaYOB1mFvDyO+svNF0GI/GRV1gmsnnvixzFxB42D8J3JSY92uv83FQ75YfFVcZBhVpQy0Dc63CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xMpgsdmTqN9mitbd2Ubb/XRaBKDp+WkwdOXR+nDYcTM=;
 b=S7wyu7wCbNJbQJ/yt6/92rwf/b3/44scq8rBZWVtCo1+/G5NpAIYT28e1N6wIYxIxNbTO8pItxLhfioZMLlIP2zuKkbTZ5sBhgJZyoJ5Pqbw8WfYJ4kK+YxqkLOA2lrAN3dYtKdPW3yg19Gsy91oPJr3ozngoMJS+3k9zQ0/DV4=
Authentication-Results-Original: lists.freedesktop.org; dkim=none (message not
 signed) header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=arm.com;
Received: from AM6PR08MB3653.eurprd08.prod.outlook.com (2603:10a6:20b:4c::22)
 by AM5PR0802MB2388.eurprd08.prod.outlook.com (2603:10a6:203:9f::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.24; Thu, 8 Oct
 2020 14:34:53 +0000
Received: from AM6PR08MB3653.eurprd08.prod.outlook.com
 ([fe80::d0be:76bf:3d2f:8c56]) by AM6PR08MB3653.eurprd08.prod.outlook.com
 ([fe80::d0be:76bf:3d2f:8c56%6]) with mapi id 15.20.3455.024; Thu, 8 Oct 2020
 14:34:53 +0000
From:   Matteo Franchin <matteo.franchin@arm.com>
To:     dri-devel@lists.freedesktop.org
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        brian.starkey@arm.com, liviu.dudau@arm.com,
        linux-kernel@vger.kernel.org, nd@arm.com,
        Matteo Franchin <matteo.franchin@arm.com>
Subject: [PATCH v2] drm/fourcc: Add AXBXGXRX106106106106 format
Date:   Thu,  8 Oct 2020 15:33:50 +0100
Message-Id: <20201008143350.5306-1-matteo.franchin@arm.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [217.140.106.53]
X-ClientProxiedBy: LNXP265CA0030.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5c::18) To AM6PR08MB3653.eurprd08.prod.outlook.com
 (2603:10a6:20b:4c::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lagrange.cambridge.arm.com (217.140.106.53) by LNXP265CA0030.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:5c::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21 via Frontend Transport; Thu, 8 Oct 2020 14:34:53 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 7376cc00-e5eb-4f12-e6c4-08d86b975e6d
X-MS-TrafficTypeDiagnostic: AM5PR0802MB2388:|AM0PR08MB4228:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM0PR08MB4228B4165D93C4A248FF5A00F40B0@AM0PR08MB4228.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:222;OLM:222;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: cwBEKjxpyS3kOntNX+eO9LUc2fpQ/KA+uDyH43BBPa3ZNB65FCeJd4ld6UDTgjn1cKMIkpDgasooetUXILsS5vnrO5NxNQxKY9W49Sg1/Hsw2UJs01zG/y2p1DwPtJs3bxEJHnnvAGTs8cmlUweVBC0okwoYYGwDpoQDjqogAarcJVK10suyzvI5zBquTpH2gmikcs2HWlen78KIaRALMpsFuq3fJLt0/5I4GqsJ0ZKtjqpkLlQK8Fp+wNNVptbP6jdf67BE2Uj7ZRM93hqhSufe0sJtwDVkVXvcjp9ZBK1xZHRtRyxIBa6mE0vjMnasIKZ5nDfrLYvh0GLOZHY6+A==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB3653.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(39860400002)(366004)(376002)(346002)(136003)(8936002)(6486002)(36756003)(66946007)(66476007)(66556008)(478600001)(2906002)(44832011)(16526019)(956004)(2616005)(186003)(52116002)(316002)(86362001)(1076003)(26005)(6916009)(5660300002)(4326008)(8676002)(7696005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: 2Pf6xGyYP96RztuSEYr8drh1SJI8w8eOplaqFSSFZqxKCccpJ1Yelsom9U9n7ZJCZjv0TuD947GqEEmAE5bTfzpwL42KsObD8EZaO1rOAgqWqslmtWV6fv7kkqPJexIbJuptWUv9XbHZsdS6/ei/CAJYJsHybWsz6b+fBeJ3EyFvE3Z96PoL6diZf95MzmImCsn/gh3+EAZh55T0xtVmcUXkFujiu3+odIYrnSV02hPH9CDCxE2U+2sZRSFgesvsof1w8XDlFl/lAMbF/AFjUgfzHWaFB687HmDlrgf0/khOj1Bq6RY5vwAt1aZbPIG5RJdnJes0wjgPW3YM/S4moiXKN+WDQP1S+5zDCgkQbT7rWkXTMyWgMON0uPkhzpUT7qL1sDlMozv0xRw+OR+Pkbn/yWxI0wu37IQp5dob2X7uuFQpm2f1C5O57xwVSUxA9leceD7lfwPK78dHzALvwjlQkVaRk2S1Iroql6lFpI+Z6y63/EmgRv8pP1P9Yb9d2NJZEH9RTOhb/NiZbjBXPiSVyqehECy8nWXfNkuvrxgcMo6CSeoJ7dSzZhJK19pNA95yonln98cz3IMuw+MazIksfkOJMrOpwuWb2pkSfHf9sLM9iC4yYT+E4Smj2SzUQIzMTbCY74K9B0l4NF0d9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0802MB2388
Original-Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT017.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 9b2d1f9a-a96f-4c4c-d277-08d86b975204
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vf2hr468fqnCHheueNDZ1RE+r6Sx4PmRNKgDlN5hsDzyX7eqodg+wwAsPKT7BvIjL71HlPLzLJakjz7gJCNZke4euOV/yxDR0OyNk5NDo8UPMgiTdi1qeeufSYiwEp3Bf1PgzbPrqu0FA5j2RmY2wlMA4qYH2SahCZKEmxp+suha6NJbGrIMINWs7qBURuDpjR7quGiFy6AapJ+levu4ADd/SQuUyH0GqXNDvmFLWyqnFOdDGKXf63L3+ku+Uc+Ufcxgc79rUacUYh2uWjKCk3XNaSX3HEZ8ptVZGabXkHMBj4GfonLcqzVFBU+Z5Lri9sk/MXmUoGHeLIOH98qEEteDZBae5F0A30Kyj+VQOQ9fToA+uPvPFi+RfA9wkyoB+p8v5pH5fhPA480dboiGGQ==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(396003)(376002)(46966005)(82310400003)(16526019)(86362001)(956004)(2616005)(81166007)(356005)(34206002)(7696005)(44832011)(336012)(186003)(26005)(4326008)(6486002)(70206006)(5660300002)(82740400003)(316002)(70586007)(36906005)(36756003)(8936002)(478600001)(8676002)(1076003)(47076004)(2906002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2020 14:35:14.0700
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7376cc00-e5eb-4f12-e6c4-08d86b975e6d
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT017.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4228
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
 include/uapi/drm/drm_fourcc.h | 6 ++++++
 2 files changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
index 722c7ebe4e88..03262472059c 100644
--- a/drivers/gpu/drm/drm_fourcc.c
+++ b/drivers/gpu/drm/drm_fourcc.c
@@ -202,6 +202,7 @@ const struct drm_format_info *__drm_format_info(u32 format)
 		{ .format = DRM_FORMAT_XBGR16161616F,	.depth = 0,  .num_planes = 1, .cpp = { 8, 0, 0 }, .hsub = 1, .vsub = 1 },
 		{ .format = DRM_FORMAT_ARGB16161616F,	.depth = 0,  .num_planes = 1, .cpp = { 8, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
 		{ .format = DRM_FORMAT_ABGR16161616F,	.depth = 0,  .num_planes = 1, .cpp = { 8, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
+		{ .format = DRM_FORMAT_AXBXGXRX106106106106, .depth = 0, .num_planes = 1, .cpp = { 8, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
 		{ .format = DRM_FORMAT_RGB888_A8,	.depth = 32, .num_planes = 2, .cpp = { 3, 1, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
 		{ .format = DRM_FORMAT_BGR888_A8,	.depth = 32, .num_planes = 2, .cpp = { 3, 1, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
 		{ .format = DRM_FORMAT_XRGB8888_A8,	.depth = 32, .num_planes = 2, .cpp = { 4, 1, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
index 82f327801267..9374d9558493 100644
--- a/include/uapi/drm/drm_fourcc.h
+++ b/include/uapi/drm/drm_fourcc.h
@@ -155,6 +155,12 @@ extern "C" {
 #define DRM_FORMAT_ARGB16161616F fourcc_code('A', 'R', '4', 'H') /* [63:0] A:R:G:B 16:16:16:16 little endian */
 #define DRM_FORMAT_ABGR16161616F fourcc_code('A', 'B', '4', 'H') /* [63:0] A:B:G:R 16:16:16:16 little endian */
 
+/*
+ * RGBA format with 10-bit components packed in 64-bit per pixel, with 6 bits
+ * of unused padding per component:
+ */
+#define DRM_FORMAT_AXBXGXRX106106106106 fourcc_code('A', 'B', '1', '0') /* [63:0] A:x:B:x:G:x:R:x 10:6:10:6:10:6:10:6 little endian */
+
 /* packed YCbCr */
 #define DRM_FORMAT_YUYV		fourcc_code('Y', 'U', 'Y', 'V') /* [31:0] Cr0:Y1:Cb0:Y0 8:8:8:8 little endian */
 #define DRM_FORMAT_YVYU		fourcc_code('Y', 'V', 'Y', 'U') /* [31:0] Cb0:Y1:Cr0:Y0 8:8:8:8 little endian */
-- 
2.17.1

