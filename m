Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38AD528BE7D
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Oct 2020 18:53:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403963AbgJLQxS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Oct 2020 12:53:18 -0400
Received: from mail-eopbgr140053.outbound.protection.outlook.com ([40.107.14.53]:31109
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390534AbgJLQxS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Oct 2020 12:53:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ptud1KFm58RmhRRd508rHXseV33JnQ8uTkgihSGh8ec=;
 b=aTqobfxKxJ+qls7FBUg2vVCWVgCPYOMJT1A/fIj8eeLbrCRLVII7UHW13Q+n5bYkOWrMg6glHlv/ppnQKCEBiS4sVK7WemAsvguImq0T0jXxMgIXX6rdVCVkJ5+R+xPMY2onPjuPmBq6Vx94XvOg3AyuNgTtiTzpS9ZkudjACsQ=
Received: from DB6PR0202CA0028.eurprd02.prod.outlook.com (2603:10a6:4:a5::14)
 by AM5PR0802MB2420.eurprd08.prod.outlook.com (2603:10a6:203:9e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.26; Mon, 12 Oct
 2020 16:53:11 +0000
Received: from DB5EUR03FT045.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:4:a5:cafe::f8) by DB6PR0202CA0028.outlook.office365.com
 (2603:10a6:4:a5::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21 via Frontend
 Transport; Mon, 12 Oct 2020 16:53:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 DB5EUR03FT045.mail.protection.outlook.com (10.152.21.164) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.23 via Frontend Transport; Mon, 12 Oct 2020 16:53:11 +0000
Received: ("Tessian outbound bac899b43a54:v64"); Mon, 12 Oct 2020 16:53:11 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 942b3a53984a5ddd
X-CR-MTA-TID: 64aa7808
Received: from d7233043c77e.2
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 16A53E00-AE19-4739-B4F5-6598D967839D.1;
        Mon, 12 Oct 2020 16:53:05 +0000
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id d7233043c77e.2
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Mon, 12 Oct 2020 16:53:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lTCQguxJ244Z2ZBqlwYJB+uhLMfS/MH6GAOXyPLyrYmg3LbWHko8IXFyIJ2FLSTC8m+GPRi7ky1Hvj9v6Up84HUBPH4iVJ7uFfKJxxKTqYloxLswBHHfyT+SMRPpx4TaUCtIt1tADX4TUFmaxzmipxpl3Q8747Zj1Jx2HBriTQF+/dowMD0dGm3oOlppZHsW6nf85nMTlVRrO7xkvkzEH6ko72mZy/NfQNZuSdHpwI2X+C2R8KfNNyClCEhP0PQMLtCm/YQ1V4Eq6nekghtY9AkZ4VX5sm7eFMXO5ZyAKska0H/nr+e8bKrb7vYQXPEW8g5eC4N60KDzGOjZ8trlBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ptud1KFm58RmhRRd508rHXseV33JnQ8uTkgihSGh8ec=;
 b=AMneCPu2kogj2E1nVQFktw4W7VV23R9FWD9lo5U0T4cv54Cf341GnOjx/4O/SB5Q1m+W4ORgXAfArU6/ZPVlKc8VY7cIUTwiCEV5Q6CyLT7xylIPr9YU2GsvOCJgquItDazFRVi+feKWETShSywKHiCfacE8NX3YWa0VKH+aqBde2NHQ4fqwNSntsiwRc/Jh9khrC8b3Pvz6FZhV4hbhqr1FQOVzWsWGYmsiOvpzt1rdd4xBPSJjr3YRjQUlTydV6dJClzopcKr73ACDK2ckaztWtBwJKP4J3QqLQ0qW98u/TeRgOsj8rS4v7zZLWDhXi+Q60f4rLE2++bBcO6xGlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ptud1KFm58RmhRRd508rHXseV33JnQ8uTkgihSGh8ec=;
 b=aTqobfxKxJ+qls7FBUg2vVCWVgCPYOMJT1A/fIj8eeLbrCRLVII7UHW13Q+n5bYkOWrMg6glHlv/ppnQKCEBiS4sVK7WemAsvguImq0T0jXxMgIXX6rdVCVkJ5+R+xPMY2onPjuPmBq6Vx94XvOg3AyuNgTtiTzpS9ZkudjACsQ=
Authentication-Results-Original: lists.freedesktop.org; dkim=none (message not
 signed) header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=arm.com;
Received: from AM6PR08MB3653.eurprd08.prod.outlook.com (2603:10a6:20b:4c::22)
 by AM5PR0802MB2561.eurprd08.prod.outlook.com (2603:10a6:203:9b::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.28; Mon, 12 Oct
 2020 16:53:03 +0000
Received: from AM6PR08MB3653.eurprd08.prod.outlook.com
 ([fe80::d0be:76bf:3d2f:8c56]) by AM6PR08MB3653.eurprd08.prod.outlook.com
 ([fe80::d0be:76bf:3d2f:8c56%6]) with mapi id 15.20.3455.029; Mon, 12 Oct 2020
 16:53:03 +0000
Date:   Mon, 12 Oct 2020 17:53:02 +0100
From:   Matteo Franchin <matteo.franchin@arm.com>
To:     dri-devel@lists.freedesktop.org
Cc:     maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        tzimmermann@suse.de, airlied@linux.ie, daniel@ffwll.ch,
        brian.starkey@arm.com, liviu.dudau@arm.com,
        linux-kernel@vger.kernel.org, joe@perches.com, nd@arm.com
Subject: Re: [PATCH v3] drm/fourcc: Add AXBXGXRX106106106106 format
Message-ID: <20201012165302.GA23781@lagrange>
References: <20201012164043.23630-1-matteo.franchin@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201012164043.23630-1-matteo.franchin@arm.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [217.140.106.55]
X-ClientProxiedBy: LO2P265CA0435.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:e::15) To AM6PR08MB3653.eurprd08.prod.outlook.com
 (2603:10a6:20b:4c::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (217.140.106.55) by LO2P265CA0435.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:e::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21 via Frontend Transport; Mon, 12 Oct 2020 16:53:03 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 6263453c-4274-47c0-3e5d-08d86ecf4dcf
X-MS-TrafficTypeDiagnostic: AM5PR0802MB2561:|AM5PR0802MB2420:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM5PR0802MB2420B2B2D0A8C60CCF32206BF4070@AM5PR0802MB2420.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:529;OLM:529;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: LoimjnzIJNT/Lzz1gPsks9fuNUlRz/Y4NvCAJVes7g4XQOMrvaFn6K5hWZroYDOhVs2ybBH4AkVGYseWrMXgFcU8H7+BXAs6C1kpRYJSYWwZyPm36buPUvk8GkH61mylvMINrMVZC0qaq74l9Chv6bFQNlbpMYlARgjKuwp9FSNHwhQZtvvZcWSCxIVCxjvyBRXP87M4GiRQCv+hnMBeUqYYqvTCZiFvkBW42zvQAgYhQ/jJn0ZKmFIXMND4SONokRBZlKCxlwhRg3ANpFunz9DDjij9ZYg0lEcJGxd4QD1Jz9UK4zN5/0w6LikngKKlewVQJJ6+xEgzdTiLJoWrmw==
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB3653.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(376002)(366004)(346002)(396003)(136003)(39860400002)(8936002)(33656002)(478600001)(66946007)(6496006)(33716001)(52116002)(316002)(66476007)(66556008)(26005)(2906002)(44832011)(956004)(6486002)(8676002)(86362001)(5660300002)(6916009)(16526019)(1076003)(186003)(9686003)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: WjGaN/77WCGu2oazCDfWonUJoBTOOQ8B+JQYWTPaMUR7Ix/k+E0t/2JK4z5FCarheXbjnTZ9YVnsO7zhekD204aQIWv1tmyNiPjF/A4/OWkgxPPaPFzkMRhQDc6CW9XwSSBL4bKdOs9Fmc0IXUgQygES0sebpztoNFzHpNtSzeN4KGUC2dp/vZ3YQjOSegnYvr2vFPbyZoPV+cy1wIYU+8TbKqZMAs7/pt1FAfCBaQ7qPN0BmPvXKswZO2p9xP/Qb1+NwsrAjmcsayy/lKv2iy/h4TrIM07DDOv9fOrDMe9qeR/P8ERs2ZaUXt/D2m9Jdc/2Bco4CgaAeCChyV/cP0PmqC0th8p36cdJ5pTQWmec1/K7XazCeSrAXEnYlzhZKpMsaLVPAEDuHZGKBl8HeT+KA1W4P7WFYzoic2YYnfIbU11usGtW7fbZj/qpC5rumcascullG46080tvWj8tnQzkq1HRfqXU1FjSYh6pzUGbP5lvVs6SHPnQp5VZHcu+J2kvwjGZ3hpVLDc/08ke8eajmhPqG9OouPou8zUBI265qWrpeJCZRnuHG9fel2dVYEa2l+umADNzt6TAwRJRTDD0Iclh2RFPPJG/OjfRXQYeM/l8KtRxhhyvbqJsMhuxVBTXXJ2HmT5ThEJEag3KKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0802MB2561
Original-Authentication-Results: lists.freedesktop.org; dkim=none (message not signed)
 header.d=none;lists.freedesktop.org; dmarc=none action=none
 header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: DB5EUR03FT045.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 59f126ac-fbe0-4bf4-f883-08d86ecf48ff
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SOsmRXIU8X2xcfRhmKoyGF99bd/4mSbVK5nxFycY3PY3X9HVoazmtmN999H4BTF5pUp4Yv80vQOJPne3ZmXZko7L4rmPos33SyEzWlTJGFNcaOORr8V0u5V+07+DdL8q45lZ+F+h1GVPIaeUux0XQqgUucRRilgXgbWjf2NWyT2qJTau/AJPortNFlAm1bveqEaf2e4lt9+DJrBBL+gaLURu50jSvuHg+5V5KQeFutAkJLD1nqnu/aVhPb49YWI0GTE1JpJgRyIecBBPbTCHlMwF+O/+W1rIONVw9DmWjGiBG1CZZ4xVjDCpTyJXF81ODe6XN4lYV97r1LtSdAKRVrJ3BKU4NNaIzhkRKydvl1eyn7IXhRH6+GlwJhbIJlv6ka/fjUUOcX86OhJdf/1vAg==
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(7916004)(4636009)(396003)(376002)(346002)(136003)(39860400002)(46966005)(6496006)(81166007)(336012)(70206006)(956004)(9686003)(8676002)(2906002)(70586007)(1076003)(8936002)(16526019)(478600001)(26005)(4326008)(33716001)(356005)(6486002)(34206002)(33656002)(186003)(5660300002)(47076004)(82740400003)(44832011)(316002)(82310400003)(86362001);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2020 16:53:11.5573
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6263453c-4274-47c0-3e5d-08d86ecf4dcf
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5EUR03FT045.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR0802MB2420
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3 includes the Signed-off-by and Acked-by lines in the commit. No
other changes.

At this point, I'd need some help from a maintainer/committer to merge
this, I understand.

Daniel Vetter, are you happy to do this or does this work differently?

Many thanks,
Matteo

On Mon, Oct 12, 2020 at 05:40:43PM +0100, Matteo Franchin wrote:
> Add ABGR format with 10-bit components packed in 64-bit per pixel.
> This format can be used to handle
> VK_FORMAT_R10X6G10X6B10X6A10X6_UNORM_4PACK16 on little-endian
> architectures.
> 
> Signed-off-by: Matteo Franchin <matteo.franchin@arm.com>
> Reviewed-by: Brian Starkey <brian.starkey@arm.com>
> Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> ---
>  drivers/gpu/drm/drm_fourcc.c  | 1 +
>  include/uapi/drm/drm_fourcc.h | 6 ++++++
>  2 files changed, 7 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
> index 722c7ebe4e88..03262472059c 100644
> --- a/drivers/gpu/drm/drm_fourcc.c
> +++ b/drivers/gpu/drm/drm_fourcc.c
> @@ -202,6 +202,7 @@ const struct drm_format_info *__drm_format_info(u32 format)
>  		{ .format = DRM_FORMAT_XBGR16161616F,	.depth = 0,  .num_planes = 1, .cpp = { 8, 0, 0 }, .hsub = 1, .vsub = 1 },
>  		{ .format = DRM_FORMAT_ARGB16161616F,	.depth = 0,  .num_planes = 1, .cpp = { 8, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
>  		{ .format = DRM_FORMAT_ABGR16161616F,	.depth = 0,  .num_planes = 1, .cpp = { 8, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
> +		{ .format = DRM_FORMAT_AXBXGXRX106106106106, .depth = 0, .num_planes = 1, .cpp = { 8, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
>  		{ .format = DRM_FORMAT_RGB888_A8,	.depth = 32, .num_planes = 2, .cpp = { 3, 1, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
>  		{ .format = DRM_FORMAT_BGR888_A8,	.depth = 32, .num_planes = 2, .cpp = { 3, 1, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
>  		{ .format = DRM_FORMAT_XRGB8888_A8,	.depth = 32, .num_planes = 2, .cpp = { 4, 1, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
> diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
> index 6f0628eb13a6..d720f1e8ae5e 100644
> --- a/include/uapi/drm/drm_fourcc.h
> +++ b/include/uapi/drm/drm_fourcc.h
> @@ -179,6 +179,12 @@ extern "C" {
>  #define DRM_FORMAT_ARGB16161616F fourcc_code('A', 'R', '4', 'H') /* [63:0] A:R:G:B 16:16:16:16 little endian */
>  #define DRM_FORMAT_ABGR16161616F fourcc_code('A', 'B', '4', 'H') /* [63:0] A:B:G:R 16:16:16:16 little endian */
>  
> +/*
> + * RGBA format with 10-bit components packed in 64-bit per pixel, with 6 bits
> + * of unused padding per component:
> + */
> +#define DRM_FORMAT_AXBXGXRX106106106106 fourcc_code('A', 'B', '1', '0') /* [63:0] A:x:B:x:G:x:R:x 10:6:10:6:10:6:10:6 little endian */
> +
>  /* packed YCbCr */
>  #define DRM_FORMAT_YUYV		fourcc_code('Y', 'U', 'Y', 'V') /* [31:0] Cr0:Y1:Cb0:Y0 8:8:8:8 little endian */
>  #define DRM_FORMAT_YVYU		fourcc_code('Y', 'V', 'Y', 'U') /* [31:0] Cb0:Y1:Cr0:Y0 8:8:8:8 little endian */
> -- 
> 2.17.1
