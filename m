Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 08C7528BE31
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 18:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403939AbgJLQmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 12:42:14 -0400
Received: from mail-eopbgr50046.outbound.protection.outlook.com ([40.107.5.46]:56793
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2403861AbgJLQmO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 12:42:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zI/R7FszYqDYGFpHo4EV1quZdDfYX6DtzMoBbasU9k4=;
 b=qIie8d9yoyGZZvivEqNWLHumP5VnhsC4zkf7Dygf5I6IFcjB6oT8PZiGm2tqzj5fWrg1yAM0bLm9ba9p3ZydqYauS9gnVwQZl5Pf8L5Lhwc2qL4atWrP2YpPBJbJfplZ9LRo2oXh+X5aZHPx/AkLeH5dQPbIcw25QdaFfLVo5YQ=
Received: from AM6PR10CA0103.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:209:8c::44)
 by VI1PR0801MB1696.eurprd08.prod.outlook.com (2603:10a6:800:51::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Mon, 12 Oct
 2020 16:42:07 +0000
Received: from VE1EUR03FT017.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:8c:cafe::6f) by AM6PR10CA0103.outlook.office365.com
 (2603:10a6:209:8c::44) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.23 via Frontend
 Transport; Mon, 12 Oct 2020 16:42:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 VE1EUR03FT017.mail.protection.outlook.com (10.152.18.90) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.23 via Frontend Transport; Mon, 12 Oct 2020 16:42:06 +0000
Received: ("Tessian outbound 7161e0c2a082:v64"); Mon, 12 Oct 2020 16:42:06 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: ea9e987ab417e9db
X-CR-MTA-TID: 64aa7808
Received: from 1d70988bec98.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 8AAEF01F-36C6-417C-A8BB-F90F2387EE67.1;
        Mon, 12 Oct 2020 16:41:59 +0000
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 1d70988bec98.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 12 Oct 2020 16:41:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hB4ZAlxGa6ZRyqqMnb50i+o9ogXnWjmAtZRqZBGkLw4uEMM/3SbaQAZQTavEigkjFIHQ7P2rbKRuHNNtvaAeWGUAHQdHCJ9lOpe4yw89BJnjWF1Yxrtky8ITqPy9kv6l+keUHP4vnaLXvs3PWzuRTOjKWFKOMM1bHXMZQOBKw9sNNrxemE+b9Mlqqqk3bbjXrxA+ZzDsTwPgr4cozVCLAvtfII85tFxecRR51UmVzCKdSCOlpCN2PJ9AkB/h3ukvlBAPnQoKOw3ecSlPiJ2dbfY0/eb4sjTlMnT0Dbz5udELkS5ERKNJGaNSxH3bK9yJDgA0iF8/mfP+9ZMn3KuL/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zI/R7FszYqDYGFpHo4EV1quZdDfYX6DtzMoBbasU9k4=;
 b=Nuh5n4Km9CZh1YTtpUOjwV4IYi4iv2WwgkaoUJsn1CicmCTmFnco9LVNUPq/f2pN6I/qxi7fSfTNGwBmizyOumsGuZjnuO5hGgDzhW7/EsP2E8wSy5agmjuxybRyrXM/oJfw9vgKTTZA5hN3dSs3yp7CH+g0sxPvIeCXy3yYcJ44CXVP5kigWSes656zbVe9cj+s4sxqbgZeGtWQwGDUxiVZZZvGjWyeX9zFrjDo3VXXANY7Jdbx8kSZv4ze7jfATmw0MWIEVkoG5OajxqLSu1hqz/8x1jSMcWIDqCjPArjSVab1En/zlHD40dHEScqSwLJRASOXOc4yMlg6YWv0pA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zI/R7FszYqDYGFpHo4EV1quZdDfYX6DtzMoBbasU9k4=;
 b=qIie8d9yoyGZZvivEqNWLHumP5VnhsC4zkf7Dygf5I6IFcjB6oT8PZiGm2tqzj5fWrg1yAM0bLm9ba9p3ZydqYauS9gnVwQZl5Pf8L5Lhwc2qL4atWrP2YpPBJbJfplZ9LRo2oXh+X5aZHPx/AkLeH5dQPbIcw25QdaFfLVo5YQ=
Authentication-Results-Original: lists.freedesktop.org; dkim=none (message not
 signed) header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=arm.com;
