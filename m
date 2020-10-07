Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB862285DD4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Oct 2020 13:07:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbgJGLHt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Oct 2020 07:07:49 -0400
Received: from mail-eopbgr60083.outbound.protection.outlook.com ([40.107.6.83]:46215
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726129AbgJGLHs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Oct 2020 07:07:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ps3ELCrVTLAP80aZ1X+PNliYGY47NA595zJk5ZpTQ7g=;
 b=Aa5zCKt0+kJd+coViK764sE/rF+D14R0loa+2ZzaCWbghpUG1goEOo3SiMHlhxQEUOyFP7G4do+8eJ/Kvpnik7rK/ylUZOZMeSBBxtgXe3g4wtqpiCL/EYcaqJEBGMOVGmzKw5LCSU/rRGSR7mDnZ0e4XOE/KxSG/wSZF2PaXJ4=
Received: from AM6P194CA0083.EURP194.PROD.OUTLOOK.COM (2603:10a6:209:8f::24)
 by HE1PR0802MB2363.eurprd08.prod.outlook.com (2603:10a6:3:c8::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3433.35; Wed, 7 Oct
 2020 11:07:44 +0000
Received: from AM5EUR03FT058.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:8f:cafe::6c) by AM6P194CA0083.outlook.office365.com
 (2603:10a6:209:8f::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.21 via Frontend
 Transport; Wed, 7 Oct 2020 11:07:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT058.mail.protection.outlook.com (10.152.17.48) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3455.23 via Frontend Transport; Wed, 7 Oct 2020 11:07:43 +0000
Received: ("Tessian outbound bac899b43a54:v64"); Wed, 07 Oct 2020 11:07:43 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 0dfa2ac6042014f5
X-CR-MTA-TID: 64aa7808
Received: from 1863444d075c.1
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id A3D467DD-60D3-4597-98F2-AF42D5411C97.1;
        Wed, 07 Oct 2020 11:07:38 +0000
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 1863444d075c.1
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Wed, 07 Oct 2020 11:07:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AMo87+wQd6pW/homA+0Im2Io6L2rLl2CWOIP18TIis75dvtQXExHliaTJlUloQyfa8UjWhXB9ozFsn3txlYaPEsncAvHPZ6wkgrrWGGbXdBSAh33+0oe7n6OO0DUQ4v8A41cxAXq8rap39p8BqLa7ALDXtLWd57sTYfiEGonW4O4KRjBWum4VHF/RJ2rS/p+mhaycJnp6mlaWYAjffbwHpHmgyecdA6k1m6jTQ6LXe1a58D/9u7+Fy41ZTa3eKTmD7i9V4+xIl9bjG3j1yV33EoX9fdfUuQH5C4M2xrS4uQsstZP7BRe5PHR7si5ggqSLUae9qf1/S4Jk0TCuBd7FQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ps3ELCrVTLAP80aZ1X+PNliYGY47NA595zJk5ZpTQ7g=;
 b=S6zBjyMv/jnvtduCC/tOXnbafNSTKD4tBLK54VdN8frLCpQv3et/NGFbuisEc5hgibxjv5pvbMu951CySxVxWw5ky2oT+G8KPx8FzhIg60Q5UlRF+daAeHIkpZzJLfFW/emna2a92GGWNXbrVqx9Jq4pbSi6Q1QybVhWvCieiQa2RjDCEiaymEtlV0dXMLIr47wRVB2hAz4gSCcbNl9rQI/I09lKRU0eXDeFkYawRQpNB3NZIwRKxvAG9OvMNVc6iJb33ujpo89uTb12tNVjQrm1KD9nkH8Uj882EV2Yfkk+PAPa0HITPHV6blik1j/4wqxJIsXQm1+7W8ZovYGAgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ps3ELCrVTLAP80aZ1X+PNliYGY47NA595zJk5ZpTQ7g=;
 b=Aa5zCKt0+kJd+coViK764sE/rF+D14R0loa+2ZzaCWbghpUG1goEOo3SiMHlhxQEUOyFP7G4do+8eJ/Kvpnik7rK/ylUZOZMeSBBxtgXe3g4wtqpiCL/EYcaqJEBGMOVGmzKw5LCSU/rRGSR7mDnZ0e4XOE/KxSG/wSZF2PaXJ4=
Authentication-Results-Original: linux.intel.com; dkim=none (message not
 signed) header.d=none;linux.intel.com; dmarc=none action=none
 header.from=arm.com;
Received: from AM6PR08MB3653.eurprd08.prod.outlook.com (2603:10a6:20b:4c::22)
 by AS8PR08MB6136.eurprd08.prod.outlook.com (2603:10a6:20b:292::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22; Wed, 7 Oct
 2020 11:07:37 +0000
Received: from AM6PR08MB3653.eurprd08.prod.outlook.com
 ([fe80::d0be:76bf:3d2f:8c56]) by AM6PR08MB3653.eurprd08.prod.outlook.com
 ([fe80::d0be:76bf:3d2f:8c56%6]) with mapi id 15.20.3433.044; Wed, 7 Oct 2020
 11:07:37 +0000
Date:   Wed, 7 Oct 2020 12:07:36 +0100
From:   Matteo Franchin <matteo.franchin@arm.com>
To:     Ville =?iso-8859-1?Q?Syrj=E4l=E4?= <ville.syrjala@linux.intel.com>
Cc:     airlied@linux.ie, liviu.dudau@arm.com,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        tzimmermann@suse.de, nd@arm.com
Subject: Re: [PATCH] drm/fourcc: Add AXBXGXRX106106106106 format
Message-ID: <20201007110736.GA13842@lagrange>
References: <20201007092725.13300-1-matteo.franchin@arm.com>
 <20201007103539.GA6112@intel.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201007103539.GA6112@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Originating-IP: [217.140.106.49]
X-ClientProxiedBy: LO2P265CA0406.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::34) To AM6PR08MB3653.eurprd08.prod.outlook.com
 (2603:10a6:20b:4c::22)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from localhost (217.140.106.49) by LO2P265CA0406.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:f::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3455.22 via Frontend Transport; Wed, 7 Oct 2020 11:07:37 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: e2069559-2108-4dd1-c041-08d86ab13720
X-MS-TrafficTypeDiagnostic: AS8PR08MB6136:|HE1PR0802MB2363:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <HE1PR0802MB2363893DE5B6FA18A749BC74F40A0@HE1PR0802MB2363.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: pGIlxItK39Un4KJpESNrYr/IiOF4vElSUIUWHGu2R8+vF0r5L7ldHhLosj8DRdEv56qIcI1xsJI+YeOcjwXa149OwKUe0BVgT1pLxABtdGij+6DkLC0AwGKdxBad1oeoeeBYkgGpRGFod/5hm4/wjT2LOqidv31tRff8fT0M3J9fb8i405U+5DwFKBQDxLdLlkxMr4r9TxMoRcwGS11CmKSRYDlqaUQqYyPyQTbOXuOurPmQyQOavReNn8MO4jkt8HsJPQEyuNQd8sVFZkkWSTXVjmMF1pTg2SIdUVuPDBmmfH7X6JgF9RQBK96kYUT12qiQIzziBmALOQJ1J6oenyPNzuBbw/XJE73gMiLIVXA=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR08MB3653.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(4636009)(396003)(39850400004)(376002)(346002)(136003)(366004)(5660300002)(6486002)(478600001)(33656002)(66946007)(66556008)(4326008)(6916009)(66476007)(44832011)(2906002)(52116002)(16526019)(26005)(6496006)(186003)(316002)(956004)(86362001)(9686003)(8676002)(1076003)(8936002)(33716001)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: JFFAAzOq5ZuFX58vPuTEMiEvv5NqCbYt9pJjDUU/XS61V9HNg8dYLco9grVdI5/gzZqgAvaCnxh+/P/dZx/IFtU55lucVs688U9tusUqecqwQjXzBI6pR3a7KMTom4Mj3YjxcTTmQUbdhGkA22tOCDVhlWml6zTcTBhS+Zr6Vg1mgmDKjQyLHnfHeuqIq9PDY+NxyFa/JWEijtYCgDWx5ilhEyd/yrkaW2DGZRP27FGlhV1KBkdeip6CQqc3peXl7cxwYSnUKd1eHwHDMl48znZPjnG8ersGzC/WNzPxc6fXzIGuM/nvATtJWmAQjcp5TyYWt3bBZLFEdBK86GB9dQUqn8SZXlXtFZmLRHodQdAtbYabJBfLmqOxRqeXurUbrqoQwJk0GDK1HQh4UesiJyXX2U843L1tqZH/freiQ8DtlfZOE/RmBKAj0p13VoMph4ZigpZ5qHMVA+sBVKbBlhZROxKnj9+S5HaK1tPrOxT47ahHxzxSoN3yeUyDLURkyN5Kl+izPcOHgs/A19j+knrkzqp8C3nfOALn8X8wGJRNXrkrFT8Z7QW3BAmNmaXrZ7t33L1VUVBpv+U9VDsjHfI9CEQycR+lShjWIeNvIx9QjtGq7+asBtRtf0R4b1br/22jxjzSMCqiNFkjC2B4lQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR08MB6136
Original-Authentication-Results: linux.intel.com; dkim=none (message not signed)
 header.d=none;linux.intel.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT058.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 20154023-e1fe-45ef-fee8-08d86ab1330d
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: phpgPD/rkrQ9/1nSOFw0vwQQeaEWLD0h3f05T0xgEGAthdpObGxAZo3z6gpAaErpU0rcRd/Lazv1fWCCpY7qLTPkuO4QM+tOZWI3QioRnoBbq7GMpAv8YdKLB3hLaKFLmTzuAvFX/IerAqY6OAMujvbA06PDD+3GNBsdvmdWre/OaaJlLcmHSJmIPtzSqV9dzLxxQnB+gvZoVL48DasMOEDZdak1i+I32sTMUdrkY/o8AR9gDhkUjb2yOMin2qESLmA/uLpZFa/IfS1bBWK976e152rTFfkNNcEKkUaSikgclgHH1n5Vn3v7qGJ/T2BmqiwI2B3I7GpJMqU4SxCJEHuRYjjtvkMrK9e0WkrbATlBPOqxmNSYAzfP2ACPx3d02qNCx6KoJ3ta672a+SD/jeXk1jqSfSFb/gKQi3QaB23VzW21EMvB2FajPZWJBjUG
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(7916004)(136003)(376002)(346002)(39860400002)(396003)(46966005)(956004)(6496006)(186003)(1076003)(82310400003)(16526019)(5660300002)(9686003)(33716001)(2906002)(8936002)(6486002)(6862004)(86362001)(82740400003)(4326008)(336012)(70586007)(26005)(478600001)(81166007)(44832011)(356005)(316002)(36906005)(33656002)(8676002)(966005)(70206006)(47076004);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2020 11:07:43.9004
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2069559-2108-4dd1-c041-08d86ab13720
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT058.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR0802MB2363
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ville,

On Wed, Oct 07, 2020 at 01:35:39PM +0300, Ville Syrj�l� wrote:
> On Wed, Oct 07, 2020 at 10:27:25AM +0100, Matteo Franchin wrote:
> > Add ABGR format with 10-bit components packed in 64-bit per pixel.
> > This format can be used to handle
> > VK_FORMAT_R10X6G10X6B10X6A10X6_UNORM_4PACK16 on little-endian
> > architectures.
> > 
> > Signed-off-by: Matteo Franchin <matteo.franchin@arm.com>
> > ---
> >  drivers/gpu/drm/drm_fourcc.c  | 1 +
> >  include/uapi/drm/drm_fourcc.h | 7 +++++++
> >  2 files changed, 8 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/drm_fourcc.c b/drivers/gpu/drm/drm_fourcc.c
> > index 722c7ebe4e88..bba03fcb016d 100644
> > --- a/drivers/gpu/drm/drm_fourcc.c
> > +++ b/drivers/gpu/drm/drm_fourcc.c
> > @@ -202,6 +202,7 @@ const struct drm_format_info *__drm_format_info(u32 format)
> >  		{ .format = DRM_FORMAT_XBGR16161616F,	.depth = 0,  .num_planes = 1, .cpp = { 8, 0, 0 }, .hsub = 1, .vsub = 1 },
> >  		{ .format = DRM_FORMAT_ARGB16161616F,	.depth = 0,  .num_planes = 1, .cpp = { 8, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
> >  		{ .format = DRM_FORMAT_ABGR16161616F,	.depth = 0,  .num_planes = 1, .cpp = { 8, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
> > +		{ .format = DRM_FORMAT_AXBXGXRX106106106106,	.depth = 0,  .num_planes = 1, .cpp = { 8, 0, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
> >  		{ .format = DRM_FORMAT_RGB888_A8,	.depth = 32, .num_planes = 2, .cpp = { 3, 1, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
> >  		{ .format = DRM_FORMAT_BGR888_A8,	.depth = 32, .num_planes = 2, .cpp = { 3, 1, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
> >  		{ .format = DRM_FORMAT_XRGB8888_A8,	.depth = 32, .num_planes = 2, .cpp = { 4, 1, 0 }, .hsub = 1, .vsub = 1, .has_alpha = true },
> > diff --git a/include/uapi/drm/drm_fourcc.h b/include/uapi/drm/drm_fourcc.h
> > index 82f327801267..76eedba52b77 100644
> > --- a/include/uapi/drm/drm_fourcc.h
> > +++ b/include/uapi/drm/drm_fourcc.h
> > @@ -155,6 +155,13 @@ extern "C" {
> >  #define DRM_FORMAT_ARGB16161616F fourcc_code('A', 'R', '4', 'H') /* [63:0] A:R:G:B 16:16:16:16 little endian */
> >  #define DRM_FORMAT_ABGR16161616F fourcc_code('A', 'B', '4', 'H') /* [63:0] A:B:G:R 16:16:16:16 little endian */
> >  
> > +/*
> > + * RGBA format with 10-bit components packed in 64-bit per pixel, with 6 bits
> > + * of unused padding per component:
> > + * [63:0] A:x:B:x:G:x:R:x 10:6:10:6:10:6:10:6 little endian
> 
> I think we usually put that last bit at the end of the fourcc define.
> In theory it makes grepping a bit nicer. The exceptions are all planar
> formats where each plane can have different component packing.

Makes sense, I'll change the patch as suggested.

Thanks,
Matteo

> 
> > + */
> > +#define DRM_FORMAT_AXBXGXRX106106106106 fourcc_code('A', 'B', '1', '0')
> > +
> >  /* packed YCbCr */
> >  #define DRM_FORMAT_YUYV		fourcc_code('Y', 'U', 'Y', 'V') /* [31:0] Cr0:Y1:Cb0:Y0 8:8:8:8 little endian */
> >  #define DRM_FORMAT_YVYU		fourcc_code('Y', 'V', 'Y', 'U') /* [31:0] Cb0:Y1:Cr0:Y0 8:8:8:8 little endian */
> > -- 
> > 2.17.1
> > 
> > _______________________________________________
> > dri-devel mailing list
> > dri-devel@lists.freedesktop.org
> > https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
> -- 
> Ville Syrj�l�
> Intel
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