Received: from AM6PR08MB3653.eurprd08.prod.outlook.com (2603:10a6:20b:4c::22)
 by AM6PR08MB4705.eurprd08.prod.outlook.com (2603:10a6:20b:cf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21; Mon, 12 Oct
 2020 16:41:57 +0000
Received: from AM6PR08MB3653.eurprd08.prod.outlook.com
 ([fe80::d0be:76bf:3d2f:8c56]) by AM6PR08MB3653.eurprd08.prod.outlook.com
 ([fe80::d0be:76bf:3d2f:8c56%6]) with mapi id 15.20.3455.029; Mon, 12 Oct 2020
 16:41:57 +0000
From:   Matteo Franchin <matteo.franchin@arm.com>
To:     dri-devel@lists.freedesktop.org
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        brian.starkey@arm.com, liviu.dudau@arm.com,
        linux-kernel@vger.kernel.org, joe@perches.com, nd@arm.com,
        Matteo Franchin <matteo.franchin@arm.com>
Subject: [PATCH v3] drm/fourcc: Add AXBXGXRX106106106106 format
Date:   Mon, 12 Oct 2020 17:40:43 +0100
Message-Id: <20201012164043.23630-1-matteo.franchin@arm.com>
X-Mailer: git-send-email 2.17.1
Content-Type: text/plain
X-Originating-IP: [217.140.106.51]
X-ClientProxiedBy: DM5PR21CA0021.namprd21.prod.outlook.com
 (2603:10b6:3:ac::31) To AM6PR08MB3653.eurprd08.prod.outlook.com
 (2603:10a6:20b:4c::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from lagrange.cambridge.arm.com (217.140.106.51) by DM5PR21CA0021.namprd21.prod.outlook.com (2603:10b6:3:ac::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3499.3 via Frontend Transport; Mon, 12 Oct 2020 16:41:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 479ec182-35d3-4c1d-8b55-08d86ecdc1b9
X-MS-TrafficTypeDiagnostic: AM6PR08MB4705:|VI1PR0801MB1696:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <VI1PR0801MB1696E51E1E16E4A447461265F4070@VI1PR0801MB1696.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:222;OLM:222;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: LmFHmkSK7HZZ3Rs/MRCdtflKTC3K60Kn51xbyPygHUo0f/wkOECTm+huF45S76VLGy3ErvmeXP0qsmdZcjwV/qXJSXOXmdUJnyV/guwB1mi3f8CVAJvfH6OxEblKxTSVp7dnb/L+yKqFwuczZDbU8rbQ+tEqp+xaIKnSnqA9wwc7a+pTfuAK0h++v0bhkZf8aTfFDsnnJj0ii7kYJOZk+Iy8sd+pKqiqYk687hfRTzEsJAfRdsprvsmy3N2MV4EgtVtVzeYpzB2JSBYol22XHeVKi0A4CmIPz/JJTQ9ccEAAVXDXpXShXii79TOuQ8QLStc5BQ4fbTjT7osbDHSU+w==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB3653.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(376002)(136003)(396003)(366004)(6916009)(316002)(66556008)(52116002)(44832011)(7696005)(26005)(2906002)(66476007)(36756003)(6666004)(186003)(16526019)(8936002)(1076003)(5660300002)(2616005)(956004)(6486002)(4326008)(66946007)(8676002)(86362001)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: YtVlETn5xaTfW7+ih/VoN+cYaimDELl6a3HdfyCQapIjkg6J4gzBtda1p9ym3/v0OewsHRUYOl5Bxlw6ttfL7QBNTzUrWB+hz2utUXMpZcocypG990dofe7gjDN8W02IShofqmV+LIWoTjvE9n4B3kgL+fTJY3eiYaA7TBXwOCIO2IN5nk1p6ezJtKjnRAmp6rYvaIrrXPE0tuMejhwOOpdToflxtsB7arMy9L5FrmeQO7/Jd6LMEsLWeXLXhTpPmIao7nbFzaRvgAplnDGvO9RI4yLw2pfJempnHedQTNMzkiTTMr9cvazd/XloQWpQvBwXK65rC4wCTU0J8fW2u+DQg+12o5YiJHuTpAwJrNYN0MmS6h+Y+utoRZkZe5tjZC4P2k6fHOBSoCE+UDrOoU3qTXQZHAYCFZUdchTLI40X28IH0yR4XXcOsXTPWGlf3SJEhNLXLC9FCQIqFTMJv3VUvYgBKx40hF/sp1mILGX/aGTHk+X2WZGVbxfCvCBP/FGQZmiGibpgpsH50XpnZXoNQAMfOoLwyubcUbhNfJUKxRnU4YBhhhbYNiVE6/y2VzvrX0PLhxloy8JVluB7s57b8ine0JNju/FdjZx2nwBW1w+d4e1DdIWXYnlVK4F37p7tqW7aI0hWl3RUbsReqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR08MB4705
Original-Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: VE1EUR03FT017.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: ecfdcee7-0732-4d9f-103e-08d86ecdbbe4
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QY8gpK8ntI6LH8ApVLxKoKWT44f0GxLnUXmvmySu86CFleIKRkYT1p9ns99KC9BxBiH87oqJvIhVQW30Dam9wDr3XjdZP9E8Egfk9jKshCJO3BS9avmJwCDid0vyO0ACso1TkmzPD4YX30XyUkKTdzxX6IXXDfbwWbpABvdbSBg3Aje+ykW3F5R16FGHbyv69VGSQSW+dbOWqF7C8r4Tm4TgYidkq4FkH8kwviqWFzZzeZupSqBNQEGi/IjaUwqEbWvHhM0R6qd84APJKmLV7hd9PayjZ8J7pxtG0/YOCq88AELh0OvBMaftnYh00C7fLR3MxLTEyJRjGjgQnRqlMCPktuQ+3JP7er5LzCVsNmMNT4C0vSaUK9w6/j8kbOXx+Ns5bAjDyT5ODniHbZ8lUw==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(396003)(39860400002)(136003)(376002)(346002)(46966005)(7696005)(478600001)(34206002)(47076004)(4326008)(6486002)(26005)(5660300002)(82740400003)(8936002)(36756003)(86362001)(70586007)(16526019)(6666004)(70206006)(81166007)(186003)(8676002)(44832011)(2616005)(2906002)(336012)(956004)(1076003)(356005)(316002)(82310400003);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2020 16:42:06.9339
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 479ec182-35d3-4c1d-8b55-08d86ecdc1b9
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: VE1EUR03FT017.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR0801MB1696
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add ABGR format with 10-bit components packed in 64-bit per pixel.
This format can be used to handle
VK_FORMAT_R10X6G10X6B10X6A10X6_UNORM_4PACK16 on little-endian
architectures.

Signed-off-by: Matteo Franchin <matteo.franchin@arm.com>
Reviewed-by: Brian Starkey <brian.starkey@arm.com>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
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
index 6f0628eb13a6..d720f1e8ae5e 100644
--- a/include/uapi/drm/drm_fourcc.h
+++ b/include/uapi/drm/drm_fourcc.h
@@ -179,6 +179,12 @@ extern "C" {
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

